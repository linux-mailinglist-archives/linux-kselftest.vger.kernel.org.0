Return-Path: <linux-kselftest+bounces-35970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9655AEB819
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 14:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D9189670E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F049B2D879C;
	Fri, 27 Jun 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lqmuzra6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NeYoApK1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C762980BF;
	Fri, 27 Jun 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028538; cv=none; b=VFdPq0amJSCOcEkw/ns9LjkL89OIaAH5LCgp8Gp9yqYiqh9vPnFQOXqcrxy1/aRCKEh0oK/knz/ESz62Yf++YJ54qBpnuT6AbaqxQoYeiLbOShJFgjEgXSSnYysNlTvplP/p8dZHxv3CSd4Gc+IesvIg5YsOcWiTyhEp3Kcq0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028538; c=relaxed/simple;
	bh=91g/Z0XKaGrm4enQreIzabrBw3Lf4UpDZ4SRKzVP1xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8ccilJz6NrPEt8+PcA4shkbgEgU+8nJfSGdUB45A3oetuUh0c+jTsruGC8xLF1AeQtTamxBO0VS72GFOoEf1GCMxPSSxF+cN1l2Wt43WdqeNEC3mj6z6WIj1I15zluU2BHLx8aKDLoBR2QNOYOEwi+ydRfw/TnifRwAJl6z2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lqmuzra6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NeYoApK1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751028535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dahXu2LEDMAp26RbUOIDlGEe7yKn2tw8fEfvF1ZcJHA=;
	b=lqmuzra6pRShzul0BKepI1sehWdXlq7GRY6s+aWJmehnFXVc2um1nmpnw+W5PC8U/NJeed
	TEp78/NSPC28NRo1WAnF7CP31PZSGfJCFwRRRmVxySvvoNr7eOeWopOGLQ+THKJif4FlV+
	bTctGp317l7qkQ2finUivmro66xG6b/ZBMLIGTS5xw8I191KKuTsfVoIuaj84tqSx4zCiQ
	ADsG/VUW8/pakI+zv8Kj19k5AACZitEYI5Odea9pMasohs1ubkb8yNKkEAtaOJGhBL/cvE
	7gbDuepex8RX2NJDmvuRJ19u7jAaMVdzOqWe6k75Q5Ha7rz8NUQ4EBnJY6owZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751028535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dahXu2LEDMAp26RbUOIDlGEe7yKn2tw8fEfvF1ZcJHA=;
	b=NeYoApK17LDa2m/ATlT2S+xXuEP1obxvXvQ2rZS4JhKRPbPkEy91xRAqFifQEHFCgw3wnx
	irF2m56Q1/vYN5Ag==
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
Subject: Re: [PATCH v5 7/7] selftests: futex: Expand robust list test for
 the new interface
In-Reply-To: <20250626-tonyk-robust_futex-v5-7-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-7-179194dbde8f@igalia.com>
Date: Fri, 27 Jun 2025 14:48:54 +0200
Message-ID: <87tt41nydl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:

> Expand the current robust list test for the new set_robust_list2
> syscall. Create an option to make it possible to run the same tests
> using the new syscall, and also add two new relevant test: test long
> lists (bigger than ROBUST_LIST_LIMIT) and for unaligned addresses.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  .../selftests/futex/functional/robust_list.c       | 160 +++++++++++++++=
+++++-
>  1 file changed, 156 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/too=
ls/testing/selftests/futex/functional/robust_list.c
> index 42690b2440fd29a9b12c46f67f9645ccc93d1147..004ad79ff6171c411fd47e699=
e3c38889544218e 100644
> --- a/tools/testing/selftests/futex/functional/robust_list.c
> +++ b/tools/testing/selftests/futex/functional/robust_list.c
> @@ -35,16 +35,45 @@
>  #include <stddef.h>
>  #include <sys/mman.h>
>  #include <sys/wait.h>
> +#include <stdint.h>
>=20=20
>  #define STACK_SIZE (1024 * 1024)
>=20=20
>  #define FUTEX_TIMEOUT 3
>=20=20
> +#define SYS_set_robust_list2 468
> +
> +enum robust_list2_type {
> +        ROBUST_LIST_32BIT,
> +        ROBUST_LIST_64BIT,
> +};

Why can't this use an updated header?

> +
>  static pthread_barrier_t barrier, barrier2;
>=20=20
> +bool robust2 =3D false;

global because ....

>  int set_robust_list(struct robust_list_head *head, size_t len)
>  {
> -	return syscall(SYS_set_robust_list, head, len);
> +	int ret, flags;
> +
> +	if (!robust2) {
> +		return syscall(SYS_set_robust_list, head, len);
> +	}

Pointless brackets.

> +	if (sizeof(head) =3D=3D 8)
> +		flags =3D ROBUST_LIST_64BIT;
> +	else
> +		flags =3D ROBUST_LIST_32BIT;
> +
> +	/*
> +	 * We act as we have just one list here. We try to use the first slot,
> +	 * but if it hasn't been alocated yet we allocate it.
> +	 */
> +	ret =3D syscall(SYS_set_robust_list2, head, 0, flags);
> +	if (ret =3D=3D -1 && errno =3D=3D ENOENT)
> +		ret =3D syscall(SYS_set_robust_list2, head, -1, flags);

What the heck is this?

> +	return ret;
>  }
>=20=20
>  int get_robust_list(int pid, struct robust_list_head **head, size_t *len=
_ptr)
> @@ -246,6 +275,11 @@ static void test_set_robust_list_invalid_size(void)
>  	size_t head_size =3D sizeof(struct robust_list_head);
>  	int ret;
>=20=20
> +	if (robust2) {
> +		ksft_test_result_skip("This test is only for old robust interface\n");

Why is it invoked in the first place?

> +		return;
> +	}
> +
>  	ret =3D set_robust_list(&head, head_size);
>  	ASSERT_EQ(ret, 0);
>=20=20
> @@ -321,6 +355,11 @@ static void test_get_robust_list_child(void)
>  	struct robust_list_head head, *get_head;
>  	size_t len_ptr;
>=20=20
> +	if (robust2) {
> +		ksft_test_result_skip("Not implemented in the new robust interface\n");

For the very wrong reasons.

> +		return;
> +	}
> +
>  	ret =3D pthread_barrier_init(&barrier, NULL, 2);
>  	ret =3D pthread_barrier_init(&barrier2, NULL, 2);
>  	ASSERT_EQ(ret, 0);
> @@ -332,7 +371,7 @@ static void test_get_robust_list_child(void)
>=20=20
>  	ret =3D get_robust_list(tid, &get_head, &len_ptr);
>  	ASSERT_EQ(ret, 0);
> -	ASSERT_EQ(&head, get_head);
> +	ASSERT_EQ(get_head, &head);

ROTFL

>=20=20
>  	pthread_barrier_wait(&barrier2);
>=20=20
> @@ -507,11 +546,119 @@ static void test_circular_list(void)
>  	ksft_test_result_pass("%s\n", __func__);
>  }
>=20=20
> +#define ROBUST_LIST_LIMIT	2048
> +#define CHILD_LIST_LIMIT (ROBUST_LIST_LIMIT + 10)
> +
> +static int child_robust_list_limit(void *arg)
> +{
> +	struct lock_struct *locks;
> +	struct robust_list *list;
> +	struct robust_list_head head;
> +	int ret, i;
> +
> +	locks =3D (struct lock_struct *) arg;
> +
> +	ret =3D set_list(&head);
> +	if (ret)
> +		ksft_test_result_fail("set_list error\n");

Yet again the same broken crap.

> +	/*
> +	 * Create a very long list of locks
> +	 */
> +	head.list.next =3D &locks[0].list;
> +
> +	list =3D head.list.next;
> +	for (i =3D 0; i < CHILD_LIST_LIMIT - 1; i++) {
> +		list->next =3D &locks[i+1].list;
> +		list =3D list->next;
> +	}
> +	list->next =3D &head.list;
> +
> +	/*
> +	 * Grab the lock in the last one, and die without releasing it
> +	 */
> +	mutex_lock(&locks[CHILD_LIST_LIMIT], &head, false);
> +	pthread_barrier_wait(&barrier);
> +
> +	sleep(1);
> +
> +	return 0;
> +}
> +
> +/*
> + * The old robust list used to have a limit of 2048 items from the kerne=
l side.
> + * After this limit the kernel stops walking the list and ignore the oth=
er

ignores

> + * futexes, causing deadlocks.
> + *
> + * For the new interface, test if we can wait for a list of more than 20=
48
> + * elements.
> + */
> +static void test_robust_list_limit(void)
> +{
> +	struct lock_struct locks[CHILD_LIST_LIMIT + 1];
> +	_Atomic(unsigned int) *futex =3D &locks[CHILD_LIST_LIMIT].futex;
> +	struct robust_list_head head;
> +	int ret;
> +
> +	if (!robust2) {
> +		ksft_test_result_skip("This test is only for new robust interface\n");
> +		return;
> +	}
> +
> +	*futex =3D 0;
> +
> +	ret =3D set_list(&head);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret =3D pthread_barrier_init(&barrier, NULL, 2);
> +	ASSERT_EQ(ret, 0);
> +
> +	create_child(child_robust_list_limit, locks);
> +
> +	/*
> +	 * After the child thread creates the very long list of locks, wait on
> +	 * the last one.
> +	 */
> +	pthread_barrier_wait(&barrier);
> +	ret =3D mutex_lock(&locks[CHILD_LIST_LIMIT], &head, false);
> +
> +	if (ret !=3D 0)
> +		printf("futex wait returned %d\n", errno);
> +	ASSERT_EQ(ret, 0);

lalala.

> +
> +	ASSERT_TRUE(*futex | FUTEX_OWNER_DIED);

Copy and pasta does not make it more correct.

> +	wait(NULL);
> +	pthread_barrier_destroy(&barrier);
> +
> +	ksft_test_result_pass("%s\n", __func__);
> +}
> +
> +/*
> + * The kernel should refuse an unaligned head pointer
> + */
> +static void test_unaligned_address(void)
> +{
> +	struct robust_list_head head, *h;
> +	int ret;
> +
> +	if (!robust2) {
> +		ksft_test_result_skip("This test is only for new robust interface\n");
> +		return;
> +	}
> +
> +	h =3D (struct robust_list_head *) ((uintptr_t) &head + 1);
> +	ret =3D set_list(h);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
>  void usage(char *prog)
>  {
>  	printf("Usage: %s\n", prog);
>  	printf("  -c	Use color\n");
>  	printf("  -h	Display this help message\n");
> +	printf("  -n	Use robust2 syscall\n");

Right. We need a command line option to guarantee that the test is not
executed by bots...

>  	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
>  	       VQUIET, VCRITICAL, VINFO);
>  }
> @@ -520,7 +667,7 @@ int main(int argc, char *argv[])
>  {
>  	int c;
>=20=20
> -	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
> +	while ((c =3D getopt(argc, argv, "chnt:v:")) !=3D -1) {
>  		switch (c) {
>  		case 'c':
>  			log_color(1);
> @@ -531,6 +678,9 @@ int main(int argc, char *argv[])
>  		case 'v':
>  			log_verbosity(atoi(optarg));
>  			break;
> +		case 'n':
> +			robust2 =3D true;
> +			break;
>  		default:
>  			usage(basename(argv[0]));
>  			exit(1);
> @@ -538,7 +688,7 @@ int main(int argc, char *argv[])
>  	}
>=20=20
>  	ksft_print_header();
> -	ksft_set_plan(7);
> +	ksft_set_plan(8);
>

Just check whether the new syscall is implemented and then set the
number of tests accordingly.

>  	test_robustness();
>=20=20
> @@ -548,6 +698,8 @@ int main(int argc, char *argv[])
>  	test_set_list_op_pending();
>  	test_robust_list_multiple_elements();
>  	test_circular_list();
> +	test_robust_list_limit();
> +	test_unaligned_address();

and then do:

	test_robustness();
        ....
	test_circular_list();

        if (has_robust) {
        	robust2 =3D true;
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                test_robustness();
                ...
                test_circular_list();
		test_robust_list_limit();
		test_unaligned_address();
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        }=20=20=20=20=20=20=20=20

or something like that.

Time for a stiff drink....

