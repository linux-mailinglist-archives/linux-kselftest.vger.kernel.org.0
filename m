Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6945B764886
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjG0HZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjG0HYO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:24:14 -0400
Received: from mgamail.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF4A4C06;
        Thu, 27 Jul 2023 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690442123; x=1721978123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7h/0hZf3xsYJlE3BBdTFYysxnJ4Nt8eEM/a5WpIe31M=;
  b=f0ba+1RChqanRT31ZkJXoUTYvK1CdgLpujhtBuPzM0zzKylf/fGPeAsM
   LtaYCwo7jF5ljPb0bCGhZAFt3sqXwUKdt8v1ubI4JTldk3Wc/RHXdcKHL
   NFElvih2WHSsI1wNxS86qu0Ll3FYTxV+DjVlq5hSaFdTIG2vw1IVWhv3I
   C5wUpBHRMGT/dNYsGzZgbHyDOYTcVSW69OT+0142f8JoTYBJxP6oA3Lp6
   sV23jpREDIsqV6x+eQznIE8Hq8bDPCNjscyaUsLG5vNJNlhdkZSaYbppD
   aDq0j7txko4u9CuimqSZIfKOa61k+F/XmI3/oPp/+yFb2xxFB4YwGsn/M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367102109"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367102109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720785811"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="720785811"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:19 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 1/4] tools: riscv: Add header file csr.h
Date:   Thu, 27 Jul 2023 15:20:05 +0800
Message-Id: <35ce2b9f7ca655eb3af13730b1ca9f05b518e08f.1690364259.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690364259.git.haibo1.xu@intel.com>
References: <cover.1690364259.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Borrow some of the csr definitions and operations from kernel's
arch/riscv/include/asm/csr.h to tools/ for riscv.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/arch/riscv/include/asm/csr.h | 127 +++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 tools/arch/riscv/include/asm/csr.h

diff --git a/tools/arch/riscv/include/asm/csr.h b/tools/arch/riscv/include/asm/csr.h
new file mode 100644
index 000000000000..b437e6438216
--- /dev/null
+++ b/tools/arch/riscv/include/asm/csr.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ * Copyright (c) 2023, Intel Corporation.
+ */
+
+#ifndef _ASM_RISCV_CSR_H
+#define _ASM_RISCV_CSR_H
+
+#ifdef __ASSEMBLY__
+#define __ASM_STR(x)    x
+#else
+#define __ASM_STR(x)    #x
+#endif
+
+/* Status register flags */
+#define SR_SIE		_AC(0x00000002, UL) /* Supervisor Interrupt Enable */
+#define SR_SPIE		_AC(0x00000020, UL) /* Previous Supervisor IE */
+#define SR_SPP		_AC(0x00000100, UL) /* Previously Supervisor */
+#define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
+
+#define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
+#define SR_FS_OFF	_AC(0x00000000, UL)
+#define SR_FS_INITIAL	_AC(0x00002000, UL)
+#define SR_FS_CLEAN	_AC(0x00004000, UL)
+#define SR_FS_DIRTY	_AC(0x00006000, UL)
+
+#define SR_XS		_AC(0x00018000, UL) /* Extension Status */
+#define SR_XS_OFF	_AC(0x00000000, UL)
+#define SR_XS_INITIAL	_AC(0x00008000, UL)
+#define SR_XS_CLEAN	_AC(0x00010000, UL)
+#define SR_XS_DIRTY	_AC(0x00018000, UL)
+
+#define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
+
+#define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
+#define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
+#define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
+
+/* Exception cause high bit - is an interrupt if set */
+#define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
+
+/* Interrupt causes (minus the high bit) */
+#define IRQ_S_SOFT		1
+#define IRQ_S_TIMER		5
+#define IRQ_S_EXT		9
+
+/* Exception causes */
+#define EXC_INST_MISALIGNED	0
+#define EXC_INST_ACCESS		1
+#define EXC_INST_ILLEGAL	2
+#define EXC_BREAKPOINT		3
+#define EXC_LOAD_ACCESS		5
+#define EXC_STORE_ACCESS	7
+#define EXC_SYSCALL		8
+#define EXC_HYPERVISOR_SYSCALL	9
+#define EXC_SUPERVISOR_SYSCALL	10
+#define EXC_INST_PAGE_FAULT	12
+#define EXC_LOAD_PAGE_FAULT	13
+#define EXC_STORE_PAGE_FAULT	15
+#define EXC_INST_GUEST_PAGE_FAULT	20
+#define EXC_LOAD_GUEST_PAGE_FAULT	21
+#define EXC_VIRTUAL_INST_FAULT		22
+#define EXC_STORE_GUEST_PAGE_FAULT	23
+
+/* symbolic CSR names: */
+#define CSR_CYCLE		0xc00
+#define CSR_TIME		0xc01
+#define CSR_INSTRET		0xc02
+
+#define CSR_SSTATUS		0x100
+#define CSR_SIE			0x104
+#define CSR_STVEC		0x105
+#define CSR_SCOUNTEREN		0x106
+#define CSR_SSCRATCH		0x140
+#define CSR_SEPC		0x141
+#define CSR_SCAUSE		0x142
+#define CSR_STVAL		0x143
+#define CSR_SIP			0x144
+#define CSR_SATP		0x180
+
+#define CSR_STIMECMP		0x14D
+#define CSR_STIMECMPH		0x15D
+
+/* IE/IP (Supervisor Interrupt Enable/Pending) flags */
+#define IE_SIE		(_AC(0x1, UL) << IRQ_S_SOFT)
+#define IE_TIE		(_AC(0x1, UL) << IRQ_S_TIMER)
+#define IE_EIE		(_AC(0x1, UL) << IRQ_S_EXT)
+
+#ifndef __ASSEMBLY__
+
+#define csr_read(csr)						\
+({								\
+	register unsigned long __v;				\
+	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
+			      : "=r" (__v) :			\
+			      : "memory");			\
+	__v;							\
+})
+
+#define csr_write(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
+			      : : "rK" (__v)			\
+			      : "memory");			\
+})
+
+#define csr_set(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrs " __ASM_STR(csr) ", %0"	\
+			      : : "rK" (__v)			\
+			      : "memory");			\
+})
+
+#define csr_clear(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrc " __ASM_STR(csr) ", %0"	\
+			      : : "rK" (__v)			\
+			      : "memory");			\
+})
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_CSR_H */
-- 
2.34.1

