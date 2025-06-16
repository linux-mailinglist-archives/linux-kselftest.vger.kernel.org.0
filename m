Return-Path: <linux-kselftest+bounces-35148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF8ADBCD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 00:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2733B2B00
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125F31A262D;
	Mon, 16 Jun 2025 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAwbPPpS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C68F4A;
	Mon, 16 Jun 2025 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113023; cv=none; b=iip8T7bQZc7EFQRPCperbhofQpd62Qim4WOMeTGOuSJ1l/XsxKK64yISbnMVAEkrump2LbuH3JjDfD4yKccH+bujWytiQ2Y9UFun9VhxwmxM7eMTYLQCNQeXUv2pX+h5NxSCQRkcqGVoaXcxTBDKEctK/Lcv9M0XrXebEMq1TMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113023; c=relaxed/simple;
	bh=f1sSNyfpzFUk6skmWjbRzTOcr9W+CfHR1mATzudvQUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N1nTd3iMdCXDyQwaHzSg7qovCJYDtQI2Ob0YF4C5+U9skY+H8LrkPk/KWB2Vto+mJbv6nANUQBYIbBIAuyM+wJfC2ZI6LIAXx0heejFfB3qhMe0BxPdwFiRMHEQ24LTOQxgXztoX0bSnN2rvBvAAB40GWbyotmqwqOdB2GKCi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAwbPPpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666F0C4CEEA;
	Mon, 16 Jun 2025 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750113022;
	bh=f1sSNyfpzFUk6skmWjbRzTOcr9W+CfHR1mATzudvQUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAwbPPpSPOGN8SWFVs9ZKEXgHQ91VFJgwoONVYOVlAZ3PgOps50XQh/qnp6pBOPwQ
	 WL7EzHWu5US/vDIiVSsPb1jJfHTtxqOy2wGAgnCPjdajj8/iDwAa/R7hY0lMBvt0x3
	 a+FzOGmzrnLgytoEeZzZ0+XIn+LUPFn9qHvv8gn7na4LnAZC3sXa6tgRYcKfOUSMwt
	 Lcz0EoaOrvIuuW2FjpR5XPM+IyC5MwTOpQCeLY+sNJoe5Eb02HyIISJPn+N+EzpsU1
	 wL8QRRTHvCJTChZhLobtcJ8oCCQlVTZYlUtVJM8dw967SJ7xNJsxJGFMMkmEPmXCdj
	 xM4FLyxi028pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DDF38111D8;
	Mon, 16 Jun 2025 22:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] netpoll: Untangle netconsole and netpoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011305125.2535792.17187511380555589893.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:30:51 +0000
References: <20250613-rework-v3-0-0752bf2e6912@debian.org>
In-Reply-To: <20250613-rework-v3-0-0752bf2e6912@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, gustavold@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 04:31:29 -0700 you wrote:
> Initially netpoll and netconsole were created together, and some
> functions are in the wrong file. Seperate netconsole-only functions
> in netconsole, avoiding exports.
> 
> 1. Expose netpoll logging macros in the public header to enable consistent
>    log formatting across netpoll consumers.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] netpoll: remove __netpoll_cleanup from exported API
    https://git.kernel.org/netdev/net-next/c/260948993a9f
  - [net-next,v3,2/8] netpoll: expose netpoll logging macros in public header
    https://git.kernel.org/netdev/net-next/c/afb023329c07
  - [net-next,v3,3/8] netpoll: relocate netconsole-specific functions to netconsole module
    https://git.kernel.org/netdev/net-next/c/5a34c9a85365
  - [net-next,v3,4/8] netpoll: move netpoll_print_options to netconsole
    https://git.kernel.org/netdev/net-next/c/ccc7edf0ada8
  - [net-next,v3,5/8] netconsole: rename functions to better reflect their purpose
    https://git.kernel.org/netdev/net-next/c/abebef96aab1
  - [net-next,v3,6/8] netconsole: improve code style in parser function
    https://git.kernel.org/netdev/net-next/c/d79206451f4f
  - [net-next,v3,7/8] selftests: net: Refactor cleanup logic in lib_netcons.sh
    https://git.kernel.org/netdev/net-next/c/bed365ca56ca
  - [net-next,v3,8/8] selftests: net: add netconsole test for cmdline configuration
    https://git.kernel.org/netdev/net-next/c/69d094ef69b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



