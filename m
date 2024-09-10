Return-Path: <linux-kselftest+bounces-17680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43AF9746BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DA02872F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72F1BDABC;
	Tue, 10 Sep 2024 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDbckmXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0921BDA87
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011903; cv=none; b=okFy7dg20uAbGcPkvbsTS5PPfCsJNO+MzuwIpZZugfaQIpvWO2kwwM/CF6K3JQqu7Z9KeRI+iAT3u+FmW2ut8dZyRTRYIx7eOAnoX7vfKGpxq8SlkSPMr2cWu3a6UwJZOVJpIZl18CnckjljUgwV8XHceeh0DArObNlmXw84qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011903; c=relaxed/simple;
	bh=vc4EsPZFORRD3kG426hVT8sa27BXWZ1MjE0MPigLyyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5QH7Gu2lCZjXh9uzhi3YV2fvQR/j/UqueICoCMY8D4pMsWJ8gW9eW/QkfsP2FG/fJ6U1bX98vryo11LQHGx6YOzJYc+iL5WfEUBwAQDun5gCMrcOksBGiCBrYQ3TAFfKPUikwY4gDhxBGwiv2PoH5jUQoQsrclnEGidZQQeCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDbckmXP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d6b2b9a534so37702287b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011901; x=1726616701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/HXd5Kdj9SBXB3jabZ8LV/kfZeRyP8D+V3Q9EiJjcU=;
        b=cDbckmXPSsZT2jTkf0XcEaq+GE5mmfBUixvfmptWQ58c2Dl+kXE077kGPGiZw/7aD3
         zPgtanCGvlgy2S4YHQTxxR62Gq2iZJgegWkqnl+95N/dCs/f8TTK68sBo9oOyPOqgo4q
         YI/WPNJmybEl0DwLoKZ/AZQ9/twhmGEiLoiAcVJflsKWr6O0B7t9szjwXgfc5FXSvPlI
         IJJ5QD6wQ6ld9FrU2dETpmYTlQvP+ReylZib2WZwP7bvTe0HOkCU9+mZ2jZCfoQspDoa
         f4WKngCZwTTvTvEr49jVUATHZfcI8Ib98fStYOBKkI4IZlUG/0uC9jDHU9G484IcTRUj
         aTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011901; x=1726616701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/HXd5Kdj9SBXB3jabZ8LV/kfZeRyP8D+V3Q9EiJjcU=;
        b=mIsgNtyqb5G10hdiSf0E73a8xl4+9BpbEQRD7VIJt4wsVYdTZN0YAolBVq+pgoMzDO
         CO9Qt+PqeKTDlcLX/ZOmXOHCVWwKxecXF2/wXq/ENEaWwLgo0bZCEuSC58flTa0cXCFY
         kngwwHjQQhRVdQFLlf9KLhRlrT1jBXwi6oqplMTOQSX33m+Yo2KYQEN1d/+JmQmVD2Om
         IelR1aOLIn7Fj+Bnr/DkqTFx+ycHuigAVoe7OyeacVVlxIPhqIyse3IW+DEvik/lSw5l
         AR7T1rQwQvj0Bk6Vn0UZsZhve7F3hZnWUBPr8lWBG4u+QN9uLotDnLOX83aqHB983DJO
         Akwg==
X-Forwarded-Encrypted: i=1; AJvYcCXpL6ausEs6Oo0I7lqBVzU/Q9RGUViAl/NPnVct4ZlT9MRaXRe+ktaWIoPGnKzZpsY1a7TJTl5RubTHKxpS1wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3Omqfmkf9jUX5Li9csnzYAhpGllqPYxvbe784bh+g4pDr2FH
	4FwCJw5gujuULjCR+Gs2/0AJMjIlZRIKIBIVOWk0vJBI9dpFlx4qiJnH1c5VS9/9LflmUkvCzUT
	iLzGQtg7phz4oL4vBqA8zrQ==
X-Google-Smtp-Source: AGHT+IHO3Hz+XYA+Vm8ou+yVR+TLwcjnNq/stukVuZHNAMFeSdnEW4ysXQTgCnqywX2CHH+Ew1hV18uk9npr6EUJ3A==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:6e0a:b0:6ae:34f0:8832 with
 SMTP id 00721157ae682-6dba6d5d3e6mr543327b3.2.1726011901348; Tue, 10 Sep 2024
 16:45:01 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:48 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <2f0572464beebbcd2166fe9d709d0ce33a0cee78.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 17/39] KVM: selftests: Add basic selftests for
 hugetlb-backed guest_memfd
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

Add tests for 2MB and 1GB page sizes, and update the invalid flags
test for the new KVM_GUEST_MEMFD_HUGETLB flag.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 .../testing/selftests/kvm/guest_memfd_test.c  | 45 ++++++++++++++-----
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ba0c8e996035..3618ce06663e 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
+#include <linux/kvm.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -122,6 +123,7 @@ static void test_invalid_punch_hole(int fd, size_t page_size, size_t total_size)
 
 static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
 {
+	uint64_t valid_flags = KVM_GUEST_MEMFD_HUGETLB;
 	size_t page_size = getpagesize();
 	uint64_t flag;
 	size_t size;
@@ -135,6 +137,9 @@ static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
 	}
 
 	for (flag = 0; flag; flag <<= 1) {
+		if (flag & valid_flags)
+			continue;
+
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		TEST_ASSERT(fd == -1 && errno == EINVAL,
 			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
@@ -170,24 +175,16 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 	close(fd1);
 }
 
-int main(int argc, char *argv[])
+static void test_guest_memfd(struct kvm_vm *vm, uint32_t flags, size_t page_size)
 {
-	size_t page_size;
 	size_t total_size;
 	int fd;
-	struct kvm_vm *vm;
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
 
-	page_size = getpagesize();
 	total_size = page_size * 4;
 
-	vm = vm_create_barebones();
-
-	test_create_guest_memfd_invalid(vm);
-	test_create_guest_memfd_multiple(vm);
-
-	fd = vm_create_guest_memfd(vm, total_size, 0);
+	fd = vm_create_guest_memfd(vm, total_size, flags);
 
 	test_file_read_write(fd);
 	test_mmap(fd, page_size);
@@ -197,3 +194,31 @@ int main(int argc, char *argv[])
 
 	close(fd);
 }
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
+
+	vm = vm_create_barebones();
+
+	test_create_guest_memfd_invalid(vm);
+	test_create_guest_memfd_multiple(vm);
+
+	printf("Test guest_memfd with 4K pages\n");
+	test_guest_memfd(vm, 0, getpagesize());
+	printf("\tPASSED\n");
+
+	printf("Test guest_memfd with 2M pages\n");
+	test_guest_memfd(vm, KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_2MB,
+			 2UL << 20);
+	printf("\tPASSED\n");
+
+	printf("Test guest_memfd with 1G pages\n");
+	test_guest_memfd(vm, KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_1GB,
+			 1UL << 30);
+	printf("\tPASSED\n");
+
+	return 0;
+}
-- 
2.46.0.598.g6f2099f65c-goog


