Return-Path: <linux-kselftest+bounces-25425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15674A22EBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997E4163ACF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA1D1E7C2B;
	Thu, 30 Jan 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC/e0Ajn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279C1E573F;
	Thu, 30 Jan 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246212; cv=none; b=R0fYEl2fUQ7QM6jtoNZiy6klnI5FvE28TDl0kHxzqJz3lP6KUbEdVF2yxGsNFVUisPcX0SOeCD0SiS5yS6BvAKiQq/wP4zsgLdB+lkBeAWYQSXw7lCG5eKyxNXfc0RHOzWtm/w4xPthMoCV8DTvf6PvsXBNQ5XOOJ1rlNs2tgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246212; c=relaxed/simple;
	bh=kXMtPvKQuZHL9xcm4hq3kkVSDGMX5Os3i3OJFM8PSIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uGfJyE28+Az1QJTRVbgpmt53kKGeCbPNZpS5m/oB7OtNb112ul0oiSzADb3eCC8Hkvd9vjKKHkXhCoBAUBK49B5SXhswHwiZ8f7FD2g7AokR44FNxgqglmdkBgr/4UyJlfIDGI82SEcNdbh0h8STIoUZNS/u5MtoAijLglB80MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC/e0Ajn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C027C4CED2;
	Thu, 30 Jan 2025 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738246212;
	bh=kXMtPvKQuZHL9xcm4hq3kkVSDGMX5Os3i3OJFM8PSIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FC/e0Ajnb6yigUYE+68RWjMmE2hdLowFH7ZjlxuOc49+h3pHnNVQIv92HciGk/veu
	 l1jqLQaZr2jUbt8dQGfDtinIahleHwrW28sIiDWSodyN11u5+4iFEsHoLTP3r4pbWk
	 Db3LcSsWuclPXhWwqvS+dlaEHsD8NPXMYUYitlRZJtnFFFh7Er53eerdaLXx9jRc3R
	 HNgtRa+x/qFi+HCxmQHcJn/jH1KwsWku+nTy3G41+eSbMYj5ydbcK51rCieBsL7Uzs
	 EphNuo4965I9C7qr/gTH7RETVZsRASw04DpP6gu2lNstqCuy5XmXqCkncugX4n91pY
	 j0A3fEdKN4KZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7136E380AA66;
	Thu, 30 Jan 2025 14:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v11 00/14] riscv: Add support for xtheadvector
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173824623824.971083.4395426797923401446.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 14:10:38 +0000
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, conor@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, jszhang@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, samuel.holland@sifive.com,
 corbet@lwn.net, shuah@kernel.org, guoren@kernel.org, evan@rivosinc.com,
 jrtc27@jrtc27.com, ajones@ventanamicro.com, cyy@cyyself.name,
 andybnac@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, conor.dooley@microchip.com, heiko@sntech.de

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 13 Nov 2024 18:21:06 -0800 you wrote:
> xtheadvector is a custom extension that is based upon riscv vector
> version 0.7.1 [1]. All of the vector routines have been modified to
> support this alternative vector version based upon whether xtheadvector
> was determined to be supported at boot.
> 
> vlenb is not supported on the existing xtheadvector hardware, so a
> devicetree property thead,vlenb is added to provide the vlenb to Linux.
> 
> [...]

Here is the summary with links:
  - [v11,01/14] dt-bindings: riscv: Add xtheadvector ISA extension description
    https://git.kernel.org/riscv/c/e576b7cb8183
  - [v11,02/14] dt-bindings: cpus: add a thead vlen register length property
    https://git.kernel.org/riscv/c/bf6279b38a4b
  - [v11,03/14] riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
    https://git.kernel.org/riscv/c/ce1daeeba600
  - [v11,04/14] riscv: Add thead and xtheadvector as a vendor extension
    https://git.kernel.org/riscv/c/cddd63869f92
  - [v11,05/14] riscv: vector: Use vlenb from DT for thead
    https://git.kernel.org/riscv/c/377be47f90e4
  - [v11,06/14] RISC-V: define the elements of the VCSR vector CSR
    https://git.kernel.org/riscv/c/66f197785d51
  - [v11,07/14] riscv: csr: Add CSR encodings for CSR_VXRM/CSR_VXSAT
    https://git.kernel.org/riscv/c/b9a931442451
  - [v11,08/14] riscv: Add xtheadvector instruction definitions
    https://git.kernel.org/riscv/c/01e3313e34d0
  - [v11,09/14] riscv: vector: Support xtheadvector save/restore
    https://git.kernel.org/riscv/c/d863910eabaf
  - [v11,10/14] riscv: hwprobe: Add thead vendor extension probing
    https://git.kernel.org/riscv/c/a5ea53da65c5
  - [v11,11/14] riscv: hwprobe: Document thead vendor extensions and xtheadvector extension
    https://git.kernel.org/riscv/c/7fa00fd6ff53
  - [v11,12/14] selftests: riscv: Fix vector tests
    https://git.kernel.org/riscv/c/57d7713af93e
  - [v11,13/14] selftests: riscv: Support xtheadvector in vector tests
    https://git.kernel.org/riscv/c/c384c5d4a2ae
  - [v11,14/14] riscv: Add ghostwrite vulnerability
    https://git.kernel.org/riscv/c/4bf97069239b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



