Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9AD45C6F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352787AbhKXOQ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 09:16:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44566 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352777AbhKXOQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 09:16:34 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOBm91w005285;
        Wed, 24 Nov 2021 14:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FRrxLWEmfeQ/NnkQZMb7wpFJ+lJSMAm3qJyxMRFZ5F4=;
 b=MR1wE7E9GDJIL3rS33NuC2lJ4SuFT+Myj0/i1fpzhBmD/QC7mmDAjkF+x0Pqgh0NuzOb
 cG/wxIaZRblftNb1dEZ+vYgPk6S+yZSIkioWbju3VBB6zXEF7uC5O6ugNp592vaijHZw
 85WonEnCHBWejQSAspCRITUPn5Zcpry7SYo6EGmVUZwbdS8KAKt5m3VJ4B0dT6A3ccz5
 p+715BduR47p5j6F8svRNGnWmqgtyfvWgIcU2mDA053jNZzq5KN9T7rVXutb32QSrzqt
 yIr9mJgoES5yQLG219BOQ+ABJQCuyb7sRA2Fvjit+JOplp0v+85xLHv1by6iKzJ/2GA2 MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chmu1b31v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:22 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AOE9suu023413;
        Wed, 24 Nov 2021 14:13:22 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chmu1b31f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:22 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOECixS027887;
        Wed, 24 Nov 2021 14:13:21 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3cernb2evt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:21 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AOEDKVG40763736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 14:13:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9278B206E;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98853B2067;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 3/3] selftests: tpm2: Add support for SHA-384 and SHA-512
Date:   Wed, 24 Nov 2021 09:13:14 -0500
Message-Id: <20211124141314.1356338-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124141314.1356338-1-stefanb@linux.ibm.com>
References: <20211124141314.1356338-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cx8zVA4XdFK3OwFpWkFURNMTBeaTX_Lf
X-Proofpoint-ORIG-GUID: _tVLqPmiRL_rnkoZgzVYLbt27FC-wqXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_04,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240079
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for SHA-384 and SHA-512 to the TPM2 library and extend
the test case's PCR bank probing function to also probe for SHA-384
and SHA-512 banks in case SHA-1 and SHA-256 banks are not available
for use.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tools/testing/selftests/tpm2/tpm2.py       | 12 +++++++++++-
 tools/testing/selftests/tpm2/tpm2_tests.py |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index f34486cd7342..d0960fe0e029 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -37,6 +37,8 @@ TPM2_ALG_SHA1 = 0x0004
 TPM2_ALG_AES = 0x0006
 TPM2_ALG_KEYEDHASH = 0x0008
 TPM2_ALG_SHA256 = 0x000B
+TPM2_ALG_SHA384 = 0x000C
+TPM2_ALG_SHA512 = 0x000D
 TPM2_ALG_NULL = 0x0010
 TPM2_ALG_CBC = 0x0042
 TPM2_ALG_CFB = 0x0043
@@ -67,6 +69,8 @@ HR_TRANSIENT = 0x80000000
 
 SHA1_DIGEST_SIZE = 20
 SHA256_DIGEST_SIZE = 32
+SHA384_DIGEST_SIZE = 48
+SHA512_DIGEST_SIZE = 64
 
 TPM2_VER0_ERRORS = {
     0x000: "TPM_RC_SUCCESS",
@@ -186,16 +190,22 @@ RC_WARN = 0x900
 ALG_DIGEST_SIZE_MAP = {
     TPM2_ALG_SHA1: SHA1_DIGEST_SIZE,
     TPM2_ALG_SHA256: SHA256_DIGEST_SIZE,
+    TPM2_ALG_SHA384: SHA384_DIGEST_SIZE,
+    TPM2_ALG_SHA512: SHA512_DIGEST_SIZE,
 }
 
 ALG_HASH_FUNCTION_MAP = {
     TPM2_ALG_SHA1: hashlib.sha1,
-    TPM2_ALG_SHA256: hashlib.sha256
+    TPM2_ALG_SHA256: hashlib.sha256,
+    TPM2_ALG_SHA384: hashlib.sha384,
+    TPM2_ALG_SHA512: hashlib.sha512,
 }
 
 NAME_ALG_MAP = {
     "sha1": TPM2_ALG_SHA1,
     "sha256": TPM2_ALG_SHA256,
+    "sha384": TPM2_ALG_SHA384,
+    "sha512": TPM2_ALG_SHA512,
 }
 
 
diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index ae88d8866e5d..3feca25038f5 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -29,7 +29,8 @@ class SmokeTest(unittest.TestCase):
 
     def determine_bank_alg(self):
         # Probe for available PCR bank
-        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256]:
+        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256,
+                         tpm2.TPM2_ALG_SHA384, tpm2.TPM2_ALG_SHA512]:
             try:
                 handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
                 self.client.policy_pcr(handle, [17], bank_alg=bank_alg)
-- 
2.31.1

