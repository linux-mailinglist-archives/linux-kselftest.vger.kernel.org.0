Return-Path: <linux-kselftest+bounces-40956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93FEB49475
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0095A3A5007
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1ED30FC3C;
	Mon,  8 Sep 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI+TL0Qo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A730FC10;
	Mon,  8 Sep 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346946; cv=none; b=Y58y85vYH25mfV63gUAn1/lsmAo8PV5LbV2p5pFOrIjPBCmVnUyKTlTlxVL2zzgTNxLYgmWNoOYB6B7mxUcDReeTeN1bh5YmXXmAzyyKxdG3moj5tW5YSsGi8BhDRhEqlIo/XI4M7Y2ae5d20KcsV0q/rl5n0/iR0GZDl9pG+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346946; c=relaxed/simple;
	bh=TrbhHDclZj61VL4BpfvLM7YtJx5kSeqUFFlWu2MxTDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rC+4zoC0XOp3cnzndXJ0pobnKa62BrvcHTkZ0kXfvqyHwlgrF6VUH57LJC5IC9P/0WIQ98daimKV+XJ8yFGWI2QCJlqRsH7Nsr80MGbaHzhUD/Q517eUhCHfdKSrL13vjXisBCGUHjUu4hHVWm3K4XEr6H3IOjqc1HnBKlrEeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI+TL0Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A34C4CEF9;
	Mon,  8 Sep 2025 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346945;
	bh=TrbhHDclZj61VL4BpfvLM7YtJx5kSeqUFFlWu2MxTDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pI+TL0QoFGcDCtPXmvuSrq4sPxGAinw8UCXjrNFhdGOSTL7UO3B8NulAQgg2t4FSn
	 WmqPrgz5Yag7/O3hIxk6dsuZH07Y2YoQDX67q9LbKaHzAn2Ky3lQrX/XyqeswF88vv
	 lbTuo1DiglMRV9fMFBMY2rtJLgkdeZUAVlEm/9DvHVOqeyMHN2yZNhbjl83mLD9E+6
	 0Akfzmz82TPFwQpLZvwoxg5zSQ76nEa6xuiE5sKsa4Rt9wWDdee5ue1DO2uxgbG3iY
	 hUhpeB6vezPyeQ9ZPHKLly9vvdjABBZuYZCxxXRIevBsuvaAQ76ZzOzt1yBlehhdk6
	 exy0dXqsYyoLA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest/arm64/gcs: Cleanups for basic-gcs.c
Date: Mon,  8 Sep 2025 16:55:29 +0100
Message-Id: <175734328051.148062.3197193591970753500.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821-nolibc-gcs-fixes-v1-0-88519836c915@weissschuh.net>
References: <20250821-nolibc-gcs-fixes-v1-0-88519836c915@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 17:13:01 +0200, Thomas Weißschuh wrote:
> Two small cleanups.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/2] kselftest/arm64/gcs: Correctly check return value when disabling GCS
      https://git.kernel.org/arm64/c/740cdafd0d99
[2/2] kselftest/arm64/gcs: Use nolibc's getauxval()
      https://git.kernel.org/arm64/c/a985fe638344

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

