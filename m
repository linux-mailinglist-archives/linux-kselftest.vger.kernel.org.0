Return-Path: <linux-kselftest+bounces-29688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D6FA6E17D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E173A81C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2271264FA1;
	Mon, 24 Mar 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3+3ZEQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993926E170
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837632; cv=none; b=iKx7u79mlRzo7NK+RL8TEU03OsmAmCoRBvjP5p/zPM7RsmM65wnbMKqHbJiq/AD6TNQLPTIZurYR5T9uo1oxZUaaB8jwroB9s0d1N0J146YfHqIH4uZZ9el2ONN7td76z1ZxtXvYYi6otblX1NO0PWCovwyZ9NJdJWMK2uQEAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837632; c=relaxed/simple;
	bh=QEXTgCiBbEdS4w6CQHuGGcellK8LpBCCKx5tvc2kY/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RV3m5O2eq+E7YehFvu314N/tY4R/tfO0w2h6TYH63ghZvr1lHu691XxoqIyJA/zfSyoO59TJZSOAFhzvrl/sm/HQsNM3nm60ICy75kbNBR+nsikdSTLnRcnYDRuzootMVCEd5Dz2Lhmz3D86XTmbrOhYTzTl8TsPYXJV8pCSpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3+3ZEQt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff68033070so7314712a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837630; x=1743442430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dBqCRDl1BaUTi1HkHSsNxnlzCe4zXBNzKMIODcAHiYw=;
        b=M3+3ZEQtiHGdOCLYG5U2JoETd1v86mAbIQUuAb6hXUC1gJWNobZmKAX2w+iD9p8AmB
         dKhcNrwtqzBP5ME7WlIkA5CNBaMjch9CSSAfXaAFI88OV0kcsY6OiAC+WWjQogaGtNhi
         nk7n6fQuiwpU+k8prr4AMw1Dy/0832/PR0V8mkhh9ZisM6ZjNnlAAAq4a8qQNXjEP5gO
         6tItd+qliyDfuHzLXr8HIEm1/QQ4W+KsdT2B0yjA3wec4Cb1+s6Wm6+SxvkGPVPpDC5j
         No//eL2PUrBXvzXFxCZ0mj6V+UuvCnq3P5Yt8q5HMT8ZkvxU2P6/YKuTBRoOLUjQtevV
         pk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837630; x=1743442430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBqCRDl1BaUTi1HkHSsNxnlzCe4zXBNzKMIODcAHiYw=;
        b=IfcDkzsdl72Hq44yL1N9aleWeChl53yvhPNuSQouaznU/oFEGZhtEs4tjGGxdvzTqf
         euA3U1iUnnSPgINP+FY6eZByZ04kymOEci/sdK4Cjic7LCCbAzabLo/HnY4W2WfleHR4
         yLvfY09CzhGaPdEcH6R+i6LaIDPD6CZuEuAGgMSjkWsWLRzF2kCKOWcC/lvSqEKedGdY
         HF2oMaTQDwHIKClPEDdiBT/1AY5gkvPDhL3kB9ki3I7VwCBKvxlcWotxm7ZilQoPQViY
         aYJJtBsy7enNNFd6UsNdALX31pmIXwb3rytRKWfoBK+84vc77k8MYs1DIzK5QGkiHNya
         s7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7xtvzMYff89UYK8O+v+aDZzzJuCYleEpfXzmOIumPpkBUqk+uGjSDvPHZjVhskeILo8Izru/9S7PvZbsvY2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hGF18yR1QFKyHgcNG/eCVX/d5FLRwFHd5D6pEXWNa6j/ZTOf
	QleK7Pr6PGF4hDE4OgMbxbwzOc0Rs0FOIAYv5aRM3cuX6WEnjjJLL61E4qyPUC3QCO/ogaBapTE
	nsHKlJQ==
X-Google-Smtp-Source: AGHT+IFVMWyCCSqp8v1wmBp9ZYcVHAb3dnatY+7Oyg/sMKAHidEKkkuGwuo6xJ/wrZ6w/wGs3G6SoF1DmHcl
X-Received: from pjbpl3.prod.google.com ([2002:a17:90b:2683:b0:2fb:fa85:1678])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc7:b0:2ee:d371:3227
 with SMTP id 98e67ed59e1d1-3030fea3935mr26101748a91.17.1742837630569; Mon, 24
 Mar 2025 10:33:50 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:16 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-37-mizhang@google.com>
Subject: [PATCH v4 36/38] KVM: selftests: Add mediated vPMU supported for pmu tests
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

Mediated vPMU needs to call KVM_CAP_PMU_CAPABILITY ioctl to enable it.
Thus add a helper vm_create_with_one_vcpu_with_pmu() to create PMU
enabled VM and replace vm_create_with_one_vcpu() helper with this new
helper in pmu tests.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 +++++++++++++++++++
 .../selftests/kvm/x86/pmu_counters_test.c     |  4 +++-
 .../selftests/kvm/x86/pmu_event_filter_test.c |  8 ++++---
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4c4e5a847f67..a73b0b98be5e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -961,6 +961,9 @@ static inline struct kvm_vm *vm_create_shape_with_one_vcpu(struct vm_shape shape
 	return __vm_create_shape_with_one_vcpu(shape, vcpu, 0, guest_code);
 }
 
+struct kvm_vm *vm_create_with_one_vcpu_with_pmu(struct kvm_vcpu **vcpu,
+						void *guest_code);
+
 struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
 
 void kvm_pin_this_task_to_pcpu(uint32_t pcpu);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 33fefeb3ca44..18143ec2e751 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -545,6 +545,29 @@ struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm)
 	return vm_vcpu_recreate(vm, 0);
 }
 
+struct kvm_vm *vm_create_with_one_vcpu_with_pmu(struct kvm_vcpu **vcpu,
+						void *guest_code)
+{
+	struct kvm_vm *vm;
+	int r;
+
+	r = kvm_check_cap(KVM_CAP_PMU_CAPABILITY);
+	if (!(r & KVM_PMU_CAP_DISABLE))
+		return NULL;
+
+	vm = vm_create(1);
+
+	/*
+	 * KVM_CAP_PMU_CAPABILITY ioctl must be explicitly called to enable
+	 * mediated vPMU.
+	 */
+	vm_enable_cap(vm, KVM_CAP_PMU_CAPABILITY, !KVM_PMU_CAP_DISABLE);
+
+	*vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	return vm;
+}
+
 void kvm_pin_this_task_to_pcpu(uint32_t pcpu)
 {
 	cpu_set_t mask;
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 698cb36989db..441c66f314fb 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -40,7 +40,9 @@ static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 {
 	struct kvm_vm *vm;
 
-	vm = vm_create_with_one_vcpu(vcpu, guest_code);
+	vm = vm_create_with_one_vcpu_with_pmu(vcpu, guest_code);
+	assert(vm);
+
 	sync_global_to_guest(vm, kvm_pmu_version);
 
 	/*
diff --git a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
index c15513cd74d1..1c7d265a0003 100644
--- a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
@@ -822,8 +822,9 @@ static void test_fixed_counter_bitmap(void)
 	 * fixed performance counters.
 	 */
 	for (idx = 0; idx < nr_fixed_counters; idx++) {
-		vm = vm_create_with_one_vcpu(&vcpu,
-					     intel_run_fixed_counter_guest_code);
+		vm = vm_create_with_one_vcpu_with_pmu(&vcpu,
+						      intel_run_fixed_counter_guest_code);
+		assert(vm);
 		vcpu_args_set(vcpu, 1, idx);
 		__test_fixed_counter_bitmap(vcpu, idx, nr_fixed_counters);
 		kvm_vm_free(vm);
@@ -843,7 +844,8 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(use_intel_pmu() || use_amd_pmu());
 	guest_code = use_intel_pmu() ? intel_guest_code : amd_guest_code;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm = vm_create_with_one_vcpu_with_pmu(&vcpu, guest_code);
+	assert(vm);
 
 	TEST_REQUIRE(sanity_check_pmu(vcpu));
 
-- 
2.49.0.395.g12beb8f557-goog


