Return-Path: <linux-kselftest+bounces-2892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCD82BB46
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776281C24626
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F95C8EF;
	Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGAcbI0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D823C1;
	Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD15BC43394;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705041030;
	bh=nTCKlP8E3w3r918DPScqNt0w2ZJX7f1RmOrFs37dgR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OGAcbI0VhUEpVkGS4VG3jEOGk3GqOPOr+EdWGx53BE+NE4KQR/yFHpjBuYEL9tKCw
	 RXn26BLLp8IiJIb7iuDuj6N5E4GJhTUJh0yPN8uuE9tw/3OgjDaH59M5YmL8zzC/T8
	 decxw1LmqoBxpIOEmmjyfVxkrIX6+gZI8AWGjtVcBO3I/cTN21lZSwJNMkgiWcMiim
	 2HS/etH3Txt6vLZBk+c8n6O4DuKtgeL16zHL6AEw1oKaaDGzko6j62Ry/IE0rIBT+d
	 CJO9GG4QqwYUIw+Bv/VBVzOTSID0bLM5iQwnPW9AF2umzhuD/AyFbLUCvR63YiquM8
	 lYe+SGt6KVtKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C34F1D8C96D;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] tools: selftests: riscv: Fix compiler warnings
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170504103079.17535.4478051835218795004.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 06:30:30 +0000
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
To: =?utf-8?q?Christoph_M=C3=BCllner_=3Cchristoph=2Emuellner=40vrull=2Eeu=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 aou@eecs.berkeley.edu, shuah@kernel.org, philipp.tomsich@vrull.eu,
 ajones@ventanamicro.com, evan@rivosinc.com, xiao.w.wang@intel.com,
 alexghiti@rivosinc.com, andy.chiu@sifive.com, bjorn@rivosinc.com,
 charlie@rivosinc.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 Nov 2023 19:58:16 +0100 you wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> When building the RISC-V selftests with a riscv32 compiler I ran into
> a couple of compiler warnings. While riscv32 support for these tests is
> questionable, the fixes are so trivial that it is probably best to simply
> apply them.
> 
> [...]

Here is the summary with links:
  - [1/5] tools: selftests: riscv: Fix compile warnings in hwprobe
    https://git.kernel.org/riscv/c/b91c26fdb0e8
  - [2/5] tools: selftests: riscv: Fix compile warnings in cbo
    https://git.kernel.org/riscv/c/ac7b2a02d62f
  - [3/5] tools: selftests: riscv: Add missing include for vector test
    https://git.kernel.org/riscv/c/b250c9089841
  - [4/5] tools: selftests: riscv: Fix compile warnings in vector tests
    https://git.kernel.org/riscv/c/e1baf5e68ed1
  - [5/5] tools: selftests: riscv: Fix compile warnings in mm tests
    https://git.kernel.org/riscv/c/12c16919652b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



