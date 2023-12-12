Return-Path: <linux-kselftest+bounces-1656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B984D80E755
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 10:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB731F21D7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099A584C5;
	Tue, 12 Dec 2023 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7z9RbHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27982EB;
	Tue, 12 Dec 2023 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372828; x=1733908828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3eiUKT+cKcrQtCN2MDItspu7jMjjWkhuuJpCpoi/JE=;
  b=n7z9RbHlWpmX++R9/nW5SMu7v+8qm4da5teoR+PR7e64kfu2uSMC1eRq
   BayggVD3GGnQeQJ3lWFU69Lsjxr5/+D0YQ39ZtaMhB1FB7e0rGmKYyNCS
   OOvIvi8l4RyRvBtrP4DoHD/dDXWRMiCDDoMrV7k0DVWVwvnsvFfezVAK9
   ldFQ2yDqtZIZx2Kv5WDUhEHpjaHhRtxkn00EKXpMW5KO97xwPC1odQbQe
   ObpMVJ7pgQN22o4btQRtpbOGsNR41JRKk14TZ5YQssu6R4iydjRL1kqgf
   3aQzUOToBOuWGbzMeG97IB2XL0TL5wcPc5dChpufzLEzTql94X0XRvT11
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974301"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917213010"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917213010"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:20:20 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	haibo1.xu@intel.com,
	ajones@ventanamicro.com,
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
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Like Xu <likexu@tencent.com>,
	Vipin Sharma <vipinsh@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Thomas Huth <thuth@redhat.com>,
	Aaron Lewis <aaronlewis@google.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v4 05/11] tools: riscv: Add header file vdso/processor.h
Date: Tue, 12 Dec 2023 17:31:14 +0800
Message-Id: <7b633cc441f5133608597463301fef122f5174d3.1702371136.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702371136.git.haibo1.xu@intel.com>
References: <cover.1702371136.git.haibo1.xu@intel.com>
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


