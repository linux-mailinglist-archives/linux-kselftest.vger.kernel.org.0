Return-Path: <linux-kselftest+bounces-45977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD8FC6E876
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65B4F4FBBF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50435FF6C;
	Wed, 19 Nov 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO44VA4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233EB35FF62;
	Wed, 19 Nov 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555451; cv=none; b=TeLdRIyrkwa2v5CLwaOhvUMx5Hyod8EKwNTBVtO+vs6ooLM7Ey0uVXBPi0W0qreJZJmGQJms7t4/+qjDPIWxAkNfZpQ5HAmgC2cAw56HCsVWl5c/9z88MqvNaBOmakipHipkNTmAHUNynhxUmwAR6qFTd4uTDcidQK0hDb5dlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555451; c=relaxed/simple;
	bh=mMRAx6ZJOONKImYBrNRIu3H4Zn/hB85+rterq9QpQ8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q0Yub11izLzjovmaeFc0l8DmDXn2ZGs8UymN9zHvLb9N+lk432PL082saUgdSoUZCrsmxPxHFTlvebjtyVVp5rzV/g9VaG6qduw3z3mbClwDAeqG6mc2EC7DTF4g3qWmpeaQDAhp8Fr1wBxOLedgc+XNc0cRsEk2kZIhy9vzlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO44VA4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CDDC19425;
	Wed, 19 Nov 2025 12:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763555450;
	bh=mMRAx6ZJOONKImYBrNRIu3H4Zn/hB85+rterq9QpQ8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XO44VA4MS43Ut+JjCb+Yu+HPzJBJetzrAmCyurSY2nYyRtbDLu7XLmHmpE+OC8POg
	 uqI5cGg7pJMRyqkTX+R+ZVKYi4Sp4jlsGVYj2j+nPOeqlINtjBUO0BrLVxJWvmRtts
	 uILMmJOT6Zz7Jn16LRTYn6a1xnoHgUz5H4m8pGTIffrENWw9jM4BPewgA8kJt9UR01
	 Zoa+dhVcTsnVcKVfmQvXGmLAjkRY7OGdHHDv77CvCHz4lqtdDIibJ7TF3e9iG6RC2q
	 za+T3vfASWLdS3yEBjjQj8CH8PTd3KN0ZXR6CzqJe75rGohr9CGHAREnNoARrWdxvU
	 ZfnaPV+YV1Wow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34233380AA40;
	Wed, 19 Nov 2025 12:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/10] riscv: Add Zalasr ISA extension support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176355541475.758643.7685467502830246491.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 12:30:14 +0000
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
 anup@brainfault.org, atish.patra@linux.dev, pbonzini@redhat.com,
 shuah@kernel.org, parri.andrea@gmail.com, ajones@ventanamicro.com,
 brs@rivosinc.com, guoren@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, apw@canonical.com, joe@perches.com,
 lukas.bulwahn@gmail.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Mon, 20 Oct 2025 12:20:46 +0800 you wrote:
> This patch adds support for the Zalasr ISA extension, which supplies the
> real load acquire/store release instructions.
> 
> The specification can be found here:
> https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
> 
> This patch seires has been tested with ltp on Qemu with Brensan's zalasr
> support patch[1].
> 
> [...]

Here is the summary with links:
  - [v4,01/10] riscv: Add ISA extension parsing for Zalasr
    https://git.kernel.org/riscv/c/0597b9c8627e
  - [v4,02/10] dt-bindings: riscv: Add Zalasr ISA extension description
    https://git.kernel.org/riscv/c/6e2a0ff70abe
  - [v4,03/10] riscv: hwprobe: Export Zalasr extension
    https://git.kernel.org/riscv/c/d5e20628a882
  - [v4,04/10] riscv: Introduce Zalasr instructions
    https://git.kernel.org/riscv/c/c4139ea6717c
  - [v4,05/10] riscv: Apply Zalasr to smp_load_acquire/smp_store_release
    (no matching commit)
  - [v4,06/10] riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
    (no matching commit)
  - [v4,07/10] riscv: Apply acquire/release semantics to arch_atomic operations
    (no matching commit)
  - [v4,08/10] riscv: Remove arch specific __atomic_acquire/release_fence
    (no matching commit)
  - [v4,09/10] RISC-V: KVM: Allow Zalasr extensions for Guest/VM
    (no matching commit)
  - [v4,10/10] RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



