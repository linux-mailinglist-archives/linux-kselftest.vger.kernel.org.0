Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7449A68C394
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjBFQqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBFQqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7BA2884C;
        Mon,  6 Feb 2023 08:46:17 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316GiaUb032597;
        Mon, 6 Feb 2023 16:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MfimxpAk7yrTbQD4iiKgsDkpDIiumYmt7tkHoxXNkls=;
 b=gcATaS1jOEhHIFJ4FoNhmAOnhppxgZaCUTvZ3lx+TsiEI0Np/Fa7lpKzl7s209ZQ9NoO
 dFn8/bnetdlksCISy2k/bNNGDR9pPjWywlQrJTfqfJbOBJ+yAsFRvhsT8/lilDBuuAem
 x/whK9tPiUlFWCVKnsHrQi1+owvEUzJ/N/5LdrtwnqVvGSEvBXe6KJBZnkLlPgstgoyo
 8BNBuJ7pAr2klthhhkOC8a/Cbx9z0w3NcbKVegS6ju0Ws9hoDMVSyJ2Fw2YvSHuTwTcN
 mcuHTSCkZHjeu8PolbRnFPmjIxSzeaoxW7EfC0P3a1esAtlifTsndGbRA/pN5Zfe7Q4r pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk56q8ax8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:15 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316GikLB033523;
        Mon, 6 Feb 2023 16:46:14 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk56q8aw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3161E5jw002393;
        Mon, 6 Feb 2023 16:46:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06jm62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316Gk8iN24314194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88F0420040;
        Mon,  6 Feb 2023 16:46:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DCA42004E;
        Mon,  6 Feb 2023 16:46:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:08 +0000 (GMT)
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
Subject: [PATCH v7 08/14] KVM: s390: Move common code of mem_op functions into function
Date:   Mon,  6 Feb 2023 17:45:56 +0100
Message-Id: <20230206164602.138068-9-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HkjXGiUGOixMlcH_D04TqzFiJeZgjRLQ
X-Proofpoint-GUID: I_dgNZVwdKhIPh0BgNSENdMLgeDkwCvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The vcpu and vm mem_op ioctl implementations share some functionality.
Move argument checking into a function and call it from both
implementations. This allows code reuse in case of additional future
mem_op operations.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 52 +++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e4890e04b210..0367c1a7e69a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2764,24 +2764,32 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 	return r;
 }
 
-static bool access_key_invalid(u8 access_key)
+static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_flags)
 {
-	return access_key > 0xf;
+	if (mop->flags & ~supported_flags || !mop->size)
+		return -EINVAL;
+	if (mop->size > MEM_OP_MAX_SIZE)
+		return -E2BIG;
+	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
+		if (mop->key > 0xf)
+			return -EINVAL;
+	} else {
+		mop->key = 0;
+	}
+	return 0;
 }
 
 static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
-	u64 supported_flags;
 	void *tmpbuf = NULL;
 	int r, srcu_idx;
 
-	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
-			  | KVM_S390_MEMOP_F_CHECK_ONLY;
-	if (mop->flags & ~supported_flags || !mop->size)
-		return -EINVAL;
-	if (mop->size > MEM_OP_MAX_SIZE)
-		return -E2BIG;
+	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_SKEY_PROTECTION |
+					KVM_S390_MEMOP_F_CHECK_ONLY);
+	if (r)
+		return r;
+
 	/*
 	 * This is technically a heuristic only, if the kvm->lock is not
 	 * taken, it is not guaranteed that the vm is/remains non-protected.
@@ -2793,12 +2801,6 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	 */
 	if (kvm_s390_pv_get_handle(kvm))
 		return -EINVAL;
-	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
-		if (access_key_invalid(mop->key))
-			return -EINVAL;
-	} else {
-		mop->key = 0;
-	}
 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
 		tmpbuf = vmalloc(mop->size);
 		if (!tmpbuf)
@@ -5250,23 +5252,17 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 {
 	void __user *uaddr = (void __user *)mop->buf;
 	void *tmpbuf = NULL;
-	int r = 0;
-	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
-				    | KVM_S390_MEMOP_F_CHECK_ONLY
-				    | KVM_S390_MEMOP_F_SKEY_PROTECTION;
+	int r;
 
-	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS || !mop->size)
+	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_INJECT_EXCEPTION |
+					KVM_S390_MEMOP_F_CHECK_ONLY |
+					KVM_S390_MEMOP_F_SKEY_PROTECTION);
+	if (r)
+		return r;
+	if (mop->ar >= NUM_ACRS)
 		return -EINVAL;
-	if (mop->size > MEM_OP_MAX_SIZE)
-		return -E2BIG;
 	if (kvm_s390_pv_cpu_is_protected(vcpu))
 		return -EINVAL;
-	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
-		if (access_key_invalid(mop->key))
-			return -EINVAL;
-	} else {
-		mop->key = 0;
-	}
 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
 		tmpbuf = vmalloc(mop->size);
 		if (!tmpbuf)
-- 
2.37.2

