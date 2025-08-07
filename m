Return-Path: <linux-kselftest+bounces-38468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F178DB1D783
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 14:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4363BD249
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50924E4C3;
	Thu,  7 Aug 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbPAqEC2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4AWyzCfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D724677C;
	Thu,  7 Aug 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568855; cv=none; b=ccJ0GbblnFU3h/v2L6ZoN+RaYrbrHtutIfPhaiSXpwfkrlax+f/ugBX5YnnznoLOtrQNZjbkHcD1V0vCPttTyntpS0tyz1rzVFYxVZX8BDKtNdzh7tm6P6gHyuqDvhCu09UTasQicQakyMiJVvxW/JG+DU+GpTR5wfQq/zbG1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568855; c=relaxed/simple;
	bh=9eAjqVoPH60xTe4hk8BzLnfJUmmamtnI61RI8cXAJuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEAomSHE35qoJLU2CrJlftgMZYE7BFe5jteWJnCMaSYQY7zCTx+WeVLugDDOiOLNLB9oenNyjOdxGu7oFXN/4cOEL24E781lBTmfdmyPQE/ObE0ixZ8r6/LAxzCdk/6ohFSLnLJ3hwemUDRM+lyeng04x91B+tVxFSg0X5nh8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbPAqEC2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4AWyzCfH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 Aug 2025 14:14:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754568851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+f0xBoJCXrCB5TMcth5fRcGRrB61mzdJpKiYAAtIrhI=;
	b=fbPAqEC23v9amshmY4QKxjsXzScVKQZhnj1wI64Frg6lW5nOZEaKwaENbBC6t4vfATxIkC
	VqEEjQOZyunqoODZg11ItMnc7fYjYurgsP2s5OXLkbcRITuk6vO0uSXZQBNHilZPKxCRhf
	XEWk1NIZpPMxSsk0Q7IVNYTndFY1Rr16p7PLK/z5i131Ej1Qt4slz12Qy0ZZnK++KTcCND
	5+JHa4mX0yQvEfL1t+XRZyeffxd7cKR7b+Q+fpsvNLGHcTujQMgRZOfNJumm4okzBYCPOx
	0qlLKyckPwwW7Ro8osjh6L7zjW7tBTlcYWIU/QFiwR2wNS3gH0BTPRb6mVnOGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754568851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+f0xBoJCXrCB5TMcth5fRcGRrB61mzdJpKiYAAtIrhI=;
	b=4AWyzCfHVykARLgrbKHhSFqGKWl9RSQqMjZ7lOIrIgb1YmrTJZMvHoJKfJadsebsGV68S5
	DCLgjHpF9WovqqDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Wake Liu <wakel@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, peterz@infradead.org, 
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com
Subject: Re: [PATCH v2 1/1] selftests/futex: Check for shmget support at
 runtime
Message-ID: <20250807140508-d3df8cab-249a-47ed-b92a-d33e43de0aee@linutronix.de>
References: <20250807120042.1761685-1-wakel@google.com>
 <20250807120042.1761685-2-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807120042.1761685-2-wakel@google.com>

On Thu, Aug 07, 2025 at 08:00:42PM +0800, Wake Liu wrote:
> The futex tests `futex_wait.c` and `futex_waitv.c` rely on the `shmget()`
> syscall, which may not be available if the kernel is built without
> System V IPC support (CONFIG_SYSVIPC=n). This can lead to test
> failures on such systems.
> 
> This patch modifies the tests to check for `shmget()` support at
> runtime by calling it and checking for an `ENOSYS` error. If `shmget()`
> is not supported, the tests are skipped with a clear message,
> improving the user experience and preventing false negatives.
> 
> This approach is more robust than relying on compile-time checks and
> ensures that the tests run only when the required kernel features are
> present.
> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  .../selftests/futex/functional/futex_wait.c   | 49 +++++++------
>  .../selftests/futex/functional/futex_waitv.c  | 73 ++++++++++++-------
>  2 files changed, 73 insertions(+), 49 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
> index 685140d9b93d..17a465313a59 100644
> --- a/tools/testing/selftests/futex/functional/futex_wait.c
> +++ b/tools/testing/selftests/futex/functional/futex_wait.c
> @@ -48,7 +48,7 @@ static void *waiterfn(void *arg)
>  int main(int argc, char *argv[])
>  {
>  	int res, ret = RET_PASS, fd, c, shm_id;
> -	u_int32_t f_private = 0, *shared_data;
> +	u_int32_t f_private = 0, *shared_data = NULL;
>  	unsigned int flags = FUTEX_PRIVATE_FLAG;
>  	pthread_t waiter;
>  	void *shm;
> @@ -96,32 +96,35 @@ int main(int argc, char *argv[])
>  	/* Testing an anon page shared memory */
>  	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
>  	if (shm_id < 0) {
> -		perror("shmget");
> -		exit(1);
> -	}
> -
> -	shared_data = shmat(shm_id, NULL, 0);
> +		if (errno == ENOSYS) {
> +			ksft_test_result_skip("Kernel does not support System V shared memory\n");
> +		} else {
> +			ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
> +			ret = RET_FAIL;

kselftest.h is already keeping track of the failure status.
Just call ksft_finished() at the end.
Also the whole perror()/exit(1) pattern doesn't really make sense in a kselftest.

> +		}
> +	} else {
> +		shared_data = shmat(shm_id, NULL, 0);

(...)

