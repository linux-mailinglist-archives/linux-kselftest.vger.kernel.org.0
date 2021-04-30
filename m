Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77D236F523
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Apr 2021 06:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhD3Ejq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Apr 2021 00:39:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17825 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhD3Ejq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Apr 2021 00:39:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FWfhV36fjzBrxk;
        Fri, 30 Apr 2021 12:36:26 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 30 Apr 2021
 12:38:50 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <shuah@kernel.org>, <sfr@canb.auug.org.au>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kirill.shutemov@linux.intel.com>,
        <yang.shi@linux.alibaba.com>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] khugepaged: selftests: remove debug_cow
Date:   Fri, 30 Apr 2021 13:11:17 +0800
Message-ID: <20210430051117.400189-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The debug_cow attribute had been removed since commit 4958e4d86ecb01
("mm: thp: remove debug_cow switch"), so remove it in selftest code too,
otherwise the khugepaged test will fail.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 tools/testing/selftests/vm/khugepaged.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 8b7582130..155120b67 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -86,7 +86,6 @@ struct settings {
 	enum thp_enabled thp_enabled;
 	enum thp_defrag thp_defrag;
 	enum shmem_enabled shmem_enabled;
-	bool debug_cow;
 	bool use_zero_page;
 	struct khugepaged_settings khugepaged;
 };
@@ -95,7 +94,6 @@ static struct settings default_settings = {
 	.thp_enabled = THP_MADVISE,
 	.thp_defrag = THP_DEFRAG_ALWAYS,
 	.shmem_enabled = SHMEM_NEVER,
-	.debug_cow = 0,
 	.use_zero_page = 0,
 	.khugepaged = {
 		.defrag = 1,
@@ -268,7 +266,6 @@ static void write_settings(struct settings *settings)
 	write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
 	write_string("shmem_enabled",
 			shmem_enabled_strings[settings->shmem_enabled]);
-	write_num("debug_cow", settings->debug_cow);
 	write_num("use_zero_page", settings->use_zero_page);
 
 	write_num("khugepaged/defrag", khugepaged->defrag);
@@ -304,7 +301,6 @@ static void save_settings(void)
 		.thp_defrag = read_string("defrag", thp_defrag_strings),
 		.shmem_enabled =
 			read_string("shmem_enabled", shmem_enabled_strings),
-		.debug_cow = read_num("debug_cow"),
 		.use_zero_page = read_num("use_zero_page"),
 	};
 	saved_settings.khugepaged = (struct khugepaged_settings) {
-- 
2.25.1

