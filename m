Return-Path: <linux-kselftest+bounces-16371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319789603F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BC4281C9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD418BC02;
	Tue, 27 Aug 2024 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oQ7ehSB7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EC155CA5;
	Tue, 27 Aug 2024 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745985; cv=none; b=eF+snR2GhruAhmeiKSSs49JYdsT/gd7WMoe0vz+P2bdJhpFLOay5ELa0e+qKNzG+UAtUt6aKmjnh2pZDVUlACKzHsQVsooiqB64g1xN8V0T1IwUhkir50fJ/ygYpJ/5Dt60sW0UW8FA1nFkpSHKhzxsZjmBP9LDL2uXT34W45Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745985; c=relaxed/simple;
	bh=FEAY4G08V4p4v067K373UcpJj352bNUAXuaBr5yG81w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZOjSz+yS9u4gthwRCCgitLd7mMGp/GS55YMKbKyDOPYfk3/qUZq6/1cagq+VIkeaiYNn7+XrC54cfv/hcORCn+N7CJumnJH373DcAFaK3EHH3mbaSaGU7dqqft8c5NMUX8tRDTTirNQHpBozH7dsZJUboaX8X1LyWkCE1p1585w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oQ7ehSB7; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724745970; bh=XSuLHbw5Qh9hxUArp6/0gEvP09hyxdfOpiAwFodjpCc=;
	h=From:To:Cc:Subject:Date;
	b=oQ7ehSB72m2apvSTEP6N6+hfKWJTFR+oLF1RhzEFB4/hIhp2CuTfuWeNYSZHWPu1o
	 Cv3XcCfPeYEoYaezQPASOsxlkgu2JcT3hkeqsKFBeXUc2gkLVpSXADXaAo5oagiuSh
	 e99Ow8+WpfhtJh+nrRrmwLAGlBzCcY8odeHNywi0=
Received: from cyy-pc.lan ([240e:379:224b:5f00:16b6:fb41:2849:da9d])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 185800A8; Tue, 27 Aug 2024 16:06:05 +0800
X-QQ-mid: xmsmtpt1724745965tl0gmx80a
Message-ID: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTNMP2jtZxLCG3MqoT45QmcT6F+Y89dIjCFc1STe2F2X+PupYH7R
	 X9g9TdKjDKBlZoLbJtnnCQE/ILZSPi8T28fZf7+9fobiS/0fS1PiC3NljqHD51Pbch7O550mZqa1
	 Vgicbu6BX5Xdp+nlVGSd2O8muVOpnGwanTbJxAVrdEqGXBlJWwPe5xCc5FmGJmmdp4o6mq9FQQNN
	 guY3/pzFRkCLU5nLPOfN7wSyPv1NwPFRl9ynXFoVVdQajBsuVW4DzahykVZDbvWBxo3W1j5BntVP
	 APVKBL23jrsFGDIyhMCIclUSZVOYDfjuUARCjCOzlyyDwq4NYelg7upPSN8qGS9UrvLZ9vWTvwCd
	 /whbAhRpgPbdVN3lnEXAQVpJEqT6TN5TXy1M6rKRvSO3cAtlc5WtgfuRansFBR9W9MELYuMwFaO6
	 8E6Q3Ktkk77MU7RrW1s3ezJNt8eI7ggGOfFtyKujYjd4ETnGyzeP2IGsxmLHIj3bua2zscphfyTA
	 SAB6rnTEveFgqVHJpogqyp3J8XfUZ2HSnXpQl6w8pC2vHC7W8LvPEi7F7HIPUPxkNwKa6hyaOQbw
	 Eu6T+4zKII1xuTGreyo8tOSMKB93iOxAdnULz59qac1MpiBWguHRMj6szooD0Fd/e+h9yuo1gWO9
	 ok8NEBYXr/uGinbd1/xQPxiQK5i+5X4W5GMjph3nk9nPHfBD+Q4MMyRhYMsGcSLY43jl/j78DBjg
	 mm3CDnU5o+d7MScHX+kq8awoOpqvTyo09YYYfg/npplmdGmbrPVHHNHgqbaF6WrRRmsOK7N/Suz3
	 +Ki+ebQVllr3qixdnN+K6/fUbhtuSVZVi8RuudzYndctLP7UpqQUJwfqFrKHubbq2n8uO0t4ExAg
	 DUNhfRHmlMofYCNkOoIHIHljWWFZn9ldMDlEHH1xtR+iLV+/15aeZ24D0PwjsGKQETPVEuczBUfC
	 s9BdalA3SUEOuLKkNGVv5l2Z1ctJdP3r1CiKUsuANm2XAPN0QDJxP7U1L+T9jWAH2i9gudaE8=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>,
	Levi Zim <rsworktech@outlook.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v3 0/3] RISC-V: mm: do not treat hint addr on mmap as the upper bound to search
Date: Tue, 27 Aug 2024 16:05:15 +0800
X-OQ-MSGID: <20240827080515.3788410-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous patch series[1][2] changes a mmap behavior that treats the hint
address as the upper bound of the mmap address range. The motivation of the
previous patch series is that some user space software may assume 48-bit
address space and use higher bits to encode some information, which may
collide with large virtual address space mmap may return. However, to make
sv48 by default, we don't need to change the meaning of the hint address on
mmap as the upper bound of the mmap address range. This behavior breaks
some user space software like Chromium that gets ENOMEM error when the hint
address + size is not big enough, as specified in [3].

Other ISAs with larger than 48-bit virtual address space like x86, arm64,
and powerpc do not have this special mmap behavior on hint address. They
all just make 48-bit / 47-bit virtual address space by default, and if a
user space software wants to large virtual address space, it only need to
specify a hint address larger than 48-bit / 47-bit.

Thus, this patch series change mmap to use sv48 by default but does not
treat the hint address as the upper bound of the mmap address range. After
this patch, the behavior of mmap will align with existing behavior on other
ISAs with larger than 48-bit virtual address space like x86, arm64, and
powerpc. The user space software will no longer need to rewrite their code
to fit with this special mmap behavior only on RISC-V.

Note: Charlie also created another series [4] to completely remove the
arch_get_mmap_end and arch_get_mmap_base behavior based on the hint address
and size. However, this will cause programs like Go and Java, which need to
store information in the higher bits of the pointer, to fail on Sv57
machines.

Changes in v3:
- Rebase to newest master
- Changes some information in cover letter after patchset [2]
- Use patch [5] to patch selftests
- Link to v2: https://lore.kernel.org/linux-riscv/tencent_B2D0435BC011135736262764B511994F4805@qq.com/

Changes in v2:
- correct arch_get_mmap_end and arch_get_mmap_base
- Add description in documentation about mmap behavior on kernel v6.6-6.7.
- Improve commit message and cover letter
- Rebase to newest riscv/for-next branch
- Link to v1: https://lore.kernel.org/linux-riscv/tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com/

[1] https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosinc.com/
[2] https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com/
[3] https://lore.kernel.org/linux-riscv/MEYP282MB2312A08FF95D44014AB78411C68D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
[4] https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com/
[5] https://lore.kernel.org/linux-riscv/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com/

Charlie Jenkins (1):
  riscv: selftests: Remove mmap hint address checks

Yangyu Chen (2):
  RISC-V: mm: not use hint addr as upper bound
  Documentation: riscv: correct sv57 kernel behavior

 Documentation/arch/riscv/vm-layout.rst        | 43 ++++++++----
 arch/riscv/include/asm/processor.h            | 20 ++----
 .../selftests/riscv/mm/mmap_bottomup.c        |  2 -
 .../testing/selftests/riscv/mm/mmap_default.c |  2 -
 tools/testing/selftests/riscv/mm/mmap_test.h  | 67 -------------------
 5 files changed, 36 insertions(+), 98 deletions(-)

-- 
2.45.2


