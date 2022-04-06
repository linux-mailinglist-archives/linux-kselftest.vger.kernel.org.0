Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224974F69BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 21:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiDFTX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Apr 2022 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiDFTVc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Apr 2022 15:21:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFF27FC8F;
        Wed,  6 Apr 2022 10:57:37 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236GnQo5000971;
        Wed, 6 Apr 2022 17:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=EIZq0sEIJfeT9I1Gb/BlkG7lb68M6yMU1xY9qv8gko4=;
 b=HCMx6RCatU8Mp6xEbENFmX+GMruYA+tG6wMu11gINCI2+9YsnTHg/QljyByAHTw3MSJl
 9uocU14EVTdeokB6f7IPOkcJZ2E4utRC7Ixh3M+kTFa2DBj2m1FEKe0vTOBuEvBrQkWo
 0CMncOqGt4sgUxdoMcrKfV02/h3ik805ihOlKaOg7RB9l8AvAutn49d7+bXF0lqgS5kf
 xHVbyHi+4siDF2E/qKbogAmaPfk9ZZdeR8eznS2WT2gX1JefPj6PTWJilKH5G7/1JgJz
 BEzgro8q+G5yCsW+7KULBiogpA4ASCiy50D7jDFoQMKFDXE+hXx6+Mv1UuuYG1hI0MfO jg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f8ya1btrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:57:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236HrDxV027660;
        Wed, 6 Apr 2022 17:57:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3f6e4908sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:57:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236HvNPf35520920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 17:57:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21BF44C044;
        Wed,  6 Apr 2022 17:57:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0FD14C040;
        Wed,  6 Apr 2022 17:57:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.90.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Apr 2022 17:57:17 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com
Subject: [PATCH] testing/selftests/mqueue: Fix mq_perf_tests to free the allocated cpu set
Date:   Wed,  6 Apr 2022 23:27:15 +0530
Message-Id: <20220406175715.87937-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SWGsCKz1tXs5MUdS4yLCeeuWiySXqxwh
X-Proofpoint-ORIG-GUID: SWGsCKz1tXs5MUdS4yLCeeuWiySXqxwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_09,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
cpu set is not freed. Fix this by adding CPU_FREE after its usage
is done.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index b019e0b8221c..17c41f216bef 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -732,6 +732,7 @@ int main(int argc, char *argv[])
 		pthread_attr_destroy(&thread_attr);
 	}
 
+	CPU_FREE(cpu_set);
 	if (!continuous_mode) {
 		pthread_join(cpu_threads[0], &retval);
 		shutdown((long)retval, "perf_test_thread()", __LINE__);
-- 
2.35.1

