Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB22D610B1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 09:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJ1HQv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJ1HQu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 03:16:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A61A9123;
        Fri, 28 Oct 2022 00:16:48 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S70bB5019796;
        Fri, 28 Oct 2022 07:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=ILyBORIANJ7JMdWrR3L+rEGQWqFurp9mQNYOkfTqS0E=;
 b=XVAumf47xp+8ARFm28Zz2d3sweOkko+IpkM99HHxuytYogmQQS/Gou98jbELqYR149x+
 MAh5Tmunn5AUGbgXzyyziN9QTYwtALZcnZ71xwFZY3r4+V9OkQtIcnVCZuJZcwR/Vaf7
 5Kcj9xpaHIITRLu538p08L2rzBACwnixIftQcVYL82YH0gCjGWIfQ/UOUpq9McaXGBdL
 Qk0w0MIScsQ9DKhs8MnSC8JZZHEIrMd48I/iTr0iiL/1ZiwOsC0RBKdyVk+WXkATQ2Ax
 lROLamh7/1YNSft1m0dNKSBXuJR/OfP2XzJ+f8ZTAZzNjx8JY6jh+/e5czCWvYM2Jj/R Vw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgaamrv7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:16:44 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29S774YP014303;
        Fri, 28 Oct 2022 07:16:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3kfahmja85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:16:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29S7HEr851970408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 07:17:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9130A4053;
        Fri, 28 Oct 2022 07:16:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0A4A4040;
        Fri, 28 Oct 2022 07:16:36 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.57.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 07:16:36 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [RESEND PATCH v2 1/2] selftests/ftrace: Add check for ping command for trigger tests
Date:   Fri, 28 Oct 2022 12:46:09 +0530
Message-Id: <4ad6204f8a30860ec2fa32eb0313c0df10c6235e.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J2m4I_ZlMb3A7JadKuIcCUkWsBiy0tWe
X-Proofpoint-ORIG-GUID: J2m4I_ZlMb3A7JadKuIcCUkWsBiy0tWe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All these tests depend on the ping command and will fail if it is not
found. Allow tests to specify dependencies on programs through the
'requires' field. Add dependency on 'ping' for some of the trigger
tests.

Link: https://lore.kernel.org/all/20221017104312.16af5467@gandalf.local.home/
Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/functions           | 8 +++++++-
 .../trigger/inter-event/trigger-field-variable-support.tc | 2 +-
 .../inter-event/trigger-inter-event-combined-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onchange-action-hist.tc   | 2 +-
 .../trigger/inter-event/trigger-onmatch-action-hist.tc    | 2 +-
 .../inter-event/trigger-onmatch-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-snapshot-action-hist.tc   | 2 +-
 .../inter-event/trigger-synthetic-event-dynstring.tc      | 2 +-
 .../trigger/inter-event/trigger-trace-action-hist.tc      | 2 +-
 10 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5f6cbec847fc99..779f3e62ec9005 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -142,9 +142,15 @@ finish_ftrace() {
 
 check_requires() { # Check required files and tracers
     for i in "$@" ; do
+	p=${i%:program}
         r=${i%:README}
         t=${i%:tracer}
-        if [ $t != $i ]; then
+	if [ $p != $i ]; then
+	    if ! which $p ; then
+                echo "Required program $p is not found."
+                exit_unresolved
+	    fi
+        elif [ $t != $i ]; then
             if ! grep -wq $t available_tracers ; then
                 echo "Required tracer $t is not configured."
                 exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index 41119e0440e960..04c5dd7d0acc4b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test field variable support
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 9098f1e7433fd0..f7447d800899ac 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event combined histogram trigger
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index adaabb873ed4ab..91339c1308324b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onchange action
-# requires: set_event "onchange(var)":README
+# requires: set_event "onchange(var)":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index 20e39471052e9a..d645abcf11c4f7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index f4b03ab7c28714..c369247efb3501 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch-onmax action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 71c9b5911c7067..e28dc5f11b2be0 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmax action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 67fa328b830f5f..147967e86584ac 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger snapshot action
-# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README
+# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
index 3d65c856eca3e6..213d890ed1886e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
-# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index c126d2350a6d41..d7312047ce2818 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README ping:program
 
 fail() { #msg
     echo $1
-- 
2.38.0

