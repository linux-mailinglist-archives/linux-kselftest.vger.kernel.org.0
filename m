Return-Path: <linux-kselftest+bounces-41619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B19B5A3B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1953246F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF22DE71E;
	Tue, 16 Sep 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZImTrAYK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1C31BCB6;
	Tue, 16 Sep 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057240; cv=none; b=UzKuOGu4gkLBAoZhvq22F2qN8txEh6FlJCmKNeN7N6nu/6+aezC8TkpEJWsUYLXj5m6gH7XEkGrajpJ2YctlW6zD/QcuR0xkrTyvaS1ggG/kTcAcoqROhv6Ekm0VpEgDSTGe5zi6SfbAWqT8fbZQA7+sQJE1Z4bluw7DQKO3xCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057240; c=relaxed/simple;
	bh=jInJWqCSD2tE4OmrvXDiyUixVS6RwmIj9RFok/Nmy5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9ngzEMCfnXBREUZFmlpDvQ24YZVATGUsIljx0vXuBQFrcPWqzCCgbkL+EMOM04SmzQ1s47dDcoaXi/7rooqiRFvBmom0rChGELO6uZk2+4U7bWnnhfCZe1uc/FMwAgzKv/Z5vqjwPKqZwPhbkvGlIQWltMjfBeCVIS4DB9mA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZImTrAYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C004C4CEEB;
	Tue, 16 Sep 2025 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758057240;
	bh=jInJWqCSD2tE4OmrvXDiyUixVS6RwmIj9RFok/Nmy5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZImTrAYKUJQRO/o8tLpQjVUwBA+8cF+Vax3PQvKoQOhfsvMkIyvR9n1Ytu2GTvHu7
	 Zux8k/Pzb61qlNms5ou8CaHFR32E6y2DIMr6UpWy/EegfFFt7bBm7BSQaXAH9LdjtC
	 K5DBTGk3A7rpgA9OUSeEc8mjdHPolwgo6CH8ckSAf/txOOqTpqFPbKfNRrfxaiAfOe
	 SXwc5stvlg+kjtrcioai6x97S12wiX52RkEmsfDP1MRPr5OM+Ikkkw33WgzQw57O3H
	 yEPqltEWWL+tIZKEdMM3tgubPVPapbC0EIrS45xlzIN/gRQCXR0JiYgSU4lGHiSdER
	 3B9HGygntElug==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: Support FEAT_LSFE (Large System Float Extension)
Date: Tue, 16 Sep 2025 22:13:47 +0100
Message-Id: <175804891321.3098971.7036072968418097022.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
References: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 20:21:17 +0100, Mark Brown wrote:
> FEAT_LSFE is optional from v9.5, it adds new instructions for atomic
> memory operations with floating point values.  We have no immediate use
> for it in kernel, provide a hwcap so userspace can discover it and allow
> the ID register field to be exposed to KVM guests.
> 
> 

Applied first patch to arm64 (for-next/cpufeature), thanks!

[1/3] arm64/hwcap: Add hwcap for FEAT_LSFE
      https://git.kernel.org/arm64/c/220928e52cb0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

