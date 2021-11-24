Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FB45C6F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 15:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349513AbhKXOQz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 09:16:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350167AbhKXOQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 09:16:34 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOCGOUC009576;
        Wed, 24 Nov 2021 14:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NcKGNOPRaEm058WySCDr4gUAVGYTkQF0nWb9MaVlod0=;
 b=KIS5WEfx3YkpVaHdOmFh0YYj06MJpb9CoZa+BABjxus2uiC07kfZik18xED5gXcMocME
 vgpRpy50L4i/WzquIsfhVjqv98xU42PVi2jnS1IXMPJgwbIIly/lq1cZxfTKxMGjJyLK
 hmaRKoERfk3T10oyGZsS43ASCq9uMX4vTTybxnq0ZK0h/z3EflpZBFCCIiDLJIltgxWc
 bTk6YleAEvzDsQZEEu3HD6sH36gmn1B+elw/ulr4l/z0NpKFY6Ap3h6xSFpPdreiqulb
 WjRjvnzuyzma4mvK3OsC4Q8xod0NNnvBqc/og6kqwDoGTPoFpwyia0dWWrrDp7SeXaHZ pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chn8n2k8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:22 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AODghmN019348;
        Wed, 24 Nov 2021 14:13:22 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chn8n2k8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:22 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOECuJI030078;
        Wed, 24 Nov 2021 14:13:21 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3ch1nc3uft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:21 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AOEDKlr41222474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 14:13:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97CA3B2073;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87647B206E;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/3] selftests: tpm2: Reset the dictionary attack lock
Date:   Wed, 24 Nov 2021 09:13:13 -0500
Message-Id: <20211124141314.1356338-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124141314.1356338-1-stefanb@linux.ibm.com>
References: <20211124141314.1356338-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LOunOUx6HG7kDIiykQ0l8oKO2SpRLEWZ
X-Proofpoint-GUID: vhHrHobym2kGm1rRAu2SWdkVBofUP3vr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_04,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240079
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
 tools/testing/selftests/tpm2/tpm2_tests.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 6b88ff0e47b9..ae88d8866e5d 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -104,6 +104,7 @@ class SmokeTest(unittest.TestCase):
             policy_dig = self.client.get_policy_digest(handle)
         finally:
             self.client.flush_context(handle)
+            self.client.reset_da_lock()
 
         blob = self.client.seal(self.root_key, data, auth, policy_dig)
 
-- 
2.31.1

