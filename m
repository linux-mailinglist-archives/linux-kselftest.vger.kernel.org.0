Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BCE52A175
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiEQM0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 08:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbiEQM0a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 08:26:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A38BF6D;
        Tue, 17 May 2022 05:26:29 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HBK1JS009399;
        Tue, 17 May 2022 12:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oITBhgw2DgjooEWBAksX8aen1RGzaWZZg0dSlGBb/PQ=;
 b=scZxvkSkZT9KQCDnFeIHZLt2xYNkwFzNdvQBtnBZes8wp7DGFsXEpwGkx0G+EdJPHzfA
 EBay0UK60NQXakr+PYuVw6EOaP2mAgazSoQjCpU90dcZAXTrx3eRFy8JKH2Diej+SRxn
 jlIOJB8e4JVvsE7zOhyEsH42mWMkTLyA6F5eO9j731bZe8RlBRyuJj2wVh3iaWNzVpX7
 OhQlephKl+/L2x7MVF7iRvm5xCurrB/BCB9hi2DROK6v5BswN75fY5uzfDEYfQJZbkGV
 AYl05G/MJTBOWReZuNgxcHOMolH7NLnWWvZPsZW05AX97SxMOWP5FyE2KLzYyR8p91FG xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4ar79hf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:26:25 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HBd9XZ017067;
        Tue, 17 May 2022 12:26:25 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4ar79hee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:26:25 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HCMxSO005083;
        Tue, 17 May 2022 12:26:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3g2428uc4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:26:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HCQKVQ32047402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 12:26:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F11C52052;
        Tue, 17 May 2022 12:26:20 +0000 (GMT)
Received: from [9.171.49.46] (unknown [9.171.49.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9755752050;
        Tue, 17 May 2022 12:26:19 +0000 (GMT)
Message-ID: <975ba61e-b0ba-b5a8-8e71-2833b95fb638@linux.ibm.com>
Date:   Tue, 17 May 2022 14:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] KVM: s390: selftest: Test suppression indication
 on key prot exception
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220512131019.2594948-1-scgl@linux.ibm.com>
 <20220512131019.2594948-3-scgl@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220512131019.2594948-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TIyc9jtkwpNbz-TldKvW19KfMMJTCrLH
X-Proofpoint-GUID: VFZC95bDYfIqSeTLoCwYsLP7Jndqu8f_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_02,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170073
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Am 12.05.22 um 15:10 schrieb Janis Schoetterl-Glausch:
> Check that suppression is not indicated on injection of a key checked
> protection exception caused by a memop after it already modified guest
> memory, as that violates the definition of suppression.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 46 ++++++++++++++++++++++-
>   1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index b04c2c1b3c30..49f26f544127 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -10,6 +10,8 @@
>   #include <string.h>
>   #include <sys/ioctl.h>
>   
> +#include <linux/bits.h>
> +
>   #include "test_util.h"
>   #include "kvm_util.h"
>   
> @@ -194,6 +196,7 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
>   #define SIDA_OFFSET(o) ._sida_offset = 1, .sida_offset = (o)
>   #define AR(a) ._ar = 1, .ar = (a)
>   #define KEY(a) .f_key = 1, .key = (a)
> +#define INJECT .f_inject = 1
>   
>   #define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
>   
> @@ -430,9 +433,18 @@ static void test_copy_key_fetch_prot(void)
>   	TEST_ASSERT(rv == 4, "Should result in protection exception");		\
>   })
>   
> +static void guest_error_key(void)
> +{
> +	GUEST_SYNC(STAGE_INITED);
> +	set_storage_key_range(mem1, PAGE_SIZE, 0x18);
> +	set_storage_key_range(mem1 + PAGE_SIZE, sizeof(mem1) - PAGE_SIZE, 0x98);
> +	GUEST_SYNC(STAGE_SKEYS_SET);
> +	GUEST_SYNC(STAGE_IDLED);
> +}
> +
>   static void test_errors_key(void)
>   {
> -	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
> +	struct test_default t = test_default_init(guest_error_key);
>   
>   	HOST_SYNC(t.vcpu, STAGE_INITED);
>   	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
> @@ -446,6 +458,37 @@ static void test_errors_key(void)
>   	kvm_vm_free(t.kvm_vm);
>   }
>   
> +static void test_termination(void)
> +{
> +	struct test_default t = test_default_init(guest_error_key);
> +	uint64_t prefix;
> +	uint64_t teid;
> +	uint64_t teid_mask = BIT(63 - 56) | BIT(63 - 60) | BIT(63 - 61);
> +	uint64_t psw[2];
> +
> +	HOST_SYNC(t.vcpu, STAGE_INITED);
> +	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
> +
> +	/* vcpu, mismatching keys after first page */
> +	ERR_PROT_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), KEY(1), INJECT);
> +	/*
> +	 * The memop injected a program exception and the test needs to check the
> +	 * Translation-Exception Identification (TEID). It is necessary to run
> +	 * the guest in order to be able to read the TEID from guest memory.
> +	 * Set the guest program new PSW, so the guest state is not clobbered.
> +	 */
> +	prefix = t.run->s.regs.prefix;
> +	psw[0] = t.run->psw_mask;
> +	psw[1] = t.run->psw_addr;
> +	MOP(t.vm, ABSOLUTE, WRITE, psw, sizeof(psw), GADDR(prefix + 464));
> +	HOST_SYNC(t.vcpu, STAGE_IDLED);
> +	MOP(t.vm, ABSOLUTE, READ, &teid, sizeof(teid), GADDR(prefix + 168));
> +	/* Bits 56, 60, 61 form a code, 0 being the only one allowing for termination */
> +	ASSERT_EQ(teid & teid_mask, 0);
> +
> +	kvm_vm_free(t.kvm_vm);
> +}
> +
>   static void test_errors_key_storage_prot_override(void)
>   {
>   	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
> @@ -668,6 +711,7 @@ int main(int argc, char *argv[])
>   		test_copy_key_fetch_prot();
>   		test_copy_key_fetch_prot_override();
>   		test_errors_key();
> +		test_termination();
>   		test_errors_key_storage_prot_override();
>   		test_errors_key_fetch_prot_override_not_enabled();
>   		test_errors_key_fetch_prot_override_enabled();
