Return-Path: <linux-kselftest+bounces-37830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA100B0D6FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EA21895FD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772702DCF4F;
	Tue, 22 Jul 2025 10:11:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B92DFF04;
	Tue, 22 Jul 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179064; cv=none; b=rIZqkTRNuaZ8723wLdBxc07IjrRPreCJ/mJf4qpb3hDAXCjTye/ba64E1dxIRoNk/SfDXSsf7aL8iJRhK2X4LqFKiyIbogUcMTzhIsngzCW0pN00TjcHsvPZ+0O6e/BlmTS+kUYRRGjnKbht2exlN3gj8G34LiyOYJcMhd0cXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179064; c=relaxed/simple;
	bh=7YDeBbJP99OFyZ/Q/Rjmw1N1BxR5a+vtdXY2NRs1I5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UV2/s5mS3YXSmxb0RPYlpEktBB8rniK9SY3JxhH+qTnqlx9rg41vmK5dUV2rkjJdErAwTfvUdAX3IjEg6DSucN4/uv01wdlT9a6itJWCHgqMuCrE2N0MOk7tVjczsFSuHqxbhLmDXGE37Q71W2CWHRNqLhNeC8HfLGo+2Ygj24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E788C4CEEB;
	Tue, 22 Jul 2025 10:11:02 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Allow sve-ptrace to run on SME only systems
Date: Tue, 22 Jul 2025 11:11:00 +0100
Message-Id: <175317903265.3058188.12275051311356684269.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718-arm64-sve-ptrace-sme-only-v1-1-2a1121e51b1d@kernel.org>
References: <20250718-arm64-sve-ptrace-sme-only-v1-1-2a1121e51b1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 19:33:16 +0100, Mark Brown wrote:
> Currently the sve-ptrace test program only runs if the system supports
> SVE but since SME includes streaming SVE the tests it offers are valid
> even on a system that only supports SME. Since the tests already have
> individual hwcap checks just remove the top level test and rely on those.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Allow sve-ptrace to run on SME only systems
      https://git.kernel.org/arm64/c/b5cebb5de9a8

-- 
Catalin


