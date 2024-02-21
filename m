Return-Path: <linux-kselftest+bounces-5228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D30D85E8BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8BD1F299B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BA86628;
	Wed, 21 Feb 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3m+74o8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1385958
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545867; cv=none; b=LmhSaqhGEGzt+CjdbKqr+8xt62REa1UgpjbJn/Cj5A6cXwFGyFO4vrNgWI8Ru/hsMzLq06Rkra1EOrkxLKHqNQkLRzjFLXyQMcF2VU5gPUWgg/yfX5PLV2vZkrkMOWKz7K75GL+1kyLsESjQt62Qj16ypFhXxxpWjsNJKcX0270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545867; c=relaxed/simple;
	bh=OA1/1MIUS+P/xii3X+kUs1opugBAYp2FXnCE8iim2Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNTYJYjp8myImCXURXrNQNYh/wlF730xiy3EZWVl4JF7rpU18G7PB3cT0gwqcS2RocsVS1uHgzTg/VFzMG2s2lhsqhldnYOGU6MU1VDh0XBPFPaA6uOaligNDPtXrYckeAy10LXXc+o4GM3wvvUovsKmUaMb92tlC8iWxGjYcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3m+74o8S; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso327731939f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708545865; x=1709150665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUxWnozNASldM6mLZUsm3giXihd3A7IaClJa0LXBxNU=;
        b=3m+74o8SjvRsdmUgcYcVhHtkQ5gtjFXUrXn6POXh1c7bs4FNNLFfqhCoweEw0t6rVC
         1gwzCq7K8wG2mewcUH2FA551uDimGj2Ajm4SVSdCyDNHl4+rqoAO5P9Hn6kzTK4pM6mD
         MJCR/dYGEVDqVbPN3yr6STHiC8ZpEXAyZ9MD29xvbsWnaImAmx7Pc4PwXmurgb/Tes65
         8/+sCDGnn0uta56Orh5loeKJolOEzWejwsObm98RrnI5Go2s4sZH+4qQj7IVSLUSRbGc
         H/N8zYGffOrHaABy3J+cKHCtTG0ogUFtzi0InKaEuFy1ChIC/QCz2GxbDvO9cJSuogPd
         RhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708545865; x=1709150665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUxWnozNASldM6mLZUsm3giXihd3A7IaClJa0LXBxNU=;
        b=XeGjYTtyb24+VyIbW7FPjEusLK1qNDtusc9mE41BeQc8CYD3an+5vh461r2+i6rrt/
         0PpkrMz9Sm5FM8kYckAfc2sD1SCbpjVe/sJjguAnVRxWSwmVNY6WrLBUd4CGpoozVRwY
         FkIPitbGBwgJaQSrJUEYvLg7jeWqLURjpzRfhh3G+YapA6cAUaxrc4yHU97gz2wnPK2q
         S625z8tmeYddC8n4PPE/n3OgUCTn8LOsbzzHTZzZi0rh+JcawnDErG5TTgyyjoduCeSl
         kO2+Hz5AsK8zCIRRzFKgIoj3ahTrEcD8dT5VdqgbBTvVJf5hBjaEn8EapwvKKbHjlBS9
         aOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt57bcRlA8GKQY+EXWIkl6HNwL377o46PQ7Heb6OhvwGTNbNtE7X4TSnfCjgAJ0tWgd5mHxJcHRdbR3vMPXOfPcLPnAjWp0lizjFhGzhCG
X-Gm-Message-State: AOJu0YxD8kgcnf5haGtTD3kKVuQjCFDdQeIpHMO0hASCYSgxU051Tlnh
	K8JothO71JWz6tBz5A/Lbf04b8jcgMmxQFdW3L0UUEUSkxkCLWakoUSveJyV8A==
X-Google-Smtp-Source: AGHT+IERZJoWhG4EWPF6TTNxmVzRySC9KGEbeq7lW206WSkBdenSx9MWqz5eGYR8XIoLVoQASwKcyw==
X-Received: by 2002:a5d:9b10:0:b0:7c7:6e49:2208 with SMTP id y16-20020a5d9b10000000b007c76e492208mr4170773ion.13.1708545864703;
        Wed, 21 Feb 2024 12:04:24 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id dl5-20020a056638278500b004742837424fsm1881404jab.53.2024.02.21.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:04:23 -0800 (PST)
Date: Wed, 21 Feb 2024 20:04:21 +0000
From: Justin Stitt <justinstitt@google.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
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
Message-ID: <20240221200421.us26bqteeihiwiwu@google.com>
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

Hi,

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

Reviewed-by: Justin Stitt <justinstitt@google.com>
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

Thanks
Justin

