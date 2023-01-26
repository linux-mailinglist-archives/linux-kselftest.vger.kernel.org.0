Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C567CA47
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjAZLv6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 06:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjAZLv5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 06:51:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE61259A;
        Thu, 26 Jan 2023 03:51:56 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QBg6Bn013213;
        Thu, 26 Jan 2023 11:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dT4GiBRJi0vaPuWg1zPzvIHecZYmHpSb6zEd1Vr8B4s=;
 b=hifgUfKUsKHMUO5SCrHr/wGKgFjvRjKwEwJZILhtSOgJoQTWUFazlhkwOrFWNDqsMT0d
 cs3xx79m0MlqrTaKDRweItS/BOiruMAT9BI1bbtoR5BlI0ChGKpRcYOXjlBRgC5btqWO
 xTPua3+QPaYUY2Yesbdq711n3vEBPwWhBWMAipS6OUdabowSGMMAdTTp4eNEQc8t1qAY
 rT+yd0FXqTrOvPFXLQ3DuirNV2auH6qhZCrPpayTQ4Td5S4vaGa6dTzD3qPIVNs4848E
 qNOnMWAlvDEgLPKjHEThtGgkyzaexxvPZqg/eMjI3SBLaqSpNrY7uCwv8eIoqusW0UVj WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbrv6g6ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 11:51:54 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QBgIpQ013670;
        Thu, 26 Jan 2023 11:51:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbrv6g6qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 11:51:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QApjPv015356;
        Thu, 26 Jan 2023 11:51:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afeb8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 11:51:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QBpl1c41222402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 11:51:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76D8420040;
        Thu, 26 Jan 2023 11:51:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D5F42004B;
        Thu, 26 Jan 2023 11:51:47 +0000 (GMT)
Received: from [9.152.224.253] (unknown [9.152.224.253])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 11:51:47 +0000 (GMT)
Message-ID: <9a8086e5-7794-5d76-6f96-69b218d1cc25@linux.ibm.com>
Date:   Thu, 26 Jan 2023 12:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 01/14] KVM: s390: selftest: memop: Pass mop_desc via
 pointer
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
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-2-scgl@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230125212608.1860251-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yPmX9jEjrrwQBP9klnm9vIDq2QnZsMpK
X-Proofpoint-GUID: uSsVsctfDzmd1SLIfbBSBhE-OjEJO23-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_04,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260111
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/25/23 22:25, Janis Schoetterl-Glausch wrote:
> The struct is quite large, so this seems nicer.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 44 +++++++++++------------
>   1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 3fd81e58f40c..9c05d1205114 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -48,53 +48,53 @@ struct mop_desc {
>   	uint8_t key;
>   };
>   
> -static struct kvm_s390_mem_op ksmo_from_desc(struct mop_desc desc)
> +static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
>   {
>   	struct kvm_s390_mem_op ksmo = {
> -		.gaddr = (uintptr_t)desc.gaddr,
> -		.size = desc.size,
> -		.buf = ((uintptr_t)desc.buf),
> +		.gaddr = (uintptr_t)desc->gaddr,
> +		.size = desc->size,
> +		.buf = ((uintptr_t)desc->buf),
>   		.reserved = "ignored_ignored_ignored_ignored"
>   	};
>   
> -	switch (desc.target) {
> +	switch (desc->target) {
>   	case LOGICAL:
> -		if (desc.mode == READ)
> +		if (desc->mode == READ)
>   			ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
> -		if (desc.mode == WRITE)
> +		if (desc->mode == WRITE)
>   			ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
>   		break;
>   	case SIDA:
> -		if (desc.mode == READ)
> +		if (desc->mode == READ)
>   			ksmo.op = KVM_S390_MEMOP_SIDA_READ;
> -		if (desc.mode == WRITE)
> +		if (desc->mode == WRITE)
>   			ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
>   		break;
>   	case ABSOLUTE:
> -		if (desc.mode == READ)
> +		if (desc->mode == READ)
>   			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_READ;
> -		if (desc.mode == WRITE)
> +		if (desc->mode == WRITE)
>   			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_WRITE;
>   		break;
>   	case INVALID:
>   		ksmo.op = -1;
>   	}
> -	if (desc.f_check)
> +	if (desc->f_check)
>   		ksmo.flags |= KVM_S390_MEMOP_F_CHECK_ONLY;
> -	if (desc.f_inject)
> +	if (desc->f_inject)
>   		ksmo.flags |= KVM_S390_MEMOP_F_INJECT_EXCEPTION;
> -	if (desc._set_flags)
> -		ksmo.flags = desc.set_flags;
> -	if (desc.f_key) {
> +	if (desc->_set_flags)
> +		ksmo.flags = desc->set_flags;
> +	if (desc->f_key) {
>   		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
> -		ksmo.key = desc.key;
> +		ksmo.key = desc->key;
>   	}
> -	if (desc._ar)
> -		ksmo.ar = desc.ar;
> +	if (desc->_ar)
> +		ksmo.ar = desc->ar;
>   	else
>   		ksmo.ar = 0;
> -	if (desc._sida_offset)
> -		ksmo.sida_offset = desc.sida_offset;
> +	if (desc->_sida_offset)
> +		ksmo.sida_offset = desc->sida_offset;
>   
>   	return ksmo;
>   }
> @@ -183,7 +183,7 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
>   		else								\
>   			__desc.gaddr = __desc.gaddr_v;				\
>   	}									\
> -	__ksmo = ksmo_from_desc(__desc);					\
> +	__ksmo = ksmo_from_desc(&__desc);					\
>   	print_memop(__info.vcpu, &__ksmo);					\
>   	err##memop_ioctl(__info, &__ksmo);					\
>   })

