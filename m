Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE773C1F67
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 08:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGIGll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 02:41:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6782 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhGIGlk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 02:41:40 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLjz74D3DzXr5K;
        Fri,  9 Jul 2021 14:33:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 14:38:52 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 9 Jul 2021
 14:38:52 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <pbonzini@redhat.com>, <shuah@kernel.org>, <bgardon@google.com>,
        <wangyanan55@huawei.com>, <axelrasmussen@google.com>,
        <drjones@redhat.com>, <chenlifu@huawei.com>, <seanjc@google.com>,
        <vkuznets@redhat.com>, <dwmw@amazon.co.uk>,
        <joao.m.martins@oracle.com>, <yangyingliang@huawei.com>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/2] selftests: Fix vm_handle_exception undefined error
Date:   Fri, 9 Jul 2021 14:37:40 +0800
Message-ID: <20210709063741.355325-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Compile setftests on x86_64 occurs following error:
make -C tools/testing/selftests
...

x86_64/hyperv_features.c:618:2: warning: implicit declaration of function ‘vm_handle_exception’ [-Wimplicit-function-declaration]
  618 |  vm_handle_exception(vm, GP_VECTOR, guest_gp_handler);
/usr/bin/ld: /tmp/cclOnpml.o: in function `main':
tools/testing/selftests/kvm/x86_64/hyperv_features.c:618: undefined reference to `vm_handle_exception'
collect2: error: ld returned 1 exit status

The reason is that commit b78f4a596692 ("KVM: selftests: Rename vm_handle_exception")
renamed "vm_handle_exception" function to "vm_install_exception_handler" function.

Fix it by replacing "vm_handle_exception" with "vm_install_exception_handler"
in corresponding selftests files.

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 2 +-
 tools/testing/selftests/kvm/x86_64/mmu_role_test.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 42bd658f52a8..af27c7e829c1 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -615,7 +615,7 @@ int main(void)
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vm, VCPU_ID);
-	vm_handle_exception(vm, GP_VECTOR, guest_gp_handler);
+	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
 	pr_info("Testing access to Hyper-V specific MSRs\n");
 	guest_test_msrs_access(vm, addr_gva2hva(vm, msr_gva),
diff --git a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
index 523371cf8e8f..da2325fcad87 100644
--- a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
@@ -71,7 +71,7 @@ static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 	/* Set up a #PF handler to eat the RSVD #PF and signal all done! */
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vm, VCPU_ID);
-	vm_handle_exception(vm, PF_VECTOR, guest_pf_handler);
+	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
 
 	r = _vcpu_run(vm, VCPU_ID);
 	TEST_ASSERT(r == 0, "vcpu_run failed: %d\n", r);
-- 
2.32.0

