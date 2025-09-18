from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy import String, Integer, ForeignKey
from sqlalchemy.orm import relationship

class Base(DeclarativeBase): pass

class Rental(Base):
  __tablename__ = "rentals"
  id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
  city: Mapped[str] = mapped_column(String(64), index=True)
  price: Mapped[int] = mapped_column(Integer, index=True)

class User(Base):
  __tablename__ = "users"
  id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
  email: Mapped[int] = mapped_column(String(120), unique=True, index=True)

