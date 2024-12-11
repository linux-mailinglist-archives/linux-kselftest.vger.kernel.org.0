Return-Path: <linux-kselftest+bounces-23229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69519ED9F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F3816667C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD51FFC73;
	Wed, 11 Dec 2024 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj+xOSei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A421FFC63;
	Wed, 11 Dec 2024 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956356; cv=none; b=HXLonHoQIQ+AS4ic3qwOf5L9a6nS+hJwiwqCNt59EiUTR7OKrruBG/2dEHZCODzUV9SZGD/7jdlMOvJU8BInh0TFuenw6bTfIlDZBfkCRCc4uWYi0KKbaKNngrwYZb71JLNdv26mExO83KqsB1ddwtvlx5oBkZeFRw9H8TgEz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956356; c=relaxed/simple;
	bh=R/piOYxV7yarX3+ioC7AI5Ae+G1cK9j4iXrTWmCNeAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JT2yseOipaU4cUtBEVOe+JdGbmMmE3qJFND3hQLyU1RKPoermEuJD49xkrLIpcZdFNJOAe+DdQXzFQDZ5cIItF6j+SjdcA/GwpBuQZv+0Tcfk2AmaocDXB4j/EtYmvHbWy4XHSoYR+Ww+6oNFWcQ9pVBmYxs6RSTR5NoHTXgU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj+xOSei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3F6C4CED2;
	Wed, 11 Dec 2024 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956356;
	bh=R/piOYxV7yarX3+ioC7AI5Ae+G1cK9j4iXrTWmCNeAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mj+xOSeioeKDbSdqGf7D5cWxQNiIVtl7IETIJJK+Mr5SkhgY3mm+EOPmB+a0z7dBz
	 qNrMjXgWwxB3u9abW369Ms9zhe+peGKYSJLjDF1Z5JyYXRXxOmnwmOlLUBLi360JCe
	 qgamfxLSrGa98pH6H28pPOBTk5HEOqo+umYvqz0XWFqlWiENDVQY9qCs05xN6cqAaK
	 oFEnHQ3vYSyZLODCiMjpOKzHE8cGbmYEl8wweOS5jfXTijJD6/+5efD23tkjMH0kIp
	 zurVJTSSW7qbW9D0LkpoIlMa+c/AAW9zBLnivUed2vUPouh+xI/CBLKJOdBxS8sIeg
	 MI2Ybwv0kGmNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B08380A965;
	Wed, 11 Dec 2024 22:32:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/4] A few fixes for RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395637198.1729195.13590127218540707757.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:51 +0000
References: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 akpm@linux-foundation.org, shuah@kernel.org, paul.walmsley@sifive.com,
 alex@ghiti.fr, charlie@rivosinc.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhang.lyra@gmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue,  8 Oct 2024 17:41:37 +0800 you wrote:
> These patches are all simple fixes with no strong dependency though,
> I hope that making them a patchset will be more convenient for merge.
> 
> The patchset are based on v6.12-rc2.
> 
> Chunyan Zhang (4):
>   riscv: Remove unused GENERATING_ASM_OFFSETS
>   riscv: Remove duplicated GET_RM
>   selftest/mm: Fix typo in virtual_address_range
>   selftests/mm: skip virtual_address_range tests on riscv
> 
> [...]

Here is the summary with links:
  - [V2,1/4] riscv: Remove unused GENERATING_ASM_OFFSETS
    (no matching commit)
  - [V2,2/4] riscv: Remove duplicated GET_RM
    (no matching commit)
  - [V2,3/4] selftest/mm: Fix typo in virtual_address_range
    https://git.kernel.org/riscv/c/e847f8cd96ae
  - [V2,4/4] selftests/mm: skip virtual_address_range tests on riscv
    https://git.kernel.org/riscv/c/4175eff0e007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



