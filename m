Return-Path: <linux-kselftest+bounces-3856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC9284438A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 16:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F4C1F22C98
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB412A154;
	Wed, 31 Jan 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L35fe0p2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BB12A15A;
	Wed, 31 Jan 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716792; cv=none; b=oxVpAG90zlQqo4S0zXvIZ7XSrUfUYq9ey8w0qNFiQYriwP24XVsYj+BA6KR+S0bPldQSY6CCxrMEJctAYB6KakWhrVc/4QKguY/vwM4uiJS9RNsxvfhdnZTbnzhz/0+QABUwtijKDZ1nWl19p5cz3ToqqoRsQrmC3ZP6TUTkTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716792; c=relaxed/simple;
	bh=9FHeNdla+jIOOK2A7eSE1AfIOgvA+iOX0COwE66UVmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LlyUGRl8OUGb3k8YI31T1dJcL1tTJf/jww2EZqusKVKMTRYLOsxrmoEPJU6DDT5GnS4vQ6Tsqmn5ugsfwFIZc2ZJqUG4KqttprcCSt4Nz5KJgvKt/ffcmGyFc0p5sAp/sn5r+SP3B5xZPmhpVPH8RxiQVbWXhHnV/5WCyvmfJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L35fe0p2; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706716786; bh=N7Wf1cp0fO57Z9uDiMvCuo//pFaOGnfEQuJkfrl9Odo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L35fe0p2yqrIYc15QB6RUsa/NTKYpoFHLDCTUcfquHIlmgUCXjX3OScglrrtvZY7j
	 +6Jgw4nJJT7gG+X5n2CiqU4WJWbOwUoFTVnHarGALi8AKEbUZ553il9SGNNWNrovvf
	 XzSPm43EbUwgJDWsfo8/CrqI7ck80iD8vadP1840=
Received: from [127.0.0.1] ([240e:379:2245:2000:e9ce:4171:6217:836b])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id EEB9DCEF; Wed, 31 Jan 2024 23:59:43 +0800
X-QQ-mid: xmsmtpt1706716783t1k17n6nr
Message-ID: <tencent_068B3B7AE01AC67885E4369AF14109CE6A0A@qq.com>
X-QQ-XMAILINFO: OSwzSWs0onYP0SSh2k2Rfo1G0GlEZlxvjYKSVqlBi++K8IwPuekaD6GJRMsdEW
	 wncHhTMAXNfnj3f8dAEFCu5e+jSDlcxlgzEN7Hg1Sir8o/E/l3MP8tXbmb1lRjx/5ZzdL8nbpYDb
	 sgzWCXhLxTEBWTR65p5q5q1lAoe3cBFQQzFX9MHE/BIlDOU2OqKEpQgqB4lfoJx89oIRqJVrwdz9
	 XuOR3/Q//BHoM0VplG0+Dx/5w70QDofz5iglvPCGbxZsFjY4e+MPRNkbcS6+jeGlYuY4Nkbida+y
	 8Etf1g58JgzfTXdfNtpcoekxVyON/bQ/IoATIg8dwVbJ5jHBg747SFdSMRj14NQTyzqeCFOKHut8
	 CzKoOTZMmsx3b0TTfvI9sXUTOsnYcz8Y+s1plTx1qUwnnRrt9Y9kO5iYJIdPUnHzrRbLSpu2/7zp
	 2iHT0dale0BhAx/wcHjKq5zBSsDirvFbVI7USZS/7iSS3ojf+eml9tTkXMh9wzvwU95TAAy5ry9M
	 rS9qRgtd/CV7AmhKwvlVfEzYV4+uXyiB7AazXK28HFdyazblG+Ph5eK3oU7NpwxYKcm9oUJXRnoM
	 +92ATLQ9iSmqESB8qiAx5NEUc3Q7PID5TRBsFY6CSbVogcltLdlkJZxVrdoCQ8qHtjVezuAqM2wI
	 jBaEX6pznqdOTRdOLcwmagclBGilMvk7JfFq+hgJDy1FPlb7inh0thZaZtl7/hL/ppK2+VMb5INO
	 k+ZpnNXC5s7gyKgltO3ol8iBPDzEc3TG0hqgmQMfL8e/IXNp4wKiXu4r4owo6Bz5cKfLzCBStSeo
	 85Jcf6Rbsh2HDVMFddxScr6VOd4jJoP/QxpkfKqELYHBW8yY81I3eMUxOoRUhMtWqWFRpImoFxHN
	 C8lJgcIzeGL226kH111Ha4L1TVMwA5wXmLkX1i2HKk7ZPd1fKDDyu3yilEGbplvG+3/VSUde9oBQ
	 Egwc56rOmrTnVjqyVbEDaWjfy6rz56Mcub5NGph9GfktqC4MID5Y7MXfdK2vw1MKENoD2WWidznO
	 OfEBzMomYQMHS7zuyIE41bg8zZ2pme7YyzihBpEw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-OQ-MSGID: <c35f3079f1c2b949cf1e7c17908ade5f7c46169e.camel@cyyself.name>
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
From: Yangyu Chen <cyy@cyyself.name>
To: Charlie Jenkins <charlie@rivosinc.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Wed, 31 Jan 2024 23:59:43 +0800
In-Reply-To: <tencent_83E0AB36A9A3032E5A4C4AC864A311DF9406@qq.com>
References: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
	 <20240130-use_mmap_hint_address-v3-1-8a655cfa8bcb@rivosinc.com>
	 <tencent_83E0AB36A9A3032E5A4C4AC864A311DF9406@qq.com>
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

On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
> On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
> > On riscv it is guaranteed that the address returned by mmap is less
> > than
> > the hint address. Allow mmap to return an address all the way up to
> > addr, if provided, rather than just up to the lower address space.
> >=20
> > This provides a performance benefit as well, allowing mmap to exit
> > after
> > checking that the address is in range rather than searching for a
> > valid
> > address.
> >=20
> > It is possible to provide an address that uses at most the same
> > number
> > of bits, however it is significantly more computationally expensive
> > to
> > provide that number rather than setting the max to be the hint
> > address.
> > There is the instruction clz/clzw in Zbb that returns the highest
> > set
> > bit
> > which could be used to performantly implement this, but it would
> > still
> > be slower than the current implementation. At worst case, half of
> > the
> > address would not be able to be allocated when a hint address is
> > provided.
> >=20
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > =C2=A0arch/riscv/include/asm/processor.h | 27 +++++++++++--------------=
-
> > -
> > =C2=A01 file changed, 11 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/arch/riscv/include/asm/processor.h
> > b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..8ece7a8f0e18 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -14,22 +14,16 @@
> > =C2=A0
> > =C2=A0#include <asm/ptrace.h>
> > =C2=A0
> > -#ifdef CONFIG_64BIT
> > -#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > -#define STACK_TOP_MAX		TASK_SIZE_64
> > -
> > =C2=A0#define arch_get_mmap_end(addr, len, flags)			\
> > =C2=A0({								\
> > =C2=A0	unsigned long
> > mmap_end;					\
> > =C2=A0	typeof(addr) _addr =3D (addr);				\
> > -	if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > is_compat_task())) \
> > +	if ((_addr) =3D=3D 0 ||					\
> > +	=C2=A0=C2=A0=C2=A0 (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||=
	\
> > +	=C2=A0=C2=A0=C2=A0 ((_addr + len) > BIT(VA_BITS -
> > 1)))			\
> > =C2=A0		mmap_end =3D STACK_TOP_MAX;			\
> > -	else if ((_addr) >=3D VA_USER_SV57)			\
> > -		mmap_end =3D STACK_TOP_MAX;			\
> > -	else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D
> > VA_BITS_SV48)) \
> > -		mmap_end =3D VA_USER_SV48;			\
> > =C2=A0	else							\
> > -		mmap_end =3D VA_USER_SV39;			\
> > +		mmap_end =3D (_addr + len);			\
> > =C2=A0	mmap_end;						\
> > =C2=A0})
> > =C2=A0
> > @@ -39,17 +33,18 @@
> > =C2=A0	typeof(addr) _addr =3D (addr);				\
> > =C2=A0	typeof(base) _base =3D (base);				\
> > =C2=A0	unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base);	\
> > -	if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > is_compat_task())) \
> > +	if ((_addr) =3D=3D 0 ||					\
> > +	=C2=A0=C2=A0=C2=A0 (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||=
	\
> > +	=C2=A0=C2=A0=C2=A0 ((_addr + len) > BIT(VA_BITS -
> > 1)))			\
> > =C2=A0		mmap_base =3D (_base);				\
> > -	else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D
> > VA_BITS_SV57)) \
> > -		mmap_base =3D VA_USER_SV57 - rnd_gap;		\
> > -	else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D
> > VA_BITS_SV48)) \
> > -		mmap_base =3D VA_USER_SV48 - rnd_gap;		\
> > =C2=A0	else							\
> > -		mmap_base =3D VA_USER_SV39 - rnd_gap;		\
> > +		mmap_base =3D (_addr + len) - rnd_gap;		\
> > =C2=A0	mmap_base;						\
> > =C2=A0})
> > =C2=A0
> > +#ifdef CONFIG_64BIT
> > +#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > +#define STACK_TOP_MAX		TASK_SIZE_64
> > =C2=A0#else
> > =C2=A0#define DEFAULT_MAP_WINDOW	TASK_SIZE
> > =C2=A0#define STACK_TOP_MAX		TASK_SIZE
> >=20
>=20
> I have carefully tested your patch on qemu with sv57. A bug that
> needs
> to be solved is that mmap with the same hint address without
> MAP_FIXED
> set will fail the second time.
>=20
> Userspace code to reproduce the bug:
>=20
> #include <sys/mman.h>
> #include <stdio.h>
> #include <stdint.h>
>=20
> void test(char *addr) {
> =C2=A0=C2=A0=C2=A0 char *res =3D mmap(addr, 4096, PROT_READ | PROT_WRITE,
> MAP_ANONYMOUS
> > MAP_PRIVATE, -1, 0);
> =C2=A0=C2=A0=C2=A0 printf("hint %p got %p.\n", addr, res);
> }
>=20
> int main (void) {
> =C2=A0=C2=A0=C2=A0 test(1<<30);
> =C2=A0=C2=A0=C2=A0 test(1<<30);
> =C2=A0=C2=A0=C2=A0 test(1<<30);
> =C2=A0=C2=A0=C2=A0 return 0;
> }
>=20
> output:
>=20
> hint 0x40000000 got 0x40000000.
> hint 0x40000000 got 0xffffffffffffffff.
> hint 0x40000000 got 0xffffffffffffffff.
>=20
> output on x86:
>=20
> hint 0x40000000 got 0x40000000.
> hint 0x40000000 got 0x7f9171363000.
> hint 0x40000000 got 0x7f9171362000.
>=20
> It may need to implement a special arch_get_unmapped_area and
> arch_get_unmapped_area_topdown function.
>=20

This is because hint address < rnd_gap. I have tried to let mmap_base =3D
min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
does not work for bottom-up while ulimit -s is unlimited. You said this
behavior is expected from patch v2 review.=C2=A0However it brings a new
regression even on sv39 systems.

I still don't know the reason why use addr+len as the upper-bound. I
think solution like x86/arm64/powerpc provide two address space switch
based on whether hint address above the default map window is enough.


