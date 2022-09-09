Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364CA5B3BBA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiIIPVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIIPVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 11:21:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF77A00EF;
        Fri,  9 Sep 2022 08:21:16 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289El24C003935;
        Fri, 9 Sep 2022 15:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ETxy00/oSLMaFwhEgTi64CSAohYWFjoKt+q44NRh+5E=;
 b=e2lK6FKnRBGUqzGIpdMTD3kgoJF94JDX7W3gB05VUy88pA9GOKEXGyy9CozkcTC+6NcT
 kqpvFq/c/UYv5n7/NenDrFRo1AwyJz5/mGp4J8oxL4mzIU6VfzlGyL79O6p6FFMdMsR0
 kxgmLNY+6pLYnQ8EXpibpE1eFCc8WDX5Qvd5psVHw+kP6lMlsxIyIKJABFOuS6LyxxK7
 uDVv4dpF51rI3dtZE9u9qBLU+Wg0B7aJtss7WQNKm0btkojHcdEGhpWJPZaZbDsAUZGU
 VH9VO+jfiE3C0yqlwwdmc1B0EmWjKiSJuZKDXCzG8ASCTaSlr5NRIUThJoYNIK2HWhGJ 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg7j6s3nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 15:21:12 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 289ElHbX005279;
        Fri, 9 Sep 2022 15:21:11 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg7j6s3n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 15:21:11 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289FKfiU030354;
        Fri, 9 Sep 2022 15:21:10 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3jbxjash13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 15:21:10 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289FL9Tb35521022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 15:21:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41FFB7805F;
        Fri,  9 Sep 2022 15:32:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFD5E78064;
        Fri,  9 Sep 2022 15:32:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  9 Sep 2022 15:32:49 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests: tpm2: Implement class desstructor to close file descriptor
Date:   Fri,  9 Sep 2022 11:20:56 -0400
Message-Id: <20220909152056.1335261-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uBgP43LIeEsIw0QlRJAR-jQOm899RkpN
X-Proofpoint-ORIG-GUID: K_4MA1wVvviQMNkflsxsgCsUvZOJ5Saa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=483 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209090053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement a class destructor to close the open TPM file descriptor
and avoid the following error message:

 test_flush_context (tpm2_tests.SpaceTest) ... \
   /usr/lib64/python3.6/unittest/case.py:605: ResourceWarning: \
   unclosed file <_io.FileIO name='/dev/tpmrm0' mode='rb+' closefd=True>

Fixes: 6ea3dfe1e0732 ("selftests: add TPM 2.0 tests")
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
 tools/testing/selftests/tpm2/tpm2.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index 057a4f49c79d..c7363c6764fc 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -371,6 +371,10 @@ class Client:
             fcntl.fcntl(self.tpm, fcntl.F_SETFL, flags)
             self.tpm_poll = select.poll()
 
+    def __del__(self):
+        if self.tpm:
+            self.tpm.close()
+
     def close(self):
         self.tpm.close()
 
-- 
2.35.1

