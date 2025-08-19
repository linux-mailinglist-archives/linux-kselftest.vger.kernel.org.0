Return-Path: <linux-kselftest+bounces-39265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B43EB2B558
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F7F19678AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 00:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A5315E5D4;
	Tue, 19 Aug 2025 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqguAWeY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D8156F45;
	Tue, 19 Aug 2025 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563717; cv=none; b=k8z5LhmnDjq4JcqlgaUA+YSmPHhr4dY5SUk2/xGUUwThcF5/0xT7+YbcX53oSPIEUhq1/GKAxt6GW0lVLF/TTjkEJLV6FTOThOJXTGKt8dAwmmNwW9F1rESywP1WJi3ZmD3CTGAqNnYMd/mi6RoulFidF0Z/LLxOLGB4oKBeG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563717; c=relaxed/simple;
	bh=pS3SAXWXLubnYcw9FqTVjHbNQej40FQ4fhcGAOaEF+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mneQMSnRucXOfeaWkE1y0gJOM4Cbc4WEhrc9/9CGERIqQ3i1qhGuqKwbaSskb1gQpg5RcyDoheyCgVBlauhh/w6/6YVzla11UyXd3P9b5J0PGUFX50G0ofwyoiQj1y73beCP4lYOnV6ivxoWmv60I3z8Oq782m2I46qoRNRBcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqguAWeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E50C4CEEB;
	Tue, 19 Aug 2025 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563716;
	bh=pS3SAXWXLubnYcw9FqTVjHbNQej40FQ4fhcGAOaEF+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqguAWeYNOBlzmLabfbhIjMJXKk538mSIPSUlf1oF/UfRDxdGudmeakNDZSEvuBRW
	 rRTD4ZPMMa0gFoioVMhyl8nBvQOpfExB1BBYoiBw4zA11bwmthMX6p0XpzYIzK1X6b
	 D040kcT504JYWKPqilzwan11d+70VNpF8wiuztBq7KNn7PfXyEWuYg8iumXfVTBXIx
	 QwRzvsfH989+BnyAB2qTHCP7SsRiI2CM35d/tV38/AzbeyT6YyXc5c8Yjcb0Fzj0xy
	 a1axyCG85/i7PX0y/dV4azjvW9w9vhuxoTWIrT8hZDzt/xvh13CF5rF/UfLuor2YTX
	 7GdsRlzWt7lag==
Date: Mon, 18 Aug 2025 17:35:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests net/socket.c: removed warnings from unused
 returns
Message-ID: <20250818173515.1845a785@kernel.org>
In-Reply-To: <20250815060631.144471-1-alex.t.tran@gmail.com>
References: <20250815060631.144471-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 23:06:31 -0700 Alex Tran wrote:
> +	char *err_message1;
> +	char *err_message2;

nit, how about:

	const char *msg1, *msg2;

? And then please wrap the lines at 80 chars.

>  	int i, err;
>  
>  	err = 0;
> @@ -56,13 +58,13 @@ static int run_tests(void)
>  			    errno == -s->expect)
>  				continue;
>  
> -			strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
> -			strerror_r(errno, err_string2, ERR_STRING_SZ);
> +			err_message1 = strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
> +			err_message2 = strerror_r(errno, err_string2, ERR_STRING_SZ);

