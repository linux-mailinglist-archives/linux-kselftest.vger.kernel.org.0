Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516EE5BE6D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiITNPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiITNPf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 09:15:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5EF3DF18;
        Tue, 20 Sep 2022 06:15:33 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KD0JFt026187;
        Tue, 20 Sep 2022 13:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PYIvYTAAdCiZxua/KpMy+T+6zdoN1f7wb9Ci3NDqtGk=;
 b=E3U/G4CPYZHfLQo34pCSP0RKwpxO3ZRWUSo5ViEuMwg4y9uM2rUTiU6PwEkahX41p6z9
 2kDHWcZ8Es3eRZxMqGs26dUF4NPeB0uefbPjo0e1Sh0C3h7om1eHwt+EKpTGOUl88gCh
 04umVxAIIb2tJ1hqNlB4bGfubeZLiDYp1Ewr3xs6kjKGuCth7E8IdwbeMSFSZiHx4OCj
 wQFn9CnAjpNEtt1UspJo34+ZX1UUjntNtC0NLckDfvIasVOZXBFjNtS6492wyw7VB7bH
 w2qvKIjN6oaJQhh/dmzcft+kcraqK+CJddTo2xzhQLF6O/vhfwZBmaGO+9i9t1anMnfy QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqe17gtp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:15:30 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KD0gQe028275;
        Tue, 20 Sep 2022 13:15:29 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqe17gtn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:15:29 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KD701H030978;
        Tue, 20 Sep 2022 13:15:28 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3jn5v9rutx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:15:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KDFRBF31195426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 13:15:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377C55805F;
        Tue, 20 Sep 2022 13:15:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BC2458053;
        Tue, 20 Sep 2022 13:15:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 13:15:26 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        shuah@kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2] selftest: tpm2: Add Client.__del__() to close /dev/tpm* handle
Date:   Tue, 20 Sep 2022 09:15:18 -0400
Message-Id: <20220920131518.1984701-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Scym3ii4UvSkSUb59rvM09EGyQVHtVLS
X-Proofpoint-GUID: ogfoCpxp-5wj3ziIDOFJQjEk-7AzJsrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=533 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following output can bee seen when the test is executed:

  test_flush_context (tpm2_tests.SpaceTest) ... \
    /usr/lib64/python3.6/unittest/case.py:605: ResourceWarning: \
    unclosed file <_io.FileIO name='/dev/tpmrm0' mode='rb+' closefd=True>

An instance of Client does not implicitly close /dev/tpm* handle, once it
gets destroyed. Close the file handle in the class destructor
Client.__del__().

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
2.36.1

