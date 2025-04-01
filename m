Return-Path: <linux-kselftest+bounces-29981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA99A77A64
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4209F1683ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E5202C21;
	Tue,  1 Apr 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kj9wvZ4c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lO5tqnet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA41202961;
	Tue,  1 Apr 2025 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509314; cv=none; b=My219LKvzSxlN6oPJmv5Xok8hcaI71lSgBvrK0SzPSmR/qdwLCinVgVQXUbQPR94Fj65j849gC802Qq1UtFGI9ANdgkXlzLGyPJeG2LoLsNWSWCYXQtQBxXxRagPKY/QZM8uaNuHwRf5cNnbFKsen5nGVZHzHWCdLmOe+D3h8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509314; c=relaxed/simple;
	bh=zcdbLSKxqwAC91pmORRiZQDeYHoqRz2r4XU1RKPiQCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XvEjGFyJBE66wPIzbbKrbeD+kE1zA6qD9kX5AWNdI+ivdsr32dKOVwlUSK1R3T9sS80v9J9Vn22L9prw2fsGH7Z5QBSBuJJLgdqYtmIfJCJKY6ed5wdCxU10ojeIB3bkGL9/JXBshqPxmo+Du82Xm3qUTAKlY8hD0l+aJYSdt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kj9wvZ4c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lO5tqnet; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743509309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TwBHgWSiVPHJ8DK8kHjiBrFuEFpcmevr8jPemaQHCQ=;
	b=Kj9wvZ4cYIbFLrZUIcUQjVI15e6PcNV+c6WA+ZExl3Obqp2khG9z849aoXCmzrah9vYwg1
	b5ssJv1utmLzliTLqOoUP2CVQJDT4sn1LI6EZyYKzeuQBgE1k81oAIPRaPX0PWTXNDVUJe
	O1+xe5TR4jP/nHdenVrXyW4g08SKrfdpwdQDgVI0M4maR3cDo0FeebvTdZ602GIjCnQEYW
	Yq/yz9VFezAo0/d8fPBAY2HsY1O9wMdMfI8WEYQrrzSfzfvDJlxQ2xXyVRa+msPHFX2Rbq
	wjLnELwZRczarV2yh4bh7gyfy8hT6HkOeYJTaQy8MjD7hTqyws963no/VzbxhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743509309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TwBHgWSiVPHJ8DK8kHjiBrFuEFpcmevr8jPemaQHCQ=;
	b=lO5tqnetVw0Pa1Bj0rcsPDTBHe0Zi5vY7rXmbTLHUBtyUK8WTwh6uC/y5CWhzSq8i30FGP
	HgEWThdIFWmdx6AA==
To: Nam Cao <namcao@linutronix.de>, Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 2/3] selftests: coredump: Use waitpid() instead of
 busy-wait
In-Reply-To: <133d0dc62cebb6fde2764af384b0166d98755a3c.1743438749.git.namcao@linutronix.de>
References: <cover.1743438749.git.namcao@linutronix.de>
 <133d0dc62cebb6fde2764af384b0166d98755a3c.1743438749.git.namcao@linutronix.de>
Date: Tue, 01 Apr 2025 14:14:28 +0206
Message-ID: <84y0wkkrsz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-03-31, Nam Cao <namcao@linutronix.de> wrote:
> The test waits for coredump to finish by busy-waiting for the
> stackdump_values file to be created. The maximum wait time is 10 seconds.
>
> This doesn't work for slow machine (qemu-system-riscv64), because coredump
> takes longer.
>
> Switch to use waitpid().

Note that you are now assuming that returning from waitpid() means that:

1. the coredumping has completed

and

2. the STACKDUMP_FILE with all its contents are visible to the parent
process

> With this, the stack_values file doesn't need to be atomically written by
> coredump anymore, therefore simplify the stackdump script.
>
> Fixes: 15858da53542 ("selftests: coredump: Add stackdump test")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  tools/testing/selftests/coredump/stackdump        |  6 +-----
>  tools/testing/selftests/coredump/stackdump_test.c | 13 ++++++-------
>  2 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/stackdump b/tools/testing/selftests/coredump/stackdump
> index 96714ce42d12..ad487fd5ff15 100755
> --- a/tools/testing/selftests/coredump/stackdump
> +++ b/tools/testing/selftests/coredump/stackdump
> @@ -4,11 +4,7 @@
>  CRASH_PROGRAM_ID=$1
>  STACKDUMP_FILE=$2
>  
> -TMP=$(mktemp)
> -
>  for t in /proc/$CRASH_PROGRAM_ID/task/*; do
>  	tid=$(basename $t)
> -	cat /proc/$tid/stat | awk '{print $29}' >> $TMP
> +	cat /proc/$tid/stat | awk '{print $29}' >> $STACKDUMP_FILE
>  done
> -
> -mv $TMP $STACKDUMP_FILE

I would leave this as it was. Then the availability of STACKDUMP_FILE
means the full contents are available.

> diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
> index 1dc54e128586..733feaa0f895 100644
> --- a/tools/testing/selftests/coredump/stackdump_test.c
> +++ b/tools/testing/selftests/coredump/stackdump_test.c
> @@ -96,7 +96,7 @@ TEST_F(coredump, stackdump)
>  	char *test_dir, *line;
>  	size_t line_length;
>  	char buf[PATH_MAX];
> -	int ret, i;
> +	int ret, i, status;
>  	FILE *file;
>  	pid_t pid;
>  
> @@ -131,12 +131,11 @@ TEST_F(coredump, stackdump)
>  	/*
>  	 * Step 3: Wait for the stackdump script to write the stack pointers to the stackdump file
>  	 */
> -	for (i = 0; i < 10; ++i) {
> -		file = fopen(STACKDUMP_FILE, "r");
> -		if (file)
> -			break;
> -		sleep(1);
> -	}
> +	waitpid(pid, &status, 0);
> +	ASSERT_TRUE(WIFSIGNALED(status));
> +	ASSERT_TRUE(WCOREDUMP(status));

Why not just put these 3 lines above the for-loop? So you would wait for
the process to end, then go into the 20-second timeout loop waiting for
STACKDUMP_FILE to show up.

John Ogness

