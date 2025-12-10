Return-Path: <linux-kselftest+bounces-47366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF5CB297F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A603019B41
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9BF2FE566;
	Wed, 10 Dec 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9DvzSGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BD24DCF6;
	Wed, 10 Dec 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359794; cv=none; b=jXy+ByJoPHbOrUal0VSTeCwWp626ub4q46HAQpdGy+yR4tYrshSjiUjj8Pa4Li6nMdmqinnQ1yDheA5QFZb6rgsKuhlw/N5cKvvmdbI7X1TAZxkbtLZUFX63B5xSxNi9OQsvEmKC7u/NVh65Dv0+E3Csg5FV9Doeb2SHCV3xIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359794; c=relaxed/simple;
	bh=GwIJ4yJ1zxiUHNt9Pq9TbAnLoOTS8mG/kbwMh9hvj1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rbWHbvDpSIy/lHJlHK3qHpW+ebQmGTZqBVyXHloWb4iq1Yozi6B85j3Mwg+EtlsM+cL2qoKeW7GRtiSjLrUqJ54O0sQeTFocNLjLRzfBAYdSBtNSbqIIOTfVb6YenOaaFAaLsjErRL0bOVpS6lBbxhQOgt7O7LYe41FyOic9U9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9DvzSGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F21EC4CEF1;
	Wed, 10 Dec 2025 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765359794;
	bh=GwIJ4yJ1zxiUHNt9Pq9TbAnLoOTS8mG/kbwMh9hvj1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S9DvzSGmXM7c11gaoK+MwH7rsHbC7XgiWcAU4afHHES6dd1drRl/ds8+48NfQF0Vn
	 G6IXue6odx056hg9PPvzlKGhRwGV+pktG8YpTvmwIDrMTILb3uuejP9h/3PzYp6swd
	 6+klyadkL1Zoo3YiV+c/qKtq1RppOfba1ajA/qO2dMihNUaLeIrMqY2uspqgECxq5d
	 yeF+gEvf+vTawB7skL6qO1crxINIC846Zb1yNThTfHHrkosbQF/EnWgwYk54HpZpiU
	 AmcnWKpSrFpGixvVHGQ64SNAhMyHKLJL6QK/6+519P3kLAYCx0BSRD2RVC6hY5HdTv
	 KbYLdw58SuHXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A023809A18;
	Wed, 10 Dec 2025 09:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/2] bpf: fix bpf_d_path() helper prototype
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535960878.529830.9163565996803445928.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 09:40:08 +0000
References: <20251206141210.3148-1-electronlsr@gmail.com>
In-Reply-To: <20251206141210.3148-1-electronlsr@gmail.com>
To: Shuran Liu <electronlsr@gmail.com>
Cc: song@kernel.org, mattbobrowski@google.com, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 dxu@dxuuu.xyz, linux-kselftest@vger.kernel.org, shuah@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  6 Dec 2025 22:12:08 +0800 you wrote:
> Hi,
> 
> This series fixes a verifier issue with bpf_d_path() and adds a
> regression test to cover its use within a hook function.
> 
> Patch 1 updates the bpf_d_path() helper prototype so that the second
> argument is marked as MEM_WRITE. This makes it explicit to the verifier
> that the helper writes into the provided buffer.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/2] bpf: mark bpf_d_path() buffer as writeable
    https://git.kernel.org/bpf/bpf/c/ac44dcc788b9
  - [bpf,v5,2/2] selftests/bpf: add regression test for bpf_d_path()
    https://git.kernel.org/bpf/bpf/c/79e247d66088

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



