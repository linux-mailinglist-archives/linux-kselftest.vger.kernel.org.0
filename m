Return-Path: <linux-kselftest+bounces-18369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4A9866B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326491C215A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8BC487B0;
	Wed, 25 Sep 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm9XyDEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9E1D5AD8;
	Wed, 25 Sep 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291740; cv=none; b=Y9e0CE/zuE/CIYvCvR8C6WYbRHT8kF2Y3cvTmBlY0Q0CgPYWS+2JoSD9fF8fQYPTDOUYZdohgCSuKQYkG08lcoDHlnnto7bOBseVdwHgmFLt/5nbcs+IVjSHse7D1ALOx8uatnLldD8q1WrNXrhcQi+qNOL5u7GWOu1nKx+1LG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291740; c=relaxed/simple;
	bh=bvdze4USU8/AdjQQloX699LCNdkC7gCmYFf8Y4whwjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZQyrEUceS/qqo0IaHk3PVFfYxQxGuGmWXfIyvdv9TEXZTRMGDfcZi+35sj1Q79LMCFHjtRS+B0zIbje9Yc/XcsBVKFWCUF7XVbUuOuJK6pweOo8BhQMSigc9Jx9XJIO8aqltCpPaDOgAwaRP+QjAnGLPfy6d4RgJGPwGtPfHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm9XyDEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E737AC4CEC3;
	Wed, 25 Sep 2024 19:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727291740;
	bh=bvdze4USU8/AdjQQloX699LCNdkC7gCmYFf8Y4whwjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rm9XyDEsS7qJ5NVIcLBjA5YUHHrXBVZTVlas+aH43qIhjeBE0fKVlThZzWdGDEKiK
	 bhOvSWXGGmdJT6VFfjrcpjDEWSva7w+7Jer81cAUflXHAKExMO9jW+x4Z3tqt4uikd
	 VrrxCbZv/Mu1KnmEvH2Vdx7XPhURZNuaH1MD296a7LD8B/p+3LZMx5CdegqBs/M0+P
	 drQfli9Y4+w/lVCMgh8qS4MVJ6+L9DLOl5WwMqAP6juIvr4rc6VntbEHBD/44xXqv6
	 OQrHxTjRkJd5BWGMOiU8RKFdsu0kamveecASG7WGi0CpUPON99eXejVGnqhjxuvGou
	 iGqTlhzf0qGTg==
Date: Wed, 25 Sep 2024 20:15:37 +0100
From: Simon Horman <horms@kernel.org>
To: Kacper Ludwinski <kacper@ludwinski.dev>
Cc: davem@davemloft.net, kuba@kernel.org, vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix issue related with assigning two diffrent vids to
 the same interface.
Message-ID: <20240925191537.GX4029621@kernel.org>
References: <20240925043724.1785-1-kacper@ludwinski.dev>
 <20240925050539.1906-1-kacper@ludwinski.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925050539.1906-1-kacper@ludwinski.dev>

On Wed, Sep 25, 2024 at 02:05:39PM +0900, Kacper Ludwinski wrote:
> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
> Signed-off-by: Kacper Ludwinski <kacper@ludwinski.dev>
> ---
>  tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

...

Hi Kacper,

Thanks for your patch.

Some feedback in process:

* Please do not post updated versions of patches within 24h of each
  other.

* Please do post new versions of patches in new threads,
  with appropriate versions in the subject (v2 in this case).
  And some text under the scissors ('---') describing that the change is.
  b4 will handle this for you.

* Please include some text in the commit message,
  in this case describing the problem that is being resolved.

* Please tag patches for Networking as being targeted at either
  the net or net-next trees.

  Subject: [PATCH net v2] ...

* Please refer to git history and include an appropriate prefix
  in the subject of the patch. In this case it looks like
  it should be 'selftests: forwarding:'

  Subject: [PATCH net v2] selftests: forwarding: ...

* Please consider reading the netdev maintainers process guide
  https://docs.kernel.org/process/maintainer-netdev.html

Lastly, there is a spelling error in the subject.
checkpatch.pl --codespell flagged this.

-- 
pw-bot: changes-requested

