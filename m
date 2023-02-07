Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7768D881
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 14:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjBGNKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjBGNKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 08:10:14 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583193B0E8;
        Tue,  7 Feb 2023 05:09:58 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317BOhL4030809;
        Tue, 7 Feb 2023 13:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eSqfTMcYmap6Rq2CFj8elWEtcqRfbRQlrMyq11yd7PE=;
 b=cHWqwEXEmiSZuysi0XYCUSPHltUT6gITefzFDmfrADIIKPEzF7w4Z6SvtG0Z9y8yTS35
 gQCPCEsm4BzREgIukFTZVF+3E+4A2df8dl1wXpwIqfAvd/lkId9hbTnIRAOHjslJbm4x
 QcFrhP42gptAG3o990uZlNUjQiS9zePIcHUqUUpR5VDfwTCpIuS4a3O5jBK80fiXSiyN
 AAAP9cZhf93LRKFgUPV1msQ44Kl32d5wMp6iWYvYQ0DLriD3nzkiVScV4dZ+aBGZT+BM
 /aCbZxjPgE8CyCSgi9ftbdkYQWmvwNH+DPGwOJnhkSLBh1hXI421tkR3/PZVq/F3WaWd dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nknr32kvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:09:02 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317CrUxH023084;
        Tue, 7 Feb 2023 13:09:01 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nknr32kvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:09:01 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316Dvnms015413;
        Tue, 7 Feb 2023 13:08:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06tja7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:08:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317D8ufq23855512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 13:08:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFDE920043;
        Tue,  7 Feb 2023 13:08:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11F7F20040;
        Tue,  7 Feb 2023 13:08:55 +0000 (GMT)
Received: from [9.171.52.227] (unknown [9.171.52.227])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 13:08:54 +0000 (GMT)
Message-ID: <f37f0057-c872-4cb0-fd15-12d2ef280f49@linux.ibm.com>
Date:   Tue, 7 Feb 2023 14:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 09/14] KVM: s390: Dispatch to implementing function at
 top level of vm mem_op
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
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
 <20230206164602.138068-10-scgl@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230206164602.138068-10-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wv-J_tqsIw07YP7dJAYC3o8baXJGZUWU
X-Proofpoint-ORIG-GUID: YlNFpg-Fkt1HeNAWRFKav-OQgJcr1cJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_05,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070116
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/6/23 17:45, Janis Schoetterl-Glausch wrote:
> Instead of having one function covering all mem_op operations,
> have a function implementing absolute access and dispatch to that
> function in its caller, based on the operation code.
> This way additional future operations can be implemented by adding an
> implementing function without changing existing operations.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   arch/s390/kvm/kvm-s390.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 0367c1a7e69a..707967a296f1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2779,7 +2779,7 @@ static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_fla
>   	return 0;
>   }
>   
> -static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
> +static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
>   	void *tmpbuf = NULL;
> @@ -2790,17 +2790,6 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	if (r)
>   		return r;
>   
> -	/*
> -	 * This is technically a heuristic only, if the kvm->lock is not
> -	 * taken, it is not guaranteed that the vm is/remains non-protected.
> -	 * This is ok from a kernel perspective, wrongdoing is detected
> -	 * on the access, -EFAULT is returned and the vm may crash the
> -	 * next time it accesses the memory in question.
> -	 * There is no sane usecase to do switching and a memop on two
> -	 * different CPUs at the same time.
> -	 */
> -	if (kvm_s390_pv_get_handle(kvm))
> -		return -EINVAL;
>   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>   		tmpbuf = vmalloc(mop->size);
>   		if (!tmpbuf)
> @@ -2841,8 +2830,6 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   		}
>   		break;
>   	}
> -	default:
> -		r = -EINVAL;
>   	}
>   
>   out_unlock:
> @@ -2852,6 +2839,29 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	return r;
>   }
>   
> +static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
> +{
> +	/*
> +	 * This is technically a heuristic only, if the kvm->lock is not
> +	 * taken, it is not guaranteed that the vm is/remains non-protected.
> +	 * This is ok from a kernel perspective, wrongdoing is detected
> +	 * on the access, -EFAULT is returned and the vm may crash the
> +	 * next time it accesses the memory in question.
> +	 * There is no sane usecase to do switching and a memop on two
> +	 * different CPUs at the same time.
> +	 */
> +	if (kvm_s390_pv_get_handle(kvm))
> +		return -EINVAL;
> +
> +	switch (mop->op) {
> +	case KVM_S390_MEMOP_ABSOLUTE_READ:
> +	case KVM_S390_MEMOP_ABSOLUTE_WRITE:
> +		return kvm_s390_vm_mem_op_abs(kvm, mop);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   long kvm_arch_vm_ioctl(struct file *filp,
>   		       unsigned int ioctl, unsigned long arg)
>   {

