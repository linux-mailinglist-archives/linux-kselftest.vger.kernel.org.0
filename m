Return-Path: <linux-kselftest+bounces-24005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFCFA046DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FB01888C30
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921921E3784;
	Tue,  7 Jan 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWF6m7NP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DF1F5406;
	Tue,  7 Jan 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268167; cv=none; b=XLjT0/BsufRY/P44ut92Bwo4SgoMIIz/NbF9/gRgZDvC7M+lG/WIiyA8uEY/GPaGcKS5p0GPCfXYaeDOuXMM005NNu1xHeOK9dtY34qIr2+5TNTZPcvUOYCwQ4qn+EDBqt9e+QGeOX8MAQY4T+ePuDxjvV/BpBXoGTNjH8q72zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268167; c=relaxed/simple;
	bh=7m9srgpMEiXCY3EwU421KJCD1mkHAQtbO2dhdmFCRw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uf8IWaYsX3VXWvS8IaV5uxVSyKJYjKfez5JdP+k8aGtfoW6XoTujqeICliO8dlYTSIR8oByq/QphUNVfWyxLUZCDOjiiOoUN+JQxR0x6f3ikF7uOkQguYnkNsmOFzc0Shnna7OsDO24yigLOOeFuCQUXNz45fx8FiqGVTqyKRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWF6m7NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F22AC4CED6;
	Tue,  7 Jan 2025 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268167;
	bh=7m9srgpMEiXCY3EwU421KJCD1mkHAQtbO2dhdmFCRw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWF6m7NPfxEG40b4664zvEnm1bLBbYX24kosBrfehIi+uCYikhhmwIgk8aX6vTd3M
	 WX73/yYf7UoE0cTeCqfXrk4UF9hU0ugpJGt/sStNIL4JTMessrl/tX5ZXJMkQntu2s
	 dP7uYqFoQDO1Is5Q9HmqxckBWzw84D67zhOsV1gnEh7EHT/clAiHIH9jE2IhW5wdYZ
	 czkQPMsMiZ1jtXLgnhrabVozQQE/fGQ18EJxYvdPTxa817TFIT+y/bO+QKs//XuRRa
	 IL8Pzfqr1VbRW7vrYKgqIQ/jM4tsj2FH3aL+3iofcfaDbEpFg+kYGWWS3LnDEEYI/l
	 +FQTBg+LuFrNA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/9] arm64: Support 2024 dpISA extensions
Date: Tue,  7 Jan 2025 16:42:38 +0000
Message-Id: <173626298431.2741856.11908646584681839796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Dec 2024 01:02:45 +0000, Mark Brown wrote:
> The 2024 architecture release includes a number of data processing
> extensions, mostly SVE and SME additions with a few others.  These are
> all very straightforward extensions which add instructions but no
> architectural state so only need hwcaps and exposing of the ID registers
> to KVM guests and userspace.
> 
> 
> [...]

For the sysreg definitions that Marc's fantastic script is happy with,
applied to arm64 (for-next/cpufeature), thanks!

[1/9] arm64/sysreg: Update ID_AA64PFR2_EL1 to DDI0601 2024-09
      https://git.kernel.org/arm64/c/1ad9a56442a0
[2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601 2024-09
      https://git.kernel.org/arm64/c/054339beae58
[3/9] arm64/sysreg: Update ID_AA64FPFR0_EL1 to DDI0601 2024-09
      https://git.kernel.org/arm64/c/12b5ff517a19
[4/9] arm64/sysreg: Update ID_AA64ZFR0_EL1 to DDI0601 2024-09
      https://git.kernel.org/arm64/c/9a43ee864349

[6/9] arm64/sysreg: Update ID_AA64ISAR2_EL1 to DDI0601 2024-09
      https://git.kernel.org/arm64/c/d66e21d59ed0

The KVM patch needs an Ack from the maintainers and the hwcap change
probably needs checking in light of [1].

Cheers,
-- 
Will

[1] https://lore.kernel.org/r/20250106174020.1793678-1-maz@kernel.org

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

