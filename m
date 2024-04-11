Return-Path: <linux-kselftest+bounces-7722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F18A1F5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA8E1C23297
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A4610E;
	Thu, 11 Apr 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBmI0q+4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C43101DA;
	Thu, 11 Apr 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863231; cv=none; b=LYo1RA+2fRSCXzGkPfElCqBn4gN4UUPmIb/+iuOgIyZ69VkRpSyG8J/OcKsm3Ib61h4QHMBgOA6WheGYQq9RlG+pYvyasZu/uagfgg8/znG1mr7woMS2NycDjsk8/vGEZ2cnSZzHLrHqBlQU73CMgijad09PqaR0IX/DO/hBRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863231; c=relaxed/simple;
	bh=ik3MMjYXoqChMChoiyUUXem6QskYR691W4CBolpgBUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f3sKnP5ax7CV34439BboqUyxcSgShMcgQFlk+xvZE8QicSte+l977DKRHncEQIB94483AN7HQxH/TiGkMt7n2+XrvT0UxcPlPURyVYZY4+FypuO1GgvrNKq5lBhk1rvlBpCrUUB8rJoN7wYvpwNbiagWE5wmc+BZ2UwTfCOniuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBmI0q+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62D55C2BBFC;
	Thu, 11 Apr 2024 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712863230;
	bh=ik3MMjYXoqChMChoiyUUXem6QskYR691W4CBolpgBUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nBmI0q+4WLAxexUxYH9aCgK6EFUKd37i9kjY4MUAJqDLxvwGlGyH0b+e01XmBLSiU
	 dDeiwnzC5/4YsxPZRJ+RtZWGVfby7hQXd6wtmHMYLfBctTk7KqLpZpYiGvPmAmibYz
	 QTWozDZlK8JatmBvoHygUzRtHnhtYyLHcoiMtV0YFRqd5HLhHdJBItiv0r598dsH0S
	 94/ns1c5E+jSrPm4WSopz78nwp/r8r1VHYdzn2+djutKjvfLOONuyMwGpcyX0aYkjM
	 MSfeGJyTYtBocNq0/KpiigBOoxke1VWjdq9SddF7qAYPXD/vqhUKSZLHQmrcH1XRTO
	 7hAy9jD1DD5fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E975C433E9;
	Thu, 11 Apr 2024 19:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] export send_recv_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171286323031.10483.1616573340590505149.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 19:20:30 +0000
References: <cover.1712813933.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1712813933.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 11 Apr 2024 13:43:10 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v5:
>  - address Martin's comments for v4 (thanks).
>  - update patch 2, use 'return err' instead of 'return -1/0'.
>  - drop patch 3 in v4.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] selftests/bpf: Add struct send_recv_arg
    https://git.kernel.org/bpf/bpf-next/c/68acca6e6f99
  - [bpf-next,v5,2/2] selftests/bpf: Export send_recv_data helper
    https://git.kernel.org/bpf/bpf-next/c/dc34e44ea6a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



