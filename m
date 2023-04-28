Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587F6F1CC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 18:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346293AbjD1Qj7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjD1Qj6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 12:39:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC459DC;
        Fri, 28 Apr 2023 09:39:50 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SGbMfm029807;
        Fri, 28 Apr 2023 16:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1VFq6zyI75ZkAy0GmVMbORMhJmkyPnnRdcx8uJyRGqc=;
 b=hBg76IQPZU3C0X57/Yzuon3bKGAoht2zXv3xMlz6wEm8GRQoQVNaL7IgUCvl3HrTMWE1
 OVr+AXTZoL3c90Lz46QCDi+4/lNGrhoUcwEMNqio6DNnnoT09DiRlWtAPZkIeCpkHOuz
 4RDFdm9j0vjKFDkqgGzmxcMruCvj7dRKGS1+ZRbVEpBCP3inPajmSlbwpUxwcODEeq9N
 EW6sdJMbMVxik0i7P+6YMGILEvWmUXhRAT7yBUGOQFD75HxZ6h/ml6WCH0jBjDFGneI1
 IeG9fy2VXMUJz1KkubtWDPaudvgCcUpgmvHd6FXBAf5LDNEwMU4te5JN1WO8sKtPSrkp 7g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8gjw2ggp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 16:39:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33SGbMhA027503;
        Fri, 28 Apr 2023 16:38:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q47773nsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 16:38:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SGct7c36831502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 16:38:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2DE32004D;
        Fri, 28 Apr 2023 16:38:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71DA020043;
        Fri, 28 Apr 2023 16:38:52 +0000 (GMT)
Received: from li-ed75614c-32e0-11b2-a85c-ba2953069b43.ibm.com.com (unknown [9.43.42.160])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 16:38:52 +0000 (GMT)
From:   Akanksha J N <akanksha@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com, akanksha@linux.ibm.com,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH v3 1/2] selftests/ftrace: Add new test case which adds multiple consecutive probes in a function
Date:   Fri, 28 Apr 2023 22:08:41 +0530
Message-Id: <20230428163842.95118-2-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230428163842.95118-1-akanksha@linux.ibm.com>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dLm0FE2YlPeEtHARPFhB-2Drxon920ql
X-Proofpoint-ORIG-GUID: dLm0FE2YlPeEtHARPFhB-2Drxon920ql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

