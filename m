Return-Path: <linux-kselftest+bounces-46420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F6C844C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 10:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C88913454E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7B2EC081;
	Tue, 25 Nov 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ3TY/wN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4562E9ECA;
	Tue, 25 Nov 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064251; cv=none; b=dJS4311iMw/EAmdPC6O6VrgFCfJroxKObFDldx/AC2SYQ8K2e7kxuHGrW+Np1t0b2Net3HjXYuvVfs7gWikp5gqU5om7/oae9E5p9MbMci93BtxQas7Jp+dw0/6xiK8HY54rgUmPDUc30hV2l4kk27e4/l//7PnkU6Lkt9tVtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064251; c=relaxed/simple;
	bh=ZpZ7Gn9GLkQYXGHbd52ia/vfx8XpDdhT9cEzlscmjek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cv764hFvM78TUQQng1W0/m7tsZggBJVlkhF/6i0l5dtm8n6UvlRjHMCrFffIgX3fR8UiNG1yICK/NTVG+kZD/74Er+wfUbN8c8D+zas55lFNUAtaUaxR2XeV0G45QlAn4Bo+zQSCltzKesrUuCN/H9its8/X2DihMVF/roeJZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ3TY/wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F13BC4CEF1;
	Tue, 25 Nov 2025 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764064251;
	bh=ZpZ7Gn9GLkQYXGHbd52ia/vfx8XpDdhT9cEzlscmjek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YQ3TY/wNjqodeZHs7cE5lAYdvVZ23Fk0Y3iJU+nqRkQWEwN1q2k5fFzjwd8uM381Z
	 t/Kit8WUH7idwZdNOPhAI1oZUmyQBAVSrWq2dwIiZDn6okk2bd+6GbU+zmlPhlhva0
	 21EikZ0Rgdiz8jg8xj2uWPn0SqzW8Uy4TXOVHuEMf3QNiXxThyJ9Evwr6e5nUik/eV
	 sG5HT5RmS98jBKN8HeKtVb6SL0sq6jCkUNEOpMhiv8jufsbqDQpqWlf9dDfxlZ+vjM
	 Pwicdetk7YIZ3BF4huugAu/dM1N1xA/Qz44hIwEXzwQ2gRKja2j7C5deCLw0L59icH
	 hFVqBmVLRX5jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0513A8D142;
	Tue, 25 Nov 2025 09:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] Add Zilsd/Zclsd support in hwprobe and KVM
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176406421375.657800.9856634072172881689.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 09:50:13 +0000
References: <20250826162939.1494021-1-pincheng.plct@isrc.iscas.ac.cn>
In-Reply-To: <20250826162939.1494021-1-pincheng.plct@isrc.iscas.ac.cn>
To: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, anup@brainfault.org,
 pbonzini@redhat.com, shuah@kernel.org, cyan.yang@sifive.com,
 cleger@rivosinc.com, charlie@rivosinc.com, cuiyunhui@bytedance.com,
 samuel.holland@sifive.com, namcao@linutronix.de, jesse@rivosinc.com,
 inochiama@gmail.com, yongxuan.wang@sifive.com, ajones@ventanamicro.com,
 parri.andrea@gmail.com, mikisabate@gmail.com, yikming2222@gmail.com,
 thomas.weissschuh@linutronix.de, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 27 Aug 2025 00:29:34 +0800 you wrote:
> Hi all,
> 
> This is v2 of a short series that adds kernel support for the ratified
> Zilsd (Load/Store pair) and Zclsd (Compressed Load/Store pair) RISC-V
> ISA extensions. The series enables kernel-side exposure so user-space
> (for example glibc) can detect and use these extensions via hwprobe and
> runtime checks.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] dt-bindings: riscv: add Zilsd and Zclsd extension descriptions
    https://git.kernel.org/riscv/c/aeec6a5ddd8a
  - [v2,2/5] riscv: add ISA extension parsing for Zilsd and Zclsd
    https://git.kernel.org/riscv/c/ac3b03f8a4eb
  - [v2,3/5] riscv: hwprobe: export Zilsd and Zclsd ISA extensions
    https://git.kernel.org/riscv/c/668a3bd57466
  - [v2,4/5] riscv: KVM: allow Zilsd and Zclsd extensions for Guest/VM
    (no matching commit)
  - [v2,5/5] KVM: riscv: selftests: add Zilsd and Zclsd extension to get-reg-list test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



