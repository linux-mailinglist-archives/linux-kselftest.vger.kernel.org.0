Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D73664D49
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjAJU1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjAJU0t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:26:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1286E5C930;
        Tue, 10 Jan 2023 12:26:47 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJvuEI008534;
        Tue, 10 Jan 2023 20:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Es0OSIb4OzYg02qlstLfes3mBw5/BQTxvHU0G9JKb4o=;
 b=qBtZaDagPr6+H0RKVde7D9thkpNHtRXW+RozrL5gYNeGxVmJUU5XEGdGxRZbb1CimSvD
 EpSKLKpTWIcldSLCtjgtjx00BKrfTUXuA/mVuoHJS6HvvkmGcQzfSjci2lk2B/ufNAgv
 3ecjEza3NpRNoGh1RGItpC2KkRXQYR3F1xNeM0nbeEUfbf3CL+XmLPq1MVapheZetPA+
 +VnMI57Lxw9qYB4A1OKR1IpXevIR/UzYkeaMA1jidoKTG+0HXUEMjwVhRWQ0hPIsCi8q
 +TMrFwyFVoIEuGaPiP+jRYv0RKW7SpQzmkNULHlPhdzVq91qc1d2sh5aj/lz/YryVUIr JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1en0gme8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:44 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AJxHCf013833;
        Tue, 10 Jan 2023 20:26:43 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1en0gmdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIeFXd024704;
        Tue, 10 Jan 2023 20:26:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6nd4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AKQbsA49873276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 20:26:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51F4320040;
        Tue, 10 Jan 2023 20:26:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C397B20049;
        Tue, 10 Jan 2023 20:26:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 20:26:36 +0000 (GMT)
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
Subject: [PATCH v5 03/10] KVM: s390: selftest: memop: Pass mop_desc via pointer
Date:   Tue, 10 Jan 2023 21:26:25 +0100
Message-Id: <20230110202632.2533978-4-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110202632.2533978-1-scgl@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 70Y1ERrzH2QuK4djlyc8zETNintVHIKz
X-Proofpoint-GUID: RrYht7b2Tx1HdZMM66blz7FM6vSYexoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100133
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

