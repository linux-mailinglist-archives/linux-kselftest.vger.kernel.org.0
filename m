Return-Path: <linux-kselftest+bounces-5168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0E85DA2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243B5B26C3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F387993D;
	Wed, 21 Feb 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR1rGpjP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967573161;
	Wed, 21 Feb 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521960; cv=none; b=u4MZysTk299PWC4h9auzPPdD17R8t8SYGe9pM3G9jbEQQMsIBx5bbdAAgRp9iFL2LWENuQl4AIR3Fs2AFIkVgQm8nOO0zabmuPr6un9uSeDuXD1OkftFK+AyRtJAJ0Dr9DcCpsmCRdudzOZ0+vJOyTcpehdx/3h2ranlbl2zI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521960; c=relaxed/simple;
	bh=JMwJ1lRMW3333bVJ2qfNovPBUtjm+boh3d2JxDQ8WiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9bdRmR/TszafFxwo2KvU1fvuwWe4fFuM7l5UdNwVd3C3c4MUjWaIkdiLOBKHF22izz43vJySpa0aS7I/j1Iqcvd0P5OQ4JWyBR1RJI0eZD6LCwTcuzKK2kks0V7hU1JrJFgKVPiw1s0pJX2K1m4LFdd9pJ55n1xrzZ3rAJzxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR1rGpjP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4841ce028so1022326b3a.0;
        Wed, 21 Feb 2024 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521958; x=1709126758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Kt4DQtLokPYkv4wG5VaIf0hlu8PH+a30q0oFCSdLWw=;
        b=LR1rGpjPfgsQPGc+OrFyAmvFgTH8qGCfEjK+DDxBtuSqiL4Nav0kIQdahago6py0sI
         LNzcxfD1+2IfdjHNww0FDz2jHSa+iQmB1ZpG49v/TvglWpRBaG7G1xKhSPzVUQQaqwNe
         jHVgYiKUwf8uEN2kW34PaCv0nJrmJ7SqjIItgjyv4vTYxvR3eEysyOoobQm2ky7wNIeM
         s+C+7m6y08fmwmAER1hBmiiWn2Ql6mTJWuUVnbzvK9lt8Fc8HJJjwkDEGujPDOvAfGYO
         fAamnBVbWiYkC6A4uiIfLswyH8v4KWhK9AC+yZ9CK3xkYdLFjfVqQT4H6hcs8uMg4g74
         CeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521958; x=1709126758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Kt4DQtLokPYkv4wG5VaIf0hlu8PH+a30q0oFCSdLWw=;
        b=JcYtLJkHNwHSq5OdGUtaXkcATtdnoCpy/zGysbmZwG6mwVl2noihUSWPmFmTetbR9R
         EesZfW6yMRrtZdN7OTgY0WJOIPVv+av1O7SFlE/7p3mTSpnGOdkzNUlPC22GiK+JhVzF
         G1r9nKktXvTt3OB83nne5X3Nno+nDuURX08t9uYXmbrd+ChtsUquuvyYWWrF4a39EdAJ
         Suc/mHdxFXUBQ8H0W2xoIMliNkKjuBZXRDWdP0dIFs/mVi8ZvjEN5IHMdHly2LAljUMn
         YEdqtCAptSABuNeC+OkxoCbGUB/6hLLS6yd9C2TU1Kstm8uDeWRxOi87IGyZ3ho1bYsk
         Iu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt5tuLBWLIEvJqFiHZZPpm8p8c0iTh0yj+4/Z7HvGlEjj2gEoJgxTIy2gUG8pSqsH75dHSeroomHzdPho+PLwY4XsURLhfy//bde8OjAjkywM5XALnvHB9dDYbcu0kTsNLL+vzhw4XvczeyH+6JdDTgpVixNHVy/ZcsaN28tACTNLkmryHF26C8TwU83eAPy0nk8PdijcvM+Mze9oYVAHpPuaX4yt27RPDlLkfwnCwUTPtZV2qVZNvrSDOdwvpkTED
X-Gm-Message-State: AOJu0Yy8/LCs/cHq6plY8vIDb5lYImCrgHUs78uSQeXAT8sQV9m95dkV
	SOf8gMsTmZc8K7VCRvnRFJocFszTKizT9bz7TkHNjBhB3/9uJvIF
X-Google-Smtp-Source: AGHT+IG5kyIHO4GYkBIFrd944IQCsvluBVVm5K3A7XIKl/XEjSlVsogI7UiVFdKhmV+8aF6TpJ3Ocg==
X-Received: by 2002:a05:6a20:2d08:b0:19c:678d:c1c with SMTP id g8-20020a056a202d0800b0019c678d0c1cmr18117836pzl.37.1708521958464;
        Wed, 21 Feb 2024 05:25:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090aaa8b00b0029929ec25fesm1716436pjq.27.2024.02.21.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:25:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:25:56 -0800
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
Subject: Re: [PATCH 4/9] time: test: Fix incorrect format specifier
Message-ID: <64512797-41d5-4a40-81f5-5b17c8b7bccd@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-5-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-5-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:17PM +0800, David Gow wrote:
> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
> 
> This was found by extending KUnit's assertion macros to use gcc's
> __printf attribute.
> 
> Fixes: 276010551664 ("time: Improve performance of time64_to_tm()")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  kernel/time/time_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
> index ca058c8af6ba..3e5d422dd15c 100644
> --- a/kernel/time/time_test.c
> +++ b/kernel/time/time_test.c
> @@ -73,7 +73,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
>  
>  		days = div_s64(secs, 86400);
>  
> -		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
> +		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
>  			year, month, mdday, yday, days
>  
>  		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

