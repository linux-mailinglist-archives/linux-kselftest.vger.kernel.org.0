Return-Path: <linux-kselftest+bounces-44217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B033C16F0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E6118996ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E273355806;
	Tue, 28 Oct 2025 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHk2Agy9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66435502F
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686464; cv=none; b=ocZSwwTSNna25MotRBYehboC3OQzZDVwXIxj49Gl47OhW/iRxRqH99EXPqD6k/YqoH196Awd70xdrqi2Z1v4CRZT9hGhQ1Z4wwvGQ8xnCTnD57nswUzNi3pd7VCWoAmYW+/QuLq5WNIfKw1tWU2TTeFE5s7n7GHTGVdAa4PheR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686464; c=relaxed/simple;
	bh=nEGfNmakvG/SJrWZlD9nSZUH+AMlCksOwOluH5NYAP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7MOTezUDybin9de/sc1/1Eay7wIaABxA4xF8CmukS0x4Z7BzDvV0uAYSUPTCC5M0Wu7WXiMGN3qs38Vwhpef7UhUMlD76bS8Py54F5ECTByX0n2IR/SqCQI+TYniibXTh5dOCMcBVz7vRsMO7ew+hiT8TVUuOINZCKv+oTTFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHk2Agy9; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-945a4849260so1050255939f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686461; x=1762291261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX5GVugwc+C6JrdMwZqI+sQGwgOrrPE6BL3d8gkbivU=;
        b=iHk2Agy9zj40Uf31mcDHKXO5AJ4tHfDnAXknJbX/Mj+iVtUxO23CRQgiN8HMXQMuiD
         LQMDI4ZpBgndun8af8CPJV/TeT37/OsLmss+FtwS5KlRS102s+ipZKy5Di8MWBys9QSh
         Kpxzme6Hy8W+mDpiFU5AhQg1dhhIgxuspGvB75d53eE2i4RDyFJK0LtSF/vvgdqOB3zA
         JG49KoIDvZrDSLxl487S0/5+aDB75l2HOaRcroSo6A3QpmsZ44AXCDss0csbSh+nwf+0
         cQIAuFfo9YGuwAgB/vHn245n2alGFIpX1Y3GyxS4q4wVqL4FJnYNkHcBR3U2jV4wHc7Q
         w3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686461; x=1762291261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX5GVugwc+C6JrdMwZqI+sQGwgOrrPE6BL3d8gkbivU=;
        b=WZZgMuzYzXHFxN9ydWRmiBdyQfU5CLeWGjy3aeRKXOeukvuRNI3ZPsdZpbOTVC7qcc
         kq4pCWTls2D0lBse2jc8zUKfT1lEMZ8ZlUBk1i4vUmDiwRPhmrRBDe4WyoQxMTHFHgjJ
         dk/ieiI7U6wV6Td7M8mSrF/fV48q+0AVbF0pspPJvEzAKpcZ8W0Yk+jmktTUJH2riV3n
         vez7aj5DF0IDX0/gyVyKPQaIfMx0HRQxAU/+QOtTNXUqstSPyIGYmnWfG3lMoCoqiy9Y
         s+qHGJ793A/UrihDA2P1pNMHQByPz8X0gB//v7OivzO7xWOP8FiLMq+kdcDWZOZhFcYD
         iEbQ==
X-Gm-Message-State: AOJu0Yyt4/ONwnFoD8NqHjNiBQhisYZ9AOG3s0L79+Lpcl/fK4ENDq9E
	/qN9kjETE137n1cnCqTXPtwGRWu+SdlySPiIwXUbm8BWmJRlknp2i+ZwlygcJCnUazN9KCQukXF
	aVFFzbyqSkWxP3Gh+AbGU7xHmKqUMBgSfsM9g6XFc+1JgaZ1fezUkZFLhoF+I8eO6g+1n4khNMr
	lq9gu9rObQ9sQMXEQ7MKZNOtFFGaFVbeI21DdV66kWFBE=
X-Google-Smtp-Source: AGHT+IGAFvo/KKvEdFChEUwxqiCVhHew0LDSPHYl5/GxeXUOv2hI6CPOtlDXCHz1yE7r5C1l+LIYI7DprA==
X-Received: from iobjh17.prod.google.com ([2002:a05:6602:7191:b0:945:a321:1fc4])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:718b:b0:93e:8bab:e17f
 with SMTP id ca18e2360f4ac-945c9865452mr118639039f.14.1761686461422; Tue, 28
 Oct 2025 14:21:01 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:32 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-7-sagis@google.com>
Subject: [PATCH v12 06/23] KVM: selftests: Expose segment definitons to
 assembly files
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

Move kernel segment definitions to a separate file which can be included
from assembly files.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor_asm.h        | 12 ++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c      |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/processor_asm.h

diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
new file mode 100644
index 000000000000..7e5386a85ca8
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Used for storing defines used by both processor.c and assembly code.
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
+#define SELFTEST_KVM_PROCESSOR_ASM_H
+
+#define KERNEL_CS	0x8
+#define KERNEL_DS	0x10
+#define KERNEL_TSS	0x18
+
+#endif  // SELFTEST_KVM_PROCESSOR_ASM_H
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 519d60a3827c..5f75bd48623b 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "pmu.h"
 #include "processor.h"
+#include "processor_asm.h"
 #include "sev.h"
 #include "tdx/tdx_util.h"
 
@@ -15,10 +16,6 @@
 #define NUM_INTERRUPTS 256
 #endif
 
-#define KERNEL_CS	0x8
-#define KERNEL_DS	0x10
-#define KERNEL_TSS	0x18
-
 vm_vaddr_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;
-- 
2.51.1.851.g4ebd6896fd-goog


