Return-Path: <linux-kselftest+bounces-34387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0AACF4D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A53170AF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F959275112;
	Thu,  5 Jun 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrONN9qW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8F5FEE6;
	Thu,  5 Jun 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142675; cv=none; b=T77squOSJKkZSZxskI/lLo32JDQiXMV5zEdsT9NYBwnawa5ZJb8UVNo3TR9erujHdxhesvM5r8SDMS0sqKFjUn7mjIoAO1x03gX3amar+tQUyBxJOIFgoW0U6Q2EsgciPqn9GQeAfkant7zzmOLIJOxa8u/AdpM++siqH8g5vu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142675; c=relaxed/simple;
	bh=pjV3bNzBf1YJf1rM+e/SvZsaxG6fHSEEd/WI3ExKBGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eF2cxZ0aTtsJSvz7zAk3RjltffNTC3/EzujLRKqNWkYFOFQDWhqeEOMAp9tk1NYbwdFuO2HH87loZcXUzFrdBtKkyAAERDf39poaKIQW5cIX2xsx4Lh1aSXO0Wh9EEFHXDi9Trc42LZGVgk/xnxQhuTSA37tJk1kAKaW4EBw5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrONN9qW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99E9C4CEE7;
	Thu,  5 Jun 2025 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749142674;
	bh=pjV3bNzBf1YJf1rM+e/SvZsaxG6fHSEEd/WI3ExKBGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rrONN9qW1aHmF5/UQgqLlnYMX7Q4VsokJ4R22HjDxXA934YUU0zNzq6yjAiwujQMa
	 KT2BDFGdKRzP/RiPPMOj3guszhi3/xzuwAkbC8zf2uYgpL1CGRX07vzgnZ+LbK+xoO
	 S2POrMn3TLOiLPh2aqFY3eGuyCbLN4ntVHjMM3uDVAdrSljSC7F2eLY7W2WdHOS1SE
	 cy2QFsEcSrC8D7r4pgLvv2jWy1wy9HjfqVoMuyJZ3jhsnzspvg/5ibV+eTyT0dIGxA
	 rMpal3yosEluCov6TPplKm4A0gxOA4DKDDgyiLlBBzwaH/JJD+eU+Jm3ASXDOvhYFq
	 Mtl+lu6HSwUZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1FD39D60B4;
	Thu,  5 Jun 2025 16:58:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error of
 bin_attribute::read/write()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174914270651.3142609.5571647506914286281.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 16:58:26 +0000
References: <tencent_A6502A28AF21A3CA88B106F3421159869708@qq.com>
In-Reply-To: <tencent_A6502A28AF21A3CA88B106F3421159869708@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, rongtao@cestc.cn, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 peterz@infradead.org, ameryhung@gmail.com, juntong.deng@outlook.com,
 oleg@redhat.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Jun 2025 13:53:22 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Since commit 97d06802d10a ("sysfs: constify bin_attribute argument of
> bin_attribute::read/write()"), make bin_attribute parameter of
> bin_attribute::read/write() const.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix compile error of bin_attribute::read/write()
    https://git.kernel.org/bpf/bpf-next/c/4b65d5ae9714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



