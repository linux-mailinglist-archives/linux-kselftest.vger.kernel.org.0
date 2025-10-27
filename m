Return-Path: <linux-kselftest+bounces-44153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2AC12092
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38156188A984
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C532E15F;
	Mon, 27 Oct 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbDyd9J1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF1E303A0D;
	Mon, 27 Oct 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607829; cv=none; b=ck+m3MqRQ80h7HgyYtRI0/RKcHbdgM0OWg1q2asV+Wt1mC2kqiVXPxBvhaYC1ubrIDcmmQpnQPa4EE87yY29iswHKYkYCwC0jMNcsIaIVO/b9B7sdLmuSKhccNcSH+x6PSYhkxZ7paX6pHqhZ1238HVbw7RysYA8ODGafFKBCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607829; c=relaxed/simple;
	bh=onOqGzfuh2lN+fnyKlYcERLypwTp8HMrJkvl5wLcOEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zzy20sszLoysMoyp7dJUIUKqXauaq8gnGErd+YhgX5YE4gX84SbNbTB3+/4TzUrhBrnFkrrif52A9LrdrrvApMSMbgtYlWd5QlKViDldkvi6pw1BWtmyyN0HYLV2hYytHqRddcsQnPJGfRxmCcr3er7HRRumctk17qX0h1RUED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbDyd9J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5217C4CEF1;
	Mon, 27 Oct 2025 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761607829;
	bh=onOqGzfuh2lN+fnyKlYcERLypwTp8HMrJkvl5wLcOEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PbDyd9J1N/B4cFfl4t13Q3z7D9cqhAkdHWZH9apMj9EwLSXcv3iq0zC73hnhugnzq
	 Fkera6yUyikTgZe3aWdk6Q6hgCt67nPgnDNdUrtz2/DA9ujriXPtn1shMlTybx9oOc
	 LjssoLgCodIsFaWkljqrPHLoXjVlfZ5iPheyGbsRtgFi7TaSK9YfMw0OWKsavsqqre
	 JWVP6NeQSeo3UvnouC/Ga4hQna/noW0q8l2/DuCj1k5saVFYtXziu+wqVoOjeiQ+0B
	 F1COAHN2QcA+cy35zCJDOkE891ePTWgaH1UAs4GsWedej6JqhhcvkXNlNjHxs9fm0v
	 KetjJOEeRh5MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF639D0C95;
	Mon, 27 Oct 2025 23:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176160780701.1620997.1697978966670845263.git-patchwork-notify@kernel.org>
Date: Mon, 27 Oct 2025 23:30:07 +0000
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
In-Reply-To: <20251022001937.20155-1-wilfred.opensource@gmail.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 corbet@lwn.net, horms@kernel.org, john.fastabend@gmail.com,
 sd@queasysnail.net, shuah@kernel.org, wilfred.mallawa@wdc.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 10:19:36 +1000 you wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
> maximum record size. Meaning that, the outgoing records from the kernel
> can exceed a lower size negotiated during the handshake. In such a case,
> the TLS endpoint must send a fatal "record_overflow" alert [1], and
> thus the record is discarded.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/2] net/tls: support setting the maximum payload size
    https://git.kernel.org/netdev/net-next/c/82cb5be6ad64
  - [net-next,v8,2/2] selftests: tls: add tls record_size_limit test
    https://git.kernel.org/netdev/net-next/c/5f30bc470672

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



