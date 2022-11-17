Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65C62E83F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 23:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiKQWTw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 17:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiKQWTD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6FA898CE;
        Thu, 17 Nov 2022 14:18:19 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHM3xRg020482;
        Thu, 17 Nov 2022 22:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EMEh6zjm+yBYqhMuTSUoP/6jltijJapr73NkP2C9uFs=;
 b=sUxDZjSpjo5Uf0MpT+d2AkaBTEYp2KTOHtXP37TGL1on4C3ns3QGNmViibj1IWiPMkxE
 V79hWlEvHPkxYNZgqL3z+hDFPPfXCo3iRxxY4ynxHfTQfUzK4FNZcAYpa6WXChYPB7h2
 vGVAnTi3jHhgvhfo8i0nB71Svek8WaOLMlc+XTZ2yzJvAWdG+JpKyzo5mJzX4YA5esuu
 xTY4CmRVdRpyGEFCrVcs33ONNYiNmNwvt+Glwnk+Xvooo+zSLQeq/rJAOUyC5BqWCB20
 OZersMf0QSUv/R1IOTIq8di2Wg8JBy/sjfcNxk7bfcxo4WpEIKonRtlZahVg0+XWrrBu pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwtb0w2h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:15 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHMEd4k020007;
        Thu, 17 Nov 2022 22:18:14 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwtb0w2gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHM6Gv1012871;
        Thu, 17 Nov 2022 22:18:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kwthe05ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHMInNJ52298110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 22:18:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8C74A4051;
        Thu, 17 Nov 2022 22:18:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2431AA4053;
        Thu, 17 Nov 2022 22:18:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 22:18:09 +0000 (GMT)
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
Subject: [PATCH v3 6/9] KVM: s390: selftest: memop: Add cmpxchg tests
Date:   Thu, 17 Nov 2022 23:17:55 +0100
Message-Id: <20221117221758.66326-7-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117221758.66326-1-scgl@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hp8Q4vKKz-5_K6jL3IdfFNnPm2MEDiQB
X-Proofpoint-ORIG-GUID: MGQ1MD5KLnP5U2DxW26yszYFVRDlfCEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170157
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
 tools/testing/selftests/kvm/s390x/memop.c | 404 +++++++++++++++++++++-
 1 file changed, 390 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 10f34c629cac..269b181731c8 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <pthread.h>
 
 #include <linux/bits.h>
 
@@ -44,6 +45,8 @@ struct mop_desc {
 	enum mop_access_mode mode;
 	void *buf;
 	uint32_t sida_offset;
+	void *old;
+	bool *cmpxchg_success;
 	uint8_t ar;
 	uint8_t key;
 };
@@ -91,6 +94,10 @@ static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *desc)
 		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
 		ksmo.key = desc->key;
 	}
+	if (desc->old) {
+		ksmo.flags |= KVM_S390_MEMOP_F_CMPXCHG;
+		ksmo.old_p = (uint64_t)desc->old;
+	}
 	if (desc->_ar)
 		ksmo.ar = desc->ar;
 	else
@@ -136,35 +143,45 @@ static void print_memop(struct kvm_vcpu *vcpu, const struct kvm_s390_mem_op *ksm
 		printf("ABSOLUTE, WRITE, ");
 		break;
 	}
-	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u",
-	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key);
+	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u, old_p=%llx",
+	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key,
+	       ksmo->old_p);
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
+static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
+			   struct mop_desc *desc)
 {
 	struct kvm_vcpu *vcpu = info.vcpu;
 
 	if (!vcpu)
-		vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
+		return __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
 	else
-		vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
+		return __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
 }
 
-static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
+static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo,
+			struct mop_desc *desc)
 {
-	struct kvm_vcpu *vcpu = info.vcpu;
+	int r;
+
+	r = err_memop_ioctl(info, ksmo, desc);
+	if (ksmo->flags & KVM_S390_MEMOP_F_CMPXCHG) {
+		if (desc->cmpxchg_success)
+			*desc->cmpxchg_success = !r;
+		if (r == KVM_S390_MEMOP_R_NO_XCHG)
+			r = 0;
+	}
+	TEST_ASSERT(!r, __KVM_IOCTL_ERROR("KVM_S390_MEM_OP", r));
 
-	if (!vcpu)
-		return __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
-	else
-		return __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
 }
 
 #define MEMOP(err, info_p, mop_target_p, access_mode_p, buf_p, size_p, ...)	\
@@ -187,7 +204,7 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 	}									\
 	__ksmo = ksmo_from_desc(&__desc);					\
 	print_memop(__info.vcpu, &__ksmo);					\
-	err##memop_ioctl(__info, &__ksmo);					\
+	err##memop_ioctl(__info, &__ksmo, &__desc);				\
 })
 
 #define MOP(...) MEMOP(, __VA_ARGS__)
@@ -201,6 +218,8 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 #define AR(a) ._ar = 1, .ar = (a)
 #define KEY(a) .f_key = 1, .key = (a)
 #define INJECT .f_inject = 1
+#define CMPXCHG_OLD(o) .old = (o)
+#define CMPXCHG_SUCCESS(s) .cmpxchg_success = (s)
 
 #define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
 
@@ -210,8 +229,8 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 #define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
 #define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
 
-static uint8_t mem1[65536];
-static uint8_t mem2[65536];
+static uint8_t __aligned(PAGE_SIZE) mem1[65536];
+static uint8_t __aligned(PAGE_SIZE) mem2[65536];
 
 struct test_default {
 	struct kvm_vm *kvm_vm;
@@ -243,6 +262,8 @@ enum stage {
 	STAGE_SKEYS_SET,
 	/* Guest copied memory (locations up to test case) */
 	STAGE_COPIED,
+	/* End of guest code reached */
+	STAGE_DONE,
 };
 
 #define HOST_SYNC(info_p, stage)					\
@@ -254,6 +275,9 @@ enum stage {
 									\
 	vcpu_run(__vcpu);						\
 	get_ucall(__vcpu, &uc);						\
+	if (uc.cmd == UCALL_ABORT) {					\
+		REPORT_GUEST_ASSERT_2(uc, "hints: %lu, %lu");		\
+	}								\
 	ASSERT_EQ(uc.cmd, UCALL_SYNC);					\
 	ASSERT_EQ(uc.args[1], __stage);					\
 })									\
@@ -293,6 +317,44 @@ static void default_read(struct test_info copy_cpu, struct test_info mop_cpu,
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
@@ -377,6 +439,250 @@ static void test_copy_key(void)
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
+static __uint128_t cut_to_size(int size, __uint128_t val)
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
+static bool popcount_eq(__uint128_t a, __uint128_t b)
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
+static __uint128_t rotate(int size, __uint128_t val, int amount)
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
+static __uint128_t permutate_bits(bool guest, int i, int size, __uint128_t old)
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
+		__uint128_t new;
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
+static bool _cmpxchg(int size, void *target, __uint128_t *old_p, __uint128_t new)
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
+			__uint128_t old = *old_p;
+
+			asm volatile ("cdsg %[old],%[new],%[address]"
+			    : [old] "+d" (old),
+			      [address] "+Q" (*(__uint128_t *)(target))
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
+	__uint128_t old, new;
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
+static char *quad_to_char(__uint128_t *quad, int size)
+{
+	return ((char *)quad) + (sizeof(*quad) - size);
+}
+
+static void test_cmpxchg_key_concurrent(void)
+{
+	struct test_default t = test_default_init(guest_cmpxchg_key);
+	int size, offset;
+	__uint128_t old, new;
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
+	TEST_ASSERT(popcount_eq(*(__uint128_t *)mem1, *(__uint128_t *)mem2),
+		    "Must retain number of set bits");
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void guest_copy_key_fetch_prot(void)
 {
 	/*
@@ -457,6 +763,24 @@ static void test_errors_key(void)
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
+		__uint128_t old = 0;
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
@@ -690,6 +1014,38 @@ static void test_errors(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+static void test_errors_cmpxchg(void)
+{
+	struct test_default t = test_default_init(guest_idle);
+	__uint128_t old;
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
@@ -719,6 +1075,16 @@ int main(int argc, char *argv[])
 			.test = test_copy_key,
 			.requirements_met = extension_cap > 0,
 		},
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
 		{
 			.name = "copy with key storage protection override",
 			.test = test_copy_key_storage_prot_override,
@@ -739,6 +1105,16 @@ int main(int argc, char *argv[])
 			.test = test_errors_key,
 			.requirements_met = extension_cap > 0,
 		},
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
 		{
 			.name = "termination",
 			.test = test_termination,
-- 
2.34.1

