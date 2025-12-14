Return-Path: <linux-kselftest+bounces-47563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B05CBBA32
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 12:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5033300A73A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C731329C;
	Sun, 14 Dec 2025 11:23:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5A313273;
	Sun, 14 Dec 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765711409; cv=none; b=lW28k9okXe0Gv7cGk1/iCoOPHrKK60Go3tef5t0GMOHTgJt2cYjJuVVMYt+po+CsZUAlPIazhQlMSI+Uvc1qQrtNpwZeAIcbf05n+beRvcrFoySA6jofEUPequ/PrCEWxs6MX0929jOlVzmEas8v9uxTdRphuKTVZZzvz4QLzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765711409; c=relaxed/simple;
	bh=lhB4tUhCCDLZA6yBYgCDqTgP+a9jFwXX5PcOcj+pjRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1vGmC877EQ6xs+AYM1EiY1oycpDW+8Ma03bWCunzXuBcuhxWMUmE51gtUjomb7WuKNvyun5u8NdIkzIZMYcWKGyI61mPUkMzoS1eEyZkqxa1fz7g4fXf54COp2+ELVFQkvN6IxKWr8YnP6OKoqScwmrqEpjPluZ1kiTOlY0viM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B1B16F3;
	Sun, 14 Dec 2025 03:23:20 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31B933F73B;
	Sun, 14 Dec 2025 03:23:24 -0800 (PST)
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
Subject: [PATCH v11 RESEND 9/9] arm64: armv8_deprecated: apply FEAT_LSUI for swpX emulation.
Date: Sun, 14 Dec 2025 11:22:48 +0000
Message-Id: <20251214112248.901769-10-yeoreum.yun@arm.com>
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

Apply the FEAT_LSUI instruction to emulate the deprecated swpX
instruction, so that toggling of the PSTATE.PAN bit can be removed when
LSUI-related instructions are used.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 77 +++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index d15e35f1075c..b8e6d71f766d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -13,6 +13,7 @@
 #include <linux/uaccess.h>

 #include <asm/cpufeature.h>
+#include <asm/lsui.h>
 #include <asm/insn.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
@@ -86,13 +87,77 @@ static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
  *	   Rn  = address
  */

+/* Arbitrary constant to ensure forward-progress of the loop */
+#define __SWP_LOOPS	4
+
+#ifdef CONFIG_AS_HAS_LSUI
+static __always_inline int
+__lsui_user_swp_asm(unsigned int *data, unsigned int addr)
+{
+	int err = 0;
+	unsigned int temp;
+
+	asm volatile("// __lsui_user_swp_asm\n"
+	__LSUI_PREAMBLE
+	"1:	swpt		%w1, %w2, [%3]\n"
+	"	mov		%w1, %w2\n"
+	"2:\n"
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
+	: "+r" (err), "+r" (*data), "=&r" (temp)
+	: "r" ((unsigned long)addr)
+	: "memory");
+
+	return err;
+}
+
+static __always_inline int
+__lsui_user_swpb_asm(unsigned int *data, unsigned int addr)
+{
+	u8 i, idx;
+	int err = -EAGAIN;
+	u64 __user *addr_al;
+	u64 oldval;
+	union {
+		u64 var;
+		u8 raw[sizeof(u64)];
+	} newval, curval;
+
+	idx = addr & (sizeof(u64) - 1);
+	addr_al = (u64 __user *)ALIGN_DOWN(addr, sizeof(u64));
+
+	for (i = 0; i < __SWP_LOOPS; i++) {
+		if (get_user(oldval, addr_al))
+			return -EFAULT;
+
+		curval.var = newval.var = oldval;
+		newval.raw[idx] = *data;
+
+		asm volatile("// __lsui_user_swpb_asm\n"
+		__LSUI_PREAMBLE
+		"1: cast	%x2, %x3, %1\n"
+		"2:\n"
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
+		: "+r" (err), "+Q" (*addr_al), "+r" (curval.var)
+		: "r" (newval.var)
+		: "memory");
+
+		if (curval.var == oldval) {
+			err = 0;
+			break;
+		}
+	}
+
+	if (!err)
+		*data = curval.raw[idx];
+
+	return err;
+}
+#endif /* CONFIG_AS_HAS_LSUI */
+
 /*
  * Error-checking SWP macros implemented using ldxr{b}/stxr{b}
  */

-/* Arbitrary constant to ensure forward-progress of the LL/SC loop */
-#define __SWP_LL_SC_LOOPS	4
-
 #define LLSC_USER_SWPX(B)					\
 static __always_inline int					\
 __llsc_user_swp##B##_asm(unsigned int *data, unsigned int addr)	\
@@ -117,7 +182,7 @@ __llsc_user_swp##B##_asm(unsigned int *data, unsigned int addr)	\
 	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w0)			\
 	: "=&r" (err), "+r" (*data), "=&r" (temp), "=&r" (temp2)\
 	: "r" ((unsigned long)addr), "i" (-EAGAIN),		\
-	  "i" (__SWP_LL_SC_LOOPS)				\
+	  "i" (__SWP_LOOPS)					\
 	: "memory");						\
 	uaccess_disable_privileged();				\
 								\
@@ -128,9 +193,9 @@ LLSC_USER_SWPX()
 LLSC_USER_SWPX(b)

 #define __user_swp_asm(data, addr) \
-	__llsc_user_swp_asm(data, addr)
+	__lsui_llsc_body(user_swp_asm, data, addr)
 #define __user_swpb_asm(data, addr) \
-	__llsc_user_swpb_asm(data, addr)
+	__lsui_llsc_body(user_swpb_asm, data, addr)

 /*
  * Bit 22 of the instruction encoding distinguishes between
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


