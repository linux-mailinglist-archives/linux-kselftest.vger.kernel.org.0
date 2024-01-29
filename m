Return-Path: <linux-kselftest+bounces-3693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B862840A89
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 16:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318FB1F23646
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151A155A28;
	Mon, 29 Jan 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHiZgAqM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A880153BE2;
	Mon, 29 Jan 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543424; cv=none; b=B+SiDkyAOJVFMXH0V1e3Tw+4o1BJWVckHb5qGfaC/nuFsxap8iENxCYXq8I1A0kHRmQTqsdOibQcr4zDHjdOpU/YcIJnyusb9aSpt5pxk6461/b4XVg76XYQ5H1aIVEVGwONJM7uSvWebF+cZ6XAJ91nmbvdW4vJygwlbiP+Q5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543424; c=relaxed/simple;
	bh=ax/Lh/PBKSuiBecALTZz2yYQsi6XfmmWzOHHDFEOAmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T1e5v9G00ePuIJjLyLl45AEuQ4t+H/k+CHb92bT5bpMU11JjI4ND8fvI4Mkd57QyznafAB3BFrGAgqpoF/GW9xaD5SsagG7jPRsCAv4BoVXklAdBqg1C3niN+6bBAfBOOQF1AlEDyJ+bL38qCkLZfxjo1mHM4G2qZBWZOpFtUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHiZgAqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C8DAC433B1;
	Mon, 29 Jan 2024 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706543424;
	bh=ax/Lh/PBKSuiBecALTZz2yYQsi6XfmmWzOHHDFEOAmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qHiZgAqM2z92tRqiTELg9/zAAnFRcQyMKlXiSLxnsbEcIEu2u6hn4QBZTflRutOqW
	 onmAHBB/az3Jb6R8pDgSLYASf9UhmzDvokaZ3569tQgnPI5gyqlEgcDi9WPf/Oo+5y
	 dUq0gHnT/zLAayFvi6xw+iq84clac4+cKY78yDFY8rFNJunG+sss+hHhOplPdWEc2F
	 Z+XSW5Dz5sxK2lrQAt12pC6ppTuISyOwJr5neRDhuel9ClK0x3eOiBoClBscrm3w2A
	 kk7FAp/dmoqv4APEbr/b5CcybY+G9Xmq5WYf/dh0bUvbWihotE5/oVzETGtaYtwqgo
	 7wlLwQDBLjUyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12083C595C3;
	Mon, 29 Jan 2024 15:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Drop return in bpf_testmod_exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170654342407.16483.4558817250866112324.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 15:50:24 +0000
References: <5765b287ea088f0c820f2a834faf9b20fb2f8215.1706442113.git.tanggeliang@kylinos.cn>
In-Reply-To: <5765b287ea088f0c820f2a834faf9b20fb2f8215.1706442113.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 28 Jan 2024 19:43:57 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> bpf_testmod_exit() should not have a return value, so this patch drops this
> useless 'return' in it.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Drop return in bpf_testmod_exit
    https://git.kernel.org/bpf/bpf-next/c/f149d03f450b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



