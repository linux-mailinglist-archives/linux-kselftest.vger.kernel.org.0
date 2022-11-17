Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD562E82B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 23:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiKQWTg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 17:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbiKQWTD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA6F786EC;
        Thu, 17 Nov 2022 14:18:20 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHLRYZm026984;
        Thu, 17 Nov 2022 22:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bRsMyRo7qbgJh304THbYg9Jy/rlIw7N2YlCaunhJyX0=;
 b=BMMeekXoD2xcRvH331I9CTorUBzv3lt+YSQNue5jTrJcPZGlbTqgLcnXW4Ls9u73N2mM
 nVrytXy0Jj2AluhSmUWG6AOssbaR50QgZN5p3tAEXPmg9H9ru4waxk6GUjr2Mf8+/YJu
 g2oG9Bgh/w4wMBa7gIKcEASeJLPweOFW0MdFrYEntuFiGTMeak8PE2yxSjruQMjEwYGE
 I8L5hZcwqg0GN4TlX2RrGxAhQt2J3evvVJ5ionSDdEhDyPzvTNjE3DgvgeLEwez0JPVm
 vSFlUfaPMCC38v05O51WuK7A27h+TExK5OtgFhzN2CKBJ/Nre+UFB4tCaN1T12hrYcg3 Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwuvytkgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:14 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHLm1db001434;
        Thu, 17 Nov 2022 22:18:13 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwuvytkfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHM5aVn017689;
        Thu, 17 Nov 2022 22:18:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3kwte4g42p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHMI8ZE39256372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 22:18:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 084E3A404D;
        Thu, 17 Nov 2022 22:18:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F2B2A4057;
        Thu, 17 Nov 2022 22:18:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 22:18:07 +0000 (GMT)
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
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 3/9] KVM: s390: selftest: memop: Pass mop_desc via pointer
Date:   Thu, 17 Nov 2022 23:17:52 +0100
Message-Id: <20221117221758.66326-4-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117221758.66326-1-scgl@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NjUP1-moDtk1dVe6EQ3cp0d7Dpb9bo_d
X-Proofpoint-GUID: -cxq1OJfbGFvLs0c7n_27_Osc5VKl6GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The struct is quite large, so this seems nicer.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 44 +++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 9113696d5178..69869c7e2ab1 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -48,53 +48,53 @@ struct mop_desc {
 	uint8_t key;
 };
 
-static struct kvm_s390_mem_op ksmo_from_desc(struct mop_desc desc)
+static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
 {
 	struct kvm_s390_mem_op ksmo = {
-		.gaddr = (uintptr_t)desc.gaddr,
-		.size = desc.size,
-		.buf = ((uintptr_t)desc.buf),
+		.gaddr = (uintptr_t)desc->gaddr,
+		.size = desc->size,
+		.buf = ((uintptr_t)desc->buf),
 		.reserved = "ignored_ignored_ignored_ignored"
 	};
 
-	switch (desc.target) {
+	switch (desc->target) {
 	case LOGICAL:
-		if (desc.mode == READ)
+		if (desc->mode == READ)
 			ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
-		if (desc.mode == WRITE)
+		if (desc->mode == WRITE)
 			ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 		break;
 	case SIDA:
-		if (desc.mode == READ)
+		if (desc->mode == READ)
 			ksmo.op = KVM_S390_MEMOP_SIDA_READ;
-		if (desc.mode == WRITE)
+		if (desc->mode == WRITE)
 			ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
 		break;
 	case ABSOLUTE:
-		if (desc.mode == READ)
+		if (desc->mode == READ)
 			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_READ;
-		if (desc.mode == WRITE)
+		if (desc->mode == WRITE)
 			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_WRITE;
 		break;
 	case INVALID:
 		ksmo.op = -1;
 	}
-	if (desc.f_check)
+	if (desc->f_check)
 		ksmo.flags |= KVM_S390_MEMOP_F_CHECK_ONLY;
-	if (desc.f_inject)
+	if (desc->f_inject)
 		ksmo.flags |= KVM_S390_MEMOP_F_INJECT_EXCEPTION;
-	if (desc._set_flags)
-		ksmo.flags = desc.set_flags;
-	if (desc.f_key) {
+	if (desc->_set_flags)
+		ksmo.flags = desc->set_flags;
+	if (desc->f_key) {
 		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
-		ksmo.key = desc.key;
+		ksmo.key = desc->key;
 	}
-	if (desc._ar)
-		ksmo.ar = desc.ar;
+	if (desc->_ar)
+		ksmo.ar = desc->ar;
 	else
 		ksmo.ar = 0;
-	if (desc._sida_offset)
-		ksmo.sida_offset = desc.sida_offset;
+	if (desc->_sida_offset)
+		ksmo.sida_offset = desc->sida_offset;
 
 	return ksmo;
 }
@@ -183,7 +183,7 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 		else								\
 			__desc.gaddr = __desc.gaddr_v;				\
 	}									\
-	__ksmo = ksmo_from_desc(__desc);					\
+	__ksmo = ksmo_from_desc(&__desc);					\
 	print_memop(__info.vcpu, &__ksmo);					\
 	err##memop_ioctl(__info, &__ksmo);					\
 })
-- 
2.34.1

