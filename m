Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0032068C3A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBFQqY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBFQqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F832884D;
        Mon,  6 Feb 2023 08:46:19 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316Gk9pj001282;
        Mon, 6 Feb 2023 16:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O63EL2nVE0XoojtA41wT6iXaXKgqdbtdUQDq2wyErxE=;
 b=mhGJZmQ7vpUKUUI0uN0p+O1xJVGPMhiZXQ/pimQpwwLqvssOSaUCcPqUzd++gfkxjcFc
 tAUJNP03l084ZKv26ZGla1/xmp+/+/ISO97MTeK1IHZKnoMNp+UNnmRTujPUJnfIsjcQ
 EWlJl7eWhZ8/2XzTEqWaHNBoUXfIsTkRART2jakmzkMpwWhpObCh5CJHWbNoK3aBX2fb
 VUP+7jxEL9+licueNtnbz9aPaCyg2JfyBGEE6kXjOuYao06xqdaBxz/lJnWcOnCBOCeQ
 EZcfuJhem/Da4wbhuJyDRB1nZkoMSkVMCul43UTM3ekStUe+WFISp219RkYaEXMVOoDm 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk5c2r03j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:12 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316GkCG4001388;
        Mon, 6 Feb 2023 16:46:12 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk5c2r02g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:12 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316Ed2r2026561;
        Mon, 6 Feb 2023 16:46:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3nhf06sv6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316Gk6hl47907326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6311020040;
        Mon,  6 Feb 2023 16:46:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA37620043;
        Mon,  6 Feb 2023 16:46:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:05 +0000 (GMT)
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
        Nico Boehr <nrb@linux.ibm.com>
Subject: [PATCH v7 04/14] KVM: s390: selftest: memop: Add bad address test
Date:   Mon,  6 Feb 2023 17:45:52 +0100
Message-Id: <20230206164602.138068-5-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2jfJV1NDil-NuDnV-QuzXzTgHC-JeC9W
X-Proofpoint-ORIG-GUID: ShSHD1LSOsdqg9L_DK0f_V0Znx9ucinY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test that tries a real write to a bad address.
The existing CHECK_ONLY test doesn't cover all paths.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index bbc191a13760..00737cceacda 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -641,7 +641,9 @@ static void _test_errors_common(struct test_info info, enum mop_target target, i
 
 	/* Bad guest address: */
 	rv = ERR_MOP(info, target, WRITE, mem1, size, GADDR((void *)~0xfffUL), CHECK_ONLY);
-	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address with CHECK_ONLY");
+	rv = ERR_MOP(info, target, WRITE, mem1, size, GADDR((void *)~0xfffUL));
+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address on write");
 
 	/* Bad host address: */
 	rv = ERR_MOP(info, target, WRITE, 0, size, GADDR_V(mem1));
-- 
2.37.2

