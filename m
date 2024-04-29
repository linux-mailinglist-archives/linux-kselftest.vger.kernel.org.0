Return-Path: <linux-kselftest+bounces-9095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1818B6627
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 01:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4FA1C218EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62017BB1A;
	Mon, 29 Apr 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iloUxgku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C62E405;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432830; cv=none; b=hZwLPSLDSnbySG+NCkrzi2ftXwyDFACRDMso2OAWmBv9WWy07IiWJvnmSeCAoNBJoBgZr1pqRU1lW8/Hmt39vn04hx+1cfeBtkjXMOzP2zTLJkpcCDc8b8KJma50LL4VqZOqMYb8DojnFmH28GtLxbmjy9izcA2MuHXWZK7f5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432830; c=relaxed/simple;
	bh=eDP/rILAhE7oVNfVgwnd8zPtqZGLP8a5/qk0KSBqLmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GVJrte0piI19gJSwKwW+xYPC9Ge/WgZpdsd/hl4Duy9oldBt2Hl5VaI2EA3sL3aqNZmTIT0igrU9Q3F6kHn08Y7OOszm+Ih2EohG1dixV4ug8Ydjd0tu0cFRjbxun5IAAnt+TPkAiIyBBxqu/fvCd3xt6g6dT4HmctuFhIZyXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iloUxgku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73B93C4AF19;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714432830;
	bh=eDP/rILAhE7oVNfVgwnd8zPtqZGLP8a5/qk0KSBqLmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iloUxgkuhcitRL6LX9XzPyDsz56f3Zhc9xcX0wW33amJ2xOx8mRBYS4Cx6T3AW50S
	 +dy+FeP97esX9JqkAgzZhkG/T3Rt98YibKLhiLxZYS9hY0c8HZhzVe8YLWH88CLmqL
	 hrlop4hS2IXLZX++bbr99DSYN/vOXfuMJm6EWrKk82wMuuWMsYkiUS/Aru8qnSHCrq
	 2Ii5XoCyOm6mPp8Z+dlLMrjadKedR7NNCnyg2KOseBWWDIE3P7ySbArfQmzvQiWyAf
	 Z5jQrB5rDQqy0WYaG0xqws8Z1v+H/Fwk3uzdgIOyvp+PjQCiNe81uY2gHi5dttZSON
	 /44fi3nwshEow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FA62C54BAD;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Free strdup memory in selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171443283038.1398.7034964733309861371.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 23:20:30 +0000
References: <cover.1714374022.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1714374022.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 jakub@cloudflare.com, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 29 Apr 2024 15:07:32 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Two fixes to free strdup memory in selftests to avoid memory leaks.
> 
> Geliang Tang (2):
>   selftests/bpf: Free strdup memory in test_sockmap
>   selftests/bpf: Free strdup memory in veristat
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Free strdup memory in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/237c522c1d5d
  - [bpf-next,2/2] selftests/bpf: Free strdup memory in veristat
    https://git.kernel.org/bpf/bpf-next/c/25927d0a1bec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



