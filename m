Return-Path: <linux-kselftest+bounces-26923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED81A3AF07
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 02:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630081893485
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777F81724;
	Wed, 19 Feb 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i94154hA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD8114F70;
	Wed, 19 Feb 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929202; cv=none; b=ern0xouxBg8hseW4RYpZq1GM8dpr4Cn1AVWF2nOWrsRMzkIQuJ+sWokih/nnP1d4V18z6YINvJKG6k9IUbNxDAsiNOMVzE5dNCHn0bHB1JIlABnk9+0aEeNv3WeHFNbMoVIvkx6UJtyrAigNPRsOyzZ2npJyeD8hWs7TUhYxNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929202; c=relaxed/simple;
	bh=Y4nJM5yqpSJw03bVFKMdiwJdKpDJBSF/5texQ6suxlo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tw9+NapXifR6Ygd3v0HShf3E+ZSB4ySaODbNcCRb9mHRG6nU2X1i4CaaZ9e6gX47lweWbq/p0FgChYdm0EFJrc9O2bK4KWyKxZtQVZev1gv5EsNlmvPL0cuCJRmJUaJZdzhsQrtF8ourbLXRjw8DKykaafWUcgR4GPQRRwTIzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i94154hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96193C4CEE2;
	Wed, 19 Feb 2025 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739929201;
	bh=Y4nJM5yqpSJw03bVFKMdiwJdKpDJBSF/5texQ6suxlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i94154hA4C1fqqvPw77+FNpVU+Cdf3KDMjTVgP1R8lMO9rEX2H0SGiMFSyzy4DI30
	 s2LKdlpINJipK3RvvlkcgXWK+baAY1bWZKmwG1q6SXSjPqwKvJklVYyjRswLLnMqp4
	 w8w/POC4U1WbUaCPAnba9aR9U5rWV0L8wW106e6gtqBSYkFh+GKwUaoUY7x/+AqAdU
	 m9Ish+QhsoBN/WNiFLnA68iXuChzLxXuLRJNc/HvXjgYN8VqBj5vtHU7xDwq1sC2mK
	 K5wRP73cIxt518WGqbDkORlACV/ul3c7A16cthwPobgrHRBUVFmF10Z9bpCvlOi+iY
	 EibokWQKr911A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340F3380AAE9;
	Wed, 19 Feb 2025 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf 0/2] bpf: skip non exist keys in
 generic_map_lookup_batch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173992923201.98087.10855762431625409310.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 01:40:32 +0000
References: <cover.1739171594.git.yan@cloudflare.com>
In-Reply-To: <cover.1739171594.git.yan@cloudflare.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, brianvv@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com, houtao@huaweicloud.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 9 Feb 2025 23:22:31 -0800 you wrote:
> The generic_map_lookup_batch currently returns EINTR if it fails with
> ENOENT and retries several times on bpf_map_copy_value. The next batch
> would start from the same location, presuming it's a transient issue.
> This is incorrect if a map can actually have "holes", i.e.
> "get_next_key" can return a key that does not point to a valid value. At
> least the array of maps type may contain such holes legitly. Right now
> these holes show up, generic batch lookup cannot proceed any more. It
> will always fail with EINTR errors.
> 
> [...]

Here is the summary with links:
  - [v3,bpf,1/2] bpf: skip non exist keys in generic_map_lookup_batch
    https://git.kernel.org/bpf/bpf/c/5644c6b50ffe
  - [v3,bpf,2/2] selftests: bpf: test batch lookup on array of maps with holes
    https://git.kernel.org/bpf/bpf/c/d66b7739176d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



