Return-Path: <linux-kselftest+bounces-25598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86039A26378
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 20:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B81886374
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC420F09E;
	Mon,  3 Feb 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjVatSnA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D320F098;
	Mon,  3 Feb 2025 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610122; cv=none; b=SiBxAiyd2+qYsyDy9otVKQwQ1Bqo0+Yna9FiN8GpnOVJlRiftiv44JKdPA0nUdDEj/ICLyd5eeRFeTH6ewBHk/wD2CgBRuogNzouvbXbe8nQcxUqN0f7imAKPWuyLjgGtaRqX5RdM1Uvzc1d+xFabF+9jZkdn3/81vexIUC2tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610122; c=relaxed/simple;
	bh=WCkfjIwqrL/vZTemkLUHoj349eCNsHtsoy14HaLr43w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=leYNSS44GUAbzYvDeGQ9v5TCkv97jh2NtECy55C31KuKrpcvkC4JeC2RFb3fQsEfRSdDIXgJGW5K1mfpnkrdToYOxCDNq5ECE1NJhoxfbkoy4WCKMtQXvkKAEgI5Pe9inKymGYoJf+xnhBAKxEBd8Rfh8F9GDUi3upKMI7hzuhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjVatSnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513E5C4CEE6;
	Mon,  3 Feb 2025 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738610121;
	bh=WCkfjIwqrL/vZTemkLUHoj349eCNsHtsoy14HaLr43w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JjVatSnAqwEZKnjH5gXnbCrtiH0i2lhdUz8zmvgLp7wqnjihF0v0qwDRr0oSisVeH
	 QnYeoiUDwsQP1VnXR1hU/eeLw+uvdCuYcePrQn3kCGMKMBlxYuzdgF6s0t1vI9gYTi
	 lsXDNszpS/S7b8oeMIkgUW4r251fDFxzh3guAc6BoGZ7he3m22VH7vA5wnz78TH8Wr
	 CqwIfb+cgH6Yj/3R2Tk4nZiJPwHCmsajIyHvx5KKf63Of0jkZaCFPciPubr4h2EHcC
	 KyREtOaCu4b5uqJtwLbKLrgxpv6wF1IVpa0FK68d7PtYDXrDacqWhYeuJaN2BcPlbv
	 oDPARFDpSyL/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7118C380AA67;
	Mon,  3 Feb 2025 19:15:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/6] selftests/nolibc: wire up riscv32
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173861014802.3409359.16765792882817041253.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 19:15:48 +0000
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
In-Reply-To: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, w@1wt.eu, shuah@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 falcon@tinylab.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Thomas Weißschuh <linux@weissschuh.net>:

On Sat, 21 Dec 2024 15:44:27 +0100 you wrote:
> Nolibc has support for riscv32. But the testsuite did not allow to test
> it so far. Add a test configuration.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (6):
>       tools/nolibc: add support for waitid()
>       selftests/nolibc: use waitid() over waitpid()
>       selftests/nolibc: use a pipe to in vfprintf tests
>       selftests/nolibc: skip tests for unimplemented syscalls
>       selftests/nolibc: rename riscv to riscv64
>       selftests/nolibc: add configurations for riscv32
> 
> [...]

Here is the summary with links:
  - [1/6] tools/nolibc: add support for waitid()
    https://git.kernel.org/riscv/c/7f89bc51101c
  - [2/6] selftests/nolibc: use waitid() over waitpid()
    https://git.kernel.org/riscv/c/a0bc8947ac73
  - [3/6] selftests/nolibc: use a pipe to in vfprintf tests
    https://git.kernel.org/riscv/c/4c7f09ab79b1
  - [4/6] selftests/nolibc: skip tests for unimplemented syscalls
    https://git.kernel.org/riscv/c/349afc8a52f8
  - [5/6] selftests/nolibc: rename riscv to riscv64
    https://git.kernel.org/riscv/c/a47b4b9fbaa1
  - [6/6] selftests/nolibc: add configurations for riscv32
    https://git.kernel.org/riscv/c/60fe18237f72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



