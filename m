Return-Path: <linux-kselftest+bounces-1695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A096A80F451
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC0F1F21330
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43417D882;
	Tue, 12 Dec 2023 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quWq7NFA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF37B3D9;
	Tue, 12 Dec 2023 17:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955A4C433C9;
	Tue, 12 Dec 2023 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401677;
	bh=NjEv9qEr/oYVM+wHeeNDWCRv65KfnIhhpX8bgvPrnAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quWq7NFAtXTBXufHjGAQPZuAXrlWxIJ4Rn3ITaI13bZesQeatjNFR7raywE3BfBn7
	 Pitan+DMqBcCL58QZwCgz3Lh/6jidDw46o+sSHdw2XNETPNFha4R9ntZwxgldpxfvd
	 ThUunTfPwVTXTNhOAsJ9W9/N6z4PG1M3beyPew54n2U5AZrjlyDMmXs2L7Toa+G5kj
	 jyTED6ks2sSuPvCG+6dEMiYHKakPG+EvMGSSnpSABMjq1R1ugTLDeB0n3JnFi9LuSS
	 cUuBfE0LIKezRTEQ8AUTFsdnAhfeVJygPdgHWAaZ27aCb30nqIqsyQPesJMXA3vzFc
	 vN+/g3oSMdIBg==
From: Will Deacon <will@kernel.org>
To: anshuman.khandual@arm.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	James Clark <james.clark@arm.com>,
	suzuki.poulose@arm.com,
	linux-perf-users@vger.kernel.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Zaid Al-Bassam <zalbassam@google.com>,
	linux-kselftest@vger.kernel.org,
	Zenghui Yu <yuzenghui@huawei.com>,
	namhyung@gmail.com,
	Jonathan Corbet <corbet@lwn.net>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	James Morse <james.morse@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	kvm@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 00/11] arm64: perf: Add support for event counting threshold
Date: Tue, 12 Dec 2023 17:20:53 +0000
Message-Id: <170237438420.1648654.4727808470285684911.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231211161331.1277825-1-james.clark@arm.com>
References: <20231211161331.1277825-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 11 Dec 2023 16:13:12 +0000, James Clark wrote:
> Changes since v6:
> 
>   * Remove inlines from arm_pmuv3.c
>   * Use format attribute mechanism from SPE
>   * Re-arrange attributes so that threshold comes last and can
>     potentially be extended
>   * Emit an error if the max threshold is exceeded rather than clamping
>   * Convert all register fields to GENMASK
> 
> [...]

Thanks for respinning, James. This looks really good now.

Applied to will (for-next/perf), thanks!

[01/11] arm: perf: Remove inlines from arm_pmuv3.c
        https://git.kernel.org/will/c/9343c790e6de
[02/11] arm: perf/kvm: Use GENMASK for ARMV8_PMU_PMCR_N
        https://git.kernel.org/will/c/62e1f212e5fe
[03/11] arm: perf: Use GENMASK for PMMIR fields
        https://git.kernel.org/will/c/2f6a00f30600
[04/11] arm: perf: Convert remaining fields to use GENMASK
        https://git.kernel.org/will/c/d30f09b6d7de
[05/11] arm64: perf: Include threshold control fields in PMEVTYPER mask
        https://git.kernel.org/will/c/3115ee021bfb
[06/11] arm: pmu: Share user ABI format mechanism with SPE
        https://git.kernel.org/will/c/f6da86969a3c
[07/11] perf/arm_dmc620: Remove duplicate format attribute #defines
        https://git.kernel.org/will/c/a5f4ca68f348
[08/11] KVM: selftests: aarch64: Update tools copy of arm_pmuv3.h
        https://git.kernel.org/will/c/c7b98bf0fc79
[09/11] arm: pmu: Move error message and -EOPNOTSUPP to individual PMUs
        https://git.kernel.org/will/c/186c91aaf549
[10/11] arm64: perf: Add support for event counting threshold
        https://git.kernel.org/will/c/816c26754447
[11/11] Documentation: arm64: Document the PMU event counting threshold feature
        https://git.kernel.org/will/c/bd690638e2c2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

