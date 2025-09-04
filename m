Return-Path: <linux-kselftest+bounces-40733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3CDB432F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0831B1C25C36
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77E288531;
	Thu,  4 Sep 2025 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emOewqRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEC2882AA
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968911; cv=none; b=O60qGkCXmyXJ1gUWn495275JHCNBoo96hKIaagRYzZS3ZddQC6TIM0XQhuq7B9Cvv91HOiwaidTFgaFZtW26MR9JaNgWDZ78B9unBcx49asPo+HcloPqSAErQZaomLAAHyZzTPJEjX12b675xgdKD486D1+D4RTzjCbyOMpPV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968911; c=relaxed/simple;
	bh=gbMGCJ4AmKTFx5ZP3d8/sR850NUZ8Nyfys/WO0gx5zQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2X+Kf3/omvjV6R0VyX3vQWM7z94/3dJQI3JEtSc7K7XoYTQqno1LtvWZFurjsQo75PG5NVRyGqrIhXhGnhKueHBZcGTNfmfdvebGF2Y9UsxPvCVi7vIUmNUDLwS5ZFZ+f7fv091R58T6/PSsaRCxo+TPcjzpXg2u1hmj7C8NdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emOewqRS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4fc06ba4c1so333193a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968909; x=1757573709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDDOgHIgq9qGhhvchsAZNjlKa2bwiovWK1PgQkjRy/c=;
        b=emOewqRSahTk0nN4wYhNazRIY1dPE+SpIACQU36S7xXNeCXvgptOkDU5yOLIHMZ0ZO
         ruNnxqqS7xA2VLit0xmDiwzx7PVTwNQBx2D592+MAMBMogOP9hqg976dl1C+yY64vqbN
         GqJhREIShbpZ+KWi96a1FJewejdHjD1LyO1S0Td2YIhvRvafNdufT9QA+ECO2ZRo5G7d
         S3JBMmIXNfZTvrlUNQHmGhPHqO3f9One9kKvkplzk/EL/Ogna9+uFvyz4NskrnUe5792
         WGhgfs5iYEwzEA0v1wYzLoXEPtaYnovzlUOqX2/SsihxXkJdYxoM/AM+njryOO1xYT1B
         U8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968909; x=1757573709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDDOgHIgq9qGhhvchsAZNjlKa2bwiovWK1PgQkjRy/c=;
        b=DqdA29e34vD6VZdvwANbqEAXjnCDUk0yqakl+S9fChZjihN/pelAk00h3XKcxgFIIM
         mkf0Rw7ztCsTNfzesnMjNLVp1o/HuZhKlh+yYPatvI6F9tK/gG4zbT7AYVE4bQj3G12p
         w002nDV36ZFtTov1hi5NM/nDfME2hq/J/C/y0fQZKJ12hkvSJ1rPLFqXLD7zc0hTeCy4
         OdsgC9BWHbC+Ar0hQIZjjQV31rmsmLo4bY+lNPQPxby4kCDONtabhO5jg88rEQWZ1MmD
         hKhRrlQEvq8iY6wvg68/zVC3KK/t5CNthjqpB4O/hiwHW0aZO7PhmEh13N+tSkn6N1Tr
         xYmQ==
X-Gm-Message-State: AOJu0YzWJXyL9l4WR9f8a0LfMznR4uvCO5USWnBq4WAq53NwrpT0Wd62
	u1g39m0AmP4rDskBXcDdEeTLnC3X7ZbL45Qpj24dw2yMAygdIeV3i3qbGwl1uVEpZZEUIESMA3C
	QNLoP4ZsoLKcKDTpDyJYXaqkNh99rS0tK8DGr8vTJTfjbMDqg9jEltqb8gWmpSkBZQSbLOJWnKT
	tqPzVFIef+bI629rAnk1n/lrZJ32nQMxXkcQhWDMwjbDQ=
X-Google-Smtp-Source: AGHT+IEJ3xueX8dywduwUXcV9xf6moiRuuQXOoidBruGPeNFQRdyoPhUvTZBSxs/kIbopXdVJcYw683Htw==
X-Received: from pgbdp9.prod.google.com ([2002:a05:6a02:f09:b0:b4c:2bd1:3d27])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258a:b0:24c:2fa1:fdd4
 with SMTP id adf61e73a8af0-24c2fa201c8mr1255804637.19.1756968909005; Wed, 03
 Sep 2025 23:55:09 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:34 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-5-sagis@google.com>
Subject: [PATCH v10 04/21] KVM: selftests: Update kvm_init_vm_address_properties()
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
2.51.0.338.gd7d06c2dae-goog


