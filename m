Return-Path: <linux-kselftest+bounces-43426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACA7BEB8C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 22:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37EC24F6706
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1B345CC8;
	Fri, 17 Oct 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rc7HKZiT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34234217A
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731992; cv=none; b=t9uAlO/s0PAbMLZqqJc4myfmnNXnTyNYQ4HrMJ0KV133+XMojm4gDMsvBpjHTeCZT+9d5SO9bt0yaUun46+kZJL+xOC7L1rUX9fXh7sHa/d5dFfPUCZckvng6/wEl/CkgB5AjYLx/vQV2vDy1FuV7B2YtHkQvSBvFSRaI/Wyz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731992; c=relaxed/simple;
	bh=9Ff3PWoIrWIqdLj70SRHRgapMbRCOgIGvC+YSHiKL44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y5aL1PH9tJxMd+vGoBAvDWsANZH0NY+Erd4CqGTlY8oGQ631DM1xQie/CxyP10xcwuigQjOlMv+8atzdP0ZDs9m9Pr+IBmrdT5tjRbK7PCuUbZVbXm6cfEoyArAmxjfQ3vQk/4ZQoV4gyg5LHWB8pPICcsytHTZXWityOnktEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rc7HKZiT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso3673316a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731984; x=1761336784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lnebmp8Qf5EWIBCxuV2pnQrOdRPzx0FMFYBdpouvbtI=;
        b=Rc7HKZiTiWNa7OS7+uWerDu71X6Vq+ZLEq71VcHQfFvFKwnqDE5IxDqREgfGAzg/sN
         gEHtuecplKJu7ytrshDwiHypjYxz7EjDOdO1hZOFTB7yK2Bx/BuVbfCD6aJCajUkz90S
         jDIK4CYid8Y2hKZQ/YUX3CrYW0+u3WRKM0QnUjnhNAAFRB+GtToqLklW9lA2AydJyqqv
         XYpDuZ+4Yb2bNaePZshtPsH8uVfbFLPnXVCRrqFIk0nqVZkvQicGnDwWgEoC5KnA7qla
         CFPCJGtqKirVtOGT8qDG5km6cDpxoxBJN7BhE/QUDJDW75pb4dcaDkJZZcynBvGgjc4v
         oFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731984; x=1761336784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lnebmp8Qf5EWIBCxuV2pnQrOdRPzx0FMFYBdpouvbtI=;
        b=Y9CrE3cx2yiTz3Rqt6PUyzDlLbQmM76UnzVamWULQ3bfNOeo2nWUbPxx1yk02GtCAU
         ipmvhWbhPS0KdaAZcOO1UgIqTNZEhNA3vgWJAz9vsOeTYn83NcgUYaQwF5vuLCvjCkPr
         M1TmTfzOR9agOfz2tYe3vouQeBMV5WmwtgBEt7qH9gI7nV0gxo5tG8BeFP9kVOs41qrA
         CYUXi/LhM5c7FbozJVHGTfc+LCQpOGpZiuBt+lEWQRRxlLiLWr1+n3isK5XQED+qslDw
         TMhrKZo+XqgF3tnWbjd5EZjK4gQ+IwdemegiAtqO/d+0vVTDqvJKfp5r2DVvXNEAKezx
         1svQ==
X-Forwarded-Encrypted: i=1; AJvYcCVspt/8jjd8qHJwe56igDPm8L/fOggzou4xrPVUkdNNCqcXI78AnPyzlZp2h7tcYSPWr4tGJS5LdSunDhj0Zs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HmnAknak+hSjImDwdlY5wrj6kC3vRmkkjT0jcmU/+vIlMeRx
	J8DkJRleasYhx+Sx0aZK0H8U7PlzMX2rGxoSIvCKQ6S3CQBDLjnQ/3YiWW2oYVWb7sS9ZLmEWbi
	ESolULCZi+3JjMY9EIEY6qFCiog==
X-Google-Smtp-Source: AGHT+IEB52F61621aMByRkpbPgTkpDpb2zZJPIEfSZTfaBbai+oIczGx5aQpE8WOhm5/i6XAmSimYUjcxZtR+kNbuQ==
X-Received: from pjtk2.prod.google.com ([2002:a17:90a:c502:b0:327:7035:d848])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:244b:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-334a85fdb31mr6337050637.56.1760731983589;
 Fri, 17 Oct 2025 13:13:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:02 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <612a3bcc787fb76379b081e802b9c67ccbeb8a87.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 21/37] KVM: selftests: guest_memfd: Test indexing in guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

The existing guest_memfd conversion tests only use single-page memory
regions. This provides no coverage for multi-page guest_memfd objects,
specifically whether KVM correctly handles the page index for conversion
operations. An incorrect implementation could, for example, always operate
on the first page regardless of the index provided.

Add a new test case to verify that conversions between private and shared
memory correctly target the specified page within a multi-page guest_memfd.

To support this test, add a new GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED
macro that handles setting up and tearing down the VM for each page
iteration. The teardown logic is adjusted to prevent a double-free in this
new scenario.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/guest_memfd_conversions_test.c        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index d57e66ee11310..54e7deec992d4 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -63,6 +63,9 @@ static void gmem_conversions_do_teardown(test_data_t *t)
 {
 	/* No need to close gmem_fd, it's owned by the VM structure. */
 	kvm_vm_free(t->vcpu->vm);
+
+	/* NULL this out to avoid second free on full teardown in multipage tests. */
+	t->vcpu->vm = NULL;
 }
 
 FIXTURE_TEARDOWN(gmem_conversions)
@@ -101,6 +104,29 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
 #define GMEM_CONVERSION_TEST_INIT_SHARED(test)					\
 	__GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
 
+/*
+ * Repeats test over nr_pages in a guest_memfd of size nr_pages, providing each
+ * test iteration with test_page, the index of the page under test in
+ * guest_memfd. test_page takes values 0..(nr_pages - 1) inclusive.
+ */
+#define GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(test, __nr_pages)		\
+static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,	\
+						const int test_page);		\
+										\
+TEST_F(gmem_conversions, test)							\
+{										\
+	const uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED; \
+	int i;									\
+										\
+	for (i = 0; i < __nr_pages; ++i) {					\
+		gmem_conversions_do_setup(self, __nr_pages, flags);		\
+		__gmem_conversions_multipage_##test(self, __nr_pages, i);	\
+		gmem_conversions_do_teardown(self);				\
+	}									\
+}										\
+static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,	\
+						const int test_page)
+
 struct guest_check_data {
 	void *mem;
 	char expected_val;
@@ -207,6 +233,36 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
 	test_convert_to_shared(t, 0, 'C', 'D', 'E');
 }
 
+/*
+ * Test indexing of pages within guest_memfd, using test data that is a multiple
+ * of page index.
+ */
+GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
+{
+	int i;
+
+	/*
+	 * Start with the highest index, to catch any errors when, perhaps, the
+	 * first page is returned even for the last index.
+	 */
+	for (i = nr_pages - 1; i >= 0; --i)
+		test_shared(t, i, 0, i, i * 2);
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_convert_to_private(t, i, i * 2, i * 4);
+		else
+			test_shared(t, i, i * 2, i * 3, i * 4);
+	}
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_convert_to_shared(t, i, i * 4, i * 5, i * 6);
+		else
+			test_shared(t, i, i * 4, i * 5, i * 6);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog


