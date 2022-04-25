Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1332850E24D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiDYNu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiDYNu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 09:50:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF374AE36;
        Mon, 25 Apr 2022 06:47:44 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PBs8u7023685;
        Mon, 25 Apr 2022 13:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=aRI5j41VpO8jAl2VMpmL1bsu0V2/kiQ5Nz3OxejtxIA=;
 b=rmA/b0KHoecQED+Q7nGpBoJjIvTDWi2d2dloxPWD0Isoc6m0QUbtOhpvsPy6Nqz+IeLo
 WGlTbLmwhRyzhXrTbxUNyMNMQoNe26V/cB+n7NSgX1Y/hbs8ViODr96p0+6EO/LL+3zJ
 rJDphNw71suddZfXDBYlCSAGvPETdquT2cJFFyGyDLY9crVIAYq4GTTVKQgte0HRlXrJ
 CagXnrFAIFbebwOX2RzwnfZ8FoCJfxlCb8AftVp6BnBTBS9KJUSFCDhz8QB+ZXHCn6Ix
 4XMw6cUvqcTqD5i/hEQUTNpehbj45nntek9cr1J/HpK3wmRcFRrqKGnMmZ5z0CqpiNTs ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuh62k6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 13:47:41 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PDOrqA002560;
        Mon, 25 Apr 2022 13:47:40 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuh62k5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 13:47:40 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PDeUQI020699;
        Mon, 25 Apr 2022 13:47:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3fm938t1us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 13:47:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PDlmgu35389696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:47:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC18A42042;
        Mon, 25 Apr 2022 13:47:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEB2942041;
        Mon, 25 Apr 2022 13:47:34 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.10.176])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 13:47:34 +0000 (GMT)
Date:   Mon, 25 Apr 2022 15:46:44 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: s390: Don't indicate suppression on
 dirtying, failing memop
Message-ID: <20220425154644.383d4b7f@p-imbrenda>
In-Reply-To: <20220425100147.1755340-2-scgl@linux.ibm.com>
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
        <20220425100147.1755340-2-scgl@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9VILd7bZh7d1OxRloBhWWofwLk4TdcfC
X-Proofpoint-GUID: vZ_izivV8rp6opn6LJ13O4ZaW4lly9nH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=862
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Apr 2022 12:01:46 +0200
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> If user space uses a memop to emulate an instruction and that
> memop fails, the execution of the instruction ends.
> Instruction execution can end in different ways, one of which is
> suppression, which requires that the instruction execute like a no-op.
> A writing memop that spans multiple pages and fails due to key
> protection can modified guest memory, as a result, the likely
> correct ending is termination. Therefore do not indicate a
> suppressing instruction ending in this case.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/gaccess.c | 47 ++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index d53a183c2005..3b1fbef82288 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -491,8 +491,8 @@ enum prot_type {
>  	PROT_TYPE_IEP  = 4,
>  };
>  
> -static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
> -		     u8 ar, enum gacc_mode mode, enum prot_type prot)
> +static int trans_exc_ending(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
> +			    enum gacc_mode mode, enum prot_type prot, bool suppress)
>  {
>  	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
>  	struct trans_exc_code_bits *tec;
> @@ -503,22 +503,24 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
>  
>  	switch (code) {
>  	case PGM_PROTECTION:
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
>  		}
>  		fallthrough;
>  	case PGM_ASCE_TYPE:
> @@ -552,6 +554,12 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
>  	return code;
>  }
>  
> +static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva, u8 ar,
> +		     enum gacc_mode mode, enum prot_type prot)
> +{
> +	return trans_exc_ending(vcpu, code, gva, ar, mode, prot, true);
> +}
> +
>  static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
>  			 unsigned long ga, u8 ar, enum gacc_mode mode)
>  {
> @@ -1110,7 +1118,8 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>  		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
>  	}
>  	if (rc > 0)
> -		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);
> +		rc = trans_exc_ending(vcpu, rc, ga, ar, mode, prot,
> +				      (mode != GACC_STORE) || (idx == 0));
>  out_unlock:
>  	if (need_ipte_lock)
>  		ipte_unlock(vcpu);

