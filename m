Return-Path: <linux-kselftest+bounces-39132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D187B28993
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 03:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725041B66760
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1273537F8;
	Sat, 16 Aug 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aaqw7NiF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65363FB31;
	Sat, 16 Aug 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307195; cv=none; b=Gk2o1MWzDn873x3E00qC0/zy82O2xquy2IIavLrtQ47TppNHULDrALF+EhxClwvN7jxgeowJZKB9StqGfm6QYAi7pmUBYCLAv7a9+gXuvB6vVkN9+3sT/O3nuJZmtOOQslXj0zfxZ8DgpndY6MqfUVCivStU8Wb5h5Aj+nlc3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307195; c=relaxed/simple;
	bh=C68hlH9NavAvLQH+ZxrttN8X/gMNYOniv0uEJ0pMLww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WvseywOZzgO5K6yUvSJrMlkz0Sswkw0BeUlaPkiVTLg4ZuCNjk98HjXjeVI/Q48Dnoik56rE2kICMiSfuK1sDpN/1aR+23HJae/uIT2NIgtSRhJkQQuK1ix+fxFdCEHXUOcLdHNnkg/5tm24NfgEB2VWBjh/0oElMSxDdAgR97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aaqw7NiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E93C4CEEB;
	Sat, 16 Aug 2025 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755307195;
	bh=C68hlH9NavAvLQH+ZxrttN8X/gMNYOniv0uEJ0pMLww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aaqw7NiFGfBj01tnjrLRufXoBjBhZaLiyM0TwFhnIpEhrCa6Hb26dYvjPYoKftjwa
	 zIcvCcN1w63pcijXACeksqVSOj81dXXHIEOuEj4IFQVcyncNWIe8JuFDGeh8Q4AC3H
	 ORv2SDNaA9zGOXK20kCj89+56s4zfju9+2hvNuSHzIHy7miJBGtMG0MMdbv0I2MzWl
	 jHRpegDvNc2Kd7BVW7EjS5m8tfqn6EAkc/Hciskj5htvcRAmJHQzUS8ZNaFvjPWyFk
	 JCFq5LbNkaqKydqPX4FEbZLMCRGz1D+pUb2fc+HHvP5ZC2nMd2OSUEbgff4HR7Y/7Q
	 Nc71iaqRs3H5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339FA39D0C3D;
	Sat, 16 Aug 2025 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: tls: make the new data_steal test less
 flaky
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175530720600.1331127.3047974725256303180.git-patchwork-notify@kernel.org>
Date: Sat, 16 Aug 2025 01:20:06 +0000
References: <20250814194323.2014650-1-kuba@kernel.org>
In-Reply-To: <20250814194323.2014650-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Aug 2025 12:43:23 -0700 you wrote:
> The CI has hit a couple of cases of:
> 
>   RUN           global.data_steal ...
>  tls.c:2762:data_steal:Expected recv(cfd, buf2, sizeof(buf2), MSG_DONTWAIT) (20000) == -1 (-1)
>  data_steal: Test terminated by timeout
>           FAIL  global.data_steal
> 
> [...]

Here is the summary with links:
  - [net] selftests: tls: make the new data_steal test less flaky
    https://git.kernel.org/netdev/net/c/715c7a36d59f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



