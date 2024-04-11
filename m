Return-Path: <linux-kselftest+bounces-7717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F778A1DDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D6A1F267EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06469949;
	Thu, 11 Apr 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7+fhPxI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22459160;
	Thu, 11 Apr 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856629; cv=none; b=oybJ6zz8UbhZPVuWwsOxRQEKcxBq6VN4pgFF8j2zQ74vsPnkqzWV0ZjkxhP1XwTvBO8jHRT9jTn9Fo5hNk94SOTHxzep6Fu0+E7514fDbstBr318QhLPx9JHun/4ZYuvdaAgXSVxYr2VwJcNNrEu2YY4PbxP8yvJmMo4De6SsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856629; c=relaxed/simple;
	bh=vUH25OsPFa4RcBBeVz7wpTctxBONPQTL7NjwQVVnSok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZRoYESYMBD681EWJoZKGxPCWk1w0QUshttAxbUtf8jivBm9MJx+blKSr4WVb+NcXak53T58cgAVIT483+2tvVbbKrerBOKBtIAbXVH/q0qxbVkdVhasiN65Vc9/8tZe1UHeQJwZqcLTm/qoEPXTk1NwErOnazQDbPzo5aRS42wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7+fhPxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3610AC113CD;
	Thu, 11 Apr 2024 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712856629;
	bh=vUH25OsPFa4RcBBeVz7wpTctxBONPQTL7NjwQVVnSok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S7+fhPxIcy/4bgIhutbfJAdv2uH+nG0YuAJ4cbhJE+9zmSQBN4S7CXL96Ey1cqxU9
	 6GABvx0BvzB4nO3yy/T/b6D8rQvqDgD/PfLGbQl3gpTMsK7RCENnDeZ7CFfZKucceJ
	 4iLIUnOi/J2C5kLoCAuPKCX4U77qcwWLtp91zP37ox/B4q+adLzcLdniNGuhWisXR3
	 DELm+S40U+5OdUTDChm6JLs35XzGJAjjDPdnZql7CMRYIeyRCTVL5mgmPMFmM2AL5j
	 IH3X1ISXrEtjqYkrmB+/5HWqXbtuBEV1hksqZYTyulP/4Ov58B/LJBqFTbSRT/RmyD
	 0y2K2aHcjPAug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20662C433F2;
	Thu, 11 Apr 2024 17:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] mptcp: add last time fields in mptcp_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171285662912.10890.774534823632472407.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 17:30:29 +0000
References: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
In-Reply-To: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tanggeliang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 11:48:23 +0200 you wrote:
> These patches from Geliang add support for the "last time" field in
> MPTCP Info, and verify that the counters look valid.
> 
> Patch 1 adds these counters: last_data_sent, last_data_recv and
> last_ack_recv. They are available in the MPTCP Info, so exposed via
> getsockopt(MPTCP_INFO) and the Netlink Diag interface.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] mptcp: add last time fields in mptcp_info
    https://git.kernel.org/netdev/net-next/c/18d82cde7432
  - [net-next,v2,2/2] selftests: mptcp: test last time mptcp_info
    https://git.kernel.org/netdev/net-next/c/22724c89892f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



