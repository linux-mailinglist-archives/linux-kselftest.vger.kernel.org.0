Return-Path: <linux-kselftest+bounces-9058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0048B5FE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2AB23BE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B58662A;
	Mon, 29 Apr 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUJtqOK1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43683CBA;
	Mon, 29 Apr 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411009; cv=none; b=DWDoVNBN50RGlvVRhx0dnoi1i6KC1k+Gu38n4pEjBDkgfhj+E+++xyYGE0Fj6fA8R/i1QpMSdb8wlK90k0kqHGKyB4xU9GIYA4T1bKYLGRrGRpZQGFn0tIndARF4cTm3wMS6Eupt0FU3lWZ4zCf3/tq98O3UDp2Q9t64YJSrBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411009; c=relaxed/simple;
	bh=Jf99MEr0EpcNQAp05QOEx0Ed6w8E09DIYgzKMwWYMdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phoYOXISRSMn0Ea87bqfp/asPpN0hWsjTJGSTf8kBvWwWsFCdjfP/k3J8x6qw2cgkhGlRyLYyRNkComGBBhLPF7EZ7f0JAdSiKu7Zd9t+RO8U3TJ2GLwF1msc4YPkuNnrcclEvugQF1rXMInzhJizMwY4rmZkGb1E/Khwbgq6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUJtqOK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A6DC113CD;
	Mon, 29 Apr 2024 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714411009;
	bh=Jf99MEr0EpcNQAp05QOEx0Ed6w8E09DIYgzKMwWYMdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mUJtqOK1t9bYyIOz16i4YaVlAB03uNUlv1ln53D5j8C0+THNP26tsWaytERDaM8bl
	 sF+HbyO4U2QD0MU/QpCaZkoL7LJ6keopNVaReHU7RuG7ojYW5lTuH6eBX1jE0bdWry
	 WFC+qAI/oHyK1d9HWAOMr9v2Q/b0E1rvFjNP8zfUk7XGSC6aeht1J6jah9WuSnHMVB
	 nSWf2XEGpuR66IOUTIyS1PEap9vOw+NHORGWN6CdfYjSKkAr3Otsd/tn/spJUfyXvb
	 3wUAifAU8XmvX2WtrDRsBJn984bQMMtmx8izdAa53uD0mSqBcdcPP79n+Lt5A5oZva
	 Zpx80WQrAgT8w==
Date: Mon, 29 Apr 2024 10:16:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, Christian
 Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>, Shengyu Li
 <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, =?UTF-8?B?R8O8bnRoZXI=?= Noack
 <gnoack@google.com>, Will Drewry <wad@chromium.org>, kernel test robot
 <oliver.sang@intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/9] selftests/harness: Fix interleaved scheduling
 leading to race conditions
Message-ID: <20240429101647.756a1ac7@kernel.org>
In-Reply-To: <202404290852.C327596A@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
	<20240429130931.2394118-5-mic@digikod.net>
	<202404290852.C327596A@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 08:52:36 -0700 Kees Cook wrote:
> > +/* Wait for the child process to end but without sharing memory mapping. */
> > +static pid_t __attribute__((__unused__)) clone3_vfork(void)  
> 
> Why "unused"?

Right, static inline is enough

