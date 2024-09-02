Return-Path: <linux-kselftest+bounces-16918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F67967D4F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 03:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735E11C212F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DC2EEC0;
	Mon,  2 Sep 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UkpW38Oj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D158F6C;
	Mon,  2 Sep 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240316; cv=none; b=N2jGxy/1n2wflqvnf/lThiWTZUEEcAAEUTcyKvrbILR5yZgU+QjAz6XkwzkJo49Im5ZjY1RCN6nsjVGvXoz1oaHsb5/cHOf3PeTMWIQr0ekCMJ8PjP1HrPnkSTzhkhSDgwJcJxYsd1fdnwdMWgxCBR++wI1hO/m+14+rfjiaiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240316; c=relaxed/simple;
	bh=wtpNYKnZbKdLBY23YTOSswuvHz/BYSepZx1YEZntG9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1hLBe/Z6rVtYA+qgRV2BCQkuXFexKluMruw58bh+6qDvkNa9I/Wd2FkYFhvHsJ0d8Dc9drUpF7rbq5f5W5KQXVOCcFalWZMxsiGWokFbKFBEzZk4Yd/2E/Sl7hSpQijAvnBUJWZN2KjZYolpDxA9ic8u1u6JH7CfAEJWV9My64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=UkpW38Oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B3C4CEC3;
	Mon,  2 Sep 2024 01:25:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UkpW38Oj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725240313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2K7OHgvBC0Jl0NQ7ZSPU3UBUGrLsQruG/gL/a9e9DwU=;
	b=UkpW38OjKk2A4/02WiGW7XVS2vw3SmZK8YoiNJT+UpI11nCwPq+vprgkRlh+gYiOCqGs2k
	XqoUdACWl3D7P+JTYUgkJEZ2agwouBTGWlz3uEF52/Oa46/xSMTMvrbxAJEUCR9rUU7dps
	i3YuNCm+RMBRSIQ0bFx96eqpQ3D5z78=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9764ebd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 01:25:13 +0000 (UTC)
Date: Mon, 2 Sep 2024 03:25:10 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: vDSO: Also test counter in vdso_test_chacha
Message-ID: <ZtUT9t_wr96S2mJe@zx2c4.com>
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
> > +	reference_chacha20_blocks(output1, key, counter1, BLOCKS);
> > +	__arch_chacha20_blocks_nostack(output2, key, counter2, BLOCKS);
> > +	if (memcmp(output1, output2, sizeof(output1)) ||
> > +	    memcmp(counter2, counter2, sizeof(counter1)))
> > +		return KSFT_FAIL;
> > +
> > +	reference_chacha20_blocks(output1, key, counter1, BLOCKS);
> > +	__arch_chacha20_blocks_nostack(output2, key, counter2, BLOCKS);
> > +	if (memcmp(output1, output2, sizeof(output1)) ||
> > +	    memcmp(counter2, counter2, sizeof(counter1)))
> > +		return KSFT_FAIL;
> > +
> 
> Why repeat these two stanzas? 

Ah, from your commit message:

"The first test verifies that the function properly writes back the
upper word, the second test verifies that the function properly reads
back the upper word."


