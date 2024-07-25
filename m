Return-Path: <linux-kselftest+bounces-14245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE8F93C925
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 21:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C41F20EE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EEE55898;
	Thu, 25 Jul 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irKo7k6z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79A51C5A;
	Thu, 25 Jul 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937035; cv=none; b=bDVkK750gxXalUBFFwe/dDogFsa0WONmOhAwHczyUklQE2wo/6QqbXyQeinAgXjD4ZpPfaWzSDp4SsOpIrEp+CXhN5F/g3RZw6CTc9PPiL8mT5Da+STw8oawfrxFE/YHJoOQ/fyBXIJmv9hWI7DxTPPv8p/eFe2cKPStiHOURSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937035; c=relaxed/simple;
	bh=SC385zA43vEEWRGraMPRF3060o/t7+pwsu2R5ly/0Ec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GgSChfBqmaxvEhCKAgAeF2w8R+dYC/jwDLmVzrDHFn40/WZEmLA/+ByVjjdU1NsOrxIlMF4jo2d+K6TK7kDxyA07gKG3O9KXeg/IQEjV810B/sW3toiwc2BNVXJF02nOQTVpkO1gM3Ysr1cYGxcnYcvoyVC04Ra33QQWGpx2HDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irKo7k6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD813C32786;
	Thu, 25 Jul 2024 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721937034;
	bh=SC385zA43vEEWRGraMPRF3060o/t7+pwsu2R5ly/0Ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=irKo7k6z7AgzHa/o2ValWsPiHXR/IlGqjx5C6sDQURozMr9nAbL46GdbDgv7uLZVz
	 f5+ugp4iROMdTMc8HntgLIC2YS3soW1Sc0TE4nQ2xCqhbHJD5gv78BwDlmq6apHuNV
	 E0oUZrya0OQX/DxyuGPSpraQf6oEPS9hx0vbe+GHoMbvUcOXqiZEYHAVYmuOVta79L
	 HqdZO/M/SXqX8wFn2YeYL/UzZLvdkh80uiBIUvtPlBBRNmjq+9qiHRDuqugkvRnSTC
	 r1jJyXREBFP9MwC2THdbB03zf/cJ8OY+iU1d5vk94SVOCJGWAfBMibiN+7EfXmNkTR
	 HynRkDibSDUvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9145C4332D;
	Thu, 25 Jul 2024 19:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 00/13] riscv: Add support for xtheadvector
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172193703481.21409.18294756229042401950.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 19:50:34 +0000
References: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, conor@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, jszhang@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, samuel.holland@sifive.com,
 corbet@lwn.net, shuah@kernel.org, guoren@kernel.org, evan@rivosinc.com,
 andy.chiu@sifive.com, jrtc27@jrtc27.com, ajones@ventanamicro.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, conor.dooley@microchip.com, heiko@sntech.de

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 24 Jul 2024 21:16:17 -0700 you wrote:
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
  - [v8,01/13] dt-bindings: riscv: Add xtheadvector ISA extension description
    https://git.kernel.org/riscv/c/8a0fe092f06f
  - [v8,02/13] dt-bindings: cpus: add a thead vlen register length property
    https://git.kernel.org/riscv/c/7c527250e3fc
  - [v8,03/13] riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
    https://git.kernel.org/riscv/c/7d174ad15cc5
  - [v8,04/13] riscv: Add thead and xtheadvector as a vendor extension
    https://git.kernel.org/riscv/c/db44682eb864
  - [v8,05/13] riscv: vector: Use vlenb from DT for thead
    https://git.kernel.org/riscv/c/513baedd87c2
  - [v8,06/13] RISC-V: define the elements of the VCSR vector CSR
    https://git.kernel.org/riscv/c/8d141ea2e107
  - [v8,07/13] riscv: csr: Add CSR encodings for CSR_VXRM/CSR_VXSAT
    https://git.kernel.org/riscv/c/91c52b2d902e
  - [v8,08/13] riscv: Add xtheadvector instruction definitions
    https://git.kernel.org/riscv/c/a3f2adbddf80
  - [v8,09/13] riscv: vector: Support xtheadvector save/restore
    https://git.kernel.org/riscv/c/efc8d713bc11
  - [v8,10/13] riscv: hwprobe: Add thead vendor extension probing
    https://git.kernel.org/riscv/c/75a4b53cbc9d
  - [v8,11/13] riscv: hwprobe: Document thead vendor extensions and xtheadvector extension
    https://git.kernel.org/riscv/c/8302596e9d0c
  - [v8,12/13] selftests: riscv: Fix vector tests
    https://git.kernel.org/riscv/c/a1d098335922
  - [v8,13/13] selftests: riscv: Support xtheadvector in vector tests
    https://git.kernel.org/riscv/c/d81701d2ba9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



