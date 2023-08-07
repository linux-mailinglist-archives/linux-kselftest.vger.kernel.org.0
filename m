Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92BA77333B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjHGXBx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjHGXBh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B4610F6
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c04f5827eso3412788a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449294; x=1692054094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyOCciFW2Ckh/B5HTo1lu/EKNDU2b8Raj4KNQZ3bNy8=;
        b=uJOBS3ugweQYN52NY8pPJP4fC3zUz1c9ojo4XDlVUsFi/jjOlgJHXUyLp5Nc+LyD6W
         wx7xXrNG1HaypGEEtSSWkQYc/mZdvXmHOXd+WmY7Nmgt6Ohwr2RGh+lKOC5XbxZgSPxh
         LafphqQEjrKPgmBjxtLTK1R4CSWGCA7SbhmNpnkrvdmR0ni/LKS9/zt7P8JZ6kqTpjqP
         FaCeA+MEOK1Xfexus/CBFMyDCLf9cu+S4Tcvnqkbomm6V4EaSh8N9J5m511j9MKKq5Kd
         vdxNFuYw5vsbZDO4/RjPf9H4UmvjjuYAFcn2lbbHHKsW/C0CL1KLHTL0cyNTNOObV5Xi
         QjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449294; x=1692054094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyOCciFW2Ckh/B5HTo1lu/EKNDU2b8Raj4KNQZ3bNy8=;
        b=eE2BEaHpnsHSF0N4+zvSXkYHTsgKfSg2RSIFKJ0IMRKS4HFOEnfneiuTJ5KFISZqIL
         Cvw0KiE3YuA7Gl+8yzyWbTwvSSFvKpJRpCq4VXizcCYgb35r9zoiEVuME65U1w/uU9J/
         LWW9m4iY4y2CCU9pqAK4pTBCQSKccIk1OBF7oufC2FeHUVeu2k871N8yFBYrv9qS/xA+
         y9//osqulmM3+YEuE4dnCVn+rQkm8qoi9uEdEUbhrc8/uk91ePACvRh3iOTa0QXDCHeu
         TEGBLcK97vvcXfmzZGqMlbzk9Y5CNNjr20YwRF36AIHTv3rHgMiMH616qgs6zxbTI7dh
         RHNQ==
X-Gm-Message-State: AOJu0YyzX24313T0RlMl+46FNRhzKGQPHCgJJFqu2IKrjYOVcPRlbv7c
        SJ8Zq6LigxP1aecu/ea/QFZYjblFk5jTt5295w==
X-Google-Smtp-Source: AGHT+IGDqRrAoKu8LLVlLzg0wrThTAqsAaU5hSETrzotqJdKs6jztrKmnPwLxXOwvdhsHXsv9IcmQ/gkxtMnMsbr2Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:b512:0:b0:564:9785:75c with SMTP
 id y18-20020a63b512000000b005649785075cmr35489pge.10.1691449293726; Mon, 07
 Aug 2023 16:01:33 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:06 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <a6578d60b14a94b9895272c202cc47025257fc9b.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 03/11] KVM: selftests: Add tests for KVM_LINK_GUEST_MEMFD ioctl
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

Test that

+ Invalid inputs should be rejected with EINVAL
+ Successful inputs return a new (destination) fd
+ Destination and source fds have the same inode number
+ No crash on program exit

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 42 +++++++++++++++++++
 .../selftests/kvm/include/kvm_util_base.h     | 18 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ad20f11b2d2c..38fe96ea60f9 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -105,6 +105,47 @@ static void test_create_guest_memfd_invalid(struct kvm_vm *vm, size_t page_size)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+static void test_link(struct kvm_vm *src_vm, int src_fd, size_t total_size)
+{
+	int ret;
+	int dst_fd;
+	struct kvm_vm *dst_vm;
+	struct stat src_stat;
+	struct stat dst_stat;
+
+	dst_vm = vm_create_barebones();
+
+	/* Linking with a nonexistent fd */
+	dst_fd = __vm_link_guest_memfd(dst_vm, 99, 0);
+	ASSERT_EQ(dst_fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with a non-gmem fd */
+	dst_fd = __vm_link_guest_memfd(dst_vm, 0, 1);
+	ASSERT_EQ(dst_fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with invalid flags */
+	dst_fd = __vm_link_guest_memfd(dst_vm, src_fd, 1);
+	ASSERT_EQ(dst_fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with an already-associated vm */
+	dst_fd = __vm_link_guest_memfd(src_vm, src_fd, 1);
+	ASSERT_EQ(dst_fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	dst_fd = __vm_link_guest_memfd(dst_vm, src_fd, 0);
+	TEST_ASSERT(dst_vm > 0, "linking should succeed with valid inputs");
+	TEST_ASSERT(src_fd != dst_fd, "linking should return a different fd");
+
+	ret = fstat(src_fd, &src_stat);
+	ASSERT_EQ(ret, 0);
+	ret = fstat(dst_fd, &dst_stat);
+	ASSERT_EQ(ret, 0);
+	TEST_ASSERT(src_stat.st_ino == dst_stat.st_ino,
+		    "src and dst files should have the same inode number");
+}
 
 int main(int argc, char *argv[])
 {
@@ -126,6 +167,7 @@ int main(int argc, char *argv[])
 	test_mmap(fd, page_size);
 	test_file_size(fd, page_size, total_size);
 	test_fallocate(fd, page_size, total_size);
+	test_link(vm, fd, total_size);
 
 	close(fd);
 }
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 8bdfadd72349..868925b26a7b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -495,6 +495,24 @@ static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
 	return fd;
 }
 
+static inline int __vm_link_guest_memfd(struct kvm_vm *vm, int fd, uint64_t flags)
+{
+	struct kvm_link_guest_memfd params = {
+		.fd = fd,
+		.flags = flags,
+	};
+
+	return __vm_ioctl(vm, KVM_LINK_GUEST_MEMFD, &params);
+}
+
+static inline int vm_link_guest_memfd(struct kvm_vm *vm, int fd, uint64_t flags)
+{
+	int new_fd = __vm_link_guest_memfd(vm, fd, flags);
+
+	TEST_ASSERT(new_fd >= 0, KVM_IOCTL_ERROR(KVM_LINK_GUEST_MEMFD, new_fd));
+	return new_fd;
+}
+
 void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 			       uint64_t gpa, uint64_t size, void *hva);
 int __vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
-- 
2.41.0.640.ga95def55d0-goog

