Return-Path: <linux-kselftest+bounces-42383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A51BA0E2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3661C4A18BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91C320A04;
	Thu, 25 Sep 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjrKtQUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D131FEDE
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821368; cv=none; b=P+sMxDhNVCXdfg80DB7izKItWJb6SXiwyRwBL1Xvson/sa1NdQ4GM2cKRpeIAmhZkkerB3GOfeYHM3sQu0LNFHhuFuVcAAUmUzfVitDpV+yCpc24PF/Yb+DcfD1tJLEuQzCUUozJUDcz6UwJzm1xlWsCkO44teG3jBjF9XeDNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821368; c=relaxed/simple;
	bh=rY4Ycxq8QNFfTlKpgKYsuMxxweY8g7PDper3LW3OHIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JjFpD6YJviImfuYlLsSpWx72UKM/qZPJohLheREqyCHAZtnoudvjUGdoV1zGB65wQv8U/Bf2KyIEey/0s+eQ25qo4vCVsxV8x8xLNZAHEh3LwxsbkJoxXZHhJNS/Aaj6NAyN4OdxMkVZi4pNIv1W/dg4EzfKi2KV3YCtW/eY4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjrKtQUa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso1755710a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821365; x=1759426165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Va1zA5ixIcyoN0vd3aUHA8j5zm7YdEz/wv0z/nEjSI=;
        b=PjrKtQUasguwa1WvXPLxu4Wc1i5O3pTuPDGhbO4bw4wXERkIsW9sC9VqTa8ocy9nWa
         J7b8uzlpcWXNidm/v/H2ZCwzuNhr1sRRaaWur2HJ/j4S6hTM+hiludjA/AiMgp29Tfc1
         bin52bNvbwlkjEpDfnz7txRbIf3VJOHhS5x1Rn8jmyFKmN4X8Z+mgnUrJ9vBhRhBjv3z
         J+UFQzu4oRzjf0jhHA0B+bYmOYnurbx7WSIQEkh9TDvS4wWoqpMLA2uTU6K9gWqb+sx6
         4qZv17FVoMqLFT/zIcsGzPIJ9mudQppHoLNm4gjXo7ea/Y2jWrdKozjpQacYKgxkFlRh
         WG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821365; x=1759426165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Va1zA5ixIcyoN0vd3aUHA8j5zm7YdEz/wv0z/nEjSI=;
        b=TjoX7ocUlGKS/WGWF1z8pts2SeOwCJcorf+RQTnJNzVfkRaa64NwyCpg5TwkOEriRv
         9UiydInP7wAx6H4RouyxDuOtjodnbAVlW5YK1bcbkfi7xXGyXbE/AZCWHKQG2qDqfkbv
         BPBdSUKvQYuTEAf5cMS3U76q4JOE52H7uG+IK77AwhuwU4HMDDqueeU4SKPuq3BqQuAy
         gX3IR8c2wlLBtQFBbHaXhECIyz6ZA30yZpLVmsPY8EupNVrujqb/cdxpH3GUvbHXuXKD
         m9DHxj9sxu0+l1sdvyZ3WYxcjU6Y8+o+/q/i9qdkKv4PEiFtNkMvXxvqH9kYClulR2MD
         RFKw==
X-Gm-Message-State: AOJu0YwoqNYXkrFqh85dHvEATuYUu3ZZI67QxCwNlfKEaJ88/LXr3vTP
	RD1odg+LErWICpxGl8tOP8A6qJF791/2fozdXChBpwunI6XZ5Oqk5PGQ3FjJ128EjJ8sQWDJIDj
	WYWU8ixjTA0HwsV3n0ErF+Q7yV1YSuXfnQ8BYMf3aFe95B6PA/17bRiG8rx1gP4p8L6hpJJNjB3
	TNYnOaqgxJQhwmMzsXieT8jkZ6s0jcOWReP2LefLY62Zc=
X-Google-Smtp-Source: AGHT+IGO+kzY6zrc5L2YijkKRhK8hVWCvgdGtGL5epGOc/asjJqUyFVd0BNC8oxEFQsxsY1921qPWa7JOQ==
X-Received: from pjbhl7.prod.google.com ([2002:a17:90b:1347:b0:32e:d644:b829])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5343:b0:32d:17ce:49d5
 with SMTP id 98e67ed59e1d1-3342a2b08bcmr4282494a91.23.1758821365169; Thu, 25
 Sep 2025 10:29:25 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:44 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-17-sagis@google.com>
Subject: [PATCH v11 16/21] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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

TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
vcpu creation.

Since the cpuids for TD are managed by the TDX module, read the values
virtualized for the TD using KVM_TDX_GET_CPUID and set them in kvm using
KVM_SET_CPUID2 so that kvm has an accurate view of the VM cpuid values.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/lib/x86/processor.c | 35 ++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 63b751253d1b..f7ddea3b2044 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -687,6 +687,19 @@ vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 	return stack_vaddr;
 }
 
+static void vm_tdx_vcpu_add(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid2 *cpuid;
+
+	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);
+	vcpu_init_cpuid(vcpu, cpuid);
+	free(cpuid);
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+
+	vm_tdx_load_vcpu_boot_parameters(vm, vcpu);
+}
+
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	struct kvm_mp_state mp_state;
@@ -694,15 +707,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct kvm_vcpu *vcpu;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
 
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = kvm_allocate_vcpu_stack(vm);
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vm)) {
+		vm_tdx_vcpu_add(vm, vcpu);
+	} else {
+		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
+
+		vcpu_init_sregs(vm, vcpu);
+		vcpu_init_xcrs(vm, vcpu);
+
+		/* Setup guest general purpose registers */
+		vcpu_regs_get(vcpu, &regs);
+		regs.rflags = regs.rflags | 0x2;
+		regs.rsp = kvm_allocate_vcpu_stack(vm);
+		vcpu_regs_set(vcpu, &regs);
+	}
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
-- 
2.51.0.536.g15c5d4f767-goog


