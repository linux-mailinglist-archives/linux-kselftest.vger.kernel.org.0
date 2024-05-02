Return-Path: <linux-kselftest+bounces-9274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDE8BA118
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E674281192
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697317B518;
	Thu,  2 May 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkXNxnVX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA71E877
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678680; cv=none; b=J5oIvGvqNJi3jb4NhigU62Y2AOPTOPuD97ZGyvU6QlNw+gK/rcIXPGgQ+PQbSLF+IMD8/nUiKfoSC2a8sS4zPSZVZXbYLwq3xpP4Y6HebMYlkGhFveipv7iBN7HgdGQgK7gn00CYB6TTKk7jtsZ0uQ4IEJ6SmrReWD/gLMzBt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678680; c=relaxed/simple;
	bh=zB3xTuyZbgX8sdF/Cs7DRyt+/+BNC4nMKcVIYlmLyhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggFOrr0NYFT/+wv2PxC9KWhoIngV0a2B70BbYFvb3sbIzF4ZgDwCMoJsAvzwNecZBIRTWPkGC4LYLo+Bi5EeabArOd1/jA0hsK8dHXmmmIYwK0U4b8ud7jqcdI2tGYU6rDBt4/nhhD1GFiaf69//TQk4iu30w08K4KW+zdqrtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkXNxnVX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso978447276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714678678; x=1715283478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AFo+rWPM0rSLEMNbLLPaQl2EL3t3+SEPUFV0x84rCE=;
        b=BkXNxnVXg2ls8D3Ty9aFPAi5XxN/wu/jxC7wiee8P0GC2HymUIaNRXop4IZRRpQOHl
         FTCY5Qt2NghVMHTA7aUf/zeYVj2rvN5ym2ldo8s3FX09LtdizH7SOPJ/8yfIRTfeket7
         PR7czPjqBqcbyxgHOjn3FjzHIWPdIAsCCEE/nekfYUkUJADGKJTLrCE8jWA4FNqnvCck
         KTXprNY7oFAIlqzmJkuvjHrRqDJEAXhC8AEaF8KfcrKKywpe+NIABGiEVkDGdnYMmjeR
         cvCPCbgjl5D1UQ1BTcS9DeTv+9ymrbTueYnnyF0QuTOrqluTtwUYaVHHujvAyFEbNFwG
         A6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678678; x=1715283478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AFo+rWPM0rSLEMNbLLPaQl2EL3t3+SEPUFV0x84rCE=;
        b=fbmKljAKuU6dR2etjqO5puVqp42qwizhtsv9X/fN0fqt2N9/YiwoszOXIzyc1pUgca
         s+muCZVVjDUzzOC0hAbx75Byn/G+IKjjTJMqpCw46/v+fGbUO+jfAwET9uYnT60zXkBl
         C3SjUmeotLAhpZZNSyM6uXzC8Dq/BwcAABpyOclLTCXgN6T6sC1Rqo4T0rPyE0fqrAMk
         aPhRQGmm9MJwVLx9WWPq3OfuaumuZZt3GuGlRQPwYoDk0eSBTa4JSf5Qo45yLI/upg8T
         FimpS+fIjrwvzZhlMG+WXAX7b6/wpLMivIZzNx61ozZ4MHsCewTELG7+rx8Li08Tv3+q
         HR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFALZLLlefQcezEW4ZSyxJOgreMhn6C0Y4Lp6IMVnlqPULq/JdQU1pNmDgifamFbr/qdwUmM+bkpu3GufCaWmspY+LQ+8UgvtivM7/Jb6u
X-Gm-Message-State: AOJu0YxnxRitxgfEOW7Psz173pOy4CzwNyHKcntIx0o3nitMeYBOIxFg
	6KaX2pBEDmEhCxvGH0/bEptvNlQN54uvEFi07G/lDnnuR9AoZNo93WBAW6j34OBWna7nVhB1vju
	edw==
X-Google-Smtp-Source: AGHT+IHTZuZmwfOPEshApicWMHuRZRqYNPfI7JDHkDmawakUOBh+D03pZylyG9GgsJpLZl5KrfZnSPSqjzM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c12:b0:dd9:20c1:85b6 with SMTP id
 fs18-20020a0569020c1200b00dd920c185b6mr240542ybb.2.1714678677992; Thu, 02 May
 2024 12:37:57 -0700 (PDT)
Date: Thu, 2 May 2024 12:37:56 -0700
In-Reply-To: <20240426114552.667346-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426114552.667346-1-thuth@redhat.com>
Message-ID: <ZjPrlLNNGNh2mOmW@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Use TAP interface in the
 set_memory_region test
From: Sean Christopherson <seanjc@google.com>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 26, 2024, Thomas Huth wrote:
> Use the kselftest_harness.h interface in this test to get TAP
> output, so that it is easier for the user to see what the test
> is doing. (Note: We are not using the KVM_ONE_VCPU_TEST_SUITE()
> macro here since these tests are creating their VMs with the
> vm_create_barebones() function, not with vm_create_with_one_vcpu())
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Rebase to linux-next branch
>  - Make "loops" variable static
>  - Added Andrew's Reviewed-by
> 
>  .../selftests/kvm/set_memory_region_test.c    | 86 +++++++++----------
>  1 file changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 68c899d27561..a5c9bee5235a 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -16,6 +16,7 @@
>  #include <test_util.h>
>  #include <kvm_util.h>
>  #include <processor.h>
> +#include "kselftest_harness.h"
>  
>  /*
>   * s390x needs at least 1MB alignment, and the x86_64 MOVE/DELETE tests need a
> @@ -38,6 +39,8 @@ extern const uint64_t final_rip_end;
>  
>  static sem_t vcpu_ready;
>  
> +static int loops;

...

> -static void test_add_overlapping_private_memory_regions(void)
> +TEST(add_overlapping_private_memory_regions)
>  {
>  	struct kvm_vm *vm;
>  	int memfd;
>  	int r;
>  
> -	pr_info("Testing ADD of overlapping KVM_MEM_GUEST_MEMFD memory regions\n");
> +	if (!has_cap_guest_memfd())
> +		SKIP(return, "Missing KVM_MEM_GUEST_MEMFD / KVM_X86_SW_PROTECTED_VM");

I like that we can actually report sub-tests as being skipped, but I don't like
having multiple ways to express requirements.  And IMO, this is much less readable
than TEST_REQUIRE(has_cap_guest_memfd());

AIUI, each test runs in a child process, so TEST_REQUIRE() can simply exit(), it
just needs to avoid ksft_exit_skip() so that a sub-test doesn't spit out the full
test summary.

And if using exit() isn't an option, setjmp()+longjmp() will do the trick (I got
that working for KVM_ONE_VCPU_TEST() before I realized tests run as a child).

The below is lightly tested, but I think it does what we want?

I also think we would effectively forbid direct use of TEST().  Partly because
it's effectively necessary to use TEST_REQUIRE(), but also so that all tests will
have an existing single point of contact if we need/want to make similar changes
in the future.

Lastly, would using a fixture allow throwing "loops" into a structure that is
passed to each sub-test?  Having the global is obviously not a big deal, but it'd
be nice if the early conversions to the TAP-friendly framework demonstrate the
"right" way to do things, because they'll inevitably become the blueprint for all
future conversions.

---
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 2 May 2024 12:32:04 -0700
Subject: [PATCH] KVM: selftests: Allow using TEST_REQUIRE in kselftest harness
 testcases

TODO: write me

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_test_harness.h  |  4 ++++
 .../testing/selftests/kvm/include/test_util.h | 24 +++++++++++++++----
 tools/testing/selftests/kvm/lib/kvm_util.c    |  2 ++
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  3 +--
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_test_harness.h b/tools/testing/selftests/kvm/include/kvm_test_harness.h
index 8f7c6858e8e2..eda1c08c7c2b 100644
--- a/tools/testing/selftests/kvm/include/kvm_test_harness.h
+++ b/tools/testing/selftests/kvm/include/kvm_test_harness.h
@@ -9,6 +9,7 @@
 #define SELFTEST_KVM_TEST_HARNESS_H
 
 #include "kselftest_harness.h"
+#include "test_util.h"
 
 #define KVM_ONE_VCPU_TEST_SUITE(name)					\
 	FIXTURE(name) {							\
@@ -29,7 +30,10 @@ static void __suite##_##test(struct kvm_vcpu *vcpu);			\
 TEST_F(suite, test)							\
 {									\
 	vcpu_arch_set_entry_point(self->vcpu, guestcode);		\
+									\
+	kvm_is_sub_test = true;						\
 	__suite##_##test(self->vcpu);					\
+	kvm_is_sub_test = NULL;						\
 }									\
 static void __suite##_##test(struct kvm_vcpu *vcpu)
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849f..64c9f128fef4 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -36,10 +36,26 @@ static inline int _no_printf(const char *format, ...) { return 0; }
 #endif
 
 void __printf(1, 2) print_skip(const char *fmt, ...);
-#define __TEST_REQUIRE(f, fmt, ...)				\
-do {								\
-	if (!(f))						\
-		ksft_exit_skip("- " fmt "\n", ##__VA_ARGS__);	\
+
+extern bool kvm_is_sub_test;
+
+/*
+ * Skip the test if a required capability/feature/whatever is not available,
+ * e.g. due to lack of support in the underlying hardware, running against an
+ * older kernel/KVM, etc.  Use ksft_test_result_skip() for sub-tests to avoid
+ * spuriously printing the summary of the entire test suite.  Note, sub-tests
+ * run in a child process, and so can exit() directly, e.g. don't need to
+ * longjmp() out or do something similar to avoid killing the test as a whole.
+ */
+#define __TEST_REQUIRE(f, fmt, ...)						\
+do {										\
+	if (!(f)) {								\
+		if (kvm_is_sub_test) {						\
+			ksft_test_result_skip("- " fmt "\n", ##__VA_ARGS__);	\
+			exit(KSFT_SKIP);					\
+		}								\
+		ksft_exit_skip("- " fmt "\n", ##__VA_ARGS__);			\
+	}									\
 } while (0)
 
 #define TEST_REQUIRE(f) __TEST_REQUIRE(f, "Requirement not met: %s", #f)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6b2158655baa..4b24c454fd33 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -19,6 +19,8 @@
 
 #define KVM_UTIL_MIN_PFN	2
 
+bool kvm_is_sub_test;
+
 uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 7c92536551cc..a58e0b1c2ee5 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -195,8 +195,7 @@ KVM_ONE_VCPU_TEST(vmx_pmu_caps, lbr_perf_capabilities, guest_code)
 {
 	int r;
 
-	if (!host_cap.lbr_format)
-		return;
+	TEST_REQUIRE(host_cap.lbr_format);
 
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
 	vcpu_set_msr(vcpu, MSR_LBR_TOS, 7);

base-commit: 2489e6c9ebb57d6d0e98936479b5f586201379c7
-- 


