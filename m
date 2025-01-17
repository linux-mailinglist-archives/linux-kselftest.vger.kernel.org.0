Return-Path: <linux-kselftest+bounces-24689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0BA14776
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5904D3A9C76
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 01:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24661F957;
	Fri, 17 Jan 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm4F+JJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861708C11;
	Fri, 17 Jan 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076809; cv=none; b=GTYMpDTNRsFx7ET96BPy5rkjbpqXvuyHrIclnjeqt5r2pl2Vlnhx26PIerV3yOgg/iKzI+3n9St7u5JlLo1QlaccEl+NtH5tTD5TJjbGl1cG2KR/BoqWGVL5PEVDHUDHY0JeFxe4GsKH/OLP6HoOYjx4IAclGxqp9TtnSOhREhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076809; c=relaxed/simple;
	bh=e4ighU5MPhKp+lvq304/SDVglvjn1a1ET/56chNe59Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VCFg7BXzC6fhYtDpR1SLFI8laHLwti54Uaqr38U4q+wnj67r7C1d5SNvLlxcJk7nA52d1qd5DoOc+Os2fP4043+iMgKQvxvK6/Z9bddiu2fNR9KCDj+qJh0YfoFlCHywumXhK4146WsrLmF33Mkt/iAVhNo5wfP0OcDu9r1fdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm4F+JJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A1C4CEDF;
	Fri, 17 Jan 2025 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737076809;
	bh=e4ighU5MPhKp+lvq304/SDVglvjn1a1ET/56chNe59Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nm4F+JJynooi8DaLI4GQjAUy5Akcp7+XoJ/iLLQMQl0UeqPxYqVrDm2rNc3B6GSzd
	 +ueb23n/+1HPi5i9dzca6gHj1GmX/uGjtyjfv+r7MB9zBb1Qy0hBCha7vmnIyH07ta
	 FvFoYnUTSCh8bYNKTxuih72qC2xr2oMzUbbsykD2e8gPcu6qjByihbfjPF3mCUPcJi
	 cihNepmWJ/+wE8c1JDptbYE71KkKVgnImbVAs9ISBk07zS+A7AwLdPQzi69JXjs4u0
	 Mbk079gxAWIOnC5ErQikr5hDKXa1w1qBEmfQ7I6+68JF+3S1mjnhsn0iKE0PqKd/Ul
	 h7BO7RUOpa17Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7174D380AA63;
	Fri, 17 Jan 2025 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/1] selftests: drv-net-hw: fix pp_alloc_fail test
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707683202.1645866.2260732014925213405.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 01:20:32 +0000
References: <20250115181312.3544-1-johndale@cisco.com>
In-Reply-To: <20250115181312.3544-1-johndale@cisco.com>
To: John Daley <johndale@cisco.com>
Cc: shuah@kernel.org, kuba@kernel.org, sdf@fomichev.me, willemb@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 10:13:11 -0800 you wrote:
> The tool pp_alloc_fail.py tested error recovery by injecting errors
> into page_pool_alloc_pages(). Perhaps due to the netmems conversion,
> page_pool_put_full_page() does not end up calling that function.
> 
> page_pool_alloc_netmems() seems to be the base function for all the
> the allocation functions in the API call, so put the error injection
> there instead.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] selftests: drv-net-hw: inject pp_alloc_fail errors in the right place
    https://git.kernel.org/netdev/net-next/c/8d20dcda404d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



