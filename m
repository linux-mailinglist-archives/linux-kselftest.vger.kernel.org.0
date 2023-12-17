Return-Path: <linux-kselftest+bounces-2107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2F81623F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 22:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430E2B2196A
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23211481D7;
	Sun, 17 Dec 2023 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwho3piZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D4347C9;
	Sun, 17 Dec 2023 21:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68143C433C9;
	Sun, 17 Dec 2023 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702846912;
	bh=QooiDWtDhrpz9KdYagYeUGjZiKuPYATavk/3k5xXyp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gwho3piZAAly6/OHoTjCp6MoVralueg4Dj0dCyHEs1XLaDov40fuWQ3LYSa8VdbXE
	 8VN8yK0s6mgkmHuJRvgH2gxERaNd4A06MPE8ub4ue3xLSfbjU80XwjtbkBII2cYQJ9
	 AMZg0Tsa143QEKrHtlqAs+cKEOtLaBbejUpmrXFySQTcI7n7KaHySBnaluB/9pfpoo
	 1/y/WIoEFxZqxzw/WpD1cYWbgEId4tvvz1M4gQ7Q5PK4+HaB4n6mpS4cfIRk6Nhxf9
	 KGy4oikN1Td3oKA43T6mbTdctVxWb1AaiJ5+PJn8YP6tMwLqCeBv28DGiiDTip9sL6
	 s6QpJrqz8EXcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E6C1C04DD9;
	Sun, 17 Dec 2023 21:01:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: misc. fixes for v6.7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170284691231.19159.11595245549872933441.git-patchwork-notify@kernel.org>
Date: Sun, 17 Dec 2023 21:01:52 +0000
References: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
In-Reply-To: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 benjamin.hesmans@tessares.net, dmytro@shytyi.net, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 geliang.tang@linux.dev, stable@vger.kernel.org,
 syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Dec 2023 17:04:23 +0100 you wrote:
> Here are a few fixes related to MPTCP:
> 
> Patch 1 avoids skipping some subtests of the MPTCP Join selftest by
> mistake when using older versions of GCC. This fixes a patch introduced
> in v6.4, backported up to v6.1.
> 
> Patch 2 fixes an inconsistent state when using MPTCP + FastOpen. A fix
> for v6.2.
> 
> [...]

Here is the summary with links:
  - [net,1/4] selftests: mptcp: join: fix subflow_send_ack lookup
    https://git.kernel.org/netdev/net/c/c8f021eec581
  - [net,2/4] mptcp: fix inconsistent state on fastopen race
    https://git.kernel.org/netdev/net/c/4fd19a307016
  - [net,3/4] mptcp: fill in missing MODULE_DESCRIPTION()
    https://git.kernel.org/netdev/net/c/a8f570b24797
  - [net,4/4] mailmap: add entries for Geliang Tang
    https://git.kernel.org/netdev/net/c/356c71c46169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



