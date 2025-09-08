Return-Path: <linux-kselftest+bounces-40957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E65B49478
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E483B3A64DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330E30FF34;
	Mon,  8 Sep 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WezdQvLf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A930FC3F;
	Mon,  8 Sep 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346949; cv=none; b=jq+r4+zCqF0i9neVgb/Sy3buKynvo5PnHl8UOAlWDcWjzrS53bKdqF8T+qpNgP1zA0FrfiiQOxSGMS8fj30e8SXZfd37CMoyt+l/hj2KogEHiXkVUoLXGTTdtLMse71y4k7JqNr+mvP2gdnOl0n7eeY9RNjmPQsLoE9lPnH3/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346949; c=relaxed/simple;
	bh=ugkOsd8Tovfe1b2/cCJ9AsQbL5PP91uhRU2ifNevKdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtU9FMxWaUOINqs7uTyuZ1DfP/rTaFzlLguN/A5QL2bPk8zfvH7MdD7VKbKDqyVw1VhY9PUvF+37x1HJZD3ldvVNfr0eP0UR2WzLYNgHPNjn2HZZqzIC2E9LxaTyitJM5yf+6iEUUcsd4DsgO1tnneagC6laYgQXSNcqvINVpnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WezdQvLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2E6C4CEF5;
	Mon,  8 Sep 2025 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346948;
	bh=ugkOsd8Tovfe1b2/cCJ9AsQbL5PP91uhRU2ifNevKdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WezdQvLf9cxcGTdiY3msxIaKRJ9B/gBJl0uJUROY91bPAlGWSRIPvkMpP1icHedgO
	 uzpvWZAU80NmCYIP4v7e0ks3EL2QjPxgmIy2ffmMV7LIwZGPsqhYpk4JKQ1iH2v/v2
	 CEJ2qyYq4jOu3zxnQre6Nu+5hW5LpmmwAHEnlSzAkFWC7d2awhh8rA5N4ty5y0VN6x
	 3ZyyiMY6M32UI8HxVOUPEcwJO0CQoBmIty82ffCSA3rAjwI3qkgB+oZvAWg3vm7PsU
	 Tac52Jne1H/KZZuayeEBxrVIswQf4C6D4dA0+BBEQco4vkp+hDtdCK6LNIJJmtcykp
	 bans5EHjlOi1Q==
From: Will Deacon <will@kernel.org>
To: broonie@kernel.org,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: arm64: Check fread return value in exec_target
Date: Mon,  8 Sep 2025 16:55:30 +0100
Message-Id: <175734023581.133744.8096458683777089384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250808080955.41735-1-reddybalavignesh9979@gmail.com>
References: <a72e8741-a63a-487e-838e-daeed3458c0f@sirena.org.uk> <20250808080955.41735-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 08 Aug 2025 13:38:30 +0530, Bala-Vignesh-Reddy wrote:
> Fix -Wunused-result warning generated when compiled with gcc 13.3.0,
> by checking fread's return value and handling errors, preventing
> potential failures when reading from stdin.
> 
> Fixes compiler warning:
> warning: ignoring return value of 'fread' declared with attribute
> 'warn_unused_result' [-Wunused-result]
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] selftests: arm64: Check fread return value in exec_target
      https://git.kernel.org/arm64/c/a679e5683d3e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

