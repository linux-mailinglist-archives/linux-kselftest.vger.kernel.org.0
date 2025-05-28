Return-Path: <linux-kselftest+bounces-33949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8478BAC6E1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13FC7AB3DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C128C5D9;
	Wed, 28 May 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u10GsACJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089F288C88;
	Wed, 28 May 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450192; cv=none; b=fDYeK/9jlQKK76pL2S668QHjEmHcyLZYCAKi14WS3TcmGz95PThECFC7r8bHYGfCh2s1q4NOmuXvuuOGKfFt5dIeU7avuq1umZrofcVwzSB+lvOrbXp/Q1pWS7MaHpKlNNyTuGKb4ycK4RSM5GxZQleQ/PMmQjIgPMRRbMy3+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450192; c=relaxed/simple;
	bh=jcz4uzarVJUq0poBXYFuAda1Apggpcq+mKsch6qZexw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0mBTh+xpgFhPfisSHOXpYD8ApuHdVELQxOrIKwOdC6hSCoIAXMgMOUUlUwLDxE17L9wHp2wqlJWJX1jF2SeHCuN+/m2F0YshDdljTQJXW7gq4zAvVJ2+5eRjTy+6M0LXOJsQr8CWU8czrjKj/+3SmrLpVvKBXawb+obTbnFh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u10GsACJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2D2C4CEE3;
	Wed, 28 May 2025 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748450191;
	bh=jcz4uzarVJUq0poBXYFuAda1Apggpcq+mKsch6qZexw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u10GsACJL3x7wVHM/mmy2chKOGx5oFq0lomwr0vWLPlAzxjBT77ZRyqNBUsxtOXHY
	 Cm92oigX1U5evCrFqoRH5YXROAuTu6jdtpdoR+vG666AxWxb2cBCggk812Z0o+HhyS
	 ghlqnIKOMBePw6KPuwx/Eg4iAicfsqq4Q8GFBKSaEL07SRuukPmGMtXmksI6rx9nqo
	 Ay6ar66dCnzR1e1hYURRClow3sri7Wria9j+cjM7XKFpepyhC0HYVM3zA/lrUpbtQd
	 jDqWfXiVKILlXLsPz4K7X/qbKBxmF6ziVAmcq93vvZjQjZdANbZfAqNGOHU6u96w7P
	 eAaGmhGHfo/gQ==
Date: Wed, 28 May 2025 09:36:28 -0700
From: Kees Cook <kees@kernel.org>
To: Sameeksha Sankpal <sameekshasankpal@gmail.com>
Cc: skhan@linuxfoundation.org, luto@amacapital.net, wad@chromium.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/seccomp: Improve error logging in
 get_proc_stat()
Message-ID: <202505280933.33EEDC4DC8@keescook>
References: <202505190816.2A78B3153@keescook>
 <20250528010839.11594-1-sameekshasankpal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528010839.11594-1-sameekshasankpal@gmail.com>

On Wed, May 28, 2025 at 06:38:39AM +0530, Sameeksha Sankpal wrote:
> Use TH_LOG to report failure when reading /proc/<pid>/stat in
> get_proc_stat(), following kernel test framework conventions.
> 
> Previously, printf() was used which is discouraged.

printf wasn't used previous, that was in your v1. :)

> 
> Suggested-by: Kees Cook <kees@kernel.org>
> 

No blank line here -- other tags should all be together with the S-o-b
line.

> Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
> ---
> v1 -> v2:
> - Used TH_LOG instead of printf for error logging
> - Moved variable declaration to the top of the function
> - Applied review suggestion by Kees Cook
> 
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index d6a85d7b26da..0f12052ef1c7 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4505,14 +4505,14 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
>  	char proc_path[100] = {0};
>  	char status;
>  	char *line;
> +	int rc;
>  
>  	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
>  	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
> -	int rc = get_nth(_metadata, proc_path, 3, &line);
> -    	if (rc != 1) {
> -        	printf("[ERROR] user_notification_fifo: failed to read stat for PID %d (rc=%d)\n", pid, rc);
> -    	}
> -    	ASSERT_EQ(rc, 1);

This patch is against your v1 patch -- it doesn't apply to the seccomp
tree as-is. Please rebase your v2 off of the upstream tree rather than
your v1.

> +	rc = get_nth(_metadata, proc_path, 3, &line);
> +    ASSERT_EQ(rc, 1) {

Indenting looks wrong here, double-check you're using tabs. (And please
use scripts/checkpatch.pl to check your patch for common errors.)

> +		TH_LOG("user_notification_fifo: failed to read stat for PID %d (rc=%d)", pid, rc);
> +	}
>  	status = *line;
>  	free(line);

Code-wise, it looks good. Please respin for a v3 and this change should
be good to land.

-Kees

-- 
Kees Cook

