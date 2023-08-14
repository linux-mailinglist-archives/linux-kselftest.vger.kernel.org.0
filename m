Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F033A77B38B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjHNIMU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjHNIML (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:12:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F410FB;
        Mon, 14 Aug 2023 01:11:49 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E7w4hp012309;
        Mon, 14 Aug 2023 08:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JgCuLHtbvZeMjPl8W8XtLJncGJUIuvpa9y8VKiX28Wk=;
 b=QVgUjIJJWbSqhJNr2onlG/sJzNhN5FRYiTJTqyFuRA7xMT2Ph4DB6CJgFqSrRgoDNQ9r
 e0dBo+ji5HBjHC668S0hot38fICdAHgCuJSIL2ZiwLMqHEER8gPsXv6q7MIMPTU1HQJ+
 dRrx6LyQUwsLNvFVHVQhu4+CpOvwJ77jlCLUFGwZkJlWSGEWUn2rggCkxRccMCLO2/Kd
 UxNz8wma1QYy+bK2t8Y42xGKmyrCX+EGIrA+6CIXOJ6WPyk+cnIxAlKPrBt4aoEPaP5R
 he5AkXY6+cyh5OFo6paSTwnwUwxbNt/DQvQEV+d4zLZ/ZWz/4+g1M8hXB0Cs6nzdTnjz eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfgbgrf99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:10:50 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37E7wRf6013400;
        Mon, 14 Aug 2023 08:10:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfgbgrf8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:10:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E7K9cn013323;
        Mon, 14 Aug 2023 08:10:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmja13w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:10:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E8AlBT46072070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 08:10:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C5D220049;
        Mon, 14 Aug 2023 08:10:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64EC720040;
        Mon, 14 Aug 2023 08:10:45 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.in.ibm.com (unknown [9.199.157.108])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 14 Aug 2023 08:10:45 +0000 (GMT)
From:   "Nysal Jan K.A" <nysal@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Nysal Jan K . A" <nysal@linux.ibm.com>
Subject: [PATCH] selftests/futex: Order calls to futex_lock_pi
Date:   Mon, 14 Aug 2023 13:39:27 +0530
Message-ID: <20230814080927.61048-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6HDP3wtOcg_WMu8WmeI-KbIBt1RUsSTf
X-Proofpoint-GUID: ARSVnrOJ2DTnZvOjOKSrWeLUwwjIW3as
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Observed occassional failures in the futex_wait_timeout test:

ok 1 futex_wait relative succeeds
ok 2 futex_wait_bitset realtime succeeds
ok 3 futex_wait_bitset monotonic succeeds
ok 4 futex_wait_requeue_pi realtime succeeds
ok 5 futex_wait_requeue_pi monotonic succeeds
not ok 6 futex_lock_pi realtime returned 0
......

The test expects the child thread to complete some steps before
the parent thread gets to run. There is an implicit expectation
of the order of invocation of futex_lock_pi between the child thread
and the parent thread. Make this order explicit. If the order is
not met, the futex_lock_pi call in the parent thread succeeds and
will not timeout.

Fixes: f4addd54b161 ("selftests: futex: Expand timeout test")
Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>
---
 .../selftests/futex/functional/futex_wait_timeout.c        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 3651ce17beeb..d183f878360b 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -24,6 +24,7 @@
 
 static long timeout_ns = 100000;	/* 100us default timeout */
 static futex_t futex_pi;
+static pthread_barrier_t barrier;
 
 void usage(char *prog)
 {
@@ -48,6 +49,8 @@ void *get_pi_lock(void *arg)
 	if (ret != 0)
 		error("futex_lock_pi failed\n", ret);
 
+	pthread_barrier_wait(&barrier);
+
 	/* Blocks forever */
 	ret = futex_wait(&lock, 0, NULL, 0);
 	error("futex_wait failed\n", ret);
@@ -130,6 +133,7 @@ int main(int argc, char *argv[])
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
 
+	pthread_barrier_init(&barrier, NULL, 2);
 	pthread_create(&thread, NULL, get_pi_lock, NULL);
 
 	/* initialize relative timeout */
@@ -163,6 +167,9 @@ int main(int argc, char *argv[])
 	res = futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
 	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
 
+	/* Wait until the other thread calls futex_lock_pi() */
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
 	/*
 	 * FUTEX_LOCK_PI with CLOCK_REALTIME
 	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
-- 
2.41.0

