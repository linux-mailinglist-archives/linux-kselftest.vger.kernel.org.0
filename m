Return-Path: <linux-kselftest+bounces-22912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85629E6EBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 14:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A0328151D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB45204097;
	Fri,  6 Dec 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnPepYaX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391D5464A;
	Fri,  6 Dec 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490000; cv=none; b=k/0tVQQ8Dkxa35NL2m0Gx5pgoggpN9isFfF2Qb9SpUJ8tFOZPzUNBlCGAFUdxQXMEGd0EUaZ+8P8/iGkPr27/KEmTfuFBJKwFtA1nBm5PXr4x8iPMVbBiB56Hwj/ymWEp0UkzWesiQfO9mO25y77pBeFg849mcDaChx2bwcCpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490000; c=relaxed/simple;
	bh=wUKOSUXksVXl0E6Tmv5WTo83O8nE1lYQrPmQL+4Ly0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQxwStBA6/ZbLVWQ03kUyN+pEL9gUaR013BZeARzAWLpuEDTQXcV42mdEFUsDYhQT4CDikpExDB6net7uhkKee3QnTkltHVmLxoV7zpWN7kx1YPnWjyGBNatHqCQX62HVNk4InsWnZHTEBkubzzGToHcS3Huln2f5ZcM9RCVcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnPepYaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD13C4CED1;
	Fri,  6 Dec 2024 12:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489999;
	bh=wUKOSUXksVXl0E6Tmv5WTo83O8nE1lYQrPmQL+4Ly0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnPepYaX8z2d5kbt8HoETblI7L9Q4enhaxH8WKLS1Pz8lGtk65jIwLSEE3AX16yab
	 9uR0KEEBkxGrsX9Ob8FaYJ1kDoYVu+8U1SGUVreIYSSfOKdknTXZfY1cHyZ+S1tVBC
	 yUHMCr13mo5YLb7khZMLzobIpTDSnBQybL/WgBUWeaDb23oqfk+Qq+kGApJNoi88yH
	 ISogCzjFIQYLf8bS37pHMaPU2WD1Qnqased58LPlX4r2d7mv6adrGJzONWGLURfDd3
	 btxyG06LmOJuJWpojSOM+u6ncP2bCvN2jhcZM2VUWeEPWQuEN041BaGtzNAFDNLgb4
	 0QlE1QL2qiV1w==
Date: Fri, 6 Dec 2024 12:59:55 +0000
From: Simon Horman <horms@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: Fix typo in psock_tpacket.c
Message-ID: <20241206125955.GO2581@kernel.org>
References: <20241204075756.11561-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
In-Reply-To: <20241204075756.11561-1-zhujun2@cmss.chinamobile.com>

On Tue, Dec 03, 2024 at 11:57:56PM -0800, Zhu Jun wrote:
> The word 'accross' is wrong, so fix it.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/psock_tpacket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
> index 404a2ce75..221270cee 100644
> --- a/tools/testing/selftests/net/psock_tpacket.c
> +++ b/tools/testing/selftests/net/psock_tpacket.c
> @@ -12,7 +12,7 @@
>   *
>   * Datapath:
>   *   Open a pair of packet sockets and send resp. receive an a priori known
> - *   packet pattern accross the sockets and check if it was received resp.
> + *   packet pattern across the sockets and check if it was received resp.
>   *   sent correctly. Fanout in combination with RX_RING is currently not
>   *   tested here.
>   *

Thanks Zhu Jun,

FTR, I'm not sure that I understand the grammar in the comment.
But the spelling correction looks good to me and codespell
doesn't seem to flag any other spelling errors in this file.
So this change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

