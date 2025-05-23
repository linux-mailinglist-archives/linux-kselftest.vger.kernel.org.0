Return-Path: <linux-kselftest+bounces-33710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5782EAC2C44
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0253A188ABD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5CD220F5F;
	Fri, 23 May 2025 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwrA6RSG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E32220F36
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043052; cv=none; b=bMtOf751CiR8NCxzqP1uB+zD65wGLGXS0jcXBzVvGtO9spkwVfbMBVTs1mvFdlr45feZR/+zIDXi0LrIBwx7xZdgPlCDKWzvxtQof6UKfieD1sxsLSGCykbJVzs9UeS/u7f68VEcTpkeOhJgqjvAr2AddgvQl9awoDedPDyaJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043052; c=relaxed/simple;
	bh=km0htpuAkJUV0zuVrkGxs+M34Ahf+Loi9SWQ3zbCDtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t1JLIb5YrKGhIfo/caD0hUGDhRbpP3PSWvg3VAocSY4qCADudznCwDwtYeTJ/j0cxXyVXHCql9JnLZUrYcr9l8lXlO9fCBuOaG5NP+kc93Y5SpQI5sm1hqEwKb5K4QpTnt/dmRMtnx/Q+1ciRcXsmF0th1yAkogQK4SJzruTd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwrA6RSG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e0fee541so210647a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043050; x=1748647850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytBIFo98xFNB1MVt6EkCempGxNhbLpE0MPkhz750Fyc=;
        b=mwrA6RSGTpGNEETylLkNABsB0mmC9tHxAuZH++uv193bpAJoxmquBp8aKYJ0CgB4iF
         dp3peziSyrcwVrJWqpzhU0tHPZyk8MKXm4aqRDYoQM1pJOWXcjbW/fc81ATd5PFv9Qik
         tkCYJZzYl+S5xr2jVen1MMr34wWM7C8TiX+LG9FkX94BbbyP1d3pfafPe+vBHQCMTIbW
         ZLWS6K91EEmAY11dnCQYIWQrbxD6ViLUkFEprjA1+j47N84r18chxw+8JBmjrrx8hOpc
         4QkDHqVMbNIPqs1g4Qhf49V0SB1hJOJI2LLrZxAw8HWtRe4m6EHw9zPFff6/HpbLQO2T
         GxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043050; x=1748647850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytBIFo98xFNB1MVt6EkCempGxNhbLpE0MPkhz750Fyc=;
        b=CVBSbkYt4isxNh76E4MlidJbQ61YvlqT2cf/3vLoflbwMCPJRrDtLInZ2iePhXcNFe
         BseqoqsX8FM+358eHRUq2Lb+X3ZMp9Dq8vQ3dPwW0NVHUsHWTEXGYURNorI3xKOReEIZ
         3X07d7IUdTzyY8cNHRGHbaWgWHlZ3FwlEbd+BrefNOmEZLxPAaldqXNqyM2NA2yMdT5b
         fwbJh1jt0fFNK7nzWvB7wFf41qA+gnu1aJbDJdTWWdWZpg0pVhGZC0iklKmGr2onpArh
         880y4J7KiNlbVYJ3UtM5j4bLS9MfUy+Qnfg2olP8DyU0JVT/WRc2JpB4ytz77miNiuiD
         bNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9jJesqQtjjem00tr7hb0K+MArsS01A/kr+tER7Vkkv9JZK6NlyHHdF9HwY0x71t5X4A0rqYSCeom/aWrSgW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7wGc9WFxj+/BvNpxSf4w8lGqk2i985Py93Aq7WxfwC18BDDi
	3Txlniukh1KRwzJpiXQ/Ng5pLuyqVAFCsOsKs8yozLSOsV+slFD8glc7YoM4mZ1MG6jAc5w3V9p
	FDGIh/fArosH/sw==
X-Google-Smtp-Source: AGHT+IGITjGEmjYwA0OzIiOuTLVVQ30T9NDX5D0e99YXFv1OioDrXF13PWhstptBBVs3gyOR+z4+EVpkYcPkCg==
X-Received: from pjf6.prod.google.com ([2002:a17:90b:3f06:b0:2ea:9d23:79a0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da1:b0:215:f6ab:cf78 with SMTP id adf61e73a8af0-2188c34da5cmr1689283637.28.1748043050085;
 Fri, 23 May 2025 16:30:50 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:59 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-15-dmatlack@google.com>
Subject: [RFC PATCH 14/33] tools headers: Import drivers/dma/idxd/registers.h
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

Import drivers/dma/idxd/registers.h into tools/include/ so that it can
be used in VFIO selftests to interact with Intel DSA devices.

Changes made when importing:
 - Drop macro definitions that access struct idxd_device (e.g.
   WQCFG_OFFSET()).

Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/drivers/dma/idxd/registers.h | 601 +++++++++++++++++++++
 1 file changed, 601 insertions(+)
 create mode 100644 tools/include/drivers/dma/idxd/registers.h

diff --git a/tools/include/drivers/dma/idxd/registers.h b/tools/include/drivers/dma/idxd/registers.h
new file mode 100644
index 000000000000..7f4699e6a5c3
--- /dev/null
+++ b/tools/include/drivers/dma/idxd/registers.h
@@ -0,0 +1,601 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#ifndef _IDXD_REGISTERS_H_
+#define _IDXD_REGISTERS_H_
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/idxd.h>
+
+/* PCI Config */
+#define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
+#define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
+
+#define DEVICE_VERSION_1		0x100
+#define DEVICE_VERSION_2		0x200
+
+#define IDXD_MMIO_BAR		0
+#define IDXD_WQ_BAR		2
+#define IDXD_PORTAL_SIZE	PAGE_SIZE
+
+/* MMIO Device BAR0 Registers */
+#define IDXD_VER_OFFSET			0x00
+#define IDXD_VER_MAJOR_MASK		0xf0
+#define IDXD_VER_MINOR_MASK		0x0f
+#define GET_IDXD_VER_MAJOR(x)		(((x) & IDXD_VER_MAJOR_MASK) >> 4)
+#define GET_IDXD_VER_MINOR(x)		((x) & IDXD_VER_MINOR_MASK)
+
+union gen_cap_reg {
+	struct {
+		u64 block_on_fault:1;
+		u64 overlap_copy:1;
+		u64 cache_control_mem:1;
+		u64 cache_control_cache:1;
+		u64 cmd_cap:1;
+		u64 rsvd:3;
+		u64 dest_readback:1;
+		u64 drain_readback:1;
+		u64 rsvd2:3;
+		u64 evl_support:2;
+		u64 batch_continuation:1;
+		u64 max_xfer_shift:5;
+		u64 max_batch_shift:4;
+		u64 max_ims_mult:6;
+		u64 config_en:1;
+		u64 rsvd3:32;
+	};
+	u64 bits;
+} __packed;
+#define IDXD_GENCAP_OFFSET		0x10
+
+union wq_cap_reg {
+	struct {
+		u64 total_wq_size:16;
+		u64 num_wqs:8;
+		u64 wqcfg_size:4;
+		u64 rsvd:20;
+		u64 shared_mode:1;
+		u64 dedicated_mode:1;
+		u64 wq_ats_support:1;
+		u64 priority:1;
+		u64 occupancy:1;
+		u64 occupancy_int:1;
+		u64 op_config:1;
+		u64 wq_prs_support:1;
+		u64 rsvd4:8;
+	};
+	u64 bits;
+} __packed;
+#define IDXD_WQCAP_OFFSET		0x20
+#define IDXD_WQCFG_MIN			5
+
+union group_cap_reg {
+	struct {
+		u64 num_groups:8;
+		u64 total_rdbufs:8;	/* formerly total_tokens */
+		u64 rdbuf_ctrl:1;	/* formerly token_en */
+		u64 rdbuf_limit:1;	/* formerly token_limit */
+		u64 progress_limit:1;	/* descriptor and batch descriptor */
+		u64 rsvd:45;
+	};
+	u64 bits;
+} __packed;
+#define IDXD_GRPCAP_OFFSET		0x30
+
+union engine_cap_reg {
+	struct {
+		u64 num_engines:8;
+		u64 rsvd:56;
+	};
+	u64 bits;
+} __packed;
+
+#define IDXD_ENGCAP_OFFSET		0x38
+
+#define IDXD_OPCAP_NOOP			0x0001
+#define IDXD_OPCAP_BATCH			0x0002
+#define IDXD_OPCAP_MEMMOVE		0x0008
+struct opcap {
+	u64 bits[4];
+};
+
+#define IDXD_MAX_OPCAP_BITS		256U
+
+#define IDXD_OPCAP_OFFSET		0x40
+
+#define IDXD_TABLE_OFFSET		0x60
+union offsets_reg {
+	struct {
+		u64 grpcfg:16;
+		u64 wqcfg:16;
+		u64 msix_perm:16;
+		u64 ims:16;
+		u64 perfmon:16;
+		u64 rsvd:48;
+	};
+	u64 bits[2];
+} __packed;
+
+#define IDXD_TABLE_MULT			0x100
+
+#define IDXD_GENCFG_OFFSET		0x80
+union gencfg_reg {
+	struct {
+		u32 rdbuf_limit:8;
+		u32 rsvd:4;
+		u32 user_int_en:1;
+		u32 evl_en:1;
+		u32 rsvd2:18;
+	};
+	u32 bits;
+} __packed;
+
+#define IDXD_GENCTRL_OFFSET		0x88
+union genctrl_reg {
+	struct {
+		u32 softerr_int_en:1;
+		u32 halt_int_en:1;
+		u32 evl_int_en:1;
+		u32 rsvd:29;
+	};
+	u32 bits;
+} __packed;
+
+#define IDXD_GENSTATS_OFFSET		0x90
+union gensts_reg {
+	struct {
+		u32 state:2;
+		u32 reset_type:2;
+		u32 rsvd:28;
+	};
+	u32 bits;
+} __packed;
+
+enum idxd_device_status_state {
+	IDXD_DEVICE_STATE_DISABLED = 0,
+	IDXD_DEVICE_STATE_ENABLED,
+	IDXD_DEVICE_STATE_DRAIN,
+	IDXD_DEVICE_STATE_HALT,
+};
+
+enum idxd_device_reset_type {
+	IDXD_DEVICE_RESET_SOFTWARE = 0,
+	IDXD_DEVICE_RESET_FLR,
+	IDXD_DEVICE_RESET_WARM,
+	IDXD_DEVICE_RESET_COLD,
+};
+
+#define IDXD_INTCAUSE_OFFSET		0x98
+#define IDXD_INTC_ERR			0x01
+#define IDXD_INTC_CMD			0x02
+#define IDXD_INTC_OCCUPY			0x04
+#define IDXD_INTC_PERFMON_OVFL		0x08
+#define IDXD_INTC_HALT_STATE		0x10
+#define IDXD_INTC_EVL			0x20
+#define IDXD_INTC_INT_HANDLE_REVOKED	0x80000000
+
+#define IDXD_CMD_OFFSET			0xa0
+union idxd_command_reg {
+	struct {
+		u32 operand:20;
+		u32 cmd:5;
+		u32 rsvd:6;
+		u32 int_req:1;
+	};
+	u32 bits;
+} __packed;
+
+enum idxd_cmd {
+	IDXD_CMD_ENABLE_DEVICE = 1,
+	IDXD_CMD_DISABLE_DEVICE,
+	IDXD_CMD_DRAIN_ALL,
+	IDXD_CMD_ABORT_ALL,
+	IDXD_CMD_RESET_DEVICE,
+	IDXD_CMD_ENABLE_WQ,
+	IDXD_CMD_DISABLE_WQ,
+	IDXD_CMD_DRAIN_WQ,
+	IDXD_CMD_ABORT_WQ,
+	IDXD_CMD_RESET_WQ,
+	IDXD_CMD_DRAIN_PASID,
+	IDXD_CMD_ABORT_PASID,
+	IDXD_CMD_REQUEST_INT_HANDLE,
+	IDXD_CMD_RELEASE_INT_HANDLE,
+};
+
+#define CMD_INT_HANDLE_IMS		0x10000
+
+#define IDXD_CMDSTS_OFFSET		0xa8
+union cmdsts_reg {
+	struct {
+		u8 err;
+		u16 result;
+		u8 rsvd:7;
+		u8 active:1;
+	};
+	u32 bits;
+} __packed;
+#define IDXD_CMDSTS_ACTIVE		0x80000000
+#define IDXD_CMDSTS_ERR_MASK		0xff
+#define IDXD_CMDSTS_RES_SHIFT		8
+
+enum idxd_cmdsts_err {
+	IDXD_CMDSTS_SUCCESS = 0,
+	IDXD_CMDSTS_INVAL_CMD,
+	IDXD_CMDSTS_INVAL_WQIDX,
+	IDXD_CMDSTS_HW_ERR,
+	/* enable device errors */
+	IDXD_CMDSTS_ERR_DEV_ENABLED = 0x10,
+	IDXD_CMDSTS_ERR_CONFIG,
+	IDXD_CMDSTS_ERR_BUSMASTER_EN,
+	IDXD_CMDSTS_ERR_PASID_INVAL,
+	IDXD_CMDSTS_ERR_WQ_SIZE_ERANGE,
+	IDXD_CMDSTS_ERR_GRP_CONFIG,
+	IDXD_CMDSTS_ERR_GRP_CONFIG2,
+	IDXD_CMDSTS_ERR_GRP_CONFIG3,
+	IDXD_CMDSTS_ERR_GRP_CONFIG4,
+	/* enable wq errors */
+	IDXD_CMDSTS_ERR_DEV_NOTEN = 0x20,
+	IDXD_CMDSTS_ERR_WQ_ENABLED,
+	IDXD_CMDSTS_ERR_WQ_SIZE,
+	IDXD_CMDSTS_ERR_WQ_PRIOR,
+	IDXD_CMDSTS_ERR_WQ_MODE,
+	IDXD_CMDSTS_ERR_BOF_EN,
+	IDXD_CMDSTS_ERR_PASID_EN,
+	IDXD_CMDSTS_ERR_MAX_BATCH_SIZE,
+	IDXD_CMDSTS_ERR_MAX_XFER_SIZE,
+	/* disable device errors */
+	IDXD_CMDSTS_ERR_DIS_DEV_EN = 0x31,
+	/* disable WQ, drain WQ, abort WQ, reset WQ */
+	IDXD_CMDSTS_ERR_DEV_NOT_EN,
+	/* request interrupt handle */
+	IDXD_CMDSTS_ERR_INVAL_INT_IDX = 0x41,
+	IDXD_CMDSTS_ERR_NO_HANDLE,
+};
+
+#define IDXD_CMDCAP_OFFSET		0xb0
+
+#define IDXD_SWERR_OFFSET		0xc0
+#define IDXD_SWERR_VALID		0x00000001
+#define IDXD_SWERR_OVERFLOW		0x00000002
+#define IDXD_SWERR_ACK			(IDXD_SWERR_VALID | IDXD_SWERR_OVERFLOW)
+union sw_err_reg {
+	struct {
+		u64 valid:1;
+		u64 overflow:1;
+		u64 desc_valid:1;
+		u64 wq_idx_valid:1;
+		u64 batch:1;
+		u64 fault_rw:1;
+		u64 priv:1;
+		u64 rsvd:1;
+		u64 error:8;
+		u64 wq_idx:8;
+		u64 rsvd2:8;
+		u64 operation:8;
+		u64 pasid:20;
+		u64 rsvd3:4;
+
+		u64 batch_idx:16;
+		u64 rsvd4:16;
+		u64 invalid_flags:32;
+
+		u64 fault_addr;
+
+		u64 rsvd5;
+	};
+	u64 bits[4];
+} __packed;
+
+union iaa_cap_reg {
+	struct {
+		u64 dec_aecs_format_ver:1;
+		u64 drop_init_bits:1;
+		u64 chaining:1;
+		u64 force_array_output_mod:1;
+		u64 load_part_aecs:1;
+		u64 comp_early_abort:1;
+		u64 nested_comp:1;
+		u64 diction_comp:1;
+		u64 header_gen:1;
+		u64 crypto_gcm:1;
+		u64 crypto_cfb:1;
+		u64 crypto_xts:1;
+		u64 rsvd:52;
+	};
+	u64 bits;
+} __packed;
+
+#define IDXD_IAACAP_OFFSET	0x180
+
+#define IDXD_EVLCFG_OFFSET	0xe0
+union evlcfg_reg {
+	struct {
+		u64 pasid_en:1;
+		u64 priv:1;
+		u64 rsvd:10;
+		u64 base_addr:52;
+
+		u64 size:16;
+		u64 pasid:20;
+		u64 rsvd2:28;
+	};
+	u64 bits[2];
+} __packed;
+
+#define IDXD_EVL_SIZE_MIN	0x0040
+#define IDXD_EVL_SIZE_MAX	0xffff
+
+union msix_perm {
+	struct {
+		u32 rsvd:2;
+		u32 ignore:1;
+		u32 pasid_en:1;
+		u32 rsvd2:8;
+		u32 pasid:20;
+	};
+	u32 bits;
+} __packed;
+
+union group_flags {
+	struct {
+		u64 tc_a:3;
+		u64 tc_b:3;
+		u64 rsvd:1;
+		u64 use_rdbuf_limit:1;
+		u64 rdbufs_reserved:8;
+		u64 rsvd2:4;
+		u64 rdbufs_allowed:8;
+		u64 rsvd3:4;
+		u64 desc_progress_limit:2;
+		u64 rsvd4:2;
+		u64 batch_progress_limit:2;
+		u64 rsvd5:26;
+	};
+	u64 bits;
+} __packed;
+
+struct grpcfg {
+	u64 wqs[4];
+	u64 engines;
+	union group_flags flags;
+} __packed;
+
+union wqcfg {
+	struct {
+		/* bytes 0-3 */
+		u16 wq_size;
+		u16 rsvd;
+
+		/* bytes 4-7 */
+		u16 wq_thresh;
+		u16 rsvd1;
+
+		/* bytes 8-11 */
+		u32 mode:1;	/* shared or dedicated */
+		u32 bof:1;	/* block on fault */
+		u32 wq_ats_disable:1;
+		u32 wq_prs_disable:1;
+		u32 priority:4;
+		u32 pasid:20;
+		u32 pasid_en:1;
+		u32 priv:1;
+		u32 rsvd3:2;
+
+		/* bytes 12-15 */
+		u32 max_xfer_shift:5;
+		u32 max_batch_shift:4;
+		u32 rsvd4:23;
+
+		/* bytes 16-19 */
+		u16 occupancy_inth;
+		u16 occupancy_table_sel:1;
+		u16 rsvd5:15;
+
+		/* bytes 20-23 */
+		u16 occupancy_limit;
+		u16 occupancy_int_en:1;
+		u16 rsvd6:15;
+
+		/* bytes 24-27 */
+		u16 occupancy;
+		u16 occupancy_int:1;
+		u16 rsvd7:12;
+		u16 mode_support:1;
+		u16 wq_state:2;
+
+		/* bytes 28-31 */
+		u32 rsvd8;
+
+		/* bytes 32-63 */
+		u64 op_config[4];
+	};
+	u32 bits[16];
+} __packed;
+
+#define WQCFG_PASID_IDX                2
+#define WQCFG_PRIVL_IDX		2
+#define WQCFG_OCCUP_IDX		6
+
+#define WQCFG_OCCUP_MASK	0xffff
+
+#define GRPCFG_SIZE		64
+#define GRPWQCFG_STRIDES	4
+
+/* Following is performance monitor registers */
+#define IDXD_PERFCAP_OFFSET		0x0
+union idxd_perfcap {
+	struct {
+		u64 num_perf_counter:6;
+		u64 rsvd1:2;
+		u64 counter_width:8;
+		u64 num_event_category:4;
+		u64 global_event_category:16;
+		u64 filter:8;
+		u64 rsvd2:8;
+		u64 cap_per_counter:1;
+		u64 writeable_counter:1;
+		u64 counter_freeze:1;
+		u64 overflow_interrupt:1;
+		u64 rsvd3:8;
+	};
+	u64 bits;
+} __packed;
+
+#define IDXD_EVNTCAP_OFFSET		0x80
+union idxd_evntcap {
+	struct {
+		u64 events:28;
+		u64 rsvd:36;
+	};
+	u64 bits;
+} __packed;
+
+struct idxd_event {
+	union {
+		struct {
+			u32 event_category:4;
+			u32 events:28;
+		};
+		u32 val;
+	};
+} __packed;
+
+#define IDXD_CNTRCAP_OFFSET		0x800
+struct idxd_cntrcap {
+	union {
+		struct {
+			u32 counter_width:8;
+			u32 rsvd:20;
+			u32 num_events:4;
+		};
+		u32 val;
+	};
+	struct idxd_event events[];
+} __packed;
+
+#define IDXD_PERFRST_OFFSET		0x10
+union idxd_perfrst {
+	struct {
+		u32 perfrst_config:1;
+		u32 perfrst_counter:1;
+		u32 rsvd:30;
+	};
+	u32 val;
+} __packed;
+
+#define IDXD_OVFSTATUS_OFFSET		0x30
+#define IDXD_PERFFRZ_OFFSET		0x20
+#define IDXD_CNTRCFG_OFFSET		0x100
+union idxd_cntrcfg {
+	struct {
+		u64 enable:1;
+		u64 interrupt_ovf:1;
+		u64 global_freeze_ovf:1;
+		u64 rsvd1:5;
+		u64 event_category:4;
+		u64 rsvd2:20;
+		u64 events:28;
+		u64 rsvd3:4;
+	};
+	u64 val;
+} __packed;
+
+#define IDXD_FLTCFG_OFFSET		0x300
+
+#define IDXD_CNTRDATA_OFFSET		0x200
+union idxd_cntrdata {
+	struct {
+		u64 event_count_value;
+	};
+	u64 val;
+} __packed;
+
+union event_cfg {
+	struct {
+		u64 event_cat:4;
+		u64 event_enc:28;
+	};
+	u64 val;
+} __packed;
+
+union filter_cfg {
+	struct {
+		u64 wq:32;
+		u64 tc:8;
+		u64 pg_sz:4;
+		u64 xfer_sz:8;
+		u64 eng:8;
+	};
+	u64 val;
+} __packed;
+
+#define IDXD_EVLSTATUS_OFFSET		0xf0
+
+union evl_status_reg {
+	struct {
+		u32 head:16;
+		u32 rsvd:16;
+		u32 tail:16;
+		u32 rsvd2:14;
+		u32 int_pending:1;
+		u32 rsvd3:1;
+	};
+	struct {
+		u32 bits_lower32;
+		u32 bits_upper32;
+	};
+	u64 bits;
+} __packed;
+
+#define IDXD_MAX_BATCH_IDENT	256
+
+struct __evl_entry {
+	u64 rsvd:2;
+	u64 desc_valid:1;
+	u64 wq_idx_valid:1;
+	u64 batch:1;
+	u64 fault_rw:1;
+	u64 priv:1;
+	u64 err_info_valid:1;
+	u64 error:8;
+	u64 wq_idx:8;
+	u64 batch_id:8;
+	u64 operation:8;
+	u64 pasid:20;
+	u64 rsvd2:4;
+
+	u16 batch_idx;
+	u16 rsvd3;
+	union {
+		/* Invalid Flags 0x11 */
+		u32 invalid_flags;
+		/* Invalid Int Handle 0x19 */
+		/* Page fault 0x1a */
+		/* Page fault 0x06, 0x1f, only operand_id */
+		/* Page fault before drain or in batch, 0x26, 0x27 */
+		struct {
+			u16 int_handle;
+			u16 rci:1;
+			u16 ims:1;
+			u16 rcr:1;
+			u16 first_err_in_batch:1;
+			u16 rsvd4_2:9;
+			u16 operand_id:3;
+		};
+	};
+	u64 fault_addr;
+	u64 rsvd5;
+} __packed;
+
+struct dsa_evl_entry {
+	struct __evl_entry e;
+	struct dsa_completion_record cr;
+} __packed;
+
+struct iax_evl_entry {
+	struct __evl_entry e;
+	u64 rsvd[4];
+	struct iax_completion_record cr;
+} __packed;
+
+#endif
-- 
2.49.0.1151.ga128411c76-goog


