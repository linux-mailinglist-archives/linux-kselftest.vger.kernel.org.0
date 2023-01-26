Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F6867CA62
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 13:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAZMBV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 07:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjAZMBV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 07:01:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FE62263;
        Thu, 26 Jan 2023 04:01:20 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QBSYd2019195;
        Thu, 26 Jan 2023 12:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Hvz+UF+L+DMyOFKaZrZpB1mZOmQVEMvu/YCePRO6nDU=;
 b=kWrKccPJ6JIFrvNxJzGVOTwGamRt2S60/7p2w8mq6NQ4rsSFz1I9u9kQ89RN6MElRMv5
 dIO0revap6Tm4M1QE4BJqCpsqLJgtvYo8J1GS97SZENT60nJw6QnMZYe4x2GkmIzQptf
 jVl+C8hI96YPyHe3lt2ZgQgc7Cggtj7P3+UedjE+VnANECoGxUeYzUx3YesAqooDppk6
 nLD9QjY8v+dmjcYZiOwzbTNGfjdG12KjIfJllBJ/nRsr1dVg8matbVA7HHtVyBg6TgwM
 ieD9oKBcgqNEa7n3XM1/A3YSdk86NC0jioFZ2gkBPXvFA0mXEgidif8GqH3NHlo92cpw kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbrp7rpm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 12:01:15 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QBTbk7023145;
        Thu, 26 Jan 2023 12:01:04 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbrp7rpd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 12:01:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QB1Hns014950;
        Thu, 26 Jan 2023 12:00:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afebhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 12:00:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QC0n8s40829278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 12:00:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 440EF2004B;
        Thu, 26 Jan 2023 12:00:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1E6120043;
        Thu, 26 Jan 2023 12:00:48 +0000 (GMT)
Received: from [9.152.224.253] (unknown [9.152.224.253])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 12:00:48 +0000 (GMT)
Message-ID: <147cbcff-b54c-90be-4bd0-6ac02f385528@linux.ibm.com>
Date:   Thu, 26 Jan 2023 13:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 02/14] KVM: s390: selftest: memop: Replace macros by
 functions
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
 <20230125212608.1860251-3-scgl@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230125212608.1860251-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d7Ydl6jYfw7oQVH94g-AP9onMQLGvPGJ
X-Proofpoint-ORIG-GUID: 3lFDC649xYe4shY4RQySOGtH2BU1GaVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_04,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301260116
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/25/23 22:25, Janis Schoetterl-Glausch wrote:
> Replace the DEFAULT_* test helpers by functions, as they don't
> need the exta flexibility.

s/exta/extra/

But if you want I can fix that up.

The __VA_ARGS__ often don't make it easier to understand therefore I'd 
rather have a function so I'm happy this patch removes a bit of the magic:

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 82 +++++++++++------------
>   1 file changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 9c05d1205114..df1c726294b2 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -48,6 +48,8 @@ struct mop_desc {
>   	uint8_t key;
>   };
>   
> +const uint8_t NO_KEY = 0xff;
> +
>   static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
>   {
>   	struct kvm_s390_mem_op ksmo = {
> @@ -85,7 +87,7 @@ static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
>   		ksmo.flags |= KVM_S390_MEMOP_F_INJECT_EXCEPTION;
>   	if (desc->_set_flags)
>   		ksmo.flags = desc->set_flags;
> -	if (desc->f_key) {
> +	if (desc->f_key && desc->key != NO_KEY) {
>   		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
>   		ksmo.key = desc->key;
>   	}
> @@ -268,34 +270,28 @@ static void prepare_mem12(void)
>   #define ASSERT_MEM_EQ(p1, p2, size) \
>   	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
>   
> -#define DEFAULT_WRITE_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)		\
> -({										\
> -	struct test_info __copy_cpu = (copy_cpu), __mop_cpu = (mop_cpu);	\
> -	enum mop_target __target = (mop_target_p);				\
> -	uint32_t __size = (size);						\
> -										\
> -	prepare_mem12();							\
> -	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
> -			GADDR_V(mem1), ##__VA_ARGS__);				\
> -	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
> -	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size,		\
> -			GADDR_V(mem2), ##__VA_ARGS__);				\
> -	ASSERT_MEM_EQ(mem1, mem2, __size);					\
> -})
> +static void default_write_read(struct test_info copy_cpu, struct test_info mop_cpu,
> +			       enum mop_target mop_target, uint32_t size, uint8_t key)
> +{
> +	prepare_mem12();
> +	CHECK_N_DO(MOP, mop_cpu, mop_target, WRITE, mem1, size,
> +		   GADDR_V(mem1), KEY(key));
> +	HOST_SYNC(copy_cpu, STAGE_COPIED);
> +	CHECK_N_DO(MOP, mop_cpu, mop_target, READ, mem2, size,
> +		   GADDR_V(mem2), KEY(key));
> +	ASSERT_MEM_EQ(mem1, mem2, size);
> +}
>   
> -#define DEFAULT_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)		\
> -({										\
> -	struct test_info __copy_cpu = (copy_cpu), __mop_cpu = (mop_cpu);	\
> -	enum mop_target __target = (mop_target_p);				\
> -	uint32_t __size = (size);						\
> -										\
> -	prepare_mem12();							\
> -	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
> -			GADDR_V(mem1));						\
> -	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
> -	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size, ##__VA_ARGS__);\
> -	ASSERT_MEM_EQ(mem1, mem2, __size);					\
> -})
> +static void default_read(struct test_info copy_cpu, struct test_info mop_cpu,
> +			 enum mop_target mop_target, uint32_t size, uint8_t key)
> +{
> +	prepare_mem12();
> +	CHECK_N_DO(MOP, mop_cpu, mop_target, WRITE, mem1, size, GADDR_V(mem1));
> +	HOST_SYNC(copy_cpu, STAGE_COPIED);
> +	CHECK_N_DO(MOP, mop_cpu, mop_target, READ, mem2, size,
> +		   GADDR_V(mem2), KEY(key));
> +	ASSERT_MEM_EQ(mem1, mem2, size);
> +}
>   
>   static void guest_copy(void)
>   {
> @@ -310,7 +306,7 @@ static void test_copy(void)
>   
>   	HOST_SYNC(t.vcpu, STAGE_INITED);
>   
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size);
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, NO_KEY);
>   
>   	kvm_vm_free(t.kvm_vm);
>   }
> @@ -357,26 +353,26 @@ static void test_copy_key(void)
>   	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
>   
>   	/* vm, no key */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, NO_KEY);
>   
>   	/* vm/vcpu, machting key or key 0 */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(9));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(9));
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 0);
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 9);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, 0);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, 9);
>   	/*
>   	 * There used to be different code paths for key handling depending on
>   	 * if the region crossed a page boundary.
>   	 * There currently are not, but the more tests the merrier.
>   	 */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(9));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(9));
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, 1, 0);
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, 1, 9);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, 1, 0);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, 1, 9);
>   
>   	/* vm/vcpu, mismatching keys on read, but no fetch protection */
> -	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(2));
> -	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem1), KEY(2));
> +	default_read(t.vcpu, t.vcpu, LOGICAL, t.size, 2);
> +	default_read(t.vcpu, t.vm, ABSOLUTE, t.size, 2);
>   
>   	kvm_vm_free(t.kvm_vm);
>   }
> @@ -409,7 +405,7 @@ static void test_copy_key_storage_prot_override(void)
>   	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
>   
>   	/* vcpu, mismatching keys, storage protection override in effect */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(2));
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 2);
>   
>   	kvm_vm_free(t.kvm_vm);
>   }
> @@ -422,8 +418,8 @@ static void test_copy_key_fetch_prot(void)
>   	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
>   
>   	/* vm/vcpu, matching key, fetch protection in effect */
> -	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(9));
> -	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem2), KEY(9));
> +	default_read(t.vcpu, t.vcpu, LOGICAL, t.size, 9);
> +	default_read(t.vcpu, t.vm, ABSOLUTE, t.size, 9);
>   
>   	kvm_vm_free(t.kvm_vm);
>   }

