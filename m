Return-Path: <linux-kselftest+bounces-21880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CCC9C5CDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3D282B4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E620604A;
	Tue, 12 Nov 2024 16:07:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF14204012;
	Tue, 12 Nov 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427670; cv=none; b=RNnalsoTlnVe8mXDgsrp719X+IlP2aUhk1tZ43LH8wLNeVGxbh8Cs3v6oQ5Z6UcU5hy00qVnwFVLhF9j16kZgtDyA4p/bFSGQk5SJ/t8t6bx0xjlPOzRoYosD5ktb8NbcM1aljb1rJvsszoHUdMmlx0GaWn/w2AMC9HChm3lG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427670; c=relaxed/simple;
	bh=cz1/cavbZ2k96Mu1RIzkBK48u6dTV5xvBO8Zk1WR27g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FES25qeUC0qkKsmrbiBhvNKRFZ8Wy+K2hVMiz7RCgP7NBctWWatTZwj4fNlOyhJ2zM/D2VirvPnctws08yaWBhatL/Lph6N7kK2ZsO7pU596YAK6WG1/ah7wTatBm9RGTl2li0z8uH5Q4vSlMzIato4nafXnTKBaH2Sc8kQo/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C1DC4CEDA;
	Tue, 12 Nov 2024 16:07:45 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] kselftest/arm64: Enable build of PAC tests with LLVM=1
Date: Tue, 12 Nov 2024 16:07:32 +0000
Message-Id: <173142698242.893467.5720909659251120583.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241111-arm64-selftest-pac-clang-v1-1-08599ceee418@kernel.org>
References: <20241111-arm64-selftest-pac-clang-v1-1-08599ceee418@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 11 Nov 2024 18:32:58 +0000, Mark Brown wrote:
> Currently we don't build the PAC selftests when building with LLVM=1 since
> we attempt to test for PAC support in the toolchain before we've set up the
> build system to point at LLVM in lib.mk, which has to be one of the last
> things in the Makefile.
> 
> Since all versions of LLVM supported for use with the kernel have PAC
> support we can just sidestep the issue by just assuming PAC is there when
> doing a LLVM=1 build.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Enable build of PAC tests with LLVM=1
      https://git.kernel.org/arm64/c/c297aa7d3fb6

-- 
Catalin


