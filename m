Return-Path: <linux-kselftest+bounces-26703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB725A36BE1
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C353B2CA0
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD41624C4;
	Sat, 15 Feb 2025 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPn5rvJ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07511158851;
	Sat, 15 Feb 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592004; cv=none; b=TNieF6UM9yVghEa259he/uNfW9dCr86xAX+0qJn7BoaDMK+hlXbJ277j61NkNJaEdkx4PJ4HK6bxVZEcHyy98uf7x6SPsim/Quz1wuhe0dH8OxcFWphAxPu6B22vmKteC3R4MCglnFp2/kOoDvROod1XcO0wIzmLMojrt8NIEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592004; c=relaxed/simple;
	bh=hCnQDWhtMnKn+5oJ5xMo1GoVUBOmPZ3ucfXjsqfaR+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3TdSuO7AZsgfMsFU1IU7KXFCR5VJm/chFU8EDEcdZdqjMw7DM40uFbUZVJVUA1rS2Aihbs/rtlv6j96sxW/bfuyhFWfVYKbinOgvIva+DQ1q+0jwyYWHyjoCr+Y6uVD7Hx2Car8UEOMaq9hSxMIFfg+MmKMHxF0WDgZfq2bLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPn5rvJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D92BC4CEE4;
	Sat, 15 Feb 2025 04:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739592003;
	bh=hCnQDWhtMnKn+5oJ5xMo1GoVUBOmPZ3ucfXjsqfaR+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TPn5rvJ0QB4Ij9Lw2+Xhf13M4XsqJ/asNxGXJWKQ82VF/E+BhFY5YAhO5ZIgDTih5
	 DJFqorUV+KH3qx04JSA5Q1m1qtXwXPZjPO0uTynpjtRKrIXqHPEi5GMdLdrK0MXXRb
	 kJ2pZ4DRIaucCT22lCC4oqFryNNG5c6kYMh2l5k0HhtFHq6vvm8q4ZiRl9r8uhcWib
	 8AZvkJdysVWVf8g3+jhJykkK/+zjsbSjbhPxBHx+TwxOSNeJelH3p4gq677a/rSEyA
	 Lg5BtnqBH3LDcnASvmzWdtb/Qij8s9v1iyZDrPps0whDbCMklbEHfCx3W7zJnqfMVh
	 j45pVk2vn/JrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34CA7380CEE9;
	Sat, 15 Feb 2025 04:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix array bounds error with may_goto and
 add selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173959203283.2185212.17551794379760846853.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 04:00:32 +0000
References: <20250214091823.46042-1-mrpre@163.com>
In-Reply-To: <20250214091823.46042-1-mrpre@163.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, linux-kselftest@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Feb 2025 17:18:20 +0800 you wrote:
> Syzbot caught an array out-of-bounds bug [1]. It turns out that when the
> BPF program runs through do_misc_fixups(), it allocates an extra 8 bytes
> on the call stack, which eventually causes stack_depth to exceed 512.
> 
> I was able to reproduce this issue probabilistically by enabling
> CONFIG_UBSAN=y and disabling CONFIG_BPF_JIT_ALWAYS_ON with the selfttest
> I provide in second patch(although it doesn't happen every time - I didn't
> dig deeper into why UBSAN behaves this way).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Fix array bounds error with may_goto
    https://git.kernel.org/bpf/bpf-next/c/6ebc5030e0c5
  - [bpf-next,v3,2/3] selftests/bpf: Introduce __load_if_JITed annotation for tests
    https://git.kernel.org/bpf/bpf-next/c/b38c72ab808c
  - [bpf-next,v3,3/3] selftests/bpf: Add selftest for may_goto
    https://git.kernel.org/bpf/bpf-next/c/72266ee83fed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



