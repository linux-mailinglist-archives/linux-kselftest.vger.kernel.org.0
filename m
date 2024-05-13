Return-Path: <linux-kselftest+bounces-10123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C9F8C3999
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BDC1F21432
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E262C4C9A;
	Mon, 13 May 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INO5/lwf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBF6FC2;
	Mon, 13 May 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560227; cv=none; b=u/Z+qkfsJFzfr5ABlokJpXbpdQ4+JCM5IWd29ZiknAcPYVUbhXIVDSKVbKcbyAbFjAGEybU8gfC0U+z+UIip/Mhxqri0lzQPsHL7nGEkR+YMrQELl3QIXMRCgCWHfQzFqQTdUozxnP+0xVdvK7Uxm6TX3WbFJS91WYI1OvqEWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560227; c=relaxed/simple;
	bh=ZeioUWwBdjtOf6MYNA4iO0p+x0+D5Ip0Flz/byoQZ30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R1kde51yKHCKYyUvWtO9iKY5CB8vZdEc5QSOTGAxeg/IiB7DUs5p/7gD5Sq25BL35PuRxJ8vHt0JVFKqVHKHuhjAuuWYacOI5CFr+gYuDApOOWMiDdiLIneikS3+EQjf+ftrJjneXpIvABMkcnbyvrzPd1T5KBKH9oclNBkWgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INO5/lwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C68C4AF07;
	Mon, 13 May 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715560227;
	bh=ZeioUWwBdjtOf6MYNA4iO0p+x0+D5Ip0Flz/byoQZ30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=INO5/lwfN6D8GejiAjQPyKKsm5NPI55147V/Lzuw6SsnW8HwKBU62GZ31CF3LOIHt
	 L5cAQspMStCXt21OcHGPWjg+Tz/Kp36IqGRkZKxpW0myUaGdMjB4C80BEzxw/zdz5S
	 PwgB1etsRUq87GT/t7RoDYwPSrljKTlOdlfPrBtczlXjh761mdeVOCdY50sh7nrOx/
	 vBsVjm1GnWvbuk9XSh/FgRY7eXmdvVRYzFm+vPDYLszsaK9IIAkVSoZQ744frfG4UX
	 jzR6fx+1tJ78R4oS5TXkDOMe37o6y/EL1HqlI6uIzj5ZlxsjOD6vgY19iLYgVjADx/
	 7aucwHrMwq8hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E9FEC43444;
	Mon, 13 May 2024 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Free strdup memory in xdp_hw_metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171556022712.884.6947069044278472975.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:30:27 +0000
References: <af9bcccb96655e82de5ce2b4510b88c9c8ed5ed0.1715417367.git.tanggeliang@kylinos.cn>
In-Reply-To: <af9bcccb96655e82de5ce2b4510b88c9c8ed5ed0.1715417367.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 May 2024 16:50:24 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The strdup() function returns a pointer to a new string which is a
> duplicate of the string "ifname". Memory for the new string is obtained
> with malloc(), and need to be freed with free().
> 
> This patch adds this missing "free(saved_hwtstamp_ifname)" in cleanup()
> to avoid a potential memory leak in xdp_hw_metadata.c.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Free strdup memory in xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/a3c1c95538e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



