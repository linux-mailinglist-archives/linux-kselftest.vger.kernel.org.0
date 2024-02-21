Return-Path: <linux-kselftest+bounces-5165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7385DA18
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D73A281844
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C787C6DB;
	Wed, 21 Feb 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1LvHDmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4D762C1;
	Wed, 21 Feb 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521932; cv=none; b=c3zhOI5onkEJB06GrkE5h/wOfV1ykG4A0oID8H70Lhf1jqXeL84dXxSrKLwbhH4QzVlE03pRIqU566Loi1OcAWOr7nwZrRfHlMt9qp09s7BpwZDxmNPXihgSzUyEkua4Y19+nPnDPuDFlGmLm9xKLvdYV/xWBM+YrIPP2HdgFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521932; c=relaxed/simple;
	bh=Awv2ya/dCmyXIz+PUwM1HeJ90+1RVeiqxObGWE0hzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/YKcn8fD7cpaVmMd2hedUF7LL4ydXYgl6zeVzUqNHYUQl9xDO+4gEpdIythX9PA51lpIx8+vZssTbtro/1OgIgqx/V0JOd/pSHgg/hAsk1gf8oWq/71VqbyW74oI/Qt70VzPA7DKHIwhMsmVAL9OM8tOyiKWH1w1bEY9YK9ISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1LvHDmD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2997a9f4d61so2615130a91.3;
        Wed, 21 Feb 2024 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521929; x=1709126729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OI7tqbj6mWKb61MysMY2DivYivNGwAjWTxPQEZuJVHY=;
        b=Y1LvHDmD+j9EJUHYcVk/3g7FWLgNLMLl8nz+xHgs18O9Be0EngqZsn3/XrOvN0EBOb
         5Qyj3WntFZPlRmW1CcjsccFJguyw5u2lcF/WaV2GnRxu8hndChR/a0+EjGbmoJrsvZmd
         fEWOEb+Oa5+J0jBA3EV91bVZZXQkxGnHFjUQJ0XzyMputWn0rJeptGVP60S6ndZwy6vY
         0/Pl4neVEHTVqwhS2hnQTIRuftU+BdoLYqVmfp9NVKVj9W3snL/Q/C+1xgcNU0qFB5o/
         KWzJ++546+pSZ2rEwdCWVZLnqI6ZSowWJewRKnCYr4cuKUOQyPPbZAmbz9PS6vstJDWw
         BbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521929; x=1709126729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI7tqbj6mWKb61MysMY2DivYivNGwAjWTxPQEZuJVHY=;
        b=CHlFagmO5Xtst1d6lN3IzEmx2axZbkKifysUDAS1ViKtk8En7AIH0HUDZ+ncz51Pit
         itp35h3Tvykou1kTVL+FM6yc2lWcW9bqm8kSPLDvjDavoc4aXovYFj6TEbwvIZfVJPlN
         KVXJBfajOntaQ9s7TCneAU312uSNfAUDsapuVtjUlD7YOjtSZfOl9+YY1zTBBtSC6k/3
         cc3E9Y0qQZr8L9oyNupZ/3V+lfMVHpaR/6r6FukcE85EHEd7mg+TTgwYZBKPtDV4y8rb
         Mac7cAcZOb/9yUL4AaW98tkPstPRUx+KkGpAUOuaA3wdz+iJQTqfBJHCD0oSLtCz6NVG
         9D/A==
X-Forwarded-Encrypted: i=1; AJvYcCVKlZ170aEBx72/zlaq6hL/y3MbzJileHXEFIIgM6ivrHTl8OmlP5aUTL7f3+K+x+LnpiTyVTVy9zuqVQV93qav90+psSWDg8V0uVhkD713SCjHGQQPprVlODYV55dxcJbYdQIT1k/xtjyBAKwVxyXILqyQ9/+bbXhRVVPsLWF79U7bkBpwcoVPBSIF6LW/wvS0ixQvs+4eXPsoqVjrEIdHPbxJuNztMi6/Vyg+TRiA0TVOY0HR9RwcpRR9QjdYU4Qh
X-Gm-Message-State: AOJu0YwjQjenJThJJzPA7SF1BlqBuy1gmuqV2NKvkDOIsBHqQPtU1btl
	fEltS9y+4FPnMljIvemibqO60VyAfXsFEkNbL643e8QSoM0njbIk
X-Google-Smtp-Source: AGHT+IHg9MoLpqgIlSHX+Evp1yAd6u93J1yLlc8YUipHUrY6efz32qYsKutsv5edzLysx+zDmmo/rg==
X-Received: by 2002:a17:90a:dd82:b0:299:5186:1989 with SMTP id l2-20020a17090add8200b0029951861989mr10159029pjv.37.1708521929579;
        Wed, 21 Feb 2024 05:25:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ds15-20020a17090b08cf00b002992cf08af0sm1359109pjb.23.2024.02.21.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:25:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:25:27 -0800
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
Subject: Re: [PATCH 1/9] kunit: test: Log the correct filter string in
 executor_test
Message-ID: <8cfc6a3e-e618-4ddd-adca-4d6bf81a5e17@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-2-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:14PM +0800, David Gow wrote:
> KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
> but passed a random character from the filter, rather than the whole
> string.
> 
> This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
> the format string.
> 
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 22d4ee86dbed..3f7f967e3688 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test)
>  			GFP_KERNEL);
>  	for (j = 0; j < filter_count; j++) {
>  		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
> -		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
> +		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter from '%s'", filters);
>  	}
>  
>  	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

