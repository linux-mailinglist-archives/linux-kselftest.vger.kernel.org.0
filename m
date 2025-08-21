Return-Path: <linux-kselftest+bounces-39451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FDDB2ECEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57EE1881CD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CEE2EBBAD;
	Thu, 21 Aug 2025 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qb6F3xrV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2112EBDE2
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750592; cv=none; b=S2QTRSMm6ipxlB3cRExAFjAu/3sY5VeNJ33LUw6nQER3hSjN7/swlDFq4dJ9lTogyQXu4nU4ygrAsNUwIPljtJflXjg/aDJ9U0yDJNHY5Mgp72WqcWElQCn5Z01cbAAn0UPi/T1SH+9FmF8o3ZggUUfB3iT0/EviZpbz/ma6txU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750592; c=relaxed/simple;
	bh=YfCKtl1oYUHFl63/I/l0XnKZWiM4Uj8GywSB9cp0jjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAkriMbrTRE5Uu6g7lfMtw6jutfmO1oqZP8Egj9Q1MeCrPJcYT1R3zHa6/QHkOayprQKNkBfEhVfEDHEg9JYOWd9F53zgakeGchnJ0Qe9R0DzEKMaAVQLdIRhVP42nMtn6pvlLdk8JN3xv5Q7oDQ3RZDtdhtAFSMqr3zjAEcQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qb6F3xrV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47175d5a90so472772a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750590; x=1756355390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=17hgKbvgVoShstlAaX3KPF4mBrZKhgeiLGz5GZxS0HI=;
        b=Qb6F3xrVOUybbId/NnuDD3ApI/TP1Kbi9dxKcXPlXyjpJF/cgqBU5iK0U1MRhHy5n4
         Yv+jiufsj9ItVmXOVjGDJ6B3gAky1O3+Iq+oLQkw6bnRN1Y1QV0/5TOlrt2QFQVqETRc
         O8EjJYkUQ6FR9FpFOCbvBYs4/TANaB0QDED7OM7dty9gsZNAbR1quDAi/Qu1TkNixxAB
         AISNpYNCx5ewkL377smQlvIHpD8Tw10LznyTk6C+5xVTFSJ1s3M+z23FVSQFR3owB5Wk
         P6Y12yuUxN1LVi9z2xtre3vUzpOHQWTRylew5lBTY+g3Kld2/KLsG0ULino9hmDn4Xk+
         r72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750590; x=1756355390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17hgKbvgVoShstlAaX3KPF4mBrZKhgeiLGz5GZxS0HI=;
        b=Rb9gJK1Ap2kySOz0dE0eiLLXozgnSj34aWDtxmIXXtEGUlfrESqVIaMXkpP6DuKIMN
         qjPjW0CzRucdmPcCCFnDy4V388VO0c+NpCaucutPbeQ9fopBsPptIjvzsXySVLjld21m
         FyRQv4ihVIKjxEAURgtqynB5fGEPzmyQS9s7Em1/gPnFUPiAXVMdK/WHyQtgMJVuCltK
         WIqVWqGZ8BtLmSTjCZifZliPdRTHC5qQzsqM9NEdjzgdFwONjagRh0mjJJnPCe9KYcxA
         xdxeGxJq1M6J7AbUuW9mfO1oah//r6VVhsxqQdX0VE6zMG03lZ1dXUAg9U6NNM6r3+mj
         HQGA==
X-Gm-Message-State: AOJu0YwI8hkRwUg2C/9Ub9+kNvQtWOw5sKe30hZR4q+vrGObmTyMd3MP
	lEIc5Cd+3WbowtStrM4+OkY5OeGmMtSNJKhXb0DEb2oYSyZpQEwi5JlvWftTIIZaMlMbn+Zym3U
	gvQyUiUGRIg4SZ0JZVSnp/4vNqJ5iKTe2+m/8R6HnhRU0k12Pw4e2Hm4BY6Po9FKby0b041nV7Z
	sxOB/XPfuCYBdRokh4u0L0AuItponEZe6n5a6scqe+Jnk=
X-Google-Smtp-Source: AGHT+IGF5a5kRZmxUiR0v1iGU7vvhEaAdIOjYi1z34R/ceiLYsiE+HhRHvw9xVKXOykbRjsvm8/UnJbeaw==
X-Received: from pgbl17.prod.google.com ([2002:a63:5711:0:b0:b47:9d0:bf72])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0c:b0:240:101c:4428
 with SMTP id adf61e73a8af0-243308364d2mr1563120637.10.1755750589607; Wed, 20
 Aug 2025 21:29:49 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:10 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-18-sagis@google.com>
Subject: [PATCH v9 17/19] KVM: selftests: Add wrapper for TDX MMIO from guest
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
 .../selftests/kvm/include/x86/tdx/tdx.h       | 14 ++++++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 1f541c0d4fe1..8d1aaebd746e 100644
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
index 000000000000..12df30ac1ceb
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -0,0 +1,22 @@
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
2.51.0.rc1.193.gad69d77794-goog


