Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2A6F1BB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbjD1PfP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbjD1PfL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1375244;
        Fri, 28 Apr 2023 08:35:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF3p1x013972;
        Fri, 28 Apr 2023 15:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=A8n7IWYsz0evWA6hKev01ep+OFzLGkqSGTqbwsVvpIE=;
 b=1Dnp43vuzDmcpvc08SYw3ZjNKtJj8cVlMZ+vvxNyNXmTu5sE9Hq7kFCYLd6yAQoyg52d
 9G6OE23+ZiqsdPvy4EwGPu3PFkm7LPb4gl57A4FWebagbmknJozZ6Y/LBJ73IyKh3ywt
 m0/Z/UG8bJPVSX/OHWnv8JRLMAxHZEnK2cyBvBvP624UXst9hv2JLjUayoc5/AP1M6No
 6Q4ihR8/UheZqjA812x638Fr3V06tXZ8RjZGFV5Etgh5c4XUX0ltouqoK5VUIpqxYQN9
 y+8+ZHAHgIjMQ9/VY2+yIa2BAzBK+Izvd/LGaoQ2ANkdecLmJBmDGvdpiTPScxR5Sp5t ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460def6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:35:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SE5fMg028161;
        Fri, 28 Apr 2023 15:35:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b4ru3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:35:05 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SFYqUK028134;
        Fri, 28 Apr 2023 15:35:04 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-60.vpn.oracle.com [10.175.188.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461b4rm0-6;
        Fri, 28 Apr 2023 15:35:04 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 tracing 5/6] selftests/ftrace: add test coverage for filter predicates
Date:   Fri, 28 Apr 2023 16:34:48 +0100
Message-Id: <1682696089-27937-6-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682696089-27937-1-git-send-email-alan.maguire@oracle.com>
References: <1682696089-27937-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280125
X-Proofpoint-GUID: Dvlj8wiFgnu_z9HszsNHs87LfXHJmZDC
X-Proofpoint-ORIG-GUID: Dvlj8wiFgnu_z9HszsNHs87LfXHJmZDC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

add tests verifying filter predicates work for 1/2/4/8/16 byte values,
IPv4, IPv6, MAC addresses and strings; use predicats at event and
subsystem level.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/ftrace/test.d/event/filter.tc   | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc

diff --git a/tools/testing/selftests/ftrace/test.d/event/filter.tc b/tools/testing/selftests/ftrace/test.d/event/filter.tc
new file mode 100644
index 000000000000..21d4715e2176
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/event/filter.tc
@@ -0,0 +1,91 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event tracing - enable filter predicates
+# requires: set_event events/sched
+# flags:
+
+do_reset() {
+    echo 0 > ${event}/enable
+    echo 0 > ${event}/filter
+    clear_trace
+}
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+test_filter() { # event filter cmd
+    event=$1
+    filter="$2"
+    cmd=$3
+    findevent=`basename $event`
+    echo "$filter" > ${event}/filter
+    echo 1 > ${event}/enable
+    $cmd
+    count=`grep $findevent trace |wc -l`
+    if [ $count -lt 1 ]; then
+        fail "at least one $event should be recorded for '$filter'"
+    fi
+    do_reset
+}
+
+# verify filter predicates at trace event/subsys level for
+# - string (prev_comm)
+# - 1-byte value (common_flags)
+# - 2-byte value (common_type)
+# - 4-byte value (next_pid)
+# - 8-byte value (prev_state)
+
+for event in events/sched/sched_switch events/sched
+do
+    for filter in	"prev_comm == 'ftracetest'"	\
+			"common_flags != 0"		\
+			"common_type >= 0"		\
+			"next_pid > 0"			\
+			"prev_state != 0"
+    do
+        test_filter "$event" "$filter" "yield"
+    done
+done
+
+# verify '==', '!=' filter predicates for IPv4 addresses at event/subsys
+# level
+for event in events/fib/fib_table_lookup events/fib ; do
+    for filter in "dst == 127.0.0.1" \
+	          "src != 127.0.0.1"
+    do
+        test_filter "$event" "$filter" "ping -c 1 127.0.0.1"
+    done
+done
+
+# verify '==', '!=' filter predicates for IPv6 addresses/16-byte arrays
+# at event/subsys level
+for event in events/fib6/fib6_table_lookup events/fib6 ; do
+    for filter in "dst == 0x00000000000000000000000000000001" \
+	          "src != 0x00000000000000000000000000000001" \
+		  "dst == ::1" \
+		  "src != ::1" \
+		  "dst == 0:0:0:0:0:0:0:1" \
+		  "dst == 0000:0000:0000:0000:0000:0000:0000:00001"
+    do
+       test_filter "$event" "$filter" "ping -c 1 -6 ::1"
+    done
+done
+
+set +e
+modprobe cfg80211
+set -e
+
+if [[ -d events/cfg80211/rdev_get_key ]]; then
+    for event in events/cfg80211/rdev_get_key ; do
+       for filter in "mac_addr == de:ad:be:ef:de:ad" \
+		     "mac_addr != AB:CD:EF:01:23:45"
+       do
+          echo "$filter" > events/cfg80211/rdev_get_key/filter
+          echo 0 > events/cfg80211/rdev_get_key/filter
+       done
+     done
+fi
+
+exit 0
-- 
2.31.1

