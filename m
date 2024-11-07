Return-Path: <linux-kselftest+bounces-21641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663B19C0DF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A24C284A84
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA972170D3;
	Thu,  7 Nov 2024 18:39:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E422101BC;
	Thu,  7 Nov 2024 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004794; cv=none; b=qIvLRlFuabJNihavoTauaRofMXZvx0YdLktxsPtSdy4CMgs5dtQpJjJ27wLsMdhYJkZ0GP3mbXCLeQ6J4fxtiRYA1xb8vNGZuqjSXHsJcXWuinWvE3BfjHINS5nNN79k4SDN48uQyCRu0R133is1w+9IUkHLJKsxrU0Y9/s+14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004794; c=relaxed/simple;
	bh=Wz5EzWRmbP96dtKYFiUnMd4mqH4d3pyYsGGFXySZ7DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk07RkDLuPMRGnMhalUoBkAiCwPSBP+oLsM6h+oYBbZ+5EIoG+I6jIEzIVWlZK8qe03rpS3x+9ZSZNuOhGLJFEqUaluhmU0+dHjmoDSEy9GYU9dnHzNdsSPcBbdnphknYacxq3ZVUwp/9X/VcaGpUbze6iwnWecnQipqXfX2CL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5FCC4CECC;
	Thu,  7 Nov 2024 18:39:52 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kselftest/arm64: fp-stress signal delivery interval improvements
Date: Thu,  7 Nov 2024 18:39:50 +0000
Message-Id: <173100478595.985049.4978407619921174171.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
References: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 30 Oct 2024 00:02:01 +0000, Mark Brown wrote:
> One of the things that fp-stress does to stress the floating point
> context switching is send signals to the test threads it spawns.
> Currently we do this once per second but as suggested by Mark Rutland if
> we increase this we can improve the chances of triggering any issues
> with context switching the signal handling code.  Do a quick change to
> increase the rate of signal delivery, trying to avoid excessive impact
> on emulated platforms, and a further change to mitigate the impact that
> this creates during startup.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/2] kselftest/arm64: Increase frequency of signal delivery in fp-stress
      https://git.kernel.org/arm64/c/a3590d71a1ac
[2/2] kselftest/arm64: Poll less often while waiting for fp-stress children
      https://git.kernel.org/arm64/c/161e9925053c

-- 
Catalin


