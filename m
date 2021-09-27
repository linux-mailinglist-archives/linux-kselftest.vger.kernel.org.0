Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D5419F10
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhI0TYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Sep 2021 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbhI0TYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Sep 2021 15:24:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5654CC061740
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Sep 2021 12:22:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w11so12442531plz.13
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Sep 2021 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4+tmZld3PQs40l6nrQYuR57TMZRxGphGPbdJLQg3qrc=;
        b=bx/Z4z6KGtK3vROpAGinbsY3FGhb/8GkxjRibXTtl/vMGLJg+0OT7iQqDjW3ODFH2E
         h5doyoSe0MShl90c/IMt7HVqgU3yhM4RgDio2Uv0zDNRBo9G6V+cQydaxW/dZE3XEfp6
         ytKjIkXHqNsiMr5uTxkxRfAill5Fq0g+yisJdLs/jXLSv5vn3TIehp53QZly8TbfE+gs
         nqAnNTWsJWS3xGN8C73lr9O7OfAeXTCAzjzGX+rH46mdqxuWgvF1w6OpyJBqQWqmvJW/
         oI9/v6kqPceGUYAo4tGecuaJll7kJ+NyUdv6avdPDfOPo5wkwEZzhBtOBxuovTQyu8Ij
         bQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4+tmZld3PQs40l6nrQYuR57TMZRxGphGPbdJLQg3qrc=;
        b=GHJRxb5mMddG/cyJo4cVWU6Q8mjehZUdRdv5OUBa0HZRrx4Va3H0cisNI7mPYcqwGb
         oq1fpnfOlSQY+lI4oOf5JAXosgW1kNzBeEMtLhjSVKYouDvQ7lxhwKsXSmObysYKBwk8
         qNxrpkEXLkY7OzZ16c/Vcy9hXAyYAuFrRPdu7GictfxwG95JRi8xemZXXV+GBassFUit
         peTS0ViZLI4kbDoouL1n6brVkRUm3e4S/HH/k3Li3qGBTBCaOExFTJ0XffWXX7Zyl+Po
         /3UENK9GRRWVmInJl9HZFRkqUFRz91SQVfrqfufOrtlg7f1Gr3eom+KHzww74h/grT8r
         7pBg==
X-Gm-Message-State: AOAM532i/8Dvmet6YqMHT6+GGTDFvv8s1AaQVZUHVd4oAUndMTvFlL6M
        vtkAZF9VhkG6XaflisKw0S+Y+w==
X-Google-Smtp-Source: ABdhPJyM0ZHido6rS/7/tbv41YSnDNdKVHtooNZWgTX+ojjimmz3NdZn/YO9NKRbkdFakeKt+KUsNQ==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr814601pji.87.1632770563566;
        Mon, 27 Sep 2021 12:22:43 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k7sm16556436pfk.59.2021.09.27.12.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 12:22:43 -0700 (PDT)
Date:   Mon, 27 Sep 2021 19:22:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: KVM: set affinity of VM to right CPUs
Message-ID: <YVIZ/67cfjk18mbe@google.com>
References: <20210924233037.4329-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924233037.4329-1-dongli.zhang@oracle.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 24, 2021, Dongli Zhang wrote:
> The nr_cpus = CPU_COUNT(&possible_mask) is the number of available CPUs in
> possible_mask. As a result, the "cpu = i % nr_cpus" may always return CPU
> that is not available in possible_mask.
> 
> Suppose the server has 8 CPUs. The below Failure is encountered immediately
> if the task is bound to CPU 5 and 6.

/facepalm

> ==== Test Assertion Failure ====
>   rseq_test.c:228: i > (NR_TASK_MIGRATIONS / 2)
>   pid=10127 tid=10127 errno=4 - Interrupted system call
>      1	0x00000000004018e5: main at rseq_test.c:227
>      2	0x00007fcc8fc66bf6: ?? ??:0
>      3	0x0000000000401959: _start at ??:?
>   Only performed 4 KVM_RUNs, task stalled too much?
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  tools/testing/selftests/kvm/rseq_test.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index c5e0dd664a7b..41df5173970c 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -10,6 +10,7 @@
>  #include <signal.h>
>  #include <syscall.h>
>  #include <sys/ioctl.h>
> +#include <sys/sysinfo.h>
>  #include <asm/barrier.h>
>  #include <linux/atomic.h>
>  #include <linux/rseq.h>
> @@ -43,6 +44,18 @@ static bool done;
>  
>  static atomic_t seq_cnt;
>  
> +static int get_max_cpu_idx(void)
> +{
> +	int nproc = get_nprocs_conf();
> +	int i, max = -ENOENT;
> +
> +	for (i = 0; i < nproc; i++)
> +		if (CPU_ISSET(i, &possible_mask))
> +			max = i;
> +
> +	return max;
> +}
> +
>  static void guest_code(void)
>  {
>  	for (;;)
> @@ -61,10 +74,13 @@ static void *migration_worker(void *ign)
>  {
>  	cpu_set_t allowed_mask;
>  	int r, i, nr_cpus, cpu;
> +	int max_cpu_idx;
>  
>  	CPU_ZERO(&allowed_mask);
>  
> -	nr_cpus = CPU_COUNT(&possible_mask);
> +	max_cpu_idx = get_max_cpu_idx();
> +	TEST_ASSERT(max_cpu_idx >= 0, "Invalid possible_mask");

I feel like this should be a KSFT_SKIP condition, not an assert.

> +	nr_cpus = max_cpu_idx + 1;
>  
>  	for (i = 0; i < NR_TASK_MIGRATIONS; i++) {
>  		cpu = i % nr_cpus;

This is still flawed, e.g. if the max CPU is 1023, but the task is pinned to _just_
CPU 1023, then the assert at the end will likely still fail because the migration
helper is effectively only running 1/1024 loops.

It probably also makes sense to grab the min CPU to reduce the pain if the task
is affined to a small subset.

As an aside, _which_ CPUs the task is affined to seems to matter, e.g. some
combinations of CPUs on my system don't fail, even with 100x iterations.  Don't
think there's anything the test can do about that, just an interesting data point
that suggests pinning while running tests may be a bad idea.

Anyways, something like this?

---
 tools/testing/selftests/kvm/rseq_test.c | 44 ++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 060538bd405a..befd64c27152 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -10,6 +10,7 @@
 #include <signal.h>
 #include <syscall.h>
 #include <sys/ioctl.h>
+#include <sys/sysinfo.h>
 #include <asm/barrier.h>
 #include <linux/atomic.h>
 #include <linux/rseq.h>
@@ -39,6 +40,7 @@ static __thread volatile struct rseq __rseq = {

 static pthread_t migration_thread;
 static cpu_set_t possible_mask;
+static int min_cpu, max_cpu;
 static bool done;

 static atomic_t seq_cnt;
@@ -60,16 +62,17 @@ static void sys_rseq(int flags)
 static void *migration_worker(void *ign)
 {
 	cpu_set_t allowed_mask;
-	int r, i, nr_cpus, cpu;
+	int r, i, cpu;

 	CPU_ZERO(&allowed_mask);

-	nr_cpus = CPU_COUNT(&possible_mask);
-
-	for (i = 0; i < NR_TASK_MIGRATIONS; i++) {
-		cpu = i % nr_cpus;
-		if (!CPU_ISSET(cpu, &possible_mask))
-			continue;
+	for (i = 0, cpu = -1; i < NR_TASK_MIGRATIONS; i++) {
+		do {
+			if (cpu < min_cpu || cpu > max_cpu)
+				cpu = min_cpu;
+			else
+				cpu++;
+		} while (!CPU_ISSET(cpu, &possible_mask));

 		CPU_SET(cpu, &allowed_mask);

@@ -154,6 +157,27 @@ static void *migration_worker(void *ign)
 	return NULL;
 }

+static int calc_min_max_cpu(void)
+{
+	int i, cnt, nproc;
+
+	nproc = get_nprocs_conf();
+	cnt = 0;
+	min_cpu = -1;
+	max_cpu = -1;
+
+	for (i = 0; i < nproc; i++) {
+		if (!CPU_ISSET(i, &possible_mask))
+			continue;
+		if (min_cpu == -1)
+			min_cpu = i;
+		max_cpu = i;
+		cnt++;
+	}
+
+	return (cnt < 2) ? -EINVAL : 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int r, i, snapshot;
@@ -168,7 +192,11 @@ int main(int argc, char *argv[])
 		    strerror(errno));

 	if (CPU_COUNT(&possible_mask) < 2) {
-		print_skip("Only one CPU, task migration not possible\n");
+		print_skip("Only one CPU, task migration not possible");
+		exit(KSFT_SKIP);
+	}
+	if (calc_min_max_cpu()) {
+		print_skip("Only one usable CPU, task migration not possible");
 		exit(KSFT_SKIP);
 	}

--
