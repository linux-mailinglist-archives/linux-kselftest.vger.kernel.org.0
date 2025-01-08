Return-Path: <linux-kselftest+bounces-24068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241AA0624A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 17:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19153A6FCE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51261204C1D;
	Wed,  8 Jan 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS6u/XKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46A201259;
	Wed,  8 Jan 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354351; cv=none; b=G+mpe3aS4w2MdIm7I6skd+UpRydW+fIZGVFCJET4ifobGKyeaWCuCyYQpXdJgiesrW+5HXsTnzGpBDPcmXBPiBIrzdkMyAn8yA8cs9FJA7zJUKi0ccXb6Ip702dMoKTrTW/a3ig2ldUXtTDIeKQK+rg3RQngXyDxfzM7sjPO4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354351; c=relaxed/simple;
	bh=yY5at5aIn3MRzmWv95JNi9saz7slbhEsQ5ueAhtaLtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGg61pCZ14IeClOFxUTMglO63gFoIQrQKg1XJEBmbQjvjVlzUNDxLDR0E5cgvqtPzzsnp7kkvtBBE/TJyKldDHuJGedTXWya8qqW6Ah3Q6OBuoRgSaKutZ2Xp60NSkzIj/V23AKAmHHA9xmdI0LR8b1Ahb05Kh3nYofkKeYovUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rS6u/XKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483FC4CED3;
	Wed,  8 Jan 2025 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736354351;
	bh=yY5at5aIn3MRzmWv95JNi9saz7slbhEsQ5ueAhtaLtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rS6u/XKovMOEglFU3aFUsrAx/jm6K5I/vHIMdaJiwAJiAttR6nlZgnhjc+hayZmxr
	 uFNCuHTrCCEN3Fl6BW5HZHCVuWQfx0Lyn3HbPVJeT/1oUWza+CMvf0ntYkcB0ngEVG
	 JGcw6ooPLHDuT65wfIcxhtskkUgND9uBHbsfQ8VlUIQMG/QNcincivc5YLROmBa16s
	 xZe5RqSK2jYWMVa40jROReW/JC+lCFjtwBY3Ia4765Rq0hVLLbqbeIdsLViiRACMep
	 KbTcG+HzUB8WKnMuy0Bpa1+wcsysPz4+U5tEY4NnLhd5r7ft2AWL/OkyQepqPN9ubY
	 JpJlMfFjvRlBg==
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
	linux-kselftest@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 0/5] arm64: Support 2024 dpISA extensions
Date: Wed,  8 Jan 2025 16:38:53 +0000
Message-Id: <173634366811.504438.8117405131587549387.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 07 Jan 2025 22:59:40 +0000, Mark Brown wrote:
> The 2024 architecture release includes a number of data processing
> extensions, mostly SVE and SME additions with a few others.  These are
> all very straightforward extensions which add instructions but no
> architectural state so only need hwcaps and exposing of the ID registers
> to KVM guests and userspace.
> 
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/5] arm64: Filter out SVE hwcaps when FEAT_SVE isn't implemented
      https://git.kernel.org/arm64/c/064737920bdb
[2/5] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601 2024-12
      https://git.kernel.org/arm64/c/47e4717eb6fc
[3/5] arm64/hwcap: Describe 2024 dpISA extensions to userspace
      https://git.kernel.org/arm64/c/819935464cb2
[4/5] KVM: arm64: Allow control of dpISA extensions in ID_AA64ISAR3_EL1
      https://git.kernel.org/arm64/c/fd22af17a458
[5/5] kselftest/arm64: Add 2024 dpISA extensions to hwcap test
      https://git.kernel.org/arm64/c/8600640d21cf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

