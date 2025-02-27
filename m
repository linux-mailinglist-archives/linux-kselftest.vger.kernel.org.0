Return-Path: <linux-kselftest+bounces-27778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E0A4832B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC557A73AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB8926AA86;
	Thu, 27 Feb 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsRDkQP4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A224E00D;
	Thu, 27 Feb 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670799; cv=none; b=hu5+Q4Xt88PZoddfo6ry5axslHIrIcB6dwiAW9UQIUMC3xAsirjAkImCBcvGWaEBlvO7eGqWwYiqm4tDIe8LSTl8dEzyrYVA7M/Deiht1GBIk1+iv8U8F/7VvJ/1KJVZqc2eXg0XXDlY7RzRgQBPifK6TmZaPycGeDQjiiaxgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670799; c=relaxed/simple;
	bh=ulkdMokp9FiXOn19JEscrw0Prlr8PbWZXyPsEiThdpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WLZm47acIQ2gmcStvRJDG2qqz/XepOcXFdLk7Kkm8n4kjAAX1zJFoLj4qVtuRxVu/I38jJw6+HRy6xMxQVrNtyHCQU5r0TCNjuHuN+KYZ3jdVX6NWj/G4fvPrMNNe5hAbHhsSejef7CTsn7vy4xGNKUohCAyws+ChgOQWgNUr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsRDkQP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5DDC4CEDD;
	Thu, 27 Feb 2025 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740670798;
	bh=ulkdMokp9FiXOn19JEscrw0Prlr8PbWZXyPsEiThdpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XsRDkQP4YEs27VvzwmsDaRV3ReaWl8Z/E0a/O8qc5lK97UVtuopJQD3eSuv54/qZd
	 YWahPot3+G1rXL4lzhNhbkA4RejVWNtHmSTQOZG8SVU1kkju7umVmcYU6SxfOripIU
	 Pj483ftrj5UT+ksEI8JzQ3DxemIfSlLDUPIkN+ciRuuwh1kCC9ZnOiR1o55yHtIniH
	 a0dfdW+MnKN722BSIaWnkg5lN6uvuEHtHQQpcuAJ0TrZ3mnHyFKxSwXIbyU38rf5kU
	 YPxAA0W5/EdKJKHzlRqXhJ8voRzkPwDRdI2GLMoSJvO2ig25SIb/WKpxVQfz8b5eUZ
	 lqlwoSjPBra2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD14380AACB;
	Thu, 27 Feb 2025 15:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: drv-net: Check if combined-count exists
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174067083075.1471828.9747653732616870781.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 15:40:30 +0000
References: <20250226181957.212189-1-jdamato@fastly.com>
In-Reply-To: <20250226181957.212189-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, dw@davidwei.uk, gerhard@engleder-embedded.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 18:19:57 +0000 you wrote:
> Some drivers, like tg3, do not set combined-count:
> 
> $ ethtool -l enp4s0f1
> Channel parameters for enp4s0f1:
> Pre-set maximums:
> RX:		4
> TX:		4
> Other:		n/a
> Combined:	n/a
> Current hardware settings:
> RX:		4
> TX:		1
> Other:		n/a
> Combined:	n/a
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: drv-net: Check if combined-count exists
    https://git.kernel.org/netdev/net/c/1cbddbddee68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



