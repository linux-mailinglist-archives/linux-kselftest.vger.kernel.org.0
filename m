Return-Path: <linux-kselftest+bounces-29659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64078A6E100
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BBC189701A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DF266B41;
	Mon, 24 Mar 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiwPhNRp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33D26656D
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837586; cv=none; b=rCpRaHVqpc8DEK3R7unYFxYLHRrtbrWPXQ0UJ9tAfToeT8rRu+G3HKzvt3FX06Z92zNAjpaaO4GmE2w+RaHZMRvdPbIA5q94wj5dwh97oPsFNmXhGYrT4h93T7viuOodkz864W8aSqOCCmLF2WTEMIf+F8GDkNth92PA1Q8b8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837586; c=relaxed/simple;
	bh=uSsfP2iUGKZAko91Ue51RA6jOzSPWpQLs2FQJIUEdN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KWgT5mtbC9azuetP5qD9eqx2byJoMd0z2+Ja91khKbherJSGyr9iSvlddX9RXK+JSB0O8VSJSGffK7r4k0uw8TTd6rvwhO8tJzNprJ6FUMQd+galFYL69qcjDTpbGFWrOno25jci15M1aparrvvlkkCJY01HfKNV3abzebF5Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiwPhNRp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so8784765a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837585; x=1743442385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kc+hvgN5vKkqFOj791yq3cFJDYHXw2rm6mE1S/YN0o=;
        b=QiwPhNRpfFfPtMxFJTrLQn4AXDUbhzYl8mvd6+DFh3bfrKshKFgQR7MT+Xat3OoAeL
         1lX1/U71RATrvgge7A8e93voA43N9Fp8hISfJInqFew1m3V4wnEHlmueEihajOekSMoi
         HnWm2oUm1QtS4uOePTn7v3sVfn45xRhwjLXGTry3Lkc/jwPw7UXrtKX1CSZ/SIJ/q123
         /5A954VGj22zF6+r+QB7ek0tE81yXM1APDEURJdIZKJ+JjhlnNJtzcQLR4gYFwiRHTlk
         +HV5G8C5VDghfYnAi8gLQ4ZpPg7hcbaCb7WrHnvnwfasNOFyZxBqp+iS4sgV7nbZtMI2
         STPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837585; x=1743442385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Kc+hvgN5vKkqFOj791yq3cFJDYHXw2rm6mE1S/YN0o=;
        b=qUmnkK1LsDtIXQ6J9F08DQjXQRAJcFONGU1n/FZXLnT6xh89m1O8uuEfjGeTqqSlDx
         Xe3iNxnjrYttgF4wtKPIoSBtETGOhN1yzLnrKahYCauJrDVaNtsBt9bZCLDiBRSOElvm
         IqcSyVbODLHSVmEcP1f8Ib9BWyOGkNhI4AeFT2sUjAEhLdcXeUGra+uTIXCFyXcon8ES
         keD/7bjHP8peun5L6j4bpTL22d7y5tTKmPF0n0ya3GR4QOjDBMSE0YC6x7/6qNM69MZG
         pg7bzh3mdgfGVMcaoYH+7qBwLpqW7Yv3g05feSra4A2vokf+VrqbAKtKnPLg2RcIqkbe
         3r6A==
X-Forwarded-Encrypted: i=1; AJvYcCV3rlo/kXnymkq8yANIMp2qeQ/KSxC9uwO10iaZH6LtwEUl5Ty3nJv8/Pzzj4g5n80hqBZRljkagzbeVUGjQwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFZdxleL0G1SKygKscZKH4A6AXTrKOgZOolMdPlz0B48WvYC2
	iV7PkABbu3qK/Rwij2Iu/KaV+GUFITKl7wFApfrXnfvtUNFjy0gyco3L78rHy1hS0GnAxI/EvHP
	w7BtWgA==
X-Google-Smtp-Source: AGHT+IGd6varlGCeyx7AQp9DEz54Ir4tI3Fr0sEZAmWQE+3Tt+2k7Q201qPQY7a5j8n0L8adjjUOD9PBqS3+
X-Received: from pjbsc2.prod.google.com ([2002:a17:90b:5102:b0:2ff:611c:bae8])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c81:b0:301:cba1:7ada
 with SMTP id 98e67ed59e1d1-3030fe56378mr20286185a91.1.1742837584784; Mon, 24
 Mar 2025 10:33:04 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:48 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-9-mizhang@google.com>
Subject: [PATCH v4 08/38] KVM: x86/pmu: Register KVM_GUEST_PMI_VECTOR handler
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

Add function to register/unregister guest KVM PMI handler at KVM module
initialization and destroy. This allows the host PMU with passthough
capability enabled can switch PMI handler at PMU context switch.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/x86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02159c967d29..72995952978a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13984,6 +13984,16 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
 }
 EXPORT_SYMBOL_GPL(kvm_sev_es_string_io);
 
+static void kvm_handle_guest_pmi(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (WARN_ON_ONCE(!vcpu))
+		return;
+
+	kvm_make_request(KVM_REQ_PMI, vcpu);
+}
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_entry);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_fast_mmio);
@@ -14021,12 +14031,14 @@ static int __init kvm_x86_init(void)
 
 	kvm_mmu_x86_module_init();
 	mitigate_smt_rsb &= boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible();
+	x86_set_kvm_irq_handler(KVM_GUEST_PMI_VECTOR, kvm_handle_guest_pmi);
 	return 0;
 }
 module_init(kvm_x86_init);
 
 static void __exit kvm_x86_exit(void)
 {
+	x86_set_kvm_irq_handler(KVM_GUEST_PMI_VECTOR, NULL);
 	WARN_ON_ONCE(static_branch_unlikely(&kvm_has_noapic_vcpu));
 }
 module_exit(kvm_x86_exit);
-- 
2.49.0.395.g12beb8f557-goog


