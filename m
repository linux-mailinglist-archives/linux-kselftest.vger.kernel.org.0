Return-Path: <linux-kselftest+bounces-9155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41B8B7E9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FE41F22297
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3121802D9;
	Tue, 30 Apr 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0clFbDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8181802C3;
	Tue, 30 Apr 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498306; cv=none; b=Ouhj8ycXPRhSHwNiprEuYfCclMCwV9bq53VycMvujb4R1V0edPzaH5EESthWSow4MHMMAlKj+55aUGPo9h4Czu7Bj24bWE8nGsfiJ1WDLytv8YGjhRa7ZhAZtW3wbe/OGgVaMbtidMyY+zHG+vUL+zFL+ieqBMPcYSy6pLKYZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498306; c=relaxed/simple;
	bh=OZfdAv9Kd4pWfqB6VspdLN4BDbD4/2bmL+06pd8HlHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdMg0mi9Q9Z4c/1uJ4PGIeqhWJmQxFw8YLknK/SR8hsL5lvDVxVbZm21aQiwyyEUyftsCUdRHVJA2BRM986gqEMVcxqBocWZnHAYpU6vKjJicoMjGd68VmLLcfpVnOIkhDgfDK61rzPdQ5jvS/paub1DELH7mDtZBP0hPf1C3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0clFbDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A0CC2BBFC;
	Tue, 30 Apr 2024 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714498305;
	bh=OZfdAv9Kd4pWfqB6VspdLN4BDbD4/2bmL+06pd8HlHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0clFbDha9R8iPiHDUgsn1ZVjkjm/cOV7b83d3UsD49XrAzNh57sVUpxiUTbDHH/b
	 AiOryLLbKn10xcrSpBZEb3nmVKOVGpsAZ3B1r2Z4KgdobxAqQ/6eStc+GcuJm5g/kf
	 qiajgLH5smRzG84WGTv4zWA9sqrTR47r9qvzgOndkOGiSR+X7grtOV687F4CAc3PF8
	 kzLYKtIwljZh6iwtQOIiAxOYdiqlDuJ5M3ZA/6ysLXewYsbreyGSknjRjvgsS0SShU
	 KZFUvzezZpmR8GMGHt50ZroWvXxHQW8ONzWNA5Nlr4tWDnk3cif12tNUsMCllmrxtD
	 y7Im4/I4uo0uQ==
Date: Tue, 30 Apr 2024 18:31:40 +0100
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Edward Liaw <edliaw@google.com>, stable@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com,
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
Message-ID: <20240430173140.GA840359@google.com>
References: <20240430010628.430427-1-edliaw@google.com>
 <2024043037-debate-capsize-e44c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024043037-debate-capsize-e44c@gregkh>

On Tue, 30 Apr 2024, Greg KH wrote:

> On Tue, Apr 30, 2024 at 01:06:27AM +0000, Edward Liaw wrote:
> > From: Mark Brown <broonie@kernel.org>
> > 
> > [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
> > 
> > The standard library perror() function provides a convenient way to print
> > an error message based on the current errno but this doesn't play nicely
> > with KTAP output. Provide a helper which does an equivalent thing in a KTAP
> > compatible format.
> > 
> > nolibc doesn't have a strerror() and adding the table of strings required
> > doesn't seem like a good fit for what it's trying to do so when we're using
> > that only print the errno.
> > 
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers test to generate KTAP output")
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> 
> This commit is already in 6.6.29, why submit it again?

I don't see this in v6.6.29.

The function that it adds is called, but doesn't exist however:

stable/linux-6.6.y:tools/testing/selftests/timers/posix_timers.c:               ksft_perror("Can't call gettimeofday()");
stable/linux-6.6.y:tools/testing/selftests/timers/posix_timers.c:               ksft_perror("Can't set timer");
stable/linux-6.6.y:tools/testing/selftests/timers/posix_timers.c:               ksft_perror("Can't call gettimeofday()");
stable/linux-6.6.y:tools/testing/selftests/timers/posix_timers.c:               ksft_perror("Can't create timer");
stable/linux-6.6.y:tools/testing/selftests/timers/posix_timers.c:               ksft_perror("Can't call gettimeofday()");
stable/linux-6.6.y:tools/testing/selftests/timers/posix_timers.c:               ksft_perror("Can't set timer");
stable/linux-6.6.y:tools/testing/selftests/timers/posix_timers.c:               ksft_perror("Can't call gettimeofday()");

We should probably have this added to linux-6.6.y.

-- 
Lee Jones [李琼斯]

