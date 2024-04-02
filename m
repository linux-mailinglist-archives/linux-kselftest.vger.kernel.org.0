Return-Path: <linux-kselftest+bounces-6969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60BD894A5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 06:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF72C1C21F49
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B617732;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glJIFoiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7A15E85;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031627; cv=none; b=Lw+fh6JYOOWiPyos21L6+5eTrK9S6dHPTGDwvOPLiVefaNzzx8j8Zm6W+f6MmdXbJMuTCZki/uIzh+UsDzj3ZFugdDWXgxOGJVh1tYOmp8apY01UM7qugvlCPqRPidIWhfe1P0hF69xW2kKeSPZW8FUk1HWoLGO0fuu7HmIQhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031627; c=relaxed/simple;
	bh=2mFa9uRHacga9htzLjyZvGjYCDeyHbMSgIaOqOYbF8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eWgex5O1hyo2WJU5qTuOAd6i9LUZPCVB21M65dc9Cvv9ZQFCn8v/+YvKA3SvvRhP+mGQEruPd4gA6wXQD6HHO0smwyP/3kb/8v29Du7C2O2XPG+QecFEmLM8np30V9CrfZLA2KrZYbyG7mM+9oodKO7kDIviOC8VrEuBddEKDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glJIFoiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12657C43390;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031627;
	bh=2mFa9uRHacga9htzLjyZvGjYCDeyHbMSgIaOqOYbF8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=glJIFoiI6SXubzegHr6LE/em1ZNAr2SVeQwohZvBr9fTbjl6Vp19v4ry0tnSmL/w4
	 xp1kRWi0j+4bQM4R9poFKwmopckpQgrDhlKhDuUpQlAdot3kUWMJvSWqkbREAUNpC9
	 ut5BczFhWHK8fOBl++a8v3uhJRfBG5FxtpxhNNmtZvIVFfgcMyz3xHwujP7cYdmn7h
	 IKX3V6MZTOLB3n/3FTwKyap9nhsaQxzISygkxoNZdY2w4+AgEaWbfuMDxYaECXyhu6
	 FTOUON69ohgwGNaQ05QbnRgDKwqAyPOzoxxmJjqBmxKpWLGO6B1TeGSjCuIN9iwuJa
	 UILm8GU1ozF7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02F97D9A14F;
	Tue,  2 Apr 2024 04:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: reuseaddr_conflict: add missing new line at
 the end of the output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203162700.30104.1836980551681376824.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:20:27 +0000
References: <20240329160559.249476-1-kuba@kernel.org>
In-Reply-To: <20240329160559.249476-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, jbacik@fb.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 09:05:59 -0700 you wrote:
> The netdev CI runs in a VM and captures serial, so stdout and
> stderr get combined. Because there's a missing new line in
> stderr the test ends up corrupting KTAP:
> 
>   # Successok 1 selftests: net: reuseaddr_conflict
> 
> which should have been:
> 
> [...]

Here is the summary with links:
  - [net] selftests: reuseaddr_conflict: add missing new line at the end of the output
    https://git.kernel.org/netdev/net/c/31974122cfde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



