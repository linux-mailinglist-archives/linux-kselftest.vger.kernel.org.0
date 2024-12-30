Return-Path: <linux-kselftest+bounces-23790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C29FEB83
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 00:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075E43A2776
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2024 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBADB19DF9A;
	Mon, 30 Dec 2024 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co1/W6wV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7719DF6A;
	Mon, 30 Dec 2024 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735599613; cv=none; b=uKs6aTUyjnDL+YPVkehFszaauwcvLL78eU6rmqpiS6oLLMin1mgsL8Wav1V3l1OIOWQGVCkQSE2mb+3PMCmUG8TLUkWNy8gQDE1Q0mGcHp1hkdPEAD16gDRhQ7yvQDZO6ZIV9AEtJMBW1uKoBEOExvfgERyv6AlAGPADWJjBQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735599613; c=relaxed/simple;
	bh=Qfv6q8kfmWZZSW4yl4LxcgTWYKz7vU9+VmcxFYIQa4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W+ITSNGCkO08pY4p3WEVkoqo26XvAIA3EqWySGeV0l9jirkqWP+ALgA9mxyJSL7SYa9uQ6OpmnFbJpm8ik1nyaV46YctLaP2mmlh+0sbM5nd+sWO3s/PydUL4OrbdpvUilGj7JD5uppt9lEc6yYThFV7TaGy1e5dZnR9ZYFXtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co1/W6wV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED810C4CED0;
	Mon, 30 Dec 2024 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735599613;
	bh=Qfv6q8kfmWZZSW4yl4LxcgTWYKz7vU9+VmcxFYIQa4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=co1/W6wVOEN9qSLT26QPDXansvhrBV5WhdpSwRAtycqlcuD0s0tJNTtkevvBjW+FJ
	 +4cRlXMmFSztGVITcoxyptNAzsW26H0GyYM8tx3e7gVQ5sxbBFiXkI8aypU6fG8R2X
	 LYrXWBlrFWiOQqJ06Ch2ghepjFDCNTBkUYfMI39yUmVn4aC7WWycQO+dCV3bxer7KE
	 8KHgbWYVmfWd3QIlGDRrDKfhwNiCuwW/MXBgHDAq7luo2mZw94OkbTajD5U1pu3JeW
	 uKgzzvHWBfb726FE0gJHgV8WIjIFalt88YOLz/Y7Uf+naVN0uo1cpEqp4bxDN+qavP
	 NmH93aHsro/tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB8380A964;
	Mon, 30 Dec 2024 23:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf, verifier: Improve precision of BPF_MUL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173559963278.1460841.10756955150962399155.git-patchwork-notify@kernel.org>
Date: Mon, 30 Dec 2024 23:00:32 +0000
References: <20241218032337.12214-1-m.shachnai@gmail.com>
In-Reply-To: <20241218032337.12214-1-m.shachnai@gmail.com>
To: Matan Shachnai <m.shachnai@gmail.com>
Cc: ast@kernel.org, harishankar.vishwanathan@gmail.com,
 srinivas.narayana@rutgers.edu, santosh.nagarakatte@rutgers.edu,
 m.shachnai@rutgers.edu, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 cupertino.miranda@oracle.com, menglong8.dong@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Dec 2024 22:23:33 -0500 you wrote:
> Hi All,
> 
> This patch-set aims to improve precision of BPF_MUL and add testcases
> to illustrate precision gains using signed and unsigned bounds.
> 
> Thanks for taking the time to review and for all the feedback!
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf, verifier: Improve precision of BPF_MUL
    https://git.kernel.org/bpf/bpf-next/c/9aa0ebde0014
  - [bpf-next,v4,2/2] selftests/bpf: Add testcases for BPF_MUL
    https://git.kernel.org/bpf/bpf-next/c/75137d9ebe9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



