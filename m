Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F117968C3BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjBFQq0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBFQqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D8B28D16;
        Mon,  6 Feb 2023 08:46:20 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316GiWr0011121;
        Mon, 6 Feb 2023 16:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RRnhPwXIY5/2buECw/ItU1dkcga38TUwkiSdZL+H9U8=;
 b=UszWp4+3lWCUTEfd7jGd3yRJ1CIphcLkjHPf9kYpPFZJE9+nuIHHF8QiumEvgpuQNZ8s
 7EdVOYGURFgZ+5+TmgEsSN05qW6MGbW7X+2KFUBKd9KQ8EIkvkZ1XRn7/VQMhnBVMN7I
 qJ7h33wckVl3EuGMRjIy4/uZnsKhYVMAGhdtwvGLqVGNxNwUK2vTyCdS3tm8gc8GBhx5
 Q3B4za2g1Q9AEgINwxPf7SSTfUy3OmUw5+Eg2StKFMnw+9dnhbvFsfGuVujzyEeoW/eh
 3D0xLempSAfh097+aDq6ymahZQqb93MdoDYqTlXGqFZNi97F3eVjB0x/Um1go+pkqnZa +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51mgp9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:16 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316GinYn012203;
        Mon, 6 Feb 2023 16:46:15 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51mgp81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:15 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 315NZgGx023824;
        Mon, 6 Feb 2023 16:46:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06tmsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316Gk9OR42992042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D8C620040;
        Mon,  6 Feb 2023 16:46:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E2B92004B;
        Mon,  6 Feb 2023 16:46:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:09 +0000 (GMT)
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
Subject: [PATCH v7 10/14] KVM: s390: Refactor absolute vm mem_op function
Date:   Mon,  6 Feb 2023 17:45:58 +0100
Message-Id: <20230206164602.138068-11-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fKgO01PJ7SQyAf6yd0WpMeEOGQrshbpV
X-Proofpoint-ORIG-GUID: O79jXpr-GRaavHwbJZR6T2ZpGRPclzm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=977 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060144
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---


Cosmetic only, can be dropped


 arch/s390/kvm/kvm-s390.c | 43 +++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 707967a296f1..1f94b18f1cb5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2782,6 +2782,7 @@ static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_fla
 static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
+	enum gacc_mode acc_mode;
 	void *tmpbuf = NULL;
 	int r, srcu_idx;
 
@@ -2803,33 +2804,25 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
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
+	acc_mode = mop->op == KVM_S390_MEMOP_ABSOLUTE_READ ? GACC_FETCH : GACC_STORE;
+	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
+		r = check_gpa_range(kvm, mop->gaddr, mop->size, acc_mode, mop->key);
+		goto out_unlock;
 	}
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
+	if (acc_mode == GACC_FETCH) {
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
2.37.2

