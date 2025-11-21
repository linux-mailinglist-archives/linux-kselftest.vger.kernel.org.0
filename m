Return-Path: <linux-kselftest+bounces-46284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB68C7B6AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75A3F341A84
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D3239567;
	Fri, 21 Nov 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/cBV5XB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B528747F;
	Fri, 21 Nov 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751646; cv=none; b=LdoFmdpNC18MihnlIKu47/naYMmIQ8RQhf9z+YpqmYmerB7tub+ZHY5x5IfVHfrbRozm8c49SOyTixMYCAstaCpBqMeAJFYZ5ewB7ozSt1SaY66DbQI1ztgestcFxGc+tWJ971+ISk+QNxoE64V+UtheQvGarM7vogE7ksYnYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751646; c=relaxed/simple;
	bh=247GLdq408z8KKSePiVUvux+tJlYt80LGEkLGIGrbww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzoOFgS4Dfr0AZcXEU1GEUuuK21okU8fp5pRb7x3+2s104HhhqxaYVl6CINJ5v8ZFvaYCpj2kduxsrwCqdlN8eJl8kRiZWamZGtHafGs1P1jMD4W9mBN6rOn+uhmO8jGo5kixBOVG92dK/2R3H/t+/c1awrGpTZr4ZOUSNuM8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/cBV5XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E91DC116C6;
	Fri, 21 Nov 2025 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763751646;
	bh=247GLdq408z8KKSePiVUvux+tJlYt80LGEkLGIGrbww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L/cBV5XBaRuBM3KXPN995zusUhDzeHzw9Rd5Hheh6vpOYhMuU7f3qRY/HIxNAKxxu
	 pNc9gqJSBx3FKlhoSCblFqVvVRRC1HpQriKltRiRZt3r6b6/AwtqfAbhgxp8BEm9yn
	 EPeh0gkCZUBS5gQLHo+Y1TQYaMcJkZ22xO+QysWG+PSfpR6YIV4Q0SaZtAuOoVpoo/
	 loEeuvQ9c8rIHpREZ87lf7jb+T6IPfBoUAfZJ3LZrVOn+mR+BuUGY4mzDg0Zfhmgyp
	 IhSEfuWBpKSsPjNAYALhBedE86khlE4YXlYOYcQPF2D7Eq2RAhTHJRFsXNEM+nTH9S
	 eC7IMomI0ObxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0AB3A78A5F;
	Fri, 21 Nov 2025 19:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: networking test cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176375161076.2547489.744358727920797337.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 19:00:10 +0000
References: <20251121081332.2309838-1-hoyeon.lee@suse.com>
In-Reply-To: <20251121081332.2309838-1-hoyeon.lee@suse.com>
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 21 Nov 2025 17:13:30 +0900 you wrote:
> This series finishes the sockaddr_storage migration in the networking
> selftests by removing the remaining open-coded IPv4/IPv6 wrappers
> (addr_port/tuple in cls_redirect, sa46 in select_reuseport). The tests
> now use sockaddr_storage directly. No other custom socket-address
> wrappers remain after this series, so the churn stops here and behavior
> is unchanged.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: use sockaddr_storage directly in cls_redirect test
    https://git.kernel.org/bpf/bpf-next/c/fd6ed07a05dc
  - [bpf-next,v2,2/2] selftests/bpf: use sockaddr_storage instead of sa46 in select_reuseport test
    https://git.kernel.org/bpf/bpf-next/c/db354a157732

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



