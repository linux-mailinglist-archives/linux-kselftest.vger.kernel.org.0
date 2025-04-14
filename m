Return-Path: <linux-kselftest+bounces-30728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75669A884B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8146F17FFCE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65229A3DF;
	Mon, 14 Apr 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD3zNjMx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C729A3DB;
	Mon, 14 Apr 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639005; cv=none; b=cgPzNEt/NaOOmdd4U5NqND4u8s4XfKNnef9uRzuXJmJ+sIKSY9xWWuYf2LSJiZxA/MrtS6Ibc7dl2BO3Thcak0mR+YSjONsDXyMSKTmKW9UETcCsREIRGBiLvSc3+jLpuSGWMz20QHxZ9SB/KSsxbxXiSjeJ8bvk/+J+YHlWHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639005; c=relaxed/simple;
	bh=ZAw0rHdYHsm4evGnkWZ6KIEQGptodt30tgz836La/HY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kz2VvdTeYVrQcwiqZNQzidVUIPuHrKOKgiiQcOhJDnSvYcOH2MvZZJPXVVfLoN2SyJmz68hCUm5bBOtI6byOFq9f86y4X/oCNdGcTdaLecVj+uAqDozS5XSZdaERKO4rdFs0WWcczXvVJ3Wf7MLu0wKs7jdQpBrHuCGTcay23KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD3zNjMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7991BC4CEED;
	Mon, 14 Apr 2025 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639005;
	bh=ZAw0rHdYHsm4evGnkWZ6KIEQGptodt30tgz836La/HY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gD3zNjMx+NwICMshEJGHrE5oUFGg8UQD4kNOdY89wYsBRUStTxlGeKGZmbZlahnPW
	 da5GxwqY231FG7vGMx4nEu78rct97eMnEKTDl6+jxnmYI28IE3gnIR6y0AG3yNN9Qq
	 I++0jj0VUAessSvNDnkhK2mKLHILmgr8U8HV9/jvGN2eEIugF0HszcXE8IaMZ+NhF2
	 gZH52EO2x3x7zv2uHFPBP/HpmVe0PilYVyXpcOqd07HVOpWtJfPPwnDxCt4Zsyafyj
	 7BGGVkfLyjgHJGfctBvVxUjVb7Sgrf5P6hn17+ypHJxBPmpn2g7iLLScP6U7OrkuxA
	 b02B1Qnz4quPA==
From: Mark Brown <broonie@kernel.org>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com, 
 npache@redhat.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250411123608.1676462-1-rf@opensource.cirrus.com>
References: <20250411123608.1676462-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/3] Fix up building KUnit tests for Cirrus Logic
 modules
Message-Id: <174463900319.86688.13547575756527850636.b4-ty@kernel.org>
Date: Mon, 14 Apr 2025 14:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 11 Apr 2025 13:36:05 +0100, Richard Fitzgerald wrote:
> This series fixes the KConfig for cs_dsp and cs-amp-lib tests so that
> CONFIG_KUNIT_ALL_TESTS doesn't cause them to add modules to the build.
> 
> Patch 1 adds the ASoC CS35L56 driver to KUnit all_tests.config so that
>         cs_dsp and cs-amp-lib will be included in the test build.
> 
> Patch 2 and 3 fixup the KConfig entries for cs_dsp and cs-amp-lib.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] kunit: configs: Add some Cirrus Logic modules to all_tests
      commit: 1aa495a6572f8641da4ec4cd32210deca61bed64
[2/3] ASoC: cs-amp-lib-test: Don't select SND_SOC_CS_AMP_LIB
      commit: 96014d91cffb335d3b396771524ff2aba3549865
[3/3] firmware: cs_dsp: tests: Depend on FW_CS_DSP rather then enabling it
      commit: a0b887f6eb9a0d1be3c57d00b0f3ba8408d3018a

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


