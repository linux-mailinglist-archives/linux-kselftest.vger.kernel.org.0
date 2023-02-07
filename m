Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDA68D931
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 14:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBGNWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 08:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjBGNWx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 08:22:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C0DB767;
        Tue,  7 Feb 2023 05:22:52 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317DMMSS024107;
        Tue, 7 Feb 2023 13:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lTzwb3wPD/ahzgNvLMmcdWpvrliagOkCOoHNCzUnFRs=;
 b=B5fXnb8A4/5najHwGW0QH2YdrL83LmWrisYQuVqZnmct5QE5D2zh35FURWvDiarGaA1M
 7/YtW2AX0Ny4gOVPu8UampIFlIx6QEw3mahJQroDtGzkmZKVv/9l3fzE73RqLqMos6rP
 NCvcgeb5GIPl3dSYfJZApiruVHsXa7c/ApdoZMK4r369WeEx785jklUUXg0kVtQobm1N
 Wzo7QvSA1IbaAwiw1oE6LDOnV/ODsGJkiUYwbBak4ziJG7MNB1AaZrFAH6DkzIbmhQ3R
 J8NXDHsxJ5zALaVPAf5DkK56FL8wdfo+mVNz6+PT/ZNRuJ35Mrm7ljHgBZQVgCfxrkk1 Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkqfj807b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:22:49 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317DMhmc024516;
        Tue, 7 Feb 2023 13:22:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkqfj806k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:22:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 317BjfKR001926;
        Tue, 7 Feb 2023 13:22:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06kmqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 13:22:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317DMhVt53084434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 13:22:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38BF52004B;
        Tue,  7 Feb 2023 13:22:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 636A120043;
        Tue,  7 Feb 2023 13:22:42 +0000 (GMT)
Received: from [9.171.52.227] (unknown [9.171.52.227])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 13:22:42 +0000 (GMT)
Message-ID: <30435adc-e86f-c96c-3795-bea6bca65c16@linux.ibm.com>
Date:   Tue, 7 Feb 2023 14:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 10/14] KVM: s390: Refactor absolute vm mem_op function
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
 <20230206164602.138068-11-scgl@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230206164602.138068-11-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bQ1obWv9uEwb0uJecL-8SBd-L_0GWt0T
X-Proofpoint-GUID: Zf3yjCv-G_ao0ginpF6j-jRf5NrU_ewg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_05,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=884 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070116
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/6/23 17:45, Janis Schoetterl-Glausch wrote:
> Remove code duplication with regards to the CHECK_ONLY flag.
> Decrease the number of indents.
> No functional change indented.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
> 

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> 
> Cosmetic only, can be dropped
> 
> 
>   arch/s390/kvm/kvm-s390.c | 43 +++++++++++++++++-----------------------
>   1 file changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 707967a296f1..1f94b18f1cb5 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2782,6 +2782,7 @@ static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_fla
>   static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
> +	enum gacc_mode acc_mode;
>   	void *tmpbuf = NULL;
>   	int r, srcu_idx;
>   
> @@ -2803,33 +2804,25 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
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
> +	acc_mode = mop->op == KVM_S390_MEMOP_ABSOLUTE_READ ? GACC_FETCH : GACC_STORE;
> +	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> +		r = check_gpa_range(kvm, mop->gaddr, mop->size, acc_mode, mop->key);
> +		goto out_unlock;
>   	}
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
> +	if (acc_mode == GACC_FETCH) {
> +		r = access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> +					      mop->size, GACC_FETCH, mop->key);
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

