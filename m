Return-Path: <linux-kselftest+bounces-20015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF79A2B8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ED61F21A52
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84F1DFE3F;
	Thu, 17 Oct 2024 17:59:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643E1D95BE
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187955; cv=none; b=lyTooT0t1f/hYBJ7vyIqb+7duuJhX/zwtSr6CXWnXeVth0y7PKknEbDNPzX6PItJtkJAY62C7qtv/yj3teG7QVdteEJTro2XZpEh6k7VLPqMPj9B7a4U8xbdEDV4w0ZNObFIlQB0S7rPFHEDYyqRMuFtxHH+dl1MOhjfb3VocvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187955; c=relaxed/simple;
	bh=W4iBVovwUNsxBXeZfg5VcjGaoPT6E+Z2JD3u+5uGeRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIP7hUTYfIA8ZWZjEpn1+Dl2JEkSyvSkvWoUaevXbS2+gtrjzHxSyb9dP/4p7MkBIz/f14kjC1XfMOB0+k+FS+AtJ+U/Di0B00nPxZMQzXT3bMGFLmiOVBWikHyUjTvHAKNqub3Mb1CPHhuFSIGqnciFZN3nSXGOpxarmYfeZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63313C4CECE;
	Thu, 17 Oct 2024 17:59:13 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: (subset) [PATCH 0/8] kselftest/arm64: various compilation fixes
Date: Thu, 17 Oct 2024 18:59:11 +0100
Message-Id: <172918790133.3620644.7386966296470435961.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240816153251.2833702-1-andre.przywara@arm.com>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 16:32:43 +0100, Andre Przywara wrote:
> This fixes several smaller issues I faced when compiling the arm64
> kselftests on my machine.
> Patch 1 avoids a warning about the double definition of GNU_SOURCE,
> for the arm64/signal tests. Patch 2 fixes a typo, where the f8dp2 hwcap
> feature test was looking at the f8dp*4* cpuinfo name. Patch 3 adjusts
> the output of the MTE tests when MTE is not available, so that tools
> parsing the TAP output don't get confused and report errors.
> The remaining patches are about wrong printf format specifiers. I grouped
> them by type of error, in patch 4-8.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

I skiped patch 5 since Mark wanted it handled differently. Andre, would
you mind respinning that patch?

[1/8] kselftest/arm64: signal: drop now redundant GNU_SOURCE definition
      https://git.kernel.org/arm64/c/a2aa5dcc6393
[2/8] kselftest/arm64: hwcap: fix f8dp2 cpuinfo name
      https://git.kernel.org/arm64/c/b0d80dbc378d
[3/8] kselftest/arm64: mte: use proper SKIP syntax
      https://git.kernel.org/arm64/c/bf52ca5912c0
[4/8] kselftest/arm64: mte: use string literal for printf-style functions
      https://git.kernel.org/arm64/c/0f995f22a03f
[6/8] kselftest/arm64: mte: fix printf type warnings about __u64
      https://git.kernel.org/arm64/c/7e893dc81de3
[7/8] kselftest/arm64: mte: fix printf type warnings about pointers
      https://git.kernel.org/arm64/c/4716f719202e
[8/8] kselftest/arm64: mte: fix printf type warnings about longs
      https://git.kernel.org/arm64/c/96dddb7b9406

-- 
Catalin


