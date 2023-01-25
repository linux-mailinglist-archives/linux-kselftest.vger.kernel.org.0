Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3467BE4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjAYV0g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbjAYV0a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:30 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2F46D59;
        Wed, 25 Jan 2023 13:26:29 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLdME036617;
        Wed, 25 Jan 2023 21:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A9SxtA0w+pan6AslJaypyNNAxeIoa+GZ64mWe6sm0dU=;
 b=qOVRvcVOKoBlgSuExw9+R7snZ1QKE5Gz8buENMgb3ZiMDd5MxSUxgVe0bSFh4xWl0TNy
 Su8ABEy8eU8S6IOWvvcA6PFZAdFgK3RRa65wCxEyd/DFkpPIZGIiOxCprwDQfYQhEOwE
 NiROoHByNHtrs7bQi0ehV0Hnv80NfeMwm3u/0krmSSeUALcjnitMrbSdGOhpnqR4bCvZ
 efDzRKa6cin3zTp+sKysMJ3V5M2u5aSPUBALB7VIMM313EVnGB7xDvqkKN72zN4fyC+5
 blsRzgw0QXSyMpk7rr82H111LE20UYfXdNc/E3r3MCX3ikTT5i8dyOl2JzF5fIWZCui2 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb2smrkfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:25 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PL6Npo039741;
        Wed, 25 Jan 2023 21:26:24 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb2smrkev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:24 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEs8AK015310;
        Wed, 25 Jan 2023 21:26:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6c0ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQJDw20644444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B80620040;
        Wed, 25 Jan 2023 21:26:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16DE020049;
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
Subject: [PATCH v6 09/14] KVM: s390: Dispatch to implementing function at top level of vm mem_op
Date:   Wed, 25 Jan 2023 22:26:03 +0100
Message-Id: <20230125212608.1860251-10-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125212608.1860251-1-scgl@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EmVID559LJPfRpjHNbAe_lZFGBZjX-VA
X-Proofpoint-ORIG-GUID: 2Axcq54oZt45gzfjKh62DNed6i6e9AK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of having one function covering all mem_op operations,
have a function implementing absolute access and dispatch to that
function in its caller, based on the operation code.
This way additional future operations can be implemented by adding an
implementing function without changing existing operations.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e0dfaa195949..588cf70dc81e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2791,7 +2791,7 @@ static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
 	return buf;
 }
 
-static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
+static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
 	void *tmpbuf = NULL;
@@ -2802,17 +2802,6 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	if (r)
 		return r;
 
-	/*
-	 * This is technically a heuristic only, if the kvm->lock is not
-	 * taken, it is not guaranteed that the vm is/remains non-protected.
-	 * This is ok from a kernel perspective, wrongdoing is detected
-	 * on the access, -EFAULT is returned and the vm may crash the
-	 * next time it accesses the memory in question.
-	 * There is no sane usecase to do switching and a memop on two
-	 * different CPUs at the same time.
-	 */
-	if (kvm_s390_pv_get_handle(kvm))
-		return -EINVAL;
 	tmpbuf = mem_op_alloc_buf(mop);
 	if (IS_ERR(tmpbuf))
 		return PTR_ERR(tmpbuf);
@@ -2851,8 +2840,6 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 		}
 		break;
 	}
-	default:
-		r = -EINVAL;
 	}
 
 out_unlock:
@@ -2862,6 +2849,29 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	return r;
 }
 
+static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
+{
+	/*
+	 * This is technically a heuristic only, if the kvm->lock is not
+	 * taken, it is not guaranteed that the vm is/remains non-protected.
+	 * This is ok from a kernel perspective, wrongdoing is detected
+	 * on the access, -EFAULT is returned and the vm may crash the
+	 * next time it accesses the memory in question.
+	 * There is no sane usecase to do switching and a memop on two
+	 * different CPUs at the same time.
+	 */
+	if (kvm_s390_pv_get_handle(kvm))
+		return -EINVAL;
+
+	switch (mop->op) {
+	case KVM_S390_MEMOP_ABSOLUTE_READ:
+	case KVM_S390_MEMOP_ABSOLUTE_WRITE:
+		return kvm_s390_vm_mem_op_abs(kvm, mop);
+	default:
+		return -EINVAL;
+	}
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
-- 
2.34.1

