Return-Path: <linux-kselftest+bounces-16321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35C95F6E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFB31C21254
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F0197558;
	Mon, 26 Aug 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja+vYV3W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC5191F78;
	Mon, 26 Aug 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690430; cv=none; b=GMA61q6T3x5Dt+cCY5vb+k8jyt0NMEAJmIgI0FzDxLrEvzRP4B4rr5RPwBzCe9reAYMT7a/GiTWTZXnLymRRGKxXb8cscTBMJqyAGooVAv3q0Wy3TeQET4CSgl59f76DbwPboNAQDHdiztzV7jxWFtd4yHz+UQrZjeFStMfGaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690430; c=relaxed/simple;
	bh=xoa5ywEc9w1JYj0npRfXyoOWYRdAqKl7kJePs+MAwfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ufVpRLRHqQpM4V8B4MG3ORC1TGubmfQikUJPjJ8fUpxVaNxeE4HpkwOQAnC3TDIxpVZHONPzSHj9BQTiIgY0zFH3o3Z6qAMpNkTzdk6I3aYhDZhttw5Bm8eNQ2/QnY6uW6LSWz9GJ3QvmWWaBdZbnD0MN4LvgtYpjKcgn7TSl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja+vYV3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E335AC52FD1;
	Mon, 26 Aug 2024 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724690430;
	bh=xoa5ywEc9w1JYj0npRfXyoOWYRdAqKl7kJePs+MAwfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ja+vYV3W6P6EKTNHzj+YUxI0jAYr0wNyplSdVDkAQip3DIRbUduxe+3OyiktQc/Y3
	 BbPQZcRk8CEabbooDhFXbctQhOPPsqkN8kGT0hGjj1oCE5c/7PTfBRWtwa2blQpA1K
	 mkjOuK7KsdQoPQDgNQ2caQ21ltBpOtrJqqlfV1W7WhLz0QIQmaM1pkOujSC7Dar3Hk
	 G0UiZvYQT5mzmqJy8eSrmGWDMG1UDIL6NyruE3A7crRpwhHH9UK1sEcnZZ4wskJzL/
	 mS5rlSkqX7TXg/oXdNds6lC/4a948jbFQ5anRCS0t+SAskIKEzvX5yA1bLHPH6AYSN
	 td5WGF89eTARg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E733822D6D;
	Mon, 26 Aug 2024 16:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] net: netconsole: selftests: Create a new
 netconsole selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469043002.64426.14117097195096331772.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:40:30 +0000
References: <20240822095652.3806208-1-leitao@debian.org>
In-Reply-To: <20240822095652.3806208-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 liuhangbin@gmail.com, petrm@nvidia.com, matttbe@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, dw@davidwei.uk, willemb@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 02:56:39 -0700 you wrote:
> Adds a selftest that creates two virtual interfaces, assigns one to a
> new namespace, and assigns IP addresses to both.
> 
> It listens on the destination interface using socat and configures a
> dynamic target on netconsole, pointing to the destination IP address.
> 
> The test then checks if the message was received properly on the
> destination interface.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] net: netconsole: selftests: Create a new netconsole selftest
    https://git.kernel.org/netdev/net-next/c/b494b1673889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



