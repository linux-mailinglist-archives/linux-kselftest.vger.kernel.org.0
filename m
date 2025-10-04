Return-Path: <linux-kselftest+bounces-42766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C60BB8FC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0CB34E3AF6
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D027E7EC;
	Sat,  4 Oct 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXPNGSqq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74112580FF;
	Sat,  4 Oct 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594823; cv=none; b=onm06XphTnAoeKk8WBKTCHle8aUdAgVIetG4mnDi63d79aY/yu26p9k5LC8LWKt3pFYnZs7tleh+U/vZ6w5wtPEuE3ooLqi/yuQZKcEdenN+Oq4D1n5MY4HE2Fx0+weJDpZrocCwW7OHEt/jft5F4KY6oYEmnO+Z4u7A+hMUv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594823; c=relaxed/simple;
	bh=5cIMyjpJFZDmFh4SApnYgFhdjw6MeMgkX0s2Y2pgj9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CRg5XOt02mVCZhsy6kifXXNGJrUmr5FDGc+Ux5XTlr1dS3Da2dMSkw0Vovp1ZcwjSS5kYoWn0NllBsShfA4YzMeG9TNvAw4cNyU/G7Vow3EEn2ugUDp+OqcTBxIcL5PFW/NtDUCwiF/ZohparTcHxlyX4DsGsU8hxKUe8e64tAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXPNGSqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E59BC4CEF1;
	Sat,  4 Oct 2025 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759594823;
	bh=5cIMyjpJFZDmFh4SApnYgFhdjw6MeMgkX0s2Y2pgj9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nXPNGSqqUTh1UC6gMu36o+fzj/J+Dv0ZaJO4HhL7RBpsXCVqDAqh9wDvpf4PZg7dh
	 VLgMMgPJ5unJ0XYkhe9SgnTPzL+julhkaEI302XNIHKuJGL0DX0zPBb1/Xu+S/7R1h
	 W2sFLqqdygLy+xdCyDukzVnURCMBS6ETZ7Z0fDe1x9q3cyPEqPsQbZG6w7nvb3hYL2
	 vl3rSKRdxG33yBr1TD5+c92sq7kEp9ly4hPQgfKTibTSHsE6cBJqY6XaZ2gWuWlZ5Q
	 B+dzEba7teTPiJGS79GeRMW4dcyNWWjVMV7Kg4wcodjatjRdfvT3GPw8PSutXDpHQS
	 39jMl/PfvoAeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8839D0C1A;
	Sat,  4 Oct 2025 16:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf_doc: Support 1st const parameter of
 bpf_d_path()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175959481402.375745.5461564115874622361.git-patchwork-notify@kernel.org>
Date: Sat, 04 Oct 2025 16:20:14 +0000
References: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
In-Reply-To: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, rongtao@cestc.cn, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, kerneljasonxing@gmail.com, willemb@google.com,
 paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
 martin.kelly@crowdstrike.com, a.s.protopopov@gmail.com,
 mattbobrowski@google.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  4 Oct 2025 22:23:29 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Since commit 1b8abbb12128 ("bpf...d_path(): constify path argument"),
> the first parameter of the bpf_d_path() has been changed to a const
> constant. We need to modify the header file and bpf_doc.py.
> 
> The two error messages are as follows:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf_doc: Support 1st const parameter of bpf_d_path()
    https://git.kernel.org/bpf/bpf/c/de7342228b73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



