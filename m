Return-Path: <linux-kselftest+bounces-5173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1A85DA4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B97E284F51
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CD80618;
	Wed, 21 Feb 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPCRgmP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C377A03;
	Wed, 21 Feb 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522009; cv=none; b=tUBhex5rP2D2nlxGxBpuPs6H+fjYscESmLK7uHEDdzJ5L/pAKdk1Pp2aD8qnBMJE//nEadaiMb1E7PwqGOz1IzKOKoagy9knsBlos6SgY4UPIqJJC87a7qJpmHK01wdSWEfpi6mLF+Q/9q2oDwtMoRd6OrapXShNdC00tNtXlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522009; c=relaxed/simple;
	bh=F+O2jT8N2BIEGIYwYUqoDBWQmBTa2NMIDug/qqNZ5Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r04yEurEDpr3HyNMrW9P76bBshc2fjFDTXNjjmH8DE4ifk6b61Y3EoexiF+7ZL5I3sHilsu08vDWHlHeE+7z4xoqVQazurRC21fNW96puGXjKnSxXY5G/h7ROFEkML/xsC+1uyeR7WMZNVpbUXxDgJVkBvGIIPcL69AMGxxBrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPCRgmP6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d731314e67so47519845ad.1;
        Wed, 21 Feb 2024 05:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708522007; x=1709126807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIcGpMiTUFuShIJcNZW3Z6nnK/vjwEkJ2H69Fs4AHDY=;
        b=NPCRgmP6U42OtlkgqwEWc6Rt5ApAtn4Z8GzHJ0ECxDbWb4EKPx/2r4SHjW0Avbfk8p
         Zk7Wd02iO/qlmC8A2xm9jjiOxeo6Aitn4YqnHLaETgWC9iPRIwE1VYy9aUIL1M/4XN4/
         2uEyuYER3WuVaDfxYbcticsRCZL7mOeRB/uYmeJjsguCA5zHETBMw2J5qd6TBZu3nSaC
         R7sBOgvSH2QfB/Ua19ZJDfgU+SbvJaKBfAYlcStr3A0uvFQpZfzD1nSeGLUNOEPZAfp5
         S0vc6Xzzc/9mTj8ExmtawE4V+FFal7dX1X727PaYl3cGzcWJDaAHkruVIFMFTAXJSa0x
         Ambg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522007; x=1709126807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIcGpMiTUFuShIJcNZW3Z6nnK/vjwEkJ2H69Fs4AHDY=;
        b=bZ3lacwWWojrYnGaC8w1zvAdIA9DGpv5kN2bb1GYI5/khh7A3DvmBUBpJzAtNkcAJ6
         9t8DxNWROUk8ymVIkiaPwiyne7ZZ0Qum8dqtnDnSoMR1cBAYmyntP3zGwDNfCEvxD73c
         FIE/OdoxOI37jrAufCJYLAxUdtSx42AT/bkPeGwlDM3EonD91sbJXOLAVR04HgaEawLO
         ZimtWRUGOqAg4QQFwNTArfNA/oJobItNmYQ8wOMpJ4EMi/bfa7NA2/oFfSfGcXTpx8FF
         m/jEi6rZdwzShJVLcerHqCyHFgkiMcEbF/VFDocliGJR2YA7We1VScI4iyqqyNbvvO4Q
         X+1A==
X-Forwarded-Encrypted: i=1; AJvYcCXJJwznjKjIxLDgvJgIFwKiBJA9sHCIYnkIqMPSgLhpiPnbkXTbPSjjmjYhi2jMJ9G8pJolzGVzMsisd0nysMe20AXFaAJiSiaFsOpX/Cl/B1S+DuG7vm0Vr6WuQ28VAcmBf60NzjbsT6UTCfML/hNY5nArxdu39XudaBcEv0OsBgsx6I1lVblvzMAL07BGr0mMd7EobL3dLVUV1mw8GD/7jDondWS+Od7cUaR2Qs3JC3VW5J3fZP8+uXgowUYriXgv
X-Gm-Message-State: AOJu0YwHZNjWjrqxU5vCWDIRGyTmNsT/gbIFxYR+IIXO/ICwOH3f5HIk
	knuw6lSKKuF0s1YqWA85rEkYIGkGky0q2FMxqaJFEhey8DdVrvCP
X-Google-Smtp-Source: AGHT+IFE0VdYohKERbDpngNjL2p6AnzRx2gY/8gsbGjsig+sWD9GvuWZ3WTfrhlLRHdoubZSLlvgUQ==
X-Received: by 2002:a17:90b:3b50:b0:299:6c4a:c5f0 with SMTP id ot16-20020a17090b3b5000b002996c4ac5f0mr8381795pjb.9.1708522007304;
        Wed, 21 Feb 2024 05:26:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090aea9700b00298c633bd5fsm1699769pjz.30.2024.02.21.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:26:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:26:45 -0800
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
Subject: Re: [PATCH 9/9] kunit: Annotate _MSG assertion variants with gnu
 printf specifiers
Message-ID: <678b4b1b-6319-448b-b6a7-7692b368bf31@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-10-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-10-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:22PM +0800, David Gow wrote:
> KUnit's assertion macros have variants which accept a printf format
> string, to allow tests to specify a more detailed message on failure.
> These (and the related KUNIT_FAIL() macro) ultimately wrap the
> __kunit_do_failed_assertion() function, which accepted a printf format
> specifier, but did not have the __printf attribute, so gcc couldn't warn
> on incorrect agruments.
> 
> It turns out there were quite a few tests with such incorrect arguments.
> 
> Add the __printf() specifier now that we've fixed these errors, to
> prevent them from recurring.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/kunit/test.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index fcb4a4940ace..61637ef32302 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -579,12 +579,12 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
>  
>  void __noreturn __kunit_abort(struct kunit *test);
>  
> -void __kunit_do_failed_assertion(struct kunit *test,
> -			       const struct kunit_loc *loc,
> -			       enum kunit_assert_type type,
> -			       const struct kunit_assert *assert,
> -			       assert_format_t assert_format,
> -			       const char *fmt, ...);
> +void __printf(6, 7) __kunit_do_failed_assertion(struct kunit *test,
> +						const struct kunit_loc *loc,
> +						enum kunit_assert_type type,
> +						const struct kunit_assert *assert,
> +						assert_format_t assert_format,
> +						const char *fmt, ...);
>  
>  #define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
>  	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

