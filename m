Return-Path: <linux-kselftest+bounces-14097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A464593A805
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5B5B21D5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FF140397;
	Tue, 23 Jul 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quQrVFET"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57718200A3;
	Tue, 23 Jul 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766038; cv=none; b=H/fl9HIiP0xc+UeE/MjglU6ilzmFUPZs/nN9HTzdvAeDzBeR5gX3GOBLe+GKetahM/9SsWEUyqK00Ok3YsBFZck1XjSgOw2v2QDoeGQTXXYvjpp+DYah+hasRLg0JuI9yq2iUm7PX7Pnle9czidwnM66Sy7FHc2wfZJdkD5x078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766038; c=relaxed/simple;
	bh=Pm/FxeMJHyA7zipiIf+6EngJ7YYrv6sM5MGMQDKnrsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u3it10MSFXm7ZfKUI7BqsaPHWGOfDmyGOJPk46By6lk+DIGX7eMW09PDM/i3FkH0QzHDN0OW1GwL5Ij0zgCR9y94vNwjNmzDehE5eA2y1m0oixns+PQBjYrZq+meF3gBsFx/1aMhsevyfwk5wt4FkDS/t+nll3WFrp3ujEu7Lf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quQrVFET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7C69C4AF0E;
	Tue, 23 Jul 2024 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721766037;
	bh=Pm/FxeMJHyA7zipiIf+6EngJ7YYrv6sM5MGMQDKnrsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=quQrVFETvvIGWm1xv3hVrSpZwKc1w8C4aP8hTovu/oAvJ0ZusIgx1hhuI4Bl+Kl6G
	 Q1UCP7mxaEQwWhevy2prtcJ75LcRdriK/Ya3x1mDmfp5DJ7xuRD/28ax4zaBDr6rWY
	 u1W3rhh4+gPjXGmflVr/PGNTvtsHUo2aLgsE51GZFHrpdcSKle1KRe+qPatzxjmPK2
	 1D1YNg+Lr4ysQS8z+xEBPcBipezMtml37hSBfnUqpvUstojwdmmz1c7grePQb9g4aM
	 BBQqyQ+MRDaKtI8yEuw7GY25SZ4yNsN4Cc+u3qSoE4iveKy0rBkd9B7wuJwaGhyqZq
	 UFhZacJ8cWaSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4DFCC43638;
	Tue, 23 Jul 2024 20:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Add missing system defines for
 mips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176603780.22487.17358161008021916921.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 20:20:37 +0000
References: <f3cfceaf5299cdd2ac0e0a36072d6ca7be23e603.1721692479.git.tony.ambardar@gmail.com>
In-Reply-To: <f3cfceaf5299cdd2ac0e0a36072d6ca7be23e603.1721692479.git.tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 22 Jul 2024 17:13:28 -0700 you wrote:
> From: Tony Ambardar <tony.ambardar@gmail.com>
> 
> Update get_sys_includes in Makefile with missing MIPS-related definitions
> to fix many, many compilation errors building selftests/bpf. The following
> added defines drive conditional logic in system headers for word-size and
> endianness selection:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Add missing system defines for mips
    https://git.kernel.org/bpf/bpf-next/c/84b4e873b10a
  - [bpf-next,v2,2/2] selftests/bpf: Fix error linking uprobe_multi on mips
    https://git.kernel.org/bpf/bpf-next/c/64d50da31564

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



