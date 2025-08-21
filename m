Return-Path: <linux-kselftest+bounces-39440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A0B2ECE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F7117F3E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC3E2E8E18;
	Thu, 21 Aug 2025 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLFexyJx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB7280325
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750575; cv=none; b=XyJdYsmLeKYg6Z+mHmB/REc4S8gL7JFomduV783ZHTVs1V/v56ZFQCbdwRPQosO93EbBDxlDCtrZPzdA6Rw57NX6JhJCB3+5+wwkEE5QNhrBZZU3rUm8lIpeZSgBX/wetgiSTignXGqFWHWtEgH04pynGThpMFopPKZzbhPw7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750575; c=relaxed/simple;
	bh=1b3afp9FciLsZc7hNSUjoTR4x2Fj/jtBIEBYZswIO9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HBPVJ9ax6lDi4ZOdSKqnX7PO0TjAn4sNt3QZOir/3l2RoA/GCE2iVAcB0Rkduh/JXFEnzwT5QoI+EOTEpWVolQJTL+mBT/RhHhVK5TZ8oSAld4WKJ8j6vbS6+wldUK+tvY43/5rHN1HpMY7t/hGQXrpreznfTuftE6WxfuP28TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLFexyJx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e21dd6so1272274a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750573; x=1756355373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXqpuVKtEF41FrGVua569uHSTz6fPFI9wc+GO39yc4A=;
        b=oLFexyJxZlVGYsNoIxhlKSE/A/JvLrhdfa8kdZg2DZfixb62JK/WFbK6VthmADl5Ye
         RuTL2rpRBa60pL2IbkVAf5rZ4wD1gXisw5J4W7OLeUcgP0nhqcikL2W0oeTt0iSpzUC/
         rHo3RvEvFDbM8o2GS32XGNTM3Srle/0MVGGw7RIe8JzdfqNWGSOdIQ2oMHux+m/MNw4P
         +Joky79r0Ubi+3C0WJ18iECoqeGB7pySXfP07QEl68DhqiHWGMuvGceFEqJ5nQeSONgi
         qLMAZG4szzIfcy/q4nsW/DSa17ENKcV1/1koZ4ICbEX5enPV+BhCRhxCwIkrdOmIwbMh
         L0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750573; x=1756355373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXqpuVKtEF41FrGVua569uHSTz6fPFI9wc+GO39yc4A=;
        b=qUd6bLapbD4eJb/gJc5z4H22yrBYhaOZCG4b19fFa5Mg6qwCwsbVxrTAhtwnuhiL6/
         SirZSCd0Mi6055l9wgZ3dVOZy1lp5lF7xgTb3X1DhqvkrsoD05BDXW2Qrqo5KUzDU3Vb
         K1nUnChSQsN9qOEBTIApy498UjugqNbkIhb1bBBSiE2iTKTO60k5JSDOLPOfZ/nkI1Ab
         g90CNLQ2QGNE35qTR1UNhjEkCtC4vMgHIusuQsbWsqpVutt4UPVDpRsRLdoJrewPb6wU
         fDpThVjMjpiQ0/ZkATGr1Jk/TgwrDJOXEyqEW4QhTAaV59tN5HoHDbS0ORQOdnjDLAfU
         nEXQ==
X-Gm-Message-State: AOJu0YyoJfv8mhsdGF05w1LfKg2XuBgry/Jpnu26GS4ZcOFYVOzEPpo4
	E/5LQpMe/yiW0M2KWQNkBXLTX9OBVgPjC1IgHDmjTYu4Vk4ZK1qrqGFvtPVUnLFYcuDTSehDEIs
	5sYk3lDGTq16vq0Ij/9zSFNx/+XekqYtzQUoPUuRvIc8KAg7m1PnJtg7PbrSnJsMbOiFgWAnYKF
	KwHeMyJfoo4iKSXEFzY7X/maiCUdoU3Dxj9DjxnjHCmBA=
X-Google-Smtp-Source: AGHT+IGzVARSsi6nHDnbmGE89/cao5FFITyy6Jqk7M5ZqZA+Zo+RcWCXp4Ofq+yExOFUmttBBEOz2ZSVvw==
X-Received: from pjbnd12.prod.google.com ([2002:a17:90b:4ccc:b0:31c:2fe4:33b7])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37c5:b0:311:e605:f60e
 with SMTP id 98e67ed59e1d1-324ed195f2emr1687094a91.20.1755750573060; Wed, 20
 Aug 2025 21:29:33 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:59 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-7-sagis@google.com>
Subject: [PATCH v9 06/19] KVM: selftests: Expose segment definitons to
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

Move kernel segment definitons to a separate file which can be included
from assembly files.

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
index 6dbf40cbbc2a..4802fc81bea7 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -7,6 +7,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "processor_asm.h"
 #include "sev.h"
 #include "tdx/tdx_util.h"
 
@@ -14,10 +15,6 @@
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
2.51.0.rc1.193.gad69d77794-goog


