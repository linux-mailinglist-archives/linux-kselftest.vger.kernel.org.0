Return-Path: <linux-kselftest+bounces-40713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C3B42DA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 01:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B083AACB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 23:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630002FABEE;
	Wed,  3 Sep 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFgJSZDn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE142D4811;
	Wed,  3 Sep 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943403; cv=none; b=IxHmdCqCsTrYkDgw6/htyZJHHCLdUcKaxlh2skoHHCzDsV83xum1cl7JC1MDYYz+NQfuFMQvifCKtyeyvgNY7dBladMM75El8rb/Tfo/NwkD7cJIKJQTJ83AZfVBKMw7IahvuT2O9p6hmP4AOQCfONF+ARRSKnX7HEIcR7Rkc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943403; c=relaxed/simple;
	bh=hJ7XefSDilhCrkfpz/CS8i/X+9Tvxqfo9xbmmHZ30ME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HwHPoPeVLpIIxK5A5mZFb2Ae8bqhHsm9CJxG6HctFF8eZRqx3cyz0bzikedYbkFpbNASsneXikjdS+MuxiZqLu/8ot9pG62OMm2W+Lj7JQ03u6jN7LZCRTvj2OlWO8h6QWp+1a16UFD98gQrdGnEaeauYN57ArirPQ+qEsynIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFgJSZDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A418AC4CEE7;
	Wed,  3 Sep 2025 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756943402;
	bh=hJ7XefSDilhCrkfpz/CS8i/X+9Tvxqfo9xbmmHZ30ME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFgJSZDn4kP6FvCpVppJxdKm3qPpyf/wpGFpVyY2MzGuQIcu2ioPN3Ivunfj6W8Rw
	 pU6SMAuBq2rORPvKNgy34Zfhuj8T9mRCf2I/7MJJSvYvZ0W92jmh+TIXN++TDwUbLk
	 KnSnDk1UeVSvWaeOzqTasS5cPe9NmH/fws+PjE6mtKmdHhq5JoIESqhPBD1+ETM6gm
	 8qmkTXFMD64AnAJCnaABuMxeBSdBe8UbEZvugSmkUvR0vpzXuz6G2Im2NQZRksCOi1
	 8nZw3HdfUIxMfn3des84ZopOW3lvi/K0cVvM8+/Sf70cjMg3xvZu3f0ZhZ8OXNVp94
	 sTCs++tFG699A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1B7383C259;
	Wed,  3 Sep 2025 23:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix count write in
 testapp_xdp_metadata_copy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694340776.1240011.10437531315474596312.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 23:50:07 +0000
References: 
 <20250829-selftests-bpf-xsk_regression_fix-v1-1-5f5acdb9fe6b@suse.com>
In-Reply-To: 
 <20250829-selftests-bpf-xsk_regression_fix-v1-1-5f5acdb9fe6b@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@codeaurora.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, tushar.vyavahare@intel.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 29 Aug 2025 16:33:49 -0300 you wrote:
> Commit 4b302092553c ("selftests/xsk: Add tail adjustment tests and support
> check") added a new global to xsk_xdp_progs.c, but left out the access in
> the testapp_xdp_metadata_copy() function. Since bpf_map_update_elem() will
> write to the whole bss section, it gets truncated. Fix by writing to
> skel_rx->bss->count directly.
> 
> Fixes: 4b302092553c ("selftests/xsk: Add tail adjustment tests and support check")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix count write in testapp_xdp_metadata_copy()
    https://git.kernel.org/bpf/bpf-next/c/c9110e6f7237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



