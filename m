Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9250F20D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 09:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiDZHVf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDZHVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 03:21:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2197BB4;
        Tue, 26 Apr 2022 00:18:28 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q7EgBv018722;
        Tue, 26 Apr 2022 07:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9+pOc/5w24EOaxSIM5Kzeu1VpGFG/SvBf+r0pH0Tn1w=;
 b=oFoX/6p+NCkMUpfUcVYQbsH3IL3MZ9NePKlzQYbj9Tt2/idLmbnaGFYM8pmE4vKZAj8Q
 tghO2E0oK03tj4EUeAxo5zj3Tqe+aug6l9DZ5ZVTuj7alaY8aF9EIAIebM01wUklq4mp
 1jJ60TlrSbxLXDuWsFPXfOpvnJwe7uzHOY2Td+rEiMj+b9A/x0puyXx2GpD0mIHUko1j
 7+4vKN8RKDopY3BsmpGP7JnJ7ENpehVkpWSkwJwjfvHZ4bis13iq4eHzYgPNLVcB2Wte
 l6Ak64ccQn+NmnDwNwMJSn3E5UXisCQvDBsWUq8IQmI42IPNQRIu9vyLbZfLJQF51Ge3 ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpc67823a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 07:18:26 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q7ExbX019211;
        Tue, 26 Apr 2022 07:18:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpc67822v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 07:18:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q78Zcs010899;
        Tue, 26 Apr 2022 07:18:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj3uh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 07:18:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q7IJKM35324222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 07:18:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1297AE055;
        Tue, 26 Apr 2022 07:18:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 204D8AE045;
        Tue, 26 Apr 2022 07:18:19 +0000 (GMT)
Received: from [9.145.2.160] (unknown [9.145.2.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 07:18:19 +0000 (GMT)
Message-ID: <2be2e47d-c1f5-18ac-264d-a1bde3b03c24@linux.ibm.com>
Date:   Tue, 26 Apr 2022 09:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] KVM: s390: Don't indicate suppression on dirtying,
 failing memop
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
 <20220425100147.1755340-2-scgl@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20220425100147.1755340-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WKoPV97it3lvEGGR1tLgLQkhXcJibm6b
X-Proofpoint-GUID: Rppi6TdBmuvJfebvbmlxxEqMsg5UWf6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=939
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260046
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/25/22 12:01, Janis Schoetterl-Glausch wrote:
> If user space uses a memop to emulate an instruction and that
> memop fails, the execution of the instruction ends.
> Instruction execution can end in different ways, one of which is
> suppression, which requires that the instruction execute like a no-op.



> A writing memop that spans multiple pages and fails due to key
> protection can modified guest memory, as a result, the likely
> correct ending is termination. Therefore do not indicate a
> suppressing instruction ending in this case.

Check grammar.

> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   arch/s390/kvm/gaccess.c | 47 ++++++++++++++++++++++++-----------------
>   1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index d53a183c2005..3b1fbef82288 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -491,8 +491,8 @@ enum prot_type {
>   	PROT_TYPE_IEP  = 4,
>   };
>   
> -static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
> -		     u8 ar, enum gacc_mode mode, enum prot_type prot)
> +static int trans_exc_ending(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
> +			    enum gacc_mode mode, enum prot_type prot, bool suppress)
>   {
>   	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
>   	struct trans_exc_code_bits *tec;
> @@ -503,22 +503,24 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
>   
>   	switch (code) {
>   	case PGM_PROTECTION:
> -		switch (prot) {
> -		case PROT_TYPE_IEP:
> -			tec->b61 = 1;
> -			fallthrough;
> -		case PROT_TYPE_LA:
> -			tec->b56 = 1;
> -			break;
> -		case PROT_TYPE_KEYC:
> -			tec->b60 = 1;
> -			break;
> -		case PROT_TYPE_ALC:
> -			tec->b60 = 1;
> -			fallthrough;
> -		case PROT_TYPE_DAT:
> -			tec->b61 = 1;
> -			break;
> +		if (suppress) {
> +			switch (prot) {
> +			case PROT_TYPE_IEP:
> +				tec->b61 = 1;
> +				fallthrough;
> +			case PROT_TYPE_LA:
> +				tec->b56 = 1;
> +				break;
> +			case PROT_TYPE_KEYC:
> +				tec->b60 = 1;
> +				break;
> +			case PROT_TYPE_ALC:
> +				tec->b60 = 1;
> +				fallthrough;
> +			case PROT_TYPE_DAT:
> +				tec->b61 = 1;
> +				break;
> +			}
>   		}

How about switching this around and masking those bits on termination.

>   		fallthrough;
>   	case PGM_ASCE_TYPE:
> @@ -552,6 +554,12 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
>   	return code;
>   }
>   
> +static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
> +		     enum gacc_mode mode, enum prot_type prot)
> +{
> +	return trans_exc_ending(vcpu, code, gva, ar, mode, prot, true);
> +}
> +
>   static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
>   			 unsigned long ga, u8 ar, enum gacc_mode mode)
>   {
> @@ -1110,7 +1118,8 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>   		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
>   	}
>   	if (rc > 0)
> -		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);
> +		rc = trans_exc_ending(vcpu, rc, ga, ar, mode, prot,
> +				      (mode != GACC_STORE) || (idx == 0));

Add a boolean variable named terminating, calculate the value before 
passing the boolean on.

>   out_unlock:
>   	if (need_ipte_lock)
>   		ipte_unlock(vcpu);


