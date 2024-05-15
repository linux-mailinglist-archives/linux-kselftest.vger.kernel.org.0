Return-Path: <linux-kselftest+bounces-10249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5B8C6427
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B58B231F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F95A116;
	Wed, 15 May 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIqJy+Oz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B195914C;
	Wed, 15 May 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766515; cv=none; b=TrSza2ReL8b6cMnra4sQVS1ERymG8iE52egcUTmNdl/1n2PwtQEvRfyWZ+/oEUHSAwsVW9df8kCb/fGTqw/SPRc90m5IMTRW6DY0pBqALn4dwaJ5Jvieop9juMtwf3v2Sk7cZk8swOnsM28IDMLz7kTXFJm9SL78l2WFG8+2aSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766515; c=relaxed/simple;
	bh=dW4XzXkdq+Ja/Dw/2N3tZiM/mGQj/ucsHQwY0STLJoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adNGv8EPbLzzXs8U0LfxG3NTiy/iGgbjydXUQyz7awamQsKZK4xhXgDe46E5USbPaWz53qRUg97mLfGKRhOcvBgJro52Ur2jzUX3csxIfV/fDRcBKzsPLTz4oSx3OUtU7iCILf4dieDukdX0Q6N6qSJ+m9rFepDuBWhDr1EV8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIqJy+Oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A60AC32786;
	Wed, 15 May 2024 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715766515;
	bh=dW4XzXkdq+Ja/Dw/2N3tZiM/mGQj/ucsHQwY0STLJoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIqJy+OzRu2eANqM1Cr1r30LZxK8LnzmlifBnWfhLA7KlvhGlm7z7uw1rVbUE204n
	 I4QWDSD7SLNPl2eq+eQPUKJSsdp1aFfH1VWfxfhJsmLkEZz6qWuvxCPrp3ugmw8RuO
	 q8IaYmsbwuMvmHYrMm1gdb97Cv0s4Z11la/ATeotiD3TkKqvRFDQd4IdI8K3Q6TFkL
	 VlA+pyy95m5tolQH0SNLFpupWBqPn1hYQe0Ox3f2VEmSyJ7MTDmMZQ7lspg7k0tN4g
	 nKD2FTfLaFkOedVL6+/ka9pxHwlLttrWXjj05xQiuGqr7NVBjfU0lg7VUqRmnPDBuY
	 ryrYLvBHbPnuw==
Date: Wed, 15 May 2024 10:48:31 +0100
From: Simon Horman <horms@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: net: kill smcrouted in the cleanup
 logic in amt.sh
Message-ID: <20240515094831.GA154012@kernel.org>
References: <20240513060852.1105380-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513060852.1105380-1-ap420073@gmail.com>

On Mon, May 13, 2024 at 06:08:52AM +0000, Taehee Yoo wrote:
> The amt.sh requires smcrouted for multicasting routing.
> So, it starts smcrouted before forwarding tests.
> It must be stopped after all tests, but it isn't.
> 
> To fix this issue, it kills smcrouted in the cleanup logic.
> 
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> The v1 patch is here:
> https://lore.kernel.org/netdev/20240508040643.229383-1-ap420073@gmail.com/
> 
> v2
>  - Headline change.
>  - Kill smcrouted process only if amt.pid exists.
>  - Do not remove the return value.
>  - Remove timeout logic because it was already fixed by following commit
>    4c639b6a7b9d ("selftests: net: move amt to socat for better compatibility")
>  - Fix shebang.
> 
>  tools/testing/selftests/net/amt.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
> index 5175a42cbe8a..d458b45c775b 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
>  # Author: Taehee Yoo <ap420073@gmail.com>

Hi.

I think that the change above is not related to the fix below.
I think it should be in a separate patch targeted at net-next.
And as net-next is currently closed it should be posted once it
reopens, after the 27th May.

The changes below look good to me.
I suggest resending only those changes, targeted at net, as v3.

Thanks.

> @@ -77,6 +77,7 @@ readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
>  readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
>  readonly RELAY=$(mktemp -u relay-XXXXXXXX)
>  readonly SOURCE=$(mktemp -u source-XXXXXXXX)
> +readonly SMCROUTEDIR="$(mktemp -d)"
>  ERR=4
>  err=0
>  
> @@ -85,6 +86,11 @@ exit_cleanup()
>  	for ns in "$@"; do
>  		ip netns delete "${ns}" 2>/dev/null || true
>  	done
> +	if [ -f "$SMCROUTEDIR/amt.pid" ]; then
> +		smcpid=$(< $SMCROUTEDIR/amt.pid)
> +		kill $smcpid
> +	fi
> +	rm -rf $SMCROUTEDIR
>  
>  	exit $ERR
>  }
> @@ -167,7 +173,7 @@ setup_iptables()
>  
>  setup_mcast_routing()
>  {
> -	ip netns exec "${RELAY}" smcrouted
> +	ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
>  	ip netns exec "${RELAY}" smcroutectl a relay_src \
>  		172.17.0.2 239.0.0.1 amtr
>  	ip netns exec "${RELAY}" smcroutectl a relay_src \

-- 
pw-bot: changes-requested
> 

