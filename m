Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0001267BE59
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjAYV0i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbjAYV0a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:26:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663D045BC1;
        Wed, 25 Jan 2023 13:26:29 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PL6ghL032428;
        Wed, 25 Jan 2023 21:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FjMvCLPyceqSMp6lC6biYf0zMESPVsGImVbbAsW6Ufg=;
 b=r9833Z+Ftm2Y3dgPw6vI+JBWOHnGtnyhHlU3F4lPZRScZJUGeQ1dhqLlDER+eNPj1Uro
 drIm0/E3jBy2Ltg9BqzA6C4ipcp8gjK2OTngGcr9ed38PS8OrLBygvD6ropsyD3Sj+if
 YJRcO4Ptet8x4B/qHQD1B2zDlBOhxd/etQcv9LrK4DUpxXIp0iSsqR8EO1R/g8SUZNSf
 mFY0dC4B6JCOgTMnYS4EYMwUZrxtxikHPXgGHLbmvz4w/2wERTkLlmoBfxQevxwWYK3y
 PdPIp11wbowpFao1uSuC6Tmy+mJLP/UUVtoEEKKoU8wgU+U62eAGgfocvLwQLh9EGpv4 eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na839fy6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:27 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PL5vFv028292;
        Wed, 25 Jan 2023 21:26:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na839fy5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFw9bP026749;
        Wed, 25 Jan 2023 21:26:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6dmar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:26:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLQKP452691388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:26:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4813920040;
        Wed, 25 Jan 2023 21:26:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13AAE20049;
        Wed, 25 Jan 2023 21:26:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:26:20 +0000 (GMT)
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
Subject: [PATCH v6 13/14] Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
Date:   Wed, 25 Jan 2023 22:26:07 +0100
Message-Id: <20230125212608.1860251-14-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125212608.1860251-1-scgl@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z-VXTUEEE90Ys__SHwINd5Z-A43iPkmA
X-Proofpoint-ORIG-GUID: pN_7tqf2MtpBxKsUVOxYsli5W1aihsAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 9807b05a1b57..ce8a50d79232 100644
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
2.34.1

