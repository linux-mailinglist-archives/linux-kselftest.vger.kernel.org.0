Return-Path: <linux-kselftest+bounces-14597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C079440AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 04:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C328152F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 02:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6931A38C8;
	Thu,  1 Aug 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3XS/uqe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD81A38C5;
	Thu,  1 Aug 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475750; cv=none; b=DYZqcg98U9CJC6KySGf5FUe4kKk23ZaZC8tHntdxkStbhC4wo6Aqe80+tl2Vz4BwH1/H9r6wC2UcyKQ+ce1DqpdnGRVqrV9aQTlU5IOSO4R2rJSVJfNfAoVx6AqHQlMOwY4gA4iMpWKhUhrU/IN+S0tAVmDx9zkU4RBofWR4keU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475750; c=relaxed/simple;
	bh=0ciPDLSIU3NmNwDhhqJ3yS+YnqcZMn08ZeVju1s27Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7S6LenhIrR90hJ+UI6f8R258doxqXhna5VJ3xbBWFJ//JXaf1RPbHpV1G1/DSVjsOmtQ/QiJVwKtlJ7Eai4bwfeK2BSJ8PLhgLg1/4SFotcLRo9bvcfSq3JSPqpR7rrUycFJYfahmbCOBHJje6SnhT/VSkg9WC4jNCTk4TJusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3XS/uqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA004C116B1;
	Thu,  1 Aug 2024 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722475750;
	bh=0ciPDLSIU3NmNwDhhqJ3yS+YnqcZMn08ZeVju1s27Pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3XS/uqeuehoDY0pTa2rNDdtjNnr8MlBnU+7Z1quTQgEOmqLXffwQBUoU4ERavcLB
	 peicV4ebIh62+UJa6BUejRqP0b/GweCrxnROJ86tebX4f8u6BlfDO3G5DSQXpNR/Gf
	 lEiQtp2fEx5HfZNMcflLifaPRrRVmpMOph0HIMpvgFsTdr3Nwbg27f3rvLRCmAxjUO
	 4kzwIag/wZhQc6p31to+9N5QiU9Ul1Ce6QhKSql7Y/9TWg4lSKOZ0+vKC4rWa2OyhT
	 mrEev+R3y+QlztRzxCalkz3UebZqmaHuiSCb4i05SKz6jy/cvKwYVmXhf/bPG2LbGe
	 AU0sQzrzqNfNg==
Date: Wed, 31 Jul 2024 18:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: zijianzhang@bytedance.com, netdev@vger.kernel.org,
 linux-api@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 davem@davemloft.net, pabeni@redhat.com, dsahern@kernel.org,
 axboe@kernel.dk, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
Subject: Re: [PATCH net-next v8 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Message-ID: <20240731182908.4584a3e1@kernel.org>
In-Reply-To: <66aab8b37157d_21c08c2941@willemb.c.googlers.com.notmuch>
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
	<20240730184120.4089835-3-zijianzhang@bytedance.com>
	<66aab8b37157d_21c08c2941@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 18:20:35 -0400 Willem de Bruijn wrote:
> Btw patchwork shows red for patch 1/3 due to a new error or warning.
> Not sure if it's a false positive, but take a look.

Patchwork is not for contributors, I keep repeating this :|
Were you not in the room at netdev when I was talking about NIPA
or am I this shit at communicating?

Next person pointing someone to patchwork will get a task to fix
something in NIPA.

