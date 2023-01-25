Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD74967BE47
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbjAYV0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjAYV03 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EC646145;
        Wed, 25 Jan 2023 13:26:28 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKgeCf022416;
        Wed, 25 Jan 2023 21:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Nr/37ukIO8uowdapXR5ljDDvZaCScgVQP8W+gohOeVc=;
 b=c32Q40g/2efaW1Y5r11QrRWgPl2XlDxoK1Zs5Szz5aInnL5W3OgBedJZRQx+5OWZCtu1
 06T/F6C4VHvD3UFqW8urKPvyFZsLlntYlPMWQvTvJ6XupCBqHw/8RWBYgWhI+BoVEYyq
 lbm2PLn28wc1+pmxjnSF7yAYvzZbIl4ko8SUhs6r6wSNJGkM7v3wdwSGZgMxl5oXRR4T
 zUEKBDcB1rK9E6h0P58GB0EgPaJSqQxLYgfrjn0zETr2Nbh/oHAi0helnrfblYNHXccQ
 yHpS2hFWdzQWFDSF/jG1IqWj134pX1BhvBneuVE4ueDHRNqgTtvz5UhYLcjrr3WWG+EK jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naagv1wr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:26 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PLQPvl007643;
        Wed, 25 Jan 2023 21:26:25 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naagv1wq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:25 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFHcnj032068;
        Wed, 25 Jan 2023 21:26:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p64137-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQJe620644442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11CE120040;
        Wed, 25 Jan 2023 21:26:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D11B620043;
        Wed, 25 Jan 2023 21:26:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:26:18 +0000 (GMT)
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
Subject: [PATCH v6 08/14] KVM: s390: Move common code of mem_op functions into functions
Date:   Wed, 25 Jan 2023 22:26:02 +0100
Message-Id: <20230125212608.1860251-9-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125212608.1860251-1-scgl@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oc9_ZVLd3GK7XAF-W4eDgrl4PFOMIRa0
X-Proofpoint-GUID: b7nEv1LMXdPwO0E9SimVE5Btofm1T0rI
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

The vcpu and vm mem_op ioctl implementations share some functionality.
Move argument checking and buffer allocation into functions and call
them from both implementations.
This allows code reuse in case of additional future mem_op operations.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 80 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e4890e04b210..e0dfaa195949 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2764,24 +2764,44 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
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
+}
+
+static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
+{
+	void *buf;
+
+	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
+		return NULL;
+	buf = vmalloc(mop->size);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+	return buf;
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
@@ -2793,17 +2813,9 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 	 */
 	if (kvm_s390_pv_get_handle(kvm))
 		return -EINVAL;
-	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
-		if (access_key_invalid(mop->key))
-			return -EINVAL;
-	} else {
-		mop->key = 0;
-	}
-	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
-		tmpbuf = vmalloc(mop->size);
-		if (!tmpbuf)
-			return -ENOMEM;
-	}
+	tmpbuf = mem_op_alloc_buf(mop);
+	if (IS_ERR(tmpbuf))
+		return PTR_ERR(tmpbuf);
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 
@@ -5250,28 +5262,20 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
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
-	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
-		tmpbuf = vmalloc(mop->size);
-		if (!tmpbuf)
-			return -ENOMEM;
-	}
+	tmpbuf = mem_op_alloc_buf(mop);
+	if (IS_ERR(tmpbuf))
+		return PTR_ERR(tmpbuf);
 
 	switch (mop->op) {
 	case KVM_S390_MEMOP_LOGICAL_READ:
-- 
2.34.1

