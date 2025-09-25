Return-Path: <linux-kselftest+bounces-42386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3290BA0E45
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926976C1AB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0009321F32;
	Thu, 25 Sep 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AB0WFZGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CC321271
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821372; cv=none; b=nFnR53ZaanGuh/ntRg/lAyoYyPeDTSfXd4qlY5+NgPCGPBWI+BUuzrx1k+/DLklqoUl4fLFOEsgPKcDzJ9YYxLTSOjJPzOhupdVHYVqEfqglUFvIhXObMuh6IKjd7Acw+G7171YsWG5FeSp+8FFXYlnljDhdY2oyoNo5AE7K2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821372; c=relaxed/simple;
	bh=3znNNTzzgwZ3OVafDf2/cAXagMtlSh9rcqeBjFqLA9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ruhfPGEb/Rn6wEf20J5APkML/8ZFaQPWBl9fGVrwH9n8Bk8ee5l5l2swJodGFUVrYnUbM9xmRiP7aXEEbwSD7EO+4xglGlJoonEhngabNROGdsxBvgEopo5j0H6DWk86thb7zLNolS0LM7D2LuYdmFUChg1xwyqkb03+1mN8Vt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AB0WFZGE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc3aso1368579a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821370; x=1759426170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1I0d3H8TyKfzIE5uQLOEkCrQLG+nnvdngPIYTlDoLN4=;
        b=AB0WFZGEyrT619+y5bjWGObwquNz8dFmqCFaisC4mXQt3IqkdZHEKIGX3TYw5CIxpi
         bU0dyV8WicmDxa++gyBuff52EOkswpG1/7PnixibFdjz08IMWKlAK/RVEixsONfg8+y2
         QllqziD0zOSEbkfDO+y9vyNhymr1Ep9Znac9m/fzoBHE3pYDEg3EycKrUfDMzU0794Xu
         sEempVKw3Ez1lOrmQlMnwzYBvV84kVggQPyPy4J7st08w9cR3aRyJRF9PTtyk6mWHlCh
         oq9Vz8Bd0bK/v2IM6v9CMZpNXVqdbuDO/4SPj9vnuOtqumil3TQ9Ywnc1a4FMFMFTAJ8
         9IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821370; x=1759426170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I0d3H8TyKfzIE5uQLOEkCrQLG+nnvdngPIYTlDoLN4=;
        b=AJMjOAofMRG2qBlPDRkdMLe1FkD6Qn7haGQRm5fHay95aqUhhZz0vcUbSpXWs+UJ7/
         hCML7jt1FtKz3MJ6hZ7VNLWKIF+SGPd9uevx+lY5QnP/fPNb+jQ3adJ5vcAuWTcwkNaS
         83P41JRH0tdokSrx3bWlDIvJb5zbKR6s9/MsrpmhxzNzhRyzPIIRm/Y8Ppnlb6F9ejFT
         YhgbpWpCjy6yWAK5AkrbbrWS4zY7pPdZi7zWKemrPDvvJcOhK02ORast3t9JFWDhoWxq
         eXE/WmXdO0Gr9bamOb2qkiBdv86RHOb+crkYFoDcwn+w6830Clti8MBE56bd7KRFEZMP
         ktmA==
X-Gm-Message-State: AOJu0YxmX/hAi0ozlfrRlKP33o6hn395/9RzJvQHWRA1F+fGKbOekoDt
	RhbFGYqbhfuEex0w4ArLi89IV10VGAjf86EGkfvv2ATh9izIrSDmHJxy/Asu9Q+L7twOK8jtYWI
	s+yLhYi28DkwfKRQ2AhvmqjZmmCuUX4JalHGp1JC16HFWBxOkoMzbr9tRSKvRoAvv4gv92b6HQP
	VkvNFSkk2Yn5KV7V7M5vaUYrdiwmQulaAsoWixhRrjDrU=
X-Google-Smtp-Source: AGHT+IECM1WrKtqV1I4hTE41GQwZHS00MBwdDco5WyVseq3MBB5Rg5a30RkPZBPhewvNjT9OfGZ9wLQtjg==
X-Received: from pjbnp18.prod.google.com ([2002:a17:90b:4c52:b0:334:1843:ee45])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d886:b0:32f:469:954c
 with SMTP id 98e67ed59e1d1-3342a2f9276mr4237165a91.34.1758821369732; Thu, 25
 Sep 2025 10:29:29 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:47 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-20-sagis@google.com>
Subject: [PATCH v11 19/21] KVM: selftests: Add wrapper for TDX MMIO from guest
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add utility function to issue MMIO TDCALL from TDX guests.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/tdx/tdx.h       | 14 +++++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 23 +++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 2d4fd68984a0..1a73e08c8437 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -35,6 +35,7 @@ LIBKVM_x86 += lib/x86/vmx.c
 LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
 LIBKVM_x86 += lib/x86/tdx/tdcall.S
+LIBKVM_x86 += lib/x86/tdx/tdx.c
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
new file mode 100644
index 000000000000..22b096402998
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_TDX_H
+#define SELFTESTS_TDX_TDX_H
+
+#include <stdint.h>
+
+/* MMIO direction */
+#define MMIO_READ	0
+#define MMIO_WRITE	1
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					     uint64_t data_in);
+
+#endif // SELFTESTS_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
new file mode 100644
index 000000000000..f9c1acd5b30c
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+
+#define TDG_VP_VMCALL 0
+
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO	48
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					     uint64_t data_in)
+{
+	struct tdx_tdcall_args args = {
+		.r10 = TDG_VP_VMCALL,
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = MMIO_WRITE,
+		.r14 = address,
+		.r15 = data_in,
+	};
+
+	return __tdx_tdcall(&args, 0);
+}
-- 
2.51.0.536.g15c5d4f767-goog


