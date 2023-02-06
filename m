Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA46A68C3A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 17:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjBFQqd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 11:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjBFQqY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 11:46:24 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F428D2B;
        Mon,  6 Feb 2023 08:46:22 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316GjfZV029653;
        Mon, 6 Feb 2023 16:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Bz33V/9/MmwvLXUiAh3YTpkiLk6qxFE9ecgH4QTQ7qw=;
 b=BiUQ6kX1y6dtXbvp1kWFzCr7TfD0Oml2iklod/2RsffZNjBI0+nICOnZDRAtoEO5rE7i
 7DRiQNxdfd0B2aba+Thw/2/tTa+Jkk9ZQf9cgbfzL2BrvYvfjNwm59YhSzL8RcYcTxSg
 EZ+M7XMnvRRynVMCxndzDAh+htcv/DkiIk+PFBfBZbPnw34/sidB84uZ8aMSw+cgQqLu
 FKQZnoi8cLKkZUl1oetr9h7o4AHy+7pq8CeN5nDNU/lKeuBejDy3wdVYjXqRnbRHcX/S
 ZYD4xOEOqi7wNjEbQ7l/uiOUVrVToeGkg4IU0Lefc0OkLnkb/TA1td9q9Tjwz5bJyLje SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51jgkmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:17 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316GkG2o031778;
        Mon, 6 Feb 2023 16:46:17 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk51jgkkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 315IPR2l003647;
        Mon, 6 Feb 2023 16:46:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3nhf06sv3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:46:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316GkBsr51577188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 16:46:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D21B20043;
        Mon,  6 Feb 2023 16:46:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9738F2004F;
        Mon,  6 Feb 2023 16:46:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 16:46:10 +0000 (GMT)
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
Subject: [PATCH v7 13/14] Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
Date:   Mon,  6 Feb 2023 17:46:01 +0100
Message-Id: <20230206164602.138068-14-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206164602.138068-1-scgl@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 42RoMsJn4mnwGoDUIkTE0TzIbhfP90cL
X-Proofpoint-ORIG-GUID: ZXysK4Z_W0wUXqwtqM4DngeODcjLv5y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=950 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
absolute vm write memops which allows user space to perform (storage key
checked) cmpxchg operations on guest memory.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 0a67cb738013..d09d7223c2a6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3736,7 +3736,8 @@ The fields in each entry are defined as follows:
 :Parameters: struct kvm_s390_mem_op (in)
 :Returns: = 0 on success,
           < 0 on generic error (e.g. -EFAULT or -ENOMEM),
-          > 0 if an exception occurred while walking the page tables
+          16 bit program exception code if the access causes such an exception,
+          other code > 0xffff with special meaning.
 
 Read or write data from/to the VM's memory.
 The KVM_CAP_S390_MEM_OP_EXTENSION capability specifies what functionality is
@@ -3754,6 +3755,8 @@ Parameters are specified via the following structure::
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u8 pad1[6];	/* ignored */
+			__u64 old_addr;	/* ignored if flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -3781,6 +3784,7 @@ Possible operations are:
   * ``KVM_S390_MEMOP_ABSOLUTE_WRITE``
   * ``KVM_S390_MEMOP_SIDA_READ``
   * ``KVM_S390_MEMOP_SIDA_WRITE``
+  * ``KVM_S390_MEMOP_ABSOLUTE_CMPXCHG``
 
 Logical read/write:
 ^^^^^^^^^^^^^^^^^^^
@@ -3829,7 +3833,7 @@ the checks required for storage key protection as one operation (as opposed to
 user space getting the storage keys, performing the checks, and accessing
 memory thereafter, which could lead to a delay between check and access).
 Absolute accesses are permitted for the VM ioctl if KVM_CAP_S390_MEM_OP_EXTENSION
-is > 0.
+has the KVM_S390_MEMOP_EXTENSION_CAP_BASE bit set.
 Currently absolute accesses are not permitted for VCPU ioctls.
 Absolute accesses are permitted for non-protected guests only.
 
@@ -3837,7 +3841,26 @@ Supported flags:
   * ``KVM_S390_MEMOP_F_CHECK_ONLY``
   * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
 
-The semantics of the flags are as for logical accesses.
+The semantics of the flags common with logical accesses are as for logical
+accesses.
+
+Absolute cmpxchg:
+^^^^^^^^^^^^^^^^^
+
+Perform cmpxchg on absolute guest memory. Intended for use with the
+KVM_S390_MEMOP_F_SKEY_PROTECTION flag.
+Instead of doing an unconditional write, the access occurs only if the target
+location contains the value pointed to by "old_addr".
+This is performed as an atomic cmpxchg with the length specified by the "size"
+parameter. "size" must be a power of two up to and including 16.
+If the exchange did not take place because the target value doesn't match the
+old value, the value "old_addr" points to is replaced by the target value.
+User space can tell if an exchange took place by checking if this replacement
+occurred. The cmpxchg op is permitted for the VM ioctl if
+KVM_CAP_S390_MEM_OP_EXTENSION has flag KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG set.
+
+Supported flags:
+  * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
 
 SIDA read/write:
 ^^^^^^^^^^^^^^^^
-- 
2.37.2

