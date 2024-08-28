Return-Path: <linux-kselftest+bounces-16560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A8962D1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F632842A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B41A2579;
	Wed, 28 Aug 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUspqTUH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04C34CC4;
	Wed, 28 Aug 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860833; cv=none; b=mhzLsAEKwlZ/L8Ii3a0xkdrCKpw2kdlpJjRd5yXeQBoakZpJZUH/Cqa0MezEpnICl/xCQHYJwPGoTMJ2rLHU2rGfJ/V6yJbWEDCqpAloslAs2L0qRqIhZRl2R9pPhOj+j1vAJhWaZue37+WkHXQmaCpEEnAbGo2FuwYNd3LpHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860833; c=relaxed/simple;
	bh=ga4suhL2ZdRrRF2FNU0Hv7rg6wOwxZ2ML7uyYHLT34g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOfkOocLPNsGYsKT8FRoEsTQkn8yvRjKKZe218DF1Zq4/e3sKGChhU3Pwz3Y86sJZAR1a6ljLtp025WfHfId7VxKoeTU6kJZw29sJaYrqWnqw6ymPyBZfof4a8zYFY0d8nfI3wkJJAN+W/zaZ2hxACuzjPRvdA3B9dstzcB1iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUspqTUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FB9C4CEC6;
	Wed, 28 Aug 2024 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860832;
	bh=ga4suhL2ZdRrRF2FNU0Hv7rg6wOwxZ2ML7uyYHLT34g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YUspqTUH2FvznOMOE63N1HUAEg3o4djIHfANMcONW6Kxuh74hy1go5cXw6hTvJGW8
	 UpIPkS77NM0KD+84+JdehUJ7pvmmxxIgTjA05+w/3VL6Fgou13YTPMOmc7PYsoG2Rr
	 dm6SeWx1udqPKQT3wCVnvFzasCBppyMMjS/9xXAaQm+RB6JbEtZB+Bj+4bWJgVa5SV
	 8ZyKqL/1rwbJZxaXLX+WalwKPzb5HLWhVcy2JeTSjTy9F/z5o/KERC0p/K37Oohfp9
	 2IYMXKEDXndvnlfFFX6FZj7F/hzGO9hJTAbJ3jMuXmtnMODh15shMQ82zAN6bhQC4P
	 AedxundQqsw2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711D3380666A;
	Wed, 28 Aug 2024 16:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172486083229.1310856.14469889698346367573.git-patchwork-notify@kernel.org>
Date: Wed, 28 Aug 2024 16:00:32 +0000
References: <20240820023622.29190-1-hao.ge@linux.dev>
In-Reply-To: <20240820023622.29190-1-hao.ge@linux.dev>
To: Hao Ge <hao.ge@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, gehao@kylinos.cn, dan.carpenter@linaro.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Aug 2024 10:36:22 +0800 you wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> Smatch reported the following warning:
>     ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
>     warn: variable dereferenced before check 'buf' (see line 454)
> 
> It seems correct,so let's modify it based on it's suggestion.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix incorrect parameters in NULL pointer checking
    https://git.kernel.org/bpf/bpf-next/c/c264487e5410

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



