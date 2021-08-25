Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF23F76AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhHYN7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 09:59:47 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:53856 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHYN7q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 09:59:46 -0400
IronPort-SDR: 5c3Zyep2JLRD8+wLRpZVe3AoaXiLoTYnLk1kGRSOHiomBfUl3qMxGc/6Q9AjDUO0GcE0Yhj5xQ
 V58EHPUh3hx17ryLq966sNgnuZSrZeva57bz7xuwfmCGJ8AiwE1EABDBe+cXHOJyVpzOlWBW9h
 Vo2naqeJyQjuVTq8AHWs5FRbQ626HGEvpEl3kBFcr99rF3IB2UDbYZSc70GirR5idh32bgsxtM
 WfI0BxQHGZ0KZ28N8mxYbvtgOuthaTVz1JtGIuNGgRieJ3wCi9KB26ANsBNPjx86oF3POYJI77
 tcOubP/b0M8X4JgHdSpsRAV3
X-IronPort-AV: E=Sophos;i="5.84,350,1620720000"; 
   d="scan'208";a="65095157"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 25 Aug 2021 05:59:01 -0800
IronPort-SDR: DA+BhndMeNe0SoZixKpNKA6Ap9wxyrw+2VEhDQpoiTYNDaOj6zyP8bSOGZSDPnP/Ip4ygW5ElQ
 kQ7jR94Yo1NrSqZx/SqCPjhpLbd1XNgjy6Lt6ijBw7F+r0n+cIPWnCCmxC9UKJN2yDlPBV8hQn
 9o48U8Za8hSxV7CBLmvWCV09rwMNwPe+I1v8A62P9GEAsDR1qKkVCg1Sy7OMLtQZI48q/vfz3o
 oqn0UmOUAtY1/M+6clbmuhbDIJKuJhbKo1vTtptDHPmUzYl3fM1esqmgNrt2eAjzPJSppqgzrN
 kA8=
From:   "George G. Davis" <george_davis@mentor.com>
To:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <george_davis@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>
Subject: [RFC][PATCH] selftests/vm/transhuge-stress: fix ram size thinko
Date:   Wed, 25 Aug 2021 09:58:43 -0400
Message-ID: <20210825135843.29052-1-george_davis@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "George G. Davis" <davis.george@siemens.com>

When executing transhuge-stress with an argument to specify the virtual
memory size for testing, the ram size is reported as 0, e.g.

transhuge-stress 384
thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 0 MiB of ram
thp-mmap: 0.184 s/loop, 0.957 ms/page,   2090.265 MiB/s  192 succeed,    0 failed

This appears to be due to a thinko in commit 0085d61fe05e
("selftests/vm/transhuge-stress: stress test for memory compaction"),
where, at a guess, the intent was to base "xyz MiB of ram" on `ram`
size. Here are results after using `ram` size:

thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 14 MiB of ram

Fixes: 0085d61fe05e ("selftests/vm/transhuge-stress: stress test for memory compaction")
Signed-off-by: George G. Davis <davis.george@siemens.com>
---
 tools/testing/selftests/vm/transhuge-stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
index fd7f1b4a96f9..5e4c036f6ad3 100644
--- a/tools/testing/selftests/vm/transhuge-stress.c
+++ b/tools/testing/selftests/vm/transhuge-stress.c
@@ -79,7 +79,7 @@ int main(int argc, char **argv)
 
 	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
 	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
-	      len >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
+	      ram >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
 
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
-- 
2.17.1

