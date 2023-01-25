Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87A67BE5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjAYV0j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbjAYV0b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCC46178;
        Wed, 25 Jan 2023 13:26:30 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLit0023853;
        Wed, 25 Jan 2023 21:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A0ibDo75A3O6s8W8FrMIWqEiKiyYDurYOY0mSEpbr3g=;
 b=o7LSRJuL6+xiAJRIIcAOd553soNfu8f3pinLo8kreeRmwn5g7qPUdGxoCYAIXM8h0t8w
 RfE9LMmJFzX3UqEjzsHHKJY+BQZnb48I4wkX5ZBQUJMQj96vT6hWIfWLvsfcN35ZghW2
 gFTx8ZgK4UXzS6Zn4N0vj5KtsQmIUR9r6d0OldvVA4DkKAYVLFVQ8a5M5t5ZkpnsJL2j
 mQqGoBKKFxTGF8q2MuGEOZWp6YRr2fcNBKFo84jW9NiT6WiIrT9EZCg/MCUZKH2mWhuH
 LHbfACaCvF7uD3sS7y01zMAmOGgoKd0nCEPO1DRd4A0yCP2XkNUI6tlEHaFECZfno4TE nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb7pp7use-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:25 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PKvjqa031881;
        Wed, 25 Jan 2023 21:26:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb7pp7ure-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PHcQva014950;
        Wed, 25 Jan 2023 21:26:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afdkka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQJdj20644446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85E0C20040;
        Wed, 25 Jan 2023 21:26:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50F1F20043;
        Wed, 25 Jan 2023 21:26:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:26:19 +0000 (GMT)
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
Subject: [PATCH v6 10/14] KVM: s390: Refactor absolute vm mem_op function
Date:   Wed, 25 Jan 2023 22:26:04 +0100
Message-Id: <20230125212608.1860251-11-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125212608.1860251-1-scgl@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VzD9KSghwEC1sl4AGgpmgK2aSg6cIXsr
X-Proofpoint-GUID: KM7-0vnqu6Yxsqh9tP9zgWkiCR1I4k_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=902 suspectscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove code duplication with regards to the CHECK_ONLY flag.
Decrease the number of indents.
No functional change indented.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---


Cosmetic only, can be dropped.


 arch/s390/kvm/kvm-s390.c | 43 ++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 588cf70dc81e..cfd09cb43ef6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2794,6 +2794,7 @@ static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
 static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
+	enum gacc_mode acc_mode;
 	void *tmpbuf = NULL;
 	int r, srcu_idx;
 
@@ -2813,33 +2814,23 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 		goto out_unlock;
 	}
 
-	switch (mop->op) {
-	case KVM_S390_MEMOP_ABSOLUTE_READ: {
-		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
-			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_FETCH, mop->key);
-		} else {
-			r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
-						      mop->size, GACC_FETCH, mop->key);
-			if (r == 0) {
-				if (copy_to_user(uaddr, tmpbuf, mop->size))
-					r = -EFAULT;
-			}
-		}
-		break;
-	}
-	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
-		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
-			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
-		} else {
-			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
-				r = -EFAULT;
-				break;
-			}
-			r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
-						      mop->size, GACC_STORE, mop->key);
+	acc_mode = mop->op == KVM_S390_MEMOP_ABSOLUTE_READ ? GACC_FETCH : GACC_STORE;
+	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
+		r = check_gpa_range(kvm, mop->gaddr, mop->size, acc_mode, mop->key);
+	} else if (acc_mode == GACC_FETCH) {
+		r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
+					      mop->size, GACC_FETCH, mop->key);
+		if (r)
+			goto out_unlock;
+		if (copy_to_user(uaddr, tmpbuf, mop->size))
+			r = -EFAULT;
+	} else {
+		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
+			r = -EFAULT;
+			goto out_unlock;
 		}
-		break;
-	}
+		r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
+					      mop->size, GACC_STORE, mop->key);
 	}
 
 out_unlock:
-- 
2.34.1

