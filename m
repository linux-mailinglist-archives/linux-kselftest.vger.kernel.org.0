Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6646689C2A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjBCOtP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjBCOtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 09:49:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92CE1F5EC;
        Fri,  3 Feb 2023 06:49:12 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313Eg6b5020482;
        Fri, 3 Feb 2023 14:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=otsSqWtNyr6skvlJKHQVwPBgVdpvIRkyLd68VyEGcx8=;
 b=iNRE5xJrjlupJTLU33v3tIEhPD5OqMWX+UrPUhjlG9hsFjS42LGSWqevpDjarKGAlyL9
 j1GUphn+jLTqA1uvgvvWNfGZ9AIuVO00hljBQOrIp8Zq8iGni39IGN+XndIFUXGP3ChS
 Ahi44HU52lHG9brzwa57lUf+UdpxUpZxHs0EYT0Pd0MzCzaWH+LeYDa2vDIcJ3VB4LVc
 Ux9cU5xtSQqHJOEh2epHjr20avMmbta+4hombr+clB1ghHAIoPwU2dvPXX8DvbkDF8yR
 1DIlxkRNK3A6DfxQdA7qVmhHtyJ2KHwZ6GTtdsSIQaI4Pc1LuVoW4lNA6QNSk7+xKepr Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh48r0594-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 14:49:03 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 313EhLSI022720;
        Fri, 3 Feb 2023 14:49:03 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh48r0588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 14:49:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 313ABMnG027465;
        Fri, 3 Feb 2023 14:49:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvttyhdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 14:49:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 313Emuj548431476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 14:48:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CAB420043;
        Fri,  3 Feb 2023 14:48:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56A920040;
        Fri,  3 Feb 2023 14:48:55 +0000 (GMT)
Received: from [9.171.75.139] (unknown [9.171.75.139])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 14:48:55 +0000 (GMT)
Message-ID: <f1b28707-c525-7cd1-64d5-6717bac5d711@linux.ibm.com>
Date:   Fri, 3 Feb 2023 15:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-11-scgl@linux.ibm.com>
Content-Language: en-US
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v6 10/14] KVM: s390: Refactor absolute vm mem_op function
In-Reply-To: <20230125212608.1860251-11-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -01CFyzKLS6ybLixwOxbYZ7g97oI5V7u
X-Proofpoint-ORIG-GUID: qfS7nfAf9MB8z_Op_n1vqvROJUZ5KKZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_13,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=758 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/25/23 22:26, Janis Schoetterl-Glausch wrote:
> Remove code duplication with regards to the CHECK_ONLY flag.
> Decrease the number of indents.
> No functional change indented.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> Cosmetic only, can be dropped.
> 
> 
>   arch/s390/kvm/kvm-s390.c | 43 ++++++++++++++++------------------------
>   1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 588cf70dc81e..cfd09cb43ef6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2794,6 +2794,7 @@ static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
>   static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
> +	enum gacc_mode acc_mode;
>   	void *tmpbuf = NULL;
>   	int r, srcu_idx;
>   
> @@ -2813,33 +2814,23 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   		goto out_unlock;
>   	}
>   
> -	switch (mop->op) {
> -	case KVM_S390_MEMOP_ABSOLUTE_READ: {
> -		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> -			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_FETCH, mop->key);
> -		} else {
> -			r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> -						      mop->size, GACC_FETCH, mop->key);
> -			if (r == 0) {
> -				if (copy_to_user(uaddr, tmpbuf, mop->size))
> -					r = -EFAULT;
> -			}
> -		}
> -		break;
> -	}
> -	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
> -		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> -			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
> -		} else {
> -			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> -				r = -EFAULT;
> -				break;
> -			}
> -			r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> -						      mop->size, GACC_STORE, mop->key);
> +	acc_mode = mop->op == KVM_S390_MEMOP_ABSOLUTE_READ ? GACC_FETCH : GACC_STORE;

Would the line be too long if that variable would be initialized where 
it's defined?

> +	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> +		r = check_gpa_range(kvm, mop->gaddr, mop->size, acc_mode, mop->key);

We should early return i.e. goto out_unlock.

IMHO else if, else patterns should either be switches (testing the same 
variable) or kept as short as possible / be avoided.

> +	} else if (acc_mode == GACC_FETCH) {
> +		r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> +					      mop->size, GACC_FETCH, mop->key);

I'd guess it's personal taste whether you use GACC_FETCH or access_mode 
but if you don't use it here then we can remove the variable all 
together, no?

> +		if (r)
> +			goto out_unlock;
> +		if (copy_to_user(uaddr, tmpbuf, mop->size))
> +			r = -EFAULT;
> +	} else {
> +		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> +			r = -EFAULT;
> +			goto out_unlock;
>   		}
> -		break;
> -	}
> +		r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> +					      mop->size, GACC_STORE, mop->key);
>   	}
>   
>   out_unlock:

