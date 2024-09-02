Return-Path: <linux-kselftest+bounces-17000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22E968C80
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2056B1F230B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999D20FABE;
	Mon,  2 Sep 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h20cIcwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D720FA85;
	Mon,  2 Sep 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296173; cv=none; b=uuWsJQTPKtN/vUQg/AY862U0/SE1sPMG/jij43HSSoR89/HjU0YQdE6yqgAq1VWPd45+QXyazGLL8dQx5J8plYyeog1p87qxmquptfi5EwME94/ubgs8uLZmcnUlHwd//+71ZClzVLoUa26ISTmvId0BKjpqzkgUmxS/9b3/qK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296173; c=relaxed/simple;
	bh=pnKwBKwqgv3BGbuTy3GkYKsZu6a7s/iNDAIAEPiUP/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMNyPAgOdhgAQZiM/4ZeJitYVffz0ZEQIGdrj7m8fdqyRjKKlYmpM1sSqfINiKyBeFXf4zPhVs6I3owoUO2JKnijefdveBJSwm7OIoEE9awRzKVrmj+3tSApDSUG0rzJEe6KWsFQwLIjVYQLokjwyXW0JRGDO9Ry6doafNu+FWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h20cIcwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6B8C4CEC7;
	Mon,  2 Sep 2024 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725296173;
	bh=pnKwBKwqgv3BGbuTy3GkYKsZu6a7s/iNDAIAEPiUP/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h20cIcwH8uDk9uMUmjdDDQjvZ75xGshRR2A1QmCOjLwVV5ssG+PB8IIYKISindjuu
	 79yHbq6ZPtqqna76Weod6x3iby7q/TNs5y1ZU0JATlcq4vYC3OTz8pgk+UBueG4dcR
	 hmnk/OzGYYeSKndfj84eNsvVuu5ohPA5nP4IpLR9rjp+1WgtMBddnTxGsmoHvs9RUp
	 sY/DOxUIHmOoBYcLrINpPG3SVz0NN7FETvUpW37JRbYz8k07f1twMZfveJaQO5Y9Aa
	 ZnQaRUNbXNn22hzHs2cKHOkOTwQehmgPfFSgb+AxWticeA1OS8YrMVR9cPVvE64XsA
	 gehjuUvJyUV9A==
Date: Mon, 2 Sep 2024 09:56:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de
 Bruijn <willemb@google.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 martineau@kernel.org
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240902095611.3567ba1e@kernel.org>
In-Reply-To: <20240902094612.6d40a914@kernel.org>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
	<66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
	<20240828090120.71be0b20@kernel.org>
	<66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
	<20240828140035.4554142f@kernel.org>
	<66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
	<20240830103343.0dd20018@kernel.org>
	<66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
	<20240830144420.5974dc5b@kernel.org>
	<66d23f2349f7_3d8dba29489@willemb.c.googlers.com.notmuch>
	<66d4d97a4cac_3df182941a@willemb.c.googlers.com.notmuch>
	<20240902094612.6d40a914@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 09:46:12 -0700 Jakub Kicinski wrote:
> PRESERVE_TEST_DIRS

This was meant to be:

PRESERVE_TEST_DIRS := 1

Testing this more, looks like rsync -aR breaks networking tests, too.
The net/lib target, specifically, is no longer able to copy out 
the files outside of tools/testing/selftests (the YAML specs which
live in Documentation/).

So unless we can pass some magic flag to rsync to skip leading ../
we'll be stuck in supporting both behaviors forever. In which case
maybe TEST_PROGS_RECURSE is indeed better. I was hoping the
PRESERVE_TEST_DIRS flag can spread and once it reaches all targets
we can make delete the old behavior. If it can't happen its no better
than TEST_PROGS_RECURSE... sorry for the noise.

