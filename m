Return-Path: <linux-kselftest+bounces-25961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85AA2BAA7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB9918876A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 05:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE82E1A38E1;
	Fri,  7 Feb 2025 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+PjX85A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E391422A8;
	Fri,  7 Feb 2025 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738906231; cv=none; b=agtSQElQ6ghSOTclR2KjdepejdY9s/Z6ymGbFbkklo7Ohhs0/Gdt2dlL37cQ6ez0OISfnT6Kr5TDb/yYkb9l3xtBsUYlzDQtzHZh1MGIzE5daaIb8jCU6Eum2f0aTDnziY0iO8TSWwXr6MzMbzflLyty1J+fRIEmGAGIVy5cFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738906231; c=relaxed/simple;
	bh=swTLf8iHqBMj6Dabpwzxm4y9Y+UlAtfIqAha8sqD4GE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bRudAqpCm9V7BBI+UeOwWpIM3ruZy4kTsn9EGTbMS1cwkuVVJO94pqtMrQ2qzvPJsFEL6CZAY8IXT0Rd6PKdMrDcJHCiV5lnrCGH511bxpCa5XJrRrgUh+rp92H63de0TkIOhbkxJMnBSJLFRlNZfstGkzZhKmiI+a1Ahpy1rnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+PjX85A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BFFC4CED1;
	Fri,  7 Feb 2025 05:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738906231;
	bh=swTLf8iHqBMj6Dabpwzxm4y9Y+UlAtfIqAha8sqD4GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+PjX85AIUm2PXjlzxnzJPjeWY7+r+mIpAkKT26MsfuiV7iSckiHumUgmEDn/7TDY
	 CbocYM/MlMxfONE8cq2kvdVuTCJ5dQGM11uDMORF39jw8TAPCZfzDHt6OG3Fd0tuwr
	 cNn1ngexJT2fE/38VSwZn2yHTnASxpmbRnIQCP1MkesEEglhruvOMxGymTsEr3hib6
	 lmnRPJWIaregockhXFP7tj9zusNsaeX2OCZY7CEF5VKZBh2nb0UauowUzt4ajiaOWW
	 bp47mHf8pc2zpQUiNl8M0kCZWrir00B5XAbI25EuKoKayr8HERX4he72qVmXkMSZjt
	 dyqcb0ZdyDEug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34EA4380AAF2;
	Fri,  7 Feb 2025 05:31:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: correct the check of join cgroup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173890625888.2105045.7240771783124555447.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 05:30:58 +0000
References: <20250204051154.57655-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250204051154.57655-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  4 Feb 2025 13:11:54 +0800 you wrote:
> Use ASSERT_OK_FD to check the return value of join cgroup,
> or else this test will pass even if the fd < 0. ASSERT_OK_FD
> can print the error message to the console.
> 
> Link: https://lore.kernel.org/all/6d62bd77-6733-40c7-b240-a1aeff55566c@linux.dev/
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: correct the check of join cgroup
    https://git.kernel.org/bpf/bpf-next/c/003be25ab99c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



