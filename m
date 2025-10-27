Return-Path: <linux-kselftest+bounces-44114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC0C0F6A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9261884721
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798B2D23B9;
	Mon, 27 Oct 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkQjl9h9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65540239E63;
	Mon, 27 Oct 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583532; cv=none; b=PsBkOCq/FqE/4xc6BXqPrCATYhqRVJPgpDk9uY+kEKnOxUc2SjSS0TJyZMwa3bon3EXeyFcmMAdijGIGt3BexuavkExgVCZjoffukppHOym2Dke+NEG/x32edFk+OiGrpSciTNLBzUIZC+SibOSB6iU4coQl93ggksYWGKL/iBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583532; c=relaxed/simple;
	bh=iKOVWF2RnfnIr0oOaw/PDTKY+Q3jxgn4qKv3p2eNTkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPYhKR7UEta/E9EKy6AAwQ8rpKuvV5HEFikwzgcCABNqJW7MHLxOsJ3Nyq6Wectj/dOCm+ASqv09MuzO2QVMXrzWggM4+IBbkn+jDjD4xtaEsK234xRzICFyQ4Lq7s3xOpUWrUn5DYFdJrf1T22jKoU2vHmvAnien0NRPruWgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkQjl9h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0377CC4CEFD;
	Mon, 27 Oct 2025 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583531;
	bh=iKOVWF2RnfnIr0oOaw/PDTKY+Q3jxgn4qKv3p2eNTkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkQjl9h9KohVvz65bHU+yH04xkh+S8fYTnr8QeHrTV4PSsCyK71TLKAPocn4quoeS
	 ntVDFx10SoLftdxXvKGbgOFZKokROQylrGH0FYJ9IJs5bdrEXbpki0LTSn8qx9CjJm
	 8EA4N8ot1fReXS9FxgYFa1M+G9EBiF6N1QQhbQsdrE6GHoBXTOSJyGqx92rNgEFIZE
	 nv5LCIgrybSDCuXTvlCZJY23r0TccWdxSS/MTbl5QJlK4Em8N4ycnMR/fzEo7dq4Cf
	 J9LDNjjZs9PE1dSbCNCs+debXClghryq+/W2++unwGI5THXvUk1EbAKYU2D3HncncK
	 wgC1Ld0SOho3w==
Date: Mon, 27 Oct 2025 16:45:27 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aP-hpxMgB5tN7KJ3@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-1-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-1-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:05PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Improve usability of logging functions. Remove the test name prefix from
> logging functions so that logging calls can be made deeper into the call
> stack without passing down the test name or setting some global. Teach
> log function to accept a LOG_PREFIX variable to avoid unnecessary
> argument shifting.
> 
> Remove log_setup() and instead use log_host(). The host/guest prefixes
> are useful to show whether a failure happened on the guest or host side,
> but "setup" doesn't really give additional useful information. Since all
> log_setup() calls happen on the host, lets just use log_host() instead.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

...

>  log() {
> -	local prefix="$1"
> +	local redirect
> +	local prefix
>  
> -	shift
> -	local redirect=
>  	if [[ ${VERBOSE} -eq 0 ]]; then
>  		redirect=/dev/null
>  	else
>  		redirect=/dev/stdout
>  	fi
>  
> +	prefix="${LOG_PREFIX:-}"
> +
>  	if [[ "$#" -eq 0 ]]; then
> -		__log_stdin | tee -a "${LOG}" > ${redirect}
> +		if [[ -n "${prefix}" ]]; then
> +			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'

FIWIIW, I would drop cat from this line.

> +		else
> +			cat
> +		fi
>  	else
> -		__log_args "$@" | tee -a "${LOG}" > ${redirect}
> -	fi
> -}
> -
> -log_setup() {
> -	log "setup" "$@"
> +		if [[ -n "${prefix}" ]]; then
> +			echo "${prefix}: " "$@"
> +		else
> +			echo "$@"
> +		fi
> +	fi | tee -a "${LOG}" > ${redirect}
>  }
>  
>  log_host() {
> -	local testname=$1
> -
> -	shift
> -	log "test:${testname}:host" "$@"
> +	LOG_PREFIX=host log $@

shellcheck suggests keeping the quoting of $@.
This seems reasonable to me. Although in practice I don't think
it will change the behaviour of this script.

>  }
>  log_host
>  log_guest() {
> -	local testname=$1
> -
> -	shift
> -	log "test:${testname}:guest" "$@"
> +	LOG_PREFIX=guest log $@

shellcheck also points out that log_guest is never passed
arguments, so $@ can be dropped. If you prefer to keep
it then, as per log_host, it seems reasonable for it to be quoted.

>  }

...

