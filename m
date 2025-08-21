Return-Path: <linux-kselftest+bounces-39439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED81B2ECDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5871F189AF7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494C2E8DEB;
	Thu, 21 Aug 2025 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpqreYqD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2B244685
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750574; cv=none; b=fmzF0RB8hkSWtwM5G2DbM2LFpivBepyW6AHfkKqAc3QTNcL7CwnURJtNPEFn/Tqr4EcBJKonmykZFmSzusIkwlXGqr5F0A/Qcz7MLsdIWZF6fMtj2MgF41davkoiQmyqt2Yxs/4AyiR0yfpnRCc7M82uEk57K4X13l+ezfib8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750574; c=relaxed/simple;
	bh=tr/kYasvhaM7kVMspgyv9tdsJx7ARbBqJCQJSG2OYi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5Cgz0RFaT7aXVCb/Yj3FCQzGEsAfwiWIo9ArX+o6J7kdDGtfSWcNfS5naDOltEJnH/XP0pZU34JCLDdwn+/Q4qkb4oBeHRsjp3KdnFYFa9IGHohZ7m8XVVPnI6fsWjVtfZaExm+6mdgFVTRR6mrCx+CL9GTU/y2tryqScFuOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpqreYqD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47173bb3daso458502a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750572; x=1756355372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNhncePcfevR9BqJj7luu3cgXc4QyqZzLOry8PLvlQ=;
        b=ZpqreYqD8a0OmPbwsDDpAcUV4VmzH+w6jJ4C5V3hnFs7JC5SvwxRmm+WprqN75I3Wq
         IDAkIpM67XuCorLeyrWY/SDaNVSqvpL4REMBtIA/t0ngtWMjsJkxZg7ejk/fGWhfx+If
         65vzyLOhB259560/H+ZG8S3Dlk8n7G0UjFwdbcL1rUD4azh/Qar3huVXoGcsYrsoGiGf
         kWVtaQEpp7tnHxsVKW3xYVOmnEPHxjucRWJ9soRq8/XiqU4TaYCOs3ogSKo8avrxlz3N
         c7IEcGs/JTkeBxHtfQCfyJMRaWovW8AVj311ueXRPb7d87VAo63fAwk+E3BYmiWSc8rN
         FfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750572; x=1756355372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNhncePcfevR9BqJj7luu3cgXc4QyqZzLOry8PLvlQ=;
        b=JmtW0+0VXMQL8aLSLBzaoPTDurs4X/Nl3WXEPBVAFmuMELjQu4ak78nIxCTXUbkuZy
         JzTfjb9+bUMHCE93+IEMcdKfiAtFr9vGlLHDwVnvJqYlbEkNg2w4hezOBgfX8DN8EHHZ
         w0Ja6uy22vqO7PwX5oZKPeDhLnG/veAUDmvA0p/WIOKkOhj94WH2Gq6YHFZ9X18kgD80
         jbT79H+y0ULBmKMMZCOMOtXw5jPBnyQLP9S/XLtS15t6TkdXUDhaenOUhumWH/SiQo/q
         wdD6KeI6eMieH4zNheL6vIxm79udtjBcATmIcu5knnq9eerJbTPD7ati7qIbveX6HMvH
         /1KA==
X-Gm-Message-State: AOJu0Yw0hFaZvXJ7TK0rJLkTlloS3kycj1iHhhI2DXDtQDuF6SEmpVVn
	y+Mv92tXsTyHofViroZ6Dpgr4zuaw41fzf6mq3eUfGLh58bFzwGzJXwfh/00XpEmb4Wj5AqJ2I4
	w7I5jOR08OvrjUr8hgon/f/zKyX9MVfuhHgrATXHwLwTpfsu8un56PVnI6L16i2h//9uXiiX2PV
	OkDcKglssjTmL5+vFlGqeQ0CF/IiozkCpnJPhq05QwqVM=
X-Google-Smtp-Source: AGHT+IFHt8bMa7jB5MANhdG47UreNFuDH8fmYAoZds65ocGLlqKumuv8qls/N0mgvNCEDLrPY4SlSjc9EQ==
X-Received: from pjyp4.prod.google.com ([2002:a17:90a:e704:b0:321:6924:af9a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68b:b0:240:2145:e51f
 with SMTP id d9443c01a7336-245febe11dcmr17946895ad.3.1755750571576; Wed, 20
 Aug 2025 21:29:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:58 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-6-sagis@google.com>
Subject: [PATCH v9 05/19] KVM: selftests: Update kvm_init_vm_address_properties()
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
index 1eae92957456..6dbf40cbbc2a 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "sev.h"
+#include "tdx/tdx_util.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -1190,12 +1191,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
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
+		vm->arch.s_bit = 1ULL << (gpa_bits - 1);
+		vm->gpa_tag_mask = vm->arch.s_bit;
 	}
 }
 
-- 
2.51.0.rc1.193.gad69d77794-goog


