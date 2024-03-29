Return-Path: <linux-kselftest+bounces-6821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB41891029
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 02:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DD5286F84
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE812E48;
	Fri, 29 Mar 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXIROsVg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125711C92;
	Fri, 29 Mar 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674711; cv=none; b=fK+CgcsqKuLD0ALUNI4rg5uI0Opws77lRqlwgp7j6JDEaUrWgXOb9dgrZNa52mKpjKC+EzqCn+YvObovgAH8uUqvVFUvJTergcycKsHHQFnL4wVdldDsPRYOZdCV1feu0FKQAylyvLEny8OJW7ZrVV9njAtnp/C5YakyC6wCKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674711; c=relaxed/simple;
	bh=SQ6TUd9cj+EdPwKpn8ySIV1bKiClRtYh4HYNF//HnjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RiZgQFWS2kx0UeXwQK0Nr17xZ8MFYP0bzCX/DdEBv85HHJlGRpSiChfCqhZfAd88/7CFr1X5vb6BYpB25MDM6ngat2ZknwhOuquI1vUHWiCR8+2TByjw8N390Yk8TEWNZR7tHnpGnUM9qD91UyqUedb57wtQuO67BFn7ELmFs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXIROsVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CAC5C433F1;
	Fri, 29 Mar 2024 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711674710;
	bh=SQ6TUd9cj+EdPwKpn8ySIV1bKiClRtYh4HYNF//HnjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AXIROsVgLK0Pfo9J0LJUbQdfTP4lb/+qbwqe8CMR+yfveHBey6c2DoenaIywWUYJP
	 If7cKuzZYsYO11dJxlYhUGl3M6R3dzJjINL7nd6ujjC4fDKsRAjexXR9JzGcrlqzJt
	 qUp3GvGGHnpLMjBCGc0JBYJYrG8NoJpkuJL/S8JknTjl1Z+2zYXlTzgew4soGOqwvY
	 2yQheAGRl8U7JYqi1CmN46yg1TeMJrNOBfI7qDOVSgZRYYRYatNM0Kl0ZJXeBH2btS
	 M0Fp4b2wkznf6c6J2vWg7xqp1y/WP5puLijJbeXW+L5Iv4eWNvL6C1BbcD7ISSPME6
	 mgSRqihGUvp7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 760E0D2D0E1;
	Fri, 29 Mar 2024 01:11:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] selftests: Fixes for kernel CI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167471047.20385.6346072073205983156.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:11:50 +0000
References: <cover.1711464583.git.petrm@nvidia.com>
In-Reply-To: <cover.1711464583.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, shuah@kernel.org,
 razor@blackwall.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
 bpoirier@nvidia.com, idosch@nvidia.com, jiri@nvidia.com,
 linux-kselftest@vger.kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 17:54:27 +0100 you wrote:
> As discussed on the bi-weekly call on Jan 30, and in mailing around
> kernel CI effort, some changes are desirable in the suite of forwarding
> selftests the better to work with the CI tooling. Namely:
> 
> - The forwarding selftests use a configuration file where names of
>   interfaces are defined and various variables can be overridden. There
>   is also forwarding.config.sample that users can use as a template to
>   refer to when creating the config file. What happens a fair bit is
>   that users either do not know about this at all, or simply forget, and
>   are confused by cryptic failures about interfaces that cannot be
>   created.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] selftests: net: libs: Change variable fallback syntax
    https://git.kernel.org/netdev/net-next/c/fa61e9aec97f
  - [net-next,02/14] selftests: forwarding.config.sample: Move overrides to lib.sh
    https://git.kernel.org/netdev/net-next/c/fd36fd26ae7c
  - [net-next,03/14] selftests: forwarding: README: Document customization
    https://git.kernel.org/netdev/net-next/c/0cb862871fe7
  - [net-next,04/14] selftests: forwarding: ipip_lib: Do not import lib.sh
    https://git.kernel.org/netdev/net-next/c/0faa565bc4a7
  - [net-next,05/14] selftests: forwarding: Move several selftests
    https://git.kernel.org/netdev/net-next/c/40d269c000bd
  - [net-next,06/14] selftests: forwarding: Ditch skip_on_veth()
    https://git.kernel.org/netdev/net-next/c/0c499a351777
  - [net-next,07/14] selftests: forwarding: Change inappropriate log_test_skip() calls
    https://git.kernel.org/netdev/net-next/c/677f394956e8
  - [net-next,08/14] selftests: lib: Define more kselftest exit codes
    https://git.kernel.org/netdev/net-next/c/51ccf267beb2
  - [net-next,09/14] selftests: forwarding: Have RET track kselftest framework constants
    https://git.kernel.org/netdev/net-next/c/596c8819cb78
  - [net-next,10/14] selftests: forwarding: Convert log_test() to recognize RET values
    https://git.kernel.org/netdev/net-next/c/a923af1ceee7
  - [net-next,11/14] selftests: forwarding: Support for performance sensitive tests
    https://git.kernel.org/netdev/net-next/c/e16a8d209c33
  - [net-next,12/14] selftests: forwarding: Mark performance-sensitive tests
    https://git.kernel.org/netdev/net-next/c/e10391092aca
  - [net-next,13/14] selftests: forwarding: router_mpath_nh_lib: Don't skip, xfail on veth
    https://git.kernel.org/netdev/net-next/c/6db870bbf788
  - [net-next,14/14] selftests: forwarding: Add a test for testing lib.sh functionality
    https://git.kernel.org/netdev/net-next/c/8ff2d7abfb6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



