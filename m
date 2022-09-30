Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88E5F1468
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 23:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiI3VIO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiI3VIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 17:08:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD461ABFD6;
        Fri, 30 Sep 2022 14:08:08 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UKMPK9020771;
        Fri, 30 Sep 2022 21:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dRZte+uDh/jovPwJ3e1L1HPEjDp71Tbgebz6NeiU0oE=;
 b=rirHl85u5uMx0t4rzrxV4lx1/EaQe2fQuahfkZfWMb8p2/VyH4M8FIJnuzpC6EecXtdH
 poCA9QE3gc0UpKWwQiAL9Wu8Ak9zOFTXUgzJXyHUk2L5W8npwdiMoFCq18raI4not34r
 NAKVYRzMdcudX9AlzHqrAb/6y85GmPJEkmNnBuACIpWkm3wukgd9zNyK/aeBhL4L2t4S
 TyYgjPHeMJmBKlp2z+eD/kZJ77Lzh/wKvhvpqjBwT8ruRO2XesSO0+jQCaiomXzIWhpx
 +GEgu0Fym7qnDHfUqSvmZgMM3qcfsp7juDIiUN3H3/cpO2rSGn2aBTA2GZHjFZ819CWs BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx7eeryym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:03 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UKsuqx000697;
        Fri, 30 Sep 2022 21:08:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx7eeryxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28UL5n5T010688;
        Fri, 30 Sep 2022 21:08:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapup8xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28UL7vAd4719208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 21:07:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6D0EA405B;
        Fri, 30 Sep 2022 21:07:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A789A4060;
        Fri, 30 Sep 2022 21:07:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 21:07:57 +0000 (GMT)
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
Subject: [PATCH v1 3/9] Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
Date:   Fri, 30 Sep 2022 23:07:45 +0200
Message-Id: <20220930210751.225873-4-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930210751.225873-1-scgl@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -rCJJ_jZvRef7p6LIX95ZGD-j1jcIw1p
X-Proofpoint-ORIG-GUID: 8k3vs8uNvLn3yyMb7r0LXDch06_4QJcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300131
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
 Documentation/virt/kvm/api.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index abd7c32126ce..0e02d66e38ae 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3771,6 +3771,7 @@ Parameters are specified via the following structure::
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u64 old[2];	/* ignored if flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -3853,8 +3854,23 @@ Absolute accesses are permitted for non-protected guests only.
 Supported flags:
   * ``KVM_S390_MEMOP_F_CHECK_ONLY``
   * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
+  * ``KVM_S390_MEMOP_F_CMPXCHG``
+
+The semantics of the flags common with logical acesses are as for logical accesses.
+
+For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
+In this case, instead of doing an unconditional write, the access occurs only
+if the target location contains the value provided in "old". This is performed
+as an atomic cmpxchg. "size" must be a power of two up to and including 16.
+Values with sizes <8 byte are to be provided by assignment to "old[1]".
+Doublewords are provided with the higher value word in "old[0]" and the lower
+word in "old[1]".
+The value at the target location is returned in "old", encoded in the same manner.
+If the value was exchanged the KVM_S390_MEMOP_F_CMPXCHG bit in "flags" is set to
+0, otherwise it remains set.
+The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
+has bit 1 (i.e. bit with value 2) set.
 
-The semantics of the flags are as for logical accesses.
 
 SIDA read/write:
 ^^^^^^^^^^^^^^^^
-- 
2.34.1

