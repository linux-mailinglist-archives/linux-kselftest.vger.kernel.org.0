Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4B610B1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 09:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJ1HQz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 03:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJ1HQy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 03:16:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1A1A7A26;
        Fri, 28 Oct 2022 00:16:53 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S7C6UM019846;
        Fri, 28 Oct 2022 07:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mg7ab1FPbfMIpeLXwnefvsX+mFBK174pNT+Pd7tomzE=;
 b=hjDmX4rou6UrLYJragfYfxE5kOU33wWKmnMyCW5FlMlydE7oHjt85btG2VoFiUpUwWJd
 QKx6ZfV4t4sfq7KYP3y3rzrAhCgKlPxNolhhabp2IWgGP7gQV44nxdmwHwuF7Wuc5txH
 v5vkRticd7XSB4RtKMCtPvXS0x/vFUamKIJjoTJy/qpnJrouyFJpd3UwNjaxTD0/Nkul
 FxAUgcG6uQZgEsc+07BRK8U61kiUKPVHHou2nL//HGiqHX3Nzb5whz3lAAqqKaJyeIPj
 +K4UJQVX7J1OTPutbTqk680R2rzKqjqHMVdiZyl5Q0wKjcSQlHJkTjr0DuWYldj7A7Zi jQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgafs06k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:16:48 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29S75mRV025871;
        Fri, 28 Oct 2022 07:16:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3kfbg2a81v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:16:45 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29S7GhT61507954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 07:16:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03D26A404D;
        Fri, 28 Oct 2022 07:16:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19EF2A4040;
        Fri, 28 Oct 2022 07:16:41 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.57.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 07:16:40 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [RESEND PATCH v2 2/2] selftests/ftrace: Convert tracer tests to use 'requires' to specify program dependency
Date:   Fri, 28 Oct 2022 12:46:10 +0530
Message-Id: <ca7a2ba0500e3df69d878c7896015184dc4d9a93.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h_D5qzwDe4b67A8sU4OgtC8jRlqDTcpv
X-Proofpoint-ORIG-GUID: h_D5qzwDe4b67A8sU4OgtC8jRlqDTcpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_03,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
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

Now that we have a good way to specify dependency of tests on programs,
convert some of the tracer tests to use this method for specifying
dependency on 'chrt'.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 7 +------
 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
index 11be10e1bf966a..e8f0fac9a110cc 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -1,12 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup tracer
-# requires: wakeup:tracer
-
-if ! which chrt ; then
-  echo "chrt is not found. This test requires nice command."
-  exit_unresolved
-fi
+# requires: wakeup:tracer chrt:program
 
 echo wakeup > current_tracer
 echo 1 > tracing_on
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
index 3a77198b3c6902..79807656785b0f 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -1,12 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup RT tracer
-# requires: wakeup_rt:tracer
-
-if ! which chrt ; then
-  echo "chrt is not found. This test requires chrt command."
-  exit_unresolved
-fi
+# requires: wakeup_rt:tracer chrt:program
 
 echo wakeup_rt > current_tracer
 echo 1 > tracing_on
-- 
2.38.0

