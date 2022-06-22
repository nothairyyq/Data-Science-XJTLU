#ifndef BMI_H
#define BMI_H

#include <string>
using namespace std;

class BMI
{
public:
  BMI(const string& newName, int newAge, 
    double newWeight, double newHeight);
  BMI(const string& newName, double newWeight, double newHeight);
  double getBMI() const;
  string getStatus() const;
  string getName() const;
  int getAge() const;
  double getWeight() const;
  double getHeight() const;

private:
  string name;
  int age;
  double weight;
  double height;
};

#endif