Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9275F147A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiI3VIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiI3VIN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 17:08:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4EB1B3A5E;
        Fri, 30 Sep 2022 14:08:10 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UIr5IN035923;
        Fri, 30 Sep 2022 21:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZJlYMaJkIlO2r0OfTwS+vxFdftL0mI33OELgTnE/xjA=;
 b=nhFdOT6GkEgriBW5YFnoYBo7EVfRzr/YX6dhF8UJS2cRUbiyXBoQgtX+WEGNXlZMnDh7
 VKiZN3aII3G46Wsu4n+U7LoSTg+fPp6VdgZzIMwqBYk5R5vQJ/Gu78hQL0f60WyPD/Cu
 Iu1hi7ja7UFlSQvBlDtPOpnyaQN3c0rz2qZ0DPq8vWvX0+kA17fromjIluekzyj9Kv1R
 K4RWzQi/EfKnNmpMqIuIo3i6vU/WcRFS+jxCNxxFDMbFvenxuDkpp1q73ldtHPGiNidr
 LZQSIMbqYHQefePveox2cbhYRQiRCDR8Lmv+TkdQothTEk42p29Iq84I0CVd0HJOvoB1 Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx64kkk6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:05 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UKwoSV020661;
        Fri, 30 Sep 2022 21:08:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx64kkk5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28UL5iGK010669;
        Fri, 30 Sep 2022 21:08:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapup8xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28UL7xN7852610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 21:08:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6959A4060;
        Fri, 30 Sep 2022 21:07:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B741A405F;
        Fri, 30 Sep 2022 21:07:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 21:07:59 +0000 (GMT)
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
Subject: [PATCH v1 7/9] KVM: s390: selftest: memop: Add cmpxchg tests
Date:   Fri, 30 Sep 2022 23:07:49 +0200
Message-Id: <20220930210751.225873-8-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930210751.225873-1-scgl@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ieHHm-IDjifZC7p8UVP1SdHppYOwigOH
X-Proofpoint-GUID: 7ExLXpj_MwVo1xWpuSRXNMR2OD1l4prV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test successful exchange, unsuccessful exchange, storage key protection
and invalid arguments.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 570 +++++++++++++++++++---
 1 file changed, 495 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 311cf7d33247..3a160ab0415b 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <pthread.h>
 
 #include <linux/bits.h>
 
@@ -44,10 +45,14 @@ struct mop_desc {
 	enum mop_access_mode mode;
 	void *buf;
 	uint32_t sida_offset;
+	void *old;
+	bool *cmpxchg_success;
 	uint8_t ar;
 	uint8_t key;
 };
 
+typedef unsigned __int128 uint128;
+
 const uint8_t NO_KEY = 0xff;
 
 static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
@@ -91,6 +96,26 @@ static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
 		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
 		ksmo.key = desc->key;
 	}
+	if (desc->old) {
+		ksmo.flags |= KVM_S390_MEMOP_F_CMPXCHG;
+		switch (ksmo.size) {
+		case 1:
+			ksmo.old[1] = *(uint8_t *)desc->old;
+			break;
+		case 2:
+			ksmo.old[1] = *(uint16_t *)desc->old;
+			break;
+		case 4:
+			ksmo.old[1] = *(uint32_t *)desc->old;
+			break;
+		case 8:
+			ksmo.old[1] = *(uint64_t *)desc->old;
+			break;
+		case 16:
+			memcpy(ksmo.old, desc->old, sizeof(ksmo.old));
+			break;
+		}
+	}
 	if (desc->_ar)
 		ksmo.ar = desc->ar;
 	else
@@ -101,6 +126,31 @@ static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
 	return ksmo;
 }
 
+static void cmpxchg_write_back(struct kvm_s390_mem_op *ksmo, struct mop_desc *desc)
+{
+	if (desc->old) {
+		switch (ksmo->size) {
+		case 1:
+			*(uint8_t *)desc->old = ksmo->old[1];
+			break;
+		case 2:
+			*(uint16_t *)desc->old = ksmo->old[1];
+			break;
+		case 4:
+			*(uint32_t *)desc->old = ksmo->old[1];
+			break;
+		case 8:
+			*(uint64_t *)desc->old = ksmo->old[1];
+			break;
+		case 16:
+			memcpy(desc->old, ksmo->old, sizeof(ksmo->old));
+			break;
+		}
+	}
+	if (desc->cmpxchg_success)
+		*desc->cmpxchg_success = !(ksmo->flags & KVM_S390_MEMOP_F_CMPXCHG);
+}
+
 struct test_info {
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
@@ -136,18 +186,22 @@ static void print_memop(struct kvm_vcpu *vcpu, const struct kvm_s390_mem_op *ksm
 		printf("ABSOLUTE, WRITE, ");
 		break;
 	}
-	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u",
-	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key);
+	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u, old[0]=%llu, old[1]=%llu",
+	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key,
+	       ksmo->old[0], ksmo->old[1]);
 	if (ksmo->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
 		printf(", CHECK_ONLY");
 	if (ksmo->flags & KVM_S390_MEMOP_F_INJECT_EXCEPTION)
 		printf(", INJECT_EXCEPTION");
 	if (ksmo->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION)
 		printf(", SKEY_PROTECTION");
+	if (ksmo->flags & KVM_S390_MEMOP_F_CMPXCHG)
+		printf(", CMPXCHG");
 	puts(")");
 }
 
-static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
+static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
+			struct mop_desc *desc)
 {
 	struct kvm_vcpu *vcpu = info.vcpu;
 
@@ -155,16 +209,21 @@ static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 		vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
 	else
 		vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
+	cmpxchg_write_back(ksmo, desc);
 }
 
-static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
+static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
+			   struct mop_desc *desc)
 {
 	struct kvm_vcpu *vcpu = info.vcpu;
+	int r;
 
 	if (!vcpu)
-		return __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
+		r = __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
 	else
-		return __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
+		r = __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
+	cmpxchg_write_back(ksmo, desc);
+	return r;
 }
 
 #define MEMOP(err, info_p, mop_target_p, access_mode_p, buf_p, size_p, ...)	\
@@ -187,7 +246,7 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 	}									\
 	__ksmo = ksmo_from_desc(&__desc);					\
 	print_memop(__info.vcpu, &__ksmo);					\
-	err##memop_ioctl(__info, &__ksmo);					\
+	err##memop_ioctl(__info, &__ksmo, &__desc);				\
 })
 
 #define MOP(...) MEMOP(, __VA_ARGS__)
@@ -201,6 +260,8 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 #define AR(a) ._ar = 1, .ar = (a)
 #define KEY(a) .f_key = 1, .key = (a)
 #define INJECT .f_inject = 1
+#define CMPXCHG_OLD(o) .old = (o)
+#define CMPXCHG_SUCCESS(s) .cmpxchg_success = (s)
 
 #define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
 
@@ -210,8 +271,8 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 #define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
 #define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
 
-static uint8_t mem1[65536];
-static uint8_t mem2[65536];
+static uint8_t __aligned(PAGE_SIZE) mem1[65536];
+static uint8_t __aligned(PAGE_SIZE) mem2[65536];
 
 struct test_default {
 	struct kvm_vm *kvm_vm;
@@ -243,6 +304,8 @@ enum stage {
 	STAGE_SKEYS_SET,
 	/* Guest copied memory (locations up to test case) */
 	STAGE_COPIED,
+	/* End of guest code reached */
+	STAGE_DONE,
 };
 
 #define HOST_SYNC(info_p, stage)					\
@@ -254,6 +317,11 @@ enum stage {
 									\
 	vcpu_run(__vcpu);						\
 	get_ucall(__vcpu, &uc);						\
+	if (uc.cmd == UCALL_ABORT) {					\
+		TEST_FAIL("line %lu: %s, hints: %lu, %lu",		\
+			  uc.args[1], (const char *)uc.args[0],		\
+			  uc.args[2], uc.args[3]);			\
+	}								\
 	ASSERT_EQ(uc.cmd, UCALL_SYNC);					\
 	ASSERT_EQ(uc.args[1], __stage);					\
 })									\
@@ -293,6 +361,44 @@ static void default_read(struct test_info copy_cpu, struct test_info mop_cpu,
 	ASSERT_MEM_EQ(mem1, mem2, size);
 }
 
+static void default_cmpxchg(struct test_default *test, uint8_t key)
+{
+	for (int size = 1; size <= 16; size *= 2) {
+		for (int offset = 0; offset < 16; offset += size) {
+			uint8_t __aligned(16) new[16] = {};
+			uint8_t __aligned(16) old[16];
+			bool succ;
+
+			prepare_mem12();
+			default_write_read(test->vcpu, test->vcpu, LOGICAL, 16, NO_KEY);
+
+			memcpy(&old, mem1, 16);
+			CHECK_N_DO(MOP, test->vm, ABSOLUTE, WRITE, new + offset,
+				   size, GADDR_V(mem1 + offset),
+				   CMPXCHG_OLD(old + offset),
+				   CMPXCHG_SUCCESS(&succ), KEY(key));
+			HOST_SYNC(test->vcpu, STAGE_COPIED);
+			MOP(test->vm, ABSOLUTE, READ, mem2, 16, GADDR_V(mem2));
+			TEST_ASSERT(succ, "exchange of values should succeed");
+			memcpy(mem1 + offset, new + offset, size);
+			ASSERT_MEM_EQ(mem1, mem2, 16);
+
+			memcpy(&old, mem1, 16);
+			new[offset]++;
+			old[offset]++;
+			CHECK_N_DO(MOP, test->vm, ABSOLUTE, WRITE, new + offset,
+				   size, GADDR_V(mem1 + offset),
+				   CMPXCHG_OLD(old + offset),
+				   CMPXCHG_SUCCESS(&succ), KEY(key));
+			HOST_SYNC(test->vcpu, STAGE_COPIED);
+			MOP(test->vm, ABSOLUTE, READ, mem2, 16, GADDR_V(mem2));
+			TEST_ASSERT(!succ, "exchange of values should not succeed");
+			ASSERT_MEM_EQ(mem1, mem2, 16);
+			ASSERT_MEM_EQ(&old, mem1, 16);
+		}
+	}
+}
+
 static void guest_copy(void)
 {
 	GUEST_SYNC(STAGE_INITED);
@@ -377,6 +483,250 @@ static void test_copy_key(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+static void test_cmpxchg_key(void)
+{
+	struct test_default t = test_default_init(guest_copy_key);
+
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	default_cmpxchg(&t, NO_KEY);
+	default_cmpxchg(&t, 0);
+	default_cmpxchg(&t, 9);
+
+	kvm_vm_free(t.kvm_vm);
+}
+
+static uint128 cut_to_size(int size, uint128 val)
+{
+	switch (size) {
+	case 1:
+		return (uint8_t)val;
+	case 2:
+		return (uint16_t)val;
+	case 4:
+		return (uint32_t)val;
+	case 8:
+		return (uint64_t)val;
+	case 16:
+		return val;
+	}
+	GUEST_ASSERT_1(false, "Invalid size");
+	return 0;
+}
+
+static bool popcount_eq(uint128 a, uint128 b)
+{
+	unsigned int count_a, count_b;
+
+	count_a = __builtin_popcountl((uint64_t)(a >> 64)) +
+		  __builtin_popcountl((uint64_t)a);
+	count_b = __builtin_popcountl((uint64_t)(b >> 64)) +
+		  __builtin_popcountl((uint64_t)b);
+	return count_a == count_b;
+}
+
+static uint128 rotate(int size, uint128 val, int amount)
+{
+	unsigned int bits = size * 8;
+
+	amount = (amount + bits) % bits;
+	val = cut_to_size(size, val);
+	return (val << (bits - amount)) | (val >> amount);
+}
+
+const unsigned int max_block = 16;
+
+static void choose_block(bool guest, int i, int *size, int *offset)
+{
+	unsigned int rand;
+
+	rand = i;
+	if (guest) {
+		rand = rand * 19 + 11;
+		*size = 1 << ((rand % 3) + 2);
+		rand = rand * 19 + 11;
+		*offset = (rand % max_block) & ~(*size - 1);
+	} else {
+		rand = rand * 17 + 5;
+		*size = 1 << (rand % 5);
+		rand = rand * 17 + 5;
+		*offset = (rand % max_block) & ~(*size - 1);
+	}
+}
+
+static uint128 permutate_bits(bool guest, int i, int size, uint128 old)
+{
+	unsigned int rand;
+	bool swap;
+
+	rand = i;
+	rand = rand * 3 + 1;
+	if (guest)
+		rand = rand * 3 + 1;
+	swap = rand % 2 == 0;
+	if (swap) {
+		int i, j;
+		uint128 new;
+		uint8_t byte0, byte1;
+
+		rand = rand * 3 + 1;
+		i = rand % size;
+		rand = rand * 3 + 1;
+		j = rand % size;
+		if (i == j)
+			return old;
+		new = rotate(16, old, i * 8);
+		byte0 = new & 0xff;
+		new &= ~0xff;
+		new = rotate(16, new, -i * 8);
+		new = rotate(16, new, j * 8);
+		byte1 = new & 0xff;
+		new = (new & ~0xff) | byte0;
+		new = rotate(16, new, -j * 8);
+		new = rotate(16, new, i * 8);
+		new = new | byte1;
+		new = rotate(16, new, -i * 8);
+		return new;
+	} else {
+		int amount;
+
+		rand = rand * 3 + 1;
+		amount = rand % (size * 8);
+		return rotate(size, old, amount);
+	}
+}
+
+static bool _cmpxchg(int size, void *target, uint128 *old_p, uint128 new)
+{
+	bool ret;
+
+	switch (size) {
+	case 4: {
+			uint32_t old = *old_p;
+
+			asm volatile ("cs %[old],%[new],%[address]"
+			    : [old] "+d" (old),
+			      [address] "+Q" (*(uint32_t *)(target))
+			    : [new] "d" ((uint32_t)new)
+			    : "cc"
+			);
+			ret = old == (uint32_t)*old_p;
+			*old_p = old;
+			return ret;
+		}
+	case 8: {
+			uint64_t old = *old_p;
+
+			asm volatile ("csg %[old],%[new],%[address]"
+			    : [old] "+d" (old),
+			      [address] "+Q" (*(uint64_t *)(target))
+			    : [new] "d" ((uint64_t)new)
+			    : "cc"
+			);
+			ret = old == (uint64_t)*old_p;
+			*old_p = old;
+			return ret;
+		}
+	case 16: {
+			uint128 old = *old_p;
+
+			asm volatile ("cdsg %[old],%[new],%[address]"
+			    : [old] "+d" (old),
+			      [address] "+Q" (*(uint128 *)(target))
+			    : [new] "d" (new)
+			    : "cc"
+			);
+			ret = old == *old_p;
+			*old_p = old;
+			return ret;
+		}
+	}
+	GUEST_ASSERT_1(false, "Invalid size");
+	return 0;
+}
+
+const unsigned int cmpxchg_iter_outer = 100, cmpxchg_iter_inner = 10000;
+
+static void guest_cmpxchg_key(void)
+{
+	int size, offset;
+	uint128 old, new;
+
+	set_storage_key_range(mem1, max_block, 0x10);
+	set_storage_key_range(mem2, max_block, 0x10);
+	GUEST_SYNC(STAGE_SKEYS_SET);
+
+	for (int i = 0; i < cmpxchg_iter_outer; i++) {
+		do {
+			old = 1;
+		} while (!_cmpxchg(16, mem1, &old, 0));
+		for (int j = 0; j < cmpxchg_iter_inner; j++) {
+			choose_block(true, i + j, &size, &offset);
+			do {
+				new = permutate_bits(true, i + j, size, old);
+			} while (!_cmpxchg(size, mem2 + offset, &old, new));
+		}
+	}
+
+	GUEST_SYNC(STAGE_DONE);
+}
+
+static void *run_guest(void *data)
+{
+	struct test_info *info = data;
+
+	HOST_SYNC(*info, STAGE_DONE);
+	return NULL;
+}
+
+static char *quad_to_char(uint128 *quad, int size)
+{
+	return ((char *)quad) + (sizeof(*quad) - size);
+}
+
+static void test_cmpxchg_key_concurrent(void)
+{
+	struct test_default t = test_default_init(guest_cmpxchg_key);
+	int size, offset;
+	uint128 old, new;
+	bool success;
+	pthread_t thread;
+
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+	prepare_mem12();
+	MOP(t.vcpu, LOGICAL, WRITE, mem1, max_block, GADDR_V(mem2));
+	pthread_create(&thread, NULL, run_guest, &t.vcpu);
+
+	for (int i = 0; i < cmpxchg_iter_outer; i++) {
+		do {
+			old = 0;
+			new = 1;
+			MOP(t.vm, ABSOLUTE, WRITE, &new,
+			    sizeof(new), GADDR_V(mem1),
+			    CMPXCHG_OLD(&old),
+			    CMPXCHG_SUCCESS(&success), KEY(1));
+		} while (!success);
+		for (int j = 0; j < cmpxchg_iter_inner; j++) {
+			choose_block(false, i + j, &size, &offset);
+			do {
+				new = permutate_bits(false, i + j, size, old);
+				MOP(t.vm, ABSOLUTE, WRITE, quad_to_char(&new, size),
+				    size, GADDR_V(mem2 + offset),
+				    CMPXCHG_OLD(quad_to_char(&old, size)),
+				    CMPXCHG_SUCCESS(&success), KEY(1));
+			} while (!success);
+		}
+	}
+
+	pthread_join(thread, NULL);
+
+	MOP(t.vcpu, LOGICAL, READ, mem2, max_block, GADDR_V(mem2));
+	TEST_ASSERT(popcount_eq(*(uint128 *)mem1, *(uint128 *)mem2),
+		    "Must retain number of set bits");
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void guest_copy_key_fetch_prot(void)
 {
 	/*
@@ -457,6 +807,24 @@ static void test_errors_key(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+static void test_errors_cmpxchg_key(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
+	int i;
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	for (i = 1; i <= 16; i *= 2) {
+		uint128 old = 0;
+
+		CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem2, i, GADDR_V(mem2),
+			   CMPXCHG_OLD(&old), KEY(2));
+	}
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void test_termination(void)
 {
 	struct test_default t = test_default_init(guest_error_key);
@@ -692,87 +1060,139 @@ static void test_errors(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
-struct testdef {
-	const char *name;
-	void (*test)(void);
-	int extension;
-} testlist[] = {
-	{
-		.name = "simple copy",
-		.test = test_copy,
-	},
-	{
-		.name = "generic error checks",
-		.test = test_errors,
-	},
-	{
-		.name = "copy with storage keys",
-		.test = test_copy_key,
-		.extension = 1,
-	},
-	{
-		.name = "copy with key storage protection override",
-		.test = test_copy_key_storage_prot_override,
-		.extension = 1,
-	},
-	{
-		.name = "copy with key fetch protection",
-		.test = test_copy_key_fetch_prot,
-		.extension = 1,
-	},
-	{
-		.name = "copy with key fetch protection override",
-		.test = test_copy_key_fetch_prot_override,
-		.extension = 1,
-	},
-	{
-		.name = "error checks with key",
-		.test = test_errors_key,
-		.extension = 1,
-	},
-	{
-		.name = "termination",
-		.test = test_termination,
-		.extension = 1,
-	},
-	{
-		.name = "error checks with key storage protection override",
-		.test = test_errors_key_storage_prot_override,
-		.extension = 1,
-	},
-	{
-		.name = "error checks without key fetch prot override",
-		.test = test_errors_key_fetch_prot_override_not_enabled,
-		.extension = 1,
-	},
-	{
-		.name = "error checks with key fetch prot override",
-		.test = test_errors_key_fetch_prot_override_enabled,
-		.extension = 1,
-	},
-};
+static void test_errors_cmpxchg(void)
+{
+	struct test_default t = test_default_init(guest_idle);
+	uint128 old;
+	int rv, i, power = 1;
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	for (i = 0; i < 32; i++) {
+		if (i == power) {
+			power *= 2;
+			continue;
+		}
+		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR_V(mem1),
+			     CMPXCHG_OLD(&old));
+		TEST_ASSERT(rv == -1 && errno == EINVAL,
+			    "ioctl allows bad size for cmpxchg");
+	}
+	for (i = 1; i <= 16; i *= 2) {
+		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR((void *)~0xfffUL),
+			     CMPXCHG_OLD(&old));
+		TEST_ASSERT(rv > 0, "ioctl allows bad guest address for cmpxchg");
+	}
+	for (i = 2; i <= 16; i *= 2) {
+		rv = ERR_MOP(t.vm, ABSOLUTE, WRITE, mem1, i, GADDR_V(mem1 + 1),
+			     CMPXCHG_OLD(&old));
+		TEST_ASSERT(rv == -1 && errno == EINVAL,
+			    "ioctl allows bad alignment for cmpxchg");
+	}
+
+	kvm_vm_free(t.kvm_vm);
+}
 
 int main(int argc, char *argv[])
 {
 	int extension_cap, idx;
 
+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
+	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
 
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+	struct testdef {
+		const char *name;
+		void (*test)(void);
+		bool requirements_met;
+	} testlist[] = {
+		{
+			.name = "simple copy",
+			.test = test_copy,
+			.requirements_met = true,
+		},
+		{
+			.name = "generic error checks",
+			.test = test_errors,
+			.requirements_met = true,
+		},
+		{
+			.name = "copy with storage keys",
+			.test = test_copy_key,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "cmpxchg with storage keys",
+			.test = test_cmpxchg_key,
+			.requirements_met = extension_cap & 0x2,
+		},
+		{
+			.name = "concurrently cmpxchg with storage keys",
+			.test = test_cmpxchg_key_concurrent,
+			.requirements_met = extension_cap & 0x2,
+		},
+		{
+			.name = "copy with key storage protection override",
+			.test = test_copy_key_storage_prot_override,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "copy with key fetch protection",
+			.test = test_copy_key_fetch_prot,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "copy with key fetch protection override",
+			.test = test_copy_key_fetch_prot_override,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks with key",
+			.test = test_errors_key,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks for cmpxchg with key",
+			.test = test_errors_cmpxchg_key,
+			.requirements_met = extension_cap & 0x2,
+		},
+		{
+			.name = "error checks for cmpxchg",
+			.test = test_errors_cmpxchg,
+			.requirements_met = extension_cap & 0x2,
+		},
+		{
+			.name = "termination",
+			.test = test_termination,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks with key storage protection override",
+			.test = test_errors_key_storage_prot_override,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks without key fetch prot override",
+			.test = test_errors_key_fetch_prot_override_not_enabled,
+			.requirements_met = extension_cap > 0,
+		},
+		{
+			.name = "error checks with key fetch prot override",
+			.test = test_errors_key_fetch_prot_override_enabled,
+			.requirements_met = extension_cap > 0,
+		},
+	};
 
 	ksft_print_header();
-
 	ksft_set_plan(ARRAY_SIZE(testlist));
 
-	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
 	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
-		if (extension_cap >= testlist[idx].extension) {
+		if (testlist[idx].requirements_met) {
 			testlist[idx].test();
 			ksft_test_result_pass("%s\n", testlist[idx].name);
 		} else {
-			ksft_test_result_skip("%s - extension level %d not supported\n",
-					      testlist[idx].name,
-					      testlist[idx].extension);
+			ksft_test_result_skip("%s - requirements not met (kernel has extension cap %#x\n)",
+					      testlist[idx].name, extension_cap);
 		}
 	}
 
-- 
2.34.1

