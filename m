Return-Path: <linux-kselftest+bounces-34207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587AACC451
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330E43A3B23
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D2225A40;
	Tue,  3 Jun 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0DmClBT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865392E62C;
	Tue,  3 Jun 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946596; cv=none; b=Z66V+rQQod3awdFvvwsxBuVKPhLXfd1sEHR0KRJGKiozlaihjC+d2XP5Jve03PtbP3+dT3SRLYqUMyjQGy7gFMzICDpN0TNvbx24ihgyrk4j3gu43hb03uMJsmpLAay8xKLiaP5AZn7Hq/XguNUUmIUb6jEURJalnsQEYh5syJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946596; c=relaxed/simple;
	bh=khxlET56OAfg41RXU4/AHLetc/aybreUdIcdoeiO9EM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBolZUHgsnzSRNk+/Z34eIrrmuKZIAOPoRpvmdlN561y/27tPILiVJipEebMuYMhifPMIs2Rm9jYWTSuQyVyO2T3aJQ55HalEZM36PMgyv1XjwvkU4xHnRHqPrkgK37yttzZ6VLhe3UpCH7WJm5mIv3iSOputx3+wKNreoWq4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0DmClBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D0C4CEED;
	Tue,  3 Jun 2025 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748946596;
	bh=khxlET56OAfg41RXU4/AHLetc/aybreUdIcdoeiO9EM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p0DmClBT2Rx3mV5rTKPst1vwxrpxuGyfCjSd5ncX1oCP9xb5BfXLi9KszK6mVT2N1
	 E76qp+s8im1g3rV6dp+JpNjg4P2Jr8fvZv3dPOj060H0pIbD/DDJBKYqEbE6+Gqtph
	 eMRn/oZaqqh7xJy1YFBv8+/C46gbTiyxl7rIP4dDcylAoyjq0+wYuUQoxEBWgau7dG
	 +R2OztlUM3/AZoKJaUpcVZpprH6fDdILfI6wIlaA5k8HP+031NfjTmHxIXEUXv+rUQ
	 ON0MDOYaD82fs8jPTvtJoKzx2Ioe3Y4lR1pL8eCMd6Dhv9I7Ok5EdpkHNLY7nqUXkQ
	 Oexv+y1UuaRHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1A380DBEC;
	Tue,  3 Jun 2025 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests: net: build net/lib dependency in all
 target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174894662851.1457586.616581985114970540.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 10:30:28 +0000
References: <20250601142914.13379-1-minhquangbui99@gmail.com>
In-Reply-To: <20250601142914.13379-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 philip.li@intel.com, oliver.sang@intel.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Jun 2025 21:29:13 +0700 you wrote:
> We have the logic to include net/lib automatically for net related
> selftests. However, currently, this logic is only in install target
> which means only `make install` will have net/lib included. This commit
> adds the logic to all target so that all `make`, `make run_tests` and
> `make install` will have net/lib included in net related selftests.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests: net: build net/lib dependency in all target
    https://git.kernel.org/netdev/net/c/d3f2a9587ebe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



