Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3221F5F1461
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiI3VIL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiI3VII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 17:08:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0988A1A9A68;
        Fri, 30 Sep 2022 14:08:07 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UIr4Li035844;
        Fri, 30 Sep 2022 21:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Vgu4PmT0iIBhqrHzLbhUPLUh6ZNPHDvATcyS2Zynq3g=;
 b=hyQIAGX9Hrc/stjoTfpP4VEiE9Ahwf0sRcj30QSn0Ro+JwYC154h4sVV+TT3V/yn4Pd1
 VLBiI88DDotmVsvG73hy1iDO6qRkMcbL8Nb9uP0U03RtE6R8r2CDrm+ZhsTfxxt/eJjN
 wHS7F0dWrasz3o+wyoZShISLoF4NfzfmgsY2bgqJNxUs6mhVyW5M3xZYeVSJmHuBnPaD
 cMA42qlHPQkZka+bm3mSUNE3VqbDRYChGz+YhmPIaFLpfzQouFhyIECnXQPc+GDcLIKx
 qmIPREWvwKPubSboVPNrl8oU44u/tI/RlIfWDVVz+GhWg9Udish+anRRSS7oXJGR9U9S ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx64kkk5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:04 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UKwoST020661;
        Fri, 30 Sep 2022 21:08:03 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx64kkk4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28UL5mmA001205;
        Fri, 30 Sep 2022 21:08:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j8mcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28UL7wut61145548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 21:07:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A73DA4062;
        Fri, 30 Sep 2022 21:07:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1DB4A405C;
        Fri, 30 Sep 2022 21:07:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 21:07:57 +0000 (GMT)
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
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v1 4/9] KVM: s390: selftest: memop: Pass mop_desc via pointer
Date:   Fri, 30 Sep 2022 23:07:46 +0200
Message-Id: <20220930210751.225873-5-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930210751.225873-1-scgl@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q20Y3gA6pPRrrLcq-uWC3i4On1qoKfCb
X-Proofpoint-GUID: BtIPHOiYHSVYdmGv6M5_7EhC7zprgB8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300131
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

