Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EEF67BE48
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbjAYV0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjAYV03 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EFE46178;
        Wed, 25 Jan 2023 13:26:28 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLcWS010777;
        Wed, 25 Jan 2023 21:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8Jgf76vGqzrfemZ0V6EbZLJItlSgTmsc5yqsLYP/z7o=;
 b=ZxvjTnWVRR9NatH8ZT0cYK7IsKTCN6velUROjqv/vmA4yixBPOaYd29z+MdLdbzudQzg
 skq745czSSUKs3ZFL/to2SZUhoFA0XMukZi8g8uiarr4Ssm+S7h1q5+dHBS8GwFfIeyO
 vytPmlVyiC8zKsfcYaqt9VW5xcfyMDSlXj9SL7Lt1IJv6qxXYgCW/8Mfiw0xazHpl1L9
 wgdLmi35NJnyc+6y2fQwPcj981n0If+JPXy3sHHJbl0ZpKxXw6SWq3sQcg2nIQYlDo9P
 XhloyhmOvByBe6Am/d9RLZx63a5e/U3ICh/bnJ4mBCKWhcyIFFgD8FyVIr6/4FZM2kPC sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb8n9e43s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:26 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PKTS35015340;
        Wed, 25 Jan 2023 21:26:26 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb8n9e42x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:26 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PId74l010363;
        Wed, 25 Jan 2023 21:26:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afc35x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQJTG20578786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C02FC20040;
        Wed, 25 Jan 2023 21:26:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0C72004B;
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
Subject: [PATCH v6 11/14] KVM: s390: Refactor absolute vcpu mem_op function
Date:   Wed, 25 Jan 2023 22:26:05 +0100
Message-Id: <20230125212608.1860251-12-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125212608.1860251-1-scgl@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l1OIaK23hMAPh2BfugkoLuPxlueWsFpT
X-Proofpoint-ORIG-GUID: vZCQLeOv3ssqLwPtRK-8XZcRHY55yA3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=822 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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


 arch/s390/kvm/kvm-s390.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index cfd09cb43ef6..4b8b41be7aed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5262,6 +5262,7 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 				 struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
+	enum gacc_mode acc_mode;
 	void *tmpbuf = NULL;
 	int r;
 
@@ -5278,38 +5279,33 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 	if (IS_ERR(tmpbuf))
 		return PTR_ERR(tmpbuf);
 
-	switch (mop->op) {
-	case KVM_S390_MEMOP_LOGICAL_READ:
-		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
-			r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
-					    GACC_FETCH, mop->key);
-			break;
-		}
+	acc_mode = mop->op == KVM_S390_MEMOP_LOGICAL_READ ? GACC_FETCH : GACC_STORE;
+	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
+		r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
+				    acc_mode, mop->key);
+	} else if (acc_mode == GACC_FETCH) {
 		r = read_guest_with_key(vcpu, mop->gaddr, mop->ar, tmpbuf,
 					mop->size, mop->key);
-		if (r == 0) {
-			if (copy_to_user(uaddr, tmpbuf, mop->size))
-				r = -EFAULT;
-		}
-		break;
-	case KVM_S390_MEMOP_LOGICAL_WRITE:
-		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
-			r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
-					    GACC_STORE, mop->key);
-			break;
+		if (r)
+			goto out_inject;
+		if (copy_to_user(uaddr, tmpbuf, mop->size)) {
+			r = -EFAULT;
+			goto out_free;
 		}
+	} else {
 		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
 			r = -EFAULT;
-			break;
+			goto out_free;
 		}
 		r = write_guest_with_key(vcpu, mop->gaddr, mop->ar, tmpbuf,
 					 mop->size, mop->key);
-		break;
 	}
 
+out_inject:
 	if (r > 0 && (mop->flags & KVM_S390_MEMOP_F_INJECT_EXCEPTION) != 0)
 		kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 
+out_free:
 	vfree(tmpbuf);
 	return r;
 }
-- 
2.34.1

