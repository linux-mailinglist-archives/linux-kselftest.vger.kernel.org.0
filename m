Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2003334E2CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhC3IJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 04:09:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15103 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhC3IJM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 04:09:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8hqs4k0gz19Jq6;
        Tue, 30 Mar 2021 16:07:05 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 16:09:01 +0800
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
Subject: [PATCH v6 02/10] mm/hugetlb: Add a macro to get HUGETLB page sizes for mmap
Date:   Tue, 30 Mar 2021 16:08:48 +0800
Message-ID: <20210330080856.14940-3-wangyanan55@huawei.com>
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

We know that if a system supports multiple hugetlb page sizes,
the desired hugetlb page size can be specified in bits [26:31]
of the mmap() flag arguments. The value in these 6 bits will be
the shift of each hugetlb page size.

So add a macro to get the page size shift and then calculate the
corresponding hugetlb page size, using flag x.

Cc: Ben Gardon <bgardon@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 include/uapi/linux/mman.h       | 2 ++
 tools/include/uapi/linux/mman.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..d72df73b182d 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -41,4 +41,6 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+#define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index f55bc680b5b0..d72df73b182d 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -41,4 +41,6 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+#define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
+
 #endif /* _UAPI_LINUX_MMAN_H */
-- 
2.19.1

