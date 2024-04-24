Return-Path: <linux-kselftest+bounces-8755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F28AFEFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD8E2827F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 03:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4684FAA;
	Wed, 24 Apr 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAAZf4e6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47B339A1;
	Wed, 24 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927631; cv=none; b=FeF3uhTMW6mI6ARbqaixQb2k5OMMJmgMvVBTsRMcvesgCdZMQBOKIETH24OIEwGccuRbQLC41bw0vm5XldZqFj0IZ2vQhRe10LWPKTsbpTy3m2dJjGbjIqL4m2EgKGujRgxpL686p8bsR+6bMF6ahHHox5Ukp1HkZ9/4bSxE7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927631; c=relaxed/simple;
	bh=8rT5BVLD6BpkZoKLX9pm9QkII/smHHTXv5XytLPOi7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKLV+7nvRnUh5nSoqLbviWGqVXsgeamvq/yBe86uG0Q+eRJbNPNI+IuRIyi93oYPoEH/69kaFUkBoJARnb3ZKF0WzEks3mfiiiWQt4Go5Qytt4xojMR1kDfBsbbyPIBKKTjQLjVjUzr2I4TKOgXsc7cJchpvU9i9p9aR5+shT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAAZf4e6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4511C2BD10;
	Wed, 24 Apr 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713927630;
	bh=8rT5BVLD6BpkZoKLX9pm9QkII/smHHTXv5XytLPOi7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NAAZf4e6T8adqA3mGtYWh2Jscrt29HoxmHuo+dcyYrTkFPnKp4G6fcTObwochlOGJ
	 PYkrRMLOI9YTgmS5xYvRxVxTDYXuvZ3WVQOSTXBBKihQ2Iun+bv1j4avpQo04hT6Op
	 AgeWGW9BvvwYr2U9ebFA7noYBKRadq3Blrn5vOYEu5Xh6kigZGnMSgw3j6Km05rmKB
	 yzO+NOXuje+qo3HGBF0JrrDiL8CvmC+szp54iwFMm3d6OUgFK5ayhoFZVO/+oRnSxs
	 Bs/99g6wxjhr4sRcHuVW6homY1ODOfpcM9aybexVMI3+MR8Rs0WkFHXNAeKdC2CYEx
	 k9XsTywXnwh8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9869AC43140;
	Wed, 24 Apr 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/16] Introduce bpf_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171392763062.9786.7335664075984702369.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 03:00:30 +0000
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 20 Apr 2024 11:09:00 +0200 you wrote:
> This is a followup of sleepable bpf_timer[0].
> 
> When discussing sleepable bpf_timer, it was thought that we should give
> a try to bpf_wq, as the 2 APIs are similar but distinct enough to
> justify a new one.
> 
> So here it is.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/16] bpf: make timer data struct more generic
    https://git.kernel.org/bpf/bpf-next/c/be2749beff62
  - [bpf-next,v2,02/16] bpf: replace bpf_timer_init with a generic helper
    https://git.kernel.org/bpf/bpf-next/c/56b4a177ae63
  - [bpf-next,v2,03/16] bpf: replace bpf_timer_set_callback with a generic helper
    https://git.kernel.org/bpf/bpf-next/c/073f11b02643
  - [bpf-next,v2,04/16] bpf: replace bpf_timer_cancel_and_free with a generic helper
    https://git.kernel.org/bpf/bpf-next/c/fc22d9495f0b
  - [bpf-next,v2,05/16] bpf: add support for bpf_wq user type
    https://git.kernel.org/bpf/bpf-next/c/d56b63cf0c0f
  - [bpf-next,v2,06/16] tools: sync include/uapi/linux/bpf.h
    https://git.kernel.org/bpf/bpf-next/c/f1d0a2fbb008
  - [bpf-next,v2,07/16] bpf: verifier: bail out if the argument is not a map
    https://git.kernel.org/bpf/bpf-next/c/ad2c03e691be
  - [bpf-next,v2,08/16] bpf: add support for KF_ARG_PTR_TO_WORKQUEUE
    https://git.kernel.org/bpf/bpf-next/c/d940c9b94d7e
  - [bpf-next,v2,09/16] bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps
    https://git.kernel.org/bpf/bpf-next/c/246331e3f1ea
  - [bpf-next,v2,10/16] selftests/bpf: add bpf_wq tests
    https://git.kernel.org/bpf/bpf-next/c/b4abee7c1ae3
  - [bpf-next,v2,11/16] bpf: wq: add bpf_wq_init
    https://git.kernel.org/bpf/bpf-next/c/eb48f6cd41a0
  - [bpf-next,v2,12/16] selftests/bpf: wq: add bpf_wq_init() checks
    https://git.kernel.org/bpf/bpf-next/c/e3d9eac99afd
  - [bpf-next,v2,13/16] bpf: wq: add bpf_wq_set_callback_impl
    https://git.kernel.org/bpf/bpf-next/c/81f1d7a583fa
  - [bpf-next,v2,14/16] selftests/bpf: add checks for bpf_wq_set_callback()
    https://git.kernel.org/bpf/bpf-next/c/01b7b1c5f3cc
  - [bpf-next,v2,15/16] bpf: add bpf_wq_start
    https://git.kernel.org/bpf/bpf-next/c/8e83da9732d9
  - [bpf-next,v2,16/16] selftests/bpf: wq: add bpf_wq_start() checks
    https://git.kernel.org/bpf/bpf-next/c/8290dba51910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



