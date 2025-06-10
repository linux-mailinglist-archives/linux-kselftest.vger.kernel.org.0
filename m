Return-Path: <linux-kselftest+bounces-34609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC4AD3ED7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F065F3A77CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75C8239E63;
	Tue, 10 Jun 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQlxGt+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B9238C34;
	Tue, 10 Jun 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572878; cv=none; b=DWBRlQlv0KMevf4dYcrgxCYr2ilbrPppB/3l0dI9EwNgugoSQODRXz/wnZ2Y+3iF0n9GhRpJZ2w0aEYw5QPnnSdw4/SQ0/13rkJBfJs2zSiUwxQ4IEIceHq3TGBpR7GgXT5QbXVlI3s+BDJtGe5VesbJRNlP1HXWc4fMkxBHxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572878; c=relaxed/simple;
	bh=mFxvI/kVZrzum73f4JuAnsQvQ7oMH5qbvvBDTrR8D+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=agfIaX3SU6JKwRH64W9nWApxXjLe+SfygECRQCiktEIYZqIP3weJiFBJQIc31B4Mzl+L0/WvnoemdeQIH9BY17jSC7WFjC2WjBj11idNvgEvmtKdXgJ8uU/9FPtyxUcbIuscgRDQ6zrzJhsAvP4cPB1tjnATnKOK0MSfZFubaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQlxGt+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F90EC4CEED;
	Tue, 10 Jun 2025 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749572878;
	bh=mFxvI/kVZrzum73f4JuAnsQvQ7oMH5qbvvBDTrR8D+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VQlxGt+FqI3gqtXadAFcUs97IUFFcFFoQNYIS1YMiCOwSw8fB/GQHW3sWVdyKgdtn
	 A9h7kD4lIg/z42ZzV6iLq1g5+hdToOz613HUg0jc9ejXI3gOBwpLF5auyibwmxHj/y
	 6ijU1n8/v5T9xkeScsbxE9VSa7vg7ojvmOmnYKGzWYzRqF3B6N/QWFU7U9ZhZ3P+Ry
	 FugqWsvm1yFMJVeMSIHmPLExxcOeDibIVB25PcgtDmYVrINYjyzrlxleA+92+FKvID
	 lC3xC5Ryva24Rv/ABPfx4G6MBufp3gcpx0OINvtiGz2nS6pyIguwKrl2Ad4IW9v+hO
	 X8ytWgu7gICwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1A39D6540;
	Tue, 10 Jun 2025 16:28:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] kunit: qemu_configs: Add riscv32 config
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174957290850.2454024.5667943279293290236.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 16:28:28 +0000
References: <20250407-kunit-qemu-riscv32-v1-1-7b9800034a35@linutronix.de>
In-Reply-To: <20250407-kunit-qemu-riscv32-v1-1-7b9800034a35@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Shuah Khan <skhan@linuxfoundation.org>:

On Mon, 07 Apr 2025 10:17:12 +0200 you wrote:
> Add a basic config to run kunit tests on riscv32.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/testing/kunit/qemu_configs/riscv32.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> [...]

Here is the summary with links:
  - kunit: qemu_configs: Add riscv32 config
    https://git.kernel.org/riscv/c/9aa08e761b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



