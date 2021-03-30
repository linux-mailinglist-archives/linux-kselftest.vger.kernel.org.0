Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7634E2C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhC3IJt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 04:09:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14959 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhC3IJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 04:09:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8hqy5YJ4zyNHZ;
        Tue, 30 Mar 2021 16:07:10 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 16:09:07 +0800
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
Subject: [PATCH v6 06/10] KVM: selftests: Add a helper to get system configured THP page size
Date:   Tue, 30 Mar 2021 16:08:52 +0800
Message-ID: <20210330080856.14940-7-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210330080856.14940-1-wangyanan55@huawei.com>
References: <20210330080856.14940-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If we want to have some tests about transparent hugepages, the system
configured THP hugepage size should better be known by the tests, which
can be used for kinds of alignment or guest memory accessing of vcpus...
So it makes sense to add a helper to get the transparent hugepage size.

With VM_MEM_SRC_ANONYMOUS_THP specified in vm_userspace_mem_region_add(),
we now stat /sys/kernel/mm/transparent_hugepage to check whether THP is
configured in the host kernel before madvise(). Based on this, we can also
read file /sys/kernel/mm/transparent_hugepage/hpage_pmd_size to get THP
hugepage size.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 .../testing/selftests/kvm/include/test_util.h |  2 ++
 tools/testing/selftests/kvm/lib/test_util.c   | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index b7f41399f22c..ef24c76ba89a 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -78,6 +78,8 @@ struct vm_mem_backing_src_alias {
 	enum vm_mem_backing_src_type type;
 };
 
+bool thp_configured(void);
+size_t get_trans_hugepagesz(void);
 void backing_src_help(void);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index c7c0627c6842..efc1a7782de0 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -10,6 +10,7 @@
 #include <limits.h>
 #include <stdlib.h>
 #include <time.h>
+#include <sys/stat.h>
 #include "linux/kernel.h"
 
 #include "test_util.h"
@@ -117,6 +118,34 @@ const struct vm_mem_backing_src_alias backing_src_aliases[] = {
 	{"anonymous_hugetlb", VM_MEM_SRC_ANONYMOUS_HUGETLB,},
 };
 
+bool thp_configured(void)
+{
+	int ret;
+	struct stat statbuf;
+
+	ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
+	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
+		    "Error in stating /sys/kernel/mm/transparent_hugepage");
+
+	return ret == 0;
+}
+
+size_t get_trans_hugepagesz(void)
+{
+	size_t size;
+	FILE *f;
+
+	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
+
+	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
+	TEST_ASSERT(f != NULL, "Error in opening transparent_hugepage/hpage_pmd_size");
+
+	fscanf(f, "%ld", &size);
+	fclose(f);
+
+	return size;
+}
+
 void backing_src_help(void)
 {
 	int i;
-- 
2.19.1

