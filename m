Return-Path: <linux-kselftest+bounces-44888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B08C39DCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 10:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2291A22C5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FBF30F553;
	Thu,  6 Nov 2025 09:40:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A476830F7E9;
	Thu,  6 Nov 2025 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422052; cv=none; b=kPXXsJ6IJAErGZYEgMBENnOD80KIcRV+wI9WVdsfSQD44dCJD4NBPsWLF1guI5lMcVtm5JO4Pngd+F5vlcM4dVcHXDXVVu2bGWp6YwHI//u14HxhePe6XITAae9/SLEXXKys4usltLqf9/IT3Y4kuPbSqCIr3LKgjsAa7atoUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422052; c=relaxed/simple;
	bh=VcdHHE8qIFEDm3Jx62mXZy7a37LsN76hFM7QgjbV5o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHTWojfSEa+NhSQB+7Rkpc0N5C5QTW6/13mrxPEJZKiM4fP/hKMHoV6Lwx2an8f/1UzEYhRhXgsynD4nTBwMaxmc8NRSIIw8XZcded8o3l4pP0O3eog1NWJqb0Fv/etLjGxH8n+joPnKRqMxQVedcBPTiXKncxQh7jW59BXmppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E7901596;
	Thu,  6 Nov 2025 01:40:42 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2466D3F63F;
	Thu,  6 Nov 2025 01:40:47 -0800 (PST)
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
Subject: [PATCH v11 6/9] arm64: futex: support futex with FEAT_LSUI
Date: Thu,  6 Nov 2025 09:40:20 +0000
Message-Id: <20251106094023.1371246-7-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106094023.1371246-1-yeoreum.yun@arm.com>
References: <20251106094023.1371246-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current futex atomic operations are implemented with ll/sc instructions
and clearing PSTATE.PAN.

Since Armv9.6, FEAT_LSUI supplies not only load/store instructions but
also atomic operation for user memory access in kernel it doesn't need
to clear PSTATE.PAN bit anymore.

With theses instructions some of futex atomic operations don't need to
be implmented with ldxr/stlxr pair instead can be implmented with
one atomic operation supplied by FEAT_LSUI.

However, some of futex atomic operation don't have matched
instructuion i.e) eor or cmpxchg with word size.
For those operation, uses cas{al}t to implement them.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/futex.h | 180 ++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index f8cb674bdb3f..6778ff7e1c0e 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -9,6 +9,8 @@
 #include <linux/uaccess.h>
 #include <linux/stringify.h>
 
+#include <asm/alternative.h>
+#include <asm/alternative-macros.h>
 #include <asm/errno.h>
 
 #define FUTEX_MAX_LOOPS	128 /* What's the largest number you can think of? */
@@ -86,11 +88,185 @@ __llsc_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
 	return ret;
 }
 
+#ifdef CONFIG_AS_HAS_LSUI
+
+/*
+ * When the LSUI feature is present, the CPU also implements PAN, because
+ * FEAT_PAN has been mandatory since Armv8.1. Therefore, there is no need to
+ * call uaccess_ttbr0_enable()/uaccess_ttbr0_disable() around each LSUI
+ * operation.
+ */
+
+#define __LSUI_PREAMBLE	".arch_extension lsui\n"
+
+#define LSUI_FUTEX_ATOMIC_OP(op, asm_op, mb)				\
+static __always_inline int						\
+__lsui_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
+{									\
+	int ret = 0;							\
+	int oldval;							\
+									\
+	asm volatile("// __lsui_futex_atomic_" #op "\n"			\
+	__LSUI_PREAMBLE							\
+"1:	" #asm_op #mb "	%w3, %w2, %1\n"					\
+"2:\n"									\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)				\
+	: "+r" (ret), "+Q" (*uaddr), "=r" (oldval)			\
+	: "r" (oparg)							\
+	: "memory");							\
+									\
+	if (!ret)							\
+		*oval = oldval;						\
+									\
+	return ret;							\
+}
+
+LSUI_FUTEX_ATOMIC_OP(add, ldtadd, al)
+LSUI_FUTEX_ATOMIC_OP(or, ldtset, al)
+LSUI_FUTEX_ATOMIC_OP(andnot, ldtclr, al)
+LSUI_FUTEX_ATOMIC_OP(set, swpt, al)
+
+static __always_inline int
+__lsui_cmpxchg64(u64 __user *uaddr, u64 *oldval, u64 newval)
+{
+	int ret = 0;
+
+	asm volatile("// __lsui_cmpxchg64\n"
+	__LSUI_PREAMBLE
+"1:	casalt	%x2, %x3, %1\n"
+"2:\n"
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
+	: "+r" (ret), "+Q" (*uaddr), "+r" (*oldval)
+	: "r" (newval)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline int
+__lsui_cmpxchg32(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
+{
+	u64 __user *uaddr64;
+	bool futex_on_lo;
+	int ret = -EAGAIN, i;
+	u32 other, orig_other;
+	union {
+		struct futex_on_lo {
+			u32 val;
+			u32 other;
+		} lo_futex;
+
+		struct futex_on_hi {
+			u32 other;
+			u32 val;
+		} hi_futex;
+
+		u64 raw;
+	} oval64, orig64, nval64;
+
+	uaddr64 = (u64 __user *) PTR_ALIGN_DOWN(uaddr, sizeof(u64));
+	futex_on_lo = (IS_ALIGNED((unsigned long)uaddr, sizeof(u64)) ==
+			IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN));
+
+	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
+		if (get_user(oval64.raw, uaddr64))
+			return -EFAULT;
+
+		nval64.raw = oval64.raw;
+
+		if (futex_on_lo) {
+			oval64.lo_futex.val = oldval;
+			nval64.lo_futex.val = newval;
+		} else {
+			oval64.hi_futex.val = oldval;
+			nval64.hi_futex.val = newval;
+		}
+
+		orig64.raw = oval64.raw;
+
+		if (__lsui_cmpxchg64(uaddr64, &oval64.raw, nval64.raw))
+			return -EFAULT;
+
+		if (futex_on_lo) {
+			oldval = oval64.lo_futex.val;
+			other = oval64.lo_futex.other;
+			orig_other = orig64.lo_futex.other;
+		} else {
+			oldval = oval64.hi_futex.val;
+			other = oval64.hi_futex.other;
+			orig_other = orig64.hi_futex.other;
+		}
+
+		if (other == orig_other) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+static __always_inline int
+__lsui_futex_atomic_and(int oparg, u32 __user *uaddr, int *oval)
+{
+	return __lsui_futex_atomic_andnot(~oparg, uaddr, oval);
+}
+
+static __always_inline int
+__lsui_futex_atomic_eor(int oparg, u32 __user *uaddr, int *oval)
+{
+	u32 oldval, newval, val;
+	int ret, i;
+
+	/*
+	 * there are no ldteor/stteor instructions...
+	 */
+	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
+		if (get_user(oldval, uaddr))
+			return -EFAULT;
+
+		newval = oldval ^ oparg;
+
+		ret = __lsui_cmpxchg32(uaddr, oldval, newval, &val);
+		if (ret)
+			return ret;
+
+		if (val == oldval) {
+			*oval = val;
+			return 0;
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static __always_inline int
+__lsui_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
+{
+	return __lsui_cmpxchg32(uaddr, oldval, newval, oval);
+}
+
+#define __lsui_llsc_body(op, ...)					\
+({									\
+	alternative_has_cap_likely(ARM64_HAS_LSUI) ?			\
+		__lsui_##op(__VA_ARGS__) : __llsc_##op(__VA_ARGS__);	\
+})
+
+#else	/* CONFIG_AS_HAS_LSUI */
+
+#define __lsui_llsc_body(op, ...)	__llsc_##op(__VA_ARGS__)
+
+#endif	/* CONFIG_AS_HAS_LSUI */
+
+
 #define FUTEX_ATOMIC_OP(op)						\
 static __always_inline int						\
 __futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)		\
 {									\
-	return __llsc_futex_atomic_##op(oparg, uaddr, oval);		\
+	return __lsui_llsc_body(futex_atomic_##op, oparg, uaddr, oval);	\
 }
 
 FUTEX_ATOMIC_OP(add)
@@ -102,7 +278,7 @@ FUTEX_ATOMIC_OP(set)
 static __always_inline int
 __futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
 {
-	return __llsc_futex_cmpxchg(uaddr, oldval, newval, oval);
+	return __lsui_llsc_body(futex_cmpxchg, uaddr, oldval, newval, oval);
 }
 
 static inline int
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


