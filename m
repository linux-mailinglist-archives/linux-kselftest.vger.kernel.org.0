Return-Path: <linux-kselftest+bounces-27779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C15A4835B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EEF3B8B4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263926B96C;
	Thu, 27 Feb 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNKBtjjU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE662222BA
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670888; cv=none; b=mV6j63aJNHBbNXDWewg7e9tRPWPjv7hb6lZpwyx0klEUQQfwtyBFyTYhusD6HCf0sAr/enn20Z+OqOe3929vU6a54+4S3VdSuobV09g1GoIguRrt1Ehas9bIe7MqHGqx3KG+lyVKc9sDcUXa+HX/k6Rbrtd/IlLK8iwxjnHfZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670888; c=relaxed/simple;
	bh=Da5AnvMmGpZ4+PRGJTdejXKPe0Mw/BATivoU7g5Y1W4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kFmiM4mO/oSh5HIH+ByWXwXHVV/j1atjq+60q5OLVvQAmYJahy4ZdpQnS3r6+bzUcgLPBZKXeXLiT0ph6+3NfHMr9atd8LKBfIMdvZm2it48rMgBN83o64t1Qq7P1+GbWAk4WzB8QmlHyYAgr2fZJf+Q50NZdrnkq2oqGssfzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNKBtjjU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fbff6426f5so2401960a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740670886; x=1741275686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpWebaG6ta7C4r+/QTI9Hpf7yd202gY2ilwfhDkC51w=;
        b=kNKBtjjU13WpJoaIoPawp0ckzfYmLmHUODsrBzdw3sAWug+nXB0W+shDByC+MmXNuN
         Z9uKB1HJIGDLoqX6EbpZ58TD/MJWvq858B8f3N4fSPpq4exUjzmuZfxuxxp6XXu++Zhu
         4KbLDMYgj6tdri1AmAE58l17q0ZDWFbAvg4ER1po5W3tn2ImHlMpMjMycbsTxMTNcPgG
         X5hieD3BT4cf632JuiPRP9J/HMKIc1icRAMsPHiTJXBdEbtbMawsO8vjLrub+tO1qIZB
         41M4289/6PxItFiYSCtXdPVCjkIrqS0fo3AP4rYeDGqIIgY5xT1KlId9EdY1SES8Rk2D
         2Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670886; x=1741275686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpWebaG6ta7C4r+/QTI9Hpf7yd202gY2ilwfhDkC51w=;
        b=JJ/Gg6LPZ19OUYIaJ0OcAyBxutJTNl/Gs1oDH33H6p+bQO8g3SaVastQu+FvThLjxP
         FzEBvR/02Ux8F/StDOHUhwIhSd9nFHZtQdT20Wn0HcIoF79RghtHiTH8I4YHWFK+iUYk
         6e/LaSx35VZNJmgZ4+djkcP4Rf80HSZE6QlwNwIlhTYKpqmeUNkG5eX2WFHjN0JonVCH
         BRsQspmhKmA1VRob8HGY1fTwMnirEncGbzLP71uGputkLLJTQUYpzlmY9aCiHm1GDLSb
         Q0t/m9eGbeDKj8LLrWZlzLbzIyUY0A1kONHuHqVver5Jao2UReEizNswIM57OV12WNXr
         GK5A==
X-Forwarded-Encrypted: i=1; AJvYcCVtWl3fUAdD1wKIYbk93KuYw11wwvQVbxHdJ23Jr5OHJxcvWz6m3TPYzjBBMv8VZF0tSH7ECEv79OKNPsVhJ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaFbTign3GHq6WlAt2Xpl4G0Ha39LUAqu3sKsm2qrefoB03ZK
	Ec7MR6CxGOPdW7QvPRWvSEhZ69gzdjEbzb3REA6xKRoQ7i0nlcKrlmuslforKkUf6mVUYVMaSmX
	7jQ==
X-Google-Smtp-Source: AGHT+IFr2Hi5hWjqDrFkQXi/BpmSscvvgpC48vIgUsBffnpafInukRPQsN67WY8M/RuByhyUtG6LR6vx2wo=
X-Received: from pjbov6.prod.google.com ([2002:a17:90b:2586:b0:2fa:a30a:3382])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc44:b0:2f6:f107:fae6
 with SMTP id 98e67ed59e1d1-2fe68cf3f5fmr15885811a91.23.1740670885945; Thu, 27
 Feb 2025 07:41:25 -0800 (PST)
Date: Thu, 27 Feb 2025 07:41:24 -0800
In-Reply-To: <20250227041522.1734260-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227041522.1734260-1-mlevitsk@redhat.com>
Message-ID: <Z8CHpJMdhWNDBr0E@google.com>
Subject: Re: [PATCH] KVM: selftests: access_tracking_perf_test: add option to
 skip the sanity check
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	James Houghton <jthoughton@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Anup Patel <anup@brainfault.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 26, 2025, Maxim Levitsky wrote:
> Add an option to skip sanity check of number of still idle pages,
> and force it on, in case hypervisor or NUMA balancing
> is detected.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  .../selftests/kvm/access_tracking_perf_test.c | 23 +++++++++++++++++--
>  .../testing/selftests/kvm/include/test_util.h |  1 +
>  tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++
>  3 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> index 3c7defd34f56..eafaecf086c4 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -65,6 +65,8 @@ static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
>  /* Whether to overlap the regions of memory vCPUs access. */
>  static bool overlap_memory_access;
>  
> +static bool skip_sanity_check;

I think it makes sense to keep the sanity check, but to warn instead of asserting,
which is already the proposed behavior.  I.e. the sanity check is still there,
it's only the assert that's being "skipped".  So maybe something like this?

static bool warn_on_too_many_idle_pages;

> +
>  struct test_params {
>  	/* The backing source for the region of memory. */
>  	enum vm_mem_backing_src_type backing_src;
> @@ -185,7 +187,7 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
>  	 */
>  	if (still_idle >= pages / 10) {
>  #ifdef __x86_64__

Gah, the assert needs to be applied to all architectures.  Commit 6336a810db5c
("KVM: selftests: replace assertion with warning in access_tracking_perf_test")
dropped it entirely.  It got restored by 8fcee0421386 ("KVM: selftests: Restore
assert for non-nested VMs in access tracking test"), but only for x86.

Maybe do that in a follow-up patch?  Or alternatively, introduce the boolean in a
prep patch, then enable the assert for !x86, and then finally add the command
line option to make it controllable.

I'd probably vote for the second option?

> -		TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
> +		TEST_ASSERT(skip_sanity_check,
>  			    "vCPU%d: Too many pages still idle (%lu out of %lu)",
>  			    vcpu_idx, still_idle, pages);
>  #endif
> @@ -342,6 +344,8 @@ static void help(char *name)
>  	printf(" -v: specify the number of vCPUs to run.\n");
>  	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
>  	       "     them into a separate region of memory for each vCPU.\n");
> +	printf(" -u: Skip check that after dirtying the guest memory, most (90%%) of\n"

Maybe '-w' if we go with something along the lines of "warn_on..."

> +	       "it is reported as dirty again");
>  	backing_src_help("-s");
>  	puts("");
>  	exit(0);
> @@ -359,7 +363,7 @@ int main(int argc, char *argv[])
>  
>  	guest_modes_append_default();
>  
> -	while ((opt = getopt(argc, argv, "hm:b:v:os:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hm:b:v:os:u")) != -1) {
>  		switch (opt) {
>  		case 'm':
>  			guest_modes_cmdline(optarg);
> @@ -376,6 +380,9 @@ int main(int argc, char *argv[])
>  		case 's':
>  			params.backing_src = parse_backing_src_type(optarg);
>  			break;
> +		case 'u':
> +			skip_sanity_check = true;

Do we want to allow the user to force the assert?  E.g. move the logic that sets
the default value to before the parsing of the command line, and then make this
something like:

			warn_on_too_many_idle_pages = atoi_positive(optarg);
			break;

> +			break;
>  		case 'h':
>  		default:
>  			help(argv[0]);
> @@ -386,6 +393,18 @@ int main(int argc, char *argv[])
>  	page_idle_fd = open("/sys/kernel/mm/page_idle/bitmap", O_RDWR);
>  	__TEST_REQUIRE(page_idle_fd >= 0,
>  		       "CONFIG_IDLE_PAGE_TRACKING is not enabled");
> +

Extra newline.

> +
> +	if (skip_sanity_check == false) {

	if (!skip_sanity_check) {

> +		if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {

This needs to be guarded with __x86_64__.

> +			printf("Skipping idle page count sanity check, because the test is run nested\n");
> +			skip_sanity_check = true;
> +		} else if (is_numa_balancing_enabled()) {
> +			printf("Skipping idle page count sanity check, because NUMA balance is enabled\n");
> +			skip_sanity_check = true;
> +		}
> +	}
> +
>  	close(page_idle_fd);
>  
>  	for_each_guest_mode(run_test, &params);
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index 3e473058849f..1bc9b0a92427 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -153,6 +153,7 @@ bool is_backing_src_hugetlb(uint32_t i);
>  void backing_src_help(const char *flag);
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>  long get_run_delay(void);
> +bool is_numa_balancing_enabled(void);
>  
>  /*
>   * Whether or not the given source type is shared memory (as opposed to
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 8ed0b74ae837..1271863613fa 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -163,6 +163,28 @@ size_t get_trans_hugepagesz(void)
>  	return size;
>  }
>  
> +

Extra newline.

> +bool is_numa_balancing_enabled(void)
> +{
> +	int ret;
> +	int val;
> +	struct stat statbuf;
> +	FILE *f;
> +
> +	ret = stat("/proc/sys/kernel/numa_balancing", &statbuf);
> +	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
> +			"Error in stating /proc/sys/kernel/numa_balancing");

Align indentation.

> +	if (ret != 0)

	if (ret)

> +		return false;
> +
> +	f = fopen("/proc/sys/kernel/numa_balancing", "r");

Pretty sure this needs to assert on f being valid.

> +	ret = fscanf(f, "%d", &val);

file needs to be closed.

Actually, rather than fix these things, extract the mechanical aspects of the THP
code to helpers (patch at the bottom), and then this can be:

bool is_numa_balancing_enabled(void)
{
	const char *numa_balancing = "/proc/sys/kernel/numa_balancing";

	return test_sysfs_path(numa_balancing) && get_sysfs_val(numa_balancing);
}

> +	TEST_ASSERT(val == 0 || val == 1, "Unexpected value in /proc/sys/kernel/numa_balancing");

I vote to omit this sanity check.  The odds of numa_balancing having a different
value *and* the bad value going unnoticed are quite low, so I'd prefer to make
the helper short and simple.

---
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 07:31:09 -0800
Subject: [PATCH] KVM: selftests: Extract guts of THP accessor to standalone
 sysfs helpers

Extract the guts of thp_configured() and get_trans_hugepagesz() to
standalone helpers so that the core logic can be reused for other sysfs
files, e.g. to query numa_balancing.

Opportunistically assert that the initial fscanf() read at least one byte,
and add a comment explaining the second call to fscanf().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/test_util.c | 35 ++++++++++++++-------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae837..3dc8538f5d69 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -132,37 +132,50 @@ void print_skip(const char *fmt, ...)
 	puts(", skipping test");
 }
 
-bool thp_configured(void)
+static bool test_sysfs_path(const char *path)
 {
-	int ret;
 	struct stat statbuf;
+	int ret;
 
-	ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
+	ret = stat(path, &statbuf);
 	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
-		    "Error in stating /sys/kernel/mm/transparent_hugepage");
+		    "Error in stat()ing '%s'", path);
 
 	return ret == 0;
 }
 
-size_t get_trans_hugepagesz(void)
+bool thp_configured(void)
+{
+	return test_sysfs_path("/sys/kernel/mm/transparent_hugepage");
+}
+
+static size_t get_sysfs_val(const char *path)
 {
 	size_t size;
 	FILE *f;
 	int ret;
 
-	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
-
-	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
-	TEST_ASSERT(f != NULL, "Error in opening transparent_hugepage/hpage_pmd_size");
+	f = fopen(path, "r");
+	TEST_ASSERT(f, "Error opening '%s'", path);
 
 	ret = fscanf(f, "%ld", &size);
+	TEST_ASSERT(ret > 0, "Error reading '%s'", path);
+
+	/* Re-scan the input stream to verify the entire file was read. */
 	ret = fscanf(f, "%ld", &size);
-	TEST_ASSERT(ret < 1, "Error reading transparent_hugepage/hpage_pmd_size");
+	TEST_ASSERT(ret < 1, "Error reading '%s'", path);
+
 	fclose(f);
-
 	return size;
 }
 
+size_t get_trans_hugepagesz(void)
+{
+	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
+
+	return get_sysfs_val("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size");
+}
+
 size_t get_def_hugetlb_pagesz(void)
 {
 	char buf[64];

base-commit: c2b800261f01eda7e811b588eaa6324cfcfdecc6
-- 


