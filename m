Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06C14EF88E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbiDAREu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 13:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347276AbiDAREt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 13:04:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612D715E8AD;
        Fri,  1 Apr 2022 10:02:59 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231GPA6V012218;
        Fri, 1 Apr 2022 17:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IC8zLlmSWU/XaldafvLjNoMK5/OB4AY21mCCATd5Soo=;
 b=HL9hUKgcsic2VAfqWG6a8Rc1o+YNZzxRaJJ3FGL1ZNhemHoMhT3QIRDrNvIPqST3tyar
 rgpsOnvf4nKKeI0KMidCvaCnd1wX+qJ+uwx2/R9px5X3sgNRnWZIjW23D6UwrrpLOcKv
 R7NnV8JAOqdWYgcA15pQlpB322+kML8tnZUS7jd0QZTZbgUXgbbpnSItMINFRAV2DsX3
 15Hw9nsKSwopm5pmRtXcwlHjSzKUeXypzCLLoVYHjT44XfwsWUyAE7dfiKFjzSwVdzJ2
 KZOyXHevmTTQg2EB5vw2YYRoB5bQM3KI3aNaVK2T1GsebhOwY3bVvnpTVRK7sKIMMysJ TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f64w8rqyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:56 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 231GuilZ023764;
        Fri, 1 Apr 2022 17:02:56 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f64w8rqy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:55 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 231GvTmf001927;
        Fri, 1 Apr 2022 17:02:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3f1tf93dbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 231H2oZu53018954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 17:02:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FA714204F;
        Fri,  1 Apr 2022 17:02:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AA9142047;
        Fri,  1 Apr 2022 17:02:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Apr 2022 17:02:50 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/2] KVM: s390: Don't indicate suppression on dirtying, failing memop
Date:   Fri,  1 Apr 2022 19:02:46 +0200
Message-Id: <20220401170247.1287354-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401170247.1287354-1-scgl@linux.ibm.com>
References: <20220401170247.1287354-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UFgd0RebYSKH5jBf9C58SA7MgtUS2t8V
X-Proofpoint-ORIG-GUID: N_LtEmhuiBR_5-fDU8lCtSnkpK-gNYjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 mlxlogscore=791 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If user space uses a memop to emulate an instruction and that
memop fails, the execution of the instruction ends.
Instruction execution can end in different ways, one of which is
suppression, which requires that the instruction execute like a no-op.
A writing memop that spans multiple pages and fails due to key
protection can modified guest memory. Therefore do not indicate a
suppressing instruction ending in this case.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 47 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index d53a183c2005..3b1fbef82288 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -491,8 +491,8 @@ enum prot_type {
 	PROT_TYPE_IEP  = 4,
 };
 
-static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
-		     u8 ar, enum gacc_mode mode, enum prot_type prot)
+static int trans_exc_ending(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
+			    enum gacc_mode mode, enum prot_type prot, bool suppress)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	struct trans_exc_code_bits *tec;
@@ -503,22 +503,24 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 
 	switch (code) {
 	case PGM_PROTECTION:
-		switch (prot) {
-		case PROT_TYPE_IEP:
-			tec->b61 = 1;
-			fallthrough;
-		case PROT_TYPE_LA:
-			tec->b56 = 1;
-			break;
-		case PROT_TYPE_KEYC:
-			tec->b60 = 1;
-			break;
-		case PROT_TYPE_ALC:
-			tec->b60 = 1;
-			fallthrough;
-		case PROT_TYPE_DAT:
-			tec->b61 = 1;
-			break;
+		if (suppress) {
+			switch (prot) {
+			case PROT_TYPE_IEP:
+				tec->b61 = 1;
+				fallthrough;
+			case PROT_TYPE_LA:
+				tec->b56 = 1;
+				break;
+			case PROT_TYPE_KEYC:
+				tec->b60 = 1;
+				break;
+			case PROT_TYPE_ALC:
+				tec->b60 = 1;
+				fallthrough;
+			case PROT_TYPE_DAT:
+				tec->b61 = 1;
+				break;
+			}
 		}
 		fallthrough;
 	case PGM_ASCE_TYPE:
@@ -552,6 +554,12 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 	return code;
 }
 
+static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
+		     enum gacc_mode mode, enum prot_type prot)
+{
+	return trans_exc_ending(vcpu, code, gva, ar, mode, prot, true);
+}
+
 static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 			 unsigned long ga, u8 ar, enum gacc_mode mode)
 {
@@ -1110,7 +1118,8 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
 	}
 	if (rc > 0)
-		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);
+		rc = trans_exc_ending(vcpu, rc, ga, ar, mode, prot,
+				      (mode != GACC_STORE) || (idx == 0));
 out_unlock:
 	if (need_ipte_lock)
 		ipte_unlock(vcpu);
-- 
2.32.0

