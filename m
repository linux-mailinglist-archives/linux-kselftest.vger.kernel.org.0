Return-Path: <linux-kselftest+bounces-23524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE2B9F6CEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 19:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4A07A06C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0E1FA8C0;
	Wed, 18 Dec 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcEdgsBg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6343597C;
	Wed, 18 Dec 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545415; cv=none; b=n4u6/0FwGWyGRXOygy9/mTVLOqAqu0337KE1qyQFm/AU5uFNcJ6xN+xBtYEtZ/c7GHkGPsKAxJ4OdDUEZzwAndc7/0UCNRqO9goAMf+w7eFv3AoINLik2IuJyZ0Id1DsZHnkXqHBg6Q4wNCPo553H6WypsoFBV/1+rQrEAxPbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545415; c=relaxed/simple;
	bh=EhJjd+bikCf0qPNbSX/6JAH0WfTX+I4qhzrb9BZk4H0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hVHsWKE5nC/EhV7AfCilMnjWUdgMGDjbzg3DQERYOMjy7AzkRQkcF5ipvDDFio6Z9wrWHWusD8jiDJh03brIgHmE3uxpc36bd7pY19uGmNfnBTcCfLR3SE937vI107VLXTh7s/P0UVXVu4q0EAa8EUSg16wlcrp+n8Tb6RJsIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcEdgsBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB6EC4CECD;
	Wed, 18 Dec 2024 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734545414;
	bh=EhJjd+bikCf0qPNbSX/6JAH0WfTX+I4qhzrb9BZk4H0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcEdgsBg+7n1FhVyV0+OFXoHCHmlftdgmLdQh2PzNiIIUD0Tpy9uk9XlwOkJqXiul
	 9QH7TnpZ/m2YxHRyCx9vQPjVr6Y4iwiiFWymcjJetnFTcSB+Jrh4Egm0NFACvS4atl
	 pjgfjkkrumHrFq45QUO4tbi84QD4m9s2heW4Q46tZlP8dtJThLX9tWamiZAhTKE2dF
	 EZs8tARwFkIWVQ1OTOG1AH8yshhP0KPYsAnCB0dXPfXu5SE5bSgUd8tphhBabeF4bZ
	 Q7lCtBOealavAPAHbXRGdrd3PW4Wd2FTSQSrpvJWA0LBqPRbYAvYLBXu+dZP9WPBZI
	 u6Kpka9aJLkrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF883805DB1;
	Wed, 18 Dec 2024 18:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173454543151.1691835.8973634359314883058.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 18:10:31 +0000
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
In-Reply-To: <20241217185203.297935-1-sohamch.kernel@gmail.com>
To: Soham Chakradeo <sohamch.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 sohamch@google.com, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 18:51:57 +0000 you wrote:
> From: Soham Chakradeo <sohamch@google.com>
> 
> Import tests for the following features (folder names in brackets):
> ECN (ecn) : RFC 3168
> Close (close) : RFC 9293
> TCP_INFO (tcp_info) : RFC 9293
> Fast recovery (fast_recovery) : RFC 5681
> Timestamping (timestamping) : RFC 1323
> Nagle (nagle) : RFC 896
> Selective Acknowledgments (sack) : RFC 2018
> Recent Timestamp (ts_recent) : RFC 1323
> Send file (sendfile)
> Syscall bad arg (syscall_bad_arg)
> Validate (validate)
> Blocking (blocking)
> Splice (splice)
> End of record (eor)
> Limited transmit (limited_transmit)
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests/net: packetdrill: import tcp/ecn, tcp/close, tcp/sack, tcp/tcp_info
    (no matching commit)
  - [net-next,2/4] selftests/net: packetdrill: import tcp/fast_recovery, tcp/nagle, tcp/timestamping
    https://git.kernel.org/netdev/net-next/c/eab35989cc37
  - [net-next,3/4] selftests/net: packetdrill: import tcp/eor, tcp/splice, tcp/ts_recent, tcp/blocking
    https://git.kernel.org/netdev/net-next/c/6f6692053939
  - [net-next,4/4] selftests/net: packetdrill: import tcp/user_timeout, tcp/validate, tcp/sendfile, tcp/limited-transmit, tcp/syscall_bad_arg
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



