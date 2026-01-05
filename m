Return-Path: <linux-kselftest+bounces-48234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8CECF5EAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 23:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7F1308F021
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB603126A3;
	Mon,  5 Jan 2026 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STjBEwGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99E311954;
	Mon,  5 Jan 2026 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653923; cv=none; b=U8mqplnZ9XZTIvgDYPPYdrIX7VG2jMfzmvmInqq8Qh96xcdHryTrMXHWOYcX/n+EQHm1TPUFQqv5ncSL/+nTOSoeKPKwgPFj+8Moj9Qczm6rPrR11l86RY72XuZgYD17Ec+MvebUA/CPIsWks7ORlPDVCssssTblBv70IRCkIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653923; c=relaxed/simple;
	bh=Y62g07QGScncAFopehfwNZgRYDrOnDWgOin4FR3zOSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cjju0DRUXTJdWq3Q1oJL0YnlbEAq3c/HKEqM5k/QL3kSm6UHesz7XfdcUdU+6vHSre9x8LsZGU/B0buJOrXZnB+vVvOJsW8yiAr/XRiPdiumxyPR6lC0t/618LBVrxP0DgYbXdQjIORvbp5Tg6Hrxn0uBjszqESqmrSuVfc8APo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STjBEwGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030EAC16AAE;
	Mon,  5 Jan 2026 22:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653922;
	bh=Y62g07QGScncAFopehfwNZgRYDrOnDWgOin4FR3zOSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STjBEwGkRjBMnOYIkQ3OXlVkdFl84KTIrRliKI26L1xplvgT6HLaC01hbHZ5AhSbj
	 QzMJSEx3V7dez5wm0ltul7mFDAjU7r9/5hnSNTK0aIJhn14plB0lAoI4tuaLWukAqF
	 V31dMm65jfX9zQY3EPbCj3oKBsnyUGqrcPXCO9tp/oCzJjmxd3VcJ2zgwofV3gH1gL
	 F0E3C25BATnFS2KcDzHTuBRA6VEV7Hj0WZFWf7SeDo2YwOgLrzwSVZTqppPPdl75zy
	 9tmEMsOcZJUxBq13yIKAV+1re4wwj1geRNR5C6l6NaTEYBFUt//SEb1uHA8vYUPFmj
	 DVDxKL4hErzoA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Support FORCE_TARGETS
Date: Mon,  5 Jan 2026 22:58:20 +0000
Message-ID: <176764780685.1450880.11544304380824187073.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219-kselftest-arm64-force-targets-v1-1-cf72d6d27e99@kernel.org>
References: <20251219-kselftest-arm64-force-targets-v1-1-cf72d6d27e99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 15:29:42 +0000, Mark Brown wrote:
> The top level kselftest Makefile supports an option FORCE_TARGETS which
> causes any failures during the build to be propagated to the exit status
> of the top level make, useful during build testing. Currently the recursion
> done by the arm64 selftests ignores this option, meaning arm64 failures are
> not reported via this mechanism. Add the logic to implement FORCE_TARGETS
> so that it works for arm64.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Support FORCE_TARGETS
      https://git.kernel.org/arm64/c/fb36d71308a7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

