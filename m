Return-Path: <linux-kselftest+bounces-4030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8808476A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 18:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53E2B23A69
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21114C58C;
	Fri,  2 Feb 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NFuDAZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941114A4D9
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895982; cv=none; b=drusgqych45XQCSIuiNOMqYuy0l92k8q8xlw1Zw8CEPHQLQvwFd/oFf8unTsxniJXcR1HfV8MUPrG0O3mYlYOYEHKeiRvRPNDN2jEQ+G97o+YhmuIl5oVJHOqyEOwKJL3aZEUdO5VwaVZF+fU5XqJwx4jindkkpFBNX+xM14kY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895982; c=relaxed/simple;
	bh=wbyUml4VzPHLwdgPIsVLZjqXLgyXVtdvOqZgsHvr69s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDrezRSJFmeeS3dnGq24SZAg6TPQu6jB2H58EM+FPtPkHYEd5r1e5HqaeRFwL2+U0Gnqij1eXgDG5JYtT6iLYxrgATwHNwFApUZfwUB8yop0XA1JUOl5SvzZRDX/G7VzaoeFC85T/mSA2maC//9vgwjG2JO/qd4tPYN/8oN039M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NFuDAZG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so3187106276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895978; x=1707500778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHpFLXNrvHNKh8cz0f89B1EFXTS6HjoV5QmargAn3T4=;
        b=0NFuDAZGPAyy/VJGH1Dv+wBjPUbGw0rCNuIG0cZkhc95xj2+/RELxQEqNgt8t92BCc
         ODsp4qwJMuTluqm2y+zzXhDXBngnwUgT+fyWyZdiR3a0Z4Yob7fhZIfRypKFSVYUZQDO
         hYt92Qb7ReM6oWfJOyPvxD8Wm8LJ8wEkf1Z1x1qRSTFmBuH+OCINeDoyMF1WvnFoZlyJ
         JEb9/fwTf6STF9PDVSkpnvfXIfNV9Ygdywoks5RevD48eT6K87TJSa/9h7kuLB43uDWn
         LB4K7XmRuqhbu20KPuTJAyxJ24IYzxml0JA9Kf0pNJdG9Zo+jgYUNng08Q5E7EothQ94
         CJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895978; x=1707500778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHpFLXNrvHNKh8cz0f89B1EFXTS6HjoV5QmargAn3T4=;
        b=WeOx+arBSa56hNx0edFWOlKLB8cvGjelnHvu4UoWMuKKvL9akgxCxk3Y4lzWObuSvX
         H6ApfO5VCCrbEpHjLlvtgyLtVazC5GrfZ+Za0JPgn9E01utQIoXc97RGQWgsXftGRL7a
         pzWpOnSE3VPCUt0jL0DI8J7CHufTYzGAXsFZ+yo3ND2CG2+42OOQhAcaHT6ZskNh6T1D
         isbFLd8AKf+aEGZMaEgpqLgUh77GOnRJcU+QNt0o7W8HgQdD2vioQU5WeDE8ZmWc99Kq
         INUj2SdpG2/yfQ/VARbXWyRrjjnK33+uLqs2ROFq0AMhETbdphtrKmbmLH4I7zq3Z2EK
         /epw==
X-Gm-Message-State: AOJu0YzGsjRiWR2VYXLTM7IssUYg8XBbEkXOYLdz7xiUF3bS3kv1jesS
	UQ1IKNs30c4KC7UKg2+i9HEi+C2LyigHtvTwgGJqYVcPxjsPsX2CI8KXD6K46yHFZHgG0ZmIjMT
	xlg==
X-Google-Smtp-Source: AGHT+IFdKiwGSp4Z4DOEbhpt9+g9PeoUWimmoqa1d6bp/KHrS9gSglpHXV8BAfo+RK/WrgFtiPOmzPaTbo8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1681:b0:dc6:bd9f:b061 with SMTP id
 bx1-20020a056902168100b00dc6bd9fb061mr144705ybb.13.1706895978655; Fri, 02 Feb
 2024 09:46:18 -0800 (PST)
Date: Fri, 2 Feb 2024 09:46:17 -0800
In-Reply-To: <20240202064332.9403-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202064332.9403-1-shahuang@redhat.com>
Message-ID: <Zb0qaZ7iT0_8Rp7-@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Fix the dirty_log_test semaphore imbalance
From: Sean Christopherson <seanjc@google.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 02, 2024, Shaoqin Huang wrote:
> ---
> v2->v3:
>   - Rebase to v6.8-rc2.
>   - Use TEST_ASSERT().

Patch says otherwise.

> @@ -726,6 +728,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  		return;
>  	}
>  
> +	sem_getvalue(&sem_vcpu_stop, &sem_val);
> +	assert(sem_val == 0);
> +	sem_getvalue(&sem_vcpu_cont, &sem_val);
> +	assert(sem_val == 0);
> +
>  	/*
>  	 * We reserve page table for 2 times of extra dirty mem which
>  	 * will definitely cover the original (1G+) test range.  Here
> @@ -825,6 +832,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  		sync_global_to_guest(vm, iteration);
>  	}
>  
> +	/*
> +	 *
> +	 * Before we set the host_quit, let the vcpu has time to run, to make
> +	 * sure we consume the sem_vcpu_stop and the vcpu consume the
> +	 * sem_vcpu_cont, to keep the semaphore balance.
> +	 */
> +	usleep(p->interval * 1000);

Sorry, I wasn't as explicit as I should have been.  When I said I don't have a
better solution, I did not mean to imply that I am ok with busy waiting as a
hack-a-around.

Against my better judgment, I spent half an hour slogging through this test to
figure out what's going wrong.  IIUC, the problem is essentially that the test
instructs the vCPU worker to continue _after_ the last iteration, and _then_ sets
host_quit, which results in the vCPU running one extra (unvalidated) iteration.

For the other modes, which stop if and only if vcpu_sync_stop_requested is set,
the extra iteration is a non-issue.  But because the dirty ring variant stops
after every exit (to purge the ring), it hangs without an extra "continue".

So rather than blindly fire off an extra sem_vcpu_cont that may or may not be
consumed, I believe the test can simply set host_quit _before_ the final "continue"
so that the vCPU worker doesn't run an extra iteration.

I ran the below with 1000 loops of "for (i = 0; i < LOG_MODE_NUM; i++)" and so
no issues.  I didn't see the assert you hit, but without the fix, I did see this
fire within a few loops (less than 5 I think)l

	assert(host_log_mode == LOG_MODE_DIRTY_RING ||
	       atomic_read(&vcpu_sync_stop_requested) == false);

I'll post this as two patches: one to fix the bug, and a second to have the
LOG_MODE_DIRTY_RING variant clear vcpu_sync_stop_requested so that the above
assert() can be modified as below.

---
 tools/testing/selftests/kvm/dirty_log_test.c | 62 ++++++++++++--------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index babea97b31a4..1a93c4231e45 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -376,7 +376,10 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 
 	cleared = kvm_vm_reset_dirty_ring(vcpu->vm);
 
-	/* Cleared pages should be the same as collected */
+	/*
+	 * Cleared pages should be the same as collected, as KVM is supposed to
+	 * clear only the entries that have been harvested.
+	 */
 	TEST_ASSERT(cleared == count, "Reset dirty pages (%u) mismatch "
 		    "with collected (%u)", cleared, count);
 
@@ -402,6 +405,15 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 		/* Update the flag first before pause */
 		WRITE_ONCE(dirty_ring_vcpu_ring_full,
 			   run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
+
+		/*
+		 * Unconditionally clear the stop request.  This dirty ring
+		 * variant doesn't actually consume the request, because the
+		 * vCPU worker stops after every exit to allow the main task
+		 * to reap the dirty ring.  But the vCPU is still obviously
+		 * stopped, i.e. has honored the request if one was made.
+		 */
+		atomic_set(&vcpu_sync_stop_requested, false);
 		sem_post(&sem_vcpu_stop);
 		pr_info("vcpu stops because %s...\n",
 			dirty_ring_vcpu_ring_full ?
@@ -415,12 +427,6 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 	}
 }
 
-static void dirty_ring_before_vcpu_join(void)
-{
-	/* Kick another round of vcpu just to make sure it will quit */
-	sem_post(&sem_vcpu_cont);
-}
-
 struct log_mode {
 	const char *name;
 	/* Return true if this mode is supported, otherwise false */
@@ -433,7 +439,6 @@ struct log_mode {
 				     uint32_t *ring_buf_idx);
 	/* Hook to call when after each vcpu run */
 	void (*after_vcpu_run)(struct kvm_vcpu *vcpu, int ret, int err);
-	void (*before_vcpu_join) (void);
 } log_modes[LOG_MODE_NUM] = {
 	{
 		.name = "dirty-log",
@@ -452,7 +457,6 @@ struct log_mode {
 		.supported = dirty_ring_supported,
 		.create_vm_done = dirty_ring_create_vm_done,
 		.collect_dirty_pages = dirty_ring_collect_dirty_pages,
-		.before_vcpu_join = dirty_ring_before_vcpu_join,
 		.after_vcpu_run = dirty_ring_after_vcpu_run,
 	},
 };
@@ -513,14 +517,6 @@ static void log_mode_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 		mode->after_vcpu_run(vcpu, ret, err);
 }
 
-static void log_mode_before_vcpu_join(void)
-{
-	struct log_mode *mode = &log_modes[host_log_mode];
-
-	if (mode->before_vcpu_join)
-		mode->before_vcpu_join();
-}
-
 static void generate_random_array(uint64_t *guest_array, uint64_t size)
 {
 	uint64_t i;
@@ -719,6 +715,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct kvm_vm *vm;
 	unsigned long *bmap;
 	uint32_t ring_buf_idx = 0;
+	int sem_val;
 
 	if (!log_mode_supported()) {
 		print_skip("Log mode '%s' not supported",
@@ -788,12 +785,22 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	/* Start the iterations */
 	iteration = 1;
 	sync_global_to_guest(vm, iteration);
-	host_quit = false;
+	WRITE_ONCE(host_quit, false);
 	host_dirty_count = 0;
 	host_clear_count = 0;
 	host_track_next_count = 0;
 	WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
 
+	/*
+	 * Ensure the previous iteration didn't leave a dangling semaphore, i.e.
+	 * that the main task and vCPU worker were synchronized and completed
+	 * verification of all iterations.
+	 */
+	sem_getvalue(&sem_vcpu_stop, &sem_val);
+	TEST_ASSERT_EQ(sem_val, 0);
+	sem_getvalue(&sem_vcpu_cont, &sem_val);
+	TEST_ASSERT_EQ(sem_val, 0);
+
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
 	while (iteration < p->iterations) {
@@ -816,18 +823,23 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		 * the flush of the last page, and since we handle the last
 		 * page specially verification will succeed anyway.
 		 */
-		assert(host_log_mode == LOG_MODE_DIRTY_RING ||
-		       atomic_read(&vcpu_sync_stop_requested) == false);
+		TEST_ASSERT_EQ(atomic_read(&vcpu_sync_stop_requested), false);
 		vm_dirty_log_verify(mode, bmap);
+
+		/*
+		 * Set host_quit before sem_vcpu_cont in the final iteration to
+		 * ensure that the vCPU worker doesn't resume the guest.  As
+		 * above, the dirty ring test may stop and wait even when not
+		 * explicitly request to do so, i.e. would hang waiting for a
+		 * "continue" if it's allowed to resume the guest.
+		 */
+		if (++iteration == p->iterations)
+			WRITE_ONCE(host_quit, true);
+
 		sem_post(&sem_vcpu_cont);
-
-		iteration++;
 		sync_global_to_guest(vm, iteration);
 	}
 
-	/* Tell the vcpu thread to quit */
-	host_quit = true;
-	log_mode_before_vcpu_join();
 	pthread_join(vcpu_thread, NULL);
 
 	pr_info("Total bits checked: dirty (%"PRIu64"), clear (%"PRIu64"), "

base-commit: 78651ed78b3496b6dbf1fb7d64d9d9736a23edc0
-- 



