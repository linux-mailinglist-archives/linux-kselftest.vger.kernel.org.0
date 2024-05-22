Return-Path: <linux-kselftest+bounces-10595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D28CC9E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8817C283496
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6E14C5AA;
	Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+rwHtvC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248B1487C6;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=stxfW22OsGUW5eQXn3pRk3yjJFgJmOWvs3kMV5ovG6csMrPXJ+fnlHXjbZ7mHn1hE2rjdlgxrxraUhz/+0Wnz5e2tU3cBVVND0MDmssYi70vIbQzdCYbpYbv8zXcYSmCjHfcF9l/IcB2CfTZJyhsVaw5oegXLygfVTmCQ/UUSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=TDaB1nKc+MxBvpO+Za9PJH0cIp+1S891erTFOL0RME0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RqWHCvB2kvGEgwlRJ4piX6agLm0G/Mg0q9fBU/staB0DK9fRFvznxBaNS/W7/2uscKTTwL0b4KVLYckR9E+C7hhCDDowY0TwwiYsbrBw7MsDZb25oB71Wv/xyeZD1Bj+zNSM8EedG9kqNRv0BGqVRRsFlWFnPWnN8zIGgENNhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+rwHtvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B399FC4AF08;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=TDaB1nKc+MxBvpO+Za9PJH0cIp+1S891erTFOL0RME0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D+rwHtvCdJh9jv2oAUness9TQVv+cysyk/nNly+t/EoeeHAhLstDeY5ELWWJunzbS
	 bT9X8seWwsieQw4inJczsbHHHT9Aap9ZpIj3KmsqVSAVvrwUXFnw+v7ZOQ4Ln3swYL
	 qs/pJrd4YZmqgkwi3HiTe7C/8FgDu57XnSfKI6gFkrGOrp16Qg0geYm15wMcq5FMVL
	 YAtvpxmxDMYFF3FBPpwPuCumgaZJaJwKqjllc5pC//MdgqsPZEviF00iP5WFoBriSv
	 P/fTgnI4SwXytPaA8cW5bfQqFaz43YtIBhG+ucoVqCYe4C0T4h1j+3rGasi5o+wi99
	 UwldgHMC+O42Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1C43C43619;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: selftests: Add signal handling vector tests
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190765.9409.15264560939296767259.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
In-Reply-To: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 andy.chiu@sifive.com, bjorn@kernel.org, vineetg@rivosinc.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 03 Apr 2024 16:50:29 -0700 you wrote:
> Add two tests to check vector save/restore when a signal is received
> during a vector routine. One test ensures that a value is not clobbered
> during signal handling. The other verifies that vector registers
> modified in the signal handler are properly reflected when the signal
> handling is complete.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - riscv: selftests: Add signal handling vector tests
    https://git.kernel.org/riscv/c/b2a2e892cdbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



