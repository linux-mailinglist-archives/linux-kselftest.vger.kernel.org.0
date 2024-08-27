Return-Path: <linux-kselftest+bounces-16454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA6E9615C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09B21F251D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFA1CDFA7;
	Tue, 27 Aug 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ExfsgvKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC813126F1E;
	Tue, 27 Aug 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780890; cv=none; b=tgFRjKfVZ0YpeBhEDkALBUX5bpG4iwd5elxrhASPs6nLX39KSILCyas8Z6s1nQoZNgkuab0RN79tnM361hL1fH1OYBUHvSgOt7b6kUzbZDS5RT4jodYTwdVK0VYawTPFGTT+8yr5UF3RiqygA2U5bgLUDMg9AoV/MIcdZldYeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780890; c=relaxed/simple;
	bh=KTbFSM9tHSP+RlcWea9+1q3s56PX4BgmMZgHn8mNEQo=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=SyA+SAri17AGSvAK6kN9hhJZOHOSWvGJW9ZsFBKWatLxEdulULG69TFWQEUFf+Q6UXOkyMehy+n2l+JqvrmvYVbpLPhTGmx1zsLgE53Cmm3l3f5oPYgVrfwm1/+TqCf3NLJJfjdBWA23M+WnanAuOI7OpixRLl0owUGjEoa9xSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ExfsgvKr; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724780884; bh=Bkd8gFeLSf6g7a8IsJ2hm/2hCok13/+tTgniHLVL1lU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=ExfsgvKrjIaXGs2ha3dh2uIpv6csDYSum/0rJ7Xe+++TS0U+QDteYeefBMK2FPRaO
	 352N3txmwOu7or2e/iBmaGIjzB7vsiNvWpIQ0d1tIckVUQqF45yvm53GLD+O0rhFwN
	 KlP6zrIwH/DEc7FJL6l5xI5+5Z27XuaSYhL7gL2c=
Received: from smtpclient.apple ([2408:8207:18a0:bb80:79e5:c8db:9406:ceaa])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id BFB9A4CC; Wed, 28 Aug 2024 01:47:59 +0800
X-QQ-mid: xmsmtpt1724780879tjalo6r6g
Message-ID: <tencent_04EADAB08E75B88431FB219C8D757C108208@qq.com>
X-QQ-XMAILINFO: MLAWG7dqOaka7Nb1xVPHfb7JG1kJ36BetyPhzCvbVVudcp9kJlLa/63mWQq6j+
	 PyMBi6irRz/tB3D2gbm4frIj4bkIxUA88BqEfbp8++n9BomqVAm3Ok1b1bFESGUqcKQFnuVqzgqu
	 uf9XC4JO2s8QWQEXs2i5sJIy//O+3xlRpotgqrgQBesW3Mp4z6rBwVRYQXME31bRN7cn0dtIpW8P
	 zzb0FYkxVhpckNC7MlY56ruTQiX4EpkJDGh9paXNSmrnEtNceHydRXPh4z7Sk4U95VLZHymOS4Hl
	 HEOiuzSGGBq5e3wl6/vry+qddJx6qQVFQO42+vBm+2S3YQGvGdIN4KGlwNJ2YR+onBKAVlTsciIP
	 bG99SSqX6gO0gY86ZRGxrOGPXVOpmmRYL4sXrwhCn9UCeCsuHbbgg0Yk1h9xOBk6QcJi7ZUz6Fa4
	 1oUlnFUldVMc1CMZRrDIpq1OeVJiWOB9OKSpu9kRa2PLbMtIyKKhJ8HkRy5kwpGv+jsP/sCQsjSv
	 ozrUk/LH7HhS95+RoU66X8Z9EONiOiQzYminWziZ891oQNqJ064ZcsPEOT2iWGKPkRqgbC2Ce/lb
	 8K68b9TuleTQ4IuxicfoVgj+k7b+mRVrjh6xUMzQxlQm/NogJqEAdsjTTEstlRLq0jXcbvaA86g2
	 S0Rw6SuK+rI4+KC+YkfMc9x812AzZe5KOey7hlPrxn3Yk/vMAyzghjOly8P4jVn9laXFxDFerCat
	 Bj0XzKQwGOoRqd25wMMGqIY+LQv/NRd3wqi31XKPdKZsHdJNNoqdsbjGEsA+rgdF16avD3ifx6F/
	 hgMygs0wZ9eeBQrpm1a0+MwxbE47mRBnzXffGzlwBGAMRRNqsy2kaOOf4C0OqSvBSMyWqc23AT61
	 5nPMr0uACHb9W98Qz4JzSNB3ZuXIC+VzF06UObRzAwZL9yXsOXVVEo29u9gedObJkqibAy+0ZARC
	 QWEUQ5cyrGooI5WucgLmLHIgsJTpxdnvrIdpzdwnjTwHi9s2/R/ije9mPz4nECFgtcZndfcgLHNm
	 HaH4ozseKt4cVlTzZ5oX6IftKSuUqUzmEVM4l2NPli6cHU8lnw
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
In-Reply-To: <mhng-a7dcdfb5-0232-4ffb-8a20-13e564904da1@palmer-ri-x1c9a>
Date: Wed, 28 Aug 2024 01:47:49 +0800
Cc: linux-riscv@lists.infradead.org,
 Charlie Jenkins <charlie@rivosinc.com>,
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
X-OQ-MSGID: <05A72DDA-F689-403F-9214-6392AB6B5C29@cyyself.name>
References: <mhng-a7dcdfb5-0232-4ffb-8a20-13e564904da1@palmer-ri-x1c9a>
To: Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On Aug 28, 2024, at 00:33, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>=20
> On Tue, 27 Aug 2024 01:05:15 PDT (-0700), cyy@cyyself.name wrote:
>> Previous patch series[1][2] changes a mmap behavior that treats the =
hint
>> address as the upper bound of the mmap address range. The motivation =
of the
>> previous patch series is that some user space software may assume =
48-bit
>> address space and use higher bits to encode some information, which =
may
>> collide with large virtual address space mmap may return. However, to =
make
>> sv48 by default, we don't need to change the meaning of the hint =
address on
>> mmap as the upper bound of the mmap address range. This behavior =
breaks
>> some user space software like Chromium that gets ENOMEM error when =
the hint
>> address + size is not big enough, as specified in [3].
>>=20
>> Other ISAs with larger than 48-bit virtual address space like x86, =
arm64,
>> and powerpc do not have this special mmap behavior on hint address. =
They
>> all just make 48-bit / 47-bit virtual address space by default, and =
if a
>> user space software wants to large virtual address space, it only =
need to
>> specify a hint address larger than 48-bit / 47-bit.
>>=20
>> Thus, this patch series change mmap to use sv48 by default but does =
not
>> treat the hint address as the upper bound of the mmap address range. =
After
>> this patch, the behavior of mmap will align with existing behavior on =
other
>> ISAs with larger than 48-bit virtual address space like x86, arm64, =
and
>> powerpc. The user space software will no longer need to rewrite their =
code
>> to fit with this special mmap behavior only on RISC-V.
>=20
> So it actually looks like we just screwed up the original version of =
this: the reason we went with the more complicated address splits were =
than we actually started with a defacto 39-bit page table uABI (ie =
38-bit user VAs), and moving to even 48-bit page tables (ie, 47-bit user =
VAs) broke users (here's an ASAN bug, for example: =
https://github.com/google/android-riscv64/issues/64). =20
> Unless I'm missing something, though, the code doesn't actually do =
that.  I remember having that discussion at some point, but I must have =
forgotten to make sure it worked.  As far as I can tell we've just moved =
to the 48-bit VAs by default, which breaks the whole point of doing the =
compatibilty stuff.  Probably a good sign I need to pay more attention =
to this stuff.
>=20

It seems the issues have been solved in LLVM D139823 [1] and LLVM =
D152895 [2].

[1] https://reviews.llvm.org/D139823
[2] https://reviews.llvm.org/D152895

> So I'm not really sure what to do here: we can just copy the arm64 =
behavior at tell the other users that's just how things work, but then =
we're just pushing around breakages.  At a certain point all we can =
really do with this hint stuff is push around problems, though, and at =
least if we copy arm64 then most of those problems get reported as bugs =
for us.
>=20
>> Note: Charlie also created another series [4] to completely remove =
the
>> arch_get_mmap_end and arch_get_mmap_base behavior based on the hint =
address
>> and size. However, this will cause programs like Go and Java, which =
need to
>> store information in the higher bits of the pointer, to fail on Sv57
>> machines.
>>=20
>> Changes in v3:
>> - Rebase to newest master
>> - Changes some information in cover letter after patchset [2]
>> - Use patch [5] to patch selftests
>> - Link to v2: =
https://lore.kernel.org/linux-riscv/tencent_B2D0435BC011135736262764B51199=
4F4805@qq.com/
>>=20
>> Changes in v2:
>> - correct arch_get_mmap_end and arch_get_mmap_base
>> - Add description in documentation about mmap behavior on kernel =
v6.6-6.7.
>> - Improve commit message and cover letter
>> - Rebase to newest riscv/for-next branch
>> - Link to v1: =
https://lore.kernel.org/linux-riscv/tencent_F3B3B5AB1C9D704763CA423E1A41F8=
BE0509@qq.com/
>>=20
>> [1] =
https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosi=
nc.com/
>> [2] =
https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a=
655cfa8bcb@rivosinc.com/
>> [3] =
https://lore.kernel.org/linux-riscv/MEYP282MB2312A08FF95D44014AB78411C68D2=
@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
>> [4] =
https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-0-cd8962afe47f@=
rivosinc.com/
>> [5] =
https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-2-cd8962afe47f@=
rivosinc.com/
>>=20
>> Charlie Jenkins (1):
>>  riscv: selftests: Remove mmap hint address checks
>>=20
>> Yangyu Chen (2):
>>  RISC-V: mm: not use hint addr as upper bound
>>  Documentation: riscv: correct sv57 kernel behavior
>>=20
>> Documentation/arch/riscv/vm-layout.rst        | 43 ++++++++----
>> arch/riscv/include/asm/processor.h            | 20 ++----
>> .../selftests/riscv/mm/mmap_bottomup.c        |  2 -
>> .../testing/selftests/riscv/mm/mmap_default.c |  2 -
>> tools/testing/selftests/riscv/mm/mmap_test.h  | 67 =
-------------------
>> 5 files changed, 36 insertions(+), 98 deletions(-)



