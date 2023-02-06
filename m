Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2668C426
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 18:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFRDn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 12:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFRDm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 12:03:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631EA21A22;
        Mon,  6 Feb 2023 09:03:41 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316GvKsd011257;
        Mon, 6 Feb 2023 17:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hrA9fZeyTW2k/jOn1JdCQauZ1lZT/lKkQLUaX2O5Ls8=;
 b=hO7zo56/d/yUtd9fiTiTK5rqJzsvYAOFETG3MRmtpg7vVRXJft2nKgH8SKPWxCfgqGFC
 5dwp7/9TJQ81GWQ5F4qYkmgG+bsUzuyHwhZy9trvCMOK7uM/3F6JuyCVMRSm1s22EJfE
 p9bVnXYhojk4qyJwUCdZjiqJNF/hPOUZ6IlXIsz/seE046pAjORkcaGZ/3Jy8mEySlq0
 oaX23/lCfhoP5yAXcn14OHOVRUWHOE2dwek9ug4Xcmlv47jnGQBpztVeUZCL8DzJL9O8
 s4JB6n2I/a5ki1JD5fhE5ik1AjC2TPOjFhptMqY2vhbFe2gGq00dv/xCbR759meXnN65 Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk3rmc1pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 17:03:36 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316Gvscb013793;
        Mon, 6 Feb 2023 17:03:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk3rmc1nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 17:03:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316Bn9B2000395;
        Mon, 6 Feb 2023 16:46:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06hv13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316Gk7Fx46399834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF3762004D;
        Mon,  6 Feb 2023 16:46:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F5942004B;
        Mon,  6 Feb 2023 16:46:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:06 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, Nico Boehr <nrb@linux.ibm.com>
Subject: [PATCH v7 05/14] KVM: s390: selftest: memop: Fix typo
Date:   Mon,  6 Feb 2023 17:45:53 +0100
Message-Id: <20230206164602.138068-6-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RmqJyTy2jHcXQE9anOBHBLJ-o7BtCpER
X-Proofpoint-ORIG-GUID: JhL9eJs5euI3-QEcrZh31rRcU5RAONCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=990
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"acceeded" isn't a word, should be "exceeded".

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 00737cceacda..033a8603a096 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -602,7 +602,7 @@ static void test_errors_key_fetch_prot_override_enabled(void)
 
 	/*
 	 * vcpu, mismatching keys on fetch,
-	 * fetch protection override does not apply because memory range acceeded
+	 * fetch protection override does not apply because memory range exceeded
 	 */
 	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048 + 1, GADDR_V(0), KEY(2));
 	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048 + 1,
-- 
2.37.2

