Return-Path: <linux-kselftest+bounces-29657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B132EA6E0F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE85D3AC037
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A2265CC5;
	Mon, 24 Mar 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSNqBUvf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B326562C
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837583; cv=none; b=mdKuILaLcPjtQ3JmQ2IzvvRHTjQqBBh1OZOFTIb5NYmvUcukvpbAuTxgWTzP6bR5/8WLJpy1vKYMwhf9tcbgCwW4zQlaOF0fMceOxdynZe0Xtgu+Uc3M+J1210sBOHYEpyHTjXg8TWNRdKV/VKazTSj6m6vJhK9Q/i0B25JguM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837583; c=relaxed/simple;
	bh=9rhZJv3o4U2efMEBmplCAD4VQ1xqI3/o9m3fZyWbtWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rTAHpuUHd4a6RtYHs8godat9ddhmKXJeXrsOm8IdDtD5bPZ8tb3Kd6CPorTc2BL+rSQANf8VpgXSKhpVnUhldPgXE4XW21sgrUPhDUxzv3HhahljGn/zLeY1li05KjAzUU5l0i+o5r3ulzESR8U4JXzvag1FZv6qHQ48cfWZ/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VSNqBUvf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so7349251a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837581; x=1743442381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tKKNrD4nKMnN1mUr26p1zzV8EuNLOk0hiGR0cZe9rjY=;
        b=VSNqBUvfmVOqK3mM3hfysDvVhcY872DInaVvGZGrr+vnyftW4kfzRnLr3UJGIXdbjt
         lEdfEprBCn2u4uaeZOmQIYNfKwT8VVlgOXYGB64kAp3pjexB71wfSlRe/dXxYIPD9scF
         cPGyJN8tVqDiLPTxObKDgQBSv9UchrOcKNxbTjhmTjqrG4er8QbUxWfuqgQiLMkwidoc
         ik9Irg9EkomGXJlj10PksJUGB/yKptKr5LhekUqAM2HK85fp+LaBnjtlsgzXz2oIRGLB
         blRtAfieWTyTd6c4D998JIdEyLbc9jVv7KXyyEsx+uznPuS8Ycj52cSSCB9uMBASW39g
         RGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837581; x=1743442381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKKNrD4nKMnN1mUr26p1zzV8EuNLOk0hiGR0cZe9rjY=;
        b=WiD00sud8q/Gqu1o6+6OJkZEpwEKSeXjvEoZF9U/Xf+3MVOm3Q7rMAw2g4z5jDnL67
         F9zizixHbpY2xSszAmjPxakYqbE5ncgEH/ZGQHCAuDzZWDA+tIn3n56MwUcvQm5rUX+D
         6q5t3xz9mCu/Kv7OlzSTyNT1KmySatn0ZbL1rhc3dDkfx35naGnSatypV0+KN5aZASwS
         xNZqeO+cRBk2TD+7NdJXRQ5fN1WsVih2dGPc7SEwQ5B0+LEwV/plRdxfeHe8hl2McSCZ
         Z1StcPqIaAQpl2RL+NlSYJIAkNHhb2y9hOrj7qhZWVHzq+CPS5COyx16gwSXdSnefs0d
         L0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp8vGPhe51ltelopz3YZ6hEeUQni5SUBJlDVHaiPHMidqjP4ynr4w9ZzIxIxgzxdniJ7zA/WmRfS83cpLGpkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XL3Er/+N5ZA8Ifo/+x2u+UXWfrCvcX/x9LV28QiK5af4SSdC
	tuSY6pxm61s6k3N6PtoJbF+/bMhtEycGbp6AYvjtgeZ+MSkTX5wnfJadzzVHbJJsxQjcltvr5dm
	VISYG2w==
X-Google-Smtp-Source: AGHT+IHBetavi3mTLVBEXyB04t1yw41hTE62aogD8Pkaru0jucbwplRgcbjX/OZoofxCfWlf0uf1KWGy1Jry
X-Received: from pjf11.prod.google.com ([2002:a17:90b:3f0b:b0:2fa:1803:2f9f])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3148:b0:2ee:bbe0:98c6
 with SMTP id 98e67ed59e1d1-3030fe928eemr17984594a91.8.1742837581399; Mon, 24
 Mar 2025 10:33:01 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:46 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-7-mizhang@google.com>
Subject: [PATCH v4 06/38] x86/irq: Factor out common code for installing kvm
 irq handler
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

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

KVM will register irq handler for POSTED_INTR_WAKEUP_VECTOR and
KVM_GUEST_PMI_VECTOR, the existing kvm_set_posted_intr_wakeup_handler() is
renamed to x86_set_kvm_irq_handler(), and vector input parameter is used
to distinguish POSTED_INTR_WARKUP_VECTOR and KVM_GUEST_PMI_VECTOR.

Caller should call x86_set_kvm_irq_handler() once to register
a non-dummy handler for each vector. If caller register one
handler for a vector, later the caller register the same or different
non-dummy handler again, the second call will output warn message.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/irq.h |  2 +-
 arch/x86/kernel/irq.c      | 18 ++++++++++++------
 arch/x86/kvm/vmx/vmx.c     |  4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 194dfff84cb1..050a247b69b4 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -30,7 +30,7 @@ struct irq_desc;
 extern void fixup_irqs(void);
 
 #if IS_ENABLED(CONFIG_KVM)
-extern void kvm_set_posted_intr_wakeup_handler(void (*handler)(void));
+void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void));
 #endif
 
 extern void (*x86_platform_ipi_callback)(void);
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 385e3a5fc304..18cd418fe106 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -312,16 +312,22 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
 static void dummy_handler(void) {}
 static void (*kvm_posted_intr_wakeup_handler)(void) = dummy_handler;
 
-void kvm_set_posted_intr_wakeup_handler(void (*handler)(void))
+void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void))
 {
-	if (handler)
+	if (!handler)
+		handler = dummy_handler;
+
+	if (vector == POSTED_INTR_WAKEUP_VECTOR &&
+	    (handler == dummy_handler ||
+	     kvm_posted_intr_wakeup_handler == dummy_handler))
 		kvm_posted_intr_wakeup_handler = handler;
-	else {
-		kvm_posted_intr_wakeup_handler = dummy_handler;
+	else
+		WARN_ON_ONCE(1);
+
+	if (handler == dummy_handler)
 		synchronize_rcu();
-	}
 }
-EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wakeup_handler);
+EXPORT_SYMBOL_GPL(x86_set_kvm_irq_handler);
 
 /*
  * Handler for POSTED_INTERRUPT_VECTOR.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6c56d5235f0f..00ac94535c21 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8279,7 +8279,7 @@ void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 
 void vmx_hardware_unsetup(void)
 {
-	kvm_set_posted_intr_wakeup_handler(NULL);
+	x86_set_kvm_irq_handler(POSTED_INTR_WAKEUP_VECTOR, NULL);
 
 	if (nested)
 		nested_vmx_hardware_unsetup();
@@ -8583,7 +8583,7 @@ __init int vmx_hardware_setup(void)
 	if (r && nested)
 		nested_vmx_hardware_unsetup();
 
-	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
+	x86_set_kvm_irq_handler(POSTED_INTR_WAKEUP_VECTOR, pi_wakeup_handler);
 
 	return r;
 }
-- 
2.49.0.395.g12beb8f557-goog


