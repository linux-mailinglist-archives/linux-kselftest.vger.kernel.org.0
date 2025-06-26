Return-Path: <linux-kselftest+bounces-35943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F71AAEA9BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 00:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205861C24B84
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C221ADB9;
	Thu, 26 Jun 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTwKMKCH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nnw69UHB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4402F1FC9;
	Thu, 26 Jun 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977402; cv=none; b=RWPwJsDtC4DYW2XjlqWsrj5j8U0hA+6+SYM4Hbi0XGNhNR2EdRpr6DV760RD3DluAPZUGxS3MTiCBo4/pYx0DzQb8G+ly9DsR9Fc3F6PWQFVfLLv4RiBQQmV4N2hZb1oDDLs2IFDQxWLJyFUdXYStgtywFibGd3gpFq/GqSNRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977402; c=relaxed/simple;
	bh=g1nr1RQJdKJGzlLvHbH+jFPReG/gFndlCIo1Z0q8/vQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tcJ/dyICJPflVO5GITXtwgAlTB9N3t9ng9QkH/52Ms+aDBKDChYBBjcWbGIDXd9eTr1AzM14SUzaB50nyeVt3E4aazZlA4F6Xyzha4oyOAMDIXxsj0Tc89u/akMnvGwE0IS+0/Jr6JiKvn3wqj9BoB9dey0JoFxJsyTLliplgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTwKMKCH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nnw69UHB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750977398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+jpGnqin1i3+54YImqxOfu2HSwmKyS0FMIyMjN326w=;
	b=bTwKMKCHqUz4pvZEUpPHFVpb2gomBtqPHPaCG9DxPOitEdzsygHiNdZP6v2mZ9FR07I6Lv
	98NkvSLp6FxoPVzUKqMoD+nlif4YYo7BqNT/wqxoaqZ9SJr6t3B3PhwzU9VaD/QllTGX/F
	jxSQLLkZqAWDtlqYZqpTQPeVAeDIW2F3SItVK+ZvfcM6nStRmlU5bZUfSSJKEHfEJ9zOl5
	HZQCpB+9jf6fwzuoov1E5rzg0JLZV3a8ROytkmBuTw5PWY0bwV7h3GYD/0jCg2733Wbi8Y
	2yXvwn65Z0RzZqYIByoCjXZLW7hJw08dnnkvRSKvB5jJ9W2vkNZzs9U/BQYgfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750977398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+jpGnqin1i3+54YImqxOfu2HSwmKyS0FMIyMjN326w=;
	b=nnw69UHB02qcikFMfUq+idSGgErSwJY8lnjIWdmENYp9YGDRu0gln5c2+aMJbfqeVeLxcV
	vetJb9qYDTV0ABCQ==
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Ingo Molnar
 <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com, =?utf-8?Q?Andr=C3=A9?=
 Almeida
 <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 2/7] selftests/futex: Create test for robust list
In-Reply-To: <20250626-tonyk-robust_futex-v5-2-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-2-179194dbde8f@igalia.com>
Date: Fri, 27 Jun 2025 00:36:37 +0200
Message-ID: <878qlep1u2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:
> +
> +int set_robust_list(struct robust_list_head *head, size_t len)

This function and the get() counterpart are global because they can?

> +{
> +	return syscall(SYS_set_robust_list, head, len);
> +}
> +/*
> + * Basic lock struct, contains just the futex word and the robust list e=
lement
> + * Real implementations have also a *prev to easily walk in the list
> + */
> +struct lock_struct {
> +	_Atomic(unsigned int) futex;
> +	struct robust_list list;

tabular arrangement please.

> +	pthread_barrier_wait(&barrier);
> +
> +	/*
> +	 * There's a race here: the parent thread needs to be inside
> +	 * futex_wait() before the child thread dies, otherwise it will miss the
> +	 * wakeup from handle_futex_death() that this child will emit. We wait a
> +	 * little bit just to make sure that this happens.
> +	 */
> +	sleep(1);

One second is quite a little bit. :)

> +	/*
> +	 * futex_wait() should return 0 and the futex word should be marked with
> +	 * FUTEX_OWNER_DIED
> +	 */
> +	ASSERT_EQ(ret, 0);
> +	if (ret !=3D 0)
> +		printf("futex wait returned %d", errno);

What's the purpose of the extra printf() after the assert here? This
code is not even reached when ret !=3D 0, no?

> +	ASSERT_TRUE(*futex | FUTEX_OWNER_DIED);

That's always true no matter what the content of the futex variable is, no?

> +/*
> + * The only valid value for len is sizeof(*head)
> + */
> +static void test_set_robust_list_invalid_size(void)
> +{
> +	struct robust_list_head head;
> +	size_t head_size =3D sizeof(struct robust_list_head);

Groan. You already define the robust_list_head variable ahead of
head_size and violate the reverse fir tree ordering, so why don't you
use the obvious and actually robust 'sizeof(head)'?

> +/*
> + * Test get_robust_list with pid =3D 0, getting the list of the running =
thread
> + */
> +static void test_get_robust_list_self(void)
> +{
> +	struct robust_list_head head, head2, *get_head;
> +	size_t head_size =3D sizeof(struct robust_list_head), len_ptr;

Ditto.

> +static int child_list(void *arg)
> +{
> +	struct robust_list_head *head =3D (struct robust_list_head *) arg;

void pointers really don't require type casts

> +	int ret;
> +
> +	ret =3D set_robust_list(head, sizeof(struct robust_list_head));

sizeof(*head)

> +	if (ret)
> +		ksft_test_result_fail("set_robust_list error\n");
> +
> +	pthread_barrier_wait(&barrier);
> +	pthread_barrier_wait(&barrier2);

Lacks a comment what this waits for

> +	return 0;
> +}
> +
> +/*
> + * Test get_robust_list from another thread. We use two barriers here to=
 ensure
> + * that:
> + *   1) the child thread set the list before we try to get it from the
> + * parent
> + *   2) the child thread still alive when we try to get the list from it
> + */
> +static void test_get_robust_list_child(void)
> +{
> +	pid_t tid;
> +	int ret;
> +	struct robust_list_head head, *get_head;
> +	size_t len_ptr;

Reverse fir tree ordering please.

> +	ret =3D pthread_barrier_init(&barrier, NULL, 2);
> +	ret =3D pthread_barrier_init(&barrier2, NULL, 2);
> +	ASSERT_EQ(ret, 0);
> +
> +	tid =3D create_child(&child_list, &head);
> +	ASSERT_NE(tid, -1);
> +
> +	pthread_barrier_wait(&barrier);
> +
> +	ret =3D get_robust_list(tid, &get_head, &len_ptr);
> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(&head, get_head);
> +
> +	pthread_barrier_wait(&barrier2);
> +
> +	wait(NULL);
> +	pthread_barrier_destroy(&barrier);
> +	pthread_barrier_destroy(&barrier2);
> +
> +	ksft_test_result_pass("%s\n", __func__);
> +}
> +
> +static int child_fn_lock_with_error(void *arg)
> +{
> +	struct lock_struct *lock =3D (struct lock_struct *) arg;

See above

> +	struct robust_list_head head;
> +	int ret;
> +
> +	ret =3D set_list(&head);
> +	if (ret)
> +		ksft_test_result_fail("set_robust_list error\n");

So you fail the test and continue to produce more fails or what? Why
does this not use one of these ASSERT thingies or return?

> +	ret =3D mutex_lock(lock, &head, true);
> +	if (ret)
> +		ksft_test_result_fail("mutex_lock error\n");
> +
> +	pthread_barrier_wait(&barrier);
> +
> +	sleep(1);
> +
> +	return 0;
> +}
> +
> +/*
> + * Same as robustness test, but inject an error where the mutex_lock() e=
xits
> + * earlier, just after setting list_op_pending and taking the lock, to t=
est the
> + * list_op_pending mechanism
> + */
> +static void test_set_list_op_pending(void)
> +{
> +	struct lock_struct lock =3D { .futex =3D 0 };
> +	struct robust_list_head head;
> +	_Atomic(unsigned int) *futex =3D &lock.futex;
> +	int ret;

See above

> +	ASSERT_EQ(ret, 0);
> +	if (ret !=3D 0)
> +		printf("futex wait returned %d", errno);

The random insertion of completely pointless printf()'s is stunning.

> +	ASSERT_TRUE(*futex | FUTEX_OWNER_DIED);

Yet another always true assert which is happily optimized out by the
compiler.

> +	wait(NULL);
> +	pthread_barrier_destroy(&barrier);
> +
> +	ksft_test_result_pass("%s\n", __func__);
> +}

> +static int child_wait_lock(void *arg)
> +{
> +	struct lock_struct *lock =3D (struct lock_struct *) arg;
> +	struct robust_list_head head;
> +	int ret;
> +
> +	pthread_barrier_wait(&barrier2);
> +	ret =3D mutex_lock(lock, &head, false);
> +
> +	if (ret)
> +		ksft_test_result_fail("mutex_lock error\n");
> +
> +	if (!(lock->futex | FUTEX_OWNER_DIED))
> +		ksft_test_result_fail("futex not marked with FUTEX_OWNER_DIED\n");

Now I kinda understand this insanity. The child emits a fail and
exits. Then the parent ...

> +	for (i =3D 0; i < CHILD_NR; i++)
> +		create_child(&child_wait_lock, &locks[i]);
> +
> +	/* Wait for all children to return */
> +	while (wait(NULL) > 0);
> +
> +	pthread_barrier_destroy(&barrier);
> +	pthread_barrier_destroy(&barrier2);
> +
> +	ksft_test_result_pass("%s\n", __func__);

... happily claims that the test passed.

Seriously?

Thread functions have a return value for a reason and wait(2) has a
wstatus argument for the very same reason.

> +static int child_circular_list(void *arg)
> +{
> +	static struct robust_list_head head;
> +	struct lock_struct a, b, c;
> +	int ret;
> +
> +	ret =3D set_list(&head);
> +	if (ret)
> +		ksft_test_result_fail("set_list error\n");

Yet another instance of the same ....

Thanks,

        tglx

