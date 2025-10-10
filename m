Return-Path: <linux-kselftest+bounces-42969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01041BCE0B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C2F4E936B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16320212557;
	Fri, 10 Oct 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/ZLFkrk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD820FA9C;
	Fri, 10 Oct 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116232; cv=none; b=Y7TzxsGwBNQ77Bk4wvUQ6tmsr0+LeHzljuYEnnD7P4U9AN0XeNBCYR9x45fw+ZW1dHQHjce2Z+m396342AsPA8VPpsrqfK4bME1+NF0k8II7uc/iQkYRkPKxlu0GgxoYKEPbgjVxbKuUgviP/DKIvO6ES0kegrWjiU7R5hC8IMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116232; c=relaxed/simple;
	bh=MTOUQJOaFYT9wm2KcVznCUdjNkH1CcP2WC4l4j/5iAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B/fG7GdQvCddoQEdRJBp69sW7kLwxXZEcSlFwmRkUG1tqbTl9Qf5s9gdgHlY2AVYVgCtxPbp2iYNaRj07rMa3zMKFafgnNW+Q/8o/4eFqnc0rpzaI2cpNZI+InQsSNSeXaea2iE2JY5AGPFG7iehOfDcU9YZk9B+j71sVJVjNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/ZLFkrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6DAC4CEF1;
	Fri, 10 Oct 2025 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760116231;
	bh=MTOUQJOaFYT9wm2KcVznCUdjNkH1CcP2WC4l4j/5iAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j/ZLFkrkyd1EZkqglwJS9yMmoWxN3tf1hF9Vl87PX83LRjHZLGmHd8hwqB+UcB1jX
	 3bUpxjWp2YhRfR1xrJh2GYM/fV30QLYWb3fXYVO95g/O9ocXWlU6aNKisBQmvbcgGs
	 UcxfNHEhDutLj7l4G0pfk/RPSZ04PjlEQLVLEHMlXLsMQgD5QOWGR9vsjyxFUBMkZW
	 LJReCLWBffImiVEM6wQ1fknsi9QGf/1vUou7AEypdzXGPLYrl/f6nwy8+7SvvSUXyd
	 90DbWC0bN/aApvznCDt9j/CbwafN4PUVBwNhgJkp7KUkX92IPFSuCJwNmbWnPp8RyL
	 0ogRKpUmNDefw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C853809A00;
	Fri, 10 Oct 2025 17:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] Add kfuncs bpf_strcasestr and
 bpf_strncasestr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176011621899.1050631.5241409064469976369.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 17:10:18 +0000
References: <tencent_98ABC9680EA2A20198904316DAE5A84AD906@qq.com>
In-Reply-To: <tencent_98ABC9680EA2A20198904316DAE5A84AD906@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: vmalik@redhat.com, ast@kernel.org, eddyz87@gmail.com, rongtao@cestc.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  9 Oct 2025 09:20:14 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add kfuncs bpf_strcasestr and bpf_strncasestr, which are extensions of
> bpf_strstr and bpf_strnstr, suitable for more scenarios.
> 
> Rong Tao (2):
>   bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
>   selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
    https://git.kernel.org/bpf/bpf-next/c/b5b693f73589
  - [bpf-next,v4,2/2] selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs
    https://git.kernel.org/bpf/bpf-next/c/eca0b643efc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



