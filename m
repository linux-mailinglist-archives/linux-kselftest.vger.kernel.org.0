Return-Path: <linux-kselftest+bounces-7337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B384589AC8F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4109CB2159E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712B44C87;
	Sat,  6 Apr 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czwZj4mX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B21E86E;
	Sat,  6 Apr 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425828; cv=none; b=V1CNHCxKsjRM+SfYSEIvi02mY8LnJjFUiBNM7tIvfbcsH+E+fepe5rRerZK9e/xmPiOR31QObvkeCtcuZXPGko3hMLMC81lDeh7cjO4+sCzBz11ThbQaLazkydUHToTPyLWFb1oDWRaKhHR61u4iH9p05YdOm2Kn+Z+MZ/Pv/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425828; c=relaxed/simple;
	bh=nPx61yG6irBUszZJT+1Sik24QidUhChv+6d4aMa5TA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k2qwr1eAKBPySj1Pl8mhf/eRJJx8FBLKdVeW9ek4okeW+/CAP9668eEEHmhW2tuTZ2wtnqjQtdn4t+UzFXXNWuuXWP2nECJo/jRE/QdA/1XbMpcTgU504gOgMZ6w6xavsssvjahFWDOctnT9M14PuVVre9v6dnVdXaVqqGPnk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czwZj4mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1684EC43394;
	Sat,  6 Apr 2024 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712425828;
	bh=nPx61yG6irBUszZJT+1Sik24QidUhChv+6d4aMa5TA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czwZj4mXLOso2bIiM18AU6oGBAqFswmcLvEECP0n1UQjwR499NVGS/zulEWnbqJTU
	 xIae7l5vDtBzxubEfRZ08vsAXYtEKX/YxS5avjZ8xt/DUV3oTXI441ZnzCy1/rIpUT
	 S+C3uqlMUJO/H/nP0JqiqrbPvjw2+TRrDdFNxH71qNt5jGTPlkCCMSt7uVBN5FjDwy
	 Sc5oTrEYj97vBQVDUVBA4QfOs9yXMp4Um58YVyvKTCRfzG2nMFTPxhL58G6jEpaYVi
	 kJWm0uXuxERWWVrkX3jG773Xkl0OQLpB2Yg1z9oWSCTUr3BdHn6DQGXki5YYJ+GP3T
	 wQdOeIF1DwZZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04B38D8A106;
	Sat,  6 Apr 2024 17:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] libbpf: API to partially consume items from ringbuffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171242582801.14797.2709908703472940193.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 17:50:28 +0000
References: <20240406092005.92399-1-andrea.righi@canonical.com>
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, void@manifault.com,
 tj@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  6 Apr 2024 11:15:40 +0200 you wrote:
> Introduce ring__consume_n() and ring_buffer__consume_n() API to
> partially consume items from one (or more) ringbuffer(s).
> 
> This can be useful, for example, to consume just a single item or when
> we need to copy multiple items to a limited user-space buffer from the
> ringbuffer callback.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] libbpf: Start v1.5 development cycle
    https://git.kernel.org/bpf/bpf-next/c/5bd2ed658231
  - [v4,2/4] libbpf: ringbuf: allow to consume up to a certain amount of items
    https://git.kernel.org/bpf/bpf-next/c/13e8125a2276
  - [v4,3/4] libbpf: Add ring__consume_n / ring_buffer__consume_n
    https://git.kernel.org/bpf/bpf-next/c/4d22ea94ea33
  - [v4,4/4] selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



