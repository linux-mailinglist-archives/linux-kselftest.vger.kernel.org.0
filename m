Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91462E81D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 23:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiKQWT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 17:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiKQWTC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5D898D6;
        Thu, 17 Nov 2022 14:18:17 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHM1CZZ005130;
        Thu, 17 Nov 2022 22:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jXuONbNOQbTjFW9mqrvksh8m0Hl68FBefYEPieEehMw=;
 b=plNA76LW0GbRP35ErLughzgJyVhCcK+ImS20BWQFXrTFWewDYY8+ri1+YcI90G2n6INB
 Phj8P1B1bOnGlnkCvYv8Wb5wohFTM/e/xHkUG0aOcCOzZMIS734icMTmsN1SJOqvM6nL
 zLXglhfNUuMlM/py7oqTB+dMDL5tYI7A/gLGapXCnCWZYZfIKLK+XVuH4nwnLq1LW8F1
 XRXcTaclIMKU0NLZ+Fas3/zOlDRySLTBpdvkYXMMVJTYC6klymrF9ltiLrt8rg/P74gO
 OvBAmuz5mgs9O+yo4usLmPO444U+FRR+mhDzoMVWqlK//1Wcj8SAx4SHYD+W/PMOk6j1 Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwwcggcm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:13 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHMFUSl026265;
        Thu, 17 Nov 2022 22:18:12 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwwcggck7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:12 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHM6hM9021297;
        Thu, 17 Nov 2022 22:18:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3kwrngg6qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHMI6Vl918056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 22:18:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E59A4051;
        Thu, 17 Nov 2022 22:18:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5DC9A4040;
        Thu, 17 Nov 2022 22:18:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 22:18:05 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 0/9] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Thu, 17 Nov 2022 23:17:49 +0100
Message-Id: <20221117221758.66326-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pb0PLufYnPHbQ7yD_EBoXfV7M2fMK20U
X-Proofpoint-GUID: 1NKUyDRbCmbZB1PQh0qzlfwTZYzoXPTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

User space can use the MEM_OP ioctl to make storage key checked reads
and writes to the guest, however, it has no way of performing atomic,
key checked, accesses to the guest.
Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
mode. For now, support this mode for absolute accesses only.

This mode can be use, for example, to set the device-state-change
indicator and the adapter-local-summary indicator atomically.

Also contains some fixes/changes for the memop selftest independent of
the cmpxchg changes.

v2 -> v3
 * rebase onto the wip/cmpxchg_user_key branch in the s390 kernel repo
 * use __uint128_t instead of unsigned __int128
 * put moving of testlist into main into separate patch
 * pick up R-b's (thanks Nico)

v1 -> v2
 * get rid of xrk instruction for cmpxchg byte and short implementation
 * pass old parameter via pointer instead of in mem_op struct
 * indicate failure of cmpxchg due to wrong old value by special return
   code
 * picked up R-b's (thanks Thomas)

Janis Schoetterl-Glausch (9):
  KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
  Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
  KVM: s390: selftest: memop: Pass mop_desc via pointer
  KVM: s390: selftest: memop: Replace macros by functions
  KVM: s390: selftest: memop: Move testlist into main
  KVM: s390: selftest: memop: Add cmpxchg tests
  KVM: s390: selftest: memop: Add bad address test
  KVM: s390: selftest: memop: Fix typo
  KVM: s390: selftest: memop: Fix wrong address being used in test

 Documentation/virt/kvm/api.rst            |  21 +-
 include/uapi/linux/kvm.h                  |   5 +
 arch/s390/kvm/gaccess.h                   |   3 +
 arch/s390/kvm/gaccess.c                   | 101 ++++
 arch/s390/kvm/kvm-s390.c                  |  35 +-
 tools/testing/selftests/kvm/s390x/memop.c | 670 +++++++++++++++++-----
 6 files changed, 683 insertions(+), 152 deletions(-)

Range-diff against v2:
 1:  c6731b0063ab !  1:  94820a73e9b0 KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
    @@ arch/s390/kvm/gaccess.h: int access_guest_with_key(struct kvm_vcpu *vcpu, unsign
      		      void *data, unsigned long len, enum gacc_mode mode);
      
     +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
    -+			       unsigned __int128 *old,
    -+			       unsigned __int128 new, u8 access_key);
    ++			       __uint128_t *old, __uint128_t new, u8 access_key);
     +
      /**
       * write_guest_with_key - copy data from kernel space to guest space
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     + *         * a program interruption code indicating the reason cmpxchg could
     + *           not be attempted
     + *         * -EINVAL: address misaligned or len not power of two
    ++ *         * -EAGAIN: transient failure (len 1 or 2)
     + */
     +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
    -+			       unsigned __int128 *old_p, unsigned __int128 new,
    ++			       __uint128_t *old_p, __uint128_t new,
     +			       u8 access_key)
     +{
     +	gfn_t gfn = gpa >> PAGE_SHIFT;
    @@ arch/s390/kvm/gaccess.c: int access_guest_real(struct kvm_vcpu *vcpu, unsigned l
     +		return -EOPNOTSUPP;
     +
     +	hva += offset_in_page(gpa);
    -+	ret = cmpxchg_user_key_size(len, (void __user *)hva, old_p, new, access_key);
    ++	switch (len) {
    ++	case 1: {
    ++		u8 old;
    ++
    ++		ret = cmpxchg_user_key((u8 *)hva, &old, *old_p, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_p;
    ++		*old_p = old;
    ++		break;
    ++	}
    ++	case 2: {
    ++		u16 old;
    ++
    ++		ret = cmpxchg_user_key((u16 *)hva, &old, *old_p, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_p;
    ++		*old_p = old;
    ++		break;
    ++	}
    ++	case 4: {
    ++		u32 old;
    ++
    ++		ret = cmpxchg_user_key((u32 *)hva, &old, *old_p, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_p;
    ++		*old_p = old;
    ++		break;
    ++	}
    ++	case 8: {
    ++		u64 old;
    ++
    ++		ret = cmpxchg_user_key((u64 *)hva, &old, *old_p, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_p;
    ++		*old_p = old;
    ++		break;
    ++	}
    ++	case 16: {
    ++		__uint128_t old;
    ++
    ++		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_p, new, access_key);
    ++		ret = ret < 0 ? ret : old != *old_p;
    ++		*old_p = old;
    ++		break;
    ++	}
    ++	default:
    ++		 return -EINVAL;
    ++	}
     +	mark_page_dirty_in_slot(kvm, slot, gfn);
     +	/*
     +	 * Assume that the fault is caused by protection, either key protection
    @@ arch/s390/kvm/kvm-s390.c: static bool access_key_invalid(u8 access_key)
      	void __user *uaddr = (void __user *)mop->buf;
     +	void __user *old_p = (void __user *)mop->old_p;
     +	union {
    -+		unsigned __int128 quad;
    -+		char raw[sizeof(unsigned __int128)];
    ++		__uint128_t quad;
    ++		char raw[sizeof(__uint128_t)];
     +	} old = { .quad = 0}, new = { .quad = 0 };
    -+	unsigned int off_in_quad = sizeof(unsigned __int128) - mop->size;
    ++	unsigned int off_in_quad = sizeof(__uint128_t) - mop->size;
      	u64 supported_flags;
      	void *tmpbuf = NULL;
      	int r, srcu_idx;
 2:  6cb32b244899 =  2:  28637a03f63e Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
 3:  5f1217ad9d31 =  3:  31f45e4377c5 KVM: s390: selftest: memop: Pass mop_desc via pointer
 4:  86a15b53846a =  4:  dba0a8ba3ba2 KVM: s390: selftest: memop: Replace macros by functions
 -:  ------------ >  5:  ba8cdd064c02 KVM: s390: selftest: memop: Move testlist into main
 5:  49e67d7559de !  6:  3cf7f710e5db KVM: s390: selftest: memop: Add cmpxchg tests
    @@ tools/testing/selftests/kvm/s390x/memop.c: struct mop_desc {
      	uint8_t ar;
      	uint8_t key;
      };
    - 
    -+typedef unsigned __int128 uint128;
    -+
    - const uint8_t NO_KEY = 0xff;
    - 
    - static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
     @@ tools/testing/selftests/kvm/s390x/memop.c: static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
      		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
      		ksmo.key = desc->key;
    @@ tools/testing/selftests/kvm/s390x/memop.c: enum stage {
      	vcpu_run(__vcpu);						\
      	get_ucall(__vcpu, &uc);						\
     +	if (uc.cmd == UCALL_ABORT) {					\
    -+		TEST_FAIL("line %lu: %s, hints: %lu, %lu",		\
    -+			  uc.args[1], (const char *)uc.args[0],		\
    -+			  uc.args[2], uc.args[3]);			\
    ++		REPORT_GUEST_ASSERT_2(uc, "hints: %lu, %lu");		\
     +	}								\
      	ASSERT_EQ(uc.cmd, UCALL_SYNC);					\
      	ASSERT_EQ(uc.args[1], __stage);					\
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	kvm_vm_free(t.kvm_vm);
     +}
     +
    -+static uint128 cut_to_size(int size, uint128 val)
    ++static __uint128_t cut_to_size(int size, __uint128_t val)
     +{
     +	switch (size) {
     +	case 1:
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	return 0;
     +}
     +
    -+static bool popcount_eq(uint128 a, uint128 b)
    ++static bool popcount_eq(__uint128_t a, __uint128_t b)
     +{
     +	unsigned int count_a, count_b;
     +
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	return count_a == count_b;
     +}
     +
    -+static uint128 rotate(int size, uint128 val, int amount)
    ++static __uint128_t rotate(int size, __uint128_t val, int amount)
     +{
     +	unsigned int bits = size * 8;
     +
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	}
     +}
     +
    -+static uint128 permutate_bits(bool guest, int i, int size, uint128 old)
    ++static __uint128_t permutate_bits(bool guest, int i, int size, __uint128_t old)
     +{
     +	unsigned int rand;
     +	bool swap;
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	swap = rand % 2 == 0;
     +	if (swap) {
     +		int i, j;
    -+		uint128 new;
    ++		__uint128_t new;
     +		uint8_t byte0, byte1;
     +
     +		rand = rand * 3 + 1;
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	}
     +}
     +
    -+static bool _cmpxchg(int size, void *target, uint128 *old_p, uint128 new)
    ++static bool _cmpxchg(int size, void *target, __uint128_t *old_p, __uint128_t new)
     +{
     +	bool ret;
     +
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +			return ret;
     +		}
     +	case 16: {
    -+			uint128 old = *old_p;
    ++			__uint128_t old = *old_p;
     +
     +			asm volatile ("cdsg %[old],%[new],%[address]"
     +			    : [old] "+d" (old),
    -+			      [address] "+Q" (*(uint128 *)(target))
    ++			      [address] "+Q" (*(__uint128_t *)(target))
     +			    : [new] "d" (new)
     +			    : "cc"
     +			);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +static void guest_cmpxchg_key(void)
     +{
     +	int size, offset;
    -+	uint128 old, new;
    ++	__uint128_t old, new;
     +
     +	set_storage_key_range(mem1, max_block, 0x10);
     +	set_storage_key_range(mem2, max_block, 0x10);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	return NULL;
     +}
     +
    -+static char *quad_to_char(uint128 *quad, int size)
    ++static char *quad_to_char(__uint128_t *quad, int size)
     +{
     +	return ((char *)quad) + (sizeof(*quad) - size);
     +}
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +{
     +	struct test_default t = test_default_init(guest_cmpxchg_key);
     +	int size, offset;
    -+	uint128 old, new;
    ++	__uint128_t old, new;
     +	bool success;
     +	pthread_t thread;
     +
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_copy_key(void)
     +	pthread_join(thread, NULL);
     +
     +	MOP(t.vcpu, LOGICAL, READ, mem2, max_block, GADDR_V(mem2));
    -+	TEST_ASSERT(popcount_eq(*(uint128 *)mem1, *(uint128 *)mem2),
    ++	TEST_ASSERT(popcount_eq(*(__uint128_t *)mem1, *(__uint128_t *)mem2),
     +		    "Must retain number of set bits");
     +
     +	kvm_vm_free(t.kvm_vm);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors_key(void)
     +	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
     +
     +	for (i = 1; i <= 16; i *= 2) {
    -+		uint128 old = 0;
    ++		__uint128_t old = 0;
     +
     +		CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem2, i, GADDR_V(mem2),
     +			   CMPXCHG_OLD(&old), KEY(2));
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
      	kvm_vm_free(t.kvm_vm);
      }
      
    --struct testdef {
    --	const char *name;
    --	void (*test)(void);
    --	int extension;
    --} testlist[] = {
    --	{
    --		.name = "simple copy",
    --		.test = test_copy,
    --	},
    --	{
    --		.name = "generic error checks",
    --		.test = test_errors,
    --	},
    --	{
    --		.name = "copy with storage keys",
    --		.test = test_copy_key,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "copy with key storage protection override",
    --		.test = test_copy_key_storage_prot_override,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "copy with key fetch protection",
    --		.test = test_copy_key_fetch_prot,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "copy with key fetch protection override",
    --		.test = test_copy_key_fetch_prot_override,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "error checks with key",
    --		.test = test_errors_key,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "termination",
    --		.test = test_termination,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "error checks with key storage protection override",
    --		.test = test_errors_key_storage_prot_override,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "error checks without key fetch prot override",
    --		.test = test_errors_key_fetch_prot_override_not_enabled,
    --		.extension = 1,
    --	},
    --	{
    --		.name = "error checks with key fetch prot override",
    --		.test = test_errors_key_fetch_prot_override_enabled,
    --		.extension = 1,
    --	},
    --};
     +static void test_errors_cmpxchg(void)
     +{
     +	struct test_default t = test_default_init(guest_idle);
    -+	uint128 old;
    ++	__uint128_t old;
     +	int rv, i, power = 1;
     +
     +	HOST_SYNC(t.vcpu, STAGE_INITED);
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
      
      int main(int argc, char *argv[])
      {
    - 	int extension_cap, idx;
    - 
    -+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
    - 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
    -+	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
    - 
    --	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
    -+	struct testdef {
    -+		const char *name;
    -+		void (*test)(void);
    -+		bool requirements_met;
    -+	} testlist[] = {
    -+		{
    -+			.name = "simple copy",
    -+			.test = test_copy,
    -+			.requirements_met = true,
    -+		},
    -+		{
    -+			.name = "generic error checks",
    -+			.test = test_errors,
    -+			.requirements_met = true,
    -+		},
    -+		{
    -+			.name = "copy with storage keys",
    -+			.test = test_copy_key,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    +@@ tools/testing/selftests/kvm/s390x/memop.c: int main(int argc, char *argv[])
    + 			.test = test_copy_key,
    + 			.requirements_met = extension_cap > 0,
    + 		},
     +		{
     +			.name = "cmpxchg with storage keys",
     +			.test = test_cmpxchg_key,
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
     +			.test = test_cmpxchg_key_concurrent,
     +			.requirements_met = extension_cap & 0x2,
     +		},
    -+		{
    -+			.name = "copy with key storage protection override",
    -+			.test = test_copy_key_storage_prot_override,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    -+		{
    -+			.name = "copy with key fetch protection",
    -+			.test = test_copy_key_fetch_prot,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    -+		{
    -+			.name = "copy with key fetch protection override",
    -+			.test = test_copy_key_fetch_prot_override,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    -+		{
    -+			.name = "error checks with key",
    -+			.test = test_errors_key,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    + 		{
    + 			.name = "copy with key storage protection override",
    + 			.test = test_copy_key_storage_prot_override,
    +@@ tools/testing/selftests/kvm/s390x/memop.c: int main(int argc, char *argv[])
    + 			.test = test_errors_key,
    + 			.requirements_met = extension_cap > 0,
    + 		},
     +		{
     +			.name = "error checks for cmpxchg with key",
     +			.test = test_errors_cmpxchg_key,
    @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors(void)
     +			.test = test_errors_cmpxchg,
     +			.requirements_met = extension_cap & 0x2,
     +		},
    -+		{
    -+			.name = "termination",
    -+			.test = test_termination,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    -+		{
    -+			.name = "error checks with key storage protection override",
    -+			.test = test_errors_key_storage_prot_override,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    -+		{
    -+			.name = "error checks without key fetch prot override",
    -+			.test = test_errors_key_fetch_prot_override_not_enabled,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    -+		{
    -+			.name = "error checks with key fetch prot override",
    -+			.test = test_errors_key_fetch_prot_override_enabled,
    -+			.requirements_met = extension_cap > 0,
    -+		},
    -+	};
    - 
    - 	ksft_print_header();
    --
    - 	ksft_set_plan(ARRAY_SIZE(testlist));
    - 
    --	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
    - 	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
    --		if (extension_cap >= testlist[idx].extension) {
    -+		if (testlist[idx].requirements_met) {
    - 			testlist[idx].test();
    - 			ksft_test_result_pass("%s\n", testlist[idx].name);
    - 		} else {
    --			ksft_test_result_skip("%s - extension level %d not supported\n",
    --					      testlist[idx].name,
    --					      testlist[idx].extension);
    -+			ksft_test_result_skip("%s - requirements not met (kernel has extension cap %#x\n)",
    -+					      testlist[idx].name, extension_cap);
    - 		}
    - 	}
    - 
    + 		{
    + 			.name = "termination",
    + 			.test = test_termination,
 6:  faad9cf03ea6 !  7:  d81d5697ba4b KVM: s390: selftest: memop: Add bad address test
    @@ Commit message
         Add test that tries to access, instead of CHECK_ONLY.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void _test_errors_common(struct test_info info, enum mop_target target, i
 7:  8070036aa89a !  8:  22c9cd9589ba KVM: s390: selftest: memop: Fix typo
    @@ Commit message
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
         Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors_key_fetch_prot_override_enabled(void)
 8:  18c423e4e3ad !  9:  4647be0790c8 KVM: s390: selftest: memop: Fix wrong address being used in test
    @@ Commit message
         protection exception the test codes needs to address mem1.
     
         Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    +    Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
     
      ## tools/testing/selftests/kvm/s390x/memop.c ##
     @@ tools/testing/selftests/kvm/s390x/memop.c: static void test_errors_key(void)

base-commit: b5b2a05e6de7b88bcfca9d4bbc8ac74e7db80c52
-- 
2.34.1

