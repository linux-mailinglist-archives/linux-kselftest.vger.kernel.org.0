Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5473A68F120
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 15:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjBHOsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjBHOsj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 09:48:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7D5267;
        Wed,  8 Feb 2023 06:48:38 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318E9wOx027415;
        Wed, 8 Feb 2023 14:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0Dpp0uD7MgEFHwPxlovGLIyepydLua0J6/J5k8CtH6s=;
 b=LcoLiUkOUXFgzhY9C3OQXMOCiGT0YbRSl6HOLoaQwOarb7wcdyw3DGVZeDiWpsjkZRxQ
 KQIGJzYfeWVD9ocGdzxgwDp2BfNYZgDAkrA2h8oCuB0v44AZa4m5Q/2HL5T5EnQHa/Em
 V6feloi+Ep1mj6BxxO8UDN4nhDeUvMXa1s2UcOKV91Rc9JrC0fEPTDilzZM0eyOdsGEJ
 DwlCjCWKuHRFzzRj3voF17Ew3lJPr/XlW2G7uDKEEmsFSq28Og2oo5t0V7YqMikyoSzK
 wdjAtIHQHfOS+/hbnk3XzkK3CiOLE1ej1IZbbPDPIELP0XxAOFFsIpLYpoRJKlwOHzaf Rg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmcy5sgj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 14:48:36 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 317KbFEr024491;
        Wed, 8 Feb 2023 14:48:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3nhemfkkjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 14:48:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318EmS4124052452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 14:48:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CBBB2004F;
        Wed,  8 Feb 2023 14:48:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ABA720040;
        Wed,  8 Feb 2023 14:48:28 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 14:48:28 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 0/2] KVM: s390: CMMA migration selftest and small bugfix
Date:   Wed,  8 Feb 2023 15:48:25 +0100
Message-Id: <20230208144827.131300-1-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OGRA7vpgN13EkQkbDm2LCcLJq8dwqWBA
X-Proofpoint-ORIG-GUID: OGRA7vpgN13EkQkbDm2LCcLJq8dwqWBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_06,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=780
 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new selftest for CMMA migration. Also fix a small issue found during
development of the test.

Nico Boehr (2):
  KVM: s390: selftests: add selftest for CMMA migration
  KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

 arch/s390/kvm/kvm-s390.c                      |   4 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/s390x/cmma_test.c | 679 ++++++++++++++++++
 3 files changed, 684 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c

-- 
2.39.1

