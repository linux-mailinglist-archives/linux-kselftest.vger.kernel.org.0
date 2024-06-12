Return-Path: <linux-kselftest+bounces-11756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5929050A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 12:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C20B22B27
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC6916C870;
	Wed, 12 Jun 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qhKumtty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11C16C685;
	Wed, 12 Jun 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189111; cv=none; b=LA/26Y+l7xqr5qZ9QeOkOkQA/RnZVTXAuhpBLZXZY48ObxPVBQYbjnRU9WTN/Bf6vu1oRrkaIQBXsXgvaOL2NcJvBH7iFv8Kc5K2FAmxW/86yW9fVxUn5OCsXxNVEKFXaeG1+A+EjwqiYFZDGWsJWiH6/Rl/qzQ9nZ7V1Kjm36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189111; c=relaxed/simple;
	bh=mGIzQ5ew1VIe645IAxdq+2P+BLh9Fz+FTEcGLy6hS1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5xpEDBbidLMcMAmAHS13djV6NLKcd65WjcsCjl/ejvO596g7NFoCTwxzXSPCcMQYSh0G+TaAVzG53xWwnToCrDi0HC3Jq8bvPTE6GVoizXsr/RNiiDWq6lKthdyHYYQMQHIC1SKe/E8tWvjRkFoNELkgAhdvm1yLQNqvKZ79Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qhKumtty; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718189107;
	bh=mGIzQ5ew1VIe645IAxdq+2P+BLh9Fz+FTEcGLy6hS1U=;
	h=From:To:Cc:Subject:Date:From;
	b=qhKumttyixzROJAaVyga+0WqyXI1mxmnyD5t3dQ1T804gSvUYNNFQRvbTF+Mf/tLX
	 Z0oJQpmqGJ4tIJ/6d5KaAWO9b+VPA58OTjVuDKzvFPD6eAl4B9+GQ0Q0Fd6Km+JkTB
	 wADIsBkU5HtY1BZ2JQV6+3dcf15qVKeOg9SyKnkbhTi7AjEMKKoDy9J8k/eutTCY70
	 SVpccrD9JFdyWSJqHMYp5OcwSy7A+8A6w4/TDRstbMSrO26xADqrJ9HVvb0ANK2JXK
	 h84cxCGIgBUWRuWUwpyZxizqAz+JeVickxRyDpVi5T+27gwjaXbzGX0CruK55qyuW0
	 12Y0zUCY8tLUQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 510333782199;
	Wed, 12 Jun 2024 10:45:01 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Thomas Huth <thuth@redhat.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kernel@collabora.com,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: kvm: remove print_skip()
Date: Wed, 12 Jun 2024 15:44:53 +0500
Message-Id: <20240612104500.425012-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace print_skip() with ksft_exit_skip() to simplify the code and
directly use the skip API provided by kselftest.h.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../testing/selftests/kvm/aarch64/vgic_init.c  |  4 ++--
 .../testing/selftests/kvm/demand_paging_test.c |  3 +--
 tools/testing/selftests/kvm/dirty_log_test.c   |  8 +++-----
 .../testing/selftests/kvm/include/test_util.h  |  1 -
 tools/testing/selftests/kvm/lib/assert.c       |  6 ++----
 tools/testing/selftests/kvm/lib/test_util.c    | 11 -----------
 tools/testing/selftests/kvm/s390x/memop.c      | 18 ++++++------------
 .../selftests/kvm/x86_64/hyperv_cpuid.c        | 13 +++++--------
 .../kvm/x86_64/hyperv_extended_hypercalls.c    |  6 ++----
 .../selftests/kvm/x86_64/ucna_injection_test.c |  6 ++----
 10 files changed, 23 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index b3b5fb0ff0a9a..556c3230eb093 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -757,8 +757,8 @@ int main(int ac, char **av)
 	}
 
 	if (!cnt_impl) {
-		print_skip("No GICv2 nor GICv3 support");
-		exit(KSFT_SKIP);
+		ksft_exit_skip("No GICv2 nor GICv3 support\n");
 	}
+
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 0202b78f8680a..ae60b3a5fb9e5 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -353,8 +353,7 @@ int main(int argc, char *argv[])
 
 int main(void)
 {
-	print_skip("__NR_userfaultfd must be present for userfaultfd test");
-	return KSFT_SKIP;
+	ksft_exit_skip("__NR_userfaultfd must be present for userfaultfd test\n");
 }
 
 #endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index aacf80f574391..e5d3b01ec9508 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -692,11 +692,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	uint32_t ring_buf_idx = 0;
 	int sem_val;
 
-	if (!log_mode_supported()) {
-		print_skip("Log mode '%s' not supported",
-			   log_modes[host_log_mode].name);
-		return;
-	}
+	if (!log_mode_supported())
+		ksft_exit_skip("Log mode '%s' not supported\n",
+			       log_modes[host_log_mode].name);
 
 	/*
 	 * We reserve page table for 2 times of extra dirty mem which
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849ff..472fce41737e0 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -35,7 +35,6 @@ static inline int _no_printf(const char *format, ...) { return 0; }
 #define pr_info(...) _no_printf(__VA_ARGS__)
 #endif
 
-void __printf(1, 2) print_skip(const char *fmt, ...);
 #define __TEST_REQUIRE(f, fmt, ...)				\
 do {								\
 	if (!(f))						\
diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index b49690658c606..33651f5b3a7fd 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -85,10 +85,8 @@ test_assert(bool exp, const char *exp_str,
 		}
 		va_end(ap);
 
-		if (errno == EACCES) {
-			print_skip("Access denied - Exiting");
-			exit(KSFT_SKIP);
-		}
+		if (errno == EACCES)
+			ksft_exit_skip("Access denied - Exiting\n");
 		exit(254);
 	}
 
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae8373..6e8ac25403bb3 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -121,17 +121,6 @@ struct timespec timespec_div(struct timespec ts, int divisor)
 	return timespec_add_ns((struct timespec){0}, ns);
 }
 
-void print_skip(const char *fmt, ...)
-{
-	va_list ap;
-
-	assert(fmt);
-	va_start(ap, fmt);
-	vprintf(fmt, ap);
-	va_end(ap);
-	puts(", skipping test");
-}
-
 bool thp_configured(void)
 {
 	int ret;
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index f2df7416be847..d7cd4b4eb6228 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -884,10 +884,8 @@ static void test_copy_key_fetch_prot_override(void)
 
 	guest_0_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, 0);
 	guest_last_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, last_page_addr);
-	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
-		print_skip("did not allocate guest pages at required positions");
-		goto out;
-	}
+	if (guest_0_page != 0 || guest_last_page != last_page_addr)
+		ksft_exit_skip("did not allocate guest pages at required positions\n");
 
 	HOST_SYNC(t.vcpu, STAGE_INITED);
 	t.run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
@@ -923,10 +921,8 @@ static void test_errors_key_fetch_prot_override_not_enabled(void)
 
 	guest_0_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, 0);
 	guest_last_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, last_page_addr);
-	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
-		print_skip("did not allocate guest pages at required positions");
-		goto out;
-	}
+	if (guest_0_page != 0 || guest_last_page != last_page_addr)
+		ksft_exit_skip("did not allocate guest pages at required positions\n");
 	HOST_SYNC(t.vcpu, STAGE_INITED);
 	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
 
@@ -944,10 +940,8 @@ static void test_errors_key_fetch_prot_override_enabled(void)
 
 	guest_0_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, 0);
 	guest_last_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, last_page_addr);
-	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
-		print_skip("did not allocate guest pages at required positions");
-		goto out;
-	}
+	if (guest_0_page != 0 || guest_last_page != last_page_addr)
+		ksft_exit_skip("did not allocate guest pages at required positions");
 	HOST_SYNC(t.vcpu, STAGE_INITED);
 	t.run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
 	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 4f5881d4ef66d..695c45635d257 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -144,10 +144,9 @@ int main(int argc, char *argv[])
 	free((void *)hv_cpuid_entries);
 
 	if (!kvm_cpu_has(X86_FEATURE_VMX) ||
-	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {
-		print_skip("Enlightened VMCS is unsupported");
-		goto do_sys;
-	}
+	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS))
+		ksft_exit_skip("Enlightened VMCS is unsupported\n");
+
 	vcpu_enable_evmcs(vcpu);
 	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
 	test_hv_cpuid(hv_cpuid_entries, true);
@@ -155,10 +154,8 @@ int main(int argc, char *argv[])
 
 do_sys:
 	/* Test system ioctl version */
-	if (!kvm_has_cap(KVM_CAP_SYS_HYPERV_CPUID)) {
-		print_skip("KVM_CAP_SYS_HYPERV_CPUID not supported");
-		goto out;
-	}
+	if (!kvm_has_cap(KVM_CAP_SYS_HYPERV_CPUID))
+		ksft_exit_skip("KVM_CAP_SYS_HYPERV_CPUID not supported\n");
 
 	test_hv_cpuid_e2big(vm, NULL);
 
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
index 949e08e98f315..d37212a27990b 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
@@ -47,10 +47,8 @@ int main(void)
 
 	/* Verify if extended hypercalls are supported */
 	if (!kvm_cpuid_has(kvm_get_supported_hv_cpuid(),
-			   HV_ENABLE_EXTENDED_HYPERCALLS)) {
-		print_skip("Extended calls not supported by the kernel");
-		exit(KSFT_SKIP);
-	}
+			   HV_ENABLE_EXTENDED_HYPERCALLS))
+		ksft_exit_skip("Extended calls not supported by the kernel\n");
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
index 57f157c06b393..1dcb37a1f0be9 100644
--- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
+++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
@@ -273,10 +273,8 @@ int main(int argc, char *argv[])
 	kvm_ioctl(vm->kvm_fd, KVM_X86_GET_MCE_CAP_SUPPORTED,
 		  &supported_mcg_caps);
 
-	if (!(supported_mcg_caps & MCG_CMCI_P)) {
-		print_skip("MCG_CMCI_P is not supported");
-		exit(KSFT_SKIP);
-	}
+	if (!(supported_mcg_caps & MCG_CMCI_P))
+		ksft_exit_skip("MCG_CMCI_P is not supported\n");
 
 	ucna_vcpu = create_vcpu_with_mce_cap(vm, 0, true, ucna_injection_guest_code);
 	cmcidis_vcpu = create_vcpu_with_mce_cap(vm, 1, false, cmci_disabled_guest_code);
-- 
2.39.2


