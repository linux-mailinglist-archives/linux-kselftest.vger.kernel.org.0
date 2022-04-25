Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671050E245
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiDYNvA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiDYNu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 09:50:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C04A93B;
        Mon, 25 Apr 2022 06:47:42 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PCDOlU010452;
        Mon, 25 Apr 2022 13:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=PBOzSs+wB8tce1Kn6v6GyvzHKDn8ZuGbp5VdiG7/gcU=;
 b=keZYwilvew6/uHIuZu4Al6y1JqNCQi4Tp1eWUC+Xtabu0X37qOZPdGpe6dVliEVZW/9m
 stWV+EVco68XCGUoRPSPM6N75spbOjbo73fWG8O8JZx5E/yInsMh5dXhYixRPPu+FWTT
 oYlKtci2oVd7IAKyEkyPT7/eJTmqVtCFDkUyDQBJccDxcISA59EkFh9DZa/EvzLutHVq
 asGBDRCp5Cz89AJWIRIvyPlLktVuyXIr0IKXarEpV+BuPGFa1OA4i+jL+NewQdG4Y1x0
 GVaTOEG5w+ZQzc6LpA3TwZxKRMYeqLXGqJeT8eelK8/AOPg7vrdRMqDWvJ4P0YZT7dpJ 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmtvhjvga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 13:47:39 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PDJOq7029696;
        Mon, 25 Apr 2022 13:47:38 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmtvhjvfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 13:47:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PDeSL5024052;
        Mon, 25 Apr 2022 13:47:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj2gpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 13:47:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PDlXWv38797626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:47:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F3A642042;
        Mon, 25 Apr 2022 13:47:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 496274203F;
        Mon, 25 Apr 2022 13:47:32 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.10.176])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 13:47:32 +0000 (GMT)
Date:   Mon, 25 Apr 2022 15:47:01 +0200
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
Subject: Re: [PATCH v2 2/2] KVM: s390: selftest: Test suppression indication
 on key prot exception
Message-ID: <20220425154701.79ad65c1@p-imbrenda>
In-Reply-To: <20220425100147.1755340-3-scgl@linux.ibm.com>
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
        <20220425100147.1755340-3-scgl@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ZDPBwRGp98_8YlkNMOtrmETZXvIdBGb
X-Proofpoint-GUID: bfEkaebAHmyK2Z7PuuBoytRsbAbLXVCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Apr 2022 12:01:47 +0200
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> Check that suppression is not indicated on injection of a key checked
> protection exception caused by a memop after it already modified guest
> memory, as that violates the definition of suppression.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 43 ++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index b04c2c1b3c30..ce176ad9f216 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -194,6 +194,7 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
>  #define SIDA_OFFSET(o) ._sida_offset = 1, .sida_offset = (o)
>  #define AR(a) ._ar = 1, .ar = (a)
>  #define KEY(a) .f_key = 1, .key = (a)
> +#define INJECT .f_inject = 1
>  
>  #define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
>  
> @@ -430,9 +431,18 @@ static void test_copy_key_fetch_prot(void)
>  	TEST_ASSERT(rv == 4, "Should result in protection exception");		\
>  })
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
>  static void test_errors_key(void)
>  {
> -	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
> +	struct test_default t = test_default_init(guest_error_key);
>  
>  	HOST_SYNC(t.vcpu, STAGE_INITED);
>  	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
> @@ -446,6 +456,36 @@ static void test_errors_key(void)
>  	kvm_vm_free(t.kvm_vm);
>  }
>  
> +static void test_termination(void)
> +{
> +	struct test_default t = test_default_init(guest_error_key);
> +	uint64_t prefix;
> +	uint64_t teid;
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
> +	ASSERT_EQ(teid & 0x4c, 0);
> +
> +	kvm_vm_free(t.kvm_vm);
> +}
> +
>  static void test_errors_key_storage_prot_override(void)
>  {
>  	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
> @@ -668,6 +708,7 @@ int main(int argc, char *argv[])
>  		test_copy_key_fetch_prot();
>  		test_copy_key_fetch_prot_override();
>  		test_errors_key();
> +		test_termination();
>  		test_errors_key_storage_prot_override();
>  		test_errors_key_fetch_prot_override_not_enabled();
>  		test_errors_key_fetch_prot_override_enabled();

