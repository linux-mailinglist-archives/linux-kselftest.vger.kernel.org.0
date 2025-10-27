Return-Path: <linux-kselftest+bounces-44115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20DBC0F704
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A0D1894D11
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E86312821;
	Mon, 27 Oct 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5xcnDSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8652D3A94;
	Mon, 27 Oct 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583713; cv=none; b=YOgGKp+fnc6ti9Vchtgtkj29allB/sJ5UlB4AXe2+tbQZaETVPGzmaQW+lRVt8FFAFl6awfryg1q7pAnCPn/ybt+CQUhE6nzqJzieYOyNblZWVPLXjhKzRd9zfeU/BDTU8vPmJnEVBGiB9rWpKzaTytKwN2x/FiyNHqqXRhoqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583713; c=relaxed/simple;
	bh=W2BSw3L8tRrkFqt+YO1ziJs5cGtsxtmyxbuWeq4h6EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRgtbBzcEsBI1cu9OPX5DysK2goj+BA6nfNJxwidNdudyR/14T8PBCOuG2kBKITvUD6Q1dvG9bQqfLqLJJFuxV6Om584uYIqEJKi+qaVx2T9fc+Libx9516Eo4fKd9QBD84HyoJq4v/4axMoPkNZdoeVz2C/dqGp6IWdQoPnv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5xcnDSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B28C4CEF1;
	Mon, 27 Oct 2025 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583713;
	bh=W2BSw3L8tRrkFqt+YO1ziJs5cGtsxtmyxbuWeq4h6EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5xcnDSq2QGAzj083I8xEGp8hgIToMz3fyPpIwhndLAHGeSlxpG1aOvNbYMGNF4U9
	 nw31z2NGOp1mKx3z1EdAHzWjf4N+IWzNnsZJWR57qFssmWWURil/1yOcx6/QMktCtO
	 HCu3WKTgdjhbcmBtw+UaGPkrqBErZAHFw0lzlLfel7oq0UaXwAjrHZDcuPHuH59FG9
	 7dAIV+RrYyUYlsIg3VAVjyW4KYGdXnA/hHOPDRZ4EVfkGDtts3KgkYCyjkHfmDxaau
	 /JC6i3eOmkJR5iuOKzTtJfcNgfpSDsC4dwdckF7Z5NAvE167mC7hPu+q2PBCRutj0E
	 VzxXVkztuanVw==
Date: Mon, 27 Oct 2025 16:48:28 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Message-ID: <aP-iXJQVPBCjfPHi@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:06PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Save/restore pipefail to not mistakenly trip the if-condition
> in wait_for_listener().
> 
> awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
> exiting upon finding a match causes false-positives when the pipefail
> option is used. This will enable pipefail usage, so that we can losing
> failures when piping test output into log() functions.
> 
> Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 561600814bef..ec3ff443f49a 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -243,6 +243,7 @@ wait_for_listener()
>  	local port=$1
>  	local interval=$2
>  	local max_intervals=$3
> +	local old_pipefail
>  	local protocol=tcp
>  	local pattern
>  	local i
> @@ -251,6 +252,13 @@ wait_for_listener()
>  
>  	# for tcp protocol additionally check the socket state
>  	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
> +
> +	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
> +	# an error, causing the if-condition to fail when pipefail is set.
> +	# Instead, temporarily disable pipefail and restore it later.
> +	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
> +	set +o pipefail
> +
>  	for i in $(seq "${max_intervals}"); do
>  		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
>  		   grep -q "${pattern}"; then

Hi Bobby,

I agree this is a problem. But I'm wondering if you considered
moving the pattern matching into the awk script. I'm no awk expert.
But suspect that would lead to a more elegant solution.

> @@ -258,6 +266,10 @@ wait_for_listener()
>  		fi
>  		sleep "${interval}"
>  	done
> +
> +	if [[ "${old_pipefail}" == on ]]; then
> +		set -o pipefail
> +	fi
>  }
>  
>  vm_wait_for_listener() {
> 
> -- 
> 2.47.3
> 
> 

