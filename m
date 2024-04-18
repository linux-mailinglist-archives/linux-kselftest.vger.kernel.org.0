Return-Path: <linux-kselftest+bounces-8291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D88A90A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908321C21BBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3E1A5A2;
	Thu, 18 Apr 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsVBNbwk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E543BB3D;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403829; cv=none; b=PBQQbofK4Ncqr5mTiM6CUnCkXKwpnEJQgPwX9usecB02g36wzsZvsdbTmjnX7LLbBHaild3qzXS+lwOQSDSA91eObHSzGsfyPooHNfuUgg/3aYKvGKTcRJkfTfR9fJ+3Ohh7MJvz03kzvKNaLanscfomgtBUraCBXWYtw+I6i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403829; c=relaxed/simple;
	bh=ZyhzTg/s0PUG65KrOeKffnLgw7Xx/VbURcWtjVQpvUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NDT9LMumFuGfqiR9j5Nk2ZbL945Bv4B3M/T+UrCFHjLnTtw35EU130c+Xe017goKbM0sAw/LMSc6P6SVCGi8UdK9bfLSsRryA3ICEb4vuXaIKQhCGGJ66M9e9uEa7TEgoJnLHoMi8x8xJBIc290d3KledH0rpzDkZjEFiQL3ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsVBNbwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86E12C32781;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713403829;
	bh=ZyhzTg/s0PUG65KrOeKffnLgw7Xx/VbURcWtjVQpvUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HsVBNbwkc2xe9UjEO6lUgdFWOfJ1klrwgjWb/Uj+Q0yy/36hZ2bYbhf6JEM56Z01y
	 dFdPF2sz/1EDXxd0Xh8ovka+QeDG8BuHaZk9K2KmCYSF+uOyHK9fbZs5NP4xcgg0mk
	 maQouCruGovroH6bzc6wqnifsRIJHP10NoGqiWtrNO2LLMvdWVQPeFk1qvMpZA+D5h
	 11AU3tGVj+JDTXiXchAz9rlgGyAItDnWKMg2j6jqEMoxO8tyIrTuurGm0wz9PYI1tq
	 AHswrQS4qFcG4ZRYPQunFItMJCDWfDIyl61wFT3Ia8BgLkVKU31UJ0kcgvgqE9PgSo
	 YJ7prqjMGkiOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71500C4361B;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: openvswitch: Fix escape chars in regexp.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340382946.22183.15564390234017793825.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:30:29 +0000
References: <20240416090913.2028475-1-amorenoz@redhat.com>
In-Reply-To: <20240416090913.2028475-1-amorenoz@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 pshelar@ovn.org, aconole@redhat.com, davem@davemloft.net, shuah@kernel.org,
 kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 11:09:13 +0200 you wrote:
> Character sequences starting with `\` are interpreted by python as
> escaped Unicode characters. However, they have other meaning in
> regular expressions (e.g: "\d").
> 
> It seems Python >= 3.12 starts emitting a SyntaxWarning when these
> escaped sequences are not recognized as valid Unicode characters.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: openvswitch: Fix escape chars in regexp.
    https://git.kernel.org/netdev/net-next/c/3fde60afe1f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



