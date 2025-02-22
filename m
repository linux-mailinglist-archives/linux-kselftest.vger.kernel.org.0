Return-Path: <linux-kselftest+bounces-27256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21134A40666
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE551757EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 08:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C122063EE;
	Sat, 22 Feb 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m7SmmnAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D72AF04;
	Sat, 22 Feb 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213457; cv=none; b=rjONxdgR4B3KObPBeogGRmC/XHVEqlYKTDAV8RgBL2np4kK6Ol0vDB6Py/lDW+rv6YbBkvGl+yfrXATrEnBNetTJdE761PHggaCmJzeXHaSS52zS7sB6eIgNIR2uy2WNBryfmSKPAI9rsHY4WFZXgY/Wj3Ho/+4m7xYV7Q3bIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213457; c=relaxed/simple;
	bh=nOFJ3LwKB+/xU1Kb8aDPrTi5hFqyakWbqSiqeaUVO44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpVB7FMcF6M4yCTeuMUibnfHq5MFaekrv3VMYaxY3AWkRsakhy5AvpAry8HjY2GXCxf4Zl9qOT66d9PzYmMu7HPSsL71USq2X8VlqW1q7nGEqsraoDau67728syyYeQsqbU/4vSfjaImHkrXyX7YZUssGmykTn1wb9djkQ6zAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m7SmmnAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A48CC4CED1;
	Sat, 22 Feb 2025 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740213457;
	bh=nOFJ3LwKB+/xU1Kb8aDPrTi5hFqyakWbqSiqeaUVO44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7SmmnAThqpY79p6an7hgde6ZVrsEFrw/a4A0kGGIaYwBDyMhGxs7sOuh30dDfN6G
	 t0N0ZOm1eqxRroBB7vsfP5TiQNFDhVJQCWufYxMSlv78R5JSqW5tTzZg3QvKNNf2vT
	 pUwHtVdnKYNq4Q8Z8yiydfCCZHHpSff+8ACGriW8=
Date: Sat, 22 Feb 2025 09:36:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: ritvikfoss@gmail.com
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/mount: Explicitly define buffer size
Message-ID: <2025022257-easter-shower-61df@gregkh>
References: <20250222081711.48208-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222081711.48208-1-ritvikfoss@gmail.com>

On Sat, Feb 22, 2025 at 01:47:11PM +0530, ritvikfoss@gmail.com wrote:
> From: Ritvik Gupta <ritvikfoss@gmail.com>
> 
> Define macro ('MAX_BUF_SIZE') for buffer size
> instead of hardcoded value '4096', to improve
> readability.
> 
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
> ---
>  tools/testing/selftests/mount/unprivileged-remount-test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
> index d2917054fe3a..67a550b7c69b 100644
> --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
> +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
> @@ -45,6 +45,8 @@
>  # define MS_STRICTATIME (1 << 24)
>  #endif
>  
> +#define MAX_BUF_SIZE 4096
> +
>  static void die(char *fmt, ...)
>  {
>  	va_list ap;
> @@ -56,7 +58,7 @@ static void die(char *fmt, ...)
>  
>  static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list ap)
>  {
> -	char buf[4096];
> +	char buf[MAX_BUF_SIZE];

As this is only used once, why is a #define really needed at all?  Only
do that if it makes sense (i.e. is checked in different places.)

thanks,

greg k-h

