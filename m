Return-Path: <linux-kselftest+bounces-5172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9DC85DA46
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CAC1C2338E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9210980036;
	Wed, 21 Feb 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWI0hq0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7479DAB;
	Wed, 21 Feb 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521999; cv=none; b=Z65jEsQEUPHDlAg+Y6YXVAm2VvpvDC99D7HeupkYnxqX4arrwJ8aEhRNG3te8FEqWcE9uHuZEsce4nI0klQhVw0KcbvdlCUFRuN6p2r6CYtK3sYUG4qxlbz9kjfLMvOxM3Yri42+79GMNbNCbGFDlKtUeEpsVaUh80utEIbKBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521999; c=relaxed/simple;
	bh=W1bh9mPCoVoWT620E6LLjEHdZl5Kkri+PSAJ6dtjs5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbvwEv81V6biYpZa7jf/Hapfi3ZI7TU0+MFpZ6QWOHN7Ot06zeTmYMSmaEibz5wkcV/TRXiLTeseYuTUD5cCecXtptv2s7ZVJchSL6sTieWsYGz9viCz+6sxjMxo8SkKxFOLjzA6Um3a+g6Qr+HAE4MTH0imJsVXSCcVm95p3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWI0hq0y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so4272068a91.1;
        Wed, 21 Feb 2024 05:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521997; x=1709126797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EePe0MTYXs7Z2oTEDss9GmtaBsc5eCkdw3mGJQ9X/gg=;
        b=DWI0hq0yIM8cq3qZLXi7llR9hsl8FxXM04YvdUJK3jpqARmt1ImjShCyXNBCGLM1ES
         Yk19FE++u7Ik4C6BO5k9O2TeMkc3KWOVKJnaj0z2BOdaDVkk4GvSg7qnlxVG5+kQ942u
         DIqX5xgb04JG6x304FeG5CnCiMp8bcaQS8RYovv08oQXk92I1MgrfHoHmdDu/t8UbywC
         /XjNES629TI5oAPQdcQYyR5sVnDtaBvK5t5fGaW4Dab+Gu9nOcfF0esobyNO52Vu1TwM
         hQIHTas7PDCf9y17udhSBh4zEN2gsVSG+fkPWL2OMKQ4Fa3ciKxF6ZgMZEOQMEm6XH9G
         bzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521997; x=1709126797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EePe0MTYXs7Z2oTEDss9GmtaBsc5eCkdw3mGJQ9X/gg=;
        b=vy9mK3GzKGPHUaHquE6GShzkfNZO1S13ajblulkWzNLRjjfTbqi4a2PtAcx1ieReM6
         IO6G8zL0+PtemS2xj3w3VRy9NnFyIyGyhFcpvt61BDTliOJAMOyVjEZUFfRmpHFsG5yK
         VzKDWSQnMJQi7XVMmgjiJsWon15Cm+L2Xhs9beX0puUiyDAK2HoOALPbnEnTROpBurwN
         wb037uxJmTAFwB/fjNebp5aCQEKBF4VO5rSkOL7JDVsqCaX+C3P/ozvJswAsqzO2kAdL
         wr+kcV4JQkiRTx56aZ9faz25GSpfjebRV9oLnrC/OKKswN3tJ8RIVijWc3Ke4B169RLa
         LG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW03hcKbwhbcMVRTDg+nQrk590Kosp2Sm8JcdH3LeLPcEaAkg0KEf9YhM8zqrpQ8vYjwICd96JeOSRwlYCYHl5RsWp4pyinTQMTbGI9TeN9AhqgDEXf5qOsdZOaOYYc24b4AOXqSg/82tKCumdE9nsd2iig23BNXWTqZJhFwivDM8vnwUpKjLmGut4BREDzHVuPC03+y0hGsEP+kXQRwnH7LKEl1/8bdMaaAcJ4M78J+7FLFjiKhspWJzbLLntiPtyD
X-Gm-Message-State: AOJu0Yx+uP5YQWxwAzC7QyzmHcuduhpw6pXDL3R25SE+P+sju52nPFFO
	3w0S/h4OHo38kMowYMt2XhAyz3Sb1GWmfx4sBYSE7A02f4yeLWr1
X-Google-Smtp-Source: AGHT+IEWPD4ejqzNqPJw2zZJamfWDbGhl2UdLf9/ybf3Epci3Toaligu7BmzJbVDgqS9rDkt/1mWvw==
X-Received: by 2002:a17:90b:155:b0:299:4fba:7434 with SMTP id em21-20020a17090b015500b002994fba7434mr10656678pjb.0.1708521997284;
        Wed, 21 Feb 2024 05:26:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pf10-20020a17090b1d8a00b002992754487fsm9447776pjb.5.2024.02.21.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:26:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:26:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Rae Moar <rmoar@google.com>,
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
Subject: Re: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in
 xe_migrate test
Message-ID: <d92e819f-f2bb-4737-8e79-2c60f5740971@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-9-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-9-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:21PM +0800, David Gow wrote:
> KUNIT_FAIL() is used to fail the xe_migrate test when an error occurs.
> However, there's a mismatch in the format specifier: '%li' is used to
> log 'err', which is an 'int'.
> 
> Use '%i' instead of '%li', and for the case where we're printing an
> error pointer, just use '%pe', instead of extracting the error code
> manually with PTR_ERR(). (This also results in a nicer output when the
> error code is known.)
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/gpu/drm/xe/tests/xe_migrate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
> index a6523df0f1d3..c347e2c29f81 100644
> --- a/drivers/gpu/drm/xe/tests/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
> @@ -114,21 +114,21 @@ static void test_copy(struct xe_migrate *m, struct xe_bo *bo,
>  						   region |
>  						   XE_BO_NEEDS_CPU_ACCESS);
>  	if (IS_ERR(remote)) {
> -		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %li\n",
> -			   str, PTR_ERR(remote));
> +		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %pe\n",
> +			   str, remote);
>  		return;
>  	}
>  
>  	err = xe_bo_validate(remote, NULL, false);
>  	if (err) {
> -		KUNIT_FAIL(test, "Failed to validate system bo for %s: %li\n",
> +		KUNIT_FAIL(test, "Failed to validate system bo for %s: %i\n",
>  			   str, err);
>  		goto out_unlock;
>  	}
>  
>  	err = xe_bo_vmap(remote);
>  	if (err) {
> -		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %li\n",
> +		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %i\n",
>  			   str, err);
>  		goto out_unlock;
>  	}
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

