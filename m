Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2522A908A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 08:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgKFHk2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 02:40:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbgKFHk0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 02:40:26 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A67WAJJ170344;
        Fri, 6 Nov 2020 02:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : subject; s=pp1;
 bh=iuecD5zUOAE9BIUvAvgOIeZkcZLar3f0+ORBlsIp6zc=;
 b=TNv5IcCF9Bbfaclw+Rqn0bYPmCqepSEnWbdhKn4MBm07Nn4Phrl7ZjdGvw7iYsTs3G6f
 wfT0G1Uk8cym203ezn9kc49S+xo97xgrWk7lH2jEFvos3MsgX56z2ONMONZzOzLtErO4
 ThnMRD5lnMovQdqiKMCiTtTdD5gdJEoiGEdm0j2BH7P+sh6Ol+RLam8/XqNCP8rJpv0+
 PpkWS7TF4NibBmCPWeZOb0wS50BTn/ugNGj8nmflSr2Dv5Z9n9OBR0QEvBCerZaUX8dy
 Whwc+sq5c6qYYsWp4SzNzywDsVySZ4pRJIS9kzJn0QmK+FeZDK4zZMTdiepYJJENzQRZ sw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34mnyj2c0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 02:40:18 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A67bCBE015767;
        Fri, 6 Nov 2020 07:40:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 34h01ue0nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 07:40:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A67eDSA3736208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 07:40:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A434352050;
        Fri,  6 Nov 2020 07:40:13 +0000 (GMT)
Received: from MacBook-Pro.local (unknown [9.85.71.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 366135204F;
        Fri,  6 Nov 2020 07:40:12 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
To:     Michael Ellerman <michael@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>, christian@brauner.io,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        keescook@chromium.org
Date:   Fri, 06 Nov 2020 13:10:06 +0530
Message-Id: <160464840151.97255.15344214064240834294.sendpatchset@MacBook-Pro.local>
Subject: [PATCH V2] selftests/cgroup: Fix build on older distros
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_02:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=777 mlxscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060048
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On older distros struct clone_args does not have a cgroup member,
leading to build errors:

 cgroup_util.c: In function 'clone_into_cgroup':
 cgroup_util.c:343:4: error: 'struct clone_args' has no member named 'cgroup'
 cgroup_util.c:346:33: error: invalid application of 'sizeof' to incomplete
  type 'struct clone_args'

But the selftests already have a locally defined version of the
structure which is up to date, called __clone_args.

So use __clone_args which fixes the error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sachin Sant <sachinp@linux.vnet.ibm.com>>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---

V2: Replace all instances of clone_args by __clone_args
---

diff --git a/a/tools/testing/selftests/cgroup/cgroup_util.c b/b/tools/testing/selftests/cgroup/cgroup_util.c
index 05853b0..0270146 100644
--- a/a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -337,13 +337,13 @@ pid_t clone_into_cgroup(int cgroup_fd)
 #ifdef CLONE_ARGS_SIZE_VER2
 	pid_t pid;
 
-	struct clone_args args = {
+	struct __clone_args args = {
 		.flags = CLONE_INTO_CGROUP,
 		.exit_signal = SIGCHLD,
 		.cgroup = cgroup_fd,
 	};
 
-	pid = sys_clone3(&args, sizeof(struct clone_args));
+	pid = sys_clone3(&args, sizeof(struct __clone_args));
 	/*
 	 * Verify that this is a genuine test failure:
 	 * ENOSYS -> clone3() not available
