Return-Path: <linux-kselftest+bounces-16455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE996166A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213C51C23029
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5201D4159;
	Tue, 27 Aug 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="e0kpik+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B741D2F56;
	Tue, 27 Aug 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781968; cv=none; b=m9C9sAwlOttVWiscGQDa4egOgh6DxxmgTLqmjw62YRBrjZzHKLJfEj4DYG8yJVJFz+nw0GBulLAq1LusbEq4JCCoyKQ0Q/1bcc6pyaOPYDaiqwP7UFs9AFqaCRmOQiCFFvfYpPhjqinQvP0xWLHIkKhbzSaZxhLFi6lSv+pV8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781968; c=relaxed/simple;
	bh=9At5ObNsRlGTxhSXagFN38DweXnHM/ljBq7zr65ISyg=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=teGA04MwHE/ZLVkTJV6wyuR56VpnFm1sQG+mCys0YImU40MZU43DDsHv7nlL4QP6Pk3ULfShIYSZU60wefXE76MnokthKkfYUm3i5VoAE1KJXkLZYzn9+9LhOodOjh6uVi65pUQ0iE3Xc7dL/YydgmzyxckbbtJy5UPbpdpoIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=e0kpik+V; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724781952; bh=YXNp1CwRzb1cSAOswvqcxzAqBdDtfm3QUAJm2PPJ9gk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=e0kpik+V+BWi9r4Ok1G5y/6ZtdOZx8OrpWCBdxM183hbNhiPhPf/y0BxzR9Nsr7SG
	 wlQbxzEmjAfx4vAya3OesmwU78O/l9EfeRDW+dpHOCHD9/9dTYiu5T5X7jvLlngX0W
	 f2F7yGWUak7TVhHNOtuc3QedLPZC/r8BahgM8xMk=
Received: from smtpclient.apple ([2408:8207:18a0:bb80:79e5:c8db:9406:ceaa])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 128828C1; Wed, 28 Aug 2024 02:04:40 +0800
X-QQ-mid: xmsmtpt1724781880t2r3wwir4
Message-ID: <tencent_595F628A43601A53F8E00461B5FB1CEB7009@qq.com>
X-QQ-XMAILINFO: NUygYfydBsqcIqBRf8IQuT6Zy1IXJL4qT+tPZ4zwr6LSASwJ6Hpc3OlylBK+SM
	 5Nff/sY1fv4dUl1cuZeXTJBWMA2p8AgPnG4zZ2eTeIJ8GnbHrwgbm1Q1ycRlI+A7HJGXTznDGr7H
	 aW2w4weKS8C3CODpnztjzzUwGJJB6zP+wjrQyGrMfwIFkqYeZbslEGrb3VGbbcZJEoIj+LYQOrvo
	 Rjaq7+yO5/rU1KSkTc8t7u0K7bAqtOT8T0Hs+1pMk70aQfEvyWTOF9jyU7woF8Mq+ikoZiLOjG/m
	 svQfY5HstsVwmMjzqrB+8t+ACVbk8Mq4Ek2kuJ9aHpb2wkteyLJkTQmSPfdkdatk/bP5yw9SZZPc
	 dKSgch4wu29FuWXZknAaGYb3HJIb0nKxw2XJHIkJqDJpilXdSUHOWwzXT1INHfPHlDjRnEjUqze6
	 VxXuTyJL8rSIWhyy4HgYKTu5IwMsCPlJ65Q3fx5AYHUsIIe6xWY5Ywe7PTeaspmQfAQbz967XMQd
	 BqfThUPceeR/eLDEEmepEpO+t7Ii6iPJ1A4jIK+JivpL2LtRtkOqN9tVvGwkgdxwI9vROJJFfln6
	 kkusQom3rquprYkaFbvhWClv0ooGvROeOHtqKDUIV3SoubSRn4lWa3BfvF/7Y8pu+otoq5eHkGTS
	 XvYrsoYRMvRrOOzI2Nd0wyA7G4WUfw/32HQm9LxzuqVqB58BwezddPakhnLhPen3cutmqGbmaDac
	 WvVWQf95g6f1qYvACY2Wg/rnP+RROVrdDRli028CX0BWmZoY+XVFOrxalm9foGI/S125iLiSQqD8
	 tOkmH+Eqrvnxc91jdme9Z64nMifx9J7FtlQ0ovn3K96m2GV+nl1rHOOLSCPgawMGaH2dP95Y1AJ5
	 wsUGllbZVtBRVZ2n3srvlHJhl2qVhzPBWweBq7PR4Ym0u8M429ErStyW6fN8J0P+X/9TFOCQkVM2
	 kBF8N0xYd+c0QAPd2RjITlaf7fGFn6aFBzW7A/LXoQa0IQpwRIP1ryIoNXn+qZH/GLP+nILOyHNY
	 0VRBiz4OyD61GK9U9FucLt2SidhWO0h1P9S3kHHJGp4TiyaRrc4swE2sVTZuO9VY25Dajxe8NcC6
	 EPJzl8
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3 0/3] RISC-V: mm: do not treat hint addr on mmap as the
 upper bound to search
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <Zs4BhmB4xOF4LOH9@ghost>
Date: Wed, 28 Aug 2024 02:04:29 +0800
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
 linux-riscv@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>,
 Levi Zim <rsworktech@outlook.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <F938DA82-936A-4226-8FF8-B4DBFC90FEF4@cyyself.name>
References: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
 <mhng-a7dcdfb5-0232-4ffb-8a20-13e564904da1@palmer-ri-x1c9a>
 <Zs4BhmB4xOF4LOH9@ghost>
To: Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On Aug 28, 2024, at 00:40, Charlie Jenkins <charlie@rivosinc.com> =
wrote:
>=20
> On Tue, Aug 27, 2024 at 09:33:11AM -0700, Palmer Dabbelt wrote:
>> On Tue, 27 Aug 2024 01:05:15 PDT (-0700), cyy@cyyself.name wrote:
>>> Previous patch series[1][2] changes a mmap behavior that treats the =
hint
>>> address as the upper bound of the mmap address range. The motivation =
of the
>>> previous patch series is that some user space software may assume =
48-bit
>>> address space and use higher bits to encode some information, which =
may
>>> collide with large virtual address space mmap may return. However, =
to make
>>> sv48 by default, we don't need to change the meaning of the hint =
address on
>>> mmap as the upper bound of the mmap address range. This behavior =
breaks
>>> some user space software like Chromium that gets ENOMEM error when =
the hint
>>> address + size is not big enough, as specified in [3].
>>>=20
>>> Other ISAs with larger than 48-bit virtual address space like x86, =
arm64,
>>> and powerpc do not have this special mmap behavior on hint address. =
They
>>> all just make 48-bit / 47-bit virtual address space by default, and =
if a
>>> user space software wants to large virtual address space, it only =
need to
>>> specify a hint address larger than 48-bit / 47-bit.
>>>=20
>>> Thus, this patch series change mmap to use sv48 by default but does =
not
>>> treat the hint address as the upper bound of the mmap address range. =
After
>>> this patch, the behavior of mmap will align with existing behavior =
on other
>>> ISAs with larger than 48-bit virtual address space like x86, arm64, =
and
>>> powerpc. The user space software will no longer need to rewrite =
their code
>>> to fit with this special mmap behavior only on RISC-V.
>>=20
>> So it actually looks like we just screwed up the original version of =
this:
>> the reason we went with the more complicated address splits were than =
we
>> actually started with a defacto 39-bit page table uABI (ie 38-bit =
user VAs),
>> and moving to even 48-bit page tables (ie, 47-bit user VAs) broke =
users
>> (here's an ASAN bug, for example:
>> https://github.com/google/android-riscv64/issues/64).
>>=20
>> Unless I'm missing something, though, the code doesn't actually do =
that.  I
>> remember having that discussion at some point, but I must have =
forgotten to
>> make sure it worked.  As far as I can tell we've just moved to the =
48-bit
>> VAs by default, which breaks the whole point of doing the =
compatibilty
>> stuff.  Probably a good sign I need to pay more attention to this =
stuff.
>>=20
>> So I'm not really sure what to do here: we can just copy the arm64 =
behavior
>> at tell the other users that's just how things work, but then we're =
just
>> pushing around breakages.  At a certain point all we can really do =
with this
>> hint stuff is push around problems, though, and at least if we copy =
arm64
>> then most of those problems get reported as bugs for us.
>=20
> Relying on the hint address in any capacity will push around breakages
> is my perspective as well. I messed this up from the start. I believe
> the only way to have consistent behavior is to mark mmap relying on =
the
> hint address as a bug, and only rely on the hint address if a flag
> defines the behavior.
>=20

I agree with this. However, since we already have this behavior on
x86 and aarch64 for quite a long time, to prevent breaking userspace,
I think we can use this patch and then add a flag like MAP_VA_FULL
to enable full va address in the future.

Thanks,
Yangyu Chen

> There is an awkward window of releases that will have this "buggy"
> behavior. However, since the mmap changes introduced a variety of
> userspace bugs it seems acceptable to revert to the previous behavior
> and to create a consistent path forward.
>=20
> - Charlie
>=20
>>=20
>>> Note: Charlie also created another series [4] to completely remove =
the
>>> arch_get_mmap_end and arch_get_mmap_base behavior based on the hint =
address
>>> and size. However, this will cause programs like Go and Java, which =
need to
>>> store information in the higher bits of the pointer, to fail on Sv57
>>> machines.
>>>=20
>>> Changes in v3:
>>> - Rebase to newest master
>>> - Changes some information in cover letter after patchset [2]
>>> - Use patch [5] to patch selftests
>>> - Link to v2: =
https://lore.kernel.org/linux-riscv/tencent_B2D0435BC011135736262764B51199=
4F4805@qq.com/
>>>=20
>>> Changes in v2:
>>> - correct arch_get_mmap_end and arch_get_mmap_base
>>> - Add description in documentation about mmap behavior on kernel =
v6.6-6.7.
>>> - Improve commit message and cover letter
>>> - Rebase to newest riscv/for-next branch
>>> - Link to v1: =
https://lore.kernel.org/linux-riscv/tencent_F3B3B5AB1C9D704763CA423E1A41F8=
BE0509@qq.com/
>>>=20
>>> [1] =
https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosi=
nc.com/
>>> [2] =
https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a=
655cfa8bcb@rivosinc.com/
>>> [3] =
https://lore.kernel.org/linux-riscv/MEYP282MB2312A08FF95D44014AB78411C68D2=
@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
>>> [4] =
https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-0-cd8962afe47f@=
rivosinc.com/
>>> [5] =
https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-2-cd8962afe47f@=
rivosinc.com/
>>>=20
>>> Charlie Jenkins (1):
>>>  riscv: selftests: Remove mmap hint address checks
>>>=20
>>> Yangyu Chen (2):
>>>  RISC-V: mm: not use hint addr as upper bound
>>>  Documentation: riscv: correct sv57 kernel behavior
>>>=20
>>> Documentation/arch/riscv/vm-layout.rst        | 43 ++++++++----
>>> arch/riscv/include/asm/processor.h            | 20 ++----
>>> .../selftests/riscv/mm/mmap_bottomup.c        |  2 -
>>> .../testing/selftests/riscv/mm/mmap_default.c |  2 -
>>> tools/testing/selftests/riscv/mm/mmap_test.h  | 67 =
-------------------
>>> 5 files changed, 36 insertions(+), 98 deletions(-)



