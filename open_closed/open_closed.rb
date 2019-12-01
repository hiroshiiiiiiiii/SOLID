class MovieProductionCompany
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def salary
    monthly_salary * 12
  end

  def display_detail_profile
    raise '定義忘れだよーん'
  end

  def data
    puts "職種: #{self.class}"
    puts "区分: #{kubun}"
    puts "氏名: #{name}"
    puts "年齢: #{age}"
    display_detail_profile
    puts salary_text
    puts '------------------------------'
  end
end

class Outsourcing < MovieProductionCompany
  def kubun
    '外部委託'
  end

  def salary_text
    "依頼単価: #{salary}万円"
  end
end

class InHouse < MovieProductionCompany
  def kubun
    '自社'
  end

  def salary_text
    "給与: #{salary}万円"
  end
end

class AcousticDirector < InHouse; end
class Writer < Outsourcing; end
class Cinematographer < InHouse; end

module SameExpertizeSelecter
  EXPERTIZE_NAMES = {
   AcousticDirector => '音響監督',
   Writer => '脚本家',
   Cinematographer => '撮影監督'
  }

  def same_expertize(*klasses)
    stakeholders = get_related_people
    text = []

    stakeholders.each do |stakeholder|
      klasses.each do |klass|
        if stakeholder.is_a?(klass)
          text << "相性の良い" + EXPERTIZE_NAMES[klass] + ": #{stakeholder.name}"
        end
      end
    end

    text
  end

  def get_related_people
    STAKEHOLDERS.select do |stakeholder|
      next if stakeholder.is_a?(ExecutiveProducer) || stakeholder.is_a?(Sales) || stakeholder.name == name
      stakeholder.genre == genre
    end
  end
end

class ExecutiveProducer < InHouse
  attr_reader :monthly_salary, :production_count, :hit_count
  def initialize(name, age, monthly_salary, production_count, hit_count)
    super(name, age)
    @monthly_salary = monthly_salary
    @production_count = production_count
    @hit_count = hit_count
  end

  def rank
    if production_count == hit_count
      'エース監督'
    elsif production_count > hit_count
      'それなりの監督'
    end
  end

  def display_detail_profile
    puts "監督ランク: #{rank}"
  end
end

class AcousticDirector < InHouse
  include SameExpertizeSelecter

  attr_reader :monthly_salary, :genre
  def initialize(name, age, monthly_salary, genre)
    super(name, age)
    @monthly_salary = monthly_salary
    @genre = genre
  end

  def display_detail_profile
    puts "得意ジャンル: #{genre}"
    puts same_expertize(Cinematographer, Writer)
  end
end

class Cinematographer < InHouse
  include SameExpertizeSelecter

  attr_reader :monthly_salary, :genre
  def initialize(name, age, monthly_salary, genre)
    super(name, age)
    @monthly_salary = monthly_salary
    @genre = genre
  end

  def display_detail_profile
    puts "得意分野: #{genre}"
    puts same_expertize(AcousticDirector, Writer)
  end
end

class Writer < Outsourcing
  include SameExpertizeSelecter

  attr_reader :unit_price, :genre
  def initialize(name, age, unit_price, genre)
    super(name, age)
    @unit_price = unit_price
    @genre = genre
  end

  def salary
    unit_price
  end

  def display_detail_profile
    puts "得意ジャンル: #{genre}"
    puts same_expertize(AcousticDirector, Cinematographer)
  end
end

class Sales < Outsourcing
  attr_reader :unit_price, :genre
  def initialize(name, age, unit_price)
    super(name, age)
    @unit_price = unit_price
  end

  def salary
    unit_price
  end

  def display_detail_profile; end
end

# 関係者データ
STAKEHOLDERS = [
  ExecutiveProducer.new('田中太郎', 60, 60, 10, 10),
  ExecutiveProducer.new('佐藤三郎', 40, 40, 5, 1),
  AcousticDirector.new('磯崎亮介', 38, 45, 'アクション'),
  AcousticDirector.new('橘りつ子', 55, 50, 'サスペンス'),
  Cinematographer.new('朝倉大地', 29, 30, 'サスペンス'),
  Cinematographer.new('ぷにすけ', 22, 25, 'アクション'),
  Writer.new('鈴木ゆかり', 40, 300,  'アクション'),
  Writer.new('高杉望', 37, 250,  'サスペンス'),
  Sales.new('上野香織', 40, 80)
].freeze

STAKEHOLDERS.each(&:data)