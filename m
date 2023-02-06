Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EEC68C3A1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBFQq0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjBFQqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2C1D93F;
        Mon,  6 Feb 2023 08:46:19 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316GjKLp027788;
        Mon, 6 Feb 2023 16:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ceGEHTyO1+iOh7mznEgt9i8DfEpEWeap35zW89VTIpw=;
 b=drilre+qfI51irvI4QSD9UkoWDT+Gq1lydBXE8A+CXmFb30Mdw/29AtRqoHOQ+MlKR64
 EuNJGrGUgJ7WN8oBAdez4AQU3lppVT1W1YCGHXWNW/JAgLH/7I9BF06UnFeXMHHedRfO
 r4NSM3HXvnvPB/mOlXTv5LM3DtEKoN9RkUcZyjGbwZfraEMab9Yo8ohNQ7/HD62+okZD
 8mqOvcAGED94Q1HLHJ37HHGcZisCNdCZyVWLA67Bmst/4zQinOYoroVUJ5e4syfJu5FW
 o6XyWibC0Kg0CHazVKDfid3zdNhpIuM4s0bMiaKtkRL+qeoOxWWyW1AFdPP4Rm3i2B0B WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk3rmbf51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:16 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316GjSrY028323;
        Mon, 6 Feb 2023 16:46:15 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk3rmbf3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316GRFA0002355;
        Mon, 6 Feb 2023 16:46:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06jm64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316GkAX626280472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1015820043;
        Mon,  6 Feb 2023 16:46:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 991652004D;
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
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v7 11/14] KVM: s390: Refactor vcpu mem_op function
Date:   Mon,  6 Feb 2023 17:45:59 +0100
Message-Id: <20230206164602.138068-12-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4mM6DFqhhqv1i-cAkb2IrRoz5ItfedFC
X-Proofpoint-ORIG-GUID: rpgNK2Q9__yqD3X8lIvcAPymfTmLar6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=815
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060144
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


Cosmetic only, can be dropped


 arch/s390/kvm/kvm-s390.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1f94b18f1cb5..8a74b7b62ecf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5254,6 +5254,7 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 				 struct kvm_s390_mem_op *mop)
 {
 	void __user *uaddr = (void __user *)mop->buf;
+	enum gacc_mode acc_mode;
 	void *tmpbuf = NULL;
 	int r;
 
@@ -5272,38 +5273,35 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
 			return -ENOMEM;
 	}
 
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
+		goto out_inject;
+	}
+	if (acc_mode == GACC_FETCH) {
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
2.37.2

