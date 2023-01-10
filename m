Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF9664D50
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjAJU1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjAJU0t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:26:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E550E72;
        Tue, 10 Jan 2023 12:26:46 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJw0PD008615;
        Tue, 10 Jan 2023 20:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8liyfggqVRfKBzRLk22EzT2PLjSMXTAQJY6H3C1Gw0U=;
 b=r4xSrecCGJnH65B1VnW9UAILz1Xn297F2lQ3NDJeeXRBW3hpCoDep1xrIqsN4BVogMEf
 UL5KQo8toHAQI1ArrKhxVIizLcTdKzaq219hJ88dd5BAYLGu2he9amV+Fnn8cu+XN5k+
 exOLLTeZO3CKBCjpitOUclXvzXqAyt69OuIXNH0TSkuyzUIs/qOf5n6HNRHFfUxKRP+l
 Xsh+eXyIpmARWR4xffOw+aqvDgSB4qYNOpZSXp38XbCShJZpcMxtkvbHfsv7/t4i8yS4
 lxTRXD5VzcRHYFACJKVOjgUSrr6hxWr+RwW53x+XewPAOEZAPDVEqsEF7MXP/OWgRzCL og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1en0gme0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:43 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AJwHXt009701;
        Tue, 10 Jan 2023 20:26:43 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1en0gmdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:42 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30ADAnwL032122;
        Tue, 10 Jan 2023 20:26:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3my00fkwhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AKQaVF43057534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 20:26:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6FE720040;
        Tue, 10 Jan 2023 20:26:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B1B420043;
        Tue, 10 Jan 2023 20:26:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 20:26:36 +0000 (GMT)
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
Subject: [PATCH v5 02/10] Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
Date:   Tue, 10 Jan 2023 21:26:24 +0100
Message-Id: <20230110202632.2533978-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110202632.2533978-1-scgl@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L1pbXIfoYpoxZX22CZVv5hYB4vhNLsQy
X-Proofpoint-GUID: HGmABwWXbw0iEBm20cGtPkBzZkr78Nuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=822 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100133
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
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index deb494f759ed..be4bdcd2d489 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3728,7 +3728,8 @@ The fields in each entry are defined as follows:
 :Parameters: struct kvm_s390_mem_op (in)
 :Returns: = 0 on success,
           < 0 on generic error (e.g. -EFAULT or -ENOMEM),
-          > 0 if an exception occurred while walking the page tables
+          16 bit program exception code if the access causes such an exception,
+          other code > 0xffff with special meaning.
 
 Read or write data from/to the VM's memory.
 The KVM_CAP_S390_MEM_OP_EXTENSION capability specifies what functionality is
@@ -3746,6 +3747,8 @@ Parameters are specified via the following structure::
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u8 pad1[6];	/* ignored */
+			__u64 old_addr;	/* ignored if flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -3828,8 +3831,21 @@ Absolute accesses are permitted for non-protected guests only.
 Supported flags:
   * ``KVM_S390_MEMOP_F_CHECK_ONLY``
   * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
+  * ``KVM_S390_MEMOP_F_CMPXCHG``
+
+The semantics of the flags common with logical accesses are as for logical
+accesses.
+
+For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if
+KVM_CAP_S390_MEM_OP_EXTENSION has flag KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG set.
+In this case, instead of doing an unconditional write, the access occurs
+only if the target location contains the value pointed to by "old_addr".
+This is performed as an atomic cmpxchg with the length specified by the "size"
+parameter. "size" must be a power of two up to and including 16.
+If the exchange did not take place because the target value doesn't match the
+old value, KVM_S390_MEMOP_R_NO_XCHG is returned.
+In this case the value "old_addr" points to is replaced by the target value.
 
-The semantics of the flags are as for logical accesses.
 
 SIDA read/write:
 ^^^^^^^^^^^^^^^^
-- 
2.34.1

