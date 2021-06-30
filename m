Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C03B8594
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhF3PAL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 11:00:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38806 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhF3PAK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 11:00:10 -0400
Received: from 1.general.ppisati.uk.vpn ([10.172.193.134] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1lybem-0007i0-Qi; Wed, 30 Jun 2021 14:57:40 +0000
From:   Paolo Pisati <paolo.pisati@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: memory-hotplug: avoid spamming logs with dump_page(), ratio limit hot-remove error test
Date:   Wed, 30 Jun 2021 16:57:40 +0200
Message-Id: <20210630145740.54614-1-paolo.pisati@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While the offline memory test obey ratio limit, the same test with error
injection does not and tries to offline all the hotpluggable memory, spamming
system logs with hundreds of thousands of dump_page() entries, slowing system
down (to the point the test itself timeout and gets terminated) and excessive fs
occupation:

...
[ 9784.393354] page:c00c0000007d1b40 refcount:3 mapcount:0 mapping:c0000001fc03e950 index:0xe7b
[ 9784.393355] def_blk_aops
[ 9784.393356] flags: 0x3ffff800002062(referenced|active|workingset|private)
[ 9784.393358] raw: 003ffff800002062 c0000001b9343a68 c0000001b9343a68 c0000001fc03e950
[ 9784.393359] raw: 0000000000000e7b c000000006607b18 00000003ffffffff c00000000490d000
[ 9784.393359] page dumped because: migration failure
[ 9784.393360] page->mem_cgroup:c00000000490d000
[ 9784.393416] migrating pfn 1f46d failed ret:1
...

$ grep "page dumped because: migration failure" /var/log/kern.log | wc -l
2405558

$ ls -la /var/log/kern.log
-rw-r----- 1 syslog adm 2256109539 Jun 30 14:19 /var/log/kern.log

Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
---
 tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index b37585e6aa38..46a97f318f58 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -282,7 +282,9 @@ done
 #
 echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
 for memory in `hotpluggable_online_memory`; do
-	offline_memory_expect_fail $memory
+	if [ $((RANDOM % 100)) -lt $ratio ]; then
+		offline_memory_expect_fail $memory
+	fi
 done
 
 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
-- 
2.30.2

