Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE94D187F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbiCHNAB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 08:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346986AbiCHM75 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 07:59:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0352C11E;
        Tue,  8 Mar 2022 04:58:55 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228BMoVi013400;
        Tue, 8 Mar 2022 12:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XrWEtC4fI92R5zD1Wl30ToHOJWl18tWleLxjFg7aGxw=;
 b=cJOlGYkvhIiPSqlduhrPadOi+UsRfrxQp6jeGNjnyFX0X68+eZaHAijSv32ODpOY35OU
 T/uA7hSOjAK+r56wTKiJWWUIrIGbXXpirjtTiuxIx5luvPBRhy+nFW6fJnNYY3rEKsce
 2c40VFg2lgUqI5ZFYsuDlqIB5mhskCjJl6KRN56FnxKfEacPEcoaQssa7hBVVBxA1uKk
 tYo8rYXsI6uhur5rGpFDNpf7sJ6/koz5CFDSS/dFXc7Ol0+WntIuzqhCaUWkshXAZNXM
 DcMYtAE2gzlzFNZEgUatB09TfZ7IDYkZ7+b5ITqE27r8n9r6N/Yx1GmOzR0GORfgHVUE jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3envcuvwhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:51 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228Cjdes009449;
        Tue, 8 Mar 2022 12:58:50 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3envcuvwgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228Crra1022863;
        Tue, 8 Mar 2022 12:58:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3enqgnj3dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228CwkrL54198770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 12:58:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE75A11C04A;
        Tue,  8 Mar 2022 12:58:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96CD211C052;
        Tue,  8 Mar 2022 12:58:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 12:58:45 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] KVM: s390: selftests: Add macro as abstraction for MEM_OP
Date:   Tue,  8 Mar 2022 13:58:38 +0100
Message-Id: <20220308125841.3271721-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308125841.3271721-1-scgl@linux.ibm.com>
References: <20220308125841.3271721-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7bU0rPVmjRfoLmboRDu0lD1V_BgpZPed
X-Proofpoint-ORIG-GUID: RjssdsmhA3hBtMMCx4dgl02hDHTfkgdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to achieve good test coverage we need to be able to invoke the
MEM_OP ioctl with all possible parametrizations.
However, for a given test, we want to be concise and not specify a long
list of default values for parameters not relevant for the test, so the
readers attention is not needlessly diverted.
Add a macro that enables this and convert the existing test to use it.
The macro emulates named arguments and hides some of the ioctl's
redundancy, e.g. sets the key flag if an access key is specified.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 272 ++++++++++++++++------
 1 file changed, 197 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index b9b673acb766..e2ad3d70bae4 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -13,6 +13,188 @@
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
 #define VCPU_ID 1
 
 static uint8_t mem1[65536];
@@ -20,6 +202,7 @@ static uint8_t mem2[65536];
 
 struct test_default {
 	struct kvm_vm *kvm_vm;
+	struct test_vcpu vcpu;
 	struct kvm_run *run;
 	int size;
 };
@@ -30,6 +213,7 @@ static struct test_default test_default_init(void *guest_code)
 
 	t.size = min((size_t)kvm_check_cap(KVM_CAP_S390_MEM_OP), sizeof(mem1));
 	t.kvm_vm = vm_create_default(VCPU_ID, 0, guest_code);
+	t.vcpu = (struct test_vcpu) { t.kvm_vm, VCPU_ID };
 	t.run = vcpu_state(t.kvm_vm, VCPU_ID);
 	return t;
 }
@@ -43,20 +227,14 @@ static void guest_copy(void)
 static void test_copy(void)
 {
 	struct test_default t = test_default_init(guest_copy);
-	struct kvm_s390_mem_op ksmo;
 	int i;
 
 	for (i = 0; i < sizeof(mem1); i++)
 		mem1[i] = i * i + i;
 
 	/* Set the first array */
-	ksmo.gaddr = addr_gva2gpa(t.kvm_vm, (uintptr_t)mem1);
-	ksmo.flags = 0;
-	ksmo.size = t.size;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size,
+	    GADDR(addr_gva2gpa(t.kvm_vm, (uintptr_t)mem1)));
 
 	/* Let the guest code copy the first array to the second */
 	vcpu_run(t.kvm_vm, VCPU_ID);
@@ -68,13 +246,7 @@ static void test_copy(void)
 	memset(mem2, 0xaa, sizeof(mem2));
 
 	/* Get the second array */
-	ksmo.gaddr = (uintptr_t)mem2;
-	ksmo.flags = 0;
-	ksmo.size = t.size;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
-	ksmo.buf = (uintptr_t)mem2;
-	ksmo.ar = 0;
-	vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	MOP(t.vcpu, LOGICAL, READ, mem2, t.size, GADDR_V(mem2));
 
 	TEST_ASSERT(!memcmp(mem1, mem2, t.size),
 		    "Memory contents do not match!");
@@ -91,68 +263,31 @@ static void guest_idle(void)
 static void test_errors(void)
 {
 	struct test_default t = test_default_init(guest_idle);
-	struct kvm_s390_mem_op ksmo;
 	int rv;
 
-	/* Check error conditions - first bad size: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = -1;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	/* Bad size: */
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, -1, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
 
 	/* Zero size: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = 0;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, 0, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
 		    "ioctl allows 0 as size");
 
 	/* Bad flags: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = -1;
-	ksmo.size = t.size;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), SET_FLAGS(-1));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
 
 	/* Bad operation: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = t.size;
-	ksmo.op = -1;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, INVALID, WRITE, mem1, t.size, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
 
 	/* Bad guest address: */
-	ksmo.gaddr = ~0xfffUL;
-	ksmo.flags = KVM_S390_MEMOP_F_CHECK_ONLY;
-	ksmo.size = t.size;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR((void *)~0xfffUL), CHECK_ONLY);
 	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
 
 	/* Bad host address: */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = t.size;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = 0;
-	ksmo.ar = 0;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, 0, t.size, GADDR_V(mem1));
 	TEST_ASSERT(rv == -1 && errno == EFAULT,
 		    "ioctl does not report bad host memory address");
 
@@ -160,29 +295,16 @@ static void test_errors(void)
 	t.run->psw_mask &= ~(3UL << (63 - 17));
 	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
 	vcpu_run(t.kvm_vm, VCPU_ID);              /* To sync new state to SIE block */
-	ksmo.gaddr = (uintptr_t)mem1;
-	ksmo.flags = 0;
-	ksmo.size = t.size;
-	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.ar = 17;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), AR(17));
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
 	t.run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
 	vcpu_run(t.kvm_vm, VCPU_ID);                  /* Run to sync new state */
 
 	/* Check that the SIDA calls are rejected for non-protected guests */
-	ksmo.gaddr = 0;
-	ksmo.flags = 0;
-	ksmo.size = 8;
-	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
-	ksmo.buf = (uintptr_t)mem1;
-	ksmo.sida_offset = 0x1c0;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, SIDA, READ, mem1, 8, GADDR(0), SIDA_OFFSET(0x1c0));
 	TEST_ASSERT(rv == -1 && errno == EINVAL,
 		    "ioctl does not reject SIDA_READ in non-protected mode");
-	ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
-	rv = _vcpu_ioctl(t.kvm_vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = ERR_MOP(t.vcpu, SIDA, WRITE, mem1, 8, GADDR(0), SIDA_OFFSET(0x1c0));
 	TEST_ASSERT(rv == -1 && errno == EINVAL,
 		    "ioctl does not reject SIDA_WRITE in non-protected mode");
 
-- 
2.32.0

