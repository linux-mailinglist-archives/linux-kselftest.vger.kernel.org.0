Return-Path: <linux-kselftest+bounces-30493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494DAA84CB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E13017F03B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 19:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFE28EA7C;
	Thu, 10 Apr 2025 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoPA6CJL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0B19E96D;
	Thu, 10 Apr 2025 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312594; cv=none; b=nzel3z/IXuRLyQhPLSaecJOPbyImsYcyiLBXDYCKvMMpn4AK/GrTuV74H0LdkOMExL0ncYQNvXYFnA3KwmBTjvl7eQkBjoEbgyKXbOqUVboCiW2MnlPTNvP4BA4GFONtKOY5GqxkES+s/v8hik/7Cc6trkMFeQb13gsGVtt7c3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312594; c=relaxed/simple;
	bh=23ClUrzhbCi4gYhBVTmCi/jHYyZPt0hjBpo3q9JPJVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mExLQy0XJ60YlnipoAgBVPHMmRwnKkZtEhpKNKTqpAptwv+E9QdCZ5T55XHe2pgOVGkgTSeGfGpV2SNNHM8EMkLTQIMuRW3ki7ImHBKJQtd9APlfSWA4GGJilVzLXXTnO4zmBWWz7UAX7KJpDQVd4Fqeug0M6brkvASzFRvqZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoPA6CJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2174C4CEDD;
	Thu, 10 Apr 2025 19:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744312593;
	bh=23ClUrzhbCi4gYhBVTmCi/jHYyZPt0hjBpo3q9JPJVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DoPA6CJLe24LjnQ4VO1y5gtxmff7qldVKgUX9XBs0dZfK/MQf55yoZggcznsFxHKN
	 R6SBEISillGf2teWkqZJKoX3pHNZezTx+PiFUV5ZSJc2CMIUiC9KKcwU1mqAzqNJCE
	 aS7NZmUPcnLVmCoPDUT5w066dpY3GWpQWCyQ4fPS0OQ772EIh3WJjcVIX7Lg1x5hm+
	 Rggr4nLlod7aDfwr8jguSjfebrwqwYhjd7VFEgqhoKXv1YRlUU1sDE0GB2qPEo4ScK
	 34LqwU3ZMmATvayI+mVlKfSpcdzqMGbqX4+O9kaLDEj5buQZkBR97685mhzvxwcYo4
	 ZWnPZTFg47Tyg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, kunit-dev@googlegroups.com, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20250410132129.1312541-1-rf@opensource.cirrus.com>
References: <20250410132129.1312541-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: test_bin_error: Fix uninitialized
 data used as fw version
Message-Id: <174431259161.501489.5379480875112527733.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 20:16:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 10 Apr 2025 14:21:29 +0100, Richard Fitzgerald wrote:
> Call cs_dsp_mock_xm_header_get_fw_version() to get the firmware version
> from the dummy XM header data in cs_dsp_bin_err_test_common_init().
> 
> Make the same change to cs_dsp_bin_test_common_init() and remove the
> cs_dsp_mock_xm_header_get_fw_version_from_regmap() function.
> 
> The code in cs_dsp_test_bin.c was correctly calling
> cs_dsp_mock_xm_header_get_fw_version_from_regmap() to fetch the fw version
> from a dummy header it wrote to XM registers. However in
> cs_dsp_test_bin_error.c the test doesn't stuff a dummy header into XM, it
> populates it the normal way using a wmfw file. It should have called
> cs_dsp_mock_xm_header_get_fw_version() to get the data from its blob
> buffer, but was calling cs_dsp_mock_xm_header_get_fw_version_from_regmap().
> As nothing had been written to the registers this returned the value of
> uninitialized data.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: test_bin_error: Fix uninitialized data used as fw version
      commit: 285b2c74cf9982e873ef82a2cb1328d9e9406f65

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


