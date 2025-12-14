Return-Path: <linux-kselftest+bounces-47562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A4CBBA2B
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AC823009130
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86931328C;
	Sun, 14 Dec 2025 11:23:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47D31352F;
	Sun, 14 Dec 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765711406; cv=none; b=JkR0alh9+Lc7VIGTmHeQlIz6E8RxkhZpVQvsF24nLYQWTXyNAKXkmX+kpmD8BmqHov/2SJajICF5KHFZs2eGiVv0+F2PStvY+ryVPDChVPh6dC/1M+lbeyAu3JA8DaP0b72UBk8+k03kixgqqaNY6X6u9BNrzqfaJ/xD6cQ15Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765711406; c=relaxed/simple;
	bh=hXU4t5YjJaGXP2q/pO0mUAmLwXiHYHec7qgGD3z5DR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWyGyv5oNxT5FgjLtqpoAqG2HSySui+5cOdNjwkoHvvuTUwd5zj/FRX34GD8KHSSO+bI4WjSoVOu9ZZYfBfZnw04mISWbAENefHfW8g/BW4x8JqZyWoK7lNl8WPWTQi8DiSposjChHJ/liXADdZJ3Le7TBKNmvUe6oQLDcvkWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0D471655;
	Sun, 14 Dec 2025 03:23:16 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 974603F73B;
	Sun, 14 Dec 2025 03:23:20 -0800 (PST)
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
	mark.rutland@arm.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v11 RESEND 8/9] arm64: armv8_deprecated: convert user_swpX to inline function
Date: Sun, 14 Dec 2025 11:22:47 +0000
Message-Id: <20251214112248.901769-9-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251214112248.901769-1-yeoreum.yun@arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
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


