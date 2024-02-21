Return-Path: <linux-kselftest+bounces-5166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2F85DA1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4B283457
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D47EEFD;
	Wed, 21 Feb 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUqK+Beg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272F762C1;
	Wed, 21 Feb 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521941; cv=none; b=ovYDhk7FZOKYNSMaZh6T/xy3kJCPuoet2ieEp5GOsTiPajgVZPb7a3aPQ26vopEo5Pi0PcolH07kZTZ1KwLJlaDuaBSNOs3aNd3frOEEesVALpFwhvVmKSXrATrGxnOXu+CRQP2r4rbvukdQ2+J2Uca3AF8XgJfigzJ9aLr2G+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521941; c=relaxed/simple;
	bh=AxOQfD/dYnKPjkTN8+5+25Conjab7Jj8Z4WrkBqpxfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqQuwKEAzkp4BiEqpJpeI06DjCyzPNmKS/GYZp8dN+UpkT9m+ocU0NnXnpo9z2bPWWj3eei0PHvvbBCljAO0F0ipzlWlBQEkrnZYOSYJ6pPrGjSsryXzyFmCHPzKSM24W0XIyc5ORheIt+8I9yrzWOEHxNaZGL8aiHq5AoGBqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUqK+Beg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso13323125ad.3;
        Wed, 21 Feb 2024 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521939; x=1709126739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZxuMWu2/GCsqoFcXfd08+HFIieM/pOcLCTfMALNvWA=;
        b=LUqK+BegDwPf+diWj48G8UWsXY6HmRgLa1zURC9c+1kKcp2klOZrXE4IrZSo6F1tnA
         64urjXlF7Fv9tXEXiA60APyLGPfcyGxeBURhWUi67mKg+1xnAIiy41nV2B/1DVwEMmJZ
         MtetRbmkGebQ5NPuS1aLjnX28W7xUvI96KGWAzQIVc3BpRIUIDTYdZWmn8J+fjYBmh7i
         GFYWmn9oRypBTyAB8pEp0tS/NyR0rmN02id5KvgwN/EFA7fg07I7h/Gzf5FvRij1ue3p
         r+eZoPJSUsSzqyj0H1lC3CQSbOew+dLV+duUOGiL+ZAG5U/1rbLEtLQ8TXVpmdXyAf5g
         6MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521939; x=1709126739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZxuMWu2/GCsqoFcXfd08+HFIieM/pOcLCTfMALNvWA=;
        b=JrcWvGZNPS1ZgoFRlQOxf5DGV36Ko5MlfMialBPAR7cWVzFoqx803Ydo1s4AbkWbG1
         C4xwLchvm0bODcGlKA1JLsB53CesXAGQBJGhXJoPIDMtj9E2kZvF6juvMUut7TvXoIPw
         qiG+ocOZSp1GL/S18pM2J6jHNhIRwS0v8W2Abwa1b296BaC1ZDgWM5x129+HWuW7H8YQ
         zZd5fgFCpwwSnruA+UtPgE0YElT6LKuRloKPtfWXXFXC+YnPBpUEBVr5fsU5IegFJP2w
         OBbsBF4tiOIjse8TYiGu/S4e6XFr8NC8Aeo/RLj7mg6sWkQCMq6SFysR7TwjPQlHBeM8
         7OEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdqFgGMZO8OnLTkypKyKH+qJ/V7AErn/mMpAuZ3UAzKFm/fvEUaj8zN1ABAbUp+RFdxBDGj3UX45BimkcJppQW5MKvcN5Y0McQSufRb2gGL4mt8LAzH8ZcEHMrGdcoi45NFO3XIzWl2ccLpu2IlUNx0qVnHvMiMVooSdG5eXi1jliwG+8HS2Wal/eEdo4IieX9b7QKjyoXzM38wi5YsNTLxZEY/h3Q/411+ToO8yvUl2FGDi3XFdezsU7k5QlMKIlt
X-Gm-Message-State: AOJu0Yx6HZzHlxOFPm+tVrlRkU8W9hAYfRr4rNtqveT0udYCsjy/68Wh
	AjyPb1EztP7bNpYS0IawOAOnD2i42jGrgNBg9ycKAgoywSN36yXx
X-Google-Smtp-Source: AGHT+IHE8MqzS815nj3h4xuequzwAdutHfnuMXuo6Qtl+GLoGzFlWgjvix1ObOiIVpalQCVk74nh2w==
X-Received: by 2002:a17:903:40cd:b0:1dc:24f8:61b7 with SMTP id t13-20020a17090340cd00b001dc24f861b7mr4170590pld.67.1708521939524;
        Wed, 21 Feb 2024 05:25:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001db5e807cd2sm8020061plb.82.2024.02.21.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:25:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:25:38 -0800
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
Subject: Re: [PATCH 2/9] lib/cmdline: Fix an invalid format specifier in an
 assertion msg
Message-ID: <293a2156-6e0e-4e80-b31e-5d553e63b707@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-3-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-3-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:15PM +0800, David Gow wrote:
> The correct format specifier for p - n (both p and n are pointers) is
> %td, as the type should be ptrdiff_t.
> 
> This was discovered by annotating KUnit assertion macros with gcc's
> printf specifier, but note that gcc incorrectly suggested a %d or %ld
> specifier (depending on the pointer size of the architecture being
> built).
> 
> Fixes: 0ea09083116d ("lib/cmdline: Allow get_options() to take 0 to validate the input")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  lib/cmdline_kunit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
> index d4572dbc9145..705b82736be0 100644
> --- a/lib/cmdline_kunit.c
> +++ b/lib/cmdline_kunit.c
> @@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
>  			    n, e[0], r[0]);
>  
>  	p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
> -	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
> +	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %td out of bound", n, p - r);
>  }
>  
>  static void cmdline_test_range(struct kunit *test)
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

