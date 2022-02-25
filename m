Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17694C49B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiBYPyM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 10:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242420AbiBYPyH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 10:54:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2971D8311;
        Fri, 25 Feb 2022 07:53:30 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PFCjZ3015184;
        Fri, 25 Feb 2022 15:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZXlEPVSrcxAuLmBaIPm0pgN3ZOelJ7/EEzrXvi7w0S4=;
 b=G+Aj/NmQeGDgmU8onHdYhXGkZzB9t7o82p2p6BrUvcGwZQTohiYGfNh7i61SzcraEX+0
 dVpxZEMT4hEUAcGlKzSm5+ReSAfr24IOh9DLefYIMeoFNhNvTa9sOsXB63dUbOu2X4Wp
 tltl9Uq14yph/cp8+bBzZL8uL7vVxvaKl2zHOhFWEJ75wXiUDzYYi+rOrzcmsGR/2igJ
 UF0oYW2tDzlGQGA5wJBKqDSqAbtJOV7FvEfPzhnYqaWf3BPZsnzOQNbb5jPeaBsUYMyY
 P01JDyxtNGvf/ATMNcpEtpnXJVjtLyMwVXyvWegJcJQUKMxFXAOmNIT7cLIqEZ0vjIRG wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef1jas6s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:22 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PFXWA8006802;
        Fri, 25 Feb 2022 15:53:22 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef1jas6r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:21 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PFqFTk026037;
        Fri, 25 Feb 2022 15:53:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3eeg2s5de8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PFrG9B41091492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:53:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4182DAE04D;
        Fri, 25 Feb 2022 15:53:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E96D7AE055;
        Fri, 25 Feb 2022 15:53:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 15:53:15 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] KVM: s390: selftests: Add more copy memop tests
Date:   Fri, 25 Feb 2022 16:53:10 +0100
Message-Id: <20220225155311.3540514-5-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225155311.3540514-1-scgl@linux.ibm.com>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220225155311.3540514-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1l08oOhYSW8l4Rab37gkpfVx1R5inNH7
X-Proofpoint-ORIG-GUID: 2VitRJjOre8AHrCB8u6zar5cz4UkuFx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_08,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Do not just test the actual copy, but also that success is indicated
when using the check only flag.
Add copy test with storage key checking enabled, including tests for
storage and fetch protection override.
These test cover both logical vcpu ioctls as well as absolute vm ioctls.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 243 ++++++++++++++++++++--
 1 file changed, 230 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index d01e48c7c5e8..088d1cc61709 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -195,13 +195,21 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
 #define AR(a) ._ar = 1, .ar = (a)
 #define KEY(a) .f_key = 1, .key = (a)
 
+#define CHECK_N_DO(f, ...) ({ f(__VA_ARGS__, CHECK_ONLY); f(__VA_ARGS__); })
+
 #define VCPU_ID 1
+#define PAGE_SHIFT 12
+#define PAGE_SIZE (1ULL << PAGE_SHIFT)
+#define PAGE_MASK (~(PAGE_SIZE - 1))
+#define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
+#define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
 
 static uint8_t mem1[65536];
 static uint8_t mem2[65536];
 
 struct test_default {
 	struct kvm_vm *kvm_vm;
+	struct test_vcpu vm;
 	struct test_vcpu vcpu;
 	struct kvm_run *run;
 	int size;
@@ -213,6 +221,7 @@ static struct test_default test_default_init(void *guest_code)
 
 	t.size = min((size_t)kvm_check_cap(KVM_CAP_S390_MEM_OP), sizeof(mem1));
 	t.kvm_vm = vm_create_default(VCPU_ID, 0, guest_code);
+	t.vm = (struct test_vcpu) { t.kvm_vm, VM_VCPU_ID };
 	t.vcpu = (struct test_vcpu) { t.kvm_vm, VCPU_ID };
 	t.run = vcpu_state(t.kvm_vm, VCPU_ID);
 	return t;
@@ -223,6 +232,8 @@ enum stage {
 	STAGE_INITED,
 	/* Guest did nothing */
 	STAGE_IDLED,
+	/* Guest set storage keys (specifics up to test case) */
+	STAGE_SKEYS_SET,
 	/* Guest copied memory (locations up to test case) */
 	STAGE_COPIED,
 };
@@ -239,6 +250,47 @@ enum stage {
 	ASSERT_EQ(uc.args[1], __stage);					\
 })									\
 
+static void prepare_mem12(void)
+{
+	int i;
+
+	for (i = 0; i < sizeof(mem1); i++)
+		mem1[i] = rand();
+	memset(mem2, 0xaa, sizeof(mem2));
+}
+
+#define ASSERT_MEM_EQ(p1, p2, size) \
+	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
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
+#define DEFAULT_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)		\
+({										\
+	struct test_vcpu __copy_cpu = (copy_cpu), __mop_cpu = (mop_cpu);	\
+	enum mop_target __target = (mop_target_p);				\
+	uint32_t __size = (size);						\
+										\
+	prepare_mem12();							\
+	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
+			GADDR_V(mem1));						\
+	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
+	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size, ##__VA_ARGS__);\
+	ASSERT_MEM_EQ(mem1, mem2, __size);					\
+})
+
 static void guest_copy(void)
 {
 	GUEST_SYNC(STAGE_INITED);
@@ -249,30 +301,186 @@ static void guest_copy(void)
 static void test_copy(void)
 {
 	struct test_default t = test_default_init(guest_copy);
-	int i;
 
-	for (i = 0; i < sizeof(mem1); i++)
-		mem1[i] = i * i + i;
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size);
+
+	kvm_vm_free(t.kvm_vm);
+}
+
+static void set_storage_key_range(void *addr, size_t len, uint8_t key)
+{
+	uintptr_t _addr, abs, i;
+	int not_mapped = 0;
+
+	_addr = (uintptr_t)addr;
+	for (i = _addr & PAGE_MASK; i < _addr + len; i += PAGE_SIZE) {
+		abs = i;
+		asm volatile (
+			       "lra	%[abs], 0(0,%[abs])\n"
+			"	jz	0f\n"
+			"	llill	%[not_mapped],1\n"
+			"	j	1f\n"
+			"0:	sske	%[key], %[abs]\n"
+			"1:"
+			: [abs] "+&a" (abs), [not_mapped] "+r" (not_mapped)
+			: [key] "r" (key)
+			: "cc"
+		);
+		GUEST_ASSERT_EQ(not_mapped, 0);
+	}
+}
+
+static void guest_copy_key(void)
+{
+	set_storage_key_range(mem1, sizeof(mem1), 0x90);
+	set_storage_key_range(mem2, sizeof(mem2), 0x90);
+	GUEST_SYNC(STAGE_SKEYS_SET);
+
+	for (;;) {
+		memcpy(&mem2, &mem1, sizeof(mem2));
+		GUEST_SYNC(STAGE_COPIED);
+	}
+}
+
+static void test_copy_key(void)
+{
+	struct test_default t = test_default_init(guest_copy_key);
+
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vm, no key */
+	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size);
+
+	/* vm/vcpu, machting key or key 0 */
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(0));
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(9));
+	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(0));
+	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, t.size, KEY(9));
+	/*
+	 * There used to be different code paths for key handling depending on
+	 * if the region crossed a page boundary.
+	 * There currently are not, but the more tests the merrier.
+	 */
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(0));
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, 1, KEY(9));
+	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(0));
+	DEFAULT_WRITE_READ(t.vcpu, t.vm, ABSOLUTE, 1, KEY(9));
+
+	/* vm/vcpu, mismatching keys on read, but no fetch protection */
+	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(2));
+	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem1), KEY(2));
+
+	kvm_vm_free(t.kvm_vm);
+}
+
+static void guest_copy_key_fetch_prot(void)
+{
+	/*
+	 * For some reason combining the first sync with override enablement
+	 * results in an exception when calling HOST_SYNC.
+	 */
+	GUEST_SYNC(STAGE_INITED);
+	/* Storage protection override applies to both store and fetch. */
+	set_storage_key_range(mem1, sizeof(mem1), 0x98);
+	set_storage_key_range(mem2, sizeof(mem2), 0x98);
+	GUEST_SYNC(STAGE_SKEYS_SET);
+
+	for (;;) {
+		memcpy(&mem2, &mem1, sizeof(mem2));
+		GUEST_SYNC(STAGE_COPIED);
+	}
+}
+
+static void test_copy_key_storage_prot_override(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
 
 	HOST_SYNC(t.vcpu, STAGE_INITED);
+	t.run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
+	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
 
-	/* Set the first array */
-	MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1));
+	/* vcpu, mismatching keys, storage protection override in effect */
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(2));
 
-	/* Let the guest code copy the first array to the second */
-	HOST_SYNC(t.vcpu, STAGE_COPIED);
+	kvm_vm_free(t.kvm_vm);
+}
 
-	memset(mem2, 0xaa, sizeof(mem2));
+static void test_copy_key_fetch_prot(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
 
-	/* Get the second array */
-	MOP(t.vcpu, LOGICAL, READ, mem2, t.size, GADDR_V(mem2));
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
 
-	TEST_ASSERT(!memcmp(mem1, mem2, t.size),
-		    "Memory contents do not match!");
+	/* vm/vcpu, matching key, fetch protection in effect */
+	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(9));
+	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem2), KEY(9));
 
 	kvm_vm_free(t.kvm_vm);
 }
 
+const uint64_t last_page_addr = -PAGE_SIZE;
+
+static void guest_copy_key_fetch_prot_override(void)
+{
+	int i;
+	char *page_0 = 0;
+
+	GUEST_SYNC(STAGE_INITED);
+	set_storage_key_range(0, PAGE_SIZE, 0x18);
+	set_storage_key_range((void *)last_page_addr, PAGE_SIZE, 0x0);
+	asm volatile ("sske %[key],%[addr]\n" :: [addr] "r"(0), [key] "r"(0x18) : "cc");
+	GUEST_SYNC(STAGE_SKEYS_SET);
+
+	for (;;) {
+		for (i = 0; i < PAGE_SIZE; i++)
+			page_0[i] = mem1[i];
+		GUEST_SYNC(STAGE_COPIED);
+	}
+}
+
+static void test_copy_key_fetch_prot_override(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot_override);
+	vm_vaddr_t guest_0_page, guest_last_page;
+
+	guest_0_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, 0);
+	guest_last_page = vm_vaddr_alloc(t.kvm_vm, PAGE_SIZE, last_page_addr);
+	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
+		print_skip("did not allocate guest pages at required positions");
+		goto out;
+	}
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	t.run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
+	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vcpu, mismatching keys on fetch, fetch protection override applies */
+	prepare_mem12();
+	MOP(t.vcpu, LOGICAL, WRITE, mem1, PAGE_SIZE, GADDR_V(mem1));
+	HOST_SYNC(t.vcpu, STAGE_COPIED);
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, 2048, GADDR_V(guest_0_page), KEY(2));
+	ASSERT_MEM_EQ(mem1, mem2, 2048);
+
+	/*
+	 * vcpu, mismatching keys on fetch, fetch protection override applies,
+	 * wraparound
+	 */
+	prepare_mem12();
+	MOP(t.vcpu, LOGICAL, WRITE, mem1, 2 * PAGE_SIZE, GADDR_V(guest_last_page));
+	HOST_SYNC(t.vcpu, STAGE_COPIED);
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048,
+			GADDR_V(guest_last_page), KEY(2));
+	ASSERT_MEM_EQ(mem1, mem2, 2048);
+
+out:
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void guest_idle(void)
 {
 	GUEST_SYNC(STAGE_INITED); /* for consistencies sake */
@@ -335,17 +543,26 @@ static void test_errors(void)
 
 int main(int argc, char *argv[])
 {
-	int memop_cap;
+	int memop_cap, extension_cap;
 
 	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
 
 	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
+	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
 	if (!memop_cap) {
 		print_skip("CAP_S390_MEM_OP not supported");
 		exit(KSFT_SKIP);
 	}
 
 	test_copy();
+	if (extension_cap > 0) {
+		test_copy_key();
+		test_copy_key_storage_prot_override();
+		test_copy_key_fetch_prot();
+		test_copy_key_fetch_prot_override();
+	} else {
+		print_skip("storage key memop extension not supported");
+	}
 	test_errors();
 
 	return 0;
-- 
2.32.0

