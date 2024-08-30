Return-Path: <linux-kselftest+bounces-16830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3996668E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3291F21EA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4C1B81D4;
	Fri, 30 Aug 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1Qk91PC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD7199FB7;
	Fri, 30 Aug 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034345; cv=none; b=tDMCl1hyyOEZE/mOVRCNC5qXCuo3Tj7RLg8s0ZCVT2dLA9mmkPWP2s47ACPe+z13c1LmEaZbLwFToLNimoTasyp6pYxvMWIg9k/3mSfBFJxq27yD7Umy19C2D/H/kOSl74B9oNliSiQuzjndnFxMRgd3G0wk7FgY5W1ndJiUUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034345; c=relaxed/simple;
	bh=Si9Ss41/+FpMC/kmn+RNcS7uGCQxnjo7fqJtXiUe7rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB+qL5keTZtaXTN8pj6pMXGZ+j5FOd4mXVe26DKoBEU8I8Ot+JDk8UZh8JEKTLTOmioNy3ikxuFAVvyNNVjW2qWvDNLJCx7QgzUX0/Fc/21PJZ/BcByo5mzdSwn8iYokNhnyrLWdxJQSdcqvrDB4coC5/y207BkjNRH9JWxmLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1Qk91PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CECC4CEC2;
	Fri, 30 Aug 2024 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725034345;
	bh=Si9Ss41/+FpMC/kmn+RNcS7uGCQxnjo7fqJtXiUe7rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1Qk91PCVg8lVtNAePi3XgtsIE2Sin/oP99Y26+Nw2BuFD2KhdfjJ+a7lIMJ14lT6
	 yOT5WOgYmWpRwFEBlZhdArGQoVsyigGlULa7M44PYY6JYSGugmk1mCjoV14c6Zyp73
	 YfxGqsit2zZxierblbS9AskJ/ralGWZV7WpA3BHrp/3TB3d6/Yo8s6gWMp11cVvPGY
	 bn9YtCvgI+7VETfSsQMMSwB+rofCVvlN/k4W0+OykiLQZ4WifO4VQnnxxgAaGnFdCe
	 v6qw+b5PBxBBoR9xPECJY+MxqKESQysxeVoEy6kK9NKhryefxIjqT3c7lgzc5MvfvV
	 HmPnKjg16GBRA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Actually test SME vector length changes via sigreturn
Date: Fri, 30 Aug 2024 17:12:09 +0100
Message-Id: <172501878542.2592028.14001650150204173729.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240829-arm64-sme-signal-vl-change-test-v1-1-42d7534cb818@kernel.org>
References: <20240829-arm64-sme-signal-vl-change-test-v1-1-42d7534cb818@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 18:20:09 +0100, Mark Brown wrote:
> The test case for SME vector length changes via sigreturn use a bit too
> much cut'n'paste and only actually changed the SVE vector length in the
> test itself. Andre's recent factoring out of the initialisation code caused
> this to be exposed and the test to start failing. Fix the test to actually
> cover the thing it's supposed to test.
> 
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Actually test SME vector length changes via sigreturn
      https://git.kernel.org/arm64/c/6f0315330af7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

