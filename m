Return-Path: <linux-kselftest+bounces-21844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4729C4D72
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 04:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F41B251E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 03:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94E209678;
	Tue, 12 Nov 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYwvfM3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276620966B;
	Tue, 12 Nov 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382827; cv=none; b=faAEBZBSw6xtHW3kCBigyyga+1almsBLB1rY9Wf2MEYFU1bh11KZzazPriIwRDboM24FJcUlr7/BrY4ZQ/5JtYmzCIC3HkPch3jDGzwVDF6AbBhpx9ZxDv9mqEqXHeIa4PwXJ/oD38GIKEH7qBICcQpLvr+L65iZ/ZTZiDgq+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382827; c=relaxed/simple;
	bh=XpeHYVPyarpkdspTn7f8dacnQW+jT1PkSYSFpXsauAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ms/5ebNGC9AZ0yY5E+7dEyl7mF/gyQMLS06e40qT7m/Q9nrSgkwNBDuT/Nt73f7yZDhq0XFITwHCOS8baZQoqhsZyKEFQNVIB2TDlxAY8jMI1MsObb6esP5/Oiz9ZepCzQYzRB+Nd6tGjMsju8hDIl+TTe8jYFGiC0jVluFF6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYwvfM3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D753AC4CED0;
	Tue, 12 Nov 2024 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731382826;
	bh=XpeHYVPyarpkdspTn7f8dacnQW+jT1PkSYSFpXsauAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XYwvfM3ZEFmQ10mEgICXMNx9/VIPcKqz3xDdU4bh0cLXt5soVQ05kNepA4mvOj87f
	 utgThYYIR7vsjGq9kfJK9dTBp59eEqHEqEO0SRGRzW2fkwsL2GhGtuFds9WNjyACCg
	 ctmVStPpspT0Ab8AumqGuj0pkODEf0iDryehIP1sqEkXGQC0n7I4WkuMgTWckuxMQ4
	 nxb176WRWwewfURtBGALl9cNCOL/I60+X7d5gkvs/VtrhR5Po1q88i4tCLv7KCaamW
	 TMb55XJcolRJb/qUQRKIWxXVicKBdcAvz5qlShfidEk3GN53Fz7ooNQWKcSqt3EZxd
	 7N3tzVvUcwKEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D273809A80;
	Tue, 12 Nov 2024 03:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138283699.71105.6903753755022416779.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 03:40:36 +0000
References: <20241108093427.317942-1-deliran@verdict.gg>
In-Reply-To: <20241108093427.317942-1-deliran@verdict.gg>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 idosch@idosch.org, edumazet@google.com, linux-kselftest@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 gnault@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Nov 2024 09:34:24 +0000 you wrote:
> Check number of paths by fib_info_num_path(),
> and update_or_create_fnhe() for every path.
> Problem is that pmtu is cached only for the oif
> that has received icmp message "need to frag",
> other oifs will still try to use "default" iface mtu.
> 
> An example topology showing the problem:
> 
> [...]

Here is the summary with links:
  - [net-next,v10] net: ipv4: Cache pmtu for all packet paths if multipath enabled
    https://git.kernel.org/netdev/net-next/c/7d3f3b4367f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



