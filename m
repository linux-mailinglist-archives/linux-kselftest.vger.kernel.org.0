Return-Path: <linux-kselftest+bounces-40113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF7B38E4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA933A3E43
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB0E313550;
	Wed, 27 Aug 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWAS25Fq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80127313526;
	Wed, 27 Aug 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333203; cv=none; b=McmLkAM04OQEYu3X5csPfpoHxKyMZ0r0vMKOVvwp/Sez5CrJxwVAtw6Y9DEhpGXbO2SURrfe6xLWBTN+RHDlDxbtRi6Y5zRvzticGahK+zDv85kczwt09qW4+xrktrJQYuePJFnTImVqDYUrPA76PcYNkvf8KfLQ+tes9wL/7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333203; c=relaxed/simple;
	bh=cy2khPxLpItODCFBrKIM3F5DgwZlLBfRmoxGnVBSQFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YP4ZrXSrEPtNrNPxkeZXQ3hR+ygbZNAQhN3+D2HzqZOMF5LGigbhKOmMMkSGkyC4l5robhmBfWVkmrjAd3YY3kKnP4GV3z4e4pkj5KqWCnu6N1ge+hIwt2cBYOWUu4/fiVyoUl63Kcc92ZsbckPave7OAwcbEnbDy6eCCIFN0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWAS25Fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9638C4CEF6;
	Wed, 27 Aug 2025 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756333202;
	bh=cy2khPxLpItODCFBrKIM3F5DgwZlLBfRmoxGnVBSQFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kWAS25FqyZcgmY1/znTdZBEulGD0XvAHkeO4MeCoLe4iZqjvbz81SDRxgt0laT47y
	 l/Ax05tswEmCrdsNNO2lAzbYydRdFtwyOBWYAnHwNkPW+us57gZRs1JSZ8atihwRE5
	 TR6M7moZTwkxr3CElf8OT4VsxE9jUaQUa40B+K7QOIIIvK4XN3nKNSGJLC63gh4lRT
	 nrRMGjwWvkKWsDY+h6iUdhZieDXLF2JdEURQe3Ij2+BNTqWR146692soMtiweUH9nX
	 vUFLifOiazPg2meGbhHo8fxbYaReEa/gxu0iDNt59TxRs31xnxnytd2tcWEwznQA39
	 YqER4K5lG22cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2F383BF76;
	Wed, 27 Aug 2025 22:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: Fix typos and grammar in test sources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175633320899.857353.7740828137657688567.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 22:20:08 +0000
References: <20250826125746.17983-1-slopixelz@gmail.com>
In-Reply-To: <20250826125746.17983-1-slopixelz@gmail.com>
To: Shubham Sharma <slopixelz@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 Aug 2025 18:27:46 +0530 you wrote:
> From: Shubham Sharma <slopixelz@gmail.com>
> 
> Fixed the spelling typo and checked other BPF selftests sources for similar typos.
> 
> Follow-up to patch series 990629
> 
> v2:Instead of sending multiple tiny patches for minor comment fixes, combined them into a single pass across the affected files.
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Fix typos and grammar in test sources
    https://git.kernel.org/bpf/bpf-next/c/d3abefe89740

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



