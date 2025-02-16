Return-Path: <linux-kselftest+bounces-26742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC000A37497
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 14:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA045169B62
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ECE194091;
	Sun, 16 Feb 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxMEGI4V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D018FDB2;
	Sun, 16 Feb 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739714273; cv=none; b=dKJQ/AaKh8Jo8EDKe9fQonra6ZRV4opecPfor/Qg/y08luSvgm1jGBJeyaViR/QeMUVlsJR6VdC/HnUJmj5U4L6tpEMEXVWKPGw7YeKrDigShU42wUwoBT2NLC/Ln6cPnO0zNcP+p/faD2ds1sW/caV2kBEKlXxWjCDEX4jQY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739714273; c=relaxed/simple;
	bh=W0mlJ4QFlDvg199xk0V7dB/8I/5mWZcRuWmBX/EAsDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPRO0iC6YsCovls4ySFGhZAlVSY9ErD89Xf6TjSl7s++cQjyGyr7KrRiKEp8hZIs7vSfZknLzE6Hp00fAKS/9eVDvvO3CyjVFUwrI3wGeVxGETw4pQvom1gmK/feWCVbYGzSFN/ABUj4vJSX98kNDLbChQu5S/7u9SeuxJDJmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxMEGI4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED15C4CEDD;
	Sun, 16 Feb 2025 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739714273;
	bh=W0mlJ4QFlDvg199xk0V7dB/8I/5mWZcRuWmBX/EAsDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxMEGI4VX5UDhy5Ulo+o3l0r/cjhhHjmRK3ubXCUTnh9z2OauqdkD3sqIGNyu9ncM
	 zuXfeaY8y96fjiwAyocmviWOghz7MNvzUA+N4p6qbjV0O11M+qtaXsx+QNiRyy8RCO
	 tQyptZgfdX2NsglKq+2Rmz+3Ei9Y38JidM4N7SL4k1m7u2tmXwAFGMzYBjWf1otkKT
	 34moAPnUJaBisBwMKBYxqmjjHQ60WrzgHmoTm4k8jGKIQEeByirQ2/PrTRvUU5PCF1
	 bqoNTl2Ozf9OLWalFzCECGAPINLOuiPeETquCOzeu8+6mzmeld6JH3p87Quq+CjBQ/
	 6UQz02PyJwUgg==
Date: Sun, 16 Feb 2025 13:57:48 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 1/8] net: pktgen: fix mix of int/long
Message-ID: <20250216135748.GD1615191@kernel.org>
References: <20250213111920.1439021-1-ps.report@gmx.net>
 <20250213111920.1439021-2-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213111920.1439021-2-ps.report@gmx.net>

On Thu, Feb 13, 2025 at 12:19:13PM +0100, Peter Seiderer wrote:
> Fix mix of int/long (and multiple conversion from/to) by using consequently
> size_t for i and max and ssize_t for len and adjust function signatures
> of hex32_arg(), count_trail_chars(), num_arg() and strn_len() accordingly.
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v4 -> v5
>   - split up patchset into part i/ii (suggested by Simon Horman)
>   - instead of align to most common pattern (int) adjust all usages to
>     size_t for i and max and ssize_t for len and adjust function signatures
>     of hex32_arg(), count_trail_chars(), num_arg() and strn_len() accordingly
>   - respect reverse xmas tree order for local variable declarations (where
>     possible without too much code churn)
>   - update subject line and patch description
>   - fix checkpatch warning '"foo * bar" should be "foo *bar"' for
>     count_trail_chars() and strn_len()
> 
> Changes v3 -> v4
>   - new patch (factored out of patch 'net: pktgen: fix access outside of user
>     given buffer in pktgen_if_write()')

Thanks Peter,

A minor nit below, but this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -777,10 +778,10 @@ static int hex32_arg(const char __user *user_buffer, unsigned long maxlen,
>  	return i;
>  }
>  
> -static int count_trail_chars(const char __user * user_buffer,
> -			     unsigned int maxlen)
> +static ssize_t count_trail_chars(const char __user *user_buffer,
> +				 size_t maxlen)

nit. as there will be a v2 anyway: the above can fit on one line.

>  {
> -	int i;
> +	size_t i;
>  
>  	for (i = 0; i < maxlen; i++) {
>  		char c;

