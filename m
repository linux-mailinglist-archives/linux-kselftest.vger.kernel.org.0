Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBF389770
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhESUFk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhESUFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC1C0613ED
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so19422560ybo.11
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MjsFjVBl/FxOvPsR75EG0eCugTJDkb3SkVrZ8fG721M=;
        b=spQmodnH3l9aCJPUDO3n5Znh2ZyIosaGKET15ANW77RodOarCKRMYdd4ZTT5Dgoc2k
         Q4gX08tS5MxCuv/Rv2D9zK6mx0pptSUfomMvtiC0DKBscF7RNhNAJ8qBYhuNbU+KJzGD
         9Di8fjJ16HT2NQ7g9Mylhd9Q4vBdD04+fGgLLFo0eDjpvWSuFHBCTuvHG5j7p7MiEgcB
         nlHhRoPl/wldjZApTsit3FNusyqwxSfZqMO5YBm/DF1cpfS5jB5ral14SuCmUiyYDllQ
         geaoVtg8aJuRrdHrE/1M/XsAjWrP2HqnJiPQ1zWuJIASN//juooGnCdv0WEiCYw1hQUJ
         KtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MjsFjVBl/FxOvPsR75EG0eCugTJDkb3SkVrZ8fG721M=;
        b=WvvcfZ81ngR1/9zoHCUEA5ccD+wkpH2bClFWx7FQyAfF1VnNHLijgD0BLfGNbgFHzw
         F5t5MWKCoknSGTCB55rSW5EqUSaxeHedRn6ghCgI7lpLYDDUqKDBgohNjy8BZsVl77BZ
         Aku4UF1cno6mmWrPd4Yd7NfKQ5JHG774sjYKHCHmvb8Iteg7J3jFlMOLDCWQzFjkJchP
         L6i+8bdwCDMrluTL94oESBEYu9yN9InjIEzZqjPHzpa0TFoCQqChJZ4jqkYdxKcEdB2f
         Kp0/tHnyhaETEkRJgNUOm1yptanbzv9NlG/4vCNF7aNRki+as1GQLjHU5Obc6AbXsWaa
         0h3Q==
X-Gm-Message-State: AOAM532Jz8KTtgUIkFLeP93AdtlyHHCa9g2srmw2Cqb+b+0OsVV1gtxu
        Hh3huxlGu0vWhp1ESXni5ZWIRQObh5M0lb57DYPi
X-Google-Smtp-Source: ABdhPJyHafljVkGdPjHHgSggwuGn/ncrKGDKCpO+1vhol0lzIU/n68KHpG5rQ7OquxgzaK0ZG9K7PUW6jHEH8izmySIR
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a25:ec02:: with SMTP id
 j2mr2058895ybh.248.1621454643850; Wed, 19 May 2021 13:04:03 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:37 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 08/10] KVM: selftests: create alias mappings when using
 shared memory
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

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 51 +++++++++++++++++++
 .../selftests/kvm/lib/kvm_util_internal.h     |  2 +
 3 files changed, 54 insertions(+)

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
index e4a8d0c43c5e..0b88d1bbc1e0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -811,6 +811,19 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 
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
@@ -1239,6 +1252,44 @@ vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
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
+ * underlying guest memory. This allows the host to manipulate guest memory
+ * without mapping that memory in the guest's address space. And, for
+ * userfaultfd-based demand paging, we can do so without triggering userfaults.
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
2.31.1.751.gd2f1c929bd-goog

