Return-Path: <linux-kselftest+bounces-40711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C0B42CB1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 00:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B23B06FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F912DD5E2;
	Wed,  3 Sep 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrcT5Sga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9807155333;
	Wed,  3 Sep 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938011; cv=none; b=fmsm0jJmws+oo9W0qFEpEtvOwWlsM0K0Vggo7+tYEp/XB2vtKiji5PL6988Q7f0usx+eX50avZ6793xHM+s4DE0Bfqvi5sjYtAZ3NRsAz9SrIByjLTVhoBQyaIE734AF9TwLeF6Z5Y5yf1sMzRd0SNSpTDacKZn/0KCB3a5/Ubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938011; c=relaxed/simple;
	bh=kEQv67VDFw8VqkSZh6w4o5ygDSRenhNdCMzd2IORFro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PpEsk5hAbEpEwLPVV67lXELOcrKGD5VzWgps8Mgvhp9kPRjc6vzHjXqEm6ezksokqA8HrRTyAgh4yNr868k3glVLsB36pWb0qy+M3KKqgy6ei7kZHYzRRjo3UnZ/fhd8XEjiX4GnrXIsKhn4hJJa3GhggoMWTsXTk1OSVFSP7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrcT5Sga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685E9C4CEE7;
	Wed,  3 Sep 2025 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756938011;
	bh=kEQv67VDFw8VqkSZh6w4o5ygDSRenhNdCMzd2IORFro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BrcT5SgaqTJiIXUkMeXSAGAbBMJKM9nLu+dPZJAlg5+BiNDOiM1Yk3VD9/gNQtIGh
	 mm99RtV+V6oJkP0a8eaFqibCU7JTflrxTiVYWZkWSSweqJQKra7FRdpTRGTXkmF/Ho
	 SXGFpvaFCzoVNM0OulbJ67VhImSUP/Zs1UHKP6kQloMUZeyirdfmjwi7JG3Ww8ynry
	 Un6J98/4h6aXaxLK+/ict7h5M1LXulkJwdyI4HOaP8YDYfyvTQDIiTi4wA86cargJn
	 C9j6xk58tu1Lm4lhDRM32WAKTWNnF7O6ub8dtAWQ8ar2c1mcMqlBTw9HuSw2O8P+uA
	 eXVgopCLvtUnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED8383C259;
	Wed,  3 Sep 2025 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] mptcp: misc. features for v6.18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175693801650.1219827.13681989499903923218.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 22:20:16 +0000
References: 
 <20250902-net-next-mptcp-misc-feat-6-18-v2-0-fa02bb3188b1@kernel.org>
In-Reply-To: 
 <20250902-net-next-mptcp-misc-feat-6-18-v2-0-fa02bb3188b1@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ebiggers@kernel.org, yangang@kylinos.cn, cpaasch@openai.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 02 Sep 2025 23:11:32 +0200 you wrote:
> This series contains 4 independent new features:
> 
> - Patch 1: use HMAC-SHA256 library instead of open-coded HMAC.
> 
> - Patch 2: selftests: check for unexpected fallback counter increments.
> 
> - Patches 3-4: record subflows in RPS table, for aRFS support.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] mptcp: use HMAC-SHA256 library instead of open-coded HMAC
    https://git.kernel.org/netdev/net-next/c/2d5be5629ce7
  - [net-next,v2,2/4] selftests: mptcp: add checks for fallback counters
    https://git.kernel.org/netdev/net-next/c/3fff72f827ad
  - [net-next,v2,3/4] net: Add rfs_needed() helper
    https://git.kernel.org/netdev/net-next/c/929324913e0c
  - [net-next,v2,4/4] mptcp: record subflows in RPS table
    https://git.kernel.org/netdev/net-next/c/3bd4f98a4e2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



