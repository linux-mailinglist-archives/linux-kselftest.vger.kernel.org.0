Return-Path: <linux-kselftest+bounces-40740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5D1B4330F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDECA5E00FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ED72989BF;
	Thu,  4 Sep 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWQDuyD/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00248296BAB
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968922; cv=none; b=td+cDa7FlGpWLEgACej6CEnDHgL6V8pRuw+pARFF2GgBjgI1j1HU4MlN4wM/SqG1itIA8xTLtB5k3xdOh3AcOT67fPLJ679WVOg6a8cI6C6u6sqz7oFlXVhD8m3NwjhiO0ad4jgzlYi/uuQr3eLkHJ7jbITLqI1JD641l8RGF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968922; c=relaxed/simple;
	bh=DsOMXiVoMzD7AjveM4os7tdOwV3YpbNGpBZ+UsnN0/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AQhoGPlsU9vuCb08XntwE960sMx+Q86+lAlBlFfSm3ZyXx+kQ+jTMQM4cQSw/6oW42uZHeQWUA2c/bg62HTfP0cbqaQSvyk+Fxk5iYenhqmLw3OlETr6w8JnqQ+wtbdDnj9q+AvEM7bYa7l6hlx8QfLOKVuF71Oo79JJaMipHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWQDuyD/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32b58eeb874so605264a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968920; x=1757573720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDaZx4H9qbNOCPJR00gXyS56Y7NvQgh76OJPTkrUQig=;
        b=qWQDuyD/qBPabd13NsMt4lQL6jyNbe66Tn2CEmQNtNSgH9ETAWPNuimGpiVcES3Sln
         JQ7BdQYZpFYgHUQX1fpXhThKL0WcnRwKdIU7zoukjGl4YGminvbc6jr5Yi1pdtsjtaiY
         ctDQ+bV20eVrzbAAN5VUYMWgyvy5l4odfad5CuZO2Rqo4tV2Vykz1Qrs8YGunVpEJ4Lk
         y8+x6okmBl65rb0dvFOGR2cFzohe9LyffixNRQ7WNNqqrXw7gV60EpAa5BWISmhI65pV
         cLtVbN+tYLFBeKo17a5GVy8nUzs1D8JhO3zL4aVm/PGpXGRRqj5iEren83fqz2Hu3qUg
         k8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968920; x=1757573720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDaZx4H9qbNOCPJR00gXyS56Y7NvQgh76OJPTkrUQig=;
        b=XT4GWCS/+/cb1ANx109JCf99VF4X1gyorQtf3cMC4Q9AxOlIlBdRaKg9klo4lHY8YL
         gJkOKifXSu1syAQiDMRF3GVs71nX2L3Ggg7Q/niGUwa7X3cg84YlZgrwzrMTo4lM2Bt6
         /kC4XGh57ZIr+/Y0dqE8FT7boMQb+LQ3AzrFhyMQmHdnOsPIDPpAgbS6cqXdwtAgU3Jc
         3BAsl0h7Pmm2fDVIUppnvwH9pqFTyoZQ2DkxUppq5NmGYCHe6sH1nk+3IzpvoSaerhus
         UNMt/QJrdGEIbBt2UfSNLxlB/e3ilyA0nTCFEHb9K8xKwPNit4VccoEE9nyHB67tkDaO
         MdYg==
X-Gm-Message-State: AOJu0YwSWUFriLgkSf5boxAEkPClmxQJs8+6/b4lK8TolhYZ2RoTNZ4x
	GBEmG9mJb9s5dlrD4wjXbpNDcNDGz6iKuIoipWoCtQ+uI0sIjwJC7jF15vqhTq/B0rRuC9Yj6eg
	6te3Wgm+kVhJRzVsJrH5kdAjuWESVg6UqVo69sU8uDBE/gt6zuTB/cuDVZ1kNC0IuIxeymKgX2r
	6iGzMi6IYJtEJYSQ/izz5M42SAJJ+1Wtatt2jQjEHJcsY=
X-Google-Smtp-Source: AGHT+IFwkf7FIzU9KeSXQcb1R3yIatVLrOEcgEEjvXReXde8fLVjRfRLB+K0+EJVwCWgTd750O/qpZWEUg==
X-Received: from pjbcz11.prod.google.com ([2002:a17:90a:d44b:b0:324:e6a7:84ce])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3809:b0:329:dff0:701b
 with SMTP id 98e67ed59e1d1-329dff070c6mr14129656a91.17.1756968920139; Wed, 03
 Sep 2025 23:55:20 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:41 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-12-sagis@google.com>
Subject: [PATCH v10 11/21] KVM: selftests: Add helper to initialize TDX VM
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

KVM_TDX_INIT_VM needs to be called after KVM_CREATE_VM and before
creating any VCPUs, thus before KVM_SET_CPUID2. KVM_TDX_INIT_VM accepts
the CPUID values directly.

Since KVM_GET_CPUID2 can't be used at this point, calculate the CPUID
values manually by using kvm_get_supported_cpuid() and filter the
returned CPUIDs against the supported CPUID values read from the TDX
module.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  54 +++++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 132 ++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index dafdc7e46abe..a2509959c7ce 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,6 +11,60 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+/*
+ * TDX ioctls
+ */
+
+#define __vm_tdx_vm_ioctl(vm, cmd, metadata, arg)			\
+({									\
+	int r;								\
+									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (uint32_t)(metadata),				\
+		.data = (uint64_t)(arg),				\
+	} };								\
+									\
+	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+	r ?: tdx_cmd.c.hw_error;					\
+})
+
+#define vm_tdx_vm_ioctl(vm, cmd, flags, arg)				\
+({									\
+	int ret = __vm_tdx_vm_ioctl(vm, cmd, flags, arg);		\
+									\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
+})
+
+#define __vm_tdx_vcpu_ioctl(vcpu, cmd, metadata, arg)			\
+({									\
+	int r;								\
+									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (uint32_t)(metadata),				\
+		.data = (uint64_t)(arg),				\
+	} };								\
+									\
+	r = __vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+	r ?: tdx_cmd.c.hw_error;					\
+})
+
+#define vm_tdx_vcpu_ioctl(vcpu, cmd, flags, arg)			\
+({									\
+	int ret = __vm_tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
+									\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (vcpu)->vm);	\
+})
+
+void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes);
+
 void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
 void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus);
 void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index ff61333bc848..aa0cb6c2205b 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -127,3 +127,135 @@ void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 
 	vcpu_params->guest_code = (uint64_t)guest_code;
 }
+
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
+{
+	struct kvm_tdx_capabilities *tdx_cap = NULL;
+	int nr_cpuid_configs = 4;
+	int rc = -1;
+	int i;
+
+	do {
+		nr_cpuid_configs *= 2;
+
+		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
+					   sizeof(tdx_cap->cpuid) +
+					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
+		TEST_ASSERT(tdx_cap,
+			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
+			    nr_cpuid_configs);
+
+		tdx_cap->cpuid.nent = nr_cpuid_configs;
+		rc = __vm_tdx_vm_ioctl(vm, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+	} while (rc < 0 && errno == E2BIG);
+
+	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
+		    rc, errno);
+
+	pr_debug("tdx_cap: supported_attrs: 0x%016llx\n"
+		 "tdx_cap: supported_xfam 0x%016llx\n",
+		 tdx_cap->supported_attrs, tdx_cap->supported_xfam);
+
+	for (i = 0; i < tdx_cap->cpuid.nent; i++) {
+		const struct kvm_cpuid_entry2 *config = &tdx_cap->cpuid.entries[i];
+
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
+			 i, config->function, config->index,
+			 config->eax, config->ebx, config->ecx, config->edx);
+	}
+
+	return tdx_cap;
+}
+
+static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capabilities *cap,
+						      uint32_t leaf, uint32_t sub_leaf)
+{
+	struct kvm_cpuid_entry2 *config;
+	uint32_t i;
+
+	for (i = 0; i < cap->cpuid.nent; i++) {
+		config = &cap->cpuid.entries[i];
+
+		if (config->function == leaf && config->index == sub_leaf)
+			return config;
+	}
+
+	return NULL;
+}
+
+/*
+ * Filter CPUID based on TDX supported capabilities
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   cpuid_data - CPUID fileds to filter
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * For each CPUID leaf, filter out non-supported bits based on the capabilities reported
+ * by the TDX module
+ */
+static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
+				struct kvm_cpuid2 *cpuid_data)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+	struct kvm_cpuid_entry2 *config;
+	struct kvm_cpuid_entry2 *e;
+	int i;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	i = 0;
+	while (i < cpuid_data->nent) {
+		e = cpuid_data->entries + i;
+		config = tdx_find_cpuid_config(tdx_cap, e->function, e->index);
+
+		if (!config) {
+			int left = cpuid_data->nent - i - 1;
+
+			if (left > 0)
+				memmove(cpuid_data->entries + i,
+					cpuid_data->entries + i + 1,
+					sizeof(*cpuid_data->entries) * left);
+			cpuid_data->nent--;
+			continue;
+		}
+
+		e->eax &= config->eax;
+		e->ebx &= config->ebx;
+		e->ecx &= config->ecx;
+		e->edx &= config->edx;
+
+		i++;
+	}
+
+	free(tdx_cap);
+}
+
+void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_init_vm *init_vm;
+	const struct kvm_cpuid2 *tmp;
+	struct kvm_cpuid2 *cpuid;
+
+	tmp = kvm_get_supported_cpuid();
+
+	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
+	vm_tdx_filter_cpuid(vm, cpuid);
+
+	init_vm = calloc(1, sizeof(*init_vm) +
+			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
+	TEST_ASSERT(init_vm, "init_vm allocation failed");
+
+	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
+	free(cpuid);
+
+	init_vm->attributes = attributes;
+
+	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
+
+	free(init_vm);
+}
-- 
2.51.0.338.gd7d06c2dae-goog


