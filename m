Return-Path: <linux-kselftest+bounces-44666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698E5C2D3F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F28A4602D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18665320CAD;
	Mon,  3 Nov 2025 16:33:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F232145A;
	Mon,  3 Nov 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187583; cv=none; b=HhePu20hAiLTcmGxSSD9NS8N5Q+W0XK5MZq+f632xLK5dkFOyuHtmkHeVVcGBP63AqbX4QygxOnz3eVe1mbOHSK/CX36/pAnDY84ZoHrlhpqsYKyFH0HQcK0IU5sltOWQhlPR3pJdhTqQkdQlX7Kailitq1jl3LHKbcGNBZpiJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187583; c=relaxed/simple;
	bh=zJ5r0/FG6kKD8kk4wmybeuLbTqD9YANOS+HOgk1St4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/i0FxzdvJ522Dz7pvCeWVcFKQb2t+XjvvgJXFynZ18qxxg2jF6Jt4gVSj12uOrQkdwvSV7OTNO9p8mpLq+X5VQIpIkDy1M6d5zGIvsPP5B1dEQT8A7GcLOkVtHZkikaG52J/X/KtFKG5064i2We34Q5VyJDVRm/gRoc9oMcvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 120663161;
	Mon,  3 Nov 2025 08:32:53 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ABC853F694;
	Mon,  3 Nov 2025 08:32:57 -0800 (PST)
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
Subject: [PATCH v10 9/9] arm64: armv8_deprecated: apply FEAT_LSUI for swpX emulation.
Date: Mon,  3 Nov 2025 16:32:24 +0000
Message-Id: <20251103163224.818353-10-yeoreum.yun@arm.com>
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

apply FEAT_LSUI instruction to emulate deprecated swpX instruction.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 52 ++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index d15e35f1075c..424cf51d554f 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -13,6 +13,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/cpufeature.h>
+#include <asm/lsui.h>
 #include <asm/insn.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
@@ -86,6 +87,53 @@ static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
  *	   Rn  = address
  */
 
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
+	unsigned char idx;
+	int err;
+	unsigned int addr_al;
+	union {
+		unsigned int var;
+		unsigned char raw[4];
+	} data_al;
+
+	idx = addr & (sizeof(unsigned int) - 1);
+	addr_al = ALIGN_DOWN(addr, sizeof(unsigned int));
+
+	if (get_user(data_al.var, (unsigned int *)(unsigned long)addr_al))
+		return -EFAULT;
+
+	data_al.raw[idx] = *data;
+
+	err = __lsui_user_swp_asm(&data_al.var, addr_al);
+	if (!err)
+		*data = data_al.raw[idx];
+
+	return err;
+}
+#endif /* CONFIG_AS_HAS_LSUI */
+
 /*
  * Error-checking SWP macros implemented using ldxr{b}/stxr{b}
  */
@@ -128,9 +176,9 @@ LLSC_USER_SWPX()
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


