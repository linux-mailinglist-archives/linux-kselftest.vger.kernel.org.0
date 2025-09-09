Return-Path: <linux-kselftest+bounces-41055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F9B5029F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 18:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90323B46A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E5246782;
	Tue,  9 Sep 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAmfNHPA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4174352FE1;
	Tue,  9 Sep 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435405; cv=none; b=NacV2R+Qvbl/Ad7GLtFTVk+LbexspdyEXdh0bQFvO8AGp9bMaIq2/m29GU7cNRZwdyJHRUmQfjqroYaX865FUV3+yC3U089BCjZoomkI66EPDaWWYZfyz2VI/EKqUhkfSiIRph3fNIV/bY2bV0IhLSE96jRv8BvyK0vVirr5b3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435405; c=relaxed/simple;
	bh=5i9KU6eO8qxun6e1/OngWs8fYDThzf/EXL86OZ2DRP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hb2eoKq5jGHB4h9jM5LVwS6Qa4BtUS6IO9jjxsPS92fcFQSdKvZE52LNrvM5sgk3+LAprMhfOXQunFFeM1xNADbf0iNQj0qms6tjK3xP2wc3ocvxIABb+/d4HVa++JI/i4MqZ+KZSYEzVIkl3sOioHEKi0rFhM/DR60kL/ob+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAmfNHPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A73C4CEF4;
	Tue,  9 Sep 2025 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435404;
	bh=5i9KU6eO8qxun6e1/OngWs8fYDThzf/EXL86OZ2DRP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QAmfNHPAIxtVqxdx/0bKgPE9mNpF8jXLCeLfvbqg2or/4GnCceD+qmoDQS9s/iWZI
	 Pj66XFvCpRMSDmVWiXuxfRq09oVmcxpasghCJmnKNka/78CelEowvr7UGGUqFVNzLk
	 zsAgmK9LJe02NVh9e1g807bo7vhJRKQVxVhk7N3IfAXzHeI4rixKu8swkroR5FpkZL
	 4EOJb++51/Yg4nSW+gWq/BRuLpdnVu+NbNNpOhP7pVdpck73KxUX2xnuUIS31BS6XK
	 4aSNFub4p/3hmEGPuL7TA58iLz09pFQ3p8Jlt3wA4gDW2ki7DvgQORRHLYxObPrVFt
	 oJv9y7q6avvBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBE4F383BF6C;
	Tue,  9 Sep 2025 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix incorrect array size
 calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175743540576.739384.5785409430836758847.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 16:30:05 +0000
References: <20250909124721.191555-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250909124721.191555-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: dan.carpenter@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, jiapeng.chong@linux.alibaba.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  9 Sep 2025 20:47:04 +0800 you wrote:
> The loop in bench_sockmap_prog_destroy() has two issues:
> 
> 1. Using 'sizeof(ctx.fds)' as the loop bound results in the number of
>    bytes, not the number of file descriptors, causing the loop to iterate
>    far more times than intended.
> 
> 2. The condition 'ctx.fds[0] > 0' incorrectly checks only the first fd for
>    all iterations, potentially leaving file descriptors unclosed. Change
>    it to 'ctx.fds[i] > 0' to check each fd properly.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix incorrect array size calculation
    https://git.kernel.org/bpf/bpf-next/c/f85981327a90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



