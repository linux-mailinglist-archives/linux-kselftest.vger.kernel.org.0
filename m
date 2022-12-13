Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138EB64BB52
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 18:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiLMRrU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 12:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiLMRrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 12:47:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEA621E36;
        Tue, 13 Dec 2022 09:47:18 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDHKWoH023109;
        Tue, 13 Dec 2022 17:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=iiCTz8qQkxR5QpavDy8ro1sdHP7oTSzVGuJJIj3InVQ=;
 b=FYrlAsVp+6eQ3VBHagRekuP/5sI9znkaGr22C6cXngfu8U3gsUQQik/9O44nvxpWXmpL
 0vq4h0pnoSmCDLORChK6hwnDp7WrkffYly2UWD+shofdTuq8bKRbhWmshSIEz7LWXY95
 28cHLyl35k2Va76RLPQ3RgYMnB/BkAbrj5yHZ6iAThP3ImEA+mzFDhKChASxCnsCXlao
 MS75yNPQ3+rHZXw4Cro6FqCiD//zwUFupdft+bHhFRYzXKrOiBNiomaEN1GmzviiYVwD
 6oOS8wd8NE+8QSRDwGJoFDGiYRRpKUH6Tb9eWpCTqdgKoblGX7rxT3xTKs10qSDv2+ej IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mewq6rn1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 17:47:13 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BDHKg7b023344;
        Tue, 13 Dec 2022 17:47:12 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mewq6rn0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 17:47:12 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDH4QTp007817;
        Tue, 13 Dec 2022 17:47:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mchcf4j1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 17:47:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDHl6Ds46596430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 17:47:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F2520040;
        Tue, 13 Dec 2022 17:47:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0706520049;
        Tue, 13 Dec 2022 17:47:06 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 17:47:05 +0000 (GMT)
Date:   Tue, 13 Dec 2022 18:32:25 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v4 2/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
Message-ID: <20221213183225.3f49ceb8@p-imbrenda>
In-Reply-To: <20221213165405.2953539-3-scgl@linux.ibm.com>
References: <20221213165405.2953539-1-scgl@linux.ibm.com>
        <20221213165405.2953539-3-scgl@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cHAf5-ZPumGPVVyEgG3Lc3qiPP8oj_94
X-Proofpoint-ORIG-GUID: ow_0cXBSTlZIltbwAVhI5CLUy75PCki0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=779 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 13 Dec 2022 17:53:58 +0100
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
> absolute vm write memops which allows user space to perform (storage key
> checked) cmpxchg operations on guest memory.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index eee9f857a986..98f5a35088b8 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3753,7 +3753,8 @@ The fields in each entry are defined as follows:
>  :Parameters: struct kvm_s390_mem_op (in)
>  :Returns: = 0 on success,
>            < 0 on generic error (e.g. -EFAULT or -ENOMEM),
> -          > 0 if an exception occurred while walking the page tables  
> +          16 bit program exception code if the access causes such an exception

s/$/,/

> +          other code > 0xffff with special meaning

s/$/./

with those two nits fixed:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

>  
>  Read or write data from/to the VM's memory.
>  The KVM_CAP_S390_MEM_OP_EXTENSION capability specifies what functionality is
> @@ -3771,6 +3772,8 @@ Parameters are specified via the following structure::
>  		struct {
>  			__u8 ar;	/* the access register number */
>  			__u8 key;	/* access key, ignored if flag unset */
> +			__u8 pad1[6];	/* ignored */
> +			__u64 old_addr;	/* ignored if flag unset */
>  		};
>  		__u32 sida_offset; /* offset into the sida */
>  		__u8 reserved[32]; /* ignored */
> @@ -3853,8 +3856,21 @@ Absolute accesses are permitted for non-protected guests only.
>  Supported flags:
>    * ``KVM_S390_MEMOP_F_CHECK_ONLY``
>    * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> +
> +The semantics of the flags common with logical accesses are as for logical
> +accesses.
> +
> +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if
> +KVM_CAP_S390_MEM_OP_EXTENSION has flag KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG set.
> +In this case, instead of doing an unconditional write, the access occurs
> +only if the target location contains the value pointed to by "old_addr".
> +This is performed as an atomic cmpxchg with the length specified by the "size"
> +parameter. "size" must be a power of two up to and including 16.
> +If the exchange did not take place because the target value doesn't match the
> +old value, KVM_S390_MEMOP_R_NO_XCHG is returned.
> +In this case the value "old_addr" points to is replaced by the target value.
>  
> -The semantics of the flags are as for logical accesses.
>  
>  SIDA read/write:
>  ^^^^^^^^^^^^^^^^

