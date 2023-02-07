Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2283B68D7D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 14:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjBGNDt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 08:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjBGNDs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 08:03:48 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63452B2BE;
        Tue,  7 Feb 2023 05:03:47 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317CidBd008600;
        Tue, 7 Feb 2023 13:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yZgO0eM8LcpQcrcCMa03LeA0r6BeUXFzzF3c5L8rSZk=;
 b=N78/AMnYkCf8/BELFlvs3tMYivbOHoz3Cla2Dd/HXN0a5N7RuwWQDH0CLLDhoRqOItSZ
 pWK9iIVST4CKNwxU/RUkx0bfY889L+zJfjJT2Wni64l2ipqkQ9U9RBU9YVflA24zoSiv
 KuIMYDIbOz1hpWIjq6YNzmUuvn+qSYo/CHHq0wC4aw/GgyBOMplyE2F/6dovX2ixUoVz
 1ey9CQPvF2RiM6nUD7zWdDSCuV+W8xmoGJpguj48dKjCJWHoXzxVLRhM6BWtUjtD8BCZ
 fxZ6YV1mvb1fdOzD/fvprBO1EP62epZTQKF/zl7AEqBs+CIhqZj1F9pNj4FHE0CEhn5G 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkpwp0fnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:03:40 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317CjDPN009890;
        Tue, 7 Feb 2023 13:03:40 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkpwp0fmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:03:40 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316DmNTb017584;
        Tue, 7 Feb 2023 13:03:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3nhemfjjyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:03:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317D3YrZ26083962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 13:03:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07A122004B;
        Tue,  7 Feb 2023 13:03:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06CBA20043;
        Tue,  7 Feb 2023 13:03:33 +0000 (GMT)
Received: from [9.171.52.227] (unknown [9.171.52.227])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 13:03:32 +0000 (GMT)
Message-ID: <ba65c1b9-910b-b298-926f-4a072f3de1e7@linux.ibm.com>
Date:   Tue, 7 Feb 2023 14:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 08/14] KVM: s390: Move common code of mem_op functions
 into function
Content-Language: en-US
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
References: <20230206164602.138068-1-scgl@linux.ibm.com>
 <20230206164602.138068-9-scgl@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230206164602.138068-9-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: walVhawWM1DOoQjL54-ed3g3x58xCvkh
X-Proofpoint-GUID: 4mFalkmlk0Nj13Rb-lhcQpOBFluFKRL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_04,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070111
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/6/23 17:45, Janis Schoetterl-Glausch wrote:
> The vcpu and vm mem_op ioctl implementations share some functionality.
> Move argument checking into a function and call it from both
> implementations. This allows code reuse in case of additional future
> mem_op operations.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   arch/s390/kvm/kvm-s390.c | 52 +++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e4890e04b210..0367c1a7e69a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2764,24 +2764,32 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>   	return r;
>   }
>   
> -static bool access_key_invalid(u8 access_key)
> +static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_flags)
>   {
> -	return access_key > 0xf;
> +	if (mop->flags & ~supported_flags || !mop->size)
> +		return -EINVAL;
> +	if (mop->size > MEM_OP_MAX_SIZE)
> +		return -E2BIG;
> +	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> +		if (mop->key > 0xf)
> +			return -EINVAL;
> +	} else {
> +		mop->key = 0;
> +	}
> +	return 0;
>   }
>   
>   static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
> -	u64 supported_flags;
>   	void *tmpbuf = NULL;
>   	int r, srcu_idx;
>   
> -	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
> -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> -	if (mop->flags & ~supported_flags || !mop->size)
> -		return -EINVAL;
> -	if (mop->size > MEM_OP_MAX_SIZE)
> -		return -E2BIG;
> +	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_SKEY_PROTECTION |
> +					KVM_S390_MEMOP_F_CHECK_ONLY);
> +	if (r)
> +		return r;
> +
>   	/*
>   	 * This is technically a heuristic only, if the kvm->lock is not
>   	 * taken, it is not guaranteed that the vm is/remains non-protected.
> @@ -2793,12 +2801,6 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	 */
>   	if (kvm_s390_pv_get_handle(kvm))
>   		return -EINVAL;
> -	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> -		if (access_key_invalid(mop->key))
> -			return -EINVAL;
> -	} else {
> -		mop->key = 0;
> -	}
>   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>   		tmpbuf = vmalloc(mop->size);
>   		if (!tmpbuf)
> @@ -5250,23 +5252,17 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
>   	void *tmpbuf = NULL;
> -	int r = 0;
> -	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
> -				    | KVM_S390_MEMOP_F_CHECK_ONLY
> -				    | KVM_S390_MEMOP_F_SKEY_PROTECTION;
> +	int r;
>   
> -	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS || !mop->size)
> +	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_INJECT_EXCEPTION |
> +					KVM_S390_MEMOP_F_CHECK_ONLY |
> +					KVM_S390_MEMOP_F_SKEY_PROTECTION);
> +	if (r)
> +		return r;
> +	if (mop->ar >= NUM_ACRS)
>   		return -EINVAL;
> -	if (mop->size > MEM_OP_MAX_SIZE)
> -		return -E2BIG;
>   	if (kvm_s390_pv_cpu_is_protected(vcpu))
>   		return -EINVAL;
> -	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> -		if (access_key_invalid(mop->key))
> -			return -EINVAL;
> -	} else {
> -		mop->key = 0;
> -	}
>   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>   		tmpbuf = vmalloc(mop->size);
>   		if (!tmpbuf)

