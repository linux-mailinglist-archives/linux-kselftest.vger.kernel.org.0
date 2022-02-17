Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E34BA3B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 15:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiBQOyE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 09:54:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiBQOyD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 09:54:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7D1F5C85;
        Thu, 17 Feb 2022 06:53:45 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HEg0Kg007867;
        Thu, 17 Feb 2022 14:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nTjmSmcIgtWfH3qy3Wj6c51ZZ0XKo2N3pXZlYHSqmBc=;
 b=Hvr6egCQHTxfhYQw8zEnOPFqSsZt0DldAGuufs82SNO8p+hl+dv61myaFvlZmffVR4lB
 ZAfy06QU2dVIPoDLwGnx+4MRfGe7i301ZB0/D+hhExbNF5aUdf/2f6ZSCxD4MvYrKem1
 cXI26r7bGq/DD5RoHEf173ErvxrpZ4N9Qm5t2yasen8AKb+aKQ9X6Zyyef8O/S/0TRxD
 ce6FllyEF/OMnizrbkR9PFdsOqtQUO38XxSiM7WbLR/Kawh8ytz52GqgyMjP8Yffz4XZ
 bxdcD5ljiFJPYX6go2vIQ2HXSfZG8HbaUPPJdrKpyEstFm+6UF6KG8vhG7Ch1fBLItfL 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9rbq888g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:53:45 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HEhOIQ014153;
        Thu, 17 Feb 2022 14:53:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9rbq887t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:53:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HEjV3x021986;
        Thu, 17 Feb 2022 14:53:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64hakf60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:53:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HErcA744826934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:53:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D50FC4C04E;
        Thu, 17 Feb 2022 14:53:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A9AD4C04A;
        Thu, 17 Feb 2022 14:53:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 14:53:38 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: s390: selftests: Refactor memop test
Date:   Thu, 17 Feb 2022 15:53:35 +0100
Message-Id: <20220217145336.1794778-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220217145336.1794778-1-scgl@linux.ibm.com>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PG9kKTB-GqxRnHsoZxh0ci-SwyP2S6cJ
X-Proofpoint-ORIG-GUID: w8-nEhpIDYsIPR-H0AAqJHr6oxna-mtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_05,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce macro for performing MEM_OP ioctls in a concise way.
Split test cases into multiple host/guest pairs making them independent.
Make various minor improvements.
All in all this lays the groundwork for future extensions.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 427 ++++++++++++++++------
 1 file changed, 309 insertions(+), 118 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index d19c3ffdea3f..4510418d73e6 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -13,169 +13,360 @@
 #include "test_util.h"
 #include "kvm_util.h"
 
+enum mop_target {
+	LOGICAL,
+	SIDA,
+	ABSOLUTE,
+	INVALID,
+};
+
+enum mop_access_mode {
+	READ,
+	WRITE,
+};
+
+struct mop_desc {
+	uintptr_t gaddr;
+	uintptr_t gaddr_v;
+	uint64_t set_flags;
+	unsigned int f_check : 1;
+	unsigned int f_inject : 1;
+	unsigned int f_key : 1;
+	unsigned int _gaddr_v : 1;
+	unsigned int _set_flags : 1;
+	unsigned int _sida_offset : 1;
+	unsigned int _ar : 1;
+	uint32_t size;
+	enum mop_target target;
+	enum mop_access_mode mode;
+	void *buf;
+	uint32_t sida_offset;
+	uint8_t ar;
+	uint8_t key;
+};
+
+static struct kvm_s390_mem_op ksmo_from_desc(struct mop_desc desc)
+{
+	struct kvm_s390_mem_op ksmo = {
+		.gaddr = (uintptr_t)desc.gaddr,
+		.size = desc.size,
+		.buf = ((uintptr_t)desc.buf),
+		.reserved = "ignored_ignored_ignored_ignored"
+	};
+
+	switch (desc.target) {
+	case LOGICAL:
+		if (desc.mode == READ)
+			ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
+		if (desc.mode == WRITE)
+			ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+		break;
+	case SIDA:
+		if (desc.mode == READ)
+			ksmo.op = KVM_S390_MEMOP_SIDA_READ;
+		if (desc.mode == WRITE)
+			ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
+		break;
+	case ABSOLUTE:
+		if (desc.mode == READ)
+			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_READ;
+		if (desc.mode == WRITE)
+			ksmo.op = KVM_S390_MEMOP_ABSOLUTE_WRITE;
+		break;
+	case INVALID:
+		ksmo.op = -1;
+	}
+	if (desc.f_check)
+		ksmo.flags |= KVM_S390_MEMOP_F_CHECK_ONLY;
+	if (desc.f_inject)
+		ksmo.flags |= KVM_S390_MEMOP_F_INJECT_EXCEPTION;
+	if (desc._set_flags)
+		ksmo.flags = desc.set_flags;
+	if (desc.f_key) {
+		ksmo.flags |= KVM_S390_MEMOP_F_SKEY_PROTECTION;
+		ksmo.key = desc.key;
+	}
+	if (desc._ar)
+		ksmo.ar = desc.ar;
+	else
+		ksmo.ar = 0;
+	if (desc._sida_offset)
+		ksmo.sida_offset = desc.sida_offset;
+
+	return ksmo;
+}
+
+/* vcpu dummy id signifying that vm instead of vcpu ioctl is to occur */
+const uint32_t VM_VCPU_ID = (uint32_t)-1;
+
+struct test_vcpu {
+	struct kvm_vm *vm;
+	uint32_t id;
+};
+
+#define PRINT_MEMOP false
+static void print_memop(uint32_t vcpu_id, const struct kvm_s390_mem_op *ksmo)
+{
+	if (!PRINT_MEMOP)
+		return;
+
+	if (vcpu_id == VM_VCPU_ID)
+		printf("vm memop(");
+	else
+		printf("vcpu memop(");
+	switch (ksmo->op) {
+	case KVM_S390_MEMOP_LOGICAL_READ:
+		printf("LOGICAL, READ, ");
+		break;
+	case KVM_S390_MEMOP_LOGICAL_WRITE:
+		printf("LOGICAL, WRITE, ");
+		break;
+	case KVM_S390_MEMOP_SIDA_READ:
+		printf("SIDA, READ, ");
+		break;
+	case KVM_S390_MEMOP_SIDA_WRITE:
+		printf("SIDA, WRITE, ");
+		break;
+	case KVM_S390_MEMOP_ABSOLUTE_READ:
+		printf("ABSOLUTE, READ, ");
+		break;
+	case KVM_S390_MEMOP_ABSOLUTE_WRITE:
+		printf("ABSOLUTE, WRITE, ");
+		break;
+	}
+	printf("gaddr=%llu, size=%u, buf=%llu, ar=%u, key=%u",
+	       ksmo->gaddr, ksmo->size, ksmo->buf, ksmo->ar, ksmo->key);
+	if (ksmo->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
+		printf(", CHECK_ONLY");
+	if (ksmo->flags & KVM_S390_MEMOP_F_INJECT_EXCEPTION)
+		printf(", INJECT_EXCEPTION");
+	if (ksmo->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION)
+		printf(", SKEY_PROTECTION");
+	puts(")");
+}
+
+static void memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
+{
+	if (vcpu.id == VM_VCPU_ID)
+		vm_ioctl(vcpu.vm, KVM_S390_MEM_OP, ksmo);
+	else
+		vcpu_ioctl(vcpu.vm, vcpu.id, KVM_S390_MEM_OP, ksmo);
+}
+
+static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
+{
+	if (vcpu.id == VM_VCPU_ID)
+		return _vm_ioctl(vcpu.vm, KVM_S390_MEM_OP, ksmo);
+	else
+		return _vcpu_ioctl(vcpu.vm, vcpu.id, KVM_S390_MEM_OP, ksmo);
+}
+
+#define MEMOP(err, vcpu_p, mop_target_p, access_mode_p, buf_p, size_p, ...)	\
+({										\
+	struct test_vcpu __vcpu = (vcpu_p);					\
+	struct mop_desc __desc = {						\
+		.target = (mop_target_p),					\
+		.mode = (access_mode_p),					\
+		.buf = (buf_p),							\
+		.size = (size_p),						\
+		__VA_ARGS__							\
+	};									\
+	struct kvm_s390_mem_op __ksmo;						\
+										\
+	if (__desc._gaddr_v) {							\
+		if (__desc.target == ABSOLUTE)					\
+			__desc.gaddr = addr_gva2gpa(__vcpu.vm, __desc.gaddr_v);	\
+		else								\
+			__desc.gaddr = __desc.gaddr_v;				\
+	}									\
+	__ksmo = ksmo_from_desc(__desc);					\
+	print_memop(__vcpu.id, &__ksmo);					\
+	err##memop_ioctl(__vcpu, &__ksmo);					\
+})
+
+#define MOP(...) MEMOP(, __VA_ARGS__)
+#define ERR_MOP(...) MEMOP(err_, __VA_ARGS__)
+
+#define GADDR(a) .gaddr = ((uintptr_t)a)
+#define GADDR_V(v) ._gaddr_v = 1, .gaddr_v = ((uintptr_t)v)
+#define CHECK_ONLY .f_check = 1
+#define SET_FLAGS(f) ._set_flags = 1, .set_flags = (f)
+#define SIDA_OFFSET(o) ._sida_offset = 1, .sida_offset = (o)
+#define AR(a) ._ar = 1, .ar = (a)
+#define KEY(a) .f_key = 1, .key = (a)
+
+#define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
+
 #define VCPU_ID 1
+#define PAGE_SHIFT 12
+#define PAGE_SIZE (1ULL << PAGE_SHIFT)
+#define PAGE_MASK (~(PAGE_SIZE - 1))
+
+#define ASSERT_MEM_EQ(p1, p2, size) \
+	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
 
 static uint8_t mem1[65536];
 static uint8_t mem2[65536];
 
-static void guest_code(void)
+static void prepare_mem12(void)
 {
 	int i;
 
-	for (;;) {
-		for (i = 0; i < sizeof(mem2); i++)
-			mem2[i] = mem1[i];
-		GUEST_SYNC(0);
-	}
+	for (i = 0; i < sizeof(mem1); i++)
+		mem1[i] = rand();
+	memset(mem2, 0xaa, sizeof(mem2));
 }
 
-int main(int argc, char *argv[])
-{
-	struct kvm_vm *vm;
+struct test_default {
+	struct test_vcpu vm;
+	struct test_vcpu vcpu;
 	struct kvm_run *run;
-	struct kvm_s390_mem_op ksmo;
-	int rv, i, maxsize;
+	int size;
+};
 
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+static struct test_default test_default_init(void *guest_code)
+{
+	struct test_default t;
 
-	maxsize = kvm_check_cap(KVM_CAP_S390_MEM_OP);
-	if (!maxsize) {
-		print_skip("CAP_S390_MEM_OP not supported");
-		exit(KSFT_SKIP);
-	}
-	if (maxsize > sizeof(mem1))
-		maxsize = sizeof(mem1);
+	t.size = min((size_t)kvm_check_cap(KVM_CAP_S390_MEM_OP), sizeof(mem1));
+	t.vm = (struct test_vcpu) { vm_create_default(VCPU_ID, 0, guest_code), VM_VCPU_ID };
+	t.vcpu = (struct test_vcpu) { t.vm.vm, VCPU_ID };
+	t.run = vcpu_state(t.vm.vm, VCPU_ID);
+	return t;
+}
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+static void test_vm_free(struct test_vcpu vm)
+{
+	kvm_vm_free(vm.vm);
+}
 
-	for (i = 0; i < sizeof(mem1); i++)
-		mem1[i] = i * i + i;
-
-	/* Set the first array */
-	ksmo.gaddr = addr_gva2gpa(vm, (uintptr_t)mem1);
-	ksmo.flags = 0;
-	ksmo.size = maxsize;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
-
-	/* Let the guest code copy the first array to the second */
-	vcpu_run(vm, VCPU_ID);
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
-		    "Unexpected exit reason: %u (%s)\n",
-		    run->exit_reason,
-		    exit_reason_str(run->exit_reason));
+#define HOST_SYNC(vcpu_p, stage)					\
+({									\
+	struct test_vcpu __vcpu = (vcpu_p);				\
+	struct ucall uc;						\
+	int __stage = (stage);						\
+									\
+	vcpu_run(__vcpu.vm, __vcpu.id);					\
+	get_ucall(__vcpu.vm, __vcpu.id, &uc);				\
+	ASSERT_EQ(uc.cmd, UCALL_SYNC);					\
+	ASSERT_EQ(uc.args[1], __stage);					\
+})									\
 
-	memset(mem2, 0xaa, sizeof(mem2));
+enum stage {
+	/* Synced state set by host, e.g. DAT */
+	STAGE_INITED,
+	/* Guest did nothing */
+	STAGE_IDLED,
+	/* Guest copied memory (locations up to test case) */
+	STAGE_COPIED,
+};
+
+#define DEFAULT_WRITE_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)		\
+({										\
+	struct test_vcpu __copy_cpu = (copy_cpu), __mop_cpu = (mop_cpu);	\
+	enum mop_target __target = (mop_target_p);				\
+	uint32_t __size = (size);						\
+										\
+	prepare_mem12();							\
+	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
+			GADDR_V(mem1), ##__VA_ARGS__);				\
+	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
+	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size,		\
+			GADDR_V(mem2), ##__VA_ARGS__);				\
+	ASSERT_MEM_EQ(mem1, mem2, __size);					\
+})
+
+static void guest_copy(void)
+{
+	GUEST_SYNC(STAGE_INITED);
+	memcpy(&mem2, &mem1, sizeof(mem2));
+	GUEST_SYNC(STAGE_COPIED);
+}
+
+static void test_copy(void)
+{
+	struct test_default t = test_default_init(guest_copy);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size);
+
+	test_vm_free(t.vm);
+}
 
-	/* Get the second array */
-	ksmo.gaddr = (uintptr_t)mem2;
-	ksmo.flags = 0;
-	ksmo.size = maxsize;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
-	ksmo.buf = (uintptr_t)mem2;
-	ksmo.ar = 0;
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
-
-	TEST_ASSERT(!memcmp(mem1, mem2, maxsize),
-		    "Memory contents do not match!");
-
-	/* Check error conditions - first bad size: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = -1;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+static void guest_idle(void)
+{
+	GUEST_SYNC(STAGE_INITED);
+	for (;;)
+		GUEST_SYNC(STAGE_IDLED);
+}
+
+static void test_errors(void)
+{
+	struct test_default t = test_default_init(guest_idle);
+	int rv;
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, -1, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
 
 	/* Zero size: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = 0;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, 0, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
 		    "ioctl allows 0 as size");
 
 	/* Bad flags: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = -1;
-	ksmo.size = maxsize;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), SET_FLAGS(-1));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
 
 	/* Bad operation: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = maxsize;
-	ksmo.op = -1;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, INVALID, WRITE, mem1, t.size, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
 
 	/* Bad guest address: */
-	ksmo.gaddr = ~0xfffUL;
-	ksmo.flags = KVM_S390_MEMOP_F_CHECK_ONLY;
-	ksmo.size = maxsize;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR((void *)~0xfffUL), CHECK_ONLY);
 	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
 
 	/* Bad host address: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = maxsize;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = 0;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, 0, t.size, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == EFAULT,
 		    "ioctl does not report bad host memory address");
 
 	/* Bad access register: */
-	run->psw_mask &= ~(3UL << (63 - 17));
-	run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
-	vcpu_run(vm, VCPU_ID);              /* To sync new state to SIE block */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = maxsize;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 17;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	t.run->psw_mask &= ~(3UL << (63 - 17));
+	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
+	HOST_SYNC(t.vcpu, STAGE_IDLED);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR(mem1), AR(17));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
-	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
-	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
+	t.run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
+	HOST_SYNC(t.vcpu, STAGE_IDLED);
 
 	/* Check that the SIDA calls are rejected for non-protected guests */
-	ksmo.gaddr = 0;
-	ksmo.flags = 0;
-	ksmo.size = 8;
-	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.sida_offset = 0x1c0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, SIDA, READ, mem1, 8, GADDR(0), SIDA_OFFSET(0x1c0));
 	TEST_ASSERT(rv == -1 && errno == EINVAL,
 		    "ioctl does not reject SIDA_READ in non-protected mode");
-	ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, SIDA, WRITE, mem1, 8, GADDR(0), SIDA_OFFSET(0x1c0));
 	TEST_ASSERT(rv == -1 && errno == EINVAL,
 		    "ioctl does not reject SIDA_WRITE in non-protected mode");
 
-	kvm_vm_free(vm);
+	test_vm_free(t.vm);
+}
+
+int main(int argc, char *argv[])
+{
+	int memop_cap;
+
+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+
+	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
+	if (!memop_cap) {
+		print_skip("CAP_S390_MEM_OP not supported");
+		exit(KSFT_SKIP);
+	}
+
+	test_copy();
+	test_errors();
 
 	return 0;
 }
-- 
2.32.0

