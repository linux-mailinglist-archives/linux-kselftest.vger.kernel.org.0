Return-Path: <linux-kselftest+bounces-41885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D62B86130
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029193B19E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789E311C01;
	Thu, 18 Sep 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzT016lF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774523D7E9;
	Thu, 18 Sep 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213803; cv=none; b=ME1aJSEFqvHpI/fJpEUX8BOWLSOH4WXXi+OLCRyVCJ01oIDmmq14cjJGgE+ouGhxecJ9cTlCo9U/BXzoAZ8had3xm5hf2vG6zZEcKjhjDHUC+e8r78DOLlczwnFG8qYukvyqof/js/5cNj9PTXJ73j5n0i5W836IqbO1jl9g2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213803; c=relaxed/simple;
	bh=Hj8pTaQfwTaM3cwtIdwgHTA6BIscCoAxZ6jBPJ5Yk74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huCVqA3UYUOMfjq6OCYuQpKx2bLMTEqEBGdqK6BEoeLvn0zugFnNQx88H/SkarUX8nRNvglAodKZfD7PwLCuM9447v56MrNB8/UdLJpdJh5G33+p/jS+nk0YHTriTfGyZ4sGw+NQtZqg7kOnAvUZsKGdQzaKNqUVOLA+h3xIeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzT016lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6CFC4CEE7;
	Thu, 18 Sep 2025 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758213802;
	bh=Hj8pTaQfwTaM3cwtIdwgHTA6BIscCoAxZ6jBPJ5Yk74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzT016lF5TBlLBjwTa1uAzTe90ShZG7KFJ6tHUwl7fSx12bW3Q49zKhwKI/si1F+s
	 ya6CzK2u3C7M/JOHvbr9Gb7gt0CEA8z9OBnixmEn18IVy3CV3AcOSQv/FiSxc69CnQ
	 r5800M9Ftmptj7H9fGsY2N6J8jeOLE2Vq6dYjW2701+5BRroHCtPDATKRxsb/98WFm
	 QZn0qsl4YerQczKD5J6N66xBLuJ6WfS1VWRutm8mWYUeJUaiif2IDwgJMePXX7mfSN
	 H5Pb30xsUFzbUsN082PTDxLKM7KeH7rGbNeZ5JPwI2qIJPrG/QBMQpIYpzYm7Zf1PM
	 /wGgTZZ7a4Kyg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Spickett <david.spickett@arm.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Luis Machado <luis.machado.foss@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64/sme: Support disabling streaming mode via ptrace on SME only systems
Date: Thu, 18 Sep 2025 17:43:06 +0100
Message-Id: <175819643529.3451422.10117622348778381735.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
References: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 19:29:02 +0100, Mark Brown wrote:
> Currently it is not possible to disable streaming mode via ptrace on SME
> only systems, the interface for doing this is to write via NT_ARM_SVE but
> such writes will be rejected on a system without SVE support. Enable this
> functionality by allowing userspace to write SVE_PT_REGS_FPSIMD format data
> via NT_ARM_SVE with the vector length set to 0 on SME only systems. Such
> writes currently error since we require that a vector length is specified
> which should minimise the risk that existing software is relying on current
> behaviour.
> 
> [...]

Applied first two selftests to arm64 (for-next/selftests), thanks!

[1/5] kselftest/arm64: Verify that we reject out of bounds VLs in sve-ptrace
      https://git.kernel.org/arm64/c/dd68f51febbd
[2/5] kselftest/arm64: Check that unsupported regsets fail in sve-ptrace
      https://git.kernel.org/arm64/c/09b5febf8426

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

