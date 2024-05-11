Return-Path: <linux-kselftest+bounces-10085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090558C2E69
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AEB28286E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF351078B;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7K7BMfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81822D52E;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391029; cv=none; b=brOI6Nn0YUnuKxgJDEfKxkhPnTt1NK8X14re5zVvmfjj214nnX5SMjbwCN9ejeO2zdE9AS7lcvUJhEtvwWeHyxNvDv18oK8Y+Ul3D1wzDzeiHd5hCZygPDEK4ehRKJpvOcxAiNcExwVDXUNRVAJTXlXqEeTinv5clayAmbFVfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391029; c=relaxed/simple;
	bh=r3YoMGLydWabdfCH6EQ/m5yh7+eA1nYB1R4Wg5iXQj8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jujJFQV2jZXhKVEsWfYyC4qwnq6uv+UOMgRkGpsdK606pgLoFBICm6kcUCfJBN0NnPDm7wriknwSGj+1kNhKdJtWmwb5xG5Q+dWpRdTD0FUtKcRbW0ZF4WIGI3u+C0z09TKNIOxNhfZDtqxIEhXBfBlJCEjnx5blyxWmQnVnIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7K7BMfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 205C8C32783;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391029;
	bh=r3YoMGLydWabdfCH6EQ/m5yh7+eA1nYB1R4Wg5iXQj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H7K7BMfZRLHwSjd91qqqkeglr+efJLluI5sQtA5vnfiVQr7TSrcnoSaCD2m17+ETZ
	 u9ySWmR6kQRHTu4lc+cCX9pZOQcZRlceITfWWOqLOOXsHVAU9RZdobYZD8M7y9nfzH
	 ZpyegVesCCMkp/3Fh7OVC2KOVihiALWuZr6tbL5lm3U7o3SC3akjpqdF/ZIbrV9kh5
	 Vn0pOoGKYrHxrh7yy99O/0vWY6s2O6Pc9+VutJEj+eOs3hHATj0mVGnCRCkiIH1HgO
	 5YoyskY/Z3aK4wLMQni4OxzqIH5yFhXfIcchY5zCbOjSxYpBy20UjS01ErVBGsaJIk
	 7Si3lwhfU6FMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F6FEC54BA2;
	Sat, 11 May 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: move amt to socat for better
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539102905.31003.2608332552992662744.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 01:30:29 +0000
References: <20240509161952.3940476-1-kuba@kernel.org>
In-Reply-To: <20240509161952.3940476-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 09:19:52 -0700 you wrote:
> The test seems to expect that nc will exit after the first
> received message. This is not the case with Ncat 7.94.
> There are multiple versions of nc out there, switch
> to socat for better compatibility.
> 
> Tell socat to exit after 128 bytes and pad the message.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: move amt to socat for better compatibility
    https://git.kernel.org/netdev/net/c/4c639b6a7b9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



