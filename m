Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB344EF8B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 19:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiDARPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 13:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiDARPp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 13:15:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB51171568;
        Fri,  1 Apr 2022 10:13:51 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FflMg001896;
        Fri, 1 Apr 2022 17:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aZUktyIygGRp6+G92Fu4LfZjLn/Rve4c0PVNF2gACXI=;
 b=gzw9CB4QtgD7IAZZ2dgKACWmTdZPplCDYIa3QUx+0t0K4UBVT7eOUFhpM3oPHxW/9OFX
 JNiUzvKtNnyD7b6fews5KOpZxntcn6SmJDVJcS04gafO+r9AdArQOlWTXbMw/mPOUv9S
 qvoKpi8ZJeELp/tvSVLHXrs3iGt4cemNjJOZVSvnLPVvLtCFfpZAo2ES4fZGUBuUPTp0
 UKRGqwTTiYw9cnIgLb6MEeUlOLvnHVlwAoKigEJKTrEZFpDDcOq7NnfFbSZgjQ7HaxoI
 cvY8uu+Bh3h5jIdZHTKuWj2n8IbWwEcLGtf4EBBU74TdGMXNLK0dhel/aLUZNl3Y4tmA IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f648s1ufn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:13:46 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 231GuAbl010416;
        Fri, 1 Apr 2022 17:13:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f648s1uf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:13:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 231HChX4029868;
        Fri, 1 Apr 2022 17:13:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3f1tf95f3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:13:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 231H1aom45482284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 17:01:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73ECBA405F;
        Fri,  1 Apr 2022 17:13:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5679A4051;
        Fri,  1 Apr 2022 17:13:39 +0000 (GMT)
Received: from [9.171.0.19] (unknown [9.171.0.19])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Apr 2022 17:13:39 +0000 (GMT)
Message-ID: <e191fbc0-9471-5cde-7698-cdd32d83051f@linux.ibm.com>
Date:   Fri, 1 Apr 2022 19:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] KVM: s390: Don't indicate suppression on dirtying,
 failing memop
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220401170247.1287354-1-scgl@linux.ibm.com>
 <20220401170247.1287354-2-scgl@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220401170247.1287354-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -RIGjg4fk1WFLx9wiwfUYGXh6t-JfNkp
X-Proofpoint-ORIG-GUID: Sjr6veBoeqkutd937-Pow2z7yjcb4hdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=991
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Am 01.04.22 um 19:02 schrieb Janis Schoetterl-Glausch:
> If user space uses a memop to emulate an instruction and that
> memop fails, the execution of the instruction ends.
> Instruction execution can end in different ways, one of which is
> suppression, which requires that the instruction execute like a no-op.
> A writing memop that spans multiple pages and fails due to key
> protection can modified guest memory. Therefore do not indicate a
> suppressing instruction ending in this case.

Make it explicit in the changelog that this is "terminating" instead of
"suppressing". z/VM has the same logic and the architecture allows for
terminating in those cases (even for ESOP2).
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
>   out_unlock:
>   	if (need_ipte_lock)
>   		ipte_unlock(vcpu);
