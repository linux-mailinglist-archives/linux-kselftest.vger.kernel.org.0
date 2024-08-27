Return-Path: <linux-kselftest+bounces-16372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C309E9603F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD411C22561
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAC188A07;
	Tue, 27 Aug 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GUz0nhqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D34C92;
	Tue, 27 Aug 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746051; cv=none; b=keJ9ucuIoK4ZKy4ZDthalMVLwUVc3+/XMSdw5I0xZM4+gC81tywtXpbntQVsyrbU17889oTWxxPxlCOoe5RwcLN5VdyZs4ppAmVfXLGND+80uSvlkNNCsvQTSsTCV8y/ccb1P/yViboVUipcsoV4G7Yc9rQKDneSjesY403uAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746051; c=relaxed/simple;
	bh=jZfIBq/ZlHLtw3gVlBG4D0r1BYFQDylW4QaFKG+Srko=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Kp3RyU3c9OtrNPcumTdxY4e96oGXjlMpltzQi9y19b5fjiWoR0xXhyJW2W961BtWqnCxmnzMhHnr82a/1rnwPo2nzHEbO1EtQonaIBZQNmJ35VLyAyu0MOi6ufAjftHD6/sRYtymHZ74qktq0ddMJjb8wRSwMz+9nlAqcP35Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GUz0nhqf; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724746044; bh=Rpaxy/Sgp6KQtqGI36Fiss4HXP2gm06tq/QCoeKMT0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GUz0nhqfyJxEsV/69CEAdV0X/i/cmRN0waZt6I729fK9k9s5Fc5NL4tS29s80mu7X
	 VkclQ7LKmSM9iQO8Qy4sBUDxCXLz5tg1mEn9oSh60FvdbmAPxTaVZ/Na1Ajp4clAdn
	 xRcU6J77/Tw/ox8/Cl4DhcpXxeLRfcBTQFiqjzdQ=
Received: from cyy-pc.lan ([240e:379:224b:5f00:16b6:fb41:2849:da9d])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 1CBA7234; Tue, 27 Aug 2024 16:07:11 +0800
X-QQ-mid: xmsmtpt1724746041tien190zy
Message-ID: <tencent_C8DB706163A442181BBBF946053FB4311C09@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UE3a09X6sZWH6ObhF0zWKAG1iocK70Ucurce3lGwQzSWE77xpTeW
	 EqEPeUGMD0x2hA4rUWze2dn5QDH8FpiDrO2prf2xK3ga4U8M6QaNLTL3SIvQPCxJM2IC9AW4AONO
	 hlVF09EjXZwVMploet79noqL26Gbn3Xnho3M2xUdLx7wPpGVWT1vFDBHqgjZyNe94nNq1BYoWWVZ
	 +4EoD34cZmH2lCbaTrYnvvzdvYpNQ9B9fF/oYm1Y9851FNZsx41c3AhZrJ+nXQzL4eN1sqfxNwca
	 LoOuCtlfLQHzzdZ6hkKfZLQWRg7G7wWNGiuNUIkxJXe5LYxQzj42RKBT4YIK2W6okSHxHTzsfRq2
	 QYTyuSaQbYQLsaX6weZVRZPFGfq2QjwP/ZWvkSkBdPwYsGJ3oyK9FKqRK5qnq4Ugq+KRfMbdbPso
	 NK9mkiL3P9itoJnXQtIuADVnubRksEbxgYvNuZ5OllfwHXdHMS5LRvgVp5llS7bwnJQNhtBJXq80
	 4O1QMappEnv72PF+SlgSRsUdmp99SZ2naZP+ZvPzDqkTNVYgGIiEZoAzs8aVkKOfB2jCVboOsmRq
	 UuiHFm7YzEGN8AVPJqIPYJFaC7aG+XTHB2xvwXfLUHwtF+GTzr/PaXP6A8PTuU22lAMxZtKq4Kpb
	 aIQV5CGU5SBZEUf5tGfwvkxAOeVc8XLVJwdrcESsdLCOSSODj+QXS3Q1ecUJXHAB0ElWe25mYxoG
	 Dd4mKr9PzczQ/+D8G39hWyRFmuE5IV6tRG2pF5cjAFXR7JMZSPMlVcqRnA4LDXdgfNm8vK4gK6eP
	 FK+PJOomGD0nFoaoo8jB/Hpkv4NG3zEytcsX/tez2/JJUjSDE1EnVlu3Elf559dORsP6YdUjf8gq
	 L0o/yy2XX4C/R9dJP8upMidMeBaGI3tHWc12D6P7YHofZqEx5/XekKef60w+vTBt74r3DBMdEhUM
	 rbjydD3CC8T4FJJLSvryzCkIc3IPKubPQuhGgun2FFKa3zb/NMpH6qb6Mc7uC0FJX1NxJZEEjTVx
	 nJUoY4cQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH v3 2/3] RISC-V: mm: not use hint addr as upper bound
Date: Tue, 27 Aug 2024 16:07:06 +0800
X-OQ-MSGID: <20240827080707.3788836-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
References: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reverted the meaning of the addr parameter in the mmap syscall
change from the previous commit b5b4287accd7 ("riscv: mm: Use hint address
in mmap if available") from patch[1] which treats hint addr + size as the
upper bound of the mmap return address. Result in ENOMEM error caused when
hint address + size is not big enough.

Thus, this patch makes the behavior of mmap syscall to align with x86,
arm64, powerpc by only limiting the address space to DEFAULT_MAP_WINDOW
which is defined as not larger than 47-bit. If a user program wants to
use sv57 address space, it can use mmap with a hint address larger than
BIT(47) as it is already documented in x86 and arm64.

[1] https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/include/asm/processor.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 8702b8721a27..faf3e230ab24 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,22 +13,17 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/mman.h>
 
-/*
- * addr is a hint to the maximum userspace address that mmap should provide, so
- * this macro needs to return the largest address space available so that
- * mmap_end < addr, being mmap_end the top of that address space.
- * See Documentation/arch/riscv/vm-layout.rst for more details.
- */
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || is_compat_task() ||			\
-	    ((_addr + len) > BIT(VA_BITS - 1)))			\
+	if (((_addr + len) > DEFAULT_MAP_WINDOW) ||		\
+	    ((flags) & MAP_FIXED))				\
 		mmap_end = STACK_TOP_MAX;			\
 	else							\
-		mmap_end = (_addr + len);			\
+		mmap_end = DEFAULT_MAP_WINDOW;			\
 	mmap_end;						\
 })
 
@@ -38,11 +33,10 @@
 	typeof(addr) _addr = (addr);				\
 	typeof(base) _base = (base);				\
 	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || is_compat_task() || 		\
-	    ((_addr + len) > BIT(VA_BITS - 1)))			\
-		mmap_base = (_base);				\
+	if ((_addr + len) > DEFAULT_MAP_WINDOW)			\
+		mmap_base = (STACK_TOP_MAX - rnd_gap);		\
 	else							\
-		mmap_base = (_addr + len) - rnd_gap;		\
+		mmap_base = (_base);				\
 	mmap_base;						\
 })
 
-- 
2.45.2


