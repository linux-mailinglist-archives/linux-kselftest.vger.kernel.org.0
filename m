Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6334E2C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhC3IJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 04:09:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15104 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhC3IJN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 04:09:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8hqs4Htrz19Jq2;
        Tue, 30 Mar 2021 16:07:05 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 16:08:59 +0800
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
Subject: [PATCH v6 01/10] tools/headers: sync headers of asm-generic/hugetlb_encode.h
Date:   Tue, 30 Mar 2021 16:08:47 +0800
Message-ID: <20210330080856.14940-2-wangyanan55@huawei.com>
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

This patch syncs contents of tools/include/asm-generic/hugetlb_encode.h
and include/uapi/asm-generic/hugetlb_encode.h. Arch powerpc supports 16KB
hugepages and ARM64 supports 32MB/512MB hugepages. The corresponding mmap
flags have already been added in include/uapi/asm-generic/hugetlb_encode.h,
but not tools/include/asm-generic/hugetlb_encode.h.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 tools/include/asm-generic/hugetlb_encode.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/asm-generic/hugetlb_encode.h b/tools/include/asm-generic/hugetlb_encode.h
index e4732d3c2998..4f3d5aaa11f5 100644
--- a/tools/include/asm-generic/hugetlb_encode.h
+++ b/tools/include/asm-generic/hugetlb_encode.h
@@ -20,13 +20,16 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
+#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
-- 
2.19.1

