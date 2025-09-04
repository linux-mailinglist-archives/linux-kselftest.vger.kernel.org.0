Return-Path: <linux-kselftest+bounces-40805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3DEB445A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 20:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758F53A8B61
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788B30F528;
	Thu,  4 Sep 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQLae5Tl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02621EE7B9;
	Thu,  4 Sep 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011205; cv=none; b=eUqpWM6EcYjFFev7FcfpWg+kMT6FPw0z2bZP/RvjcAuML9YQuZkDk+lVjZrpVg8lHUPL78gHukct25zbJ5hHBJ61Z66ybBb8cFbtJyWygmjwVSgh0ZVRUdv07trrJOSwe4A5EFNMJGbskptC4xWWbDzEDTbrezBB5RyNz/53rwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011205; c=relaxed/simple;
	bh=Winv3KuO6OdN1ZG9NJ1TBlrd3TJ5pZUlYk6IRArhaCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GI0LeeDjAD6KDs1ewLJSiKItMdeUsMKVSyGPPWvonBO6nMqGogQgKZk7WLYppLz9393WWAPo2Dhee0n+UdGv6pYzdKpkddNrbCrS/eo4RBCEAAFhwLnHHzGIRwZ9/6dy765X7UecU2gHVKEbxDAwixDE5aYOI5Fsfr+QmILrAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQLae5Tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5C9C4CEF0;
	Thu,  4 Sep 2025 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011204;
	bh=Winv3KuO6OdN1ZG9NJ1TBlrd3TJ5pZUlYk6IRArhaCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UQLae5TlfCgQ04m91HGbpFsHCX5OAX/bZoKhAFtgI8b2UeB2vv0uM+AKG/wz2ckIH
	 2UdpxbGGEMHhkpw7B3SrdCG128tjbidfGy+YOakgK14v/y0G9ckPeW00t5/BVpzNkz
	 elbnOmvowKt8WiQ+4o8fRYJP24um9mJOKP6lwGkKi3cXtSEKTBZf6hihVWO4yfSopd
	 4XFhwDNgZsckqtWTy8LkKbWP61sH/MTV/YJddbTj1taFomv9EXGg7N1tROFfErBHHX
	 BNrR8bYALtb+inpi2BlY/CSH3EdLIt7Pf7kuOPbfEO2UgqJVkhaeIOme2AbXSfE1XJ
	 2B1Sd0Z5efBOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713C7383BF69;
	Thu,  4 Sep 2025 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] libbpf: remove unused args in parse_usdt_note
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175701120927.1914025.414355681034862288.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 18:40:09 +0000
References: <20250904030525.1932293-1-phoenix500526@163.com>
In-Reply-To: <20250904030525.1932293-1-phoenix500526@163.com>
To: Jiawei Zhao <Phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  4 Sep 2025 03:05:23 +0000 you wrote:
> Remove unused 'elf' and 'path' parameters from parse_usdt_note function
> signature. These parameters are not referenced within the function body
> and only add unnecessary complexity.
> 
> The function only requires the note header, data buffer, offsets, and
> output structure to perform USDT note parsing.
> 
> [...]

Here is the summary with links:
  - [v1] libbpf: remove unused args in parse_usdt_note
    https://git.kernel.org/bpf/bpf-next/c/b338cf849ec8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



