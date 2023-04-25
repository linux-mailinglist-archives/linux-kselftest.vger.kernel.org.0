Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B416EDEEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjDYJQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjDYJQw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 05:16:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1C40E0;
        Tue, 25 Apr 2023 02:16:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0hxHB005226;
        Tue, 25 Apr 2023 09:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=sRmZ24TIDSjA4WAmXwcO6eFy6214CYNyXMb+g2Vg14E=;
 b=Ji4/Lbn3A25dUe3MzwNR0xP+dFBeNT6m/QGdMuQZ07/GgiGKjgu2rhSlmpkiRpYavMI0
 ZtCjAYyBwj0xX4ZqNoQCGGJh+GdUWiW5AQWviihMEAwMZgBmrptBGb7WcXRU6dnpUS8s
 EkaxVgClxwpOg+JbNr+w8D7M5fsrLxfFuG4ruL/3om8YV+tp+htbhTiIfhXddYNIbTNv
 5LUPwFtZx/+xPzU9M6m/75LKD/z5RrNqNH+nBTuvHt9lLe4tzIsQjddExRlOhw0S+YLZ
 eFKLqFUNr2MPGUYLIooWO+3P6BNCkj5MFXvJsTviNxUAQs7UeeyDsVfwyHJwyg3LoUGs Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476tvunb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P80Rug024874;
        Tue, 25 Apr 2023 09:16:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461cdwdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33P93LCT024482;
        Tue, 25 Apr 2023 09:16:46 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-181-126.vpn.oracle.com [10.175.181.126])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3q461cdwa1-3;
        Tue, 25 Apr 2023 09:16:45 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH tracing 2/3] selftests/ftrace: add test coverage for filter predicates
Date:   Tue, 25 Apr 2023 10:16:36 +0100
Message-Id: <1682414197-13173-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250082
X-Proofpoint-GUID: 9YkwjMFnbujJcyCEW1MkI2S4_yYbcsUl
X-Proofpoint-ORIG-GUID: 9YkwjMFnbujJcyCEW1MkI2S4_yYbcsUl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

add tests verifying filter predicates work for 1/2/4/8/16 byte values
and strings; use predicates at event and subsystem level.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/ftrace/test.d/event/filter.tc   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc

diff --git a/tools/testing/selftests/ftrace/test.d/event/filter.tc b/tools/testing/selftests/ftrace/test.d/event/filter.tc
new file mode 100644
index 000000000000..df5c93d5aa4d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/event/filter.tc
@@ -0,0 +1,62 @@
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
+# verify filter predicates at trace event/subsys level for
+# - string (prev_comm)
+# - 1-byte value (common_flags)
+# - 2-byte value (common_type)
+# - 4-byte value (next_pid)
+# - 8-byte value (prev_state)
+
+for event in events/sched/sched_switch events/sched
+do
+    for filter in	"prev_comm == 'ping'"	\
+			"common_flags != 0"	\
+			"common_type >= 0"	\
+			"next_pid > 0"		\
+			"prev_state != 0"
+    do
+        echo "$filter" > ${event}/filter
+        echo 1 > ${event}/enable
+        yield
+        count=`grep sched_switch trace|wc -l`
+        if [ $count -lt 1 ]; then
+            fail "at least one $event should be recorded for '$filter'"
+        fi
+        do_reset
+    done
+done
+
+# verify '==', '!=' filter predicates for 16-byte array at event/subsys
+# level
+
+LOCALHOST="-6 ::1"
+for event in events/fib6/fib6_table_lookup events/fib6 ; do
+    for filter in "dst == 0x00000000000000000000000000000001" \
+	          "src != 0x00000000000000000000000000000001"
+    do
+	echo "$filter" > ${event}/filter
+	echo 1 > ${event}/enable
+	yield
+	count=`grep fib6_table_lookup trace|wc -l`
+        if [ $count -lt 1 ]; then
+            fail "at least one $event should be recorded for '$filter'"
+        fi
+        do_reset
+    done
+done
+exit 0
-- 
2.31.1

