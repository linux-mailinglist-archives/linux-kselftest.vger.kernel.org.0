Return-Path: <linux-kselftest+bounces-40955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDCB49473
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30954169F64
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5830F545;
	Mon,  8 Sep 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2EeJRJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8DA30F539;
	Mon,  8 Sep 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346943; cv=none; b=CMBBr/Tbt2jLx0H5PvOEQ/r62rm4p/7+RzPoRc1G4atl413ST12dhrv0+5Sy/86u5dHb+C3htWS2wTv0Fyq8bmua/zVqeM6UBCC7Qf9ZZbSBbKqVjCRlynOife2+SaPEFubbkZVmz0QIrfTGuie+OWuL+XsI6Zce1wiHRfORrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346943; c=relaxed/simple;
	bh=BBOLuMQBpbMciZQldTFaNC14ABYsHLR+ucy6qxVuflA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Osmxnrarsrc34bHVZzgdy7g5siKtF7l+Bes0L5JoSFoGomUImgEUhBWv5qdGly2elkx/ZdK48W67yGH3BK2LBA9qHzyBT+0SI/Codk9hBsGhmolGWZmlAFMQH6ng2/SIQ+KtAhG693/VT6+iBrT8D+jFssPuI33XWgXrL+c1WXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2EeJRJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2182C4CEF5;
	Mon,  8 Sep 2025 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346943;
	bh=BBOLuMQBpbMciZQldTFaNC14ABYsHLR+ucy6qxVuflA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2EeJRJZjrCo832k4yhx0UNmvmT+xgE+UprMnC8RMlOLifl505tfT/vwenOftdXs+
	 QpOsKPF2aQ5NQM8k+Td7++payF7d/Ibl8EFPXkCinqQ+e9azH7xZCNUOIWJ19fJFBz
	 jBjsEgbvgs2r2Rbmhhh6iL51I4XRty7thSCs3hrGfmNd1HCgMRc7dzvNM6Bhou5sdL
	 OdNJjKp5NMCydbnYLsFB4pTVjAd5FCCrCNx2lo1TEO7KvyxGSrKkLU7CfIL6CDj7Uq
	 E1m2YqxdewLGyN/GmdhrDx/Omsi2qaRBdO2toplYwP01tYNJH68mG0qYolnFKYcER3
	 dRVnGuoDhxxiQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Log error codes in sve-ptrace
Date: Mon,  8 Sep 2025 16:55:28 +0100
Message-Id: <175734043843.134886.2856924752419188882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812-arm64-fp-ptrace-perror-v1-1-7ce62d33709d@kernel.org>
References: <20250812-arm64-fp-ptrace-perror-v1-1-7ce62d33709d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 15:37:00 +0100, Mark Brown wrote:
> Use ksft_perror() to report error codes from failing ptrace operations to
> make it easier to interpret logs when things go wrong.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Log error codes in sve-ptrace
      https://git.kernel.org/arm64/c/791d703baddd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

