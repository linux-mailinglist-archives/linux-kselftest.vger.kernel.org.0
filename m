Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4763F565
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 17:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLAQjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 11:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiLAQjK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 11:39:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F299B78A;
        Thu,  1 Dec 2022 08:39:09 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1GP7Qk015109;
        Thu, 1 Dec 2022 16:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Sa1LChvHQ2k7u2Yx/whdyqREDbJzHoqzZDKK/r++r6M=;
 b=iN9KU7yrTYPAJpsblV2lVRwKDQ6oJRqX4JOvikUOxPZJfqYnDuDaY2tXR7HsAN69zOVp
 9/uG0F7uku/wZ4DJ8r+MYhiWpOUfqnpa4vmxJyUJDNs7/X7vVyMD35uoOHa0Fe/4F9tl
 8NuXAPf/LbP+h9Lm4t7xrdpT9sBkWZzN5v6Ysr4IRUezQ0FcuF7bYDxcVl7f9VOmLWj+
 XG3UbGx54RxDSYUQcpBddV52emnfE+f68SXBjZty2jVGP+xMKZDQSJuM0qlIx8XKHVds
 89Yki8ofnoOQbL61WbPl6sryCi3TiETr05Z1dqtI9j4bzUbwWR29YpDkUcXfr0Kc3hT6 qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ys7rbr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:39:03 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B1GQ3rD021645;
        Thu, 1 Dec 2022 16:39:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ys7rbq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:39:02 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1GcYEC010804;
        Thu, 1 Dec 2022 16:39:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3m3ae8wjm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:39:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B1GcvC97078614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Dec 2022 16:38:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EE41A405B;
        Thu,  1 Dec 2022 16:38:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB370A4054;
        Thu,  1 Dec 2022 16:38:56 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Dec 2022 16:38:56 +0000 (GMT)
Date:   Thu, 1 Dec 2022 17:28:13 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 4/9] KVM: s390: selftest: memop: Replace macros by
 functions
Message-ID: <20221201172813.027bcd13@p-imbrenda>
In-Reply-To: <20221117221758.66326-5-scgl@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
        <20221117221758.66326-5-scgl@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NiGTT1eKJg8ec_Bwv0LYuMlzyV7tfXm3
X-Proofpoint-ORIG-GUID: _3WG0nijUxGdbeeNL4jWPRdpe4MoqBM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_11,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 17 Nov 2022 23:17:53 +0100
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> Replace the DEFAULT_* test helpers by functions, as they don't
> need the exta flexibility.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 82 +++++++++++------------
>  1 file changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 69869c7e2ab1..286185a59238 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -48,6 +48,8 @@ struct mop_desc {
>  	uint8_t key;
>  };
>  
> +const uint8_t NO_KEY = 0xff;
> +
>  static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
>  {
>  	struct kvm_s390_mem_op ksmo = {
> @@ -85,7 +87,7 @@ static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
>  		ksmo.flags |= KVM_S390_MEMOP_F_INJECT_EXCEPTION;
>  	if (desc->_set_flags)
>  		ksmo.flags = desc->set_flags;
> -	if (desc->f_key) {
> +	if (desc->f_key && desc->key != NO_KEY) {

is this change going to affect the behaviour?
if so, please document it in the patch description

>  		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
>  		ksmo.key = desc->key;
>  	}
> @@ -268,34 +270,28 @@ static void prepare_mem12(void)
>  #define ASSERT_MEM_EQ(p1, p2, size) \
>  	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
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
>  static void guest_copy(void)
>  {
> @@ -310,7 +306,7 @@ static void test_copy(void)
>  
>  	HOST_SYNC(t.vcpu, STAGE_INITED);
>  
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size);
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, NO_KEY);
>  
>  	kvm_vm_free(t.kvm_vm);
>  }
> @@ -357,26 +353,26 @@ static void test_copy_key(void)
>  	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
>  
>  	/* vm, no key */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, NO_KEY);
>  
>  	/* vm/vcpu, machting key or key 0 */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(9));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(9));
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 0);
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 9);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, 0);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, t.size, 9);
>  	/*
>  	 * There used to be different code paths for key handling depending on
>  	 * if the region crossed a page boundary.
>  	 * There currently are not, but the more tests the merrier.
>  	 */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(9));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(0));
> -	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(9));
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, 1, 0);
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, 1, 9);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, 1, 0);
> +	default_write_read(t.vcpu, t.vm, ABSOLUTE, 1, 9);
>  
>  	/* vm/vcpu, mismatching keys on read, but no fetch protection */
> -	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(2));
> -	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem1), KEY(2));
> +	default_read(t.vcpu, t.vcpu, LOGICAL, t.size, 2);
> +	default_read(t.vcpu, t.vm, ABSOLUTE, t.size, 2);
>  
>  	kvm_vm_free(t.kvm_vm);
>  }
> @@ -409,7 +405,7 @@ static void test_copy_key_storage_prot_override(void)
>  	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
>  
>  	/* vcpu, mismatching keys, storage protection override in effect */
> -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(2));
> +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, 2);
>  
>  	kvm_vm_free(t.kvm_vm);
>  }
> @@ -422,8 +418,8 @@ static void test_copy_key_fetch_prot(void)
>  	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
>  
>  	/* vm/vcpu, matching key, fetch protection in effect */
> -	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(9));
> -	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem2), KEY(9));
> +	default_read(t.vcpu, t.vcpu, LOGICAL, t.size, 9);
> +	default_read(t.vcpu, t.vm, ABSOLUTE, t.size, 9);
>  
>  	kvm_vm_free(t.kvm_vm);
>  }

