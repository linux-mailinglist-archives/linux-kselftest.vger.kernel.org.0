Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1D145D22D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 01:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbhKYAnr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 19:43:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23578 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344872AbhKYAlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 19:41:44 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOMkTKv010842;
        Thu, 25 Nov 2021 00:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eHgws6Wf+qHlJO679jheVoKil2upivq+jcL7XncWqkQ=;
 b=kJzhlvQlrLENeWZY2ETiqeqlviQaNuFYTBungREiTdL38cRCDoT/l+cJp9oYMng69Akh
 MfQ4xuE0OH6KpAVJ8oxx17RBOqaqWGa02+0fP6NbkIUQCx8mGjewbWDP2rjyzVdEAS1v
 w+ACfvUeSHC1BJb5RgV7K6nCapK5H+DXUoO6YV1EKAPvp5Vj3B9m3MIzs3199ReR5crA
 Ett0V/EO486Szcmuvt5C48ElJKQGVcmz6zxgEht3VjuGaXaEGFqGSkmxrZ6qym5VaT99
 TDg6UrdjPmhQcHRefHsRcviksyiTqD1nnpVVgix0IHIepLS0my1l3ojr9oQlMF1m2v5r 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chxfyhgus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:31 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AP0cKJH004049;
        Thu, 25 Nov 2021 00:38:31 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chxfyhguk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:31 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AP0NA4I007152;
        Thu, 25 Nov 2021 00:38:30 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3cernchega-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AP0cT9b63308084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 00:38:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7013EB205F;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 618FBB206B;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/3] selftests: tpm2: Reset the dictionary attack lock
Date:   Wed, 24 Nov 2021 19:38:26 -0500
Message-Id: <20211125003827.1360432-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211125003827.1360432-1-stefanb@linux.vnet.ibm.com>
References: <20211125003827.1360432-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l_lJ2Chsup2ssHdwBAoYUCt6U-ewlKmz
X-Proofpoint-ORIG-GUID: f5mdSKbHvDDH3GjE8Xw3nk7sTisQeyOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111250000
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

