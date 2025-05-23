Return-Path: <linux-kselftest+bounces-33709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C181AC2C40
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35201C06DCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAF217701;
	Fri, 23 May 2025 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/jgdd7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10121E0B7
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043051; cv=none; b=bDrqSMBGf5sJuNuBVLC2Mp7Ocg6Mg4auhOkhCHwLjOeHI88NHWm08ObHP2bDJBv6CcgCbl/VkBCtKl0o69CfekDz/5izvTovDjW5yiXjcf92g31QjG3k/i+R9Yp9+QOn9ta5MkeQ+HoOnz5N0pQ19xrPTGmhzNh3qMlse5xtLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043051; c=relaxed/simple;
	bh=pfR5Ax4SlBdY1xv8/Ocrr2ZX/YysW0uHrkkhEqsptWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qaSxNrwQd1NER8Kw3La/Q9vZvtVYkf9hSmXh7JcpoNG/8oU8NjIvbnZ77CrJXbHUMLEQa6ueOtmYvFhmg3LMgBTBQSVlslgZpWT8HZC+AXlPeZXTwzd1a6QniG7LfUFpD/KjdidnA48Yuhqdvd+QeouC1Twn0dd0EXoGix5RcEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/jgdd7g; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e9338430eso275474a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043049; x=1748647849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5uvmx1jOCCOOD7uCtAHcBHBFBslsVYIy8nOh66YmN4=;
        b=J/jgdd7gXDUI3EmCZ/5tKrf8GKZlt0T0oLxzXU+N+FXCwxgKQ2cSbXuOiLvBavxAgb
         UBLi+WeJe75M+l0acsHErFsMcuBY4mepG6Eg0CgNTb9i+Prgmyf7+ZQH6VXs6xcX84AT
         C/nB0yjCh0Ej2EOgH1+B4X/SMidJNHUr60Qpw5Kw41azElno0j2dHyDpKr0f/A190ECN
         GoiEvEHW+Dfuvch2Po9Yqrh2ExJWkxU0bOpNhCUbp0fRLwEiU53IxaM+ZsWFCGtdNN6a
         LGxXtbsqpKYidElmmhhCCV9tjpUuHFu2PVg1fLtVDg7aIVPwqynPFKQS5nadNy3MDOjw
         4m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043049; x=1748647849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5uvmx1jOCCOOD7uCtAHcBHBFBslsVYIy8nOh66YmN4=;
        b=WPkMFi0igx030qb5kh+umUBvLtHevj53qXcsYJF9M6L37rI/GKYBzesXJ2jyWBN3/k
         JajorxfzVbhZsC16ThWZMXrF8NhazdRrdv4CApwCM8LxNTbO1AMJPjcaCTVEWqyd+kL9
         UVsVm5zQO8iETsMeb5SoIvm/xVOcgPiweBaExpjvEQGrw7yCPzngdqigFJBWSTEq9TEN
         9unCEa6uFOl4o1nagPWZoaA342ZcnfLu/IZeDIQPuycyYkySJap5ASExbs7ujm74bG+e
         oMCgUsGUgShzaSCWAN4js02f7QL/dZ7APq5/ANDhzU1WUmRAwpuGqDJPoVFi6mJKDAAV
         EV5g==
X-Forwarded-Encrypted: i=1; AJvYcCUTsbEnI6+MDtG6+yaodgzm3dWX4LaCYgtwNSxspzLeg5WYnUwTie/IPOp5l7EEfpyTvda5QD/iBoQd/PzZCHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDQFt2l8tEsYgEdhzMSHof91RubZLWuGzOW9lpyQFnrlQr9p+
	qWcZJgHaoY5BSR/bl5w9Cm82Jo0RsgOtDzWZlzPGXeusYUlghVZL2O+n+xxx1I6ntEF0GA5zYjw
	tTIDYmChH5UAU7A==
X-Google-Smtp-Source: AGHT+IEE9DFbhmMXYaN/7MbPbRi/a73H7vVeGRag6AqCzXOsKH0OPrFkPjU5nIZ6jA+AvQhDlr6QlYxGh/nPKg==
X-Received: from pjbsr13.prod.google.com ([2002:a17:90b:4e8d:b0:301:a339:b558])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:554f:b0:310:eea1:1c1 with SMTP id 98e67ed59e1d1-311100db9cfmr1690348a91.16.1748043048946;
 Fri, 23 May 2025 16:30:48 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:58 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-14-dmatlack@google.com>
Subject: [RFC PATCH 13/33] tools headers: Import drivers/dma/ioat/{hw.h,registers.h}
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Import drivers/dma/ioat/{hw.h,registers.h} into tools/include/ so that
they can be used in VFIO selftests to interact with Intel CBDMA devices.

Changes made when importing:
 - Drop system_has_dca_enabled() prototype from hw.h

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/drivers/dma/ioat/hw.h        | 270 +++++++++++++++++++++
 tools/include/drivers/dma/ioat/registers.h | 251 +++++++++++++++++++
 2 files changed, 521 insertions(+)
 create mode 100644 tools/include/drivers/dma/ioat/hw.h
 create mode 100644 tools/include/drivers/dma/ioat/registers.h

diff --git a/tools/include/drivers/dma/ioat/hw.h b/tools/include/drivers/dma/ioat/hw.h
new file mode 100644
index 000000000000..62c7a6644376
--- /dev/null
+++ b/tools/include/drivers/dma/ioat/hw.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright(c) 2004 - 2009 Intel Corporation. All rights reserved.
+ */
+#ifndef _IOAT_HW_H_
+#define _IOAT_HW_H_
+
+#include <linux/types.h>
+
+/* PCI Configuration Space Values */
+#define IOAT_MMIO_BAR		0
+
+/* CB device ID's */
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB0	0x0e20
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB1	0x0e21
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB2	0x0e22
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB3	0x0e23
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB4	0x0e24
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB5	0x0e25
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB6	0x0e26
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB7	0x0e27
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB8	0x0e2e
+#define PCI_DEVICE_ID_INTEL_IOAT_IVB9	0x0e2f
+
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW0	0x2f20
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW1	0x2f21
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW2	0x2f22
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW3	0x2f23
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW4	0x2f24
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW5	0x2f25
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW6	0x2f26
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW7	0x2f27
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW8	0x2f2e
+#define PCI_DEVICE_ID_INTEL_IOAT_HSW9	0x2f2f
+
+#define PCI_DEVICE_ID_INTEL_IOAT_BWD0	0x0C50
+#define PCI_DEVICE_ID_INTEL_IOAT_BWD1	0x0C51
+#define PCI_DEVICE_ID_INTEL_IOAT_BWD2	0x0C52
+#define PCI_DEVICE_ID_INTEL_IOAT_BWD3	0x0C53
+
+#define PCI_DEVICE_ID_INTEL_IOAT_BDXDE0	0x6f50
+#define PCI_DEVICE_ID_INTEL_IOAT_BDXDE1	0x6f51
+#define PCI_DEVICE_ID_INTEL_IOAT_BDXDE2	0x6f52
+#define PCI_DEVICE_ID_INTEL_IOAT_BDXDE3	0x6f53
+
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX0	0x6f20
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX1	0x6f21
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX2	0x6f22
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX3	0x6f23
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX4	0x6f24
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX5	0x6f25
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX6	0x6f26
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX7	0x6f27
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX8	0x6f2e
+#define PCI_DEVICE_ID_INTEL_IOAT_BDX9	0x6f2f
+
+#define PCI_DEVICE_ID_INTEL_IOAT_SKX	0x2021
+
+#define PCI_DEVICE_ID_INTEL_IOAT_ICX	0x0b00
+
+#define IOAT_VER_1_2            0x12    /* Version 1.2 */
+#define IOAT_VER_2_0            0x20    /* Version 2.0 */
+#define IOAT_VER_3_0            0x30    /* Version 3.0 */
+#define IOAT_VER_3_2            0x32    /* Version 3.2 */
+#define IOAT_VER_3_3            0x33    /* Version 3.3 */
+#define IOAT_VER_3_4		0x34	/* Version 3.4 */
+
+#define IOAT_DESC_SZ	64
+
+struct ioat_dma_descriptor {
+	uint32_t	size;
+	union {
+		uint32_t ctl;
+		struct {
+			unsigned int int_en:1;
+			unsigned int src_snoop_dis:1;
+			unsigned int dest_snoop_dis:1;
+			unsigned int compl_write:1;
+			unsigned int fence:1;
+			unsigned int null:1;
+			unsigned int src_brk:1;
+			unsigned int dest_brk:1;
+			unsigned int bundle:1;
+			unsigned int dest_dca:1;
+			unsigned int hint:1;
+			unsigned int rsvd2:13;
+			#define IOAT_OP_COPY 0x00
+			unsigned int op:8;
+		} ctl_f;
+	};
+	uint64_t	src_addr;
+	uint64_t	dst_addr;
+	uint64_t	next;
+	uint64_t	rsv1;
+	uint64_t	rsv2;
+	/* store some driver data in an unused portion of the descriptor */
+	union {
+		uint64_t	user1;
+		uint64_t	tx_cnt;
+	};
+	uint64_t	user2;
+};
+
+struct ioat_xor_descriptor {
+	uint32_t	size;
+	union {
+		uint32_t ctl;
+		struct {
+			unsigned int int_en:1;
+			unsigned int src_snoop_dis:1;
+			unsigned int dest_snoop_dis:1;
+			unsigned int compl_write:1;
+			unsigned int fence:1;
+			unsigned int src_cnt:3;
+			unsigned int bundle:1;
+			unsigned int dest_dca:1;
+			unsigned int hint:1;
+			unsigned int rsvd:13;
+			#define IOAT_OP_XOR 0x87
+			#define IOAT_OP_XOR_VAL 0x88
+			unsigned int op:8;
+		} ctl_f;
+	};
+	uint64_t	src_addr;
+	uint64_t	dst_addr;
+	uint64_t	next;
+	uint64_t	src_addr2;
+	uint64_t	src_addr3;
+	uint64_t	src_addr4;
+	uint64_t	src_addr5;
+};
+
+struct ioat_xor_ext_descriptor {
+	uint64_t	src_addr6;
+	uint64_t	src_addr7;
+	uint64_t	src_addr8;
+	uint64_t	next;
+	uint64_t	rsvd[4];
+};
+
+struct ioat_pq_descriptor {
+	union {
+		uint32_t	size;
+		uint32_t	dwbes;
+		struct {
+			unsigned int rsvd:25;
+			unsigned int p_val_err:1;
+			unsigned int q_val_err:1;
+			unsigned int rsvd1:4;
+			unsigned int wbes:1;
+		} dwbes_f;
+	};
+	union {
+		uint32_t ctl;
+		struct {
+			unsigned int int_en:1;
+			unsigned int src_snoop_dis:1;
+			unsigned int dest_snoop_dis:1;
+			unsigned int compl_write:1;
+			unsigned int fence:1;
+			unsigned int src_cnt:3;
+			unsigned int bundle:1;
+			unsigned int dest_dca:1;
+			unsigned int hint:1;
+			unsigned int p_disable:1;
+			unsigned int q_disable:1;
+			unsigned int rsvd2:2;
+			unsigned int wb_en:1;
+			unsigned int prl_en:1;
+			unsigned int rsvd3:7;
+			#define IOAT_OP_PQ 0x89
+			#define IOAT_OP_PQ_VAL 0x8a
+			#define IOAT_OP_PQ_16S 0xa0
+			#define IOAT_OP_PQ_VAL_16S 0xa1
+			unsigned int op:8;
+		} ctl_f;
+	};
+	uint64_t	src_addr;
+	uint64_t	p_addr;
+	uint64_t	next;
+	uint64_t	src_addr2;
+	union {
+		uint64_t	src_addr3;
+		uint64_t	sed_addr;
+	};
+	uint8_t		coef[8];
+	uint64_t	q_addr;
+};
+
+struct ioat_pq_ext_descriptor {
+	uint64_t	src_addr4;
+	uint64_t	src_addr5;
+	uint64_t	src_addr6;
+	uint64_t	next;
+	uint64_t	src_addr7;
+	uint64_t	src_addr8;
+	uint64_t	rsvd[2];
+};
+
+struct ioat_pq_update_descriptor {
+	uint32_t	size;
+	union {
+		uint32_t ctl;
+		struct {
+			unsigned int int_en:1;
+			unsigned int src_snoop_dis:1;
+			unsigned int dest_snoop_dis:1;
+			unsigned int compl_write:1;
+			unsigned int fence:1;
+			unsigned int src_cnt:3;
+			unsigned int bundle:1;
+			unsigned int dest_dca:1;
+			unsigned int hint:1;
+			unsigned int p_disable:1;
+			unsigned int q_disable:1;
+			unsigned int rsvd:3;
+			unsigned int coef:8;
+			#define IOAT_OP_PQ_UP 0x8b
+			unsigned int op:8;
+		} ctl_f;
+	};
+	uint64_t	src_addr;
+	uint64_t	p_addr;
+	uint64_t	next;
+	uint64_t	src_addr2;
+	uint64_t	p_src;
+	uint64_t	q_src;
+	uint64_t	q_addr;
+};
+
+struct ioat_raw_descriptor {
+	uint64_t	field[8];
+};
+
+struct ioat_pq16a_descriptor {
+	uint8_t coef[8];
+	uint64_t src_addr3;
+	uint64_t src_addr4;
+	uint64_t src_addr5;
+	uint64_t src_addr6;
+	uint64_t src_addr7;
+	uint64_t src_addr8;
+	uint64_t src_addr9;
+};
+
+struct ioat_pq16b_descriptor {
+	uint64_t src_addr10;
+	uint64_t src_addr11;
+	uint64_t src_addr12;
+	uint64_t src_addr13;
+	uint64_t src_addr14;
+	uint64_t src_addr15;
+	uint64_t src_addr16;
+	uint64_t rsvd;
+};
+
+union ioat_sed_pq_descriptor {
+	struct ioat_pq16a_descriptor a;
+	struct ioat_pq16b_descriptor b;
+};
+
+#define SED_SIZE	64
+
+struct ioat_sed_raw_descriptor {
+	uint64_t	a[8];
+	uint64_t	b[8];
+	uint64_t	c[8];
+};
+
+#endif
diff --git a/tools/include/drivers/dma/ioat/registers.h b/tools/include/drivers/dma/ioat/registers.h
new file mode 100644
index 000000000000..54cf0ad39887
--- /dev/null
+++ b/tools/include/drivers/dma/ioat/registers.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright(c) 2004 - 2009 Intel Corporation. All rights reserved.
+ */
+#ifndef _IOAT_REGISTERS_H_
+#define _IOAT_REGISTERS_H_
+
+#define IOAT_PCI_DMACTRL_OFFSET			0x48
+#define IOAT_PCI_DMACTRL_DMA_EN			0x00000001
+#define IOAT_PCI_DMACTRL_MSI_EN			0x00000002
+
+#define IOAT_PCI_DEVICE_ID_OFFSET		0x02
+#define IOAT_PCI_DMAUNCERRSTS_OFFSET		0x148
+#define IOAT_PCI_CHANERR_INT_OFFSET		0x180
+#define IOAT_PCI_CHANERRMASK_INT_OFFSET		0x184
+
+/* MMIO Device Registers */
+#define IOAT_CHANCNT_OFFSET			0x00	/*  8-bit */
+
+#define IOAT_XFERCAP_OFFSET			0x01	/*  8-bit */
+#define IOAT_XFERCAP_4KB			12
+#define IOAT_XFERCAP_8KB			13
+#define IOAT_XFERCAP_16KB			14
+#define IOAT_XFERCAP_32KB			15
+#define IOAT_XFERCAP_32GB			0
+
+#define IOAT_GENCTRL_OFFSET			0x02	/*  8-bit */
+#define IOAT_GENCTRL_DEBUG_EN			0x01
+
+#define IOAT_INTRCTRL_OFFSET			0x03	/*  8-bit */
+#define IOAT_INTRCTRL_MASTER_INT_EN		0x01	/* Master Interrupt Enable */
+#define IOAT_INTRCTRL_INT_STATUS		0x02	/* ATTNSTATUS -or- Channel Int */
+#define IOAT_INTRCTRL_INT			0x04	/* INT_STATUS -and- MASTER_INT_EN */
+#define IOAT_INTRCTRL_MSIX_VECTOR_CONTROL	0x08	/* Enable all MSI-X vectors */
+
+#define IOAT_ATTNSTATUS_OFFSET			0x04	/* Each bit is a channel */
+
+#define IOAT_VER_OFFSET				0x08	/*  8-bit */
+#define IOAT_VER_MAJOR_MASK			0xF0
+#define IOAT_VER_MINOR_MASK			0x0F
+#define GET_IOAT_VER_MAJOR(x)			(((x) & IOAT_VER_MAJOR_MASK) >> 4)
+#define GET_IOAT_VER_MINOR(x)			((x) & IOAT_VER_MINOR_MASK)
+
+#define IOAT_PERPORTOFFSET_OFFSET		0x0A	/* 16-bit */
+
+#define IOAT_INTRDELAY_OFFSET			0x0C	/* 16-bit */
+#define IOAT_INTRDELAY_MASK			0x3FFF	/* Interrupt Delay Time */
+#define IOAT_INTRDELAY_COALESE_SUPPORT		0x8000	/* Interrupt Coalescing Supported */
+
+#define IOAT_DEVICE_STATUS_OFFSET		0x0E	/* 16-bit */
+#define IOAT_DEVICE_STATUS_DEGRADED_MODE	0x0001
+#define IOAT_DEVICE_MMIO_RESTRICTED		0x0002
+#define IOAT_DEVICE_MEMORY_BYPASS		0x0004
+#define IOAT_DEVICE_ADDRESS_REMAPPING		0x0008
+
+#define IOAT_DMA_CAP_OFFSET			0x10	/* 32-bit */
+#define IOAT_CAP_PAGE_BREAK			0x00000001
+#define IOAT_CAP_CRC				0x00000002
+#define IOAT_CAP_SKIP_MARKER			0x00000004
+#define IOAT_CAP_DCA				0x00000010
+#define IOAT_CAP_CRC_MOVE			0x00000020
+#define IOAT_CAP_FILL_BLOCK			0x00000040
+#define IOAT_CAP_APIC				0x00000080
+#define IOAT_CAP_XOR				0x00000100
+#define IOAT_CAP_PQ				0x00000200
+#define IOAT_CAP_DWBES				0x00002000
+#define IOAT_CAP_RAID16SS			0x00020000
+#define IOAT_CAP_DPS				0x00800000
+
+#define IOAT_PREFETCH_LIMIT_OFFSET		0x4C	/* CHWPREFLMT */
+
+#define IOAT_CHANNEL_MMIO_SIZE			0x80	/* Each Channel MMIO space is this size */
+
+/* DMA Channel Registers */
+#define IOAT_CHANCTRL_OFFSET			0x00	/* 16-bit Channel Control Register */
+#define IOAT_CHANCTRL_CHANNEL_PRIORITY_MASK	0xF000
+#define IOAT3_CHANCTRL_COMPL_DCA_EN		0x0200
+#define IOAT_CHANCTRL_CHANNEL_IN_USE		0x0100
+#define IOAT_CHANCTRL_DESCRIPTOR_ADDR_SNOOP_CONTROL	0x0020
+#define IOAT_CHANCTRL_ERR_INT_EN		0x0010
+#define IOAT_CHANCTRL_ANY_ERR_ABORT_EN		0x0008
+#define IOAT_CHANCTRL_ERR_COMPLETION_EN		0x0004
+#define IOAT_CHANCTRL_INT_REARM			0x0001
+#define IOAT_CHANCTRL_RUN			(IOAT_CHANCTRL_INT_REARM |\
+						 IOAT_CHANCTRL_ERR_INT_EN |\
+						 IOAT_CHANCTRL_ERR_COMPLETION_EN |\
+						 IOAT_CHANCTRL_ANY_ERR_ABORT_EN)
+
+#define IOAT_DMA_COMP_OFFSET			0x02	/* 16-bit DMA channel compatibility */
+#define IOAT_DMA_COMP_V1			0x0001	/* Compatibility with DMA version 1 */
+#define IOAT_DMA_COMP_V2			0x0002	/* Compatibility with DMA version 2 */
+
+#define IOAT_CHANSTS_OFFSET		0x08	/* 64-bit Channel Status Register */
+#define IOAT_CHANSTS_COMPLETED_DESCRIPTOR_ADDR	(~0x3fULL)
+#define IOAT_CHANSTS_SOFT_ERR			0x10ULL
+#define IOAT_CHANSTS_UNAFFILIATED_ERR		0x8ULL
+#define IOAT_CHANSTS_STATUS	0x7ULL
+#define IOAT_CHANSTS_ACTIVE	0x0
+#define IOAT_CHANSTS_DONE	0x1
+#define IOAT_CHANSTS_SUSPENDED	0x2
+#define IOAT_CHANSTS_HALTED	0x3
+
+
+
+#define IOAT_CHAN_DMACOUNT_OFFSET	0x06    /* 16-bit DMA Count register */
+
+#define IOAT_DCACTRL_OFFSET         0x30   /* 32 bit Direct Cache Access Control Register */
+#define IOAT_DCACTRL_CMPL_WRITE_ENABLE 0x10000
+#define IOAT_DCACTRL_TARGET_CPU_MASK   0xFFFF /* APIC ID */
+
+/* CB DCA Memory Space Registers */
+#define IOAT_DCAOFFSET_OFFSET       0x14
+/* CB_BAR + IOAT_DCAOFFSET value */
+#define IOAT_DCA_VER_OFFSET         0x00
+#define IOAT_DCA_VER_MAJOR_MASK     0xF0
+#define IOAT_DCA_VER_MINOR_MASK     0x0F
+
+#define IOAT_DCA_COMP_OFFSET        0x02
+#define IOAT_DCA_COMP_V1            0x1
+
+#define IOAT_FSB_CAPABILITY_OFFSET  0x04
+#define IOAT_FSB_CAPABILITY_PREFETCH    0x1
+
+#define IOAT_PCI_CAPABILITY_OFFSET  0x06
+#define IOAT_PCI_CAPABILITY_MEMWR   0x1
+
+#define IOAT_FSB_CAP_ENABLE_OFFSET  0x08
+#define IOAT_FSB_CAP_ENABLE_PREFETCH    0x1
+
+#define IOAT_PCI_CAP_ENABLE_OFFSET  0x0A
+#define IOAT_PCI_CAP_ENABLE_MEMWR   0x1
+
+#define IOAT_APICID_TAG_MAP_OFFSET  0x0C
+#define IOAT_APICID_TAG_MAP_TAG0    0x0000000F
+#define IOAT_APICID_TAG_MAP_TAG0_SHIFT 0
+#define IOAT_APICID_TAG_MAP_TAG1    0x000000F0
+#define IOAT_APICID_TAG_MAP_TAG1_SHIFT 4
+#define IOAT_APICID_TAG_MAP_TAG2    0x00000F00
+#define IOAT_APICID_TAG_MAP_TAG2_SHIFT 8
+#define IOAT_APICID_TAG_MAP_TAG3    0x0000F000
+#define IOAT_APICID_TAG_MAP_TAG3_SHIFT 12
+#define IOAT_APICID_TAG_MAP_TAG4    0x000F0000
+#define IOAT_APICID_TAG_MAP_TAG4_SHIFT 16
+#define IOAT_APICID_TAG_CB2_VALID   0x8080808080
+
+#define IOAT_DCA_GREQID_OFFSET      0x10
+#define IOAT_DCA_GREQID_SIZE        0x04
+#define IOAT_DCA_GREQID_MASK        0xFFFF
+#define IOAT_DCA_GREQID_IGNOREFUN   0x10000000
+#define IOAT_DCA_GREQID_VALID       0x20000000
+#define IOAT_DCA_GREQID_LASTID      0x80000000
+
+#define IOAT3_CSI_CAPABILITY_OFFSET 0x08
+#define IOAT3_CSI_CAPABILITY_PREFETCH    0x1
+
+#define IOAT3_PCI_CAPABILITY_OFFSET 0x0A
+#define IOAT3_PCI_CAPABILITY_MEMWR  0x1
+
+#define IOAT3_CSI_CONTROL_OFFSET    0x0C
+#define IOAT3_CSI_CONTROL_PREFETCH  0x1
+
+#define IOAT3_PCI_CONTROL_OFFSET    0x0E
+#define IOAT3_PCI_CONTROL_MEMWR     0x1
+
+#define IOAT3_APICID_TAG_MAP_OFFSET 0x10
+#define IOAT3_APICID_TAG_MAP_OFFSET_LOW  0x10
+#define IOAT3_APICID_TAG_MAP_OFFSET_HIGH 0x14
+
+#define IOAT3_DCA_GREQID_OFFSET     0x02
+
+#define IOAT1_CHAINADDR_OFFSET		0x0C	/* 64-bit Descriptor Chain Address Register */
+#define IOAT2_CHAINADDR_OFFSET		0x10	/* 64-bit Descriptor Chain Address Register */
+#define IOAT_CHAINADDR_OFFSET(ver)		((ver) < IOAT_VER_2_0 \
+						? IOAT1_CHAINADDR_OFFSET : IOAT2_CHAINADDR_OFFSET)
+#define IOAT1_CHAINADDR_OFFSET_LOW	0x0C
+#define IOAT2_CHAINADDR_OFFSET_LOW	0x10
+#define IOAT_CHAINADDR_OFFSET_LOW(ver)		((ver) < IOAT_VER_2_0 \
+						? IOAT1_CHAINADDR_OFFSET_LOW : IOAT2_CHAINADDR_OFFSET_LOW)
+#define IOAT1_CHAINADDR_OFFSET_HIGH	0x10
+#define IOAT2_CHAINADDR_OFFSET_HIGH	0x14
+#define IOAT_CHAINADDR_OFFSET_HIGH(ver)		((ver) < IOAT_VER_2_0 \
+						? IOAT1_CHAINADDR_OFFSET_HIGH : IOAT2_CHAINADDR_OFFSET_HIGH)
+
+#define IOAT1_CHANCMD_OFFSET		0x14	/*  8-bit DMA Channel Command Register */
+#define IOAT2_CHANCMD_OFFSET		0x04	/*  8-bit DMA Channel Command Register */
+#define IOAT_CHANCMD_OFFSET(ver)		((ver) < IOAT_VER_2_0 \
+						? IOAT1_CHANCMD_OFFSET : IOAT2_CHANCMD_OFFSET)
+#define IOAT_CHANCMD_RESET			0x20
+#define IOAT_CHANCMD_RESUME			0x10
+#define IOAT_CHANCMD_ABORT			0x08
+#define IOAT_CHANCMD_SUSPEND			0x04
+#define IOAT_CHANCMD_APPEND			0x02
+#define IOAT_CHANCMD_START			0x01
+
+#define IOAT_CHANCMP_OFFSET			0x18	/* 64-bit Channel Completion Address Register */
+#define IOAT_CHANCMP_OFFSET_LOW			0x18
+#define IOAT_CHANCMP_OFFSET_HIGH		0x1C
+
+#define IOAT_CDAR_OFFSET			0x20	/* 64-bit Current Descriptor Address Register */
+#define IOAT_CDAR_OFFSET_LOW			0x20
+#define IOAT_CDAR_OFFSET_HIGH			0x24
+
+#define IOAT_CHANERR_OFFSET			0x28	/* 32-bit Channel Error Register */
+#define IOAT_CHANERR_SRC_ADDR_ERR	0x0001
+#define IOAT_CHANERR_DEST_ADDR_ERR	0x0002
+#define IOAT_CHANERR_NEXT_ADDR_ERR	0x0004
+#define IOAT_CHANERR_NEXT_DESC_ALIGN_ERR	0x0008
+#define IOAT_CHANERR_CHAIN_ADDR_VALUE_ERR	0x0010
+#define IOAT_CHANERR_CHANCMD_ERR		0x0020
+#define IOAT_CHANERR_CHIPSET_UNCORRECTABLE_DATA_INTEGRITY_ERR	0x0040
+#define IOAT_CHANERR_DMA_UNCORRECTABLE_DATA_INTEGRITY_ERR	0x0080
+#define IOAT_CHANERR_READ_DATA_ERR		0x0100
+#define IOAT_CHANERR_WRITE_DATA_ERR		0x0200
+#define IOAT_CHANERR_CONTROL_ERR	0x0400
+#define IOAT_CHANERR_LENGTH_ERR	0x0800
+#define IOAT_CHANERR_COMPLETION_ADDR_ERR	0x1000
+#define IOAT_CHANERR_INT_CONFIGURATION_ERR	0x2000
+#define IOAT_CHANERR_SOFT_ERR			0x4000
+#define IOAT_CHANERR_UNAFFILIATED_ERR		0x8000
+#define IOAT_CHANERR_XOR_P_OR_CRC_ERR		0x10000
+#define IOAT_CHANERR_XOR_Q_ERR			0x20000
+#define IOAT_CHANERR_DESCRIPTOR_COUNT_ERR	0x40000
+
+#define IOAT_CHANERR_HANDLE_MASK (IOAT_CHANERR_XOR_P_OR_CRC_ERR | IOAT_CHANERR_XOR_Q_ERR)
+#define IOAT_CHANERR_RECOVER_MASK (IOAT_CHANERR_READ_DATA_ERR | \
+				   IOAT_CHANERR_WRITE_DATA_ERR)
+
+#define IOAT_CHANERR_MASK_OFFSET		0x2C	/* 32-bit Channel Error Register */
+
+#define IOAT_CHAN_DRSCTL_OFFSET			0xB6
+#define IOAT_CHAN_DRSZ_4KB			0x0000
+#define IOAT_CHAN_DRSZ_8KB			0x0001
+#define IOAT_CHAN_DRSZ_2MB			0x0009
+#define IOAT_CHAN_DRS_EN			0x0100
+#define IOAT_CHAN_DRS_AUTOWRAP			0x0200
+
+#define IOAT_CHAN_LTR_SWSEL_OFFSET		0xBC
+#define IOAT_CHAN_LTR_SWSEL_ACTIVE		0x0
+#define IOAT_CHAN_LTR_SWSEL_IDLE		0x1
+
+#define IOAT_CHAN_LTR_ACTIVE_OFFSET		0xC0
+#define IOAT_CHAN_LTR_ACTIVE_SNVAL		0x0000	/* 0 us */
+#define IOAT_CHAN_LTR_ACTIVE_SNLATSCALE		0x0800	/* 1us scale */
+#define IOAT_CHAN_LTR_ACTIVE_SNREQMNT		0x8000	/* snoop req enable */
+
+#define IOAT_CHAN_LTR_IDLE_OFFSET		0xC4
+#define IOAT_CHAN_LTR_IDLE_SNVAL		0x0258	/* 600 us */
+#define IOAT_CHAN_LTR_IDLE_SNLATSCALE		0x0800	/* 1us scale */
+#define IOAT_CHAN_LTR_IDLE_SNREQMNT		0x8000	/* snoop req enable */
+
+#endif /* _IOAT_REGISTERS_H_ */
-- 
2.49.0.1151.ga128411c76-goog


