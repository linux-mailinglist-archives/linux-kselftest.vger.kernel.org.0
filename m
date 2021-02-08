Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93472312CE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhBHJMH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 04:12:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12488 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhBHJJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 04:09:50 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DZ0Xf2sm8zjL4s;
        Mon,  8 Feb 2021 17:07:30 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Feb 2021 17:08:45 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Andrew Jones" <drjones@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH 1/2] KVM: selftests: Add a macro to get string of vm_mem_backing_src_type
Date:   Mon, 8 Feb 2021 17:08:40 +0800
Message-ID: <20210208090841.333724-2-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210208090841.333724-1-wangyanan55@huawei.com>
References: <20210208090841.333724-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a macro to get string of the backing source memory type, so that
application can add choices for source types in the help() function,
and users can specify which type to use for testing.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 5cbb861525ed..f5fc29dc9ee6 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -69,7 +69,9 @@ enum vm_guest_mode {
 #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
 
 #define vm_guest_mode_string(m) vm_guest_mode_string[m]
+#define vm_mem_backing_src_type_string(s) vm_mem_backing_src_type_string[s]
 extern const char * const vm_guest_mode_string[];
+extern const char * const vm_mem_backing_src_type_string[];
 
 struct vm_guest_mode_params {
 	unsigned int pa_bits;
@@ -83,6 +85,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS,
 	VM_MEM_SRC_ANONYMOUS_THP,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB,
+	NUM_VM_BACKING_SRC_TYPES,
 };
 
 int kvm_check_cap(long cap);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fa5a90e6c6f0..a9b651c7f866 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -165,6 +165,14 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
 
+const char * const vm_mem_backing_src_type_string[] = {
+	"VM_MEM_SRC_ANONYMOUS        ",
+	"VM_MEM_SRC_ANONYMOUS_THP    ",
+	"VM_MEM_SRC_ANONYMOUS_HUGETLB",
+};
+_Static_assert(sizeof(vm_mem_backing_src_type_string)/sizeof(char *) == NUM_VM_BACKING_SRC_TYPES,
+	       "Missing new source type strings?");
+
 /*
  * VM Create
  *
-- 
2.23.0

