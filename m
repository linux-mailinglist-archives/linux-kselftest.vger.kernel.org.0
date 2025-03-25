Return-Path: <linux-kselftest+bounces-29767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A287A7058F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 16:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F743A7587
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7912561DF;
	Tue, 25 Mar 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0m1A4SS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E81FAC34;
	Tue, 25 Mar 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917871; cv=none; b=AweQScqiZRSTY6J2KtoSLxncSoVA0IdUWRI5Sk2bOyb6bxRfUg2L9RGoUx8cPEIq456MVYYUG35cAMHrqL6A6cMKhFyDyd/sOD5NbT8zDp5tNGeMb/VqqC7VcXq570rCvyaT5ZwEpg9heZr5c+xPU+eAYCCWL2Sy5Bt533IMEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917871; c=relaxed/simple;
	bh=T0A9JesaY6l1nc8qgwaVPd5jDDCHVENKy2TJK3KE8Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JHvz5Fe8TIhrdDG2ytH9AgbhVHwPTTAdZ+ySNJETkBQOJ2b3BpxBT23OpeuQBuu5gyylaD14u1ui6L147Wu6YomkMXo63vvJMdCrEsAHGc9SjUA+A20ap755gCdiEO40uYC9c8q32SS+BRuqYXO3h4VSwjhxuNMI23V1qX0QYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0m1A4SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961EBC4CEE4;
	Tue, 25 Mar 2025 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917870;
	bh=T0A9JesaY6l1nc8qgwaVPd5jDDCHVENKy2TJK3KE8Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J0m1A4SS8Y/jTwu+azp24fmehuM8FykEVtUiPLA7S5R8SMU1abSUcP2421pLIzsdW
	 XdSu98FaoQBFQhFO8FXPQGl9d1MpxFaDkjX/Bj3mKNp6r0ISahhy/hdI++Nn9hqfR/
	 qsIWZzwUFoQsRIb7sOJGaiFdKBtlDGtRHtL8OyM7mAt/U08fptEcusEG69IOmI1/Uj
	 bwQXnmSOxvFcg8zACs7b71ky+Q6f938xaqpn9aIRDA5EoGrc957DPNGk0tN32zhZDw
	 3hbAMaKr+c6m+5cDEDVwzUUQYQhWYHXQH0MP27RvUQVu9l+xUPFvuHzQcvQJ88kttU
	 oLbtRDdQz5z/Q==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: npache@redhat.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250323170529.197205-1-rf@opensource.cirrus.com>
References: <20250323170529.197205-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Ensure cs_dsp_load[_coeff]() returns
 0 on success
Message-Id: <174291786934.56229.8841259212687977896.b4-ty@kernel.org>
Date: Tue, 25 Mar 2025 15:51:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sun, 23 Mar 2025 17:05:29 +0000, Richard Fitzgerald wrote:
> Set ret = 0 on successful completion of the processing loop in
> cs_dsp_load() and cs_dsp_load_coeff() to ensure that the function
> returns 0 on success.
> 
> All normal firmware files will have at least one data block, and
> processing this block will set ret == 0, from the result of either
> regmap_raw_write() or cs_dsp_parse_coeff().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Ensure cs_dsp_load[_coeff]() returns 0 on success
      commit: 2593f7e0dc93a898a84220b3fb180d86f1ca8c60

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


