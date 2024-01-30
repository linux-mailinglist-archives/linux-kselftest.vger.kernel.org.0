Return-Path: <linux-kselftest+bounces-3741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43832841CEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 08:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686A71C23A37
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914A53805;
	Tue, 30 Jan 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="STUbqRyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804753E07;
	Tue, 30 Jan 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600921; cv=none; b=sDsH4XPU1VIX5T2C73Q8afH28cUuZu/gRJoKJLxKr4Xq9pdo6lHdF95skdeNOx0pZx9TwgyTejRrrIZJh2vG4JR9jH7HzNn5xqO3Me2+pzV42RTxf+vZ0AQ+i2O83xz0F8KhizhtPDz+CEw+TbAhZJIIwfRgCUYLtNsFemFMVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600921; c=relaxed/simple;
	bh=fAUfUG9L4OPjwP8nXsyDo7NvEYVxO4MXF8LFC9SkkaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcS+tes8vcHsXaOdDnT0THNbZouMrdCcZpA14GTPSMdbnM5PrFEmUnLAj9w3vc59uZEOWxT4fgtjBmXegfBAnz8709ZXnDw7a9yfkTAnRCIMUDPr3EqwBNM2kPB9ucsj2MVPGaOL9Dsz3zVJ8/cKSx/YTawet3aUu2qTneNKwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=STUbqRyx; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706600905; bh=fAUfUG9L4OPjwP8nXsyDo7NvEYVxO4MXF8LFC9SkkaI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=STUbqRyxYwU5lMugJ59BHtKnpuJB87h+PvGLc1FcWuB4JYNCWIygPzemk1ooDDqyY
	 /Nlu93h8L8bYdWq3FG4yjkfuc0BkSlUpMAWNn7g8PkgSreUDhe/9vaXoJ3S0fOBI8s
	 1nASbNjNoB2dzwaeI0cRpNTX8faMQGkKV+nCXDc0=
Received: from [127.0.0.1] ([240e:379:2245:2000:e9ce:4171:6217:836b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id A918EA0B; Tue, 30 Jan 2024 15:42:17 +0800
X-QQ-mid: xmsmtpt1706600537t67bwsgl5
Message-ID: <tencent_3B64210B8DDF7C048223DA638EF8B8673108@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTpkPwgZxrJfyAica3qlAnRBmAAVdUxKzcJLV2MecuHBHwBjcVLnv
	 2MXcpPyqsKD2ZL6QLhRh2eZ7hl43gK18XGkC5ndhaNz402ero8zKzgka5jllKqeSR3M16rPrf33X
	 mw7wPcCYxbKtl5B6uX2FKlm1Yn9/RPZfkWzHvS5d/3skcdhs/b9utJkzg4MWxBu63qqZxS2mu1dP
	 UD2XBqct6r7dUrWeOKTGJkIA5ek3g+Fgb4t2J/BKBTMSnENbXkOhvm4FN5M2pBFV3CKC0AwGJUP8
	 vj3vw08XvJPS/szXCE0ZqeDxCkfIeszThuGmZEhrnghS7TgA997+/RNqQX8MgINjPOCFXOvtb3pu
	 dUapj1FxiBvOMPV0niztePsqA39skJcy3h/I6UgXxQUDkNqankG9xzSaZKjmT4NGobANvvAd+dDT
	 uCHDiFHDJpcHV19dYOeUN2o4tXx9Wgp+WEfIJ9PZvZryy1QWTdyPcD/wLPZBRp1WrLSowm9qV0r6
	 2fOnHMnZKubmewJuEnjsfVVTxMNyLVqmYu4rqIH+d+5PdHUX25/lnOLtcIdwXgzOwwOB5AkmEE2E
	 05kVj2z9plKkzHd+R15RFePMy+fhqoWhuY6I6yF1654JOyhVz3jnglz5VEvKkvTl2OH+bjmtxmM8
	 7fwVtn/ZrsZdnpMGDbxMKAD5JstMzCkiwdPIkR/+Vh/tWTOVjRjw0IejOpA+DzNVPXwHsLbVft4D
	 nBxmfCugFbfM8p2/QfVypqOk5avAHCpMCtxKk7L6NyK1XH5XoQGwrxAut+OLk6e3P4tDEoEl1ciT
	 jgTOPwxZxNuB/D+FGj7xf7f42MNdhj/KhWEyymGcFLrAxy8aSuz2jOl9N4RZKEVaz9rmY5AKJ+5h
	 3fWjNNH7Hhk3LQrFomUEsrrlnscI4ujFsCMXIVQUBg8EzfCAlzVdfVNl7CMkzwOi2PMi3VlVbq+K
	 3A1sbWGeTD3pKa/A1Eivr3PKukejS001jwBJsF6h/UOK/rUwuYVT0/AGVX321L
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <f42c1bc8b986de3ec63ac740e87be128b385b115.camel@cyyself.name>
Subject: Re: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
From: Yangyu Chen <cyy@cyyself.name>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org
Date: Tue, 30 Jan 2024 15:42:17 +0800
In-Reply-To: <ZbhkAUf+h7sK71Rs@ghost>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
	 <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
	 <tencent_F34C3BC7F1077728A62E84A7D183EF5BF005@qq.com>
	 <ZbhkAUf+h7sK71Rs@ghost>
Autocrypt: addr=cyy@cyyself.name; prefer-encrypt=mutual;
 keydata=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
	0mslfht1JyMf5dUi38RQI/fOO0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 18:50 -0800, Charlie Jenkins wrote:
> On Tue, Jan 30, 2024 at 10:34:03AM +0800, Yangyu Chen wrote:
> >=20
> > > On Jan 30, 2024, at 08:37, Charlie Jenkins <charlie@rivosinc.com>
> > > wrote:
> > >=20
> > > On riscv it is guaranteed that the address returned by mmap is
> > > less than
> > > the hint address. Allow mmap to return an address all the way up
> > > to
> > > addr, if provided, rather than just up to the lower address
> > > space.
> > >=20
> > > This provides a performance benefit as well, allowing mmap to
> > > exit after
> > > checking that the address is in range rather than searching for a
> > > valid
> > > address.
> > >=20
> > > It is possible to provide an address that uses at most the same
> > > number
> > > of bits, however it is significantly more computationally
> > > expensive to
> > > provide that number rather than setting the max to be the hint
> > > address.
> > > There is the instruction clz/clzw in Zbb that returns the highest
> > > set bit
> > > which could be used to performantly implement this, but it would
> > > still
> > > be slower than the current implementation. At worst case, half of
> > > the
> > > address would not be able to be allocated when a hint address is
> > > provided.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > arch/riscv/include/asm/processor.h | 21 ++++++++-------------
> > > 1 file changed, 8 insertions(+), 13 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/include/asm/processor.h
> > > b/arch/riscv/include/asm/processor.h
> > > index f19f861cda54..f3ea5166e3b2 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -22,14 +22,11 @@
> > > ({ \
> > > unsigned long mmap_end; \
> > > typeof(addr) _addr =3D (addr); \
> > > - if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > is_compat_task())) \
> > > - mmap_end =3D STACK_TOP_MAX; \
> > > - else if ((_addr) >=3D VA_USER_SV57) \
> > > - mmap_end =3D STACK_TOP_MAX; \
> > > - else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D
> > > VA_BITS_SV48)) \
> > > - mmap_end =3D VA_USER_SV48; \
> > > + if ((_addr) =3D=3D 0 || \
> > > + (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) || \
> > > + ((_addr + len) > BIT(VA_BITS - 1))) \
> >=20
> > How about replacing BIT(VA_BITS-1) to DEFAULT_MAP_WINDOW to make
> > the code
> > more general.
> >=20
> > > else \
> > > - mmap_end =3D VA_USER_SV39; \
> > > + mmap_end =3D (_addr + len); \
> > > mmap_end; \
> > > })
> > >=20
> > > @@ -39,14 +36,12 @@
> > > typeof(addr) _addr =3D (addr); \
> > > typeof(base) _base =3D (base); \
> > > unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base); \
> > > - if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > is_compat_task())) \
> > > + if ((_addr) =3D=3D 0 || \
> > > +=C2=A0=C2=A0=C2=A0 (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) |=
| \
> > > +=C2=A0=C2=A0=C2=A0 ((_addr + len) > BIT(VA_BITS - 1))) \
> >=20
> > Same here.
> >=20
> > > mmap_base =3D (_base); \
> > > - else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D
> > > VA_BITS_SV57)) \
> > > - mmap_base =3D VA_USER_SV57 - rnd_gap; \
> > > - else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D
> > > VA_BITS_SV48)) \
> > > - mmap_base =3D VA_USER_SV48 - rnd_gap; \
> > > else \
> > > - mmap_base =3D VA_USER_SV39 - rnd_gap; \
> > > + mmap_base =3D (_addr + len) - rnd_gap; \
> > > mmap_base; \
> > > })
> > >=20
> > >=20
> >=20
> > What about not setting the upper bound as x86/arm/powerpc as [1]
> > did?
> > In this case, user space can directly pass a constant hint address
> > >
> > BIT(47) to get a mapping in sv57. If you want this, this code also
> > allows
> > user-space to pass any address larger than TASK_SIZE. You should
> > also
> > limit the mmap_base to (base) + TASK_SIZE - DEFAULT_MAP_WINDOW.
>=20
> No. This suggestion causes a random address to be used if the hint
> address is not available. That is why I didn't simply go with your
> patch.


I think return random address is expected and other ISAs like
x86/arm/powerpc will also return random address if hint is NULL.

Also add CC linux-mm to get more opinions from people who familiar with
mm.

>=20
> This patch both gives your application the benefit of being able to
> use
> a hint address in the hopes that the address is available, as well as
> continuing to support the guarantee that an address using more bits
> than
> the hint address is not returned.
>=20
> - Charlie
>=20
> >=20
> > I=E2=80=99m also aware of the rnd_gap if it is not 0, then we will not =
get
> > address mapped to VA_USER_SV39 - rnd_gap.
> >=20
> > [1].
> > https://lore.kernel.org/linux-riscv/tencent_2683632BEE438C6D4854E30BDF9=
CA0843606@qq.com/
> >=20
> > > --=20
> > > 2.43.0
> > >=20
> >=20


