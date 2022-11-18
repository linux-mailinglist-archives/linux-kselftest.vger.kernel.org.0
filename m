Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1362F244
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 11:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiKRKOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 05:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbiKRKN6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 05:13:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E69769F8;
        Fri, 18 Nov 2022 02:13:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI98vje005005;
        Fri, 18 Nov 2022 10:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=2ITJaP4jdIVNZSLXzqhqrVHW2OsvNSr1kvcLSWotVrg=;
 b=092vVsB0kfR/0f5FxqEyj51tOi4vmkOA58lPpY7B/ExjLYMUEMJEPTI3LqeRMpg9sLN1
 QbU6gXwnpoGTiDbUFqBKPgoDwwaJ+GdnW8UCicPSiLeLxtq6JDVvGmSnKZvKWAXOkeH5
 2cnSnSB97qDBUjma4xu0PGyEBDnopaqKEzz3zA/KPtsSb28lDEiOMAqWMnLqNUeJ3cYo
 B14bQHYdoDzGqrSTmNEj+8QWszp+Jb8bxPzWi+lt4zUFhA4HSPRaOCtjxZo7vFonPn8c
 FLgymQn94Xsf8Oa0BYRpt27wxCWeSiSdQA2BYlsW2w/tsDILhA6fEfqTBldyRRiqqRKD BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kx70ur6sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 10:13:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AI9Mo7N034324;
        Fri, 18 Nov 2022 10:13:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2deus8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 10:13:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIADlTM027553;
        Fri, 18 Nov 2022 10:13:47 GMT
Received: from jarvis3.oracle.com (dhcp-10-191-220-40.vpn.oracle.com [10.191.220.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kw2deus6s-1;
        Fri, 18 Nov 2022 10:13:47 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/cgroup: Add cleanup() to test_cpuset_prs.sh
Date:   Fri, 18 Nov 2022 15:43:30 +0530
Message-Id: <20221118101330.251332-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180061
X-Proofpoint-GUID: PhYjCzto24wHHYvFrCj4PoqDoJp-D1X8
X-Proofpoint-ORIG-GUID: PhYjCzto24wHHYvFrCj4PoqDoJp-D1X8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Install a cleanup function using the trap command for signals EXIT,
SIGINT, SIGQUIT and SIGABRT.  The cleanup function will perform:
1. Online the CPUs that were made offline during the test.
2. Removing the cgroups created.
3. Restoring the original /sys/kernel/debug/sched/verbose value,
   currently it's left turned on, irrespective of the original
   configuration value.

the test performs steps 1 and 2, on the successful runs, but not during
all of the failed runs.  With the cleanup(), the system will perform all
three steps during failed/passed test runs.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 .../testing/selftests/cgroup/test_cpuset_prs.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 526d2c42d870..b8ed82b55b1d 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -16,7 +16,12 @@ skip_test() {
 [[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
 
 # Set sched verbose flag, if available
-[[ -d /sys/kernel/debug/sched ]] && echo Y > /sys/kernel/debug/sched/verbose
+if [[ -d /sys/kernel/debug/sched ]]
+then
+	# Used to restore the original setting during cleanup
+	SCHED_DEBUG=$(cat /sys/kernel/debug/sched/verbose)
+	echo Y > /sys/kernel/debug/sched/verbose
+fi
 
 # Get wait_inotify location
 WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
@@ -54,6 +59,15 @@ echo +cpuset > cgroup.subtree_control
 [[ -d test ]] || mkdir test
 cd test
 
+cleanup()
+{
+	online_cpus
+	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
+	cd ..
+	rmdir test > /dev/null 2>&1
+	echo "$SCHED_DEBUG" > /sys/kernel/debug/sched/verbose
+}
+
 # Pause in ms
 pause()
 {
@@ -666,6 +680,7 @@ test_inotify()
 	fi
 }
 
+trap cleanup 0 2 3 6
 run_state_test TEST_MATRIX
 test_isolated
 test_inotify
-- 
2.34.3

