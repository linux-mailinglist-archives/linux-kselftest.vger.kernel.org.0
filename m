Return-Path: <linux-kselftest+bounces-43433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750ABEB936
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 22:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1051888464
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2033491D8;
	Fri, 17 Oct 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0tGT68Bj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFA34217A
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732006; cv=none; b=YzSLrzxQzzEV1g/NztAke1wLkJ+RM+u5vzdsxJbsCgzYOUaZT3nww65/09ISHlIZazLeXse2egphB41yRQO7euekoaF/VE4J+KutBLjANoMELIxgSvWlK4wR1gHzfUWx7Km+qhXq0fD9r/BwqQz3jkCOf39P/V2lWdPJS8W8pHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732006; c=relaxed/simple;
	bh=htWfv+Kz/+8mCGgXv5yxc0WFOgcnBeuLeS5xitlSAOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MBMDLfOS9Wn52L5Ih+E5X/c2f1AMdTtgUjHQqDL7Gg2zuCAR4lDgR8YEnlcqPeRT6ILuVulccd7YixADCjRMt+ACYJ5Mla0iq9EMSW/ov2OiU9TzGD4PZM1wp6r8oFGN4RSn9Y/HrUctjdKyZ49/i8VnLtUDnixiiEQ7w/tTK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0tGT68Bj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33ba9047881so3096599a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731993; x=1761336793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/dkg7bO1Q/m68vFvjbiJ5siG3cxkpNKvttryWm72LM=;
        b=0tGT68Bj2I2jDRfiF/Jsvnw0FEsnbTc4186CPbTT7BH9huD6RZAJyM3ZZZ2d8Y3Rno
         rYEuO1QJPD65VqHKdN6lW2r8A9fUMbZ8jYXetPqPm6axDDhdQ//36VMNvN2ketY+rPgk
         MFDWA6ZgNCrCu9DWK8JmP+D4jR8S/S/HkksFabLh12FW7oaVxaOLFh7p5HDfgvx64gm+
         FMpceDAfG2LI0lVvqR31HrKgC9w+jIUf1su+0V+Vhb/6jP4WwC/F3WbCJn8rFuBSHfdv
         mOpXwCqxCtJtaIKtYkusnpxx5miwhGDhYI4QrfYU5sUtQ/yRyTOw9XDcqRXn5Im4eKjz
         6s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731993; x=1761336793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/dkg7bO1Q/m68vFvjbiJ5siG3cxkpNKvttryWm72LM=;
        b=EcNpQ3Gd2unBpfrQuTbtfd6LRMeT8XNf5UzSB4F/xTQPlIg1/tW5tcDgdk1jO2auUH
         JT+WZ4LM+douZ1JJ3Ua06miRmcXhHgwdHWz4VU8R9ngb5ORLlXa56Wms1AsraULyEbOg
         YurpnNB71wMYV5X40o7gEDf8ygJHif4vZ/9y5G7JE0hR4v69w4YpZK4pO/ZFOIG4SEiS
         jHSl7D3KLj7io5dYdyTOz7C4/3FYImLOuJCEAYT0reGXPjkNykeEDUQWSECC/LU8ikoe
         /PB/H3PTrUyMtIReSbvJPA8BfLyWBW4S7RWMFeWMTsSQ9J3rH/Ib2MF/ay8z1iqbcf9w
         nkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSb5d3b/vioeUAAmJm+U8vwvfsLgzCj9bGz3PrLb9ZktapfgbKwXG1GuTuDqlQsyeUK9Ptcigcm+x483sMow0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OdChgVH30Bwm4PJ0grsMa0BGGGWtFPbCu1iC2BZlmWOrE1NW
	aaNyqK7W547IIkHGBIotPNCfkXEfx3GK/3mKbOG+cab8+d+zJfV8bHz3TfaJJvDqE1u8bnbggSD
	ERSIbIDFnA1PyxUaXrhi2iDdU1A==
X-Google-Smtp-Source: AGHT+IHVYfbeJHjmJQIxf3lnI6xML61YGFIRkStopZSXJJvTgLI8jTgXjo0mAYsj6xfs9PsRIMTiStrABfsfvN8xtQ==
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:32d:e4c6:7410])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:28c5:b0:33b:c5c7:511a with SMTP id 98e67ed59e1d1-33bc5c75327mr6623268a91.15.1760731993183;
 Fri, 17 Oct 2025 13:13:13 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:08 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <de6d461b585351e38e2f0ad23d06bdd1d05025bc.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 27/37] KVM: selftests: guest_memfd: Test conversion
 with elevated page refcount
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

Add a selftest to verify that converting a shared guest_memfd page to a
private page fails if the page has an elevated reference count.

When KVM converts a shared page to a private one, it expects the page to
have a reference count equal to the reference counts taken by the
filemap. If another kernel subsystem holds a reference to the page, for
example via pin_user_pages(), the conversion must be aborted.

This test uses the gup_test debugfs interface (which requires
CONFIG_GUP_TEST) to call pin_user_pages() on a specific page, artificially
increasing its reference count. It then attempts to convert a range of
pages, including the pinned page, from shared to private.

The test asserts that both bulk and single-page conversion attempts
correctly fail with EAGAIN for the pinned page. After the page is unpinned,
the test verifies that subsequent conversions succeed.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/guest_memfd_conversions_test.c        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index e6abf2d30c62d..856166f1b1dfc 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -14,6 +14,7 @@
 #include "kselftest_harness.h"
 #include "test_util.h"
 #include "ucall_common.h"
+#include "../../../../mm/gup_test.h"
 
 FIXTURE(gmem_conversions) {
 	struct kvm_vcpu *vcpu;
@@ -404,6 +405,87 @@ GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
 	kvm_munmap(test_state, sizeof(*test_state));
 }
 
+static int gup_test_fd;
+
+static void pin_pages(void *vaddr, uint64_t size)
+{
+	const struct pin_longterm_test args = {
+		.addr = (uint64_t)vaddr,
+		.size = size,
+		.flags = PIN_LONGTERM_TEST_FLAG_USE_WRITE,
+	};
+
+	gup_test_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	TEST_REQUIRE(gup_test_fd >= 0);
+
+	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
+}
+
+static void unpin_pages(void)
+{
+	if (gup_test_fd > 0)
+		TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_STOP), 0);
+}
+
+static void test_convert_to_private_fails(test_data_t *t, loff_t pgoff,
+					  size_t nr_pages,
+					  loff_t expected_error_offset)
+{
+	loff_t offset = pgoff * page_size;
+	loff_t error_offset = -1ul;
+	int ret;
+
+	do {
+		ret = __gmem_set_private(t->gmem_fd, offset,
+					 nr_pages * page_size, &error_offset);
+	} while (ret == -1 && errno == EINTR);
+	TEST_ASSERT(ret == -1 && errno == EAGAIN,
+		    "Wanted EAGAIN on page %lu, got %d (ret = %d)", pgoff,
+		    errno, ret);
+	TEST_ASSERT_EQ(error_offset, expected_error_offset);
+}
+
+/*
+ * This test depends on CONFIG_GUP_TEST to provide a kernel module that exposes
+ * pin_user_pages() to userspace.
+ */
+GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(elevated_refcount, 4)
+{
+	int i;
+
+	pin_pages(t->mem + test_page * page_size, page_size);
+
+	for (i = 0; i < nr_pages; i++)
+		test_shared(t, i, 0, 'A', 'B');
+
+	/*
+	 * Converting in bulk should fail as long any page in the range has
+	 * unexpected refcounts.
+	 */
+	test_convert_to_private_fails(t, 0, nr_pages, test_page * page_size);
+
+	for (i = 0; i < nr_pages; i++) {
+		/*
+		 * Converting page-wise should also fail as long any page in the
+		 * range has unexpected refcounts.
+		 */
+		if (i == test_page)
+			test_convert_to_private_fails(t, i, 1, test_page * page_size);
+		else
+			test_convert_to_private(t, i, 'B', 'C');
+	}
+
+	unpin_pages();
+
+	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size);
+
+	for (i = 0; i < nr_pages; i++) {
+		char expected = i == test_page ? 'B' : 'C';
+
+		test_private(t, i, expected, 'D');
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog


