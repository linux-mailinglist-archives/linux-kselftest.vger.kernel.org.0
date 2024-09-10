Return-Path: <linux-kselftest+bounces-17698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D419746F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344B4287E31
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B391C3F09;
	Tue, 10 Sep 2024 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryFoj5lE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3061C32FE
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011936; cv=none; b=iXmsnlKwA3fYN8dL7lTKyGoOodFvHaNHWKiNDgDEFtotcfga/YTassH/sgwx//LLtXVQA2YgYJXBI2ZAFFY4TVL/5ahOUQhvTS0/5wMrNeFR7NPqz8Tydi61iy3cx5w6JQbIrJKBJ08PzxmIftmTk3+f2iZ4aXoQ+5nw8NDtu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011936; c=relaxed/simple;
	bh=xDhJT0jtukUSht8M1rW68Et+r1brKb18kxNSu0XqBak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pNWOEKtF5okTV4ZCVcIlxcirv8rVrTogxokpdTHwBeBcUZFtZn4VsZNqRV62MqGFnnajWyYH0AQU+zQaoH+uQenrS6SADifrxkA/WMo/2fp7WmXftVcCBsmZQQmWj4U6e1zMdspNeQA7P0z9XBdoF5f7x3X9up4eG0UTofF71cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryFoj5lE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-206f9b1bc52so14583075ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011934; x=1726616734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PU0eLeT/Khb6QlOSfPgwKdSujIEPbf2Mi98Qjlq+ljA=;
        b=ryFoj5lEkrpo5/Oin/SfkYzGXzKADf/1aAH+vux+vxk9jWoiuWcQCyLE4oT1FIB7Tu
         LzR5Q6RPxnEiEha2NzW4AxVN5YlXiB9Q8UE36XAOSURV1kHiXngHx5KVsdmgPnKR60yI
         j4/g6Qm/BvA160B9TYg1HPdT6gI6+K4My0v3IheLzqbN1lmXS1Zm6BVbc5gUe6KJo7Nx
         FgGBfCQCpA3GusBRgEDavhyo9PsMQuPE3LTkWskm4KJKtEH4UIDfGiacNWQEvnIoJrsl
         uIBhWJ4vh72sRLkAbtKyxx78s9UQWq5ynUf5UwLwlcu8sMrpeif44qKb9trZWSU+d088
         rFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011934; x=1726616734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PU0eLeT/Khb6QlOSfPgwKdSujIEPbf2Mi98Qjlq+ljA=;
        b=v3sTa9rD2sgPMhnygRTe0Ee+bk9LLgJaLlFR4DhGpJFzOPezPS11ZHhpuz4RRnI/hJ
         p/VECOsZFNW+Ta2qyyRp+WW/vg2++v1HnLLD/KdG42mhMWYGdBbAVL4epOni0iZMQ/UU
         hYFjntOLtrcKwSINtNoecnBEngcuvw9r3iiZkigB7NBKznd4G7aD7M0wXCo2ZTgbSqH2
         p3IG1zwAhKudXLSM/dq9Kc7INiFK0SzhhQ5ytwGPfAkkWKsZv0xNp8tehMMlfm+kGVld
         9Um799oNFBK+EJNcuv4VidwcxN2DLDo+5x7Bta7aUxDhuY7Nsu/g9fatzGkqYbRCfm1g
         2kJw==
X-Forwarded-Encrypted: i=1; AJvYcCVsostotVXWAHB4KsjnAtOD0LTK7G4miokNugk6d33aPBlCXQT5jrCIbbWiD5nIPVQCCVkC7DWt9+rcspVWXuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZC6GMxp925G2CPuroOs1waeqa+LMXZJ6vVlM46Lmbf8vt2Zzm
	w5tZsbANbcl9+LLqsTyYm4y/xsN9p6VFU3Ua3gt/3PopunpgHUh/dK8Jt+voL91C4JBSQ6rgDWT
	Rk57hL1S4F5qOk4OulL7+1w==
X-Google-Smtp-Source: AGHT+IFVTG93FUeTatq9dmJkXI56Xlmri3CwyYIl4IemmSnQkPMQ4ndLEBPGw8YCyak9fs0iNwaTmELdbdpO3NZKxw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:f687:b0:206:c776:4f11 with
 SMTP id d9443c01a7336-207522167damr522595ad.8.1726011933308; Tue, 10 Sep 2024
 16:45:33 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:06 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <09892ae14d06596aee8b766b5908c8a7fdda85b4.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 35/39] KVM: selftests: Test that pinned pages block KVM
 from setting memory attributes to PRIVATE
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

CONFIG_GUP_TEST provides userspace with an ioctl to invoke
pin_user_pages(), and this test uses the ioctl to pin pages, to check
that memory attributes cannot be set to private if shared pages are
pinned.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/guest_memfd_pin_test.c      | 104 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_pin_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 3c1f35456bfc..c5a1c8c7125a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -136,6 +136,7 @@ TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
 TEST_GEN_PROGS_x86_64 += guest_memfd_test
 TEST_GEN_PROGS_x86_64 += guest_memfd_hugetlb_reporting_test
 TEST_GEN_PROGS_x86_64 += guest_memfd_sharing_test
+TEST_GEN_PROGS_x86_64 += guest_memfd_pin_test
 TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/guest_memfd_pin_test.c b/tools/testing/selftests/kvm/guest_memfd_pin_test.c
new file mode 100644
index 000000000000..b45fb8024970
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_pin_test.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that pinned pages block KVM from setting memory attributes to PRIVATE.
+ *
+ * Copyright (c) 2024, Google LLC.
+ */
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "../../../../mm/gup_test.h"
+
+#define GUEST_MEMFD_PIN_TEST_SLOT 10
+#define GUEST_MEMFD_PIN_TEST_GPA 0x50000000ULL
+#define GUEST_MEMFD_PIN_TEST_OFFSET 0
+
+static int gup_test_fd;
+
+void pin_pages(void *vaddr, uint64_t size)
+{
+	const struct pin_longterm_test args = {
+		.addr = (uint64_t)vaddr,
+		.size = size,
+		.flags = PIN_LONGTERM_TEST_FLAG_USE_WRITE,
+	};
+
+	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
+}
+
+void unpin_pages(void)
+{
+	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_STOP), 0);
+}
+
+void run_test(void)
+{
+	struct kvm_vm *vm;
+	size_t page_size;
+	void *mem;
+	int fd;
+
+	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
+
+	page_size = getpagesize();
+	fd = vm_create_guest_memfd(vm, page_size, 0);
+
+	mem = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+		   GUEST_MEMFD_PIN_TEST_OFFSET);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap should return valid address");
+
+	/*
+	 * Setting up this memslot with a KVM_X86_SW_PROTECTED_VM marks all
+	 * offsets in the file as shared.
+	 */
+	vm_set_user_memory_region2(vm, GUEST_MEMFD_PIN_TEST_SLOT,
+				   KVM_MEM_GUEST_MEMFD,
+				   GUEST_MEMFD_PIN_TEST_GPA, page_size, mem, fd,
+				   GUEST_MEMFD_PIN_TEST_OFFSET);
+
+	/* Before pinning pages, toggling memory attributes should be fine. */
+	vm_mem_set_private(vm, GUEST_MEMFD_PIN_TEST_GPA, page_size);
+	vm_mem_set_shared(vm, GUEST_MEMFD_PIN_TEST_GPA, page_size);
+
+	pin_pages(mem, page_size);
+
+	/*
+	 * Pinning also faults pages in, so remove these pages from userspace
+	 * page tables to properly test that pinning blocks setting memory
+	 * attributes to private.
+	 */
+	TEST_ASSERT_EQ(madvise(mem, page_size, MADV_DONTNEED), 0);
+
+	/* Should fail since the page is still faulted in. */
+	TEST_ASSERT_EQ(__vm_set_memory_attributes(vm, GUEST_MEMFD_PIN_TEST_GPA,
+						  page_size,
+						  KVM_MEMORY_ATTRIBUTE_PRIVATE),
+		       -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	unpin_pages();
+
+	/* With the pages unpinned, kvm can set this page to private. */
+	vm_mem_set_private(vm, GUEST_MEMFD_PIN_TEST_GPA, page_size);
+
+	kvm_vm_free(vm);
+	close(fd);
+}
+
+int main(int argc, char *argv[])
+{
+	gup_test_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	/*
+	 * This test depends on CONFIG_GUP_TEST to provide a kernel module that
+	 * exposes pin_user_pages() to userspace.
+	 */
+	TEST_REQUIRE(gup_test_fd != -1);
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	run_test();
+
+	return 0;
+}
-- 
2.46.0.598.g6f2099f65c-goog


