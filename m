Return-Path: <linux-kselftest+bounces-12875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9D91AE82
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 19:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7A91F224CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309D19AA53;
	Thu, 27 Jun 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIYJcPU9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EBF19AA4B;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510656; cv=none; b=TOB56bUYTvTazjWFAkdp/95aTqAMkPGA4FwgSUX19/AacbYBrGCWmIDMJ3z7xpUIg01pjxcfKhuv3L8UpXBsb6rkJXSdInlxXCq+cJ7twTnTej4Z9UEDq3Ggw4HZYNqH6lS79bvca5KkGqWswhZ1Nlshrdce94yhzMlM8dcOd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510656; c=relaxed/simple;
	bh=gOn5wCkQoaz4jCvDxmaxx4Rr4gNeBfnRgSNDr4QSj8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=crIdX34rEGjhI68hNnRpmvhM1Zl7I6fzNJB1U1OvTklJr8ejRX5CyaJr2rzphzaMXu70emK5ggW6mAaezCn29sBB60rKNhuBdraZ8Y1Ewq0clqFrWsUlUApH1T7wp00MUvsdlUdBsiAKlo2PEdTLiqcWvI3VwpOEHrYC32GWwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIYJcPU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B55CC2BD10;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=gOn5wCkQoaz4jCvDxmaxx4Rr4gNeBfnRgSNDr4QSj8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IIYJcPU97Y+PRAS/+YU/5ccbncoZV1uCz57lAqil+V1ijTPByVKGTQFMqmdIktpow
	 mgUXuwPMGB0hxBKAEtQcmsJRe0kgoK0G4CxAqoS4UnqOc+s7QEYIHK2kt44seSLDnZ
	 Gh7dIhAcmLSHgaptDShKUVITRiz/vLPn0qdyGC0znkbWHWytZ7ePFuuj2lU7mHIg0F
	 X0+78irzHOMSVd8cMwuP/4tg088CmEcvevRxvvPs6wzwg65cMt+rL64nQ95qH5Tx37
	 GB4x63Y5pxbKsGJf0RlDoEvN+uEIHgUB3AusDoc3p6pdooB0KA3nJdCVz0InBkVSKv
	 iBdVjZUdtNUDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FC7EC43445;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 00/16] Add support for a few Zc* extensions,
 Zcmop and Zimop
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065638.6762.17635047001193885957.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240619113529.676940-1-cleger@rivosinc.com>
In-Reply-To: <20240619113529.676940-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, anup@brainfault.org, shuah@kernel.org,
 atishp@atishpatra.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 19 Jun 2024 13:35:10 +0200 you wrote:
> Add support for (yet again) more RVA23U64 missing extensions. Add
> support for Zimop, Zcmop, Zca, Zcf, Zcd and Zcb extensions ISA string
> parsing, hwprobe and kvm support. Zce, Zcmt and Zcmp extensions have
> been left out since they target microcontrollers/embedded CPUs and are
> not needed by RVA23U64.
> 
> Since Zc* extensions states that C implies Zca, Zcf (if F and RV32), Zcd
> (if D), this series modifies the way ISA string is parsed and now does
> it in two phases. First one parses the string and the second one
> validates it for the final ISA description.
> 
> [...]

Here is the summary with links:
  - [v7,01/16] dt-bindings: riscv: add Zimop ISA extension description
    https://git.kernel.org/riscv/c/a57b68bc315c
  - [v7,02/16] riscv: add ISA extension parsing for Zimop
    https://git.kernel.org/riscv/c/2467c2104f1f
  - [v7,03/16] riscv: hwprobe: export Zimop ISA extension
    https://git.kernel.org/riscv/c/36f8960de887
  - [v7,04/16] RISC-V: KVM: Allow Zimop extension for Guest/VM
    https://git.kernel.org/riscv/c/fb2a3d63efef
  - [v7,05/16] KVM: riscv: selftests: Add Zimop extension to get-reg-list test
    https://git.kernel.org/riscv/c/ca5446406914
  - [v7,06/16] dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension description
    https://git.kernel.org/riscv/c/e9f9946cad7b
  - [v7,07/16] riscv: add ISA extensions validation callback
    https://git.kernel.org/riscv/c/625034abd52a
  - [v7,08/16] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
    https://git.kernel.org/riscv/c/ba4cd855839d
  - [v7,09/16] riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
    https://git.kernel.org/riscv/c/0ad70db5eb21
  - [v7,10/16] RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
    https://git.kernel.org/riscv/c/d964e8f2ae65
  - [v7,11/16] KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
    https://git.kernel.org/riscv/c/d27c34a73514
  - [v7,12/16] dt-bindings: riscv: add Zcmop ISA extension description
    https://git.kernel.org/riscv/c/700556a73bc7
  - [v7,13/16] riscv: add ISA extension parsing for Zcmop
    https://git.kernel.org/riscv/c/164d644059cf
  - [v7,14/16] riscv: hwprobe: export Zcmop ISA extension
    https://git.kernel.org/riscv/c/fc078ea317cc
  - [v7,15/16] RISC-V: KVM: Allow Zcmop extension for Guest/VM
    https://git.kernel.org/riscv/c/29cf9b803e6e
  - [v7,16/16] KVM: riscv: selftests: Add Zcmop extension to get-reg-list test
    https://git.kernel.org/riscv/c/e212d92d1a86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



