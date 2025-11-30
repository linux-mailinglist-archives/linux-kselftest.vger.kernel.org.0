Return-Path: <linux-kselftest+bounces-46766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D82C9526A
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA6124E0463
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928027FB1C;
	Sun, 30 Nov 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9pWB7Ik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452B26FA5B;
	Sun, 30 Nov 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764520846; cv=none; b=sT0xxPSt5vWzcWB3dVYwM0RmepXqphvFlo0kosD0W42Q2rQQ2D5CKa8KbgGPkIVv8AAZ8dJIYBXJjPptOByK7vsRlZ+u2To9ODUtnTco/0iqzsBXubZrULj0y9VhFWnGDdRwdjKdULcuYUFGpLV/4gkWhscWl0/royYQXbSFRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764520846; c=relaxed/simple;
	bh=jkPaUslI5nGYYPviVGnb04tDKHkKdeQw1bzud2VOOF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/fLSr4+n3hKkVVvGOkjd6R6QI83KEXIoh0PQNEk2IAqhVSOOLF7LAfqu/RX1a+N/dAbkRgR3iJkcikBt1zbL2MtueIrkYLm7YqroI//OaPjDRZPA+qXZdKUl8YwqnvrnzGm+a6+AYL2KejUISo480o9fSuNJ5ax/62HevOD9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9pWB7Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F8EC4CEF8;
	Sun, 30 Nov 2025 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764520846;
	bh=jkPaUslI5nGYYPviVGnb04tDKHkKdeQw1bzud2VOOF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9pWB7IkOOZv0FkHNA5h35HHVbIeT7t6LLptnC4fOpn/R7szaPjq1sEqYCmUd7S1g
	 ojUs9E63dEakq/KrfHTk8pPg9SxWLvJJYDu8+y2jRWwBjvH4lNS7Ca/aD/Xr7bGoeg
	 R/jhbHww3pLeRUWK87FOcLg8atVm4r9Gu+/oBT3B020ikMAFuNyC6gmkJLGO957EYi
	 tAvLrgwkz4nyCtveAvkFBbtJ+7RdpA1/Xc2MHION5OOkkSSZXHep861oCdIntnWm5d
	 6bAkOhaltOJ6BVHfY5f5Wucz0eIDq/A9l943nebMHGoz4BZ4W+ox86XJ1m2SUfNbLR
	 FdPiJ+hKlOWdA==
Date: Sun, 30 Nov 2025 16:40:42 +0000
From: Simon Horman <horms@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: netconsole: remove log noise due to
 socat exit
Message-ID: <aSxziiGia10e5Stm@horms.kernel.org>
References: <20251129-netcons-socat-noise-v1-1-605a0cea8fca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129-netcons-socat-noise-v1-1-605a0cea8fca@gmail.com>

On Sat, Nov 29, 2025 at 12:24:19PM +0000, Andre Carvalho wrote:
> This removes some noise that can be distracting while looking at
> selftests by redirecting socat stderr to /dev/null.
> 
> Before this commit, netcons_basic would output:
> 
> Running with target mode: basic (ipv6)
> 2025/11/29 12:08:03 socat[259] W exiting on signal 15
> 2025/11/29 12:08:03 socat[271] W exiting on signal 15
> basic : ipv6 : Test passed
> Running with target mode: basic (ipv4)
> 2025/11/29 12:08:05 socat[329] W exiting on signal 15
> 2025/11/29 12:08:05 socat[322] W exiting on signal 15
> basic : ipv4 : Test passed
> Running with target mode: extended (ipv6)
> 2025/11/29 12:08:08 socat[386] W exiting on signal 15
> 2025/11/29 12:08:08 socat[386] W exiting on signal 15
> 2025/11/29 12:08:08 socat[380] W exiting on signal 15
> extended : ipv6 : Test passed
> Running with target mode: extended (ipv4)
> 2025/11/29 12:08:10 socat[440] W exiting on signal 15
> 2025/11/29 12:08:10 socat[435] W exiting on signal 15
> 2025/11/29 12:08:10 socat[435] W exiting on signal 15
> extended : ipv4 : Test passed
> 
> After these changes, output looks like:
> 
> Running with target mode: basic (ipv6)
> basic : ipv6 : Test passed
> Running with target mode: basic (ipv4)
> basic : ipv4 : Test passed
> Running with target mode: extended (ipv6)
> extended : ipv6 : Test passed
> Running with target mode: extended (ipv4)
> extended : ipv4 : Test passed
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 87f89fd92f8c..ae8abff4be40 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -249,7 +249,7 @@ function listen_port_and_save_to() {
>  
>  	# Just wait for 2 seconds
>  	timeout 2 ip netns exec "${NAMESPACE}" \
> -		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}"
> +		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}" 2> /dev/null
>  }
>  
>  # Only validate that the message arrived properly

I'm always concerned that a blanket redirect might hide some corner
cases in the future. But I do agree that this addresses the issue
at hand. And probably I'm over-thinking things here.

Reviewed-by: Simon Horman <horms@kernel.org>


