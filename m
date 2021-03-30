Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3024034E2CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhC3IJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 04:09:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14199 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhC3IJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 04:09:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8hqQ5ZTSzmcCx;
        Tue, 30 Mar 2021 16:06:42 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 16:09:09 +0800
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
Subject: [PATCH v6 07/10] KVM: selftests: Add a helper to get system default hugetlb page size
Date:   Tue, 30 Mar 2021 16:08:53 +0800
Message-ID: <20210330080856.14940-8-wangyanan55@huawei.com>
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

If HUGETLB is configured in the host kernel, then we can know the system
default hugetlb page size through *cat /proc/meminfo*. Otherwise, we will
not see the information of hugetlb pages in file /proc/meminfo if it's not
configured. So add a helper to determine whether HUGETLB is configured and
then get the default page size by reading /proc/meminfo.

This helper can be useful when a program wants to use the default hugetlb
pages of the system and doesn't know the default page size.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/test_util.c   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index ef24c76ba89a..e087174eefe5 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -80,6 +80,7 @@ struct vm_mem_backing_src_alias {
 
 bool thp_configured(void);
 size_t get_trans_hugepagesz(void);
+size_t get_def_hugetlb_pagesz(void);
 void backing_src_help(void);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index efc1a7782de0..665724ccab97 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -146,6 +146,31 @@ size_t get_trans_hugepagesz(void)
 	return size;
 }
 
+size_t get_def_hugetlb_pagesz(void)
+{
+	char buf[64];
+	const char *tag = "Hugepagesize:";
+	FILE *f;
+
+	f = fopen("/proc/meminfo", "r");
+	TEST_ASSERT(f != NULL, "Error in opening /proc/meminfo");
+
+	while (fgets(buf, sizeof(buf), f) != NULL) {
+		if (strstr(buf, tag) == buf) {
+			fclose(f);
+			return strtoull(buf + strlen(tag), NULL, 10) << 10;
+		}
+	}
+
+	if (feof(f))
+		TEST_FAIL("HUGETLB is not configured in host kernel");
+	else
+		TEST_FAIL("Error in reading /proc/meminfo");
+
+	fclose(f);
+	return 0;
+}
+
 void backing_src_help(void)
 {
 	int i;
-- 
2.19.1

