Return-Path: <linux-kselftest+bounces-9295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5088BA367
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD2E2839A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C332D1CA85;
	Thu,  2 May 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J8qjv+4O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31EF8C1A
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689663; cv=none; b=WibsC89fvdORLFnl908kXAA+7H30+Ga94v0zNEWV1dLY19zIOcUM3bCTjFYTjsaVJBCbgmNTqzOuhgSTYAGcj1TkPxhlyOTqOSv1oCwvGbpHrT9Af7Mw7R2Jf+U8eurVxP7BYZU9f3Tl7nGwvLhYSHYw1pEq8O0j/EMHRt6yXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689663; c=relaxed/simple;
	bh=bzyP4Xdw6nGRMa8O/ZIWOZc2YGpey8Rpt1THkkiSlKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSwJh+U4mYWVDJaVIJnEl1GtyaQ2ET1vnZZW8y65CNYRq4foUcH58od7SnAuVX4sB8GtC0iJcrc0Kt3qtAtQ5soyDWC41g40K0W2dQlSrYXxOFWc4Xn6P/fWLMZEieNEWtKeuMk8Dm+UsmTK5C9VevdEnIGe87Dn96yd/x+Gj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J8qjv+4O; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso170678b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689661; x=1715294461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L9jD35jpO4uNtUxWEojKtoKI6VMvNDOlsLmuwoeTBY=;
        b=J8qjv+4OwWekS+smq2pAOO2aD+7G0zxDDskE6DxYIMEFCqOJDEWRbgw67BNbn/LqVp
         /dF4BxMfu/exf8AdUS3KFyACeksI+tvM7dHgD2xT2KgOJi96dSQomKCnPmIE7NeiHkcA
         3qUG8xEx6vCC85Cn4OMcuMtdSxHYd464PTSqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689661; x=1715294461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L9jD35jpO4uNtUxWEojKtoKI6VMvNDOlsLmuwoeTBY=;
        b=YOL7EDFSBy+a7rYi2bVfFJC/iD8X8HVb963X5mS+AhRHOxIP4u4uWIFzSbnonpW7hH
         7via3vlA3Qj8JdpqMYXBYBzfY0lxR6VmYTDtigDBwkWvFX7WGVfxE6wsL9fwQL0qmUIS
         OZvYjgsov7kaq9EcpwytTSSYEcZpmCTZcp9T4iMreaOO+v/SWSRsxYhK0/FiEzi7YPa0
         HH+sF9mD/Og5/haJindTjsLppARiwbWUa7dv4ys0p2gbW2/F1BqjVEA7pyDbxxi0BLAn
         I63nR+cF8ecy3kuzJkB0uDcFvfdB5WrVqAV8Fb4CxbZcOb75AZdTtRp8hAarFtUofmwq
         ZFPw==
X-Forwarded-Encrypted: i=1; AJvYcCXx7ZaBqYw84K1jrMVVQM7U3ZQtNtLuUOCL5Gi1MS7WTYf1gS9ydwUs4EbjRMTi+tBZL3LW3iYHUoBUyY/oFjs1EdpkQke4YoOTvuyS+Xru
X-Gm-Message-State: AOJu0YxrTWVy2/PAbHvuDtOeNmkmdvAhB7pU2WzrA0yM8o5MhBjjBj0M
	A3DsfkQzlSu0rDpdcDzxMng96yHiMivrNddSHpCFDY5SLmxBG3O0NWVg1arz1w==
X-Google-Smtp-Source: AGHT+IHT/crKZRZ/k6RhvANBVZPADnzOe9chhI8JjANxhrQb7VX4JbkZba2YNbbf5dsZ8cKd3o/FlQ==
X-Received: by 2002:a05:6a20:5530:b0:1ad:8606:6484 with SMTP id ko48-20020a056a20553000b001ad86066484mr1120307pzb.8.1714689661156;
        Thu, 02 May 2024 15:41:01 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s185-20020a625ec2000000b006ed64f4767asm1845468pfb.112.2024.05.02.15.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:41:00 -0700 (PDT)
Date: Thu, 2 May 2024 15:41:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Mark Brown <broonie@kernel.org>, Edward Liaw <edliaw@google.com>,
	shuah@kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Define _GNU_SOURCE for sources using
Message-ID: <202405021540.3FF73DF47@keescook>
References: <20240430235057.1351993-1-edliaw@google.com>
 <ZjGiGq-_kUVht63m@finisterre.sirena.org.uk>
 <ZjJClMYEIyGEo37e@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjJClMYEIyGEo37e@google.com>

On Wed, May 01, 2024 at 06:24:36AM -0700, Sean Christopherson wrote:
> On Wed, May 01, 2024, Mark Brown wrote:
> > On Tue, Apr 30, 2024 at 11:50:09PM +0000, Edward Liaw wrote:
> > > 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> > > asprintf into kselftest_harness.h, which is a GNU extension and needs
> > > _GNU_SOURCE to either be defined prior to including headers or with the
> > > -D_GNU_SOURCE flag passed to the compiler.
> > 
> > This seems like something that should be handled centrally rather than
> > having to go round and audit the users every time some update is made.
> 
> +1.
> 
> And if for some reason unilaterally defining _GNU_SOURCE in
> tools/testing/selftests/lib.mk isn't an option, we should at least have
> kselftest_harness.h assert instead of making a futile attempt to provide its own
> definition, e.g.
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 4fd735e48ee7..6741b4f20f25 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -51,7 +51,7 @@
>  #define __KSELFTEST_HARNESS_H
>  
>  #ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> +static_assert(0, "Using the kselftests harness requires building with _GNU_SOURCE");
>  #endif
>  #include <asm/types.h>
>  #include <ctype.h>

Yeah, let's fix centrally. I like this approach.

-- 
Kees Cook

