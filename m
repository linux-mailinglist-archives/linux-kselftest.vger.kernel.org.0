Return-Path: <linux-kselftest+bounces-17681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADB9746BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CE31F270CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755971BE256;
	Tue, 10 Sep 2024 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVvaCXSW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8611BDAB6
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011905; cv=none; b=CrvngJlS5ZYSTNWieETRaX1/njMWth8WBIoAMd46QqxIQLBvCHbfzpEXilyH0BidlQy6+4xIlQ7Qg3bmSHoplKsRnvD/TzsNX2ifSrgzhUMfNGaypnR/E3aZlJsh57xnfl/bD2LsYZ03K3SDOEEVRpP/mCUJuP8Nk07wNAlTrFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011905; c=relaxed/simple;
	bh=eWDkcOSZuZ5Pq1xHHeSym7RfOxqvVkcI++gI8lj3qk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FBcYwxBbq1nEOR9opkB5nn48yTqLaQoV6FjCMtvnAgtMheSxoweaClLcRE4zg7ls3MilTV/83FOo/hLGlrC747GCU4tq0Gu7FZci0jhuscXdFHnDaErFQZgUkvoguP94YluiS6fc1toaWw4lgjvr2P+gkTym1PJ3SQZuRH20FTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVvaCXSW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2db470aa646so2496786a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011903; x=1726616703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRCNcbi6F+8e/+W6bDlSdC9DBYtBZ6HMw9eZxHX0xEQ=;
        b=TVvaCXSWAqvlTaSewTvfrylxAXS694NKkoQgWuUEX9xWZ7pCRo5mICqtp+EP9A1kWz
         Hp7LWM7nZYnj8ssyx7Z7G9UxWikVIwx3PpwhQaGw4UGmyGJztEVnjdtfwY087vPZ5Otx
         c0Cb4X0yPLRloaMtTK5QpI+W1/IKlErv+nmZ9XYaEI9sfe42msRHzJPGhMSQLlzHXnHG
         qKpwR5regWKj4lSR/9uXVxzAhprDQQh6bxXJMu6Mm5LWUqc7hNOzO0uMNmDWS17lsFFt
         x7L401zG4E6n6ZFxD4grdqOuHZGDTPEMlcjne6YrnyAA7WMt6rplWEM/iZk5SKhATgdG
         KhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011903; x=1726616703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRCNcbi6F+8e/+W6bDlSdC9DBYtBZ6HMw9eZxHX0xEQ=;
        b=fEkdPG0qgbXeAaBpL+devihAheTCJ+6HKOqveUiWHQ/omwRjT0W0X8fffeJ+sYoT6b
         FqZchQTeQCLVVExdP5BK5w+JncPh6S2zzuQTwHybC1/JstjAF6Sb4lnt0L/r+Sy8izfP
         B+4hK+klQuglOyeR2EmEo2tMtYEx/1jV3rQYrg9Fc2jXOLKHyWjQ+IJV6Pai05B39gAg
         tQbPYe22mmv+zomgM+TF9BPVuVKqIhqvSDmjgkZuUH4xoinkLrY0DBerzeaLOCdNZAFw
         wBy8GAEHt0eGkW4wVJBOs4qhggyp+OAngpEIOzWlWK1vhOiviEJgOg+3WalUdY/5iOxt
         0mdA==
X-Forwarded-Encrypted: i=1; AJvYcCUGoSUnppCTmDMyZEWm7MVWiiuNwkI775Az0qs7p6v7Ur3oWyHKtZGZ+G8Mfez+QLlfmYiTPhusuHk35WcWHE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxluwyp15UrwqUkHGLt2bIiXGYiIn6yYySEyARZF91/038Z9jFY
	3IgO/QzRAQDCNcNCmOUlikxRuL571K/UVqqlOaUyJ9PNlWp5KLPDUeFn2UKkMxEGftz8kUknMAe
	9+BoLW9PAmfKoUziImIRtJg==
X-Google-Smtp-Source: AGHT+IHtETmvMtzECuoQj0TF7p/fCvI8MzpUYVVeKR6wp9ZmcH42X+aBOrBQUronIKH1gIl+RV35B4SpP9LwziE8Sg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:b38d:b0:2d8:a37d:b762 with
 SMTP id 98e67ed59e1d1-2dad517ea05mr68668a91.4.1726011902955; Tue, 10 Sep 2024
 16:45:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:49 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <327dadf390b5e397074e5bcc9f85468b1467f9a6.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 18/39] KVM: selftests: Support various types of backing
 sources for private memory
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

Adds support for various type of backing sources for private
memory (in the sense of confidential computing), similar to the
backing sources available for shared memory.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 .../testing/selftests/kvm/include/test_util.h | 16 ++++
 tools/testing/selftests/kvm/lib/test_util.c   | 74 +++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849f..011e757d4e2c 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -142,6 +142,16 @@ struct vm_mem_backing_src_alias {
 	uint32_t flag;
 };
 
+enum vm_private_mem_backing_src_type {
+	VM_PRIVATE_MEM_SRC_GUEST_MEM,  /* Use default page size */
+	VM_PRIVATE_MEM_SRC_HUGETLB,    /* Use kernel default page size for hugetlb pages */
+	VM_PRIVATE_MEM_SRC_HUGETLB_2MB,
+	VM_PRIVATE_MEM_SRC_HUGETLB_1GB,
+	NUM_PRIVATE_MEM_SRC_TYPES,
+};
+
+#define DEFAULT_VM_PRIVATE_MEM_SRC VM_PRIVATE_MEM_SRC_GUEST_MEM
+
 #define MIN_RUN_DELAY_NS	200000UL
 
 bool thp_configured(void);
@@ -152,6 +162,12 @@ size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
+
+void private_mem_backing_src_help(const char *flag);
+enum vm_private_mem_backing_src_type parse_private_mem_backing_src_type(const char *type_name);
+const struct vm_mem_backing_src_alias *vm_private_mem_backing_src_alias(uint32_t i);
+size_t get_private_mem_backing_src_pagesz(uint32_t i);
+
 long get_run_delay(void);
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae837..d0a9b5ee0c01 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -15,6 +15,7 @@
 #include <sys/syscall.h>
 #include <linux/mman.h>
 #include "linux/kernel.h"
+#include <linux/kvm.h>
 
 #include "test_util.h"
 
@@ -288,6 +289,34 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 	return &aliases[i];
 }
 
+const struct vm_mem_backing_src_alias *vm_private_mem_backing_src_alias(uint32_t i)
+{
+	static const struct vm_mem_backing_src_alias aliases[] = {
+		[VM_PRIVATE_MEM_SRC_GUEST_MEM] = {
+			.name = "private_mem_guest_mem",
+			.flag = 0,
+		},
+		[VM_PRIVATE_MEM_SRC_HUGETLB] = {
+			.name = "private_mem_hugetlb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB,
+		},
+		[VM_PRIVATE_MEM_SRC_HUGETLB_2MB] = {
+			.name = "private_mem_hugetlb_2mb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_2MB,
+		},
+		[VM_PRIVATE_MEM_SRC_HUGETLB_1GB] = {
+			.name = "private_mem_hugetlb_1gb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_1GB,
+		},
+	};
+	_Static_assert(ARRAY_SIZE(aliases) == NUM_PRIVATE_MEM_SRC_TYPES,
+		       "Missing new backing private mem src types?");
+
+	TEST_ASSERT(i < NUM_PRIVATE_MEM_SRC_TYPES, "Private mem backing src type ID %d too big", i);
+
+	return &aliases[i];
+}
+
 #define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
 
 size_t get_backing_src_pagesz(uint32_t i)
@@ -308,6 +337,20 @@ size_t get_backing_src_pagesz(uint32_t i)
 	}
 }
 
+size_t get_private_mem_backing_src_pagesz(uint32_t i)
+{
+	uint32_t flag = vm_private_mem_backing_src_alias(i)->flag;
+
+	switch (i) {
+	case VM_PRIVATE_MEM_SRC_GUEST_MEM:
+		return getpagesize();
+	case VM_PRIVATE_MEM_SRC_HUGETLB:
+		return get_def_hugetlb_pagesz();
+	default:
+		return MAP_HUGE_PAGE_SIZE(flag);
+	}
+}
+
 bool is_backing_src_hugetlb(uint32_t i)
 {
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
@@ -344,6 +387,37 @@ enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
 	return -1;
 }
 
+static void print_available_private_mem_backing_src_types(const char *prefix)
+{
+	int i;
+
+	printf("%sAvailable private mem backing src types:\n", prefix);
+
+	for (i = 0; i < NUM_PRIVATE_MEM_SRC_TYPES; i++)
+		printf("%s    %s\n", prefix, vm_private_mem_backing_src_alias(i)->name);
+}
+
+void private_mem_backing_src_help(const char *flag)
+{
+	printf(" %s: specify the type of memory that should be used to\n"
+	       "     back guest private memory. (default: %s)\n",
+	       flag, vm_private_mem_backing_src_alias(DEFAULT_VM_PRIVATE_MEM_SRC)->name);
+	print_available_private_mem_backing_src_types("     ");
+}
+
+enum vm_private_mem_backing_src_type parse_private_mem_backing_src_type(const char *type_name)
+{
+	int i;
+
+	for (i = 0; i < NUM_PRIVATE_MEM_SRC_TYPES; i++)
+		if (!strcmp(type_name, vm_private_mem_backing_src_alias(i)->name))
+			return i;
+
+	print_available_private_mem_backing_src_types("");
+	TEST_FAIL("Unknown private mem backing src type: %s", type_name);
+	return -1;
+}
+
 long get_run_delay(void)
 {
 	char path[64];
-- 
2.46.0.598.g6f2099f65c-goog


