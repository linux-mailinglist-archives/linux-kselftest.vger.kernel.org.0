Return-Path: <linux-kselftest+bounces-7440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED65D89CF1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0A52844F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C32770C;
	Tue,  9 Apr 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2C7WKU+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30D6FCC;
	Tue,  9 Apr 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620828; cv=none; b=it1Voyur1AuYvzD+EloZszzsV9un2VkLECgbf0jrXr/VwUn7YjaBKvdv5C2VBo06FnA51XNxbnzKArZCBn2wjYdKbdM8IhLzTcbls8n7IY7oIkWoEWDglTzEBLf6dzPMsUgmlGyts7a/J9og2A2lLNi9r+RddmgatY1U6hEnUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620828; c=relaxed/simple;
	bh=mtYqmMazK3B5/swMxdH4wpMinpuhi6LpgjrcrjQY750=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ru1zLxiH0r50C4bWEl2RIlq/f7paNwZvynr8P0ruJ4AlWoQlmZqyzwRBd2PqqsN9yfAbst1a0DpDoBG/JHop/8TcGv4XVWrqGxSMwUjF3jUyhw7Za8XVYFjoFDwzDT/5EgiDr8QkTz5SJjPK9zXj1nnfPeVKcVb3XkVh+HW63bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2C7WKU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5A51C433F1;
	Tue,  9 Apr 2024 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712620827;
	bh=mtYqmMazK3B5/swMxdH4wpMinpuhi6LpgjrcrjQY750=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W2C7WKU+/Ttw4qo2lt2Q7WHqjOOSQaixBaBXAc06LdVxTd0tuKFVHb/5CeG3ejrJz
	 F+IpKFy7Rn+4tcwYHJjUDJARVdvhev7J8nWFpRXyCQh9ctQ+ctkjFOho59VcNmaw70
	 /mOUhhh5spxDcjQeEFcuqu301f0DEzyUp9/XNJBWcRGMHsTEOh4VOE/esX3XVQM5ur
	 xtCXSAtdgYJqbchGuZAJNTJGCKDNdKU1t4gaK6tb97dulgEAmljeWHXnGoa2PH+wDg
	 PvgJznckLmQrqdj5MvfEE4ZcCxdLGlGv2Iq7G4pCn94OmQeWi64YljMwJ5VqSQQStk
	 BNdFBsbbAFlLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4862C54BD3;
	Tue,  9 Apr 2024 00:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/bpf: eliminate warning of
 get_cgroup_id_from_path()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171262082766.22195.12036150932807338138.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 00:00:27 +0000
References: <20240406144613.4434-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240406144613.4434-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat,  6 Apr 2024 22:46:13 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The output goes like this if I make samples/bpf:
> ...warning: no previous prototype for ‘get_cgroup_id_from_path’...
> 
> Make this function static could solve the warning problem since
> no one outside of the file calls it.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/bpf: eliminate warning of get_cgroup_id_from_path()
    https://git.kernel.org/bpf/bpf-next/c/bb761fcb8217

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



