Return-Path: <linux-kselftest+bounces-21621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67B49C0ABC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 17:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235A51C22A3A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B22144D6;
	Thu,  7 Nov 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWOynBlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5832212F14;
	Thu,  7 Nov 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995461; cv=none; b=jSmMDn2t7SdhiZu67zvE7Ieu/ckyVaKnxdXnzziX+NpJxzl/fxJodYhwhEnBjPofCyAnDzjThp62AY+i1BxC2DW+icwnDmFwcIOIys2lRSFZT2f3TokH1LNgp3dEM0EypWUGP6NQJEPrNFIe8/Ca+ZZgqEoBmra77tSDu/cXTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995461; c=relaxed/simple;
	bh=dCNMmr5zBxOA3bfbEXeGxa+VB0gJCMUECIq25V6staE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osoXuz4mFPbdZ3mUCl9k1a16+RxNnfKh3pRU+OJGkVwCw3BekhPq8wa1ajgDMtkw9f4jd/QecTZdVKA22Ks6+tBILG73czepBWvXGT1TioFGXq8Y+g4Agg6YmJzW79a8xfPqMtufo44I+5jVgYZdKmDqtvCUIO+HZJ9sESd598g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWOynBlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8AFC4CECC;
	Thu,  7 Nov 2024 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730995461;
	bh=dCNMmr5zBxOA3bfbEXeGxa+VB0gJCMUECIq25V6staE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EWOynBlxu+wR96ilgRqOT460rhUM2cuzX4KpTEZBVgDeK5f5a7JjBi4LB8y6PqJwO
	 V4b7WsvoY3neqxuQYFLDmZHIcAeGNul4nmi7DwQI97e1pN6G7PQ96uB+1dtV1/IePo
	 V3/PTPTXb/fFdZSpnR/iYwCZsG6uh01rgIyPMHleeDBrjkjsKxqJKm8Q6+9lury0ZI
	 Hmnx0Mo9m5Cf8dgAoouag3maeZ4VEoKXsMv8BCCwlzz/XPxdU2sQpjefTi1MpTado5
	 KqbYHicZ+TL33DSz6X1ayyTKwk8ZT/Zdjs+DE6+WzPk8iQSLHLtrzJbLRVDE6VcfGa
	 D/92fBDzwMFQA==
Date: Thu, 7 Nov 2024 08:04:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next v2 7/8] tools/net/ynl: Add retry limit for
 async notification
Message-ID: <20241107080420.6a5a5243@kernel.org>
In-Reply-To: <20241107133004.7469-8-shaw.leon@gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
	<20241107133004.7469-8-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 21:30:02 +0800 Xiao Liang wrote:
> Since commit 1bf70e6c3a53 ("tools/net/ynl: improve async notification
> handling"), check_ntf() would block indefinitely if there's no messages.
> In some cases we want to set a limit on waiting time. This patch adds
> max_reties parameter check_ntf(), and makes it stop when no message is
> recievied in that number of consecutive retries.

Looking at 1bf70e6c3a53 again I wonder if we should revert it, sort of,
and add its logic back as a new function called poll_nft?

The thing is C YNL has check_ntf too - ynl_ntf_check() and it has the
old semantics. Would be nice for similarly named functions to behave
the same across languages.

WDYT Donald? Sorry for not thinking about this earlier.

Xiao, feel free to submit this separately from the series.

