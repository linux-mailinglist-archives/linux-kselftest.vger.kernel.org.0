Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086DC4603DD
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Nov 2021 05:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbhK1EQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Nov 2021 23:16:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239328AbhK1EOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Nov 2021 23:14:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AS2pSqC028470;
        Sun, 28 Nov 2021 04:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GhxeF6//uRZWMFJ7xO1mYYvGDRNWeUhfP2wCJk6DQNk=;
 b=Ilt/P767A3lSqAquDgrWFVRWgeinXglx6sbPQKlUufi4tpK5IKAuuYTRm4lAjZ2rm7cX
 96QxLPwFYneQOqXVRHLrJnfC9sJjQSd7d4iQupiokRT1jDfZgT4u3ui/xPTY6Z8XK4zQ
 OJybvtvfmhDDMQIWwoO2njj8XXGHKkiIN/tTgkstnhf32RQ7JEYk3u/IW/4eQyvzrC1H
 Nj18xQEeGBHYKfcMPBzYEuZ+a/UTYpvLx4HnOigB6rK87wYcV7X4JRqu8uFJdJ0ihoTJ
 ydgtp4jC/i5ezvN2RU4dQYmHCdPpvU1UyHfWTUeOGKlLZcoFUgu5+29hwj4Rk10hs9PB Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cm1btgsbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:56 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AS49As9017728;
        Sun, 28 Nov 2021 04:10:56 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cm1btgsbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:56 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AS47GuP024095;
        Sun, 28 Nov 2021 04:10:55 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3ckca9uh9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:55 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AS4Asbe26673542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Nov 2021 04:10:55 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3AC2AE071;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD60DAE077;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 2/2] selftests: tpm2: Reset the dictionary attack lock
Date:   Sat, 27 Nov 2021 23:10:52 -0500
Message-Id: <20211128041052.1395504-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DuNP_o9IS5atCmAYDiyf_jIZbgGvyCiy
X-Proofpoint-ORIG-GUID: voOQL49-7Mo6P53pJzq5zqN-FAfyCnhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-27_06,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111280018
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Reset the dictionary attack lock to avoid the following types of test
failures after running the test 2 times:

======================================================================
ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2_tests.py", line 105, in test_unseal_with_wrong_policy
    blob = self.client.seal(self.root_key, data, auth, policy_dig)
  File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 620, in seal
    rsp = self.send_cmd(cmd)
  File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 397, in send_cmd
    raise ProtocolError(cc, rc)
tpm2.ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tools/testing/selftests/tpm2/tpm2_tests.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index e63a37819978..ad6f54c01adf 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -139,6 +139,8 @@ class SmokeTest(unittest.TestCase):
         except:
             self.client.flush_context(handle)
             raise
+        finally:
+            self.client.reset_da_lock()
 
         self.assertEqual(rc, tpm2.TPM2_RC_POLICY_FAIL)
 
-- 
2.31.1

