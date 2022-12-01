Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39C463F571
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiLAQjQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 11:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiLAQjP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 11:39:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C828E58E;
        Thu,  1 Dec 2022 08:39:14 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1GS8pJ029673;
        Thu, 1 Dec 2022 16:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=OKrS9BBvwYfLHBzFMs6pnh1OkU96bxDQqMK4isLLZ1w=;
 b=b3uZi70YpLpZ/WI6/LDsi73mH4/syWHK3Owhk1EpYP9+WAtQVo33wx7Rk9cOPFjprA+N
 2wVUEgKsP1apo7c+Y44AePlJ8an5flVGDcKfBK0joQumJ7qGDYI0WB3vqk8k5psEx0WQ
 Ci9VBbCMWnpJoTNdvzACVRg8CUeTU1r5EuMI30UAoUlBe7qkgqwNDkZ5ai4HZUte/8Nc
 NuEplToIJ7gbNz8WsGMOGosDOvf70Fwi1IsGecArsCjLgekdqTHAj2ikNvWyQRlgqfIq
 pErjEaqk3czyDRJI3KbRToHG5A/NNHsA52sW/SvnJSlM8V058j7b7eXHQKHl9DF6UBRM Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ytn8974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:39:05 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B1GVXAo010117;
        Thu, 1 Dec 2022 16:39:05 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ytn8963-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:39:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1Gc8iL013559;
        Thu, 1 Dec 2022 16:39:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3m3ae95hvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:39:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B1GcxKY26149600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Dec 2022 16:38:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E25BA405C;
        Thu,  1 Dec 2022 16:38:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A27A1A405B;
        Thu,  1 Dec 2022 16:38:58 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Dec 2022 16:38:58 +0000 (GMT)
Date:   Thu, 1 Dec 2022 17:21:04 +0100
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
Subject: Re: [PATCH v3 2/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
Message-ID: <20221201172104.5540dcad@p-imbrenda>
In-Reply-To: <20221117221758.66326-3-scgl@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
        <20221117221758.66326-3-scgl@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gq7IygJDv2rLUlfmCDcb9PvuDDTeP3T8
X-Proofpoint-GUID: MYpt7C4ictAZa64_GbKHib27YShXlcJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=678 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 17 Nov 2022 23:17:51 +0100
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
> absolute vm write memops which allows user space to perform (storage key
> checked) cmpxchg operations on guest memory.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index eee9f857a986..204d128f23e0 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3753,7 +3753,8 @@ The fields in each entry are defined as follows:
>  :Parameters: struct kvm_s390_mem_op (in)
>  :Returns: = 0 on success,
>            < 0 on generic error (e.g. -EFAULT or -ENOMEM),
> -          > 0 if an exception occurred while walking the page tables  
> +          16 bit program exception code if the access causes such an exception
> +          other code > maximum 16 bit value with special meaning

I would write the number explicitly ( > 65535 or > 0xffff )

>  
>  Read or write data from/to the VM's memory.
>  The KVM_CAP_S390_MEM_OP_EXTENSION capability specifies what functionality is
> @@ -3771,6 +3772,8 @@ Parameters are specified via the following structure::
>  		struct {
>  			__u8 ar;	/* the access register number */
>  			__u8 key;	/* access key, ignored if flag unset */
> +			__u8 pad1[6];	/* ignored */
> +			__u64 old_p;	/* ignored if flag unset */
>  		};
>  		__u32 sida_offset; /* offset into the sida */
>  		__u8 reserved[32]; /* ignored */
> @@ -3853,8 +3856,22 @@ Absolute accesses are permitted for non-protected guests only.
>  Supported flags:
>    * ``KVM_S390_MEMOP_F_CHECK_ONLY``
>    * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> +
> +The semantics of the flags common with logical acesses are as for logical
> +accesses.
> +
> +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
> +In this case, instead of doing an unconditional write, the access occurs only
> +if the target location contains the "size" byte long value pointed to by
> +"old_p". This is performed as an atomic cmpxchg. "size" must be a power of two
> +up to and including 16.
> +The value at the target location is written to the location "old_p" points to.
> +If the exchange did not take place because the target value doesn't match the
> +old value KVM_S390_MEMOP_R_NO_XCHG is returned.
> +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> +has bit 1 (i.e. bit with value 2) set.
>  
> -The semantics of the flags are as for logical accesses.
>  
>  SIDA read/write:
>  ^^^^^^^^^^^^^^^^

