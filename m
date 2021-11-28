Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390DF4603DC
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Nov 2021 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbhK1EQV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Nov 2021 23:16:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349937AbhK1EOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Nov 2021 23:14:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AS41OAh009392;
        Sun, 28 Nov 2021 04:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uNXLyegQ34g+J10AHkdXr/GwkoSbIjjKUQCVeP8/3dQ=;
 b=ZJ4ceKbMlk6ZOB8pqlMlHs1OKXiAYeMnWT2dGwdb8g9zVhGuZUrKptzglO1gizySsrGJ
 vQC9A/jonTOvY7JtlAD6HG19ezSFmGScsVostghrnrEKQyBeMehwJSRH0LBBqxVG6SnD
 vEm70K90MosJb2jhXdKmztNVH3tkixMJ3XsKYDzPRLUvreDZCpQffwkSWPG9U0k9X9js
 rZUHFrPQ6629HHwkkvqcMses7WEBg8IKHP1IxpuUnJqHsGjQ3sTKK9TkTpZpXQ1lh4Wv
 dB2XV1rIhPv4hWv4IIMz6VvX8d+RNzxKMX53aqk9yc2SbqBme+esToZRIrYdu3irgLW5 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cm2cm83n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:57 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AS42Dv8010392;
        Sun, 28 Nov 2021 04:10:56 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cm2cm83mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:56 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AS48cv9028213;
        Sun, 28 Nov 2021 04:10:55 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckca9bgtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:55 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AS4AsOG16384450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Nov 2021 04:10:54 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2053AE063;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1B83AE075;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 1/2] selftests: tpm2: Determine available PCR bank
Date:   Sat, 27 Nov 2021 23:10:51 -0500
Message-Id: <20211128041052.1395504-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: awKnyTMFh6ekcelDeUrCyZ48YzQO6ddp
X-Proofpoint-ORIG-GUID: N7bfWrsUodZwk44zttAv71i7zhiLqaqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-27_06,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111280014
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Determine an available PCR bank to be used by a test case by querying the
capability TPM2_GET_CAP. The TPM2 returns TPML_PCR_SELECTIONS that
contains an array of TPMS_PCR_SELECTIONs indicating available PCR banks
and the bitmasks that show which PCRs are enabled in each bank. Collect
the data in a dictionary. From the dictionary determine the PCR bank that
has the PCRs enabled that the test needs. This avoids test failures with
TPM2's that either to not have a SHA-1 bank or whose SHA-1 bank is
disabled.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tools/testing/selftests/tpm2/tpm2.py       | 31 ++++++++++++++++++++++
 tools/testing/selftests/tpm2/tpm2_tests.py | 29 ++++++++++++++------
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index f34486cd7342..057a4f49c79d 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -56,6 +56,7 @@ TSS2_RESMGR_TPM_RC_LAYER = (11 << TSS2_RC_LAYER_SHIFT)
 
 TPM2_CAP_HANDLES = 0x00000001
 TPM2_CAP_COMMANDS = 0x00000002
+TPM2_CAP_PCRS = 0x00000005
 TPM2_CAP_TPM_PROPERTIES = 0x00000006
 
 TPM2_PT_FIXED = 0x100
@@ -712,3 +713,33 @@ class Client:
             pt += 1
 
         return handles
+
+    def get_cap_pcrs(self):
+        pcr_banks = {}
+
+        fmt = '>HII III'
+
+        cmd = struct.pack(fmt,
+                          TPM2_ST_NO_SESSIONS,
+                          struct.calcsize(fmt),
+                          TPM2_CC_GET_CAPABILITY,
+                          TPM2_CAP_PCRS, 0, 1)
+        rsp = self.send_cmd(cmd)[10:]
+        _, _, cnt = struct.unpack('>BII', rsp[:9])
+        rsp = rsp[9:]
+
+        # items are TPMS_PCR_SELECTION's
+        for i in range(0, cnt):
+              hash, sizeOfSelect = struct.unpack('>HB', rsp[:3])
+              rsp = rsp[3:]
+
+              pcrSelect = 0
+              if sizeOfSelect > 0:
+                  pcrSelect, = struct.unpack('%ds' % sizeOfSelect,
+                                             rsp[:sizeOfSelect])
+                  rsp = rsp[sizeOfSelect:]
+                  pcrSelect = int.from_bytes(pcrSelect, byteorder='big')
+
+              pcr_banks[hash] = pcrSelect
+
+        return pcr_banks
diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 9d764306887b..e63a37819978 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -27,7 +27,17 @@ class SmokeTest(unittest.TestCase):
         result = self.client.unseal(self.root_key, blob, auth, None)
         self.assertEqual(data, result)
 
+    def determine_bank_alg(self, mask):
+        pcr_banks = self.client.get_cap_pcrs()
+        for bank_alg, pcrSelection in pcr_banks.items():
+            if pcrSelection & mask == mask:
+                return bank_alg
+        return None
+
     def test_seal_with_policy(self):
+        bank_alg = self.determine_bank_alg(1 << 16)
+        self.assertIsNotNone(bank_alg)
+
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
         data = ('X' * 64).encode()
@@ -35,7 +45,7 @@ class SmokeTest(unittest.TestCase):
         pcrs = [16]
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             policy_dig = self.client.get_policy_digest(handle)
@@ -47,7 +57,7 @@ class SmokeTest(unittest.TestCase):
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
@@ -72,6 +82,9 @@ class SmokeTest(unittest.TestCase):
         self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
 
     def test_unseal_with_wrong_policy(self):
+        bank_alg = self.determine_bank_alg(1 << 16 | 1 << 1)
+        self.assertIsNotNone(bank_alg)
+
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
         data = ('X' * 64).encode()
@@ -79,7 +92,7 @@ class SmokeTest(unittest.TestCase):
         pcrs = [16]
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             policy_dig = self.client.get_policy_digest(handle)
@@ -91,13 +104,13 @@ class SmokeTest(unittest.TestCase):
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
@@ -109,14 +122,14 @@ class SmokeTest(unittest.TestCase):
 
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

