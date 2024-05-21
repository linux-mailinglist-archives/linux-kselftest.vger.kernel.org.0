Return-Path: <linux-kselftest+bounces-10483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A2F8CB370
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CA01F2262A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0C7F7CE;
	Tue, 21 May 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE+hzmlu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC427581A;
	Tue, 21 May 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315631; cv=none; b=f+sUFsR9UTnqV7O1fotPhuWJbYE1kO2k+amBrWKINL2qysHlsFMsgSQ3ljmURt0K16OLacwz13Vx90kXtzeTxafgD0BBQfnjhf3Cqt74jz9fj5nVLhuq3ZwTrqFbiFrinjnsaig73oV75u+QRYxlROCgfbvaxfG1RsH+ykkv40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315631; c=relaxed/simple;
	bh=V0j5ljEBZonNsvslN9uj+y1DlE73BubpACNNTkZISy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U1TK9fhy3WfMvhMWPRg54CAxsJjjLpM3SddO0CjbV3eyi4Zfzg/LPUQM6QvjN/PyW9X6HeoYhlLOI5SgjSLkMYZ4/Xjv27pCTm4FmbwxsYf5ETnq+PVP/diEdGIzsT+F5eL2RNffhhrS0aYPvJmllp5wLInlQ1F5ZYijesIMpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE+hzmlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67336C32782;
	Tue, 21 May 2024 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716315630;
	bh=V0j5ljEBZonNsvslN9uj+y1DlE73BubpACNNTkZISy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uE+hzmluNmfQ5YK+MpyP72+Ewoiron1kWJO6NANf8IC57Z1Bwn7UcJ3Ill9sV/vWp
	 0bGfLNUGMlWJbkZPzCihqcPnM9sxheXHkk0+kXjfy3Qq9x7NM/GJXrIFBn5S8DDp3A
	 F6q01cx9G5y+wOVf5864ZPFbZaU9G1l+c7UYanU0gicVdYTkctUQA8cfao2L/XDJjL
	 sB6JYNf1opCG7WiJ7OC9vX/NgO3AHfhvysTbWy+pml7o5xxvULxdLCeXML1nL0d/9M
	 p/lbOsHdy4l/obfNecGev5Qge40hA7nuulVwDu8NTV8rOvjwKUwLEx2JOAHzCSHhZM
	 R+aGpUIUpsK1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 536B4C54BD4;
	Tue, 21 May 2024 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix prog numbers in test_sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171631563033.25358.8200564796951629702.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 18:20:30 +0000
References: <9c10d9f974f07fcb354a43a8eca67acb2fafc587.1715926605.git.tanggeliang@kylinos.cn>
In-Reply-To: <9c10d9f974f07fcb354a43a8eca67acb2fafc587.1715926605.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 17 May 2024 14:21:46 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> bpf_prog5 and bpf_prog7 are removed from progs/test_sockmap_kern.h in
> commit d79a32129b21 ("bpf: Selftests, remove prints from sockmap tests"),
> now there are only 9 progs in it, not 11:
> 
> 	SEC("sk_skb1")
> 	int bpf_prog1(struct __sk_buff *skb)
> 	SEC("sk_skb2")
> 	int bpf_prog2(struct __sk_buff *skb)
> 	SEC("sk_skb3")
> 	int bpf_prog3(struct __sk_buff *skb)
> 	SEC("sockops")
> 	int bpf_sockmap(struct bpf_sock_ops *skops)
> 	SEC("sk_msg1")
> 	int bpf_prog4(struct sk_msg_md *msg)
> 	SEC("sk_msg2")
> 	int bpf_prog6(struct sk_msg_md *msg)
> 	SEC("sk_msg3")
> 	int bpf_prog8(struct sk_msg_md *msg)
> 	SEC("sk_msg4")
> 	int bpf_prog9(struct sk_msg_md *msg)
> 	SEC("sk_msg5")
> 	int bpf_prog10(struct sk_msg_md *msg)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix prog numbers in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/6c8d7598dfed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



