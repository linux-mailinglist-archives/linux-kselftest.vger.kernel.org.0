Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB06F1CBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjD1QjZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346268AbjD1QjY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 12:39:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735ED5276;
        Fri, 28 Apr 2023 09:39:21 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SGcT9G026413;
        Fri, 28 Apr 2023 16:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GkWUZ+AiZYDZ8lPFP0cYY8qVuunWl/Oa38WVcl3CSo4=;
 b=mBgpnPH8u3sozvBr+/nBbT7+42i6v5SxnpbIo0QWa4TZicZ+vwt7o9VfIVRXEBxBqluE
 jzGFp7c6hoze4CiZezfZRQKreNNcY0OL6x6NOlmKuURXIXxLzJkYdSBrwuIqJicAM4vO
 y5AJzmsmha3h1/VcbdxAvlubfOEuxFUL13cdnOWzVZHAopbY2orjOB5hNX8VbIJ1fxRm
 QJ5NbdfVGwJi0clIGAoRIiTubiFfeDiBXI2Z+sHCN9FpYIb3tFVxrxIroQ7FZFu6esxL
 GEtnW3wBxKs0Zin0d2CVybmWSecuonsYmpy9uv5wsqVdLN8k2bL420E+zSoVBj0zZna+ gA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8hmv0a2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 16:39:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33S8a88K030297;
        Fri, 28 Apr 2023 16:39:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3q4777310h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 16:39:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SGcxDw21758306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 16:38:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62E2E20040;
        Fri, 28 Apr 2023 16:38:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A19D20043;
        Fri, 28 Apr 2023 16:38:57 +0000 (GMT)
Received: from li-ed75614c-32e0-11b2-a85c-ba2953069b43.ibm.com.com (unknown [9.43.42.160])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 16:38:56 +0000 (GMT)
From:   Akanksha J N <akanksha@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com, akanksha@linux.ibm.com
Subject: [PATCH v3 2/2] selftests/ftrace: Add new test case which checks for optimized probes
Date:   Fri, 28 Apr 2023 22:08:42 +0530
Message-Id: <20230428163842.95118-3-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230428163842.95118-1-akanksha@linux.ibm.com>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WZJgrL13sgQp55Lh4Ubt2UphYzW1cY3H
X-Proofpoint-ORIG-GUID: WZJgrL13sgQp55Lh4Ubt2UphYzW1cY3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=875 mlxscore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280133
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
index 000000000000..9f5d99328086
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
+	PROBE=$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)
+        echo 0 > events/kprobes/enable
+        echo > kprobe_events
+	if echo $PROBE | grep -q OPTIMIZED; then
+                echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
+                exit_pass
+        fi
+done
+echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
+exit_unresolved
-- 
2.31.1

