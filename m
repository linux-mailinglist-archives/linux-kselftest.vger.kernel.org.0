Return-Path: <linux-kselftest+bounces-40734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC878B432F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06CF582F9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2705288C3F;
	Thu,  4 Sep 2025 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAWG4MZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51637288513
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968912; cv=none; b=CXv3kahrD4ZfkPhTScy6g1R54dl9YBQ8OHxd7UbCShW5ntNxA3QjZUfPbHLN88Uy9lK47ZFhgXAMrgxdvqcn+uwnbXoPlqOlfUfvhMvtJkLAJ5TQJubmCMLn2RTB9NxaOWj+7AAN7RMQyaJbBNzoErPD9PGGoMsukM5qLsqaRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968912; c=relaxed/simple;
	bh=7B7lwBJ0jXTeacBWtIq12DWMmRMY2GhnIen+mcsaZ6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7vu4Y78N07MxzBS+HTkoW8vFAIruHGTtpCmlSCsoSr8j62B2KhSIatHyaOJRiQaXyzE1vGT6acQQ57Ynpu5/HV3AR+hjgXLgdJ4T8y7yfH+geBMowSX/ywd7/y7w3h/Eh+i0AN4yiSq8L41CC/0dVniXmXMzJO5sCe7WUeo+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAWG4MZM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso2231319a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968911; x=1757573711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YEQCBMmqJuzc9aQAf9Qk31e/qZjHLfuJ8wSwcpoTOE=;
        b=gAWG4MZMEg2jKegzM1onX4lLzdH8stlLSwErx0eGW+fJls3ZlbFG80SVnKFA18I3zJ
         2pe/fFlp7szapVeT+ibap3r4kShYKbezatqrc2hDiwKCFcYIUx7bTp18PKriv5gOQysr
         F8dMboJjoYNA3IsTCVoO/LNtGAi1Om03DottE5nAx4hM6PoHeJTHFXkoziByUIN8WtYT
         tc0NBQ1c9vp3to93Ajvh4f8qg6VqTa1VUj4axms1YVTm5xpy/6lh49PMNDBzOOe/b7TS
         j2N66cO3UhtLBCxg+EBLftklRYACEL9j9BX+BZqUoNSD9gFHhiu/3Qvs4T1jQMhaXEJE
         p9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968911; x=1757573711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YEQCBMmqJuzc9aQAf9Qk31e/qZjHLfuJ8wSwcpoTOE=;
        b=bM1Ahri4Qkyk3t+gxvgL+NvywsBwQB5SJ8wM11/mTjhcQwb5CKaijz6b4c/n4x5zgx
         vdsV3jThjhN15APJva9nX4PB0HynAb1bULQpME22hn/zqZhQgepJMZ0KvQROI5ZDm0U5
         g3uPgjf6qgHqObD1CwAAyi6oue97DWRADNs5yxk0LAlisgeNukjnAHEKWaCxN4cwLZRZ
         2yWVjSVOkmdc2hGjFUXiPsyvvLzCSHZthdNTKOhdiFORv/B11R2qM0uwnpAwxbsg6BEA
         phTEwwYuiqr67Mpz0soulj/b9qsItDSPU/PjHFyDS+OGac/mamb3hPa20kSz7HYtmO56
         zd6g==
X-Gm-Message-State: AOJu0YwlEsjyh/iqbpwwnK18UOF7EUHHML/ALwDBPb9RShREkmzw5dMA
	HTxwSNP1Pwb8fS9ziOzH4fFlNVpdOtO1RaoA6nQoUBPf0wPmM1OfsbvJ46cCYOmu2sh3hzh+rky
	CIND71IDxN3TydiRo0KSxy3UKc5YfRyB4oXDkJvOFxMeIE4Taa/rqUTuUFyAkiFwhTRflGbkJtX
	rA0vMJZTpX/eg4fFto3fUT7sp7rw87tYqJxyjVOEi7oqw=
X-Google-Smtp-Source: AGHT+IE9YYmncisXydvkAn1sJlRRuLIxllELyPyRwTcYcKt7NlhRMcgbBqYTWjEB12Ff/oJCvryXlzSM4Q==
X-Received: from pjh4.prod.google.com ([2002:a17:90b:3f84:b0:329:d461:98a4])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8c:b0:32b:6132:5f99
 with SMTP id 98e67ed59e1d1-32b61326264mr6170784a91.15.1756968910496; Wed, 03
 Sep 2025 23:55:10 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:35 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-6-sagis@google.com>
Subject: [PATCH v10 05/21] KVM: selftests: Expose segment definitons to
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
index 2a44831e0cc9..623168ea9a44 100644
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
2.51.0.338.gd7d06c2dae-goog


