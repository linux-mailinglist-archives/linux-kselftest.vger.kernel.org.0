Return-Path: <linux-kselftest+bounces-9114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6B8B6C32
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B4D1F21F18
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F48405EC;
	Tue, 30 Apr 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fpxq5981"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E73FB87;
	Tue, 30 Apr 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463517; cv=none; b=WCE1dlsY+vUbW8LQVP/cZJvcYmjBjhZO5AGE+NdE/T9ahHDuuE4KLdWpOZfaUNTG/Srw1amZQywuJ2HTxktP6K4E6e/v+JzImssuO2X/qXTFT2SrQd5svcRWobRF4opGpx/c5UrHtu1WRMYTm2gqSN4VXW5d5RNns02WTB0YA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463517; c=relaxed/simple;
	bh=v0WF6wRNl0/o4ZfZUcYLksd3B2wnn2d8J5cCYz5LJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0yfobmPJrPvNS9UZY/4maXr/3fWSYeiRnh8J0W4mQatslPtjLJ8oSiY/AGqB+6qIHE48KaGTT+Rj8KwsKdGjHDkEVosyYGgjenmuvSFHwNtgR+CTD45ro6Hu8B1zEfMQIdSYYGrqIUgQq4vbvjI4PwymP/oCJkhsJJEY/Ve5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fpxq5981; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6293C4AF17;
	Tue, 30 Apr 2024 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714463517;
	bh=v0WF6wRNl0/o4ZfZUcYLksd3B2wnn2d8J5cCYz5LJiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fpxq5981i/tonHvgQuediTxuWMIbKvv5Ne3dxmiMm0+57NaqNaLrzxSit2KNKqwQt
	 1sB2Gfq/k7rpxsTFiB/Yk2rqVvlJ7iYVvTD7vxCOApgJYPbfXjwTi04locT3zBEFeP
	 U0FR3AVlJXYsMXTfYA0uKhbiYucrmOlhbIN9qnFg=
Date: Tue, 30 Apr 2024 09:51:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
Message-ID: <2024043037-debate-capsize-e44c@gregkh>
References: <20240430010628.430427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430010628.430427-1-edliaw@google.com>

On Tue, Apr 30, 2024 at 01:06:27AM +0000, Edward Liaw wrote:
> From: Mark Brown <broonie@kernel.org>
> 
> [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
> 
> The standard library perror() function provides a convenient way to print
> an error message based on the current errno but this doesn't play nicely
> with KTAP output. Provide a helper which does an equivalent thing in a KTAP
> compatible format.
> 
> nolibc doesn't have a strerror() and adding the table of strings required
> doesn't seem like a good fit for what it's trying to do so when we're using
> that only print the errno.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers test to generate KTAP output")
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

This commit is already in 6.6.29, why submit it again?

confused,

greg k-h

