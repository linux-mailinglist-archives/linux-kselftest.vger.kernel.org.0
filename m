Return-Path: <linux-kselftest+bounces-17335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A00B96E51E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9953BB20B73
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD019414A;
	Thu,  5 Sep 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAWla+Jf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C67115687C;
	Thu,  5 Sep 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571891; cv=none; b=L/ZDiQgrA4EiYYQ4SaduVpcMHx7Ud8jMC4SRBMxWB4qJvYQHGj0dTJSDjSEhtatLRuHQNep0TGOqAhT2MCE4Kb1JvUDpDYw3eVT6jrmZq/vC+GsphUOxPvJvhc768aHiNPuCpLInaW90leobCyIy+RwLP+OE8H+U6JCEx4RZJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571891; c=relaxed/simple;
	bh=2AcRCNYQpVDUrd7pyYpEzZZfBbkzxR5Sgp2YPhjiZeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyWNBgsxst8LmhCroh0p6AO/+lmlfGVny7boEFwcjm7IMci8az9Am37Exgrc/WRvZNfvII7CrOM2TEgHCMFbbOStthCI23+51Rh5pY82kiTqnGCx8nTYQD6RwmsZ/P6eLV7dkyYfhoVsRNXKvw6eyGC3qG6PrJdmI7j7+N7rwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAWla+Jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C120C4CEC3;
	Thu,  5 Sep 2024 21:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725571889;
	bh=2AcRCNYQpVDUrd7pyYpEzZZfBbkzxR5Sgp2YPhjiZeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAWla+JfhpYQNOKA6Ijjxrts6bmkARrpk2+IOco2J3UL0EWg3B8IiEF/QDb7TeR15
	 azFL8hrjxGsB08gYtxTScO6l/Z1qZivbzyiLrIVoZgqj2gUfTrz+QuLZKD7VCuBvFf
	 Awz/g5YOGoU8Bk9tX7JkgeDbc7PkGERV46oZP3JIrNaPjcHUrja574RjbFpjXp2kpq
	 QWzO9uAKlqJ/Oo3SHfl+ph+x3IWVjmxsmaTGVJI713SvuXhFzzbxMpiNFJtd1w3uvv
	 nbQ2xeM5KV3Ya+vV8+lLCZzJp6s3Aj7shECuB84WPt36KEk74Ap+mRfJBTWQyv3xEJ
	 NrTGYjr3OCVOQ==
Date: Thu, 5 Sep 2024 14:31:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next 2/2] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240905143128.0dde754f@kernel.org>
In-Reply-To: <20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
	<20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 23:07:03 -0400 Willem de Bruijn wrote:
> +++ b/tools/testing/selftests/net/packetdrill/config
> @@ -0,0 +1 @@
> +CONFIG_TCP_MD5SIG=y

Looks like this is not enough:

# 1..2
# open tun device: No such file or directory
# not ok 1 ipv4
# open tun device: No such file or directory

https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/1-tcp-inq-client-pkt/stdout

Resulting config in the build:

# CONFIG_TUN is not set

https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/config

Keep in mind the "Important" note here:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build

I recommend using a fresh tree or mrproper for testing vng configs.

Feel free to post v2 without the 24h wait, it's a bit tricky to handle
new targets in CI, sooner we merge this the less manual work for me..

