Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5014F37EF51
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 01:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbhELXEg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 19:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390040AbhELVtW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 17:49:22 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC8C06121A
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:16 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 1-20020aed31010000b029019d1c685840so16700881qtg.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L2NNDNh+hgASTvjB+YiQroB4OhnVKpDdWzCu7PeehzQ=;
        b=f/jWqQ9KrReYTTcLlSByNRew6FCsKM1EvpOY6NccUCKPvBGo/JQ4Zxqp+Y9qdFB990
         +ppzycm59zMkwaQn5JB3+WQrWFuHIUB51D/IExtH3kHfqQy7KV4xRmUfSvB5zMyym+5G
         TLlMSt8evZA5NNZagdBNH9Qf04w+rO/dsWryvqWKU6DKDptYEPlTI0XBk7J8ppG5Jxho
         p9ur6H3WcWjXmfJo0OsUqOPujxxTfEZBCyrkWgpZeGut4UQVgKVfweicGfBXTBbSaKFD
         9LxR/mFKzVoks3DH8wdXU7A3Pj/Uk55aP9AZ387d1ryZA3jEYsk07gR7lV4mV2jNWFvL
         5RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L2NNDNh+hgASTvjB+YiQroB4OhnVKpDdWzCu7PeehzQ=;
        b=MNOU47T3VEmifuY7Pj19cRILJp3VG+73Mf5kR7/v0dTE03ehHRuGASwtETxxa+D4iH
         fx/ulV7e8d7NK+mmoXj8qLtCarVTTIfHGzDUx1E/Hlzjy3FF6UV9zn1vEHF2cJ2pA+Fv
         3hnFJ1lSlZBifAt5uVo5N7W2ABjr4pKpL+BoqthOGYAW3hzQgDEKMa7Hh9X+0vmBrlQh
         gE8Pptwsljl7yRWQdY8imFFh5bnbWWUcYrm5XMxKtzJyqePvlP4padeuBT2PtorA8gG0
         M2j42IOQyZFrZXCxVMJFMbp+RPbv+nMR+AgBWVs98PFhSCbN2qeUPBAR7SYssf6yldUy
         vSPg==
X-Gm-Message-State: AOAM5314yItv7LuU1huCHgJG2W9PLHFmQkMxaro5DQucUpQIcXcLdN3+
        om1Dt4sRF38ixFS3ha5MQSSmhblRPs7LcMW/YR5S
X-Google-Smtp-Source: ABdhPJwmZd1tQ0tXLXGE1m4mOZ8nKprfTo961VKDRhbFhsEOZfmfNUk6cuiyjbyK+g36JmjmfxxYDg5OhcHVQXYya+QJ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:29e5:10fc:1128:b0c0])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:aa44:: with SMTP id
 e4mr37564404qvb.41.1620855915420; Wed, 12 May 2021 14:45:15 -0700 (PDT)
Date:   Wed, 12 May 2021 14:45:02 -0700
In-Reply-To: <20210512214502.2047008-1-axelrasmussen@google.com>
Message-Id: <20210512214502.2047008-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 5/5] KVM: selftests: add shared hugetlbfs backing source type
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
 tools/testing/selftests/kvm/include/test_util.h  | 10 ++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c       |  9 +++++++--
 tools/testing/selftests/kvm/lib/test_util.c      |  6 ++++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index ff29aaea3120..32942c9e0376 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -502,8 +502,10 @@ int main(int argc, char *argv[])
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
index 7377f00469ef..852d6d2cc285 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -85,9 +85,19 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
+	VM_MEM_SRC_SHARED_HUGETLB,
 	NUM_SRC_TYPES,
 };
 
+/*
+ * Whether or not the given source type is shared memory (as opposed to
+ * anonymous).
+ */
+static inline bool backing_src_is_shared(enum vm_mem_backing_src_type t)
+{
+	return t == VM_MEM_SRC_SHMEM || t == VM_MEM_SRC_SHARED_HUGETLB;
+}
+
 struct vm_mem_backing_src_alias {
 	const char *name;
 	uint32_t flag;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 838d58633f7e..fed02153c919 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -756,8 +756,13 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
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
index c7a265da5090..65fb8b43782c 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -240,6 +240,11 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			.name = "shmem",
 			.flag = MAP_SHARED,
 		},
+		[VM_MEM_SRC_SHARED_HUGETLB] = {
+			.name = "shared_hugetlb",
+			/* No MAP_HUGETLB, we use MFD_HUGETLB instead. */
+			.flag = MAP_SHARED,
+		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
@@ -262,6 +267,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
 	case VM_MEM_SRC_ANONYMOUS_HUGETLB:
+	case VM_MEM_SRC_SHARED_HUGETLB:
 		return get_def_hugetlb_pagesz();
 	default:
 		return MAP_HUGE_PAGE_SIZE(flag);
-- 
2.31.1.607.g51e8a6a459-goog

