Return-Path: <linux-kselftest+bounces-3304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED7835E87
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0FE1C20932
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FC3A1B0;
	Mon, 22 Jan 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuWFVtWJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F23A28B;
	Mon, 22 Jan 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916823; cv=none; b=brdYjUrH8Ajn48kujKyqfCJ2iVVjTGVXCVHcYnoKRK0cSBiqwEgiccedGLZw49uXqEuaDdKMo5gL9mcquUyVqGd/g6HGHnjke2MBfAPf+zDSpfE2M/2PmDat+dTq5kubyeCX6iimDTWdWaexJsUrlMLPmIalW6/njhcDuRiQWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916823; c=relaxed/simple;
	bh=XjbRb6KLhs3MMD3Cdz5D4prMhpH/m5EAMfKa/Xyq4Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z70yQoQmq8/7ZKs0DfsHPG8gmPUrhAe2CuOmoD/HIekWTrs68v+DzN2WafY5i23rpYG56DVKhT/k90ULXMYst7tae242rnPx40mTgq3piio4li0B5eLaET4ou6NSqHWmOYrF7y5lwErj/J0pVLRpcWD4kG7F1Fe2A9c82gWoMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuWFVtWJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705916822; x=1737452822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XjbRb6KLhs3MMD3Cdz5D4prMhpH/m5EAMfKa/Xyq4Ak=;
  b=fuWFVtWJjp0hxeOF7qSKNxZysDfToApMIx+fEJ1283vIBi0xnqf4/Wfp
   dIiTDTmys8IhILgmlfl6qBZyAYrt14R7vP4sK7f0CEcsFF1t69rF1LKQs
   lehPR3bMmc5aEaCgTXwZ7X5J3eo5OvXFdSRh2WIFPJAjBgvMgYQQXDSbi
   Hk9IxmmpGbV6aW4A0Q7EIRn+RJZFlLxGaaK3VY3HUet+2UX48L5LDZvxZ
   f039jDtBpJT/O8I6pyZYIGjPJfh/rI1rEylPEV4vhFduEGgf800BfaDUt
   NKPfKBYscioNOrgAlh0zIxuVPbljLre89+zYEuL8vq2NWB0qTk4LvHzO2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22641852"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22641852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778535468"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778535468"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:46:52 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Guo Ren <guoren@kernel.org>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Like Xu <likexu@tencent.com>,
	Peter Xu <peterx@redhat.com>,
	Vipin Sharma <vipinsh@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v5 07/12] tools: riscv: Add header file vdso/processor.h
Date: Mon, 22 Jan 2024 17:58:37 +0800
Message-Id: <212d0d848e54c887944ec38bd9f9729df8d1a27f.1705916069.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705916069.git.haibo1.xu@intel.com>
References: <cover.1705916069.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Borrow the cpu_relax() definitions from kernel's
arch/riscv/include/asm/vdso/processor.h to tools/ for riscv.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/arch/riscv/include/asm/vdso/processor.h | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/arch/riscv/include/asm/vdso/processor.h

diff --git a/tools/arch/riscv/include/asm/vdso/processor.h b/tools/arch/riscv/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..662aca039848
--- /dev/null
+++ b/tools/arch/riscv/include/asm/vdso/processor.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm-generic/barrier.h>
+
+static inline void cpu_relax(void)
+{
+#ifdef __riscv_muldiv
+	int dummy;
+	/* In lieu of a halt instruction, induce a long-latency stall. */
+	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
+#endif
+
+#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
+	/*
+	 * Reduce instruction retirement.
+	 * This assumes the PC changes.
+	 */
+	__asm__ __volatile__ ("pause");
+#else
+	/* Encoding of the pause instruction */
+	__asm__ __volatile__ (".4byte 0x100000F");
+#endif
+	barrier();
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
-- 
2.34.1


