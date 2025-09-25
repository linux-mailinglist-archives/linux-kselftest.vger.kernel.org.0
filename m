Return-Path: <linux-kselftest+bounces-42309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD32B9ED01
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD4A16544D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16102F1FD0;
	Thu, 25 Sep 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDwGEOIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647620DD51;
	Thu, 25 Sep 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797374; cv=none; b=a2R7Vn52HGxQ4KWT8eLJVx1fpY5PVmZTlc/6gR7ThGXaJ2Mtg7OXqByN1Q3lzTL5OzCXFtRQlOt9g73tYmiIx9VWKWkvGw9srSs4kXMgdqxO70QhApK/9FQeuw5fmkyIfp10ySpJFvI3PkDAT0O3toh/iQ8CcPuScZyd+uo7/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797374; c=relaxed/simple;
	bh=rFN5Z8FcdvSu6T/zPde/tldoP5MZ9bU5WlrMTrZ5vSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC2xVDBZ8Gi3EViOtkP9ic5ITfq7x4pM6WVx0xfeJouAhfYpNREO+xN/CgEGaR1P8NM7uiFRmMhtvrnjW9cMRfpv8pYF9J5K+uFiG6uAaWX1tvMc6TReG8GklnAoF+/qrKGrn4wOFeAMRuLyeTvH++IOTbBHfTfF7Jjb3v0Zdr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDwGEOIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5BDC4CEF7;
	Thu, 25 Sep 2025 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758797374;
	bh=rFN5Z8FcdvSu6T/zPde/tldoP5MZ9bU5WlrMTrZ5vSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDwGEOIHgpHjWwNi7yoFKnSXVW0jjz39A6A/iqU6mgnCowDLPEiX6pLjJm4C8zqP8
	 27VVGQ56CpVVwIAW77CsqJ3CwajdzF4Yeg6UCIl0Nx9hR1MkY3bZ1IAq56vQkSW5jC
	 z+EY4jh/9WGfIx4U4Xpv1j4fJ2Aq8aouErL6mvf3/9huzycgqWTctxn0c9e2gvRM7q
	 NoIbJLpFoNc7w+pgNWPvjqFIOwT03qGHwwruJFjua5qnRzLVikElqXbbFwO0RniukD
	 P0vga4T+ewCV+QWdYcs1QBbTkTtSDa5PfiVTFIPdY8PPDtzbAkjbi1P4EZ7F6NvVf+
	 6P+WDmJdg5Rtw==
Date: Thu, 25 Sep 2025 11:49:30 +0100
From: Simon Horman <horms@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: Fix error message if empty variable
Message-ID: <20250925104930.GG836419@horms.kernel.org>
References: <20250924230413.75246-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924230413.75246-1-alessandro.zanni87@gmail.com>

On Thu, Sep 25, 2025 at 01:04:07AM +0200, Alessandro Zanni wrote:
> Fix to avoid cases where the `res` shell variable is
> empty in script comparisons.
> 
> The issue can be reproduced with the command:
> make kselftest TARGETS=net
> 
> It solves the error:
> ./tfo_passive.sh: line 98: [: -eq: unary operator expected
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  tools/testing/selftests/net/tfo_passive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
> index 80bf11fdc046..2655931b2396 100755
> --- a/tools/testing/selftests/net/tfo_passive.sh
> +++ b/tools/testing/selftests/net/tfo_passive.sh
> @@ -95,7 +95,7 @@ wait
>  res=$(cat $out_file)
>  rm $out_file
>  
> -if [ $res -eq 0 ]; then
> +if [ -n "$res" ] && [ $res -eq 0 ]; then
>  	echo "got invalid NAPI ID from passive TFO socket"
>  	cleanup_ns
>  	exit 1

Hi Alessandro,

I'm not sure what $res can be in practice.
But as it is the contents of $out_file (or more specifically,
the stdout of running cat $outfile), in theory it could be anything.

So while your patch addresses one error case.
I think there are others.

f.e. if res is not empty but not numeric, then we may see

bash: [: b: integer expression expected

Or if res contains a newline, then we may see

bash: [: too many arguments


So I wonder if it is better to treat $res as a string,
and quote it to avoid unexpected side effects.

[ "$res" = "0" ]

