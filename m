Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8201134603F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 14:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhCWNxF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 09:53:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13672 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhCWNwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 09:52:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4Xn75h66znVCg;
        Tue, 23 Mar 2021 21:50:19 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 21:52:41 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, "Ingo Molnar" <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH v5 05/10] KVM: selftests: Make a generic helper to get vm guest mode strings
Date:   Tue, 23 Mar 2021 21:52:26 +0800
Message-ID: <20210323135231.24948-6-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210323135231.24948-1-wangyanan55@huawei.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For generality and conciseness, make an API which can be used in all
kvm libs and selftests to get vm guest mode strings. And the index i
is checked in the API in case of possiable faults.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  4 +--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 29 ++++++++++++-------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2d7eb6989e83..f52a7492f47f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -68,9 +68,6 @@ enum vm_guest_mode {
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
 #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
 
-#define vm_guest_mode_string(m) vm_guest_mode_string[m]
-extern const char * const vm_guest_mode_string[];
-
 struct vm_guest_mode_params {
 	unsigned int pa_bits;
 	unsigned int va_bits;
@@ -84,6 +81,7 @@ int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
 int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
 		    struct kvm_enable_cap *cap);
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
+const char *vm_guest_mode_string(uint32_t i);
 
 struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
 void kvm_vm_free(struct kvm_vm *vmp);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e5fbf16f725b..2ea837fe03af 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -143,17 +143,24 @@ static void vm_open(struct kvm_vm *vm, int perm)
 		"rc: %i errno: %i", vm->fd, errno);
 }
 
-const char * const vm_guest_mode_string[] = {
-	"PA-bits:52,  VA-bits:48,  4K pages",
-	"PA-bits:52,  VA-bits:48, 64K pages",
-	"PA-bits:48,  VA-bits:48,  4K pages",
-	"PA-bits:48,  VA-bits:48, 64K pages",
-	"PA-bits:40,  VA-bits:48,  4K pages",
-	"PA-bits:40,  VA-bits:48, 64K pages",
-	"PA-bits:ANY, VA-bits:48,  4K pages",
-};
-_Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
-	       "Missing new mode strings?");
+const char *vm_guest_mode_string(uint32_t i)
+{
+	static const char * const strings[] = {
+		[VM_MODE_P52V48_4K]	= "PA-bits:52,  VA-bits:48,  4K pages",
+		[VM_MODE_P52V48_64K]	= "PA-bits:52,  VA-bits:48, 64K pages",
+		[VM_MODE_P48V48_4K]	= "PA-bits:48,  VA-bits:48,  4K pages",
+		[VM_MODE_P48V48_64K]	= "PA-bits:48,  VA-bits:48, 64K pages",
+		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
+		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
+		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
+	};
+	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
+		       "Missing new mode strings?");
+
+	TEST_ASSERT(i < NUM_VM_MODES, "Guest mode ID %d too big", i);
+
+	return strings[i];
+}
 
 const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	{ 52, 48,  0x1000, 12 },
-- 
2.19.1

