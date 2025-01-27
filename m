Return-Path: <linux-kselftest+bounces-25246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC2A1DC63
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBB1663E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B761925B6;
	Mon, 27 Jan 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLIyIcYu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FD192590;
	Mon, 27 Jan 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004525; cv=none; b=UMDxqdgiAZkFAf4638tI5xN5VpOKW2T41SUtoHTvhF01oyAwj/5DJrRXUdBUJiB3yyASxULA/1FIcmF7NLjlv10rqmfLItey4VTJ2gqG1KHpSJj5FCg0Db4UxcUlEIe+XXFs1cFsT/OCfmuLjSH8L0UulAroBTC0pmoPXizw8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004525; c=relaxed/simple;
	bh=pPBM1QbuJu1Qtd9dO6EodbObrOJCuotRQFLsvCtMCo8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ocH3ODxymOT4YJyK5XDU1Z7MHzmkd1R4ilpuc+5DoLK0NMO+lrGcDuA+ch8LnqRIQZV2Ei8ETIDTSEeYroZuEdecbTyuCgRfw4u9k5UKB3GDBzlFjW/ZVmVzwRkSf1R1ZY/KDu+ncSxTyJ/2lqpGm9i18fNZuncjME3BgFD2NXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLIyIcYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F8CC4CEE0;
	Mon, 27 Jan 2025 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738004524;
	bh=pPBM1QbuJu1Qtd9dO6EodbObrOJCuotRQFLsvCtMCo8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HLIyIcYu06Lp9pLse+44a8Wth/VFwVY2yEAw9lXkOtP3pINDGpP2imM741ptZPZvC
	 BpLzCkvA9O/8vv+H0BQHccvuDvfQAM5efSZdW7xwpV+bT6cN2Gc5lzPK07VK9rwbte
	 11rjHr8Ji77fvWBgM6EWD4MbxvpJ5gPo2Pg/SlvwAlI4nS/6pMqOzDdX9wUV37fG3f
	 +omUjd1JNltH2gsKnWMM2KM3U/mpozlO5NAznHTx9cD1jFUBMbozb61/VFPCkuNB8y
	 mAgJ8QtJArJG9N8bfH68Rc/7ErOZ86+WcZxPk7RdlCiclEEq08eTtsxlL9VZj6lqtR
	 LMEwUpG9euk8g==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: patches@opensource.cirrus.com, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
In-Reply-To: <73c81ac85e21f1c5a75b7628d90cbb0e1b4ed0fa.1737833376.git.geert@linux-m68k.org>
References: <73c81ac85e21f1c5a75b7628d90cbb0e1b4ed0fa.1737833376.git.geert@linux-m68k.org>
Subject: Re: [PATCH] firmware: cs_dsp: FW_CS_DSP_KUNIT_TEST should not
 select REGMAP
Message-Id: <173800452243.222763.9229386892534609078.b4-ty@kernel.org>
Date: Mon, 27 Jan 2025 19:02:02 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 25 Jan 2025 20:32:15 +0100, Geert Uytterhoeven wrote:
> Enabling a (modular) test should not silently enable additional kernel
> functionality, as that may increase the attack vector of a product.
> 
> Fix this by making FW_CS_DSP_KUNIT_TEST (and FW_CS_DSP_KUNIT_TEST_UTILS)
> depend on REGMAP instead of selecting it.
> 
> After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=m to build
> modules for all appropriate tests for ones system, without pulling in
> extra unwanted functionality, while still allowing a tester to manually
> enable REGMAP_BUILD and this test suite on a system where REGMAP is not
> enabled by default.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: FW_CS_DSP_KUNIT_TEST should not select REGMAP
      commit: eb5c79828cfa72e8dbdf2db842a781ad6806cdaf

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


