Return-Path: <linux-kselftest+bounces-16919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5213967D5F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 03:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88801C213EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 01:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71811F9E6;
	Mon,  2 Sep 2024 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MhUwEyAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D73D7A;
	Mon,  2 Sep 2024 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240726; cv=none; b=YDVeitK5mv9sTLJPP6fbsECGw8vLHYc8KBI1/eAZwd/SmHBWjFEjZC4nZfdGW26f94e1dEtcHxvBkPx31UqCcMt3ozWJfU9QOSyq3YAteGVWjfC3wtg2tzfhuEe/MNKtuYUPyHaV61k5kWzb4nqDObj1bH9P4mTk8YpPNHyhMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240726; c=relaxed/simple;
	bh=hEd15IjYZXnRyhtdgcjfJSRC6rzYSKGY3zoufAR+gS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK/TUpcFYwrAuLSRD507w+bO4nFuH6uNQTHnfNpv6I5ruyw0dIuFegDfhWi53+rUgQ8UIqdB4Jww34Q4NdHYrFigiXqYSK1/CLqGxkJZVW1gsukVopwQu5sQZ9HyTa9X2viR5qpZ/p/QCnGqKHE7kgr5M6dXxHQ58Xnyvs6hjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=MhUwEyAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B4C4CEC3;
	Mon,  2 Sep 2024 01:32:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MhUwEyAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725240721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hEd15IjYZXnRyhtdgcjfJSRC6rzYSKGY3zoufAR+gS8=;
	b=MhUwEyAy7QwH2jAnlwQiZHAw1W8G/s5MAiOhbYmTLIXY3urEtImBd480WCoFf5+MPWPN0x
	N+RDjwdld/4+snJdVN6opo2RSvPoC3xYye/3DpuiTpQ4VeAgwbIzLNtcHj6hrZ8m6D3kNl
	PmoSwz1mjfoPpZ5447mk2wfwaahmsCE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5302a019 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 01:32:01 +0000 (UTC)
Date: Mon, 2 Sep 2024 03:31:59 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: vDSO: Also test counter in vdso_test_chacha
Message-ID: <ZtUVj1GJvypJ_uwK@zx2c4.com>
References: <f9f64c5ded3925ae408f01c1c61e2fdf6f645a71.1725212364.git.christophe.leroy@csgroup.eu>
 <ZtStjU_3K9yIJsmp@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtStjU_3K9yIJsmp@zx2c4.com>

On Sun, Sep 01, 2024 at 08:08:13PM +0200, Jason A. Donenfeld wrote:
> While you're doing this, also add the remaining, `0, 0` elements.
>
> counter2 will always be counter2. You meant for the first argument to be
> counter1.
>
> Also, same issue with counter2 used twice in that memcmp.

Fixed these up and applied it.

