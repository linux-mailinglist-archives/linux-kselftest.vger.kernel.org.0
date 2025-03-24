Return-Path: <linux-kselftest+bounces-29682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED5FA6E168
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1545E3B6820
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB26826B093;
	Mon, 24 Mar 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7bVphVA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630B264F84
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837624; cv=none; b=AjiKXAvU7daCzCyxd76RtTTq4JbwVKKUAhLkAiiLnf7x3Lv0+NG1Ms90TOuGSck08t7+mVg67ge1irt+uknbacyfeSHQx2QsMI5vOV/0hwWlaX7ZRjPJseF2lwqilWu6y0IaUHWb1ieV39ZTLozB3ocx7rfDgWE5jn+BKxx60JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837624; c=relaxed/simple;
	bh=s6ocOzT71CXmbbBcXEYyjJ6D7W58hm1QwCnGVXZRsjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q10bY8QrAyTVVz2tOJI+DYbYnq8yCFnD+ECT0Hs2Ti8nbfUJ38SvPuSwQmZDg4PDVLMCH09EzKdzUSgn6C6aUL/vkwDkyUqnhtTtkjF/PDTvCvHxVN7RhzVTYKI9Hj1wMqsVXc5BEgwUg9TZq5snPnvl/TRVcQTAI/MN0Pftvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7bVphVA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3011bee1751so7280116a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837622; x=1743442422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6+V904KeUQ21IQza0CY3IXyrVqbjYbDjSx/YwFPJNc8=;
        b=B7bVphVAKFRdiBLk/ckAzE4Qx7EgpIr9Drzsub9aImOB15uXfu5cq6x3VZcPjcgyzh
         T0GgLWUC73LaQQ18uLZUuu1Cv4bj1Cg2mK7j08qz1AY3/nthuPlfwaMtvtbxMi/pFCMW
         HNhBp9trPImqUCmXXXsOlV1e+fvv0KzWYvciAAULcL/9uCxmS+vJw3GqEUxqi9OS4QPG
         b/EFHRA0bfkquAYPiqE6sFIYh/Jpk5CphwhHU7biwF7gU5e7feFl2h6IE/nM+FQisE7V
         95pNjnrFN/nAGzGmRSrFwmNUmvxlouitFMEdwxulh++RW/qsvDLJk/DB5mVV9PN53PDW
         i9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837622; x=1743442422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+V904KeUQ21IQza0CY3IXyrVqbjYbDjSx/YwFPJNc8=;
        b=eh+b/RvgjgrIt4GkulsGDsbiMLIMgsFXkxjMEH878AeNCWxStqKt4IEVll/a5/IQQk
         C/ytlCw0ixOVkrQTr6M0VIYLYVhKpExRXIPF4BWmTUWJM10ey1yQ+hocGFRwkdezpaiE
         gZvMXIsSG2mz18rIL2yKklNU7Q1OH2aLH6UphPnpy3n5e95ZXNa9vt1fB5naqHptVdeS
         gusPTV/3CFQgZDoGqSfdRQahgVCOtMPsR+W2WOqRVz2GawhyU2xD6FHKpXx1F79GKVmH
         LskRZpkav7rBErHiA4NxMbG7e2USWIJy3LZyn9Z3BAii0J42DqTJOXhRLKPSG2yRAE4f
         3cLg==
X-Forwarded-Encrypted: i=1; AJvYcCVInkmbhRKxJE9qPsOJbrKLVmQPa/5ZdOS01+Ov1QlXT11hjIhsQHMI6sHh9N1IQHe3RR4kjjXLtEEP9kziSUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfMTfJorlzVrqB+T63jBomQHuCrlMPq7f8CPUp6cMoVkyX3+M
	tcNM937DbdhvmSGvbJmN1J/gw39GYW3/8fTqoF2wu+chKV5g8zSrrASX/xsq6+1wdLrVSIAVNnh
	IPd/bYA==
X-Google-Smtp-Source: AGHT+IHIqBrwCBT2VgNzdu6a3SRF1WZmbb7R9Sly1cPBTsCVjyp/BdAE9Odk3iiE+395mJznbAYwK1AFqmr6
X-Received: from pjyd8.prod.google.com ([2002:a17:90a:dfc8:b0:2ff:5516:6add])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:45:b0:2ff:58a4:9db3
 with SMTP id 98e67ed59e1d1-3030ff0b351mr22679948a91.35.1742837622350; Mon, 24
 Mar 2025 10:33:42 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:11 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-32-mizhang@google.com>
Subject: [PATCH v4 31/38] KVM: nVMX: Add macros to simplify nested MSR
 interception setting
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add macros nested_vmx_merge_msr_bitmaps_xxx() to simplify nested MSR
interception setting. No function change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/vmx/nested.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ecf72394684d..cf557acf91f8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -613,6 +613,19 @@ static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
 						   msr_bitmap_l0, msr);
 }
 
+#define nested_vmx_merge_msr_bitmaps(msr, type)	\
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,	\
+					 msr_bitmap_l0, msr, type)
+
+#define nested_vmx_merge_msr_bitmaps_read(msr) \
+	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_R)
+
+#define nested_vmx_merge_msr_bitmaps_write(msr) \
+	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_W)
+
+#define nested_vmx_merge_msr_bitmaps_rw(msr) \
+	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_RW)
+
 /*
  * Merge L0's and L1's MSR bitmap, return false to indicate that
  * we do not use the hardware.
@@ -696,23 +709,13 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	 * other runtime changes to vmcs01's bitmap, e.g. dynamic pass-through.
 	 */
 #ifdef CONFIG_X86_64
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_FS_BASE, MSR_TYPE_RW);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_GS_BASE, MSR_TYPE_RW);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_FS_BASE);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_GS_BASE);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_KERNEL_GS_BASE);
 #endif
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_IA32_SPEC_CTRL, MSR_TYPE_RW);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_IA32_PRED_CMD, MSR_TYPE_W);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_SPEC_CTRL);
+	nested_vmx_merge_msr_bitmaps_write(MSR_IA32_PRED_CMD);
+	nested_vmx_merge_msr_bitmaps_write(MSR_IA32_FLUSH_CMD);
 
 	kvm_vcpu_unmap(vcpu, &map);
 
-- 
2.49.0.395.g12beb8f557-goog


