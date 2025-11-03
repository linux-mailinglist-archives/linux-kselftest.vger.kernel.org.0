Return-Path: <linux-kselftest+bounces-44665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FBBC2D3C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE2D425D2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E131DD82;
	Mon,  3 Nov 2025 16:33:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076D2320CAD;
	Mon,  3 Nov 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187580; cv=none; b=Eojei3WwGeqJR/TUFNkiNOjd4Lxs1JtSnbvFbVqLKDembqO/4NDr8HUR/APqZAN811rAPuU488czQKV3mFhsQuoiiDzUyVnG/H3TWY0KwwuV0aI5iuRcje7ry9O4k0p3001c53rpiMJPn1d6QnjTSqDEvPPw5JWq18yo1kpdu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187580; c=relaxed/simple;
	bh=VRvFMgGgaPy/Zxqu8M6T6tyrMX1VvHgJ9PrCiAX9cOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwruS9o6f5tBkceudrx/3iu4K05a2xUcDUvE5fdhLd9LpTjRBqo6Cdp5OjjdLHtPQwsK9xmpNUSUCIUt4w32zi+s8B1msMv9+h4yd851UPVpa9N0tm3UCTB0pcPRkV0X40auKnvZDAs5P0IBah7bH+0mqgO3wEyaDQwUQRMpwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95FD3315F;
	Mon,  3 Nov 2025 08:32:49 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 422503F694;
	Mon,  3 Nov 2025 08:32:54 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	miko.lenczewski@arm.com,
	kevin.brodsky@arm.com,
	ardb@kernel.org,
	suzuki.poulose@arm.com,
	lpieralisi@kernel.org,
	yangyicong@hisilicon.com,
	scott@os.amperecomputing.com,
	joey.gouly@arm.com,
	yuzenghui@huawei.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v10 8/9] arm64: armv8_deprecated: convert user_swpX to inline function
Date: Mon,  3 Nov 2025 16:32:23 +0000
Message-Id: <20251103163224.818353-9-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103163224.818353-1-yeoreum.yun@arm.com>
References: <20251103163224.818353-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is preparation patch to apply FEAT_LSUI in
user_swpX operation.
For this, convert user_swpX macro into inline function.
No functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 38 +++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index e737c6295ec7..d15e35f1075c 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -93,13 +93,18 @@ static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
 /* Arbitrary constant to ensure forward-progress of the LL/SC loop */
 #define __SWP_LL_SC_LOOPS	4
 
-#define __user_swpX_asm(data, addr, res, temp, temp2, B)	\
-do {								\
+#define LLSC_USER_SWPX(B)					\
+static __always_inline int					\
+__llsc_user_swp##B##_asm(unsigned int *data, unsigned int addr)	\
+{								\
+	int err = 0;						\
+	unsigned int temp, temp2;				\
+								\
 	uaccess_enable_privileged();				\
 	__asm__ __volatile__(					\
 	"	mov		%w3, %w6\n"			\
-	"0:	ldxr"B"		%w2, [%4]\n"			\
-	"1:	stxr"B"		%w0, %w1, [%4]\n"		\
+	"0:	ldxr"#B"	%w2, [%4]\n"			\
+	"1:	stxr"#B"	%w0, %w1, [%4]\n"		\
 	"	cbz		%w0, 2f\n"			\
 	"	sub		%w3, %w3, #1\n"			\
 	"	cbnz		%w3, 0b\n"			\
@@ -110,17 +115,22 @@ do {								\
 	"3:\n"							\
 	_ASM_EXTABLE_UACCESS_ERR(0b, 3b, %w0)			\
 	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w0)			\
-	: "=&r" (res), "+r" (data), "=&r" (temp), "=&r" (temp2)	\
+	: "=&r" (err), "+r" (*data), "=&r" (temp), "=&r" (temp2)\
 	: "r" ((unsigned long)addr), "i" (-EAGAIN),		\
 	  "i" (__SWP_LL_SC_LOOPS)				\
 	: "memory");						\
 	uaccess_disable_privileged();				\
-} while (0)
+								\
+	return err;						\
+}
+
+LLSC_USER_SWPX()
+LLSC_USER_SWPX(b)
 
-#define __user_swp_asm(data, addr, res, temp, temp2) \
-	__user_swpX_asm(data, addr, res, temp, temp2, "")
-#define __user_swpb_asm(data, addr, res, temp, temp2) \
-	__user_swpX_asm(data, addr, res, temp, temp2, "b")
+#define __user_swp_asm(data, addr) \
+	__llsc_user_swp_asm(data, addr)
+#define __user_swpb_asm(data, addr) \
+	__llsc_user_swpb_asm(data, addr)
 
 /*
  * Bit 22 of the instruction encoding distinguishes between
@@ -131,7 +141,7 @@ do {								\
 static int emulate_swpX(unsigned int address, unsigned int *data,
 			unsigned int type)
 {
-	unsigned int res = 0;
+	unsigned int res;
 
 	if ((type != TYPE_SWPB) && (address & 0x3)) {
 		/* SWP to unaligned address not permitted */
@@ -140,12 +150,10 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 	}
 
 	while (1) {
-		unsigned long temp, temp2;
-
 		if (type == TYPE_SWPB)
-			__user_swpb_asm(*data, address, res, temp, temp2);
+			res = __user_swpb_asm(data, address);
 		else
-			__user_swp_asm(*data, address, res, temp, temp2);
+			res = __user_swp_asm(data, address);
 
 		if (likely(res != -EAGAIN) || signal_pending(current))
 			break;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


