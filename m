Return-Path: <linux-kselftest+bounces-42784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E063FBBEF79
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 20:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D61A4F19B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3A32DBF4B;
	Mon,  6 Oct 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUA8JczQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A42D94A6;
	Mon,  6 Oct 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775422; cv=none; b=Cf00D15aE+qNKwUQMuwjG8n4b/pRcY+TZaqrEb0ddfAvsZYcFecj4ifNXlU0idIiBLWN2YKOZ+DR+2yrnsrt2lcAqsHBEafVm5R5ki88esCGcEHLzk8nemI76I3KXL9vrPFGsU6T/WUldzXDQ6TsevaX92zqxnRHfCAKf9JR82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775422; c=relaxed/simple;
	bh=j2eRhgxCJOAHpbTNmGKai0ZDsCWyKYvg4XBaQCemYxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vDLHl6Cjv0vVaadXymhLWusS0G5zaMKxAjdF6XBnKhHuZR6/naQTQlzkpW8RpbAoXix/d6QipiTdFykUIdH0b9OWabZHoyUZWU+nqjsbyqQm/8pbTJ4AkDwnFjf4Nd0wGcOpFPwPGJ/9DDzb+mJ0OVGLYZwLahvPID7GhYmZ+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUA8JczQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F4DC4CEF7;
	Mon,  6 Oct 2025 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775422;
	bh=j2eRhgxCJOAHpbTNmGKai0ZDsCWyKYvg4XBaQCemYxE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cUA8JczQSUXMOgK9ESLnNt2nGL2h1Iw/ZQInC5dEYxMlufW2A+Kot1K1kcngE6xeZ
	 2FD5tLDHv5cwuvWon/MDdmk+gQymEEOW2Q47kOruhzgRbVOvenB8OQLNOT2LSJGcL+
	 xem2yXy0zLqv31zFqCHV7Ew/GASLySyQrnTZfp0ZHWIINceUMvmwI3kzgwdT/59WOY
	 B7GghDOT5J3SBV3GPoU6W04LJtZzSN2xPgPd38yaDRgCoAHoQSmaJDO4fl5G08uhpF
	 BRPT8vt/UQTXDKZVFMCQEUtqs7vDuPqihRTK8WG+Vv1kyidNHcDrd3FNpATjcR4ZPC
	 r98yBzr5/TAsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7839D0C1A;
	Mon,  6 Oct 2025 18:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] selftest:net:ovpn: Fix uninit return values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175977541174.1511446.5862875842120045644.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:30:11 +0000
References: <20251001123107.96244-2-sidharthseela@gmail.com>
In-Reply-To: <20251001123107.96244-2-sidharthseela@gmail.com>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, david.hunter.linux@gmail.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Oct 2025 18:01:08 +0530 you wrote:
> Fix functions that return undefined values. These issues were caught by
> running clang using LLVM=1 option.
> 
> Clang warnings are as follows:
> ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>  1587 |         if (!sock) {
>       |             ^~~~~
> ovpn-cli.c:1635:9: note: uninitialized use occurs here
>  1635 |         return ret;
>       |                ^~~
> ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
>  1587 |         if (!sock) {
>       |         ^~~~~~~~~~~~
>  1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1589 |                 goto err_free;
>       |                 ~~~~~~~~~~~~~~
>  1590 |         }
>       |         ~
> ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
>  1584 |         int mcid, ret;
>       |                      ^
>       |                       = 0
> ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>  2107 |         case CMD_INVALID:
>       |              ^~~~~~~~~~~
> ovpn-cli.c:2111:9: note: uninitialized use occurs here
>  2111 |         return ret;
>       |                ^~~
> ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
>  1939 |         int n, ret;
>       |                   ^
>       |
> 
> [...]

Here is the summary with links:
  - [net,v6] selftest:net:ovpn: Fix uninit return values
    https://git.kernel.org/netdev/net/c/7fc25c5a5ae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



