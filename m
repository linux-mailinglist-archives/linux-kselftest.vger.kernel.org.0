Return-Path: <linux-kselftest+bounces-20866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48E29B3E3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C99B282EB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023901FCF64;
	Mon, 28 Oct 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYMfU64f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818A1F4FA9;
	Mon, 28 Oct 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156430; cv=none; b=Ggg52Xt9PZYoilHIBZcjL7NIpt6Mm7bMvA7yi156xgxmMDgnOieQOlvhGMzCnebbvvUw+SRtNohsHwV+fkrnqgU1+ycncT+QEJL64566X0A7JWEaYQnTMtNVNMRcCSh71AgX2ToJZ/FroeLlJrJdMOZnYhdB1tyc7bJp+0bk6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156430; c=relaxed/simple;
	bh=4FuLg2Jpwj8U4DBkCMw8hGMjgxe5BuFscBWvWAMppWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uHNmcAQWK+E8ORk/y3BNJEXvvUu1jXVhKivf0J3DZEm5nsftkLyMwZFr5kwsn81S4gr0/Pqr2BbOm8QrH9uE6LBh+lKSH+eBwgyGWrbiCq+sWKGR1cJUM+BgZWwgl8PwwrurN63R/VbiMHgqQ5UbqFp4dWNn5Qw3OSkriGsVFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYMfU64f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C699C4CEC3;
	Mon, 28 Oct 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730156430;
	bh=4FuLg2Jpwj8U4DBkCMw8hGMjgxe5BuFscBWvWAMppWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gYMfU64fiuV21ZzjMXnBkmyaEBPWftBbYwQmuKA1sNQiRGR+K40UIHE3gJs+0rgQV
	 RIFo2eEHLAsErU8NA9fkNVAe+5lJKGYLBWZFD2Gnqd4scpX1YI86IQb3BSSuz8A22m
	 A67c9kqRX3TvdXgRD8TjN412R5aliiKa5htqoDpvQcedp4XHTBaaMtvffA/0FJstcI
	 B8lz57BXFQnVLe/kmLV4S/hGxxqrvYOBvnNNdlUk0borsQ94lSP3fnv4r9aWkyM7jT
	 C9+xID+463J1d8lngn070hZmEQdiZn83k52CtQHnLT5aW+OPdG5l2noCSRJHBu1xyI
	 G3DYnvcb6Cllw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE09380AC1C;
	Mon, 28 Oct 2024 23:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftest/tcp-ao: Add filter tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015643749.206744.8881222582999787972.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:00:37 +0000
References: <20241021174652.6949-1-leocstone@gmail.com>
In-Reply-To: <20241021174652.6949-1-leocstone@gmail.com>
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com, horms@kernel.org,
 rdunlap@infradead.org, mnassiri@ciena.com, jiapeng.chong@linux.alibaba.com,
 colin.i.king@gmail.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 10:46:44 -0700 you wrote:
> Add tests that check if getsockopt(TCP_AO_GET_KEYS) returns the right
> keys when using different filters.
> 
> Sample output:
> 
> > # ok 114 filter keys: by sndid, rcvid, address
> > # ok 115 filter keys: by is_current
> > # ok 116 filter keys: by is_rnext
> > # ok 117 filter keys: by sndid, rcvid
> > # ok 118 filter keys: correct nkeys when in.nkeys < matches
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftest/tcp-ao: Add filter tests
    https://git.kernel.org/netdev/net-next/c/47e99f30730c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



