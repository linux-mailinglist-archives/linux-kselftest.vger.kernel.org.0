Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82E67BE75
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjAYV03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjAYV02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D102845BC1;
        Wed, 25 Jan 2023 13:26:26 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKggpA022656;
        Wed, 25 Jan 2023 21:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Es0OSIb4OzYg02qlstLfes3mBw5/BQTxvHU0G9JKb4o=;
 b=Tj8cZJslKh5Un1LLtlw8MsvAbqBJGQRC/fxxHAXwg4NgL4UPw7k/NzJGMG1Wgv0BuHI9
 EVMLI9aPDQNt2DZCvGVd7Ny4EudyNxxDqpCdIE4rm36uQVTkMv0wT4WMIfAj7iN4IPde
 KYYO1LRI5m8Ow1mdrQz1ksu5Ks6KzmD+F0sBjA2zONJfegpc3NXmkxuB9S+hYM2glDqx
 0P9I/DY5ikcefEGEDXyGPPcU+4tiD9RhPB6Kncd/5DZCUyGCB8SUj7BePV6gNhNXmQsZ
 v8le59tGMIkzrDz8qPw3p9hEax33KpHdVODNE2GV28//26x/gJCEwgHMXuLjvkSKhwHq 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naagv1wq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:23 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PLQNFF007553;
        Wed, 25 Jan 2023 21:26:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naagv1wp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGU8Ym010790;
        Wed, 25 Jan 2023 21:26:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6nkn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQHFm24445592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A31C20043;
        Wed, 25 Jan 2023 21:26:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7A4E2004D;
        Wed, 25 Jan 2023 21:26:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:26:16 +0000 (GMT)
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
Subject: [PATCH v6 01/14] KVM: s390: selftest: memop: Pass mop_desc via pointer
Date:   Wed, 25 Jan 2023 22:25:55 +0100
Message-Id: <20230125212608.1860251-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125212608.1860251-1-scgl@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TUsZW17QGkTIs0jvtZEBWYxr_MGXI-oo
X-Proofpoint-GUID: cYPAP65_zkcCsU3y-pHFf98qfd1S1_G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301250187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 3fd81e58f40c..9c05d1205114 100644
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

