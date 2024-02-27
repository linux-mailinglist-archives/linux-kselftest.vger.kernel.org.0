Return-Path: <linux-kselftest+bounces-5499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A186A0E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 21:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F2F287857
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F7314C5A4;
	Tue, 27 Feb 2024 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hERC8G3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D134DA0C;
	Tue, 27 Feb 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709065975; cv=none; b=jPdNN2XF9gj4Iaq58FhPvXuFa6w3aO5PjwfqM6o5rqhC4S+rdTMuWaUnZ3VrlQgOybwST4uSCTHG1beIqtSmkvADDo0XR3PrVFA6MpNY8VYIgeREderJP8lE3BXmpuFljv1ht+t13xL8ueeuBdp0dpArZTEO9Az1n6lbKoXoJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709065975; c=relaxed/simple;
	bh=myVqhclYaoWabykXKhyPBJrb51yvHqqkiErwFvJjMk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOjSz11kTybERg17NwmdpvmfJd/iUTz1xmSIAcEggZReXTUaLv39aZIwAmg5gdXSvxXFdO+Qd6YaMa5qEUOqIaQQuCREGpwijuA/U8qQGcSVAmRxvHtuVIQSxmtN8cQIYc+YE/z5XlyDCPHvXQzXui+qLNm7nDFJ9niUaoHW1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hERC8G3L; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE5001BF204;
	Tue, 27 Feb 2024 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709065969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvxfxWjaLutlzwBuNGZe/hZYj/M5jqDhw7tveByHAzE=;
	b=hERC8G3LaA8JY7wMbCyhJKrjL4sPlqLlanim3qsGSCgJw5Dl1oT5pZcsXGkVC0cWuGMOcU
	j+ofXy4OyaXeQpxREaWY6IPtb+yupGSYwKfByF7MPTbFflprTXL6aDLQ7ARST491n4ykMh
	TyB9G8z6wFuiAN2sm15XUMgWe3NKOFVr2DrPPs5JOlv4KCeAi026PEfUMCVxIBut/YEWne
	mZqvk8vuGznc2J9QmsdTn+fkXzTPKzOjHT5Qp55HUuStQOd+ytAO3QwH87yxDEqEMePaR0
	InWrTLvihxQ3e7Hw82nSd1SIpOr8QPhzxBofMlGmbbxPvCT/YskO5LBQWBfujA==
Date: Tue, 27 Feb 2024 21:32:43 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/9] rtc: test: Fix invalid format specifier.
Message-ID: <20240227203243070e7d85@mail.local>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-6-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-6-davidgow@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 21/02/2024 17:27:18+0800, David Gow wrote:
> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
> 
> This was found by extending KUnit's assertion macros to use gcc's
> __printf attribute.
> 
> Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
> Signed-off-by: David Gow <davidgow@google.com>

Who do you expect to take this patch?

> ---
>  drivers/rtc/lib_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
> index d5caf36c56cd..225c859d6da5 100644
> --- a/drivers/rtc/lib_test.c
> +++ b/drivers/rtc/lib_test.c
> @@ -54,7 +54,7 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test)
>  
>  		days = div_s64(secs, 86400);
>  
> -		#define FAIL_MSG "%d/%02d/%02d (%2d) : %ld", \
> +		#define FAIL_MSG "%d/%02d/%02d (%2d) : %lld", \
>  			year, month, mday, yday, days
>  
>  		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

