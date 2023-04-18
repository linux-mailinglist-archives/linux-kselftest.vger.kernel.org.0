Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAC6E5E13
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDRJ5n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 05:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDRJ5k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 05:57:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915987ED7;
        Tue, 18 Apr 2023 02:57:04 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9j3QI012916;
        Tue, 18 Apr 2023 09:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gcDsJ3qWfJbVBLy5reW9DJAoH6Vn2IeHQawNmq3ml6o=;
 b=tLiKyc6ynXfBtoWgU01m8PJNB3xRkgDeRtU9zd/gllQo7anoeOF4XBIBn5oMHwKntC6g
 qCn4acLmYzBlCU9AEnBjy6F6SJ4QCy8M/djfApg6uuS70QjlHb1DZIe/gVhkBdvlJYFQ
 8Za5MTal3f1ZB3x7J6qmex4PNSgpVEp+64jtVKoal+axkO27IHJ9ndcLbzdJk87jGL/r
 UfQD2ixADQGQkx3nznSdazC/V6H7YDfySvj0eJGea7BLyFV12l9um6TGFOWwwz3OQima
 LtrhN9y0E27fml8jyW8oo6PfSRCmmlK7B0R1mTx/QdJYqViP2mx+k7q800n/h6c1L0kE vg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q353qtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:56:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33I3nqpe016741;
        Tue, 18 Apr 2023 09:56:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pykj6hx07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:56:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33I9uBec7078512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:56:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF4442004B;
        Tue, 18 Apr 2023 09:56:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5658520040;
        Tue, 18 Apr 2023 09:56:10 +0000 (GMT)
Received: from li-ed75614c-32e0-11b2-a85c-ba2953069b43.in.ibm.com (unknown [9.109.209.37])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:56:10 +0000 (GMT)
From:   Akanksha J N <akanksha@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com, akanksha@linux.ibm.com
Subject: [PATCH v2 2/2] selftests/ftrace: Add new test case which checks for optimized probes
Date:   Tue, 18 Apr 2023 15:25:57 +0530
Message-Id: <20230418095557.19061-3-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230418095557.19061-1-akanksha@linux.ibm.com>
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rrbtHFRkYg3m4IWvtAviFGwCY95dNWvH
X-Proofpoint-ORIG-GUID: rrbtHFRkYg3m4IWvtAviFGwCY95dNWvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=956 bulkscore=0
 phishscore=0 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new test case kprobe_opt_types.tc which enables and checks
if each probe has been optimized in order to test potential issues with
optimized probes.
The '|| continue' is added with the echo statement to ignore errors that
are caused by trying to add kprobes to non probeable lines and continue
with the test.
Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
---
 .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
new file mode 100644
index 000000000000..54e4800b8a13
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2023 Akanksha J N, IBM corporation
+# description: Register/unregister optimized probe
+# requires: kprobe_events
+
+case `uname -m` in
+x86_64)
+;;
+arm*)
+;;
+ppc*)
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_unsupported
+esac
+
+DEFAULT=$(cat /proc/sys/debug/kprobes-optimization)
+echo 1 > /proc/sys/debug/kprobes-optimization
+for i in `seq 0 255`; do
+        echo  "p:testprobe $FUNCTION_FORK+${i}" > kprobe_events || continue
+        echo 1 > events/kprobes/enable || continue
+        (echo "forked")
+        PROBE_TYPE=$(cat /sys/kernel/debug/kprobes/list | grep $FUNCTION_FORK | awk '{print $4}' | awk '{print substr($0,2,length($0)-2)}')
+        echo 0 > events/kprobes/enable
+        echo > kprobe_events
+        if [ $PROBE_TYPE = "OPTIMIZED" ]; then
+                echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
+                exit_pass
+        fi
+done
+echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
+echo "Done"
-- 
2.31.1

