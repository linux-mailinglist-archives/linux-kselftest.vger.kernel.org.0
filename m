Return-Path: <linux-kselftest+bounces-33214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA913ABA395
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F8A7B7992
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD2280A32;
	Fri, 16 May 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hC5C1MpO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B3280039
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423198; cv=none; b=qQ40Bnq6KOIBI/qE0z9UC3zwpk0wu0xnG2N9B4mi+JVvCirAASFOTMTp9cm9cirREMqORkSWOg/SD+DVxdgky8ntJUqDLBXUMicQ41SaJderdwU95cJl3kquIAJ80bUOoKCt2GJFyZHynSwI4uioETo9XuQZdNRrkOxSyi41im8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423198; c=relaxed/simple;
	bh=bfcQAMQ9jjnW3Lu5W8t13tUmLA+8UB1NqYqKNZ64Ov0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VkwkTxCGaV3E8lpzQduPQUya3bDiJH2brgiWkIwkL2S79XJ8JwJGiZqBz13noryTU9Cc7I4kKKbuvCczsegQrR+MJwItjxhelqiSJxzD6neMf34uYY+WF6t+ftWiIYcDFmQhP4o+z6lCntfOWqbF62qdzxK4AijC7HkXTn2CoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hC5C1MpO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7370e73f690so2830627b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423196; x=1748027996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhioi7Gcj72mRexvdqlPLPc4DSIey+OidUjZOy0mNj0=;
        b=hC5C1MpOB3pSC/CggDkn/nuGVcxPM+7bQ7ENWFHCYJL7tRFOkfTE3cpLIH7lXfdyZg
         81Rilrtd4HIrTlQXj8h/7IQ4ksRFt9PV/GdvDXSWKkTsfEatUE+DWkUthj5Bjp05NGii
         GU3FjHHMzcAkiaK4Zle/+3/AGOw17YPl7DTXzt5RNbEH9MCKGNiSTfdEIuByQWyVUXbt
         HRCBl5fWUys0wTRnIsMleRjdXPlYLsjTKMp1zf1mZV4vnvxz+snFCZAyw0jVoX+U3NQ8
         ak2bgLK7ZBErh1wFVL67QG5GuWm+kAuZPRrkgbD/Kjs09Ssy3kxgFklNpIds89MzUybe
         OyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423196; x=1748027996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhioi7Gcj72mRexvdqlPLPc4DSIey+OidUjZOy0mNj0=;
        b=VqPHDidVjqR1+mWLo+XgAdkmO1sj7zf1sDGUTQwWW/xpva/BWGAryMYWnOOzB1J3FP
         r+oJZ+cnqkOjx2uenvziaa2fGyWOf1oPP0LddJwFGCE+vybtH4OnyYXghYrRzGMfWRHN
         lVmmJOV2mhhkLI2LalMMLSNBOUegNiQ+YQ7exaSdsKHEp7JGo08dEyW+LxUiCvhDvjQJ
         MPkqVXO4/8SvT04fRYX//6gFhonleaJQa2aXaZPVTUH6wMVKx0f7P3YTGp3g7Fr7AH7u
         3X/hjElCZfkhtOQIsBRm72SvZ47qR8NvorZy1vzUG90r4fx903mjfJCUxQDw3ZAtI2Ny
         eWmA==
X-Forwarded-Encrypted: i=1; AJvYcCVZX10jYXrIM0597lLa/bZ3ooRxhsVr5OwUB3+qWoFcb+wPNLGZjS7S0h54gnxHOl1oRyJUmRniTyPnieL2XIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUabIIa2ox/ttIHk7eGIDdVSEOYsn4DligD9tB3WkiBmWWRrZ
	DsAbuO1ppoZToyeG78fuZsuVxArFKtTOUi7MhAKRF2vF6W2ZWr1GbTi0H9w1IWyKSbauKSsq6MV
	CJuUApea24w==
X-Google-Smtp-Source: AGHT+IEfkAWU/U59zbcJcvSExnx+OOOVI8NlhezCdt4M6QGEKDcwIKgF2uEEwit281pMZ3Ls6GbeSRldOOqo
X-Received: from pfdf22.prod.google.com ([2002:aa7:8b16:0:b0:742:a71a:ea85])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88cc:0:b0:742:a02e:dd82
 with SMTP id d2e1a72fcca58-742a98dce7fmr5684560b3a.22.1747423195895; Fri, 16
 May 2025 12:19:55 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:25 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <1ade7750adbfe39ca5b8e074ad5edb37a7bc7e54.1747368092.git.afranji@google.com>
Subject: [RFC PATCH v2 05/13] KVM: selftests: Add tests for
 KVM_LINK_GUEST_MEMFD ioctl
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Test that

+ Invalid inputs should be rejected with EINVAL
+ Successful inputs return a new (destination) fd
+ Destination and source fds have the same inode number
+ No crash on program exit

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 43 +++++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  | 18 ++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ce687f8d248f..9b2a58cd9b64 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -170,6 +170,48 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 	close(fd1);
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
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with a non-gmem fd */
+	dst_fd = __vm_link_guest_memfd(dst_vm, 0, 1);
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with invalid flags */
+	dst_fd = __vm_link_guest_memfd(dst_vm, src_fd, 1);
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with an already-associated vm */
+	dst_fd = __vm_link_guest_memfd(src_vm, src_fd, 1);
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	dst_fd = __vm_link_guest_memfd(dst_vm, src_fd, 0);
+	TEST_ASSERT(dst_vm > 0, "linking should succeed with valid inputs");
+	TEST_ASSERT(src_fd != dst_fd, "linking should return a different fd");
+
+	ret = fstat(src_fd, &src_stat);
+	TEST_ASSERT_EQ(ret, 0);
+	ret = fstat(dst_fd, &dst_stat);
+	TEST_ASSERT_EQ(ret, 0);
+	TEST_ASSERT(src_stat.st_ino == dst_stat.st_ino,
+		    "src and dst files should have the same inode number");
+}
+
 int main(int argc, char *argv[])
 {
 	size_t page_size;
@@ -194,6 +236,7 @@ int main(int argc, char *argv[])
 	test_file_size(fd, page_size, total_size);
 	test_fallocate(fd, page_size, total_size);
 	test_invalid_punch_hole(fd, page_size, total_size);
+	test_link(vm, fd, total_size);
 
 	close(fd);
 }
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 373912464fb4..68faa658b69e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -571,6 +571,24 @@ static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
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
2.49.0.1101.gccaa498523-goog


