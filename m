Return-Path: <linux-kselftest+bounces-33327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CAABC22F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E360166E02
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B962853F8;
	Mon, 19 May 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO+yRHjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAB277003;
	Mon, 19 May 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668000; cv=none; b=B3VOqV89T7DsXilmEeWLGdipWrF1LPxnG92RzfcFb7vr5QHnoZ9iZhzj1ODKb97nlESoJCYoMkmIfFYsQoxI4vhPb9w8rxIfrTYhFQr1Ag4NANmgn7Bt3Rh/y5sX+U6obKrqKJ9gn4HYtrJNCs6rDpRBG41YCP1FeEI/jEE3QxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668000; c=relaxed/simple;
	bh=8cjHwxo0XWh2Q0WxObstZElFFSqTPtQ394BLldW0js0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjRraYtfK6iRV3YG8vxC6Mm+YxXTtzzhk9G15wTCODFf1D1c+DJJ0vTlDBFEDkAK0nn8E/p8zkfflni9Z9ht3wrg1e9lhMnzCM/sPbeIFzitEq7Yy20r9QBpTL7xVy9mF+oZSvGAESzKmp7canq63TgNZvv34084mNXUTZEitWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO+yRHjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D46DC4CEE4;
	Mon, 19 May 2025 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747668000;
	bh=8cjHwxo0XWh2Q0WxObstZElFFSqTPtQ394BLldW0js0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WO+yRHjyFQXMK9XEQTbfp4Hhzn+JzfYkI9dVd62fRgy4Ic0cYJRRyWKU6UG0ezm2M
	 2ftc6laHbhOlYgMPcVRhc9Z5wjvMa6aSUmlryH8bDqFcF2SBZ0SdEwvOXcglrMvon+
	 6P/ToBQr3DUDaDXquGI0YPBioPw6yMgg7pFeorTrgWE17kKjRuzN0u1y2uE+BvzFB1
	 jon34KH9xl0SAL1uhFm1QFFJksQzJ//m/gEOapqBCd2jkZsJR0Jx6RSX7O1t6eSQc8
	 fR068ML8T0ZFy2kJa0090AMOVwpp+bpGR2Sm/RQ6k4YODu7n3KfsTlOCv8ZoXfZ16/
	 gitqe9yPwATYQ==
Date: Mon, 19 May 2025 08:19:57 -0700
From: Kees Cook <kees@kernel.org>
To: Sameeksha Sankpal <sameekshasankpal@gmail.com>
Cc: skhan@linuxfoundation.org, luto@amacapital.net, wad@chromium.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: report errno and add hints on failure
Message-ID: <202505190816.2A78B3153@keescook>
References: <20250517122740.35043-1-sameekshasankpal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517122740.35043-1-sameekshasankpal@gmail.com>

On Sat, May 17, 2025 at 05:57:40PM +0530, Sameeksha Sankpal wrote:
> Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 14ba51b52095..d6a85d7b26da 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4508,7 +4508,11 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
>  
>  	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
>  	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
> -
> +	int rc = get_nth(_metadata, proc_path, 3, &line);
> +    	if (rc != 1) {
> +        	printf("[ERROR] user_notification_fifo: failed to read stat for PID %d (rc=%d)\n", pid, rc);
> +    	}
> +    	ASSERT_EQ(rc, 1);

An ASSERT will stop execution, so if it fails, you'll never reach the
printf. And a "printf" shouldn't be used. What you want to use is TH_LOG,
probably like this:


	rc = get_nth(_metadata, proc_path, 3, &line);
  	ASSERT_EQ(rc, 1) {
		TH_LOG("user_notification_fifo: failed to read stat for PID %d (rc=%d)", pid, rc);
	}

And please don't introduce new variables in the middle -- they need to
be declared at the top of the function.

-Kees

-- 
Kees Cook

