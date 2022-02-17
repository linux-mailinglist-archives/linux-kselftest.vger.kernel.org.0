Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7A4BA3B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiBQOyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 09:54:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbiBQOyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 09:54:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818141F4678;
        Thu, 17 Feb 2022 06:53:45 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HElAP3013519;
        Thu, 17 Feb 2022 14:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JBzYUsoDJqyAEEpEi9/LjvkEBajjqj97iTMVtM3JcAk=;
 b=B25mx9TNAC4nvn9nQIWeXYciaiGYrch7TCNsYq1JUtA719iH2+sZ6HPrXI+6z0zvuuhx
 q4VrQT2pXy/P6tauQbYzpeSmtqQNSrxKpKx71i47HWuywsdUQePi+HQ5sYIcuAvnUM4i
 hAPtBt8SdiLfxGh5zMzLkV3C9WoRR3Yl7xQB2Mc1vs9zjT0EXFlfT8kGCC2Ri7sL0pyp
 qimKiqQaCCSpnPGFYgyinkt2IxNEr/WXcXFkKQ15C+Z7grulZU9pZ8wq2iKwed9f6ztz
 0IrEUpu38l0MVq7oh0E6phVAH/RImKOsSh+439YFYEf0/rsa+bPGVW425bg0wGgc9APi 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9reb84hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:53:44 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HElInR014027;
        Thu, 17 Feb 2022 14:53:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9reb84h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:53:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HEjSQ9021953;
        Thu, 17 Feb 2022 14:53:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64hakf61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:53:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HErdSK29163862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:53:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34DAB4C04A;
        Thu, 17 Feb 2022 14:53:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE244C052;
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
Subject: [PATCH 2/2] KVM: s390: selftests: Test vm and vcpu memop with keys
Date:   Thu, 17 Feb 2022 15:53:36 +0100
Message-Id: <20220217145336.1794778-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220217145336.1794778-1-scgl@linux.ibm.com>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JY9GzMPjno930pNy9lcHh25yzAu4GTvz
X-Proofpoint-GUID: rVbEwmsFIwHvynCKG5gazuIvKMG70r6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_05,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202170066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test storage key checking for both vm and vcpu MEM_OP ioctls.
Test both error and non error conditions.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 342 +++++++++++++++++++++-
 1 file changed, 328 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 4510418d73e6..bc12a9238967 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -201,6 +201,8 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
 #define PAGE_SHIFT 12
 #define PAGE_SIZE (1ULL << PAGE_SHIFT)
 #define PAGE_MASK (~(PAGE_SIZE - 1))
+#define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
+#define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
 
 #define ASSERT_MEM_EQ(p1, p2, size) \
 	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
@@ -235,6 +237,11 @@ static struct test_default test_default_init(void *guest_code)
 	return t;
 }
 
+static vm_vaddr_t test_vaddr_alloc(struct test_vcpu vm, size_t size, vm_vaddr_t vaddr_min)
+{
+	return vm_vaddr_alloc(vm.vm, size, vaddr_min);
+}
+
 static void test_vm_free(struct test_vcpu vm)
 {
 	kvm_vm_free(vm.vm);
@@ -257,6 +264,8 @@ enum stage {
 	STAGE_INITED,
 	/* Guest did nothing */
 	STAGE_IDLED,
+	/* Guest set storage keys (specifics up to test case) */
+	STAGE_SKEYS_SET,
 	/* Guest copied memory (locations up to test case) */
 	STAGE_COPIED,
 };
@@ -276,6 +285,20 @@ enum stage {
 	ASSERT_MEM_EQ(mem1, mem2, __size);					\
 })
 
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
@@ -294,6 +317,269 @@ static void test_copy(void)
 	test_vm_free(t.vm);
 }
 
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
+	test_vm_free(t.vm);
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
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	t.run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
+	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vcpu, mismatching keys, storage protection override in effect */
+	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size, KEY(2));
+
+	test_vm_free(t.vm);
+}
+
+static void test_copy_key_fetch_prot(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vm/vcpu, matching key, fetch protection in effect */
+	DEFAULT_READ(t.vcpu, t.vcpu, LOGICAL, t.size, GADDR_V(mem2), KEY(9));
+	DEFAULT_READ(t.vcpu, t.vm, ABSOLUTE, t.size, GADDR_V(mem2), KEY(9));
+
+	test_vm_free(t.vm);
+}
+
+#define ERR_PROT_MOP(...)							\
+({										\
+	int rv;									\
+										\
+	rv = ERR_MOP(__VA_ARGS__);						\
+	TEST_ASSERT(rv == 4, "Should result in protection exception");		\
+})
+
+static void test_errors_key(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vm/vcpu, mismatching keys, fetch protection in effect */
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+
+	test_vm_free(t.vm);
+}
+
+static void test_errors_key_storage_prot_override(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	t.run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
+	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vm, mismatching keys, storage protection override not applicable to vm */
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+
+	test_vm_free(t.vm);
+}
+
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
+	guest_0_page = test_vaddr_alloc(t.vm, PAGE_SIZE, 0);
+	guest_last_page = test_vaddr_alloc(t.vm, PAGE_SIZE, last_page_addr);
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
+	test_vm_free(t.vm);
+}
+
+static void test_errors_key_fetch_prot_override_not_enabled(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot_override);
+	vm_vaddr_t guest_0_page, guest_last_page;
+
+	guest_0_page = test_vaddr_alloc(t.vm, PAGE_SIZE, 0);
+	guest_last_page = test_vaddr_alloc(t.vm, PAGE_SIZE, last_page_addr);
+	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
+		print_skip("did not allocate guest pages at required positions");
+		goto out;
+	}
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/* vcpu, mismatching keys on fetch, fetch protection override not enabled */
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048, GADDR_V(0), KEY(2));
+
+out:
+	test_vm_free(t.vm);
+}
+
+static void test_errors_key_fetch_prot_override_enabled(void)
+{
+	struct test_default t = test_default_init(guest_copy_key_fetch_prot_override);
+	vm_vaddr_t guest_0_page, guest_last_page;
+
+	guest_0_page = test_vaddr_alloc(t.vm, PAGE_SIZE, 0);
+	guest_last_page = test_vaddr_alloc(t.vm, PAGE_SIZE, last_page_addr);
+	if (guest_0_page != 0 || guest_last_page != last_page_addr) {
+		print_skip("did not allocate guest pages at required positions");
+		goto out;
+	}
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+	t.run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
+	t.run->kvm_dirty_regs = KVM_SYNC_CRS;
+	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
+
+	/*
+	 * vcpu, mismatching keys on fetch,
+	 * fetch protection override does not apply because memory range acceeded
+	 */
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048 + 1, GADDR_V(0), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048 + 1,
+				 GADDR_V(guest_last_page), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, 2048, GADDR(0), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, 2048, GADDR_V(guest_0_page), KEY(2));
+
+out:
+	test_vm_free(t.vm);
+}
+
 static void guest_idle(void)
 {
 	GUEST_SYNC(STAGE_INITED);
@@ -301,38 +587,53 @@ static void guest_idle(void)
 		GUEST_SYNC(STAGE_IDLED);
 }
 
-static void test_errors(void)
+static void _test_errors_common(struct test_vcpu vcpu, enum mop_target target, int size)
 {
-	struct test_default t = test_default_init(guest_idle);
 	int rv;
 
-	HOST_SYNC(t.vcpu, STAGE_INITED);
-
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, -1, GADDR_V(mem1));
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, -1, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
 
 	/* Zero size: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, 0, GADDR_V(mem1));
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, 0, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
 		    "ioctl allows 0 as size");
 
 	/* Bad flags: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), SET_FLAGS(-1));
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, size, GADDR_V(mem1), SET_FLAGS(-1));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
 
-	/* Bad operation: */
-	rv = ERR_MOP(t.vcpu, INVALID, WRITE, mem1, t.size, GADDR_V(mem1));
-	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
-
 	/* Bad guest address: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR((void *)~0xfffUL), CHECK_ONLY);
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, size, GADDR((void *)~0xfffUL), CHECK_ONLY);
 	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
 
 	/* Bad host address: */
-	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, 0, t.size, GADDR_V(mem1));
+	rv = ERR_MOP(vcpu, target, WRITE, 0, size, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == EFAULT,
 		    "ioctl does not report bad host memory address");
 
+	/* Bad key: */
+	rv = ERR_MOP(vcpu, target, WRITE, mem1, size, GADDR_V(mem1), KEY(17));
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows invalid key");
+}
+
+static void test_errors(void)
+{
+	struct test_default t = test_default_init(guest_idle);
+	int rv;
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	_test_errors_common(t.vcpu, LOGICAL, t.size);
+	_test_errors_common(t.vm, ABSOLUTE, t.size);
+
+	/* Bad operation: */
+	rv = ERR_MOP(t.vcpu, INVALID, WRITE, mem1, t.size, GADDR_V(mem1));
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
+	/* virtual addresses are not translated when passing INVALID */
+	rv = ERR_MOP(t.vm, INVALID, WRITE, mem1, PAGE_SIZE, GADDR(0));
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
+
 	/* Bad access register: */
 	t.run->psw_mask &= ~(3UL << (63 - 17));
 	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
@@ -355,17 +656,30 @@ static void test_errors(void)
 
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
+		test_errors_key();
+		test_errors_key_storage_prot_override();
+		test_errors_key_fetch_prot_override_not_enabled();
+		test_errors_key_fetch_prot_override_enabled();
+	} else {
+		print_skip("storage key memop extension not supported");
+	}
 	test_errors();
 
 	return 0;
-- 
2.32.0

