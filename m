Return-Path: <linux-kselftest+bounces-33980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3EAC7A92
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 11:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0727B0C03
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A921C173;
	Thu, 29 May 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0p438Kf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22F21B9F0;
	Thu, 29 May 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509311; cv=none; b=gHwJmoyq++nfipycV83p/39PDkVQlVRp0LAf2DF2atMnJnMgIbOPrPtzec+3KTY0HyihPlh34DKkfLAp83hNTfzP0QL4+jqtkZ7baRKJhsb2iZ0JSFE0t+KsZ8FHLyopNO9woynSrAfZmTwbDWN5u8I2Urrv7jN1h6q/4mEPu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509311; c=relaxed/simple;
	bh=HlPWaPKN/azxxyWf2k728K8i6uOX3dIuS3C2IPYFdIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcLpvxvhFvfwIHQMNqHPEYyvmG3YarBg6TPBf0tSuJMIA+m8UW2CvrNsGbv2DMqWbTbmztf87yNNk4T5zR2/HV7bt3b2HGBp9Dy14BT0uaOE3j3bWd7RFWexaCNdaA4pURXem6lti+VGhPNJ/5nVYKtaghTvsZ45nvkrW3q5gVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D0p438Kf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4rPjHyO1ImjfX55E2k5VoZ01eHeMPnzv3/koD1bA2Rw=; b=D0p438Kf5mlprmqRVogIIHQsYh
	HJ/q3CXjGlZZZrdL/+ZAPMrxAUTScM5jGy9h3tCvTNLkxK/VU7N4/+7T8Lv0upCxQs2tLHTa+YbE2
	JDL+AuS2CNPgKy3JLdYs1zPOK3pjfknYNl+IRo10uQBbqb06b/9TWDPcN9MPmICUdXqOt04elWGcN
	z1jPG0mi/V99rdCXNHWedorf/WEL4kQcpTON2TICuR0/yMMUV/GQHuuHiHKXZEgRmya/mNx9kd7gR
	knobjRVBP894kXb000cjon+3g1Ow6ftff1ibC1Amz2siZIaiTgHVV+1VEXrlte8tU8EIiZ8cGvIs6
	aVu3QTVw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKZ8k-0000000Eaug-2OvC;
	Thu, 29 May 2025 09:01:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 964CA30057C; Thu, 29 May 2025 11:01:29 +0200 (CEST)
Date: Thu, 29 May 2025 11:01:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132755.166150-2-acarmina@redhat.com>

On Mon, May 26, 2025 at 01:27:51PM +0000, Alessandro Carminati wrote:

>  #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
>  #define __WARN_printf(taint, arg...) do {				\
> -		instrumentation_begin();				\
> -		__warn_printk(arg);					\
> -		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
> -		instrumentation_end();					\
> +		if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {		\
> +			instrumentation_begin();			\
> +			__warn_printk(arg);				\
> +			__WARN_FLAGS(BUGFLAG_NO_CUT_HERE |		\
> +				BUGFLAG_TAINT(taint));			\
> +			instrumentation_end();				\
> +		}							\
>  	} while (0)
>  #define WARN_ON_ONCE(condition) ({				\
>  	int __ret_warn_on = !!(condition);			\
> -	if (unlikely(__ret_warn_on))				\
> +	if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__func__))	\
>  		__WARN_FLAGS(BUGFLAG_ONCE |			\
>  			     BUGFLAG_TAINT(TAINT_WARN));	\
>  	unlikely(__ret_warn_on);				\
> @@ -121,7 +130,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
>  #ifndef WARN_ON
>  #define WARN_ON(condition) ({						\
>  	int __ret_warn_on = !!(condition);				\
> -	if (unlikely(__ret_warn_on))					\
> +	if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__func__))	\
>  		__WARN();						\
>  	unlikely(__ret_warn_on);					\
>  })
> @@ -138,7 +147,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
>  
>  #define WARN_TAINT(condition, taint, format...) ({			\
>  	int __ret_warn_on = !!(condition);				\
> -	if (unlikely(__ret_warn_on))					\
> +	if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__func__))	\
>  		__WARN_printf(taint, format);				\
>  	unlikely(__ret_warn_on);					\
>  })
> @@ -157,8 +166,10 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
>  #else /* !CONFIG_BUG */
>  #ifndef HAVE_ARCH_BUG
>  #define BUG() do {		\
> -	do {} while (1);	\
> -	unreachable();		\
> +	if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {			\
> +		do {} while (1);					\
> +		unreachable();						\
> +	}								\
>  } while (0)
>  #endif

NAK

This is again doing it wrong -- this will bloat every frigging bug/warn
site for no reason. 

Like I said before; you need to do this on the report_bug() size of
things.

