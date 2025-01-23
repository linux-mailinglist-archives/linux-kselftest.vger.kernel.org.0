Return-Path: <linux-kselftest+bounces-25016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D952A1A6E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 16:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3AE18842EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A9212B38;
	Thu, 23 Jan 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne6mf2Gh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9C20B22;
	Thu, 23 Jan 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645615; cv=none; b=Lr7CkyV+Mf9Z9aJ/6h6TDT/0jNzZPjDwuRppTf2yVbC/boVtX0hfLUVzQJtfG1jvXcQUWc77hqNVYcZMOz+JduqU3W+G1UIoB1oOhHQtd1s60vOMoD7AmCRaVz2x7OZdAXlOFsPM8hGiSSZnJlMqgvOx10D0Tg3/uWOAzSibjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645615; c=relaxed/simple;
	bh=peKvQYZGBDCTOOloNNhAqiFa5iG1YZQuMJ1cmFfjDd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nACf9IMgg9Z1QEnDPhIE754njPj9Zfk0ery8U1IpenYnlQkXOiKcjn0w5m1IzHLyllcGOaM5QuGDS8kBXHM91+FjxCvfU8NCWTlijYl9Xl87TBPu13HZIM3A5vV9p5qZr+chaKbNtta4aRdi6HSVhlMszOWKYgAMYzworRbLMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne6mf2Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945F6C4CED3;
	Thu, 23 Jan 2025 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737645613;
	bh=peKvQYZGBDCTOOloNNhAqiFa5iG1YZQuMJ1cmFfjDd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ne6mf2GhEUUttWtaNrh340MSjNOtzvKLR2jhjsjRzO3VTiafO/uD0C/l8XDk59Hl3
	 juDx+FCq7fH4aygjKaQ1chW7tuuCN1vjHjkODChQTiHphBs1E8vZzz6U9Oe1toBpJ1
	 e5gxc/RVJmGpMt347hAhBkKtbZwG/E0KWjS9X8wn/aZ1Y9f2tRxEcnmBdf1Q81+DyR
	 NGzAGVks3FN7hvcbLSDkRPYF/q+z0ASf5okjjLyWTdQ7n1cJ0KdUzg9fK37qA32z3k
	 RH4qrnrpaUxeWnecEWgtPu/Iocv4cMEzJe7bTv6dGWUmZV0WSGalSfFqK74vu4uJLj
	 R0LVY4QSc9MCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71F2F380AA79;
	Thu, 23 Jan 2025 15:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: more xfail changes (and
 a correction)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173764563825.1390395.3224237670604094425.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 15:20:38 +0000
References: <20250121143423.215261-1-kuba@kernel.org>
In-Reply-To: <20250121143423.215261-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, matttbe@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jan 2025 06:34:23 -0800 you wrote:
> Recent change to add more cases to XFAIL has a broken regex,
> the matching needs a real regex not a glob pattern.
> 
> While at it add the cases Willem pointed out during review.
> 
> Fixes: 3030e3d57ba8 ("selftests/net: packetdrill: make tcp buf limited timing tests benign")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: more xfail changes (and a correction)
    https://git.kernel.org/netdev/net/c/965adae5a33a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



