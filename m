Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710E7787C7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjHYASJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 20:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHYARg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 20:17:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342041BCC
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 17:17:34 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56fb25fdf06so266895a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692922653; x=1693527453;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G/sNhMJCqfRueV6LYWBkXLIpdFbSW87yBwkTP+RNfbM=;
        b=2ler23i86DL5CCFxUVj+/Kupip2CmkfnnkryiVtKq7OcvMMVSrjXSFKEDoAvcS8tgN
         MwJs+1pkjdD/NRexWKxFsvszAlug3qtzNlNgR3uwy+HM0Q07lLDdYNC7rJ+kUIaXKHyN
         ZrQWUjSIdaTWFP52B1Y9V/cITLwoKhF7Dl+zm4Pa1i1Xl/mV/T7eCtFzETFl9KYd/jjq
         lxoB1NM/3ytO+IbUZerGNmZiBG5ZoPNqK05W6QBImjGeAfOG3Iakwv9T5hRboMGy0K8M
         8IjX1MfDfcP07scvScJKOmK/XhD4mUSGO9ARrSyyps4iDfohCvdRG4Hx5+9LpGQgIrjs
         2ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692922653; x=1693527453;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/sNhMJCqfRueV6LYWBkXLIpdFbSW87yBwkTP+RNfbM=;
        b=hn7pbtpAAV8cryzp6LzTavGubMeUTn6oDgfcpnl+MjvlGs2jn1Wf3d+NcDITQXSru4
         V9Y9GIfWIeYEU9sE+Nxkm8diCaKYrHaOEPMG2ZEz98q6vJfWEWpSaK+BoQfEMhPknqIW
         dxp0bfrXcH9hhVMOEJtUDITBvm+iy7qTFoBoSr78hdCRqxJwwCkdS3s6r658CyRg3/pQ
         NyhSekgmFCBuolSz4ReRn1wOfwcnzr7E2jJi0b8hO3yLX/b+gg+sih5w6M6d6EePIUXf
         U+JiXN5YsnAYbDMo4dB+GTLU/XjJmX5MYuXU6HcKBdpTIvMnuRkFPXbBx+NwYd9cxvIE
         wB1A==
X-Gm-Message-State: AOJu0Yx+hiClnuUO6jeckka3OymzcjJwIfu3WCiHuzA9hD5EuesSZm/+
        T7sMxeIyHLUx1X23tzXiZYHi9HvVlu5F5Lp11Q==
X-Google-Smtp-Source: AGHT+IHGyIqwIvw3oEYEzQB/R/efGaZ3PRa7R8J3e7NnMUpHAfKVzTqlX74axC+CwZdalm5wSS3hbgbe3cloXyarTQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:8f50:0:b0:56c:6b2:95bc with SMTP
 id r16-20020a638f50000000b0056c06b295bcmr2413845pgn.6.1692922653549; Thu, 24
 Aug 2023 17:17:33 -0700 (PDT)
Date:   Fri, 25 Aug 2023 00:17:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230825001729.1952858-1-ackerleytng@google.com>
Subject: [PATCH v2] KVM: selftests: Add tests - invalid inputs for KVM_CREATE_GUEST_MEMFD
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test that invalid inputs for KVM_CREATE_GUEST_MEMFD, such as
non-page-aligned page size and invalid flags, are rejected by the
KVM_CREATE_GUEST_MEMFD with EINVAL

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 49 +++++++++++++++++++
 .../selftests/kvm/include/kvm_util_base.h     | 11 ++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index eb93c608a7e0..4d2b110ab0d6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -8,6 +8,7 @@
 #define _GNU_SOURCE
 #include "test_util.h"
 #include "kvm_util_base.h"
+#include <linux/bitmap.h>
 #include <linux/falloc.h>
 #include <sys/mman.h>
 #include <sys/types.h>
@@ -90,6 +91,52 @@ static void test_fallocate(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
 }

+static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
+{
+	uint64_t valid_flags = 0;
+	size_t page_size = getpagesize();
+	uint64_t flag;
+	size_t size;
+	int fd;
+
+	for (size = 1; size < page_size; size++) {
+		fd = __vm_create_guest_memfd(vm, size, 0);
+		TEST_ASSERT(fd == -1 && errno == EINVAL,
+			    "guest_memfd() with non-page-aligned page size '0x%lx' should fail with EINVAL",
+			    size);
+	}
+
+	if (thp_configured()) {
+		for (size = page_size * 2; size < get_trans_hugepagesz(); size += page_size) {
+			fd = __vm_create_guest_memfd(vm, size, KVM_GUEST_MEMFD_ALLOW_HUGEPAGE);
+			TEST_ASSERT(fd == -1 && errno == EINVAL,
+				    "guest_memfd() with non-hugepage-aligned page size '0x%lx' should fail with EINVAL",
+				    size);
+		}
+
+		valid_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+	}
+
+	for (flag = 1; flag; flag <<= 1) {
+		uint64_t bit;
+
+		if (flag & valid_flags)
+			continue;
+
+		fd = __vm_create_guest_memfd(vm, page_size, flag);
+		TEST_ASSERT(fd == -1 && errno == EINVAL,
+			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
+			    flag);
+
+		for_each_set_bit(bit, &valid_flags, 64) {
+			fd = __vm_create_guest_memfd(vm, page_size, flag | BIT_ULL(bit));
+			TEST_ASSERT(fd == -1 && errno == EINVAL,
+				    "guest_memfd() with flags '0x%llx' should fail with EINVAL",
+				    flag | BIT_ULL(bit));
+		}
+	}
+}
+

 int main(int argc, char *argv[])
 {
@@ -103,6 +150,8 @@ int main(int argc, char *argv[])

 	vm = vm_create_barebones();

+	test_create_guest_memfd_invalid(vm);
+
 	fd = vm_create_guest_memfd(vm, total_size, 0);

 	test_file_read_write(fd);
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 39b38c75b99c..8bdfadd72349 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -474,7 +474,8 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 }

 void vm_create_irqchip(struct kvm_vm *vm);
-static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
+
+static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
 					uint64_t flags)
 {
 	struct kvm_create_guest_memfd gmem = {
@@ -482,7 +483,13 @@ static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
 		.flags = flags,
 	};

-	int fd = __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &gmem);
+	return __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &gmem);
+}
+
+static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
+					uint64_t flags)
+{
+	int fd = __vm_create_guest_memfd(vm, size, flags);

 	TEST_ASSERT(fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_GUEST_MEMFD, fd));
 	return fd;
--
2.42.0.rc1.204.g551eb34607-goog
