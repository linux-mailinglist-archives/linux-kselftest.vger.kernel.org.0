Return-Path: <linux-kselftest+bounces-40798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E2B444D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 19:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940F6188D886
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26F320CC4;
	Thu,  4 Sep 2025 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vAJMMjGJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BB2C026D;
	Thu,  4 Sep 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008305; cv=none; b=tHLLyPxa7Jc25xk8RaVWAFWpycOzsNhRzunWWI2BClbAi5S5hv8D/ZpS3Ki4/hWu4eaC5Hjx2TKT6r1cHXeakQTVYq+3uEuYfBHbUIRfwe+6laiE2lq9CdNMx7WNq23kqO20l81t2XWr3L7RL9XvgBhFamI8xHsB6zOeJfBIZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008305; c=relaxed/simple;
	bh=jDu+D0q8nRKICmZ6bnLrMMMfQ0qvf+zqJ4dVtnlIAf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJvOCf4oUtEdzseTbd0ux9edUR0ETrzPUTRlgxDv6JQzQZK2ZUbe8eoB2+u3y3RCaN+loEc78cXTguq7KXChIlVO2pS3FY6dpq+z5rQ6Txq9D6w3bJpqtF6bGOlhyZDHsdmoVgnEmNjsrq6OYLgwUV5LCjuNXCEvkFNxwQUfjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vAJMMjGJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LsiKyVM8DaNk49lJby8XtmITtLhNnVn6b2laLK9bt4A=; b=vAJMMjGJ8dlaApYEToY9hKb/zg
	fkqrPuBKVphEZ1nmIbmAyh75hmYOdTlEZtjAb2mnW/QHCYLapLVpmr3PcGAWt04+yR465nScjS75x
	GjGCQmjVQwUUEHP5NGDS87iHkNCKuFPVqlPNWa47WyYjIv7hh1tXxnWbTIcaPbI89mdPbvu/t3FxW
	2Plxvk/Qci1SbswNUTc3YMM08GcER8W1yJjnAFpNx5qRmAv/rZwFmJpArbwNYKFq+CdFcHdhrJs/i
	STDsfnDfA0lD1mwNQf17hmFXejtzaUsfrEXOzVyX5X99UDNnb9VO7fhklNA/LfbUYeulOa4O+FyBJ
	f08PIwcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuE7W-00000005U1W-1kes;
	Thu, 04 Sep 2025 17:51:38 +0000
Date: Thu, 4 Sep 2025 18:51:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
	sargun@sargun.me, corbet@lwn.net, shuah@kernel.org,
	brauner@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
Message-ID: <20250904175138.GA886028@ZenIV>
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903203805.1335307-1-tom.hromatka@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 03, 2025 at 08:38:03PM +0000, Tom Hromatka wrote:

> +static long seccomp_clone_filter(void __user *upidfd)
> +{
> +	struct task_struct *task;
> +	unsigned int flags;
> +	pid_t pidfd;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

OK...

> +	if (atomic_read(&current->seccomp.filter_count) > 0)
> +		return -EINVAL;

If it's atomic, then presumably there's something that can change
it asynchronously, right?  If so, what's there to prevent
invalidation of the result of this test right after you've
decided everything's fine?

Let's check...
; git grep -n -w filter_count
<64 lines of output, most clearly unrelated to that>
; git grep -n -w -c filter_count
drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c:1
drivers/net/ethernet/intel/i40e/i40e_common.c:18
drivers/net/ethernet/intel/i40e/i40e_prototype.h:4
drivers/net/ethernet/qlogic/qede/qede_filter.c:13
drivers/net/ipa/ipa.h:2
drivers/net/ipa/ipa_cmd.c:1
drivers/net/ipa/ipa_table.c:6
fs/proc/array.c:1
include/linux/seccomp_types.h:2
init/init_task.c:1
kernel/seccomp.c:3
lib/kunit/executor.c:7
lib/kunit/executor_test.c:5

Sod drivers and lib/kunit, these are irrelevant.  Removing those
hits yields this:
; git grep -n -w filter_count|grep -v '[^dl]'
fs/proc/array.c:340:                        atomic_read(&p->seccomp.filter_count));
include/linux/seccomp_types.h:15: * @filter_count: number of seccomp filters
include/linux/seccomp_types.h:24:       atomic_t filter_count;
init/init_task.c:208:   .seccomp        = { .filter_count = ATOMIC_INIT(0) },
kernel/seccomp.c:631:           atomic_set(&thread->seccomp.filter_count,
kernel/seccomp.c:632:                      atomic_read(&caller->seccomp.filter_count));
kernel/seccomp.c:932:   atomic_inc(&current->seccomp.filter_count);

Aha.  We have a reader in fs/proc/array.c, definition of that thing in
seccomp_types.h, initialization in init_task.c and two places in
seccomp.c, one around line 631 copying the value from one thread to
another (seccomp_sync_threads()) and one at line 932 incrementing
the damn thing (seccomp_attach_filter()).

Humm...  OK, former is copying the filter_count of current (caller is
set to current there) to other threads in the same thread group and
apparently that's serialized on ->signal->cred_guard_mutex of that
bunch, as well as on current->sighand->siglock (and since all threads
in the group are going to share ->sighand, it's the same thing
as their ->sighand->siglock).

The latter increments that thing for current, under ->sighand->siglock.

So
	* atomic_t for filter_count looks like cargo-culting (and unless I'm
missing something, the only thing that cares about it is /proc/*/status;
rudiment of some sort?)
	* looks like the test can be invalidated by another thread hitting
that seccomp_sync_threads() thing (from a quick look, SECCOMP_SET_MODE_FILTER
with SECCOMP_FILTER_FLAG_TSYNC in flags).

> +	if (copy_from_user(&pidfd, upidfd, sizeof(pid_t)))
> +		return -EFAULT;

OK...

> +	task = pidfd_get_task(pidfd, &flags);
> +	if (IS_ERR(task))
> +		return -ESRCH;

OK...

> +	spin_lock_irq(&current->sighand->siglock);
> +	spin_lock_irq(&task->sighand->siglock);

WTF?  You are apparently trying to lock both the current and the task you
want to copy from, but... you are nesting two locks of the same sort
here, with not even preventing the self-deadlock (task and current sharing
->sighand - e.g. by belonging to the same thread group), let alone preventing
the same from two threads trying to take the same couple of locks in the
opposite orders.

More to the point, why do you need both at once?

> +	if (atomic_read(&task->seccomp.filter_count) == 0) {

OK...  from the earlier digging it looks like this actually stands for
"if task has no filter attached, piss off - nothing to copy".

> +		spin_unlock_irq(&task->sighand->siglock);
> +		spin_unlock_irq(&current->sighand->siglock);
> +		put_task_struct(task);
> +		return -EINVAL;
> +	}
> +
> +	get_seccomp_filter(task);

Umm...
void get_seccomp_filter(struct task_struct *tsk)
{
        struct seccomp_filter *orig = tsk->seccomp.filter;
	if (!orig)
		return;
	__get_seccomp_filter(orig);
	refcount_inc(&orig->users);
}
and
static void __get_seccomp_filter(struct seccomp_filter *filter)
{
	refcount_inc(&filter->refs);
}

So you are taking task->seccomp.filter and bumping refcounts on
it, presumably allowing to unlock the task->sighand->siglock?

> +	current->seccomp = task->seccomp;

wait, what?  You are copying all fields at once, but... from the look
at what seccomp_sync_threads() was doing, it not quite that simple.
OK, atomic for filter_count is worthless, so plain copy will do,
but what about ->seccomp.filter?  This
                /* Make our new filter tree visible. */
		smp_store_release(&thread->seccomp.filter,
				  caller->seccomp.filter);
is potentially more serious.  Granted, in this case we are doing store
to our own thread's ->seccomp.filter, so the barrier implications
might be unimportant - if all reads are either under ->sighand->siglock
or done to current->seccomp.filter, we should be fine, but that needs
to be verified _AND_ commented upon.  Memory barriers are subtle
enough...

Looks like the only lockless reader is
	struct seccomp_filter *f =
			READ_ONCE(current->seccomp.filter);
in seccomp_run_filters(), so unless I've missed something (and "filter"
is not a search-friendly name ;-/) we should be fine; that READ_ONCE()
is there to handle *other* threads doing stores (with that
smp_store_release() in seccomp_sync_threads()).  Incidentally, this
	if (!lock_task_sighand(task, &flags))
		return -ESRCH;

	f = READ_ONCE(task->seccomp.filter);
in proc_pid_seccomp_cache() looks cargo-culted - it's *not* a lockless
access, so this READ_ONCE() is confusing.

Anyway, that copying needs a comment.  What's more, this
		__seccomp_filter_release(thread->seccomp.filter);
just prior to smp_store_release() is more serious - it drops the old
reference.  Yes, you count upon no old reference being there - that's
what your check of current->seccomp.filter_count was supposed to
guarantee, but... it could've appeared after the test.

> +	spin_unlock_irq(&task->sighand->siglock);

OK, finally unlocked the source...

> +	set_task_syscall_work(current, SECCOMP);

... marked current as "we have filters"

> +	spin_unlock_irq(&current->sighand->siglock);

... and unlocked the current.

So basically you have

	verify that current has no filters
	lock current
	lock source
	verify that source has filters
	grab reference to that
	store it in current, assuming that it still has no filters
	unlock source
	mark current as having filters
	unlock current

For one thing, the first check is done before we locked current,
making it racy.  For another, this "hold two locks at once" is
asking for trouble - it could be dealt with, but do we really
need both at once?  We do need the source locked for checking
if it has filters and grabbing a reference, but we don't need
current locked for that - the only thing this lock would give is
protection against filters appearing, but it's done too late to
guarantee that.  And the lock on source shouldn't be needed after
we'd got its filters and grabbed the reference.  So... something
along the lines of

	lock source
	verify that source has filters
	grab reference to that
	store it in local variable, along with filter_count and mode
	unlock source
	lock current
	verify that current has no filters
	copy the stuff we'd stashed into our local variabl to current
	mark current as having filters
	unlock current

That would avoid all problems with nested locks, by virtue of never
taking more than one at a time, but now we grab the reference(s)
to source filters before checking that current has none.  Which
means that we need to undo that on failure.  From the way an old
reference is dropped by seccomp_sync_threads(), that would be
__seccomp_filter_release(filters)...

So something like this:
	spin_lock_irq(&task->sighand->siglock);
	if (atomic_read(&task->seccomp.filter_count) == 0) {
		spin_unlock_irq(&task->sighand->siglock);
		put_task_struct(task);
		return -EINVAL;
	}
	get_seccomp_filter(task);
	new_seccomp = task->seccomp;
	spin_unlock_irq(&task->sighand->siglock);
	spin_lock_irq(&current->sighand->siglock);
	if (atomic_read(&current->seccomp.filter_count) > 0) {
		spin_unlock_irq(&current->sighand->siglock);
		__seccomp_filter_release(new_seccomp.filter);
		put_task_struct(task);
		return -EINVAL;
	}
	// no barriers - only current->seccomp.filter is read locklessly
	current->seccomp = new_seccomp;
	set_task_syscall_work(current, SECCOMP);
	spin_unlock_irq(&current->sighand->siglock);
	put_task_struct(task);
	return 0;

and I would suggest asking whoever had come up with that atomic for
filter_count if it's needed (or ever had been, for that matter).
Who was it, anyway?  Kees, unless I'm misreading the history,
and AFAICS on Cc in this thread, so...

Kees, is there any reason not to make it a plain int?  And what is
that READ_ONCE() doing in proc_pid_seccomp_cache(), while we are
at it...  That's 0d8315dddd28 "seccomp/cache: Report cache data
through /proc/pid/seccomp_cache", by YiFei Zhu <yifeifz2@illinois.edu>,
AFAICS.  Looks like YiFei Zhu <zhuyifei@google.com> is the current
address [Cc'd]...

