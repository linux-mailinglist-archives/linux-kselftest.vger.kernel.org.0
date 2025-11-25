Return-Path: <linux-kselftest+bounces-46413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96119C833C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7813AC293
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07123ED5E;
	Tue, 25 Nov 2025 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3pcItko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B911F1313;
	Tue, 25 Nov 2025 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041447; cv=none; b=ozTKU96fyrOn3fMXT7VyihJNDOZfcMSUfGAeH9XYDb3bXvhm9xPns5XBzUIaRisMBIhGcxVNyhXXo6/jTCEqCtg+l5NwtiMNFNXx9aHonA62Fs87W7PXbBsMTLeHYXBP2fMlfFejtV3+XP2AurjW2NUQFnDzO/AVRZjJmq7vQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041447; c=relaxed/simple;
	bh=+MMACuO/EEO4urTCKiwdOmj7uPrXVNGTmbL2+n0lnzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X9A06JoKhY4CUserCfjpzjPthQHkbt7YR5Uwsdrgq7f3AB/KP01pLYb6xM2foYhY0XFTqcnUhyWJ8JAJsZ7abTE7XeSpQGNp1FU8H08wKLeawTVc4WmJCjxdZrChzcDujtELD8GsqnJRuqXy7MD8X5ka0e3gemjVz5EZkoI1eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3pcItko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47499C116B1;
	Tue, 25 Nov 2025 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764041446;
	bh=+MMACuO/EEO4urTCKiwdOmj7uPrXVNGTmbL2+n0lnzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o3pcItko9zKxmfabH+qtiw0UrdOaw6RCi87/MoY5Iob7TyDDZz7F4bwfLMOc6aSk1
	 DCe7RzCpCYXD9PigIgTepkVXghnEu8CfMHe9RLiMMZBmUtgd5UL4iKMWHileOUWq9o
	 QzbJBQ6ueb4Qb20wwGM1lWnPKphLIIfnBPz5EqbzzQwANe+xBBc9olXMO6jwHiZBeg
	 xc/kN7DEsf6keT/DH32F+t86VwfwLl4OBAOCLlQqWrW3Q0Cs07sdy8t17kMZbQmZpc
	 sfF/B+fOX482paWu+lzr58sSkw7UVhM7V3WwzSfW9wGKW6PjNIYw44JPJVlQj9Q3X1
	 8Ilksd4J+Cssg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3F7D63A8A3CA;
	Tue, 25 Nov 2025 03:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: af_unix: don't use SKIP for expected
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404140900.172437.13828660486764737049.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:30:09 +0000
References: <20251123021601.158709-1-kuba@kernel.org>
In-Reply-To: <20251123021601.158709-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kuniyu@google.com, adelodunolaoluwa@yahoo.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 18:16:01 -0800 you wrote:
> netdev CI reserves SKIP in selftests for cases which can't be executed
> due to setup issues, like missing or old commands. Tests which are
> expected to fail must use XFAIL.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: kuniyu@google.com
> CC: adelodunolaoluwa@yahoo.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: af_unix: don't use SKIP for expected failures
    https://git.kernel.org/netdev/net-next/c/e254c212cd9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



