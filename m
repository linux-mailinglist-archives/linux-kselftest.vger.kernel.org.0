Return-Path: <linux-kselftest+bounces-38646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C3B1FC22
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804F73B3C26
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 21:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE022222D7;
	Sun, 10 Aug 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eytNvycD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FF221FC7;
	Sun, 10 Aug 2025 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860326; cv=none; b=o5GdulVSeKlY8k/RIKbPwQEdlgG91oKA2wiw8jZjZo67y7Z4SBsc1QnB8vjAk+BC70uiCOgfVwv/W4wWH6msClUAV/GY8nPyWBH/K6FY3RnLtTrqCzqzp+9iOu8bd/ww91jMc6FYPDav8/MsnmQ/JIwejFi53vJB8JhdeFvwbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860326; c=relaxed/simple;
	bh=SVf33tSFtUiZDgX+LrTamKLmL2FlBV4IaY9JDQKAi/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SMkuDH9FidLKcLyNMeiyD9TU6Cv12+0adp92TnFA8DLYihl3G1L4GG5XFqiRt7CdHxsuacGNcDUphYZx7jivQLWUGd3DYfZvGKGYx5JdeUkSZpUuzC1lte85D0rwuo9CS+k7mGBGNalQH8U27SAHP1o6GUnje1WhkcMNGfKk6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eytNvycD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBDDC4CEF9;
	Sun, 10 Aug 2025 21:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860325;
	bh=SVf33tSFtUiZDgX+LrTamKLmL2FlBV4IaY9JDQKAi/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eytNvycDFo0d67cAAYPzayW0cuXtbv6CCYMFcz31wwKSUGEg4vcLRaWUbtXUBY77o
	 KRbxDnPxCuluOskwQYE7SCi0VL8PxJcfp+HG6rthf67NM7k9v6O6F21qrLTZdxoyjK
	 Q3x6nYrWbG06R83g8S0m9CjDT4VKE8Qkd5KcoBKDlehN/4gn13lBbnPF2BF+vsdQFS
	 Dx3OiByWhkUeit4cxohz4pAAYxFK2iT73XjIfLEJtW39ndG2Yq/OnYtCycIixA8u6k
	 E5vV4pQhiGkhGYBvZ6mR6c+K12gZo/MmkxucoZ0jDD+s6358tbxGkByhEHChMgR735
	 Xcksopc6bHZpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD839D0C2B;
	Sun, 10 Aug 2025 21:12:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 00/14] riscv: add SBI FWFT misaligned exception
 delegation
 support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486033798.1221929.4288222571177001101.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:17 +0000
References: <20250523101932.1594077-1-cleger@rivosinc.com>
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org,
 shuah@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 samuel.holland@sifive.com, ajones@ventanamicro.com, debug@rivosinc.com,
 charlie@rivosinc.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Fri, 23 May 2025 12:19:17 +0200 you wrote:
> The SBI Firmware Feature extension allows the S-mode to request some
> specific features (either hardware or software) to be enabled. This
> series uses this extension to request misaligned access exception
> delegation to S-mode in order to let the kernel handle it. It also adds
> support for the KVM FWFT SBI extension based on the misaligned access
> handling infrastructure.
> 
> [...]

Here is the summary with links:
  - [v8,01/14] riscv: sbi: add Firmware Feature (FWFT) SBI extensions definitions
    (no matching commit)
  - [v8,02/14] riscv: sbi: remove useless parenthesis
    (no matching commit)
  - [v8,03/14] riscv: sbi: add new SBI error mappings
    (no matching commit)
  - [v8,04/14] riscv: sbi: add FWFT extension interface
    (no matching commit)
  - [v8,05/14] riscv: sbi: add SBI FWFT extension calls
    (no matching commit)
  - [v8,06/14] riscv: misaligned: request misaligned exception from SBI
    (no matching commit)
  - [v8,07/14] riscv: misaligned: use on_each_cpu() for scalar misaligned access probing
    (no matching commit)
  - [v8,08/14] riscv: misaligned: declare misaligned_access_speed under CONFIG_RISCV_MISALIGNED
    (no matching commit)
  - [v8,09/14] riscv: misaligned: move emulated access uniformity check in a function
    (no matching commit)
  - [v8,10/14] riscv: misaligned: add a function to check misalign trap delegability
    (no matching commit)
  - [v8,11/14] RISC-V: KVM: add SBI extension init()/deinit() functions
    https://git.kernel.org/riscv/c/cf648c400fd2
  - [v8,12/14] RISC-V: KVM: add SBI extension reset callback
    (no matching commit)
  - [v8,13/14] RISC-V: KVM: add support for FWFT SBI extension
    (no matching commit)
  - [v8,14/14] RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



