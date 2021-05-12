Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC42E37EF4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 01:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346905AbhELXEN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389993AbhELVtT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 17:49:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C632C061262
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so29467654ybp.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SSP4iK7kQof7O+I0mY5Yx7zKhq95LDgOK3FrtnCssfc=;
        b=WYmdCGITKjUOQQSZswfLUeNGLxUkRHPTAVYlSBsC9FXawghwF25YW7fD6LHQiXpZoV
         Y/zUoelCiLBKEj1zL/r1oV6g+hJZxnrDqVYXrIPkBw86ysHxuA+lMCwOvdAeXFr6uu2H
         GxDmEcEEMUmKNaq0FbXVHhNu5yAFr9e2WjRYnBXtYzhpbLgxLXKEYkFew3g3PAF0RTpY
         knBGHyGcISUKVmt6pZdhaWt8iYuJG5J3Jue6SOxF4rzEbfg0jc1AT0jaQdWvBxZwN+DW
         hrRX90XUub3WRf7M3yYCGJzePD8d7PKwDuycNVqd+QS5krQVpGJSphRvW+9EqaSp3A5j
         GQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SSP4iK7kQof7O+I0mY5Yx7zKhq95LDgOK3FrtnCssfc=;
        b=BKRTyl7c7f55CgRbgppkoomUYIEdvABcK9jt340o+qnV5JEQmrcFQuWyMwdz1qp6zE
         JiixHkNgPgq3eREm5agnqrHxZQ/6vNEuK0TwcqPskCKZ6yt44iGlItdLdc4sGlzqnXvQ
         6dFgYdu2rXKzTDtUjPlid8LvUsurqso6W6Mfzfc9M/lTVJQ1uSdr0sTKQksxEIeWNxHS
         EpbfqceEokcRm2U3SaVsnvOR0f4Yw4bItOeF6vdgr8hPaSOxSZMo/p7lXu/hoYEWS3S9
         ElInvegUvOkNKTe6z6JdMjbIFErnkAEYsKdtQh6MMMbXrT+62Xc/RtM79pBlrwqRdhUd
         vS2A==
X-Gm-Message-State: AOAM531uzbSFGPvaeeTTMRqgyqSMfDrv+Hylgsngw6xHSJlg75UzsH6Y
        Vz778aga6VpP2dk5e/Dc6PwqEccNceoY3iRjE8Iw
X-Google-Smtp-Source: ABdhPJwqmFAoNNkGc7hecA9VlWtADbzv/7DZGn54W2mNkU4f/bU+2cysakOIUeg/gBZANgkKjybDmotUdnpfozeZDGqZ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:29e5:10fc:1128:b0c0])
 (user=axelrasmussen job=sendgmr) by 2002:a25:9bc6:: with SMTP id
 w6mr51455382ybo.159.1620855911479; Wed, 12 May 2021 14:45:11 -0700 (PDT)
Date:   Wed, 12 May 2021 14:45:00 -0700
In-Reply-To: <20210512214502.2047008-1-axelrasmussen@google.com>
Message-Id: <20210512214502.2047008-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 3/5] KVM: selftests: create alias mappings when using shared memory
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a memory region is added with a src_type specifying that it should
use some kind of shared memory, also create an alias mapping to the same
underlying physical pages.

And, add an API so tests can get access to these alias addresses.
Basically, for a guest physical address, let us look up the analogous
host *alias* address.

In a future commit, we'll modify the demand paging test to take
advantage of this to exercise UFFD minor faults. The idea is, we
pre-fault the underlying pages *via the alias*. When the *guest*
faults, it gets a "minor" fault (PTEs don't exist yet, but a page is
already in the page cache). Then, the userfaultfd theads can handle the
fault: they could potentially modify the underlying memory *via the
alias* if they wanted to, and then they install the PTEs and let the
guest carry on via a UFFDIO_CONTINUE ioctl.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 50 +++++++++++++++++++
 .../selftests/kvm/lib/kvm_util_internal.h     |  2 +
 3 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a8f022794ce3..0624f25a6803 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -146,6 +146,7 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
 void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
+void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
 
 /*
  * Address Guest Virtual to Guest Physical
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6fbe124e0e16..838d58633f7e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -809,6 +809,19 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 
 	/* Add to linked-list of memory regions. */
 	list_add(&region->list, &vm->userspace_mem_regions);
+
+	/* If shared memory, create an alias. */
+	if (region->fd >= 0) {
+		region->mmap_alias = mmap(NULL, region->mmap_size,
+					  PROT_READ | PROT_WRITE,
+					  vm_mem_backing_src_alias(src_type)->flag,
+					  region->fd, 0);
+		TEST_ASSERT(region->mmap_alias != MAP_FAILED,
+			    "mmap of alias failed, errno: %i", errno);
+
+		/* Align host alias address */
+		region->host_alias = align(region->mmap_alias, alignment);
+	}
 }
 
 /*
@@ -1237,6 +1250,43 @@ vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
 	return -1;
 }
 
+/*
+ * Address VM physical to Host Virtual *alias*.
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gpa - VM physical address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Equivalent address within the host virtual *alias* area, or NULL
+ *   (without failing the test) if the guest memory is not shared (so
+ *   no alias exists).
+ *
+ * When vm_create() and related functions are called with a shared memory
+ * src_type, we also create a writable, shared alias mapping of the
+ * underlying guest memory. This allows the host to manipulate guest memory,
+ * e.g. to implement demand paging.
+ */
+void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
+{
+	struct userspace_mem_region *region;
+
+	list_for_each_entry(region, &vm->userspace_mem_regions, list) {
+		if (!region->host_alias)
+			continue;
+
+		if ((gpa >= region->region.guest_phys_addr)
+			&& (gpa <= (region->region.guest_phys_addr
+				+ region->region.memory_size - 1)))
+			return (void *) ((uintptr_t) region->host_alias
+				+ (gpa - region->region.guest_phys_addr));
+	}
+
+	return NULL;
+}
+
 /*
  * VM Create IRQ Chip
  *
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index 91ce1b5d480b..a25af33d4a9c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -16,7 +16,9 @@ struct userspace_mem_region {
 	int fd;
 	off_t offset;
 	void *host_mem;
+	void *host_alias;
 	void *mmap_start;
+	void *mmap_alias;
 	size_t mmap_size;
 	struct list_head list;
 };
-- 
2.31.1.607.g51e8a6a459-goog

