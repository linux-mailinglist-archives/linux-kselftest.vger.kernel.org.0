Return-Path: <linux-kselftest+bounces-3276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D8833692
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 22:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD7B21F6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9614AB9;
	Sat, 20 Jan 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BCTJUEnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C214F61;
	Sat, 20 Jan 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705787417; cv=none; b=pv0XInkvE2IIsem7Syzt6QChOGGxOmN6nihX9xgIqxuzhZRz509YKIO7U4hM1/CgevdwGsdGHzhxPr7XLwq9D785f5uJVOL25s7BFD2vy6FiCrF144hKT94OfMskkhoXfg9Z9Wo9mjQZZwwRiBo3QjvCsLEPcgeD+fKG5WP3eZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705787417; c=relaxed/simple;
	bh=I9/wMsxiLV+cUqwajTZ6MfQw4qQvC4xIjXaZaxVW514=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=O5/OmfEa9qdkab9ZRjZsVpb39dIgx/LknRQSqpx3Md0pVBrcTI5Ht2K1TFAkqXwAJ5tPCP4s4AWSXzJSBlEjGHKhEncOu0auLJGQfMQZMse/yLMTSwiQqyFR5chWj5z4n03GoqDCTDGHJil9jBwNj7367ii3tegcdoavh/MyNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BCTJUEnR; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705787407; bh=4nmX4hKeh/0WuigJrd8ANC0wflYIcPXPQU4r0VNEKp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCTJUEnRp+uC0d0dRxHQsm/zVTkvWgVkAiSDO/Np0gxMBiylPltmYRRlaUxuRE5dT
	 JNImCpHL9Z4E39CTM/nzV/g84s+7awuJxhKqNJLPRWtD/xn8+67ZyD+5zra9Iqkfk5
	 J9hS+sWGY04ORFsXjGfpC4+g8/l88pMguMUorMpg=
Received: from cyy-pc.lan ([240e:379:2240:ed00:c92f:86c3:e615:ca18])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id C832D4DD; Sun, 21 Jan 2024 05:50:03 +0800
X-QQ-mid: xmsmtpt1705787403tnr6elyfm
Message-ID: <tencent_2683632BEE438C6D4854E30BDF9CA0843606@qq.com>
X-QQ-XMAILINFO: OPDQNGCUQ3qLjMTDsrPToOp8oyErPnL2SII8vV9kBmlMV/zje0JtvQMeaBQSLy
	 B2QJFDDnOzluHBIoK3YrDakeYq1fWVYfn74YrxBVVRd8tl+v2/yLAywxvW+k44gaNKX0N25jyf+t
	 WrPkrf8crNxwu7VPCeY43GXT7J1T8nntnPO/6OtzZ27FP6ibc1/EISwFYOuKUF1Ztq1j8CZDEY62
	 nHhBvzrqDea94mJGzZZ6dTCKXpg8YE6ggXAR1ycnSX1nUuz441T3r9p6eE+dbnEIctVBEgOkYTqY
	 NZFVL4uwWf6RoC5X3ykYjE9NXqs1aCyf2K7tovE8dlIVLrUAiZTuoIIq04uKiGxF6pKhhtUabb+W
	 IOscWMkKMcFVpW+LUTdBGEoQ9MgiMAzKEdbRJ01mK5piJuHFw2Rw+PnwunWv3tFZCGKP5yyn5Px9
	 GtU7ks9X0jco8acac37axmjiySgqH5Sw30F6SAbbCZCK8JwyZQ47x+zrWa35EnSl8FcQDZ5hehbw
	 qPYQEqQUlgI1Zp5/DNNPJc39PKDeuFD9GOL1WySOS5siYySwsyr04wvTPnPu+iHD37tiMhSmQ2ny
	 mYsBKzRvjMXAFGRaQKacp39hdh8w1HpeuPmRBoY543PPeXgDQbiPxeAdQWqX+UcQ9GiqV03ul2Rx
	 BJAqgNlKukFM0q1Cxv8PetFLS2GktGbAjpuuPTBt2dv6uJdZywgTBmm1wWGgkmFGMK2GzBwQRhb4
	 lUxxrf6bvMi0RNZzzWHQknlNc57BfIoYi9+KlMb6oPd4h2CUgkXcJzylpt23Uw2qiBrJXMO2U0CZ
	 J6P0lWu2HoLu90um4XA1X+tgwXIvydZVnZzHKOEw7Gpvi1Fi09/ABN4Ub2Pa7RLTIU72Rj87xIkh
	 bmIN8Db8FDf1vQAURV5C3ZuslG/UO1aJ8Zincg1F4sSugX+WZXDqUYtUCIj2vddR9JwJhuka6alp
	 ygJd0xxijjWzsLCCayIR99Dfr/ijIim+Z3cuceuUmlob4bU1jZwoh5pvhl8Q2/c10Bj37a/jyDxR
	 eCDOn+v55wx5G1hZ7R7Lo7MkdxHpg=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 1/3] RISC-V: mm: do not treat hint addr on mmap as the upper bound to search
Date: Sun, 21 Jan 2024 05:49:58 +0800
X-OQ-MSGID: <20240120215000.291877-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_B2D0435BC011135736262764B511994F4805@qq.com>
References: <tencent_B2D0435BC011135736262764B511994F4805@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reverted the meaning of the addr parameter in the mmap syscall
change from the previous commit add2cc6b6515 ("RISC-V: mm: Restrict address
space for sv39,sv48,sv57") from patch[1] which treats hint addr as the
upper bound of the mmap return address. However, some userspace software
assumes mmap will attempt to create mapping on the hint address if possible
without MAP_FIXED set, thus these software will always use the fallback
path as the return address is not the same as the hint, which may lead to
some performance overhead. Other ISAs like x86, arm64, and powerpc also
meet this issue which has userspace virtual address bits larger than 48-bit
and userspace software may use the MSB beyond 48-bit to store some
information. Still, these ISAs didn't change the meaning of the hint
address and only limited the address space to 48-bit when the hint address
did not go beyond the default map window.

Thus, this patch makes the behavior of mmap syscall on RISC-V sv57 capable
system align with x86, arm64, powerpc by only limiting the address space to
DEFAULT_MAP_WINDOW which is defined as not larger than 47-bit. If a user
program wants to use sv57 address space, it can use mmap with a hint
address larger than BIT(47) as it is already documented in x86 and arm64.
And this code is copied from kernel source code on powerpc.

[1]. https://lore.kernel.org/r/20230809232218.849726-2-charlie@rivosinc.com

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/include/asm/processor.h | 38 ++++++------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index a8509cc31ab2..bc604669f18e 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -18,37 +18,13 @@
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE
 
-#define arch_get_mmap_end(addr, len, flags)			\
-({								\
-	unsigned long mmap_end;					\
-	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_end = VA_USER_SV48;			\
-	else							\
-		mmap_end = VA_USER_SV39;			\
-	mmap_end;						\
-})
-
-#define arch_get_mmap_base(addr, base)				\
-({								\
-	unsigned long mmap_base;				\
-	typeof(addr) _addr = (addr);				\
-	typeof(base) _base = (base);				\
-	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
-		mmap_base = (_base);				\
-	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
-		mmap_base = VA_USER_SV57 - rnd_gap;		\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_base = VA_USER_SV48 - rnd_gap;		\
-	else							\
-		mmap_base = VA_USER_SV39 - rnd_gap;		\
-	mmap_base;						\
-})
+#define arch_get_mmap_end(addr, len, flags) \
+	(((addr) > DEFAULT_MAP_WINDOW) || \
+	 (((flags) & MAP_FIXED) && ((addr) + (len) > DEFAULT_MAP_WINDOW)) ? TASK_SIZE : \
+									    DEFAULT_MAP_WINDOW)
+
+#define arch_get_mmap_base(addr, base) \
+	(((addr) > DEFAULT_MAP_WINDOW) ? (base) + TASK_SIZE - DEFAULT_MAP_WINDOW : (base))
 
 #else
 #define DEFAULT_MAP_WINDOW	TASK_SIZE
-- 
2.43.0


