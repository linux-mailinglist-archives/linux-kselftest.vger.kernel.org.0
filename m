Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791AC6F1CC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbjD1Qje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346282AbjD1Qjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 12:39:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81D5261;
        Fri, 28 Apr 2023 09:39:32 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SGbEcv000933;
        Fri, 28 Apr 2023 16:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=tDg7SREwELwKeN0hUns7eumwqh6Sz28roWKS9Y78LFQ=;
 b=Hu2LgkX0XKlmU8CfP5XoRM/rjEZSY/PRtJbqXzEAaNdua2wpm5IGdZP6+n793MuDc6RV
 EPUMMrvvXOG5EE7PFqT6fBFi2U2T0l8oFvnmNh2ClB4QL6aJdzZUt0tBh8CU6sekH2NF
 qOI/em7yYfg0hLeBrlfJeLaHGdwwK6u0N0O3vJpkbw9s5ERSey0VVoHsLGvVl+jtAFzk
 fQ/JZfb+92idUBTRMcMrBX3gBQ1lpRbc5CtH5XE8vkegfzQJwQcmNqOXBSFPKk6dq1F2
 Y8kE+f1X6soZTq6FFH5QAI3DwWPUXXLW2s8wk7UOJOOch3Cl12hR9jyFiflwbQq6ZpQS sg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8h3shmx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 16:39:27 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33SDciNp026297;
        Fri, 28 Apr 2023 16:38:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3q4777312x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 16:38:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SGcosh24904348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 16:38:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7757E20040;
        Fri, 28 Apr 2023 16:38:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2035320043;
        Fri, 28 Apr 2023 16:38:48 +0000 (GMT)
Received: from li-ed75614c-32e0-11b2-a85c-ba2953069b43.ibm.com.com (unknown [9.43.42.160])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 16:38:47 +0000 (GMT)
From:   Akanksha J N <akanksha@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com, akanksha@linux.ibm.com
Subject: [PATCH v3 0/2] selftests/ftrace: Add tests for kprobes and optimized probes 
Date:   Fri, 28 Apr 2023 22:08:40 +0530
Message-Id: <20230428163842.95118-1-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tWfGNYoNCsRPueUGzuj5k3GptnDpIOYm
X-Proofpoint-ORIG-GUID: tWfGNYoNCsRPueUGzuj5k3GptnDpIOYm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=656
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

This patchset adds a stress test for kprobes and a test for checking
optimized probes.
The two tests are being added based on the below discussion:
https://lore.kernel.org/all/20230128101622.ce6f8e64d929e29d36b08b73@kernel.org/
kprobe_opt_types.tc is modified as per the below review comments:
https://lore.kernel.org/all/1682506809.uus6y0ir3i.naveen@linux.ibm.com/#t

Changelog:

v3:

* Add Acked-by for kprobe_insn_boundary.tc
* Simplify test for optimized probe, as suggested by Masami
* Add exit_unresolved to exit as unresolved in case no probe was optimized

v2:

* Add an explicit fork after enabling the events ( echo "forked" )
* Remove the extended test from multiple_kprobe_types.tc which adds
  multiple consecutive probes in a function and add it as a
  separate test case.
* Add new test case which checks for optimized probes.

Akanksha J N (2):
  selftests/ftrace: Add new test case which adds multiple consecutive
    probes in a function
  selftests/ftrace: Add new test case which checks for optimized probes

 .../test.d/kprobe/kprobe_insn_boundary.tc     | 19 +++++++++++
 .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc

-- 
2.31.1

