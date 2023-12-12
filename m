Return-Path: <linux-kselftest+bounces-1747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1280F859
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C3F283E26
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103C65A62;
	Tue, 12 Dec 2023 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3hxvAxN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D512F
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d34b1ea914so697615ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414066; x=1703018866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IXZ/Kz3W3ByK8YMBqzR++sHVAa+56dFMX9xl5Pgrpw=;
        b=G3hxvAxNuRf06y89eMnZl05yqK+1D9TyT6UWwRp1Lb82EufkFDR8+H7IiX4AUPd0Kw
         lHPMiSZUllgCkS0F0BZWB+1hBH28lbFgAJUnZTosSty/bzHsjSndUuVyZo1AuHwec9XW
         qmq5Y89GbVQ7Ymy9Xj1StFPHxSsSww0at/6IoSBNLirq8CZiJA+fAQiLmlQ+3qROMhcm
         Z3W8MVJr3ZpJNAEG8N53OWVULypONS7FZhTMwrcFfZ0cqd/r/8z0AoJQpL/KupEES9Kk
         PInGRf6mZ40XMweSzD1comORX/aBe/9kAJ7wQs8OlkIyoH/E2TX1MFaiKV8NP7GSu6Lv
         RwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414066; x=1703018866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IXZ/Kz3W3ByK8YMBqzR++sHVAa+56dFMX9xl5Pgrpw=;
        b=qyYGiOTCuSueHIknedIflyQZDeBUUevATNPFCaldR0NG3r0vTHpAoU5+5DLVcTewbd
         h0pGMl5yF4dDxhERlwwNBuuCb6dEZUD5QrGL5Xjy50QQT78V+xoIKdCAM+ZNVdE4w4rp
         NNn/LhEHjoSphmW82uU6/SypUFJhYUMkpBK//YzKrjFhO89yh9eqbnT73blcryQDMphI
         Ptp1sA8tu1dI2/FSaoX8QBK5VwuAdJV/tUK9b29meR/q1nTzt4l3Fpw4iQqJQSwFTsMQ
         yFaY2/mKT8Q4ZFrmrMc7LopKnjL27aRpA/LmeU/Bhpl7ATR9uAg1tpQuQezkvtc2Uq+J
         H+5w==
X-Gm-Message-State: AOJu0YyrVb+eWLtLj1h35e4Hj8II42wP4Ug1hOgySelD0UPYgl92O5zh
	Dojltrx6JPmgI4qRkqphm1Qc9J/T67lk5fo+FvapADpDiket8TZZg8qQ/wS2LYIRdGeZq6mzczT
	5EL72pfBEdFOwcDP5nPDjJQDmiYwaNhQeYCHxsUPGqiWS9zqCP6rJPQPnRDB0a1zeh7qF5KU=
X-Google-Smtp-Source: AGHT+IHCffwCKUEir/hUa+wxKlgIZsW7Q0uq80M9XBnZnShUwvNubtMSkPlm9a1kVJd/ck7Aaoje3ZF82Q==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:903:22cd:b0:1d0:727b:8355 with SMTP id
 y13-20020a17090322cd00b001d0727b8355mr51732plg.1.1702414065371; Tue, 12 Dec
 2023 12:47:45 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:41 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-27-sagis@google.com>
Subject: [RFC PATCH v5 26/29] KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    | 21 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index b71bcea40b5c..12863a8beaae 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -6,6 +6,7 @@
 #include "kvm_util_base.h"
 
 #define TDG_VP_INFO 1
+#define TDG_VP_VEINFO_GET 3
 #define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
@@ -41,4 +42,24 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
 uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
+/*
+ * Used by the #VE exception handler to gather the #VE exception
+ * info from the TDX module. This is a software only structure
+ * and not part of the TDX module/VMM ABI.
+ *
+ * Adapted from arch/x86/include/asm/tdx.h
+ */
+struct ve_info {
+	uint64_t exit_reason;
+	uint64_t exit_qual;
+	/* Guest Linear (virtual) Address */
+	uint64_t gla;
+	/* Guest Physical Address */
+	uint64_t gpa;
+	uint32_t instr_len;
+	uint32_t instr_info;
+};
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve);
+
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index d8c4ab635c06..71d9f55007f7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -241,3 +241,22 @@ uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
 {
 	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
 }
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve)
+{
+	uint64_t ret;
+	struct tdx_module_output out;
+
+	memset(&out, 0, sizeof(struct tdx_module_output));
+
+	ret = __tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+
+	ve->exit_reason = out.rcx;
+	ve->exit_qual   = out.rdx;
+	ve->gla         = out.r8;
+	ve->gpa         = out.r9;
+	ve->instr_len   = out.r10 & 0xffffffff;
+	ve->instr_info  = out.r10 >> 32;
+
+	return ret;
+}
-- 
2.43.0.472.g3155946c3a-goog


