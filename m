Return-Path: <linux-kselftest+bounces-42371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA03BA0D9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C611BC4054
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA2314B9E;
	Thu, 25 Sep 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMeO4/IX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE131326B
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821349; cv=none; b=VcCbnoDjLZFUiO5ppqz1izWFTKrD4gJGC7lRNfCGtLnaeGRkyDVhLdO1QHJHTDHqPNmaf1CckhjLrHw4iYlLLwHNOlA/fD26ANpYRXkJlB7xcFkGPQb6qz1pAUz81PGLuh4rc0V7HvwlyFRI4QbaEZbux6eVQQV+J6Od6avzJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821349; c=relaxed/simple;
	bh=ZzhA1E5+bwHrW7btlY3pOX20ORYI4vjZu03yVvByMfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+KUMoqgES1fpOVmaOESbAgJJqwytIr43q3eP2mnVxAn32U87hZi234AAVyIcRVsreI/ump/rLA+k7MIBfaP7BhrXXcFHP05J3/WYvjovY13Euqnc6TcWX+UmgpyeR4G2Uj6P2WC7/bAZy+aLQ0Vlh8hphLLyzTq/PakvVSfsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VMeO4/IX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57c2371182so1199530a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821347; x=1759426147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob07LuDFfKYbEaEx9P5dlQJ3PRLLB9y+zXQT8zPF5u4=;
        b=VMeO4/IXrKXZoEeDO5D5bsvxTuSdQ5rx6dNj0NR+eXn62mNS0dbqJ9ABf7xrAnKO/z
         O5BOQNj3Xjdk2VJCSYGID1G4ykxtoC2G8fGxUh+YgJamh3BoPadooD+eBoZI3kQaXrcq
         wun80wSXQ6avc/fuDcGixTt6w4wYMVjHwahgQT1YxLTXl52cxz5W0e/yTrC0Okge42uw
         EnPGdx/iTpM+7qimkq0p+ku3UXO4NGDutX7jyt30+00d3dBXoc2Bu+fEAVZ2f1Xd1jjH
         K2bvkSzia3D/mezCfNIhthoi5ju+ZdABc5u1mFTSUSn5WztZEtOGiii0nrZlJVcLWANv
         E1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821347; x=1759426147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob07LuDFfKYbEaEx9P5dlQJ3PRLLB9y+zXQT8zPF5u4=;
        b=F61aNT+xWtzWXP+NSm9oc1/5nJPG5tNwNvwIaYoE4Mm+9uSed31MSc5CQSizZufPT/
         8ddT6Z7acGqd14y1w3I0/7898/8WLE/wWkuJuI+WXlBZQde+imQV254+jhTcGo5mILFw
         THnHOdKZ7FzqvYSCYqbPZH1nzu/YsqgXHXCpJ4xIVTJV5M+D+gdDj2Wdm15m4CoG25za
         d1pbUsM1Uq73hWl1JetnLzQ+jDUQWIN1sBOvjm+tbWoaHWV0/X6iYzJcpMMiKZjdiLtF
         Iz4k6Q6BGjyqLo2WPBswccoUxnHIpIRs7bSKhFlhYPhUqeS7Qd1xKYqv9LMTbvxZJB1q
         glzg==
X-Gm-Message-State: AOJu0YxJry6y3jEyhL3U6fBlTw4qvD8O4DCazefMY95vTHPi8Eq7x64y
	NSEiFF4sj9J+EAh6doK38seoWMIopzHhsuiKqDoQreGbk2+zBnDXBcEhbCPzSZhi59sQgKZ+aFB
	On4MmLwx6k4m9UxPtnHwDYQKTthRg9wX9KaV5DN2U9USlmuhECUYcfqHenktlJOsFwUlniqhKK+
	z318tsopwEv4XzdfRPiH8J9r/t8Tpf8+ShRqhEECjzjRM=
X-Google-Smtp-Source: AGHT+IGQw7sH7xaAAsUIkXDLS372Nk/6XXhYM+efdWLqBDD0tTIWBSnqczrJaPgwMMUtg7JkLEtOw/7Ing==
X-Received: from pfbde17.prod.google.com ([2002:a05:6a00:4691:b0:77a:60b9:2099])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a6:b0:249:84dc:e0cb
 with SMTP id adf61e73a8af0-2e7c85532c3mr5211979637.18.1758821346819; Thu, 25
 Sep 2025 10:29:06 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:32 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-5-sagis@google.com>
Subject: [PATCH v11 04/21] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
similar to SEV.

TDX sets the shared bit based on the guest physical address width and
currently supports 48 and 52 widths.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       | 14 ++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 12 ++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
new file mode 100644
index 000000000000..286d5e3c24b1
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_TDX_UTIL_H
+#define SELFTESTS_TDX_TDX_UTIL_H
+
+#include <stdbool.h>
+
+#include "kvm_util.h"
+
+static inline bool is_tdx_vm(struct kvm_vm *vm)
+{
+	return vm->type == KVM_X86_TDX_VM;
+}
+
+#endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 82369373e843..2a44831e0cc9 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "sev.h"
+#include "tdx/tdx_util.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -1160,12 +1161,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
+	uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR);
+
+	vm->arch.sev_fd = -1;
+
 	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
-	} else {
-		vm->arch.sev_fd = -1;
+	} else if (is_tdx_vm(vm)) {
+		TEST_ASSERT(gpa_bits == 48 || gpa_bits == 52,
+			    "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR value: %u", gpa_bits);
+		vm->arch.s_bit = BIT_ULL(gpa_bits - 1);
+		vm->gpa_tag_mask = vm->arch.s_bit;
 	}
 }
 
-- 
2.51.0.536.g15c5d4f767-goog


