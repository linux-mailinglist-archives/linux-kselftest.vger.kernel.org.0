Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4429938977A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhESUGL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhESUFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EF5C061760
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j4-20020a2523040000b029050d0d623dccso14373852ybj.15
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xynO/3IOvrmFItcgXwqLWtJ7e/CIAjrQIN/NBcwC9/Y=;
        b=E0kntoJRKj0aslmfs+wcTw+D5xf7c/Q3qOFC/mgDQ8p97L0X9I38Aw5N4kwkRYLEYU
         UF/Z5lnoIBMGrXly4aMu7pWEMJC5h/BdCVhGysuZScH46byeMi24IUGASqghNkLT+YNG
         VLD+XPtz2kCG77Si2ohsP8HRw4Diy75AGv2GCnLyrtos9ffQ+6ydiCA7WpG9CPfwj2tM
         L2imdO5V6sB8i5B0R050+NZ7rBmHw7kWVLjrdfb/pYv/EkkU6i3Wz1kIc3G8BRi3OHZL
         aLfHTPiYNsDpj3d1LY/M5gg2YFgx9Pt5th72pp78s9+U3nRkGP+7gj7OeJoUnlKzijUx
         JGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xynO/3IOvrmFItcgXwqLWtJ7e/CIAjrQIN/NBcwC9/Y=;
        b=QHB8ZvDeRhbYfc3M+fGUgLVEsxtoxa6xduGWpvL/8z9Dk2hYUp75RNIOlqxMz3P7LV
         at0bbAkd6S4LzNvaO1pDtyzFQ05sEryRAzBYU6nim+RfJPCZIlEo1ezNDZTlztSYHMnd
         XMJPTCEhaPE49oUm4s6eedRbRfdcQIZ/B6I5c3l2QQB2Dqxskit7bfW79n64gFTswpfQ
         rydIgbghf846JFJvoyIhRM9LKrSABaWIN8aq1MpDiXToiQQnhTh2MacFq82yIzlAZRNM
         aplX5RaX/uSpHr+rw+SqDQH1MVzT5WtM//tybBA4FMsyi2jJiddLVp5/1hjdG13QNdjW
         DqEw==
X-Gm-Message-State: AOAM533jUyXBUKqrxPXVZ8R1/kA6dku2u9iOaezYmfseGcxZejwydd61
        +B2ruHTQdUUToQNfRh8ptvhGBdxE9wv5Z5wjMmDt
X-Google-Smtp-Source: ABdhPJxfGH4VysALNoV+9qp8T413hWsD9Tmtb1Dm9Y8yw/cQs8+l/VLZJz5HsFvMO4AhHV+uHo8PYpxmQz7i9VntWQdl
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:c02:: with SMTP id
 f2mr1895485ybq.234.1621454650549; Wed, 19 May 2021 13:04:10 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:39 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-11-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 10/10] KVM: selftests: add shared hugetlbfs backing source type
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

This lets us run the demand paging test on top of a shared
hugetlbfs-backed area. The "shared" is key, as this allows us to
exercise userfaultfd minor faults on hugetlbfs.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c |  6 ++++--
 tools/testing/selftests/kvm/include/test_util.h  | 11 +++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c       |  9 +++++++--
 tools/testing/selftests/kvm/lib/test_util.c      | 11 +++++++++++
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index df7190261923..60d9b5223b9d 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -485,8 +485,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	TEST_ASSERT(p.uffd_mode != UFFDIO_REGISTER_MODE_MINOR || p.src_type == VM_MEM_SRC_SHMEM,
-		    "userfaultfd MINOR mode requires shared memory; pick a different -t");
+	if (p.uffd_mode == UFFDIO_REGISTER_MODE_MINOR &&
+	    !backing_src_is_shared(p.src_type)) {
+		TEST_FAIL("userfaultfd MINOR mode requires shared memory; pick a different -t");
+	}
 
 	for_each_guest_mode(run_test, &p);
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 7377f00469ef..d79be15dd3d2 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -17,6 +17,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <sys/mman.h>
 #include "kselftest.h"
 
 static inline int _no_printf(const char *format, ...) { return 0; }
@@ -85,6 +86,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
+	VM_MEM_SRC_SHARED_HUGETLB,
 	NUM_SRC_TYPES,
 };
 
@@ -101,4 +103,13 @@ size_t get_backing_src_pagesz(uint32_t i);
 void backing_src_help(void);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 
+/*
+ * Whether or not the given source type is shared memory (as opposed to
+ * anonymous).
+ */
+static inline bool backing_src_is_shared(enum vm_mem_backing_src_type t)
+{
+	return vm_mem_backing_src_alias(t)->flag & MAP_SHARED;
+}
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0b88d1bbc1e0..8373aec1fb02 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -758,8 +758,13 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		region->mmap_size += alignment;
 
 	region->fd = -1;
-	if (src_type == VM_MEM_SRC_SHMEM) {
-		region->fd = memfd_create("kvm_selftest", MFD_CLOEXEC);
+	if (backing_src_is_shared(src_type)) {
+		int memfd_flags = MFD_CLOEXEC;
+
+		if (src_type == VM_MEM_SRC_SHARED_HUGETLB)
+			memfd_flags |= MFD_HUGETLB;
+
+		region->fd = memfd_create("kvm_selftest", memfd_flags);
 		TEST_ASSERT(region->fd != -1,
 			    "memfd_create failed, errno: %i", errno);
 
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index c7a265da5090..6ad6c8276b2e 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -240,6 +240,16 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			.name = "shmem",
 			.flag = MAP_SHARED,
 		},
+		[VM_MEM_SRC_SHARED_HUGETLB] = {
+			.name = "shared_hugetlb",
+			/*
+			 * No MAP_HUGETLB, we use MFD_HUGETLB instead. Since
+			 * we're using "file backed" memory, we need to specify
+			 * this when the FD is created, not when the area is
+			 * mapped.
+			 */
+			.flag = MAP_SHARED,
+		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
@@ -262,6 +272,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
 	case VM_MEM_SRC_ANONYMOUS_HUGETLB:
+	case VM_MEM_SRC_SHARED_HUGETLB:
 		return get_def_hugetlb_pagesz();
 	default:
 		return MAP_HUGE_PAGE_SIZE(flag);
-- 
2.31.1.751.gd2f1c929bd-goog

