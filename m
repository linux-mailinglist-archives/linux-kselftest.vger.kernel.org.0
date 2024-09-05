Return-Path: <linux-kselftest+bounces-17302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA90B96E0F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E88B23E04
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9A13DDDF;
	Thu,  5 Sep 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XsUmZi5H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0371522F;
	Thu,  5 Sep 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556528; cv=none; b=Pf8jPgDatfRzmCtQqzsARbdBUQ9o/Fv9dRFQBE1E5ctoL/BlqdUYf8mGXtZtwscaM7AvUoDXvKR266GUZkFJEgIis1Y8tmIFrDniutlxxBMAeC3r+wK51xxIkXgWLEXOTeJKoBzrxBvwOtBpVkeXv6BufILwqF+gn8/pZ88Q59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556528; c=relaxed/simple;
	bh=b3J0zmDqUTroBSZmui7RtRtrLz5VtHqzff2jtxVhDnk=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=XeWnUjWIK9U/Iv+OeQwuoTfhxE3GLLWQ4N75STEy6y3KS5z1eV8tfLFIfm37RPAO5FBYauQQHSSDoxdxfHvISUNQVku6VR0DKhVn1OVTspr9/CWozGKiREJo0n9Iv4fXxUgJWGBZUFYBmNm35MlizANDwq63O1kd3n3ePi5u7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XsUmZi5H; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725556518; bh=IdmLzzE4Y30s9YeYCM0UVuwavqz/aTp5LLdmTh4K8f0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=XsUmZi5HPqQjER2B98kOFc2PPfFs8IGDZYwGuoonrTzf9KFuX8IJjXUIxr8wTFikf
	 5f366F/4LO6GWGn1TbgtVF+juAFuzy1Mg+1iDo7z9qu1SxNdiVwQ+tP2PccyjRCqaI
	 oxL4xwV5gzqX76ew2bykD20WrZw/Pf7UWpCQla2M=
Received: from smtpclient.apple ([2001:da8:c800:d084:a0ed:5d47:36ee:f762])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 3CF3FE5C; Fri, 06 Sep 2024 01:15:15 +0800
X-QQ-mid: xmsmtpt1725556515tl5azvo8d
Message-ID: <tencent_B49BC6F11F5737662664B35196CF50904805@qq.com>
X-QQ-XMAILINFO: ODdZrkDuTlAgtf9EojIpmtCpfUBNWoLW0j3WAfyUMzA3bmwJ7yeQCYEc7UNFBn
	 dgh4i/ubTQJldg/Ixe82HlksCUKuP6ZB9TbSRJBKn41i3yBB2sRE7UvmO3YIC1QadIh8rIj/U8Ob
	 xH7bwli6OntCsqeLXERo7Y0XmcVZVpp1clpxOMdhqTinb81fAts36L1vK8A+E7h2Mf5Hldqx5cw1
	 Yh1mPCbyW5t+OXe9JQuZiQHaBL5Tgi+M8fqLuqsqpn2IOD6+uiIq3lfhyh4XjmrrH7DdlZ6Jzkib
	 kVJz16UBYU8LzQHK1p4nAPJrBTi7vHY4UZNzZ/5grKw7LomY+65wIzlpDI+bKGJqB9A6tjY/U24G
	 QkI6/AcMcoh1NoUKktLykS5V1O7JTc72+tHKbZhrP2UpPXaWITkdAhdVW1HGgAG+kXTlZpcvLh/Y
	 8cpdW+BsQI0yAsgApBmRlPDdPDE/ZrbPs8dicFV9WM8cZwe9x48K/ZBKXKCTqVxqnOiKqXEyz72l
	 ZCEhLxim4Nn/TV4mxzfNuiu+Da5NUfHJ3+w2yPm9qk1A0127lY/g/Pk0kL08DiDn5mQz8jdY4tdl
	 8bs9yiNxXxzyqzwRNBOts1bSTKhyPoDOSDVpGRR0It1732B7jTZvZ2ZxB1/b9c4pMZfX7vuXSQNw
	 2UuHfqJH6fhYR7CUn72aJtd8RIZR+2YbwsI8lZvt2dvJrJ8nuuBMZgHjqN+0CmzCFrkTU1irKZNm
	 2Meayw7xkV0dXhvVEmvLrzv375PBa8l7NAjRa9C0wnDMGPMWduh8lpGneRF0E3V/nNOj6vCaALJk
	 B8AEFCvseA/R67BkrBlCzy7HjhoKhEzOzq2YodvvCsYqH6lgwH2nzVcn5Zkr2R5wXd2D71Zlq/yF
	 ow3eN1KFSzysK54VOaYlROVEN801XV85jm9ownawFqEtQ1NDGDvayh16w3Ot3KgCCu8Y8Wy4ZdBv
	 qxg4sXU4K+3FSYX4TYO/9OJF01ZzV4O6nmyo/XVJzdPzuwYjBm9/mYtXGswYJ1suUI3Ztp28A=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 3/3] riscv: mm: Do not restrict mmap address based on hint
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <mhng-ad0c8c3b-568a-484d-bc3d-49b56a11dcd6@palmer-ri-x1c9>
Date: Fri, 6 Sep 2024 01:15:04 +0800
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>,
 Levi Zim <rsworktech@outlook.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <AFED66DE-BE37-467B-A7FD-BF6D530CE0D3@cyyself.name>
References: <mhng-ad0c8c3b-568a-484d-bc3d-49b56a11dcd6@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On Sep 3, 2024, at 22:27, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>=20
> On Mon, 26 Aug 2024 19:24:38 PDT (-0700), cyy@cyyself.name wrote:
>>=20
>>=20
>>> On Aug 27, 2024, at 00:36, Charlie Jenkins <charlie@rivosinc.com> =
wrote:
>>> The hint address should not forcefully restrict the addresses =
returned
>>> by mmap as this causes mmap to report ENOMEM when there is memory =
still
>>> available.
>>=20
>> Fixing in this way will break userspace on Sv57 machines as some
>> issues mentioned in the patch [1].
>>=20
>> I suggest restricting to BIT(47) by default, like patch [2], to
>> align with kernel behavior on x86 and aarch64, and this does exist
>> on x86 and aarch64 for quite a long time. In that way, we will also
>> solve the problem mentioned in the first patch [1], as QEMU enables
>> Sv57 by default now and will not break userspace.
>>=20
>> [1] =
https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosi=
nc.com/
>> [2] =
https://lore.kernel.org/linux-riscv/tencent_B2D0435BC011135736262764B51199=
4F4805@qq.com/
>=20
> I'm going to pick this up as it's a revert and a bug fix, so we can =
backport it.  If the right answer is to just forget about the sv39 =
userspace and only worry about sv48 userspace then your patches are =
likely the way to go,

I think we don't need to care about restricting to sv39 now since
the ASAN bug has been fixed. We should care about what to do to not
break userspace on sv57 machines as QEMU enables sv57 by default,
which is widely used.

> but there's a handful of discussions around that which might take a =
bit.
>=20
>>=20
>> Thanks,
>> Yangyu Chen
>>=20
>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>> Fixes: b5b4287accd7 ("riscv: mm: Use hint address in mmap if =
available")
>>> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for =
sv39,sv48,sv57")
>>> Closes: =
https://lore.kernel.org/linux-kernel/ZbxTNjQPFKBatMq+@ghost/T/#mccb1890466=
bf5a488c9ce7441e57e42271895765
>>> ---
>>> arch/riscv/include/asm/processor.h | 26 ++------------------------
>>> 1 file changed, 2 insertions(+), 24 deletions(-)
>>> diff --git a/arch/riscv/include/asm/processor.h =
b/arch/riscv/include/asm/processor.h
>>> index 8702b8721a27..efa1b3519b23 100644
>>> --- a/arch/riscv/include/asm/processor.h
>>> +++ b/arch/riscv/include/asm/processor.h
>>> @@ -14,36 +14,14 @@
>>> #include <asm/ptrace.h>
>>> -/*
>>> - * addr is a hint to the maximum userspace address that mmap should =
provide, so
>>> - * this macro needs to return the largest address space available =
so that
>>> - * mmap_end < addr, being mmap_end the top of that address space.
>>> - * See Documentation/arch/riscv/vm-layout.rst for more details.
>>> - */
>>> #define arch_get_mmap_end(addr, len, flags) \
>>> ({ \
>>> - unsigned long mmap_end; \
>>> - typeof(addr) _addr =3D (addr); \
>>> - if ((_addr) =3D=3D 0 || is_compat_task() || \
>>> -    ((_addr + len) > BIT(VA_BITS - 1))) \
>>> - mmap_end =3D STACK_TOP_MAX; \
>>> - else \
>>> - mmap_end =3D (_addr + len); \
>>> - mmap_end; \
>>> + STACK_TOP_MAX; \
>>> })
>>> #define arch_get_mmap_base(addr, base) \
>>> ({ \
>>> - unsigned long mmap_base; \
>>> - typeof(addr) _addr =3D (addr); \
>>> - typeof(base) _base =3D (base); \
>>> - unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base); \
>>> - if ((_addr) =3D=3D 0 || is_compat_task() || \
>>> -    ((_addr + len) > BIT(VA_BITS - 1))) \
>>> - mmap_base =3D (_base); \
>>> - else \
>>> - mmap_base =3D (_addr + len) - rnd_gap; \
>>> - mmap_base; \
>>> + base; \
>>> })
>>> #ifdef CONFIG_64BIT
>>> --=20
>>> 2.45.0


