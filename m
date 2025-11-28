Return-Path: <linux-kselftest+bounces-46713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E7C9349E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 00:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA79834C43B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BB2EC553;
	Fri, 28 Nov 2025 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjqkA7f7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4627F75F;
	Fri, 28 Nov 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372195; cv=none; b=eCFFgIAjIBEVyPVbJeZ1iUZ79WOuQGnKjm/LULb9/zqB5uyPLRubYJiUKT0C75dqwMo0JVbon+p3bjM386DORJt1sXaNyvevZzGtJQzpTJSpTKXdPjUQzfEAfRhGITHbWNapCxienDyqemJsI3VupmnWCmkDgGIJ8c2dr7vEtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372195; c=relaxed/simple;
	bh=EWG9B/QBn90ZYMiLnocIOGd6QQ7MoyxmqrYTWBqwdEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PccNSroiH/d2YXNvd7nmvTzXoUdl70dwil+/CUyVcaDWghPztqJhTXewVLal6BR8D4ugZRoOkpU6tg+HglMF4TZpHO9oWePqT4g0ZkizjJ9WMDjlEMZJ3HXsr46vTqJ3cezYTES2q0uEMp4f6Jkl7H3fwOhrFvqUobt43wagF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjqkA7f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22F5C4CEF1;
	Fri, 28 Nov 2025 23:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764372194;
	bh=EWG9B/QBn90ZYMiLnocIOGd6QQ7MoyxmqrYTWBqwdEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DjqkA7f709oN9kKN+E8Ublq6/kDsYQMoUEdDSZa6x6YNaLoCfG3unQourFsBy89FY
	 qoKCTdXZSaa4seyggEgruKrVxTabyS6aaXMQyqzdTHSltofnPsfA+xF7vMnuVc/FVu
	 wxT6aSu5bHsiGhcXqZICldU108LFXR6lnCONCvX4PxatKQfPchzQqmPB/eeH1RvT6j
	 AHVrRLkgJRaIsCHmqX5ttgK2zqK+EttBdIGySJSEnM0KXoVbPCpr9ZqhGJ0fT6rcLu
	 Qnc678qIVhkeC6iljGoIgNCmNpPwyHgg+Q/2PW7Y7rB0MnThxIRfKHHoybj33XdhpQ
	 sHzZSs828fumg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6267380692B;
	Fri, 28 Nov 2025 23:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] tools: bpf: remove runqslower tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176437201628.828244.882759182927174054.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 23:20:16 +0000
References: <20251126093821.373291-1-hoyeon.lee@suse.com>
In-Reply-To: <20251126093821.373291-1-hoyeon.lee@suse.com>
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, acme@redhat.com, charlie@rivosinc.com,
 tony.ambardar@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 26 Nov 2025 18:38:11 +0900 you wrote:
> runqslower was added in commit 9c01546d26d2 "tools/bpf: Add runqslower
> tool to tools/bpf" as a BCC port to showcase early BPF CO-RE + libbpf
> workflows. runqslower continues to live in BCC (libbpf-tools), so there
> is no need to keep building and maintaining it.
> 
> Drop tools/bpf/runqslower and remove all build hooks in tools/bpf and
> selftests accordingly.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] tools: bpf: remove runqslower tool
    https://git.kernel.org/bpf/bpf-next/c/bd5bdd200c9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



