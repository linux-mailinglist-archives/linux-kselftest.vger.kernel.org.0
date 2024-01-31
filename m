Return-Path: <linux-kselftest+bounces-3873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E3C844759
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 19:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFBE29163B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95931805F;
	Wed, 31 Jan 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUbAWfzV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6F20DDA;
	Wed, 31 Jan 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726427; cv=none; b=nN5zchx6lxYF2SranXlJ8DV5ZBfzJcQzPFEkzN4FRek+ZQbecg1DuBjBBD02G8uCBjajNbWNs+dOy6O719YQwEaslUr5BElrl8GGJLlHqilgA+CKiZ18PiqEb2evii6QmLLz3or1RZbNGasJmNT8RLHAbuZ/Pa5fp0iqv9rZ99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726427; c=relaxed/simple;
	bh=OucHFrQrepWY1DcBtuh6DPk+S2BNyqpkwgRHqum1Kug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i1wee2w6cwm8DoyOexcvi6DTB8RilaKzhJzYqRfCx9zpc9y3RZhXUmFtNx0xdOVz7d7slsQbctl75GX+laxTscRjPKBAQ0lHWfJiIQFFeeboWJt8LVoYt5VJ6yS+CG2122Y7hYG8+gCLiBONxJJ95N6nnBmW3CuVtk6/iS1Kz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUbAWfzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EEE0C43390;
	Wed, 31 Jan 2024 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706726427;
	bh=OucHFrQrepWY1DcBtuh6DPk+S2BNyqpkwgRHqum1Kug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JUbAWfzVkHEjdDQ1MDRZ//LILzQeAykKMl7HPsuwuJUxNPYT4yi1Qic1PgpWDrEEy
	 0yWHDBK6kko3cPb0pAtLmqfDvJOL9Om9fPE3Bsy4hWpy1ezW1/j4PRLOdnyCFcZc3v
	 yfz7tMlP+gHrkATPIrrinTr1FCnUpEIvDUIAj2T/aehG6ahmHjk7OOsPnWzQD+F5/r
	 ln9yUgiS8s9Felk/uWPWbzXHrgzX35QZJBD3Xjez3dnR4p6nAzXqXmS3gT2l7ZfMmZ
	 /uWFdF7I59PIOO7AmXUePeCt2S4D9bYHGFr33j0OWj9WtbIR6TrvO15EhkbOvdzl0r
	 Ng+KSgjErBgJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F26E6C4166F;
	Wed, 31 Jan 2024 18:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170672642698.17056.2047153019908847413.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 18:40:26 +0000
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jan 2024 21:31:51 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The test sends packets and compares enqueue, transmit and Ack
> timestamps with expected values. It installs netem delays to increase
> latency between these points.
> 
> The test proves flaky in virtual environment (vng). Increase the
> delays to reduce variance. Scale measurement tolerance accordingly.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: calibrate txtimestamp
    https://git.kernel.org/netdev/net-next/c/5264ab612e28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



