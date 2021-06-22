Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B73B064D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jun 2021 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFVN5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Jun 2021 09:57:51 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39368 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231529AbhFVN5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Jun 2021 09:57:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=houwenlong93@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UdKmcSN_1624370132;
Received: from localhost(mailfrom:houwenlong93@linux.alibaba.com fp:SMTPD_---0UdKmcSN_1624370132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Jun 2021 21:55:32 +0800
From:   Hou Wenlong <houwenlong93@linux.alibaba.com>
To:     kvm@gver.kernel.org
Cc:     linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org
Subject: [PATCH] KVM: selftests: fix triple fault if ept=0 in dirty_log_test
Date:   Tue, 22 Jun 2021 21:55:32 +0800
Message-Id: <411ea2173f89abce56fc1fca5af913ed9c5a89c9.1624351343.git.houwenlong93@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 22f232d134e1 ("KVM: selftests: x86: Set supported CPUIDs on
default VM") moved vcpu_set_cpuid into vm_create_with_vcpus, but
dirty_log_test doesn't use it to create vm. So vcpu's CPUIDs is
not set, the guest's pa_bits in kvm would be smaller than the
value queried by userspace.

However, the dirty track memory slot is in the highest GPA, the
reserved bits in gpte would be set with wrong pa_bits.
For shadowpaing, page fault would fail in permission_fault and
be injected into guest. Since guest doesn't have idt, it finally
leads to vm_exit for triple fault.

Move vcpu_set_cpuid into vm_vcpu_add_default to set supported
CPUIDs on default vcpu, since almost all tests need it.

Fixes: 22f232d134e1 ("KVM: selftests: x86: Set supported CPUIDs on default VM")
Signed-off-by: Hou Wenlong <houwenlong93@linux.alibaba.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c         | 4 ----
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 3 +++
 tools/testing/selftests/kvm/steal_time.c           | 2 --
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a2b732cf96ea..8ea854d7822d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -375,10 +375,6 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 		uint32_t vcpuid = vcpuids ? vcpuids[i] : i;
 
 		vm_vcpu_add_default(vm, vcpuid, guest_code);
-
-#ifdef __x86_64__
-		vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
-#endif
 	}
 
 	return vm;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index efe235044421..595322b24e4c 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -600,6 +600,9 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
 	vcpu_set_mp_state(vm, vcpuid, &mp_state);
+
+	/* Setup supported CPUIDs */
+	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index fcc840088c91..a6fe75cb9a6e 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -73,8 +73,6 @@ static void steal_time_init(struct kvm_vm *vm)
 	for (i = 0; i < NR_VCPUS; ++i) {
 		int ret;
 
-		vcpu_set_cpuid(vm, i, kvm_get_supported_cpuid());
-
 		/* ST_GPA_BASE is identity mapped */
 		st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
 		sync_global_to_guest(vm, st_gva[i]);
-- 
2.31.1

