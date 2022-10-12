Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3BC5FCC77
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJLU41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJLU4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 16:56:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014B5FDD5;
        Wed, 12 Oct 2022 13:56:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKiOGm025705;
        Wed, 12 Oct 2022 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JtDZIzJs+xc49I4Ma5TSfC98qmng9kM3z76Erhc9z1k=;
 b=VnnrrryYp/ogLC+po9UrWayZkMG51zoAaUpH5rYY/dg8ZEaPUvi2UA2UA1d+SXuT4o2s
 3T7leUKuYZ2oke9yfoPZFHJwRuEQ2+c+gAviwjx+MLE1wfLpnp0Vmr2mZ/aTgru0B92T
 uXYOdUh2iA8nRu9+CDChv5tUcvt5/WcM8z5fUTDI8u4pW72OZuYxgjuTaJ99tb1JtG1v
 G4tnwrOFxyyqf0WwHpJhtj3vJQLrT/Ug2BDdvRLMtlpxwH495Ug3vw2MbBLAUmIVlVNQ
 v3jMCPnxa15OEtvTlmAHtBBTGehV57tWdPWIFs5dcoT0h7L5paZHleu190EHFoM3il3X eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62v1kj95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:18 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CKjFMe028334;
        Wed, 12 Oct 2022 20:56:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62v1kj8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CKqgP7002835;
        Wed, 12 Oct 2022 20:56:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3k30u9ejf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29CKuD2038469930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:56:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 348C75204F;
        Wed, 12 Oct 2022 20:56:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B751D52050;
        Wed, 12 Oct 2022 20:56:12 +0000 (GMT)
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
Subject: [PATCH v2 3/9] Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
Date:   Wed, 12 Oct 2022 22:56:03 +0200
Message-Id: <20221012205609.2811294-4-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012205609.2811294-1-scgl@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aSvPs4rdb94c3J65VVowectlYKjI5Lz7
X-Proofpoint-GUID: WMzB2R81i1pZlSCrXHca0BLmoMi-dcoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_10,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxlogscore=773 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120131
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
index abd7c32126ce..f972f5d95e6c 100644
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

