Return-Path: <linux-kselftest+bounces-40742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9AB4330E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A055A175782
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6129B217;
	Thu,  4 Sep 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBkF1H2F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD8299AA3
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968925; cv=none; b=Gf9Hok5mXNlU8RAEJhnA23Yr1VUpO/ndIPVOj5mxjnc45gu3DVL8RgJA3QWyiAWnz/LcozamKjq9YmKHQeu5rErX1yKRTbJa1YGt9XnhliLafO21oQqI/Z8L1E6Rse8Em3yS2X71aipaMXoStd6YJJujF8EomySYp7xalXmEcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968925; c=relaxed/simple;
	bh=GeCmIZcp73sN4bfgUEfC130l9bcLrxWIZQUoDTJWL1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k8VlAxFSWl8uai4LrMXR63ENVens0mGFbHPs/Wtwc6LPGoXsoZV8nyG39Y+SzC6hpfFMXTeuMK96NuwhzCAB+Tsntfd/Nf3YsokVvgkLmlolfW13LDqe6gCmE8kdukhIOfzGGUfEBZx8wMbOUSlbQueh+ls/RcLJdpuT31/En2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBkF1H2F; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f93fe3831so893866a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968923; x=1757573723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlHmyC/s2DMAn4LeE4kWGtmiYzzcSa5Wh+lZGt38VW0=;
        b=KBkF1H2FUITBXxNjfkhEI+4ye7TYibkiqkRYtXLgLAINJioYe7VrDcB2e0cvEvWXqD
         Ps89GW/WqG/x7C5m3AEyekupgO2CK7sBPhq/KJ6mmn18rzJlqp5/IvdptRpvwvC3JmCJ
         nFx+fJmzs8n/SFkcItBUEfaq5B/Y+1qh47DfNsS+YPUD0oHl6xshVoMJx+8oEXQxiVnU
         xJLdqHRYk9NPakR3WumBPcuI1Rd/l0DSVfM1zmW5Yrk9K+Q5KuY7gJRM0603c+YE3Mml
         YOzOdiL0TjcXvaaA9kwM8QlgzNMV4hEpovWqQciN5vFFollH3rcqTtdyYsjHFNO2RX3H
         J9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968923; x=1757573723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlHmyC/s2DMAn4LeE4kWGtmiYzzcSa5Wh+lZGt38VW0=;
        b=RS2ImJpCdkFGyEd8khSXM8BRGE8FXG6tC51ZDDQVShv8l+wDQcepDrp2lk6TLlxAUv
         vLDLglfuGoLAmj/f0wE7Gi+S1VkILfdXf5NY6SdIrjtkq2e3aXNCsdofc3eArh1yfIj1
         beAHy/ZCsgJpwwGf1N8ERa4NPOtzoU82aGQ7jbXbx3eie+IJrYDVGTy/EFoWSEW7ZAU8
         YgvozI6b2zVLZkIeXXMoRbygY+gzTUXLfBjzE2HN6zYTWYn5f+0qpPhQNLcwNAxGHFM5
         9lvvFukfG1SdxJmdyzIoNjnytpDr8ELh51wuknXZ/DZsXomFDnHsnk5Do3cT4SEBfUoA
         Uz3w==
X-Gm-Message-State: AOJu0Yy+cF9omsDbFAWhgaeqo/loz9xsLEUjjG7JT8I4HNzPcRbAQPTq
	Zgq9iBeelsBv6qChqCdCHoBA0/QefzakYyB8NS6/lOljGIdCe8X3IGIVHn9Wtz2EnmGvXcT7HYQ
	vCrAFlIdV+E559fyQLEsiiXywaXqeVabSgAOR0C04rB82zBDpnIqzgkh0vHE/aBFkVfWndM5gdg
	lN0I6USNgjidWBtGgAV6rTRUn/U2SWQdxD69A5YYpIHM0=
X-Google-Smtp-Source: AGHT+IFMenAkmxXYl1G7PJiglG5TLw/xUAw89iop9i9/oF33+c4PpyUOod1RcjChgVfS6I66JQJF7Gpydg==
X-Received: from pfbbv7.prod.google.com ([2002:a05:6a00:4147:b0:772:46da:4dd1])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a9:b0:24c:1f78:1803
 with SMTP id adf61e73a8af0-24c1f783314mr1248402637.38.1756968923008; Wed, 03
 Sep 2025 23:55:23 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:43 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-14-sagis@google.com>
Subject: [PATCH v10 13/21] KVM: selftests: Add helpers to init TDX memory and
 finalize VM
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

From: Ackerley Tng <ackerleytng@google.com>

TDX protected memory needs to be measured and encrypted before it can be
used by the guest. Traverse the VM's memory regions and initialize all
the protected ranges by calling KVM_TDX_INIT_MEM_REGION.

Once all the memory is initialized, the VM can be finalized by calling
KVM_TDX_FINALIZE_VM.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 61 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index a2509959c7ce..2467b6c35557 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
 void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
+void vm_tdx_finalize(struct kvm_vm *vm);
+
 #endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 1b5c01faf1cd..d5df2de81a75 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -273,3 +273,64 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 
 	free(init_vm);
 }
+
+static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
+				uint64_t gpa, uint64_t size)
+{
+	uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
+	struct kvm_tdx_init_mem_region mem_region = {
+		.source_addr = (uint64_t)source_pages,
+		.gpa = gpa,
+		.nr_pages = size / PAGE_SIZE,
+	};
+	struct kvm_vcpu *vcpu;
+
+	vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
+
+	TEST_ASSERT((mem_region.nr_pages > 0) &&
+		    ((mem_region.nr_pages * PAGE_SIZE) == size),
+		    "Cannot add partial pages to the guest memory.\n");
+	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
+		    "Source memory buffer is not page aligned\n");
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
+}
+
+static void load_td_private_memory(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		const struct sparsebit *protected_pages = region->protected_phy_pages;
+		const vm_paddr_t gpa_base = region->region.guest_phys_addr;
+		const uint64_t hva_base = region->region.userspace_addr;
+		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
+
+		sparsebit_idx_t i;
+		sparsebit_idx_t j;
+
+		if (!sparsebit_any_set(protected_pages))
+			continue;
+
+		TEST_ASSERT(region->region.guest_memfd != -1,
+			    "TD private memory must be backed by guest_memfd");
+
+		sparsebit_for_each_set_range(protected_pages, i, j) {
+			const uint64_t size_to_load = (j - i + 1) * vm->page_size;
+			const uint64_t offset =
+				(i - lowest_page_in_region) * vm->page_size;
+			const uint64_t hva = hva_base + offset;
+			const uint64_t gpa = gpa_base + offset;
+
+			vm_set_memory_attributes(vm, gpa, size_to_load,
+						 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+			tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
+		}
+	}
+}
+
+void vm_tdx_finalize(struct kvm_vm *vm)
+{
+	load_td_private_memory(vm);
+	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
+}
-- 
2.51.0.338.gd7d06c2dae-goog


