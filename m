Return-Path: <linux-kselftest+bounces-4507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBFA8510E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 11:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C56AB23648
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445618C19;
	Mon, 12 Feb 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP8tzMOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD6182BD;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733826; cv=none; b=Z70zsyOC09taPsumumkYMYSpUA+eW4p/tCirs9aAlsIqIAvI31xMLGdDg4X26w0zpW4sHR52vCfzYhoUUDVHBRItW/t4TdWiji7FR07Qax3iJU7Lt+EGjrl6m4JfapoqMoaAV0eQj6AFHpCHsKn6rSp9/9VH1nFn1d6tMJqMEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733826; c=relaxed/simple;
	bh=PG9SkCpiqVTy+GkQxn1KPbnUnsHHSjIS0sbVYoBwvvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gO4lwG6bHftDJrxSRJVaFQiiRYdqzrnof0V7gYbdjW+kwfDL3u8HxyXV5BPuP4MRubAWlLI9Fn8uh55mb4fS+uSDJXnB1xF6UxZXoSO6m1c9C7/rK1FkHnhBPnZyRXkGnORGKnP1xeRy833jpQi8Nyscpijr8nHJYlD+uLKfsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP8tzMOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 964B6C43394;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707733826;
	bh=PG9SkCpiqVTy+GkQxn1KPbnUnsHHSjIS0sbVYoBwvvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SP8tzMOvJnIvdD8ZF9ofkmonfCLih/sc1DVfxWzQse9G4pQK1YjlD7JjNp0+1rI62
	 sM4av3paQa3zoynNXPk6Tl7E+rO7AXWiNe1Y2HKr8Me0gZt9DWpm53pRic5f9T+wxg
	 LaBsNrAyytg9wXOa14fNtZ3PjB3FkcNIdWgCnHXeO1arN2qU8WxOLVDny/UumbpvkE
	 gwboaYlDItjvSjOHivxN65dyTYNKApcv6V/aajo36qEO2hbY82caN33FkYLCE9eK9j
	 oou6/UspMHALDBgdKqrBJpZ+aWrR1u2JyYNdgh6Kbg9fFMtwWPyEFr7J0Nis4b8R6Z
	 3FbGtgE0Qf6Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 778D4D84BD0;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: ignore timing errors in txtimestamp
 if KSFT_MACHINE_SLOW
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773382648.15535.2453519836119063117.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 10:30:26 +0000
References: <bca0a7a2bac7fb1db6288a54936cdacdb0eb345b.1707411748.git.pabeni@redhat.com>
In-Reply-To: <bca0a7a2bac7fb1db6288a54936cdacdb0eb345b.1707411748.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Feb 2024 18:57:49 +0100 you wrote:
> This test is time sensitive. It may fail on virtual machines and for
> debug builds.
> 
> Similar to commit c41dfb0dfbec ("selftests/net: ignore timing errors in
> so_txtime if KSFT_MACHINE_SLOW"), optionally suppress failure for timing
> errors (only).
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: ignore timing errors in txtimestamp if KSFT_MACHINE_SLOW
    https://git.kernel.org/netdev/net-next/c/9c52994e32c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



