Return-Path: <linux-kselftest+bounces-35676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF6AE6007
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 10:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77687A84CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629E2798EB;
	Tue, 24 Jun 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfGXuciv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9D2798E5
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755375; cv=none; b=B3bBqt6etuFOe1ADV42kXaDbGiwp8hm/j9YzC3lR8oCb5dyjKopoy9BgP+yj7dIQVNFvdY9012etykq213sZpmJG97xRfq5roVcMxN/jw+P0Kc7EQKL8dIzjjO1wJjdaXjTJIxAgqyoFWSmIwx0e+jhOSFLU3vO5TAeP1q6jqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755375; c=relaxed/simple;
	bh=a8eU2AWlYYd01z+cecKG61efUWzlcdZbF2IGngs+7/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObIqCijyZ5VApS/dYXqNO/7AcuyEY8zSYfoyVie2ATmO2N9kPSxq9jbb9ZNIKjj5ga4kAUWUitIHFh+WUPj1uZN4RXDX1LuK7/SLYy7v0k5wOjm0cU9W3bHyfjpkp8AI5BDEedY1Kj6yGTAV2SWkciv+cr4epLbtRjChwrTydgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfGXuciv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB7DC4CEE3;
	Tue, 24 Jun 2025 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750755374;
	bh=a8eU2AWlYYd01z+cecKG61efUWzlcdZbF2IGngs+7/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfGXucivwIgjCe7rbBF1xq8aJa307Wztf41U0HXsWR5eMx7gMIlJnLpXhf1cWz2St
	 UafEpbli7v5mADFl2/Qq0fsKVWLcRlGYtPRKoyJ89uMA/AI1zNjHyc/OwHyfABE3mc
	 /8mOpz3d/ViAId6LXbM0euVSLIXc44o6Q6wfIuoddNdpvRc6spbO8LV7RlmTjKXYSt
	 RMsCRBhHm0r1Rwj7dLXiYiysv448f/jTr62pwyhLOUFpdNN8HkgvHqVLPEhSoIUWpK
	 zdSN/CFLFIlG6BqSju8dDcHp38ZPqwCubUmy1xtn8YIFxg6Y9KZrCfWfBNp4YAfm2d
	 osLTaGtWzUSRw==
Date: Tue, 24 Jun 2025 09:56:11 +0100
From: Simon Horman <horms@kernel.org>
To: Dylan Yudaken <dyudaken@gmail.com>
Cc: kexec@lists.infradead.org, linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests/kexec: ignore selftest binary
Message-ID: <20250624085611.GA3815@horms.kernel.org>
References: <20250623232549.3263273-1-dyudaken@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623232549.3263273-1-dyudaken@gmail.com>

On Tue, Jun 24, 2025 at 12:25:49AM +0100, Dylan Yudaken wrote:
> Add a .gitignore for the test case build object.
> 
> Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


