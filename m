Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6186E5E17
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDRJ57 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 05:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDRJ5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 05:57:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D377AB5;
        Tue, 18 Apr 2023 02:57:22 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9SVZw013023;
        Tue, 18 Apr 2023 09:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=r8qscaI2MlygtgwxkNL/15TtoUasFKOiy2Uvd5Emj6E=;
 b=a5s+anymUAnax1OfmfHzYVXl1BlKYol+VjGt2Z4dUrrcarRqE+N2x5VHSonbqZByvItD
 8k0IzBbtyHzkELEFXzgJAHHTh5G+IeydhJhQqtXWoPyVafuyJPrnde7qViNSNziFQvhn
 FF6e5DT5ES5XijG7RpQDVEuEwESFY4q/i15toADFMeHZbOLtrHVfSaxyOkZzjnbSqUtg
 rbwaGpGO9piLheiwtGjaRjCeGegZCO57SEKf5zhYkuMR+i474cd+HDiSfyK/48ddo2L3
 nZIdhmU3nMc/ij+4lSbTpXLP86WBxIp/A7/uNhtWdJH9QWGtpn8g41Cj6pXtgP5eZJJ0 bQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1pkw4mhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:56:15 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLsN9F005448;
        Tue, 18 Apr 2023 09:56:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3pykj6hjvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:56:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33I9u9Z6852522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:56:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B3C20049;
        Tue, 18 Apr 2023 09:56:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91D8720040;
        Tue, 18 Apr 2023 09:56:07 +0000 (GMT)
Received: from li-ed75614c-32e0-11b2-a85c-ba2953069b43.in.ibm.com (unknown [9.109.209.37])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:56:07 +0000 (GMT)
From:   Akanksha J N <akanksha@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com, akanksha@linux.ibm.com
Subject: [PATCH v2 1/2] selftests/ftrace: Add new test case which adds multiple consecutive probes in a function
Date:   Tue, 18 Apr 2023 15:25:56 +0530
Message-Id: <20230418095557.19061-2-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230418095557.19061-1-akanksha@linux.ibm.com>
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aq4nmESFXNa17VrgPfvACH8x3V6n1Ii4
X-Proofpoint-ORIG-GUID: aq4nmESFXNa17VrgPfvACH8x3V6n1Ii4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 97f88a3d723162 ("powerpc/kprobes: Fix null pointer reference in
arch_prepare_kprobe()") fixed a recent kernel oops that was caused as
ftrace-based kprobe does not generate kprobe::ainsn::insn and it gets
set to NULL.
Add new test case kprobe_insn_boundary.tc which adds a
kprobe at every byte within $FUNCTION_FORK up to an offset of 256 bytes,
to be able to test potential issues with kprobes on
successive instructions.
The '|| continue' is added with the echo statement to ignore errors that
are caused by trying to add kprobes to non probeable lines and continue
with the test.
Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
---
 .../test.d/kprobe/kprobe_insn_boundary.tc     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
new file mode 100644
index 000000000000..4f7cc318f331
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2023 Akanksha J N, IBM corporation
+# description: Register multiple kprobe events in a function
+# requires: kprobe_events
+
+for i in `seq 0 255`; do
+  echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
+done
+
+cat kprobe_events >> $testlog
+
+echo 1 > events/kprobes/enable
+( echo "forked" )
+echo 0 > events/kprobes/enable
+echo > kprobe_events
+echo "Waiting for unoptimizing & freeing"
+sleep 5
+echo "Done"
-- 
2.31.1

