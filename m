Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7451324A54
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Feb 2021 07:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhBYGAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Feb 2021 01:00:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12204 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbhBYGAh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Feb 2021 01:00:37 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmMWz4q96zlPwg;
        Thu, 25 Feb 2021 13:57:51 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 13:59:47 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        "Yanan Wang" <wangyanan55@huawei.com>
Subject: [RFC PATCH v2 4/7] KVM: selftests: Add a helper to get system configured THP page size
Date:   Thu, 25 Feb 2021 13:59:37 +0800
Message-ID: <20210225055940.18748-5-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210225055940.18748-1-wangyanan55@huawei.com>
References: <20210225055940.18748-1-wangyanan55@huawei.com>
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
---
 .../testing/selftests/kvm/include/test_util.h |  2 ++
 tools/testing/selftests/kvm/lib/test_util.c   | 36 +++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index c7c0627c6842..f2d133f76c67 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -10,6 +10,7 @@
 #include <limits.h>
 #include <stdlib.h>
 #include <time.h>
+#include <sys/stat.h>
 #include "linux/kernel.h"
 
 #include "test_util.h"
@@ -117,6 +118,41 @@ const struct vm_mem_backing_src_alias backing_src_aliases[] = {
 	{"anonymous_hugetlb", VM_MEM_SRC_ANONYMOUS_HUGETLB,},
 };
 
+bool thp_configured(void)
+{
+	int ret;
+	struct stat statbuf;
+
+	ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
+	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
+		    "Error in stating /sys/kernel/mm/transparent_hugepage: %d",
+		    errno);
+
+	return ret == 0;
+}
+
+size_t get_trans_hugepagesz(void)
+{
+	size_t size;
+	char buf[16];
+	FILE *f;
+
+	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
+
+	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
+	TEST_ASSERT(f != NULL,
+		    "Error in opening transparent_hugepage/hpage_pmd_size: %d",
+		    errno);
+
+	if (fread(buf, sizeof(char), sizeof(buf), f) == 0) {
+		fclose(f);
+		TEST_FAIL("Unable to read transparent_hugepage/hpage_pmd_size");
+	}
+
+	size = strtoull(buf, NULL, 10);
+	return size;
+}
+
 void backing_src_help(void)
 {
 	int i;
-- 
2.19.1

