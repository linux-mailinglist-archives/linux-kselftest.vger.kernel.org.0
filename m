Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06CF50DD80
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbiDYKFL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiDYKFH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 06:05:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757CE15A18;
        Mon, 25 Apr 2022 03:02:02 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P8gm8O023760;
        Mon, 25 Apr 2022 10:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bFRzVHs7APCv9jwTh4hUK/xVaklaCCu/0ehU/Io5HjE=;
 b=T9fZ5I/1nyH/7AMEXb9rRWSKbU7nD9mJCri/Yh7zjnqh+f7Iuv7bCkxvDvEvrX6P9RKQ
 5Q3x9/CsNqUK2psPWGN17e9V/W+wqlTUYS/7ZYbR647WBCXPeMYZTyya9Wo+J6VgXf0t
 k7or0tzZh9PtjfF7sPSWp8uUDT45eLCxhcmF2ITM9ktaTNcrndMXy9uxpGCFnbi7PctH
 pjXj1JAz77TnVpbXKdf14lf6jx2EU0GjCKqTnByAEdswFlr9ZlXqAdkyLr7+AAra6OaG
 XN2Mkex+eQKHs2j+17BLykDubv+6198CPcdqzYQV6780NF6NXbD884cTShPWyO+JuQOM tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuh5whnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:01:57 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23P9BiwH028859;
        Mon, 25 Apr 2022 10:01:57 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuh5whmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:01:57 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P9rsAo018482;
        Mon, 25 Apr 2022 10:01:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3fm938ssj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:01:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PA1qtI49873358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 10:01:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92A904203F;
        Mon, 25 Apr 2022 10:01:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CB7542042;
        Mon, 25 Apr 2022 10:01:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 10:01:52 +0000 (GMT)
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
Subject: [PATCH v2 1/2] KVM: s390: Don't indicate suppression on dirtying, failing memop
Date:   Mon, 25 Apr 2022 12:01:46 +0200
Message-Id: <20220425100147.1755340-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425100147.1755340-1-scgl@linux.ibm.com>
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EbsFefCDt1St9Uyrr2gYlSzdbu4H6nrw
X-Proofpoint-GUID: XP7INwJGLncrlgxR2tfLGY3R7eGyQTB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=798
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
protection can modified guest memory, as a result, the likely
correct ending is termination. Therefore do not indicate a
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

