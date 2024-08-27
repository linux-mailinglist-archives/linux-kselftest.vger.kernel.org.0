Return-Path: <linux-kselftest+bounces-16352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4571995FF11
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 04:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86D9B21AAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2A14A8B;
	Tue, 27 Aug 2024 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a+cpME+9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF46EAF1;
	Tue, 27 Aug 2024 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725693; cv=none; b=ZMxoNZn8m9ezOy5Gys0GxSW4ExoY9h8Vbzo311EXLSE5nSXQ5wovB3RJoLVqNJeYZr46Oop7GwkfBxRwonmKdZn/g0hKfH5XnsS4r3NJABWrPNxLD3X1W+RT5TM4aq7/8V2QDdC2TqMn/UH6Tlz4x4PBrjkeCUgXJVF++rc22bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725693; c=relaxed/simple;
	bh=Rex+v/gRjv7leIkVQjbIzLC9Eoh8KVP6y99gGD7O1VM=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=Bo5YzJCSLkqi2RkJ7UT0CZfSBY9xvqrAnwnovbjBVUEHGRhd28+fhBKYlKdZSBn8RbMm1zf20Rf9lzTNNQRF+q/+Bvg26lFtz8hOkAcml3PiGnq68PYDe95SbeZOWb0azhBy3HFx6fncUZ45AmeAnrmousus6LYv2xdw7SRKVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a+cpME+9; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724725685; bh=6OUVBGQm+R7uNiXYq6N251s4vbehYFjQAwiXtpU9mUU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=a+cpME+9Vk5/xWBfvZfkEO1zc2xqcYEQfwTHTNDjp+dHPC2VFZmKpz1AEHE8M7qT3
	 Yyc57EKoRkIQoW0qvbKmWktftmfbIJseAJ6H8sGVooxcp4IK+ROoJm6p9uA0FbhpYD
	 hqseTAqmHAzr049fGWjDgNdkCu9Z9RVnRPdzd44w=
Received: from smtpclient.apple ([2408:8207:18a0:211f:25e9:f22a:88fc:3aa2])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 62AB22D1; Tue, 27 Aug 2024 10:24:42 +0800
X-QQ-mid: xmsmtpt1724725482tyapdnd0p
Message-ID: <tencent_A414DA7D8E69B831317A21368D057C378208@qq.com>
X-QQ-XMAILINFO: MziGzrjZeogZJQ6VsuNCfMEWmzxEuNlCz4qLlbmWD8GXK82Tlhv024UTyHMuIW
	 ZtLBG68GVeE2jivNbSpoKPduTbKnA+QTcfUHwOZl2QERMeWJ6DciXxTfMgN87P4/tt7wNODCLr/i
	 6CgpqzkgKxF9mRHFf9HMTr7+G3qhcMGCTcN+vO9GEHdhaSHYu175P9c/sTybxbQBV1UR2KfEGRg9
	 z+JILA8bxwqIn6bqshESR1mhoJslaizNhds1dwS+WHN+bKVhgr5LmJkOc8ujMu2TnjLE3/DlK7/a
	 dgn11Cpc8JBwRMLLdEfA8jO+Ni8ZXWUQamEgh5MQNDRrXL4PZSjKnA+WDKTiQG8OwqjD0nUKgAM3
	 u2twQqRrjT623mTZypNeVgzrrnzJ2pV9hZhT3Tb+wrl/ht1Pae7pkK3vFOoqNc65+oMnR5V9IUyv
	 2H2UuHGUSFYN8RM6/9d0x3AxBFG+BD+b9eERHZATAnBWC95ib6NXMkBbJ6SQ05KyGSP0kQusTHrc
	 XaP+n002mFehPmr3ObtoHI7j2YLCNa5JTH5ICle0Zb/z2GfrhvkvpZ1C9e7VngM70n4HGtZxdLL3
	 Mys36Um1BmZklMItTEgend+zP/c4Y9/HN758EdpnRw/vV0CW+N746A87dl64wMa8vgl+Ua0sxthN
	 +u1qxQtSJzW/bDEMQzC5w3YxfDdiQK09aYT1F5k9CufRYKuL11RtXdEew7e5dQxGwGKPWQKhHriL
	 SyUAFwWgGoRoPliMkbSTRcLIRTN6a1j+v1fOeIb8HFtfbQafKsqOHkJZ0LdsJozsP+PORMRaXzT7
	 fSepXLJPn9LRMvi6MhyJ4LCXaa2afmBKKeRDAACZ3/1NtFyId5YksShgvRMNyEqlyMlxEgrCtZyN
	 1Ck2VZYyp6HeqKmXKmSVLghYnSh00JCXj7F4BvEWDqbUzaPQi0AzktLd63NDtrvMqhceWreCudxn
	 2n8l8UuXinL3n6S/Hln/mMrRcibbXWIMaU8iK5hYaSdxEruZvqAeITlTElmhSw4Yps++wtc8E=
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
In-Reply-To: <20240826-riscv_mmap-v1-3-cd8962afe47f@rivosinc.com>
Date: Tue, 27 Aug 2024 10:24:38 +0800
Cc: Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>,
 Levi Zim <rsworktech@outlook.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <C5CD5C41-B9C2-42E0-BAC4-AD8A6FE52447@cyyself.name>
References: <20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com>
 <20240826-riscv_mmap-v1-3-cd8962afe47f@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On Aug 27, 2024, at 00:36, Charlie Jenkins <charlie@rivosinc.com> =
wrote:
>=20
> The hint address should not forcefully restrict the addresses returned
> by mmap as this causes mmap to report ENOMEM when there is memory =
still
> available.
>=20

Fixing in this way will break userspace on Sv57 machines as some
issues mentioned in the patch [1].

I suggest restricting to BIT(47) by default, like patch [2], to
align with kernel behavior on x86 and aarch64, and this does exist
on x86 and aarch64 for quite a long time. In that way, we will also
solve the problem mentioned in the first patch [1], as QEMU enables
Sv57 by default now and will not break userspace.

[1] =
https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosi=
nc.com/
[2] =
https://lore.kernel.org/linux-riscv/tencent_B2D0435BC011135736262764B51199=
4F4805@qq.com/

Thanks,
Yangyu Chen

> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: b5b4287accd7 ("riscv: mm: Use hint address in mmap if =
available")
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for =
sv39,sv48,sv57")
> Closes: =
https://lore.kernel.org/linux-kernel/ZbxTNjQPFKBatMq+@ghost/T/#mccb1890466=
bf5a488c9ce7441e57e42271895765
> ---
> arch/riscv/include/asm/processor.h | 26 ++------------------------
> 1 file changed, 2 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/processor.h =
b/arch/riscv/include/asm/processor.h
> index 8702b8721a27..efa1b3519b23 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -14,36 +14,14 @@
>=20
> #include <asm/ptrace.h>
>=20
> -/*
> - * addr is a hint to the maximum userspace address that mmap should =
provide, so
> - * this macro needs to return the largest address space available so =
that
> - * mmap_end < addr, being mmap_end the top of that address space.
> - * See Documentation/arch/riscv/vm-layout.rst for more details.
> - */
> #define arch_get_mmap_end(addr, len, flags) \
> ({ \
> - unsigned long mmap_end; \
> - typeof(addr) _addr =3D (addr); \
> - if ((_addr) =3D=3D 0 || is_compat_task() || \
> -    ((_addr + len) > BIT(VA_BITS - 1))) \
> - mmap_end =3D STACK_TOP_MAX; \
> - else \
> - mmap_end =3D (_addr + len); \
> - mmap_end; \
> + STACK_TOP_MAX; \
> })
>=20
> #define arch_get_mmap_base(addr, base) \
> ({ \
> - unsigned long mmap_base; \
> - typeof(addr) _addr =3D (addr); \
> - typeof(base) _base =3D (base); \
> - unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base); \
> - if ((_addr) =3D=3D 0 || is_compat_task() || \
> -    ((_addr + len) > BIT(VA_BITS - 1))) \
> - mmap_base =3D (_base); \
> - else \
> - mmap_base =3D (_addr + len) - rnd_gap; \
> - mmap_base; \
> + base; \
> })
>=20
> #ifdef CONFIG_64BIT
>=20
> --=20
> 2.45.0
>=20


