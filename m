Return-Path: <linux-kselftest+bounces-6065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E38756BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 20:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEEE1C2100D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035013667C;
	Thu,  7 Mar 2024 19:06:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AF136675;
	Thu,  7 Mar 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838390; cv=none; b=XaMB+x2QD21bXoJ/5qH69oABF4HNfT+Opy21nTdmVlzB453AVyz325O/vN0LSOq7DTS1ep6Cv9SndERgSVleabqev4VXs0kngdS0nkVyehVjOZW45uxHjbgnrkxcUrCz891/lKKruRhmyFn/a6sB7bRb8Guryt6xSpGANgmNz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838390; c=relaxed/simple;
	bh=/aVycPzQGuUIJyeAnfbKezN/GZbL5wsOs/DnCoWd/cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BV4Nujf2MzFzicz3mzItniqk+n/syhB7XfVN+i1n2qDAThdauOpwmGTFulvho8qtKOHvbW3ccpSr0vHf7vtxgJRM++0kJNUR23DNfAOWZCwBRxCa+3qNHji7PnEqx3PaoY41ebFc9PsW91CUbUB+rRu0UBzCr4H1Fd7ceYSwPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ED0C433F1;
	Thu,  7 Mar 2024 19:06:27 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>,
	kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/9] arm64: Support for 2023 DPISA extensions
Date: Thu,  7 Mar 2024 19:06:25 +0000
Message-Id: <170983837968.1825324.3417487578888141721.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
References: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Mar 2024 23:14:45 +0000, Mark Brown wrote:
> This series enables support for the data processing extensions in the
> newly released 2023 architecture, this is mainly support for 8 bit
> floating point formats.  Most of the extensions only introduce new
> instructions and therefore only require hwcaps but there is a new EL0
> visible control register FPMR used to control the 8 bit floating point
> formats, we need to manage traps for this and context switch it.
> 
> [...]

Applied to arm64 (for-next/dpisa), thanks!

[1/9] arm64/cpufeature: Hook new identification registers up to cpufeature
      https://git.kernel.org/arm64/c/cc9f69a3dad3
[2/9] arm64/fpsimd: Enable host kernel access to FPMR
      https://git.kernel.org/arm64/c/b6c0b424cb91
[3/9] arm64/fpsimd: Support FEAT_FPMR
      https://git.kernel.org/arm64/c/203f2b95a882
[4/9] arm64/signal: Add FPMR signal handling
      https://git.kernel.org/arm64/c/8c46def44409
[5/9] arm64/ptrace: Expose FPMR via ptrace
      https://git.kernel.org/arm64/c/4035c22ef7d4
[6/9] arm64/hwcap: Define hwcaps for 2023 DPISA features
      https://git.kernel.org/arm64/c/c1932cac7902
[7/9] kselftest/arm64: Handle FPMR context in generic signal frame parser
      https://git.kernel.org/arm64/c/f4dcccdda586
[8/9] kselftest/arm64: Add basic FPMR test
      https://git.kernel.org/arm64/c/7bcebadda045
[9/9] kselftest/arm64: Add 2023 DPISA hwcap test coverage
      https://git.kernel.org/arm64/c/44d10c27bd75

-- 
Catalin


