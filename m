Return-Path: <linux-kselftest+bounces-49327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6BD39E47
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 07:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B48E3038993
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCEA24466C;
	Mon, 19 Jan 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ8fgPl2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE4381AF;
	Mon, 19 Jan 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803424; cv=none; b=l8yzv6BYW0QiyiNfj6uh1NTDmLUgQEPXW6JD2Ce7r1RfxiB5eedGMb3gcSPs99KdAd/JEIXJew1Bp/82l4niTmc769DyCDxLNI/shBkM1442Atx+GaHaTiFINVBOOLpV2+qyOraPeL699sV7snQHBdhOTh03EVOPEp5w3row61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803424; c=relaxed/simple;
	bh=QETn13R73S5/GcHX+qI13XXSll7BGlIfb+ruyBizkvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=py6D41gvnEOYY52Yt4d1PbwXDBKdvhthsNbRzDj1m6sQIljdLM+X+U52ZGInwlAyj7GWGO07UvyBQ9fAgwiLEIVxuJrzA6UEhBGrKdTRXKymyWiAVXxFNcU6Ot1dZiclfstGC1oZXTuuon90bk3aMNoTC+3wgKZp5TowTOE0ZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ8fgPl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F15C116C6;
	Mon, 19 Jan 2026 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768803423;
	bh=QETn13R73S5/GcHX+qI13XXSll7BGlIfb+ruyBizkvI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sJ8fgPl26LZtqwJFIYUCRiFxLnbGacVkuaNHfYWWWNerl+kYC6kOs+KIwpXl4CkAZ
	 IFV2T4iuPw8KX9hwloyaDE/kY010FucLAKvhciEY3nF2B65y428uB+kOCVHIchOD6s
	 e2AcM5ad/IYzJoqozwGA7T1vYceW8tg58hTV5zdyz2FThqOTp4WyfSwZ1evVO/mL9T
	 YrSSh6laNeAmybcOlukRjwEsHhdev6V3j9gecflH/nig3ZlDBedSxkNWFLj559Xw3v
	 nuF9ditg/GzJvvR7x5rvjQY9XkvLxQdJlA3xJe4Uj08cs6kEp1ec9uzre39ujH7EMC
	 tnwfVCLINCWNg==
Message-ID: <66b44ded1d5174131e90fae85b296ef89a53ab24.camel@kernel.org>
Subject: Re: [PATCH net-next v2] selftests: tls: use mkstemp instead of
 open(O_TMPFILE)
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)"
	 <matttbe@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca	
 <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman	
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Gang Yan
 <yangang@kylinos.cn>, 	netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Date: Mon, 19 Jan 2026 14:16:32 +0800
In-Reply-To: <20260115184922.7e346931@kernel.org>
References:
	 	<2fa14a04f5287c956a1112cef8cdfb2c86931d2d.1768467496.git.tanggeliang@kylinos.cn>
		 <20260115184922.7e346931@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Jakub, Matt,

On Thu, 2026-01-15 at 18:49 -0800, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 17:02:40 +0800 Geliang Tang wrote:
> > This is because the /tmp directory uses the virtiofs filesystem,
> > which does
> > not support the O_TMPFILE feature.
> 
> I don't think selftests are expected to support setups where /tmp 
> isn't tmp. Please fix your setup instead (or explain why it's very

Thanks for reviewing. I recently implemented TLS support for MPTCP and
have been adding MPTCP test items to the TLS selftests. When running
these in the MPTCP upstream CI (mptcp-upstream-virtme-docker), these
O_TMPFILE unsupported errors occurred.

Following your suggestion, I looked into the mptcp-upstream-virtme-
docker configuration and found that /tmp isn't mounted as tmpfs; it's
just a plain directory. I've opened a PR to address this:

virtme: mount /tmp as overlay for O_TMPFILE support

https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/pull/43

@Matt

This change adds "--overlay-rwdir /tmp" to virtme-run options, ensuring
/tmp gets mounted as an overlay filesystem. It functions correctly,
though I'm not certain it's the ideal solution.

Thanks,
-Geliang

> crucial that you don't). The upstream CI runs all the selftests in
> VMs and they are working just fine.

