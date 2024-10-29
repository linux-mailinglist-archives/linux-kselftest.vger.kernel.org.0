Return-Path: <linux-kselftest+bounces-20993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA89B51D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697B7B23636
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F461F429A;
	Tue, 29 Oct 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUHsW5wB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB11D8DFE;
	Tue, 29 Oct 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226625; cv=none; b=flUqfqsvKz+btiXZcn4P0iVohtMFObF/m6adtfNRfimudfjtCZ3nKhucfdnp+1kX6YBGtfVeZwX1nYUlHumReaTp/o2hLqpPzU6PbrRCakAQwurO8stj+uke67ETAyGPVbcMlsNVKGPQej/304hEnp2g/Kuiqiuc8CjT/s6Dvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226625; c=relaxed/simple;
	bh=7OD5SpVuDyF2S0lAgj7xSAHmRkyZPUpW37CIzPlqv7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RrKD/nHGSuKVE4++SwsRHgUCh4AfOBPOpIPUkHw1sMOMQMJZtb8dCf2tSdmQwF05ZrzoFl/Tjm9tVbb0YZ4JkTjJ3B6cm52vngcU2BeayIuoA8gIXzvrdCPjaX7yyt8NQQW6WOkuDm3St/JMMXn60s613s3DM89hHSG2ZrO7dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUHsW5wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2837FC4CECD;
	Tue, 29 Oct 2024 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226625;
	bh=7OD5SpVuDyF2S0lAgj7xSAHmRkyZPUpW37CIzPlqv7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUHsW5wBVvEAjh+MIhSulP5qnZAHpoX2ZUF8pTUzsIT8rD06qbvCcFX0CyT4n5Lcz
	 XJWqA1JVw1FhwC6eP355RLILYFH1weVP4XzdJo/Xaogi/jRlm8xlZWx/yWO/zgRrBl
	 7C/vozH5Uk6zeOG8e7qzF5PHxPg/Z6I5j2xUwweZvvG4hOtV/01nlQqvq8qK6wr4Jy
	 B6+WYncmarCJuWVQe9NPj0NWMwXwqwTfmfcFMPVeJ4cS6hiYKC7a9dGLVJ1uHAyJU1
	 n7XgE8Je7N46u4nc3prnXSFz9FJ+9U9GaKrJZf6gGhc+nVyinV/WYXED5jZ9VXOKFj
	 R9AtMGHDQ+BeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB4380AC08;
	Tue, 29 Oct 2024 18:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: handle implicit declaration of function
 gettid in bpf_iter.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022663277.781637.10352144365178320201.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:30:32 +0000
References: <20241029074627.80289-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241029074627.80289-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 29 Oct 2024 15:46:27 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> As we can see from the title, when I compiled the selftests/bpf, I
> saw the error:
> implicit declaration of function ‘gettid’ ; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
>   skel->bss->tid = gettid();
>                    ^~~~~~
>                    getgid
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: handle implicit declaration of function gettid in bpf_iter.c
    https://git.kernel.org/bpf/bpf-next/c/42602e3a06f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



