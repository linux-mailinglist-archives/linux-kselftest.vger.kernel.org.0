Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2636A45D22A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 01:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbhKYAno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 19:43:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344852AbhKYAln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 19:41:43 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AONr0TK019350;
        Thu, 25 Nov 2021 00:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7uULuc7RJ/sDND/XJhW4SmszDs2r+mbLmuNrja6S5MI=;
 b=o/ym8Vl+G7SO7f1/ckC9sEv5ADs1sQ9GOWEBvXfncv9U2hDLJlVB0nnnRUYalb7HRbUv
 k9l4Fg9m+HRmrL/qkplgci34GVM//MRLs69CAvUTROaVVKVg5LLli/tFhlZLB6mNSAnG
 g6yc2rqeb+CDMSLzyseo90pu0qTYfJDOKv1z4AwQk7DS41PE/Llv5I7xQdM68lC6NPQB
 mYKN4oNWyU1ADkcVgApEkSm/cVqJTucna0El8oMB67QDbxxdzHqh3SHnNeQ0FJGMPRFc
 dvzYXNqTGGLD2EfbCPD+bKO53Rq9PaRK7xnEwHXv6zXnQZ/94QrTPpbzxLtdPIdg+Q8/ Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chyevrn8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:31 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AP0XX4J003717;
        Thu, 25 Nov 2021 00:38:31 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chyevrn7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:31 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AP0MiHl011093;
        Thu, 25 Nov 2021 00:38:30 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3cerncs957-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AP0cT3D63045954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 00:38:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60AE1B2064;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46F8BB2068;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 1/3] selftests: tpm2: Probe for available PCR bank
Date:   Wed, 24 Nov 2021 19:38:25 -0500
Message-Id: <20211125003827.1360432-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211125003827.1360432-1-stefanb@linux.vnet.ibm.com>
References: <20211125003827.1360432-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: flss9q9zMQk0ci612-yagsEEbcy2WI1s
X-Proofpoint-ORIG-GUID: smPsZ5eqorEHNzKElpfcuT8WdxgNm0fo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250000
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Probe for an available PCR bank to accommodate devices that do not have a
SHA-1 PCR bank or whose SHA-1 bank is deactivated. Use the bank that can
be used for the TPM2 commands, such as the SHA-256 bank.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tools/testing/selftests/tpm2/tpm2_tests.py | 35 +++++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 9d764306887b..6b88ff0e47b9 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -27,7 +27,23 @@ class SmokeTest(unittest.TestCase):
         result = self.client.unseal(self.root_key, blob, auth, None)
         self.assertEqual(data, result)
 
+    def determine_bank_alg(self):
+        # Probe for available PCR bank
+        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256]:
+            try:
+                handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
+                self.client.policy_pcr(handle, [17], bank_alg=bank_alg)
+                return bank_alg
+            except tpm2.UnknownPCRBankError:
+                pass
+            finally:
+                self.client.flush_context(handle)
+        return None
+
     def test_seal_with_policy(self):
+        bank_alg = self.determine_bank_alg()
+        self.assertIsNotNone(bank_alg)
+
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
         data = ('X' * 64).encode()
@@ -35,7 +51,7 @@ class SmokeTest(unittest.TestCase):
         pcrs = [16]
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             policy_dig = self.client.get_policy_digest(handle)
@@ -47,7 +63,7 @@ class SmokeTest(unittest.TestCase):
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
@@ -72,6 +88,9 @@ class SmokeTest(unittest.TestCase):
         self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
 
     def test_unseal_with_wrong_policy(self):
+        bank_alg = self.determine_bank_alg()
+        self.assertIsNotNone(bank_alg)
+
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
         data = ('X' * 64).encode()
@@ -79,7 +98,7 @@ class SmokeTest(unittest.TestCase):
         pcrs = [16]
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             policy_dig = self.client.get_policy_digest(handle)
@@ -91,13 +110,13 @@ class SmokeTest(unittest.TestCase):
         # Extend first a PCR that is not part of the policy and try to unseal.
         # This should succeed.
 
-        ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
-        self.client.extend_pcr(1, ('X' * ds).encode())
+        ds = tpm2.get_digest_size(bank_alg)
+        self.client.extend_pcr(1, ('X' * ds).encode(), bank_alg=bank_alg)
 
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
@@ -109,14 +128,14 @@ class SmokeTest(unittest.TestCase):
 
         # Then, extend a PCR that is part of the policy and try to unseal.
         # This should fail.
-        self.client.extend_pcr(16, ('X' * ds).encode())
+        self.client.extend_pcr(16, ('X' * ds).encode(), bank_alg=bank_alg)
 
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
         rc = 0
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
-- 
2.31.1

