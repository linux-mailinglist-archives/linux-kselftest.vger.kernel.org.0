Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587A43E11EB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Aug 2021 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbhHEKGB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 06:06:01 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:47900 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234156AbhHEKGA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 06:06:00 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 06:06:00 EDT
IronPort-SDR: vaamKXEsIZb88hJ8qX91HpxT9PZILJS5Hc+vlrHxW/ZZNwyhH7VBYLYs3Z4bpG3yrGhepiOEcw
 hYu4RVjcsbjqlVR7OtJnb6Hfi/QN5xW69OdlGJI/UJS2cYX67VOYMLLIOoEpKkAqSrtDfqnem5
 TrdtBq2ZdxAf3lr4+o7d+2uazDOaOy8UtfkFCG6L9kxORjTdraWUajNszH9bYSk9mTfY0O2g5K
 4aQM60EGbnFqt0IEBU4KxrRHQaam+3055klT7tGW0CsSCJ49ficgSvVtKXLSDIOHHFHD+IPjIj
 pgstRPoZBizyX47Ldhoy1arh
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="18797132"
X-IronPort-AV: E=Sophos;i="5.84,296,1620658800"; 
   d="scan'208";a="18797132"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 05 Aug 2021 18:58:35 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 66430EB380;
        Thu,  5 Aug 2021 18:58:34 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B9B1EE37C2;
        Thu,  5 Aug 2021 18:58:33 +0900 (JST)
Received: from localhost.localdomain (luna3.soft.fujitsu.com [10.124.196.199])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id 96071400C23C5;
        Thu,  5 Aug 2021 18:58:33 +0900 (JST)
From:   Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To:     keescook@chromium.org, linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        misono.tomohiro@jp.fujitsu.com
Subject: [PATCH] selftest/lkdtm: Skip stack-entropy test if lkdtm is not available
Date:   Thu,  5 Aug 2021 19:12:36 +0900
Message-Id: <20210805101236.1140381-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Exit with return code 4 if lkdtm is not available like other tests
in order to properly skip the test.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
I saw the same problem reported here (on 5.14-rc4):
https://lore.kernel.org/lkml/2836f48a-d4e2-7f00-f06c-9f556fbd6332@linuxfoundation.org/

 tools/testing/selftests/lkdtm/stack-entropy.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/stack-entropy.sh b/tools/testing/selftests/lkdtm/stack-entropy.sh
index 1b4d95d575f8..14fedeef762e 100755
--- a/tools/testing/selftests/lkdtm/stack-entropy.sh
+++ b/tools/testing/selftests/lkdtm/stack-entropy.sh
@@ -4,13 +4,27 @@
 # Measure kernel stack entropy by sampling via LKDTM's REPORT_STACK test.
 set -e
 samples="${1:-1000}"
+TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
+KSELFTEST_SKIP_TEST=4
+
+# Verify we have LKDTM available in the kernel.
+if [ ! -r $TRIGGER ] ; then
+	/sbin/modprobe -q lkdtm || true
+	if [ ! -r $TRIGGER ] ; then
+		echo "Cannot find $TRIGGER (missing CONFIG_LKDTM?)"
+	else
+		echo "Cannot write $TRIGGER (need to run as root?)"
+	fi
+	# Skip this test
+	exit $KSELFTEST_SKIP_TEST
+fi
 
 # Capture dmesg continuously since it may fill up depending on sample size.
 log=$(mktemp -t stack-entropy-XXXXXX)
 dmesg --follow >"$log" & pid=$!
 report=-1
 for i in $(seq 1 $samples); do
-        echo "REPORT_STACK" >/sys/kernel/debug/provoke-crash/DIRECT
+        echo "REPORT_STACK" > $TRIGGER
 	if [ -t 1 ]; then
 		percent=$(( 100 * $i / $samples ))
 		if [ "$percent" -ne "$report" ]; then
-- 
2.31.1

