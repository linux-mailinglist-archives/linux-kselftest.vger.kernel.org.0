Return-Path: <linux-kselftest+bounces-33215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85473ABA397
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626047AD78C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC87280CFC;
	Fri, 16 May 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDXEf5Dr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5528032F
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423199; cv=none; b=g3QPwuBpjlHwWcDWaLcREiL5cYdRO23iPIB4rPRtQ49ORwab0s0QFNkO1yyj0t70Yq6ukw6gqDpVtJ5PBidnVUD4GvF8fe/QqsMZ/lA+DwAHthfwOQBOyaK5err+30HCat0FunwdwQUemYqxLMDuzpj1bYbyJpDKMEfs36R9u5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423199; c=relaxed/simple;
	bh=/R9vB/KqEvAjXWixKptCo/7lWCpS9NBKQF8SStvrMlc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gDMvUdZORQlHCkeFu9L/Bb7nmmeb0regudqXxEt0onY2nNKp69ySTPuUTlnw59udY756PumbDdT0A8iycmcm5KOKS7lc4yg6q4njrU69ziiLvrJkUc0iPMg7wQqVBn/kLzRRj1HZCxwThSekCEsjP6TVRoCCNQkCC4kbzjpc5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDXEf5Dr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so3435724a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423197; x=1748027997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj+O3835hB+mDLIwn62GyrN5K+Himp712LOqeVzKuMw=;
        b=JDXEf5DrhNAjKz3Pxbn2Wmciu0O/sMxPTAEWXU+/VEP7riA+/8rwR4YPbiz7pUEYu2
         jMX2Wt41mRUlJDnhlzChVONUaDzkju/SZnrCbwndPYN+p4ckrjjCzCRXOjOzZ2xTJZbP
         MLwOkt9ElCqagjlly6FPoUPayJ/CCz09mgu5I/+4yydKGezq/oQU+6IrbSNh3Q3I1oas
         dQkmZ+P1uEzBaEoDpJo9s+HIvaR99n3qFEFIzRXQkYufjhTLIBMLaXMKx1loR6i8B5Dt
         F/TcnJTMYJycaG6v2a+ml2xwPfgy4boIb3w2+cdQ51WrBlENeY2QdT14UHteg3PtQJDs
         btCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423197; x=1748027997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj+O3835hB+mDLIwn62GyrN5K+Himp712LOqeVzKuMw=;
        b=KdF6pYQsPlnODOTKNk+2UUQPgQrfrQiG9hMSnjJORv6BHRuYrN1iI7IvH+LjmKGTk2
         433Og8Z1OUjNhU1/zvbJH9iCO9q4/qxtbf/f2sJMtfCScRfTo8DiC7cfZcmYeVp2hbAn
         EqZ/w2X0R9S0mYTLXFFS4mbpvtGu/7TH7GcikvjSWUwndel2yZemQQvi0edA4brXpGr6
         LacL3nRIGRtpm6rP0YP79SG8n/VpgcUz5F6/laqOkAFRlJ3Kw5yn6dJ11fuK8NgBcZ8E
         f3Mko+ZyOQw53Po+lijc0Lvx/sMp4UNBcJbsKyPqxH7j13uItTE9THl1EhcPOA5yQpaa
         WcYg==
X-Forwarded-Encrypted: i=1; AJvYcCUWi8D4dI8B0AhsL3zA4enz7bvUmBuh4Qx3x4r1oGTwpLtOw8PMfUT3QfYImYm337/AI5hpUOpbgpnGgrts0/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTSDt8mtU9tQXlPfGpDYZhpqjYpsfa94OcMz+/0ghGEveT7DB
	E8gQJaw5XqXmTSoO58YMaCeQ07HvBRNu6iFx56lZcjCgNHWk+495Ia6aBvt3OKAVk126p3V49oz
	hArtPF2Tnxg==
X-Google-Smtp-Source: AGHT+IHsBpALK/e0rg+JB1mNGETo/0o1fwTI4vHuGOsLELeZyBF3WgvYCnwYUD0i5CByXpXpO2KcQaRcAv/0
X-Received: from pjbqn6.prod.google.com ([2002:a17:90b:3d46:b0:2fc:ccfe:368])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e185:b0:2ff:6ac2:c5a5
 with SMTP id 98e67ed59e1d1-30e7d5a8600mr5955317a91.26.1747423197397; Fri, 16
 May 2025 12:19:57 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:26 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <d6ebd0aa1d9f38e4b10a100bfd09df49cddafe73.1747368093.git.afranji@google.com>
Subject: [RFC PATCH v2 06/13] KVM: selftests: Test transferring private memory
 to another VM
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../kvm/x86/private_mem_migrate_tests.c       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c

diff --git a/tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c b/tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c
new file mode 100644
index 000000000000..4226de3ebd41
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util_base.h"
+#include "test_util.h"
+#include "ucall_common.h"
+#include <linux/kvm.h>
+#include <linux/sizes.h>
+
+#define TRANSFER_PRIVATE_MEM_TEST_SLOT 10
+#define TRANSFER_PRIVATE_MEM_GPA ((uint64_t)(1ull << 32))
+#define TRANSFER_PRIVATE_MEM_GVA TRANSFER_PRIVATE_MEM_GPA
+#define TRANSFER_PRIVATE_MEM_VALUE 0xdeadbeef
+
+static void transfer_private_mem_guest_code_src(void)
+{
+	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+
+	*ptr = TRANSFER_PRIVATE_MEM_VALUE;
+
+	GUEST_SYNC1(*ptr);
+}
+
+static void transfer_private_mem_guest_code_dst(void)
+{
+	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+
+	GUEST_SYNC1(*ptr);
+}
+
+static void test_transfer_private_mem(void)
+{
+	struct kvm_vm *src_vm, *dst_vm;
+	struct kvm_vcpu *src_vcpu, *dst_vcpu;
+	int src_memfd, dst_memfd;
+	struct ucall uc;
+
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+
+	/* Build the source VM, use it to write to private memory */
+	src_vm = __vm_create_shape_with_one_vcpu(
+		shape, &src_vcpu, 0, transfer_private_mem_guest_code_src);
+	src_memfd = vm_create_guest_memfd(src_vm, SZ_4K, 0);
+
+	vm_mem_add(src_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
+		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+		   src_memfd, 0);
+
+	virt_map(src_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
+	vm_set_memory_attributes(src_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
+				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	vcpu_run(src_vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(src_vcpu, KVM_EXIT_IO);
+	get_ucall(src_vcpu, &uc);
+	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+		    "Source VM should be able to write to private memory");
+
+	/* Build the destination VM with linked fd */
+	dst_vm = __vm_create_shape_with_one_vcpu(
+		shape, &dst_vcpu, 0, transfer_private_mem_guest_code_dst);
+	dst_memfd = vm_link_guest_memfd(dst_vm, src_memfd, 0);
+
+	vm_mem_add(dst_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
+		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+		   dst_memfd, 0);
+
+	virt_map(dst_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
+	vm_set_memory_attributes(dst_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
+				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	vcpu_run(dst_vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(dst_vcpu, KVM_EXIT_IO);
+	get_ucall(dst_vcpu, &uc);
+	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+		    "Destination VM should be able to read value transferred");
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	test_transfer_private_mem();
+
+	return 0;
+}
-- 
2.49.0.1101.gccaa498523-goog


