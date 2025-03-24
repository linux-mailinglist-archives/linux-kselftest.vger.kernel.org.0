Return-Path: <linux-kselftest+bounces-29670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED42A6E12F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044563B592D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A170268695;
	Mon, 24 Mar 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vxi7l72z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF28267F5D
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837605; cv=none; b=SQMIXHa0WYmwr5Zjs0+U7yceZA9MApZ9GjUPlEas63DmFAVgAoKH8tjJ0iv+UWlqClOvtxZP7j3MRfFAaoHtKZStYep1Qdju1W7e+xLLcO3qSXhnAxjohJV/vKMMYzRMDpu1/V4tLrfN20SWMGmm+q2sDV5kmuwSUVQIV1NnQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837605; c=relaxed/simple;
	bh=X0TQbSNZ2k8J/w0/hYiMGT/c4Mohm/WrFcB6ldk0fP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTpFLePzUqwlk8QNbEDScAM2VzcCHoaP3QMoFnLVgfcxWApKzP6UJc61Qt0d0re4GTGSi5KCOSVazbw9FBpvs0f06EJdByx0tWcfjknem/V3Wc0lccOO4YeMjwSrLUylkiscMeZkYI1gcD6xcyrhF1YyQ6TeqQY4+Q+3R3VU64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vxi7l72z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3011bee1751so7279653a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837603; x=1743442403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qanTXrz+w4TJOSGI45XCDuNPJKy6t1An1vEOy+VJFPI=;
        b=Vxi7l72zTXwhzeNwzxNWMFc9ZGDt5CF1zLHWuaiCC7ooIKbU+B0mVIfGotAYLrzUqC
         22GVPBYCuqIc5kAQh88RVfkQvywqJjT/Tq8gWaZrq0EQWGx1N3sFNwPTOVgri9WFUspu
         oCepEW7kMmALmW0r9hSlkdYbGMUU2sQkLjoISFq0Au71gK5p51IZ9x87otgEdF2IbyE0
         WclofmpyGHRBg27i70H7J0l1V68tWyJnQfepZNDw+xt3jFgG3TqJxqP+kiPJg+7NUfc2
         AvdKwP2H56CxmPMus0AeOc9RJVUosqvab5HERXDKuBNpD7mbmhPGgoNqO+2AtsPMgYA7
         cq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837603; x=1743442403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qanTXrz+w4TJOSGI45XCDuNPJKy6t1An1vEOy+VJFPI=;
        b=OKxbFz8xO3tItDTKPLRlaqYmV34+c9pjMrtEyM00x2twqtMd8T+4uWPu6/TGgKKAGP
         vjuWq2AVxEHNDC3FqxOSbEp02FDFOIds1s6+rboytpnJ4KjQtXnkHK7rH36Fic3/qhSc
         lWUxCIDN832v562vqHcEru58m1hLTB+ECPcn4GmyT/+EaugdF5jXkvRF8kCN0Z1Ikku3
         C3392/MJ2/H+tPu+RW46JE9pZg3Z/NVUYmNN36Ud0VIC6GRl3Kui3hYVpmXO6nch0Emf
         3bU0GltDwjCZRRY8ZOdVWE+/McywyNpdTLOGUbUsAZhRuR2sxmlIkuxUPLoAbHSe+elv
         xfkw==
X-Forwarded-Encrypted: i=1; AJvYcCWZn3R7vMAVHVGBxUgVlAmOGi0l+a4eCIGxHUMS8nsoFyJlB8v4u+5cIgVk0eNFQGWCGdwM0HJLOXAjLe1TYAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRT4OS2eTP3ktPEFQMNMX/bTeVj8JlX4Y0l3ItmM9hEl/81sz
	Veon78mDFItit5yEzoqBhbPaIJdpycQ8KrIzIlqhqp1c4tGfi5SMvCSxGYzPsUeKf8Jpb+MbnsK
	TmcdfUw==
X-Google-Smtp-Source: AGHT+IFylqOtzrCn8td/IyRUcTlqEyDEKm/kkkuG7qOaMhTvraXjC3+UngnEdhoJSJ60RacEffeNuZUcyLlK
X-Received: from pjk8.prod.google.com ([2002:a17:90b:5588:b0:2fc:ccfe:368])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ccf:b0:2ff:64a0:4a57
 with SMTP id 98e67ed59e1d1-3030feeb744mr18687157a91.26.1742837603274; Mon, 24
 Mar 2025 10:33:23 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:59 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-20-mizhang@google.com>
Subject: [PATCH v4 19/38] KVM: VMX: Add macros to wrap around {secondary,tertiary}_exec_controls_changebit()
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

Add macros around helpers that changes VMCS bits to simplify vmx exec ctrl
bits clearing and setting.

No function change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 20 +++++++-------------
 arch/x86/kvm/vmx/vmx.h |  8 ++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9c4b3c2b1d65..ff66f17d6358 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4471,19 +4471,13 @@ void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 
 	pin_controls_set(vmx, vmx_pin_based_exec_ctrl(vmx));
 
-	if (kvm_vcpu_apicv_active(vcpu)) {
-		secondary_exec_controls_setbit(vmx,
-					       SECONDARY_EXEC_APIC_REGISTER_VIRT |
-					       SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
-		if (enable_ipiv)
-			tertiary_exec_controls_setbit(vmx, TERTIARY_EXEC_IPI_VIRT);
-	} else {
-		secondary_exec_controls_clearbit(vmx,
-						 SECONDARY_EXEC_APIC_REGISTER_VIRT |
-						 SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
-		if (enable_ipiv)
-			tertiary_exec_controls_clearbit(vmx, TERTIARY_EXEC_IPI_VIRT);
-	}
+	secondary_exec_controls_changebit(vmx,
+					  SECONDARY_EXEC_APIC_REGISTER_VIRT |
+					  SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY,
+					  kvm_vcpu_apicv_active(vcpu));
+	if (enable_ipiv)
+		tertiary_exec_controls_changebit(vmx, TERTIARY_EXEC_IPI_VIRT,
+						 kvm_vcpu_apicv_active(vcpu));
 
 	vmx_update_msr_bitmap_x2apic(vcpu);
 }
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 8b111ce1087c..5c505af553c8 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -612,6 +612,14 @@ static __always_inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##b
 {												\
 	BUILD_BUG_ON(!(val & (KVM_REQUIRED_VMX_##uname | KVM_OPTIONAL_VMX_##uname)));		\
 	lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);				\
+}												\
+static __always_inline void lname##_controls_changebit(struct vcpu_vmx *vmx, u##bits val,	\
+						       bool set)				\
+{												\
+	if (set)										\
+		lname##_controls_setbit(vmx, val);						\
+	else											\
+		lname##_controls_clearbit(vmx, val);						\
 }
 BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)
 BUILD_CONTROLS_SHADOW(vm_exit, VM_EXIT_CONTROLS, 32)
-- 
2.49.0.395.g12beb8f557-goog


