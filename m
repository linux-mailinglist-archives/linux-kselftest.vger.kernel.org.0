Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC2783158
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjHUToW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjHUToV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 15:44:21 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42D0D9
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 12:44:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56c379a8250so1202864a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692647059; x=1693251859;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SSCma3xFa9r8jkJRJYtQ3UJXMDuR6ih/O0h93W+17hY=;
        b=PGySCjo26AZB9cqV8KpF/JMeY7vWef/kDAGS6lGDo0Q2RuJIf9UzSHhuepJrUdYeDP
         3wsRtqVlyyhBzLg4NgnhNCDBql5wFYZXsWqJsTcRl1mU2NMggXSYZeYvlEGM5PpwIXvP
         Iielz22yjvHt+QiS4NJj5jraczBUg9QlX3xA9A8GDGKLxHpG8GP/uEWad2wSPgfT93sp
         EZ7hJaU0K7Ub0I5m2uJSamCTcj1KKMUbq+P7B36rHl21GsY7ypgdNkMCI3OMsw5Bbwl2
         k8PVgGtQS/r/6BfdZ40O7B8paUefkaPLaVdXZYLeI194w5SGzeP5V2ybLicvfal8Jy53
         Rw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647059; x=1693251859;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSCma3xFa9r8jkJRJYtQ3UJXMDuR6ih/O0h93W+17hY=;
        b=dVu+jvjnfv4dUySVqDAvtm3cK9Op2dZdy9+mQWyYElIHbzZExnEWQHltBp6qGLGqtv
         5PFcsljNVGWdRFpCHDi7IX+BRNVct+nRRcgebCd57Doaq6bYsZMwnReXrQc2GnIhEtfK
         Va1kiR72hNqPbqyhNHelVl3zRHayz995qYh77NQovcSzDGlxktBLKDXpPbBod9BtDkw5
         Bf+cN2vyoHumPjNAdN0BPxZVsGgpH2bIIqXEQDcwGuOQqMtcjZ+UmxbDsVnzbBgh4+Sv
         tRWAWT6lOycZ3ufwmTXrW2J6jKec85b3uAQ5o0DI7TzCJeKWygYiS8ahWROzBLFXIQiN
         MR2A==
X-Gm-Message-State: AOJu0YyzbJe1EASCYkzyvFQQJok0N3j5eecSQj8uUFKHbjAGrIC24bXp
        qd19N5CoL8iYbyDmiVUQekOARhJ0GKc8+WsIfQ==
X-Google-Smtp-Source: AGHT+IFZOgwoG4uIlCSpVcliJBnuI18zwdWZJ8yxViklw8jp6EKLckJ2Gu/KsjtW8j9EbVROEO3Wi7ZjHJ6bUpcQ0Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:41d0:b0:1b8:84d9:dea6 with
 SMTP id u16-20020a17090341d000b001b884d9dea6mr3274875ple.12.1692647059281;
 Mon, 21 Aug 2023 12:44:19 -0700 (PDT)
Date:   Mon, 21 Aug 2023 19:44:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821194411.2165757-1-ackerleytng@google.com>
Subject: [PATCH] KVM: selftests: Add tests - invalid inputs for KVM_CREATE_GUEST_MEMFD
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
 .../testing/selftests/kvm/guest_memfd_test.c  | 33 +++++++++++++++++++
 .../selftests/kvm/include/kvm_util_base.h     | 11 +++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index eb93c608a7e0..a8e37f001297 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -90,6 +90,37 @@ static void test_fallocate(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
 }
 
+static void test_create_guest_memfd_invalid(struct kvm_vm *vm, size_t page_size)
+{
+	int fd;
+	uint64_t size;
+	uint64_t flags;
+	uint64_t valid_flags = 0;
+
+	for (size = 1; size < page_size; size++) {
+		fd = __vm_create_guest_memfd(vm, size, 0);
+		TEST_ASSERT(
+			fd == -1,
+			"Creating guest memfds with non-page-aligned page sizes should fail");
+		TEST_ASSERT(errno == EINVAL, "... and errno should be set to EINVAL");
+	}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	valid_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+#endif
+
+	for (flags = 1; flags; flags <<= 1) {
+		if (flags & valid_flags)
+			continue;
+
+		fd = __vm_create_guest_memfd(vm, page_size, flags);
+		TEST_ASSERT(
+			fd == -1,
+			"Creating guest memfds with invalid flags should fail");
+		TEST_ASSERT(errno == EINVAL, "... and errno should be set to EINVAL");
+	}
+}
+
 
 int main(int argc, char *argv[])
 {
@@ -103,6 +134,8 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_barebones();
 
+	test_create_guest_memfd_invalid(vm, page_size);
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

