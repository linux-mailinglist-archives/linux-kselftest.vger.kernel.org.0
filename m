Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769B34F8730
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346888AbiDGSmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346907AbiDGSmi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 14:42:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200A10FF5;
        Thu,  7 Apr 2022 11:40:37 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237Hl1Ex021744;
        Thu, 7 Apr 2022 18:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xfQ3E8yUSemWJMWvuJAnI/1Wu3kezd+qtoiUH5u+qPs=;
 b=pvQJ8vbwFx46sV4Y8xGDSDAY7DW9AZWP2xA+p4RUR01gM+dD4O2u0HGQ4iLEMFe1JCmJ
 XyjeTmU7tUwe0JahGyReGqiapaFCYr6qNnRebrDoidKIh+5yK7ApzszKdPSfMcvmR200
 pTRu4YMZGbNoXqz3bI0ln1QKDw9yfuJ4QPpc6QBJDwNaqE+NrcOnTlXHB5NTDUrCsa6E
 XCRZiOafC0s3gYG5bCiaQpEn7La0bOWB6J0TDfPzienodYcFBLlkQq9hCrFzw/9tJXz0
 aPjFqPnn9j3fh2YqpA2pzqWyrDUkv+/pvnVfIHPqTcstgpLc70qtOuMLDXRMQ6Py2xD9 Cw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa4a5sr9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 18:40:23 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237INbHK004405;
        Thu, 7 Apr 2022 18:40:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3f6e490j6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 18:40:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237IeIP535127806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 18:40:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 773D452051;
        Thu,  7 Apr 2022 18:40:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.133.86])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3B68C5204F;
        Thu,  7 Apr 2022 18:40:11 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com
Subject: [PATCH V2] testing/selftests/mqueue: Fix mq_perf_tests to free the allocated cpu set
Date:   Fri,  8 Apr 2022 00:10:08 +0530
Message-Id: <20220407184008.93879-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JVkspol0CEqjOAVCtqsO5wNL_61pd4OQ
X-Proofpoint-GUID: JVkspol0CEqjOAVCtqsO5wNL_61pd4OQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_04,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070092
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
is called in most of the error/exit path for the cleanup. Also add
CPU_FREE in some of the error paths where shutdown is not called.

Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
From v1 -> v2:
 Addressed review comment from Shuah Khan to add
 CPU_FREE in other exit paths where it is needed

 tools/testing/selftests/mqueue/mq_perf_tests.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index b019e0b8221c..182434c7898d 100644
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
@@ -589,6 +592,7 @@ int main(int argc, char *argv[])
 						cpu_set)) {
 					fprintf(stderr, "Any given CPU may "
 						"only be given once.\n");
+					CPU_FREE(cpu_set);
 					exit(1);
 				} else
 					CPU_SET_S(cpus_to_pin[cpu],
@@ -607,6 +611,7 @@ int main(int argc, char *argv[])
 				queue_path = malloc(strlen(option) + 2);
 				if (!queue_path) {
 					perror("malloc()");
+					CPU_FREE(cpu_set);
 					exit(1);
 				}
 				queue_path[0] = '/';
@@ -619,6 +624,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (continuous_mode && num_cpus_to_pin == 0) {
+		CPU_FREE(cpu_set);
 		fprintf(stderr, "Must pass at least one CPU to continuous "
 			"mode.\n");
 		poptPrintUsage(popt_context, stderr, 0);
@@ -628,10 +634,12 @@ int main(int argc, char *argv[])
 		cpus_to_pin[0] = cpus_online - 1;
 	}
 
-	if (getuid() != 0)
+	if (getuid() != 0) {
+		CPU_FREE(cpu_set);
 		ksft_exit_skip("Not running as root, but almost all tests "
 			"require root in order to modify\nsystem settings.  "
 			"Exiting.\n");
+	}
 
 	max_msgs = fopen(MAX_MSGS, "r+");
 	max_msgsize = fopen(MAX_MSGSIZE, "r+");
-- 
2.35.1

