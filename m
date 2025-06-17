Return-Path: <linux-kselftest+bounces-35178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B339ADC369
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D054D16ED64
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B828C86F;
	Tue, 17 Jun 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/V01r8T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J80N2mn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C074B28C85A
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145517; cv=none; b=feZsCcHnWuB/TFRjM+kGUZR00CKAjnlWJCpr4eaevMivoiXkHOQsyjYZopse+G79fE49qtqeekclEN5+2oU7DRfuzOu+jK1KPQTC3c3nHfXPAE96H54hY8xIfrlQdGgL695kSGhl5xi55ErjhTBaBYkHMneFu6mTzBjPJ8fkQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145517; c=relaxed/simple;
	bh=dIKpHWl1bSd4oEAouAAJJm7rtAYNFbayEL25dlaPidA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3IIl1XNrpXeuAsTdhMSw33SEWTrpfFh7Zq2rRxxJY8NYBco36yCFNJqFCNVPsBGOVxg/WkP4Za94Wjp2pB+jwadydtMEF7Um+bTc7HnzaqkEc2hK5kAhOMGNrA1lEUuXPk3uYTov1N7v24uLUroRNEowebefwzEXFE1ekp4KTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/V01r8T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J80N2mn3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 09:31:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750145513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4K5mn/RWGkiTGZ7yLNGYFPN0HqrSIyXUiyrEdoM/Nmc=;
	b=F/V01r8Ttx/PG49UKNC5G6Jt0AsHtTOKpTmcsPy/Hc72MEuwK67HZJjBR08QU8TYlS1h3K
	/HSnbjS4Hz3fBOtEwVqZjdPnLJbvQ1SsiqMfdXqVGHi/4mXWJXoo6ygbnHQvj408Xzjbpc
	x4/jPfi11aVdy/TM4AZqiUfpC8DNVb6yh9B5UJGve+6B9St6nlhIyNleVG52+rQB2Tpb8H
	4uVbrTvtKIDsZYKsuh38pJRio//X4Jmbpv89xTb4EikE1Uty9yNm+XJ6PQ9l0RrLSRL894
	oxYRrs/aUzKySyKfsRMcqQZLvCK45BvsekA63k0Mg50IaqCkh1AVWlOtwoE5Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750145513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4K5mn/RWGkiTGZ7yLNGYFPN0HqrSIyXUiyrEdoM/Nmc=;
	b=J80N2mn3QMyH36MsJ/H7uFfiZAgRSl62GwfCYxSdZqpeYEHNC3QG3RCzFaSlDh7Msi69Y9
	cV58dOUs9T91WtBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, linux-kselftest@vger.kernel.org, usama.anjum@collabora.com, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/3] selftests: correct one typo in comment
Message-ID: <20250617092923-28ce37f3-5b4d-4922-83a5-ae6bf6a67fbe@linutronix.de>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-2-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616122338.32678-2-richard.weiyang@gmail.com>

Please use "selftests: harness:" as subject prefix for the patches.
Also mention the specific typo to make the subject more unique.

On Mon, Jun 16, 2025 at 12:23:36PM +0000, Wei Yang wrote:
> The name is __constructor_order_forward.
>
> Just correct it.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

With the above comments addressed:
Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  tools/testing/selftests/kselftest_harness.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2925e47db995..674a6112e6e1 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -936,7 +936,7 @@ static inline bool __test_passed(struct __test_metadata *metadata)
>   * list so tests are run in source declaration order.
>   * https://gcc.gnu.org/onlinedocs/gccint/Initialization.html
>   * However, it seems not all toolchains do this correctly, so use
> - * __constructor_order_foward to detect which direction is called first
> + * __constructor_order_forward to detect which direction is called first
>   * and adjust list building logic to get things running in the right
>   * direction.
>   */
> -- 
> 2.34.1
> 

