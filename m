Return-Path: <linux-kselftest+bounces-1326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89609807A1B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 22:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C570B210DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928826DCFB;
	Wed,  6 Dec 2023 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e6l8tHe2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517BD46
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 13:07:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2868605fa4aso256964a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896849; x=1702501649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqFC5ji57tlGOgcDGhYR3koXkffw9V8OUgIHws4y0Ik=;
        b=e6l8tHe2M5qlVEEJ1DCYVDM88akxop4k1yonzqkenLnFE/utNe9Bp5mC9NOsOGgnA5
         O5w0JXVSD3uXLZZqhnCj6F/vR7z1GY9hnwE+/DmSxzjYUa0PV/ul/xOhoiUF3jTL/67C
         VqD15G+/LwwV/KhYRoLPrLxDwBW9Z6UQsZixc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896849; x=1702501649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqFC5ji57tlGOgcDGhYR3koXkffw9V8OUgIHws4y0Ik=;
        b=YE9VCArmN8w6rtSmWC1r/pTMvO6QERbBOpskmZymleQfcXuYYcTvpahadTaqnNA3zr
         86yVs05CU+bH24Ui7173CO2L3PGk1eQeHa5n/72kuZzxM7nSvrnI+TiF8Lo8FrvErTVY
         jUQhVWFEzpxwOA6UsctISiUSeO51rcnEQoH3J2H/8fIQndviP15m1F4k/0zxxVYXkv4f
         XwCyWxcTKdYHmfO4RToFTQ4b3uFX/rltLDmMnktLOETqLJUkWRhm7T0vUUP/910Btl6P
         u5LLvrRSQI3XEg71R56Qk0vh47tYDlikGUacA+ohl5yN+SWKnRLd7qr5L7wh3pLYwuMX
         gI3g==
X-Gm-Message-State: AOJu0Yxal4T9TbS/MQsxnCDBApaS0Rx87Wq06YlQ5nESGfw75NFZObf+
	0Z7yeaQY2WdvJvR6g0ZfLSSlEQ==
X-Google-Smtp-Source: AGHT+IEAbbzSLQbJ/Rm3HnAGHG3fVDh0lRG/dixqNMZ39AimVhzfCgt99eehqSCc5SMeKCYoDAW9gw==
X-Received: by 2002:a17:90b:5281:b0:286:6cc0:b920 with SMTP id si1-20020a17090b528100b002866cc0b920mr1089720pjb.87.1701896848897;
        Wed, 06 Dec 2023 13:07:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gq7-20020a17090b104700b0028571e2a759sm296227pjb.48.2023.12.06.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:07:28 -0800 (PST)
Date: Wed, 6 Dec 2023 13:07:27 -0800
From: Kees Cook <keescook@chromium.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/4] fortify: test: Use kunit_device
Message-ID: <202312061306.98DA6D275D@keescook>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-2-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-2-635036d3bc13@google.com>

On Tue, Dec 05, 2023 at 03:31:34PM +0800, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/fortify_kunit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index c8c33cbaae9e..f7a1fce8849b 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -16,6 +16,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <kunit/test.h>
> +#include <kunit/device.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -269,7 +270,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
>  	size_t len;							\
>  									\
>  	/* Create dummy device for devm_kmalloc()-family tests. */	\
> -	dev = root_device_register(dev_name);				\
> +	dev = kunit_device_register(test, dev_name);			\
>  	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),			\
>  			       "Cannot register test device\n");	\
>  									\
> @@ -303,7 +304,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
>  	checker(len, devm_kmemdup(dev, "Ohai", len, gfp),		\
>  		devm_kfree(dev, p));					\
>  									\
> -	device_unregister(dev);						\
> +	kunit_device_unregister(test, dev);				\
>  } while (0)
>  DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)

Acked-by: Kees Cook <keescook@chromium.org>

(As an aside; shouldn't this get automatically cleaned up like other
kunit resources, though?)

-- 
Kees Cook

