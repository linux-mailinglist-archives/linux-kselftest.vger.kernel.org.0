Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00254F8F98
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiDHH2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiDHH1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 03:27:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCC36C719;
        Fri,  8 Apr 2022 00:24:54 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2385QbLS011064;
        Fri, 8 Apr 2022 07:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lJdUtViZ+9WYK9MNV/wF5jy+0uPy4byFiA3RxmH2wm0=;
 b=K+VOtmnawi47OdFf+Qt8yn4/LWR4Y0m47nb+RNdHebRJh0J/jcj2TWpp6gsGX+sr/zlf
 uZLJwANDoAaUK8JXOpoJkyOJjbRvgg1JeeGeDR2nB+IfTaybXomlT1QRIxB6CPzbk1zL
 UbgbPKAt1Vv+kLUmokAbwwBWaY6DtPfo2gwOxk0+M7ekdhdaNW/EM83V8AQuJKxN1NW6
 IKBuASuq4mSAH0OxKbAsRrtouHGt2Bp511Uhi63zzpyOijePRr70B5lC7foQEv4nk2bO
 ymZ+G+BDuTmTfNxBkYPHG4QkaiTr9d3W6r5KGCow9DZk6z3yE/CXokdwFGSTiL7Wg4sK LA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3faewhsxhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 07:24:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2387CsSo024440;
        Fri, 8 Apr 2022 07:24:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3f6e49395m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 07:24:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2387Odjp39453024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 07:24:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C9445204F;
        Fri,  8 Apr 2022 07:24:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.146.176])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EB6EF52051;
        Fri,  8 Apr 2022 07:24:33 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com
Subject: [PATCH V3] testing/selftests/mqueue: Fix mq_perf_tests to free the allocated cpu set
Date:   Fri,  8 Apr 2022 12:54:31 +0530
Message-Id: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oFSK29UBfSCeQZpUe-fbcXjKIGm8eMPU
X-Proofpoint-GUID: oFSK29UBfSCeQZpUe-fbcXjKIGm8eMPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_02,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
CPU set. This cpu set is used further in pthread_attr_setaffinity_np
and by pthread_create in the code. But in current code, allocated
cpu set is not freed.

Fix this issue by adding CPU_FREE in the "shutdown" function which
is called in most of the error/exit path for the cleanup. There are
few error paths which exit without using shutdown. Add a common goto
error path with CPU_FREE for these cases.

Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
 From v2 -> v3:
  Addressed review comment from Shuah Khan to add
  common "goto" error path with CPU_FREE for few exit
  cases.
 From v1 -> v2:
  Addressed review comment from Shuah Khan to add
  CPU_FREE in other exit paths where it is needed

 .../testing/selftests/mqueue/mq_perf_tests.c  | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index b019e0b8221c..84fda3b49073 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -180,6 +180,9 @@ void shutdown(int exit_val, char *err_cause, int line_no)
 	if (in_shutdown++)
 		return;
 
+	/* Free the cpu_set allocated using CPU_ALLOC in main function */
+	CPU_FREE(cpu_set);
+
 	for (i = 0; i < num_cpus_to_pin; i++)
 		if (cpu_threads[i]) {
 			pthread_kill(cpu_threads[i], SIGUSR1);
@@ -551,6 +554,12 @@ int main(int argc, char *argv[])
 		perror("sysconf(_SC_NPROCESSORS_ONLN)");
 		exit(1);
 	}
+
+	if (getuid() != 0)
+		ksft_exit_skip("Not running as root, but almost all tests "
+			"require root in order to modify\nsystem settings.  "
+			"Exiting.\n");
+
 	cpus_online = min(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
 	cpu_set = CPU_ALLOC(cpus_online);
 	if (cpu_set == NULL) {
@@ -589,7 +598,7 @@ int main(int argc, char *argv[])
 						cpu_set)) {
 					fprintf(stderr, "Any given CPU may "
 						"only be given once.\n");
-					exit(1);
+					goto err_code;
 				} else
 					CPU_SET_S(cpus_to_pin[cpu],
 						  cpu_set_size, cpu_set);
@@ -607,7 +616,7 @@ int main(int argc, char *argv[])
 				queue_path = malloc(strlen(option) + 2);
 				if (!queue_path) {
 					perror("malloc()");
-					exit(1);
+					goto err_code;
 				}
 				queue_path[0] = '/';
 				queue_path[1] = 0;
@@ -622,17 +631,12 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "Must pass at least one CPU to continuous "
 			"mode.\n");
 		poptPrintUsage(popt_context, stderr, 0);
-		exit(1);
+		goto err_code;
 	} else if (!continuous_mode) {
 		num_cpus_to_pin = 1;
 		cpus_to_pin[0] = cpus_online - 1;
 	}
 
-	if (getuid() != 0)
-		ksft_exit_skip("Not running as root, but almost all tests "
-			"require root in order to modify\nsystem settings.  "
-			"Exiting.\n");
-
 	max_msgs = fopen(MAX_MSGS, "r+");
 	max_msgsize = fopen(MAX_MSGSIZE, "r+");
 	if (!max_msgs)
@@ -740,4 +744,9 @@ int main(int argc, char *argv[])
 			sleep(1);
 	}
 	shutdown(0, "", 0);
+
+err_code:
+	CPU_FREE(cpu_set);
+	exit(1);
+
 }
-- 
2.35.1

