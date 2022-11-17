Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9862E81F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 23:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiKQWTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 17:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbiKQWTC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:02 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8847AF75;
        Thu, 17 Nov 2022 14:18:18 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHLni4T010705;
        Thu, 17 Nov 2022 22:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZrMJowbbNtwGW73yIvLXJOK0sEz0Dl/MN6Txe0HjHlk=;
 b=CvDKIhl3RzunyTgiCGu4/az+/CzzysMM0NYhzQ9Cbi2JFSU4d50aV59NxN2FGInQXXZ2
 DE19QFvT1KPKDp7lkUEk5K+Y1GLLpp1AlL8OU/VrM4a0QOK5ZB4gaWfNmGMDvunR9XTg
 l6LrFu0/q2ypMNVuumrZsNwh4oD/O/D3O3GAdd1dfzc6LalCci0xHz9xJ6q/77UaVlVV
 pUfTinSD7P8XGtoosSxwzT1OY7KtJG6+cJ54aoYsu4mbY+Z7AGBXyiJ7Bd3k7vJ/BAoN
 12XYzMEtCIx5HU47khyZ9pp+ABvlI1DNYEgbAPEjxJzfeqRO6C8BZlmRZWTpf6hkB02A Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kww7d8nqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:12 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHLoPOT012129;
        Thu, 17 Nov 2022 22:18:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kww7d8npw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHM6KE8021491;
        Thu, 17 Nov 2022 22:18:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3kwsker58g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHMC44d33030422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 22:12:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7356DA404D;
        Thu, 17 Nov 2022 22:18:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFD78A4051;
        Thu, 17 Nov 2022 22:18:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 22:18:06 +0000 (GMT)
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
Subject: [PATCH v3 2/9] Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
Date:   Thu, 17 Nov 2022 23:17:51 +0100
Message-Id: <20221117221758.66326-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117221758.66326-1-scgl@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fXsEDSchgsploaI_hF2qTwbMPAdWAa52
X-Proofpoint-GUID: KaxvMQ0XXP2u6QKFI1fX5jsq-TfmH5tN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=723 phishscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170157
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
 Documentation/virt/kvm/api.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index eee9f857a986..204d128f23e0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3753,7 +3753,8 @@ The fields in each entry are defined as follows:
 :Parameters: struct kvm_s390_mem_op (in)
 :Returns: = 0 on success,
           < 0 on generic error (e.g. -EFAULT or -ENOMEM),
-          > 0 if an exception occurred while walking the page tables
+          16 bit program exception code if the access causes such an exception
+          other code > maximum 16 bit value with special meaning
 
 Read or write data from/to the VM's memory.
 The KVM_CAP_S390_MEM_OP_EXTENSION capability specifies what functionality is
@@ -3771,6 +3772,8 @@ Parameters are specified via the following structure::
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u8 pad1[6];	/* ignored */
+			__u64 old_p;	/* ignored if flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -3853,8 +3856,22 @@ Absolute accesses are permitted for non-protected guests only.
 Supported flags:
   * ``KVM_S390_MEMOP_F_CHECK_ONLY``
   * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
+  * ``KVM_S390_MEMOP_F_CMPXCHG``
+
+The semantics of the flags common with logical acesses are as for logical
+accesses.
+
+For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
+In this case, instead of doing an unconditional write, the access occurs only
+if the target location contains the "size" byte long value pointed to by
+"old_p". This is performed as an atomic cmpxchg. "size" must be a power of two
+up to and including 16.
+The value at the target location is written to the location "old_p" points to.
+If the exchange did not take place because the target value doesn't match the
+old value KVM_S390_MEMOP_R_NO_XCHG is returned.
+The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
+has bit 1 (i.e. bit with value 2) set.
 
-The semantics of the flags are as for logical accesses.
 
 SIDA read/write:
 ^^^^^^^^^^^^^^^^
-- 
2.34.1

