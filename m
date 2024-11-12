Return-Path: <linux-kselftest+bounces-21884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E79C5CE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DDF1F23B1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D906204092;
	Tue, 12 Nov 2024 16:08:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31665204030;
	Tue, 12 Nov 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427680; cv=none; b=Dyd9LwJQkhrGExCqdhjj2hTM9E6vpnrlUEFSV9OmKDajQzjFEeqY+RVqQ4wgPBojctnpxguEJ8kavFgUwNy+ZuN5ZrrK7ozYLQUI4OYoQAqnlpLlXpQ+mRQFD/54JFimRoQgOMeW+8CxSGT2fEaljmHwFOEDrUOQtzYDfiLyxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427680; c=relaxed/simple;
	bh=ffTj3kRTOE0f0O48739mq2dU1kEUXCSv5rOuZW6yEGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvfjbG16zabnZ3UlZ6/jGnCcOPj5/yP6MhWgSne8s8TWlgCEFptd6QRpoDmx4I4kHM+MUi7BZGCMZiXu6eGFgOCFqWV7RZNg47VzEoR9xqYTB/E5QJ6Jukzsu8oYElKeY/WmJi5rBtG/EZ99AwmjG4DTVUjUWrjCZXhroi1yNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2262C4CED0;
	Tue, 12 Nov 2024 16:07:57 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: (subset) [PATCH 0/4] kselftest/arm64: Fix compilation warnings/errors in the arm64 tests
Date: Tue, 12 Nov 2024 16:07:36 +0000
Message-Id: <173142698241.893467.3612331724915508204.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108134920.1233992-1-catalin.marinas@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 13:49:16 +0000, Catalin Marinas wrote:
> It looks like people started ignoring the compiler warnings (or even
> errors) when building the arm64-specific kselftests. The first three
> patches are printf() arguments adjustment. The last one adds
> ".arch_extension sme", otherwise they fail to build (with my toolchain
> versions at least).
> 
> Note for future kselftest contributors - try to keep them warning-free.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/4] kselftest/arm64: Fix printf() compiler warnings in the arm64 fp tests
      https://git.kernel.org/arm64/c/b6bd50dd3b56
[2/4] kselftest/arm64: Fix printf() warning in the arm64 MTE prctl() test
      https://git.kernel.org/arm64/c/0cc6b94a445c
[3/4] kselftest/arm64: Fix printf() compiler warnings in the arm64 syscall-abi.c tests
      https://git.kernel.org/arm64/c/694e2803fece

-- 
Catalin


