Return-Path: <linux-kselftest+bounces-37496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B5DB08B33
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CCE586312
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F82DA77A;
	Thu, 17 Jul 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGKvmMCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D522DC338;
	Thu, 17 Jul 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749188; cv=none; b=Z9C1OCxCHQfckHFqmjPgm8N5fSz2riKdVdQYKMh4JOfzvErV4GC+Vx/sJZ6c6b6uVYxD6zsnSHOgfnsKfjwwhYtqY5tR6A/3WvNFcm5Ng9Ra7pkPJChKx78X/+6D/656oa2CenffDI/yR3fR/f8GjsADpBlWb2/UnXKxOK2nPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749188; c=relaxed/simple;
	bh=gx5/G6zzlqK9prZpiz6/I2jYvB1WZ4q5jmJ/0wHnyEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZo57tQBJYrEZydbsJeje9hcO5DuERvmD/9p32gBZAd1UUK++4jAdEUWfkuy4t9IhLRX7nat0swK3dyn6/L4w52PN1J7dvMaBbZICDelrCYpswIINlLt+KEXU+M/P+iLloc2fh6YCx6Km3njBHetzterBcECuEe8t8ydd9B8SQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGKvmMCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD73C4CEED;
	Thu, 17 Jul 2025 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752749187;
	bh=gx5/G6zzlqK9prZpiz6/I2jYvB1WZ4q5jmJ/0wHnyEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGKvmMCmUZ+GzcSVQRFWy3zlaCTPGCGzmUiN5x7qOgZ3wcIXrPY0e5Dy/lXX2PsBO
	 W+JhlTJSfnxllqQyhZ2r4UXNZ9k8pOslCZBD0sRg3fimb95vLgHTNvhtVkpuhHGDot
	 d4mFNt/KtHtHN/zN+vinIJD23AKyMCdRYYfwTnwQuodhnf0jJ1O6yu6SeURhDdh9mF
	 1e4MC9lT7FZ69d6EKGbh/TK6NM7vR5xtYfqRFPF+EyLDXv4x7ah+iZxvyu/DJwFPzu
	 1ZbxaBeYtmX/dinV4MTPeduJYna467wXWy5/AI4BmfQhCF4dqKtAv+uAoh33i/MO98
	 KEHclzV/CGZTg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm4: Provide local defines for AT_HWCAP3
Date: Thu, 17 Jul 2025 11:46:16 +0100
Message-Id: <175274687562.736017.4541105049784210584.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715-arm64-selftest-bodge-hwcap3-v1-1-541b54bc43bb@kernel.org>
References: <20250715-arm64-selftest-bodge-hwcap3-v1-1-541b54bc43bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 22:11:41 +0100, Mark Brown wrote:
> Some build environments for the selftests are not picking up the newly
> added AT_HWCAP3 when using the libc headers, even with headers_install
> (which we require already for the arm64 selftests).  As a quick fix add
> local definitions of the constant to tools use it, while auxvec.h is
> installed with some toolchains it needs some persuasion to get picked up.
> 
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm4: Provide local defines for AT_HWCAP3
      https://git.kernel.org/arm64/c/54c605124da6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

