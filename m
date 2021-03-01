Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C63277EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Mar 2021 08:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhCAHBT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Mar 2021 02:01:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12657 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhCAHBQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 02:01:16 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dprfs03gwzlR8S;
        Mon,  1 Mar 2021 14:57:25 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 14:59:21 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <yuzenghui@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH v3 2/8] tools headers: Add a macro to get HUGETLB page sizes for mmap
Date:   Mon, 1 Mar 2021 14:59:10 +0800
Message-ID: <20210301065916.11484-3-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210301065916.11484-1-wangyanan55@huawei.com>
References: <20210301065916.11484-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We know that if a system supports multiple hugetlb page sizes,
the desired hugetlb page size can be specified in bits [26:31]
of the flag arguments. The value in these 6 bits will be the
shift of each hugetlb page size.

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
---
 include/uapi/linux/mman.h       | 2 ++
 tools/include/uapi/linux/mman.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..8bd41128a0ee 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -41,4 +41,6 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+#define MAP_HUGE_PAGE_SIZE(x) (1 << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index f55bc680b5b0..8bd41128a0ee 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -41,4 +41,6 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+#define MAP_HUGE_PAGE_SIZE(x) (1 << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
+
 #endif /* _UAPI_LINUX_MMAN_H */
-- 
2.23.0

