Return-Path: <linux-kselftest+bounces-5237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FEB85E987
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 22:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0089EB21FC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F626126F2A;
	Wed, 21 Feb 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDgPqCbq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD684126F0F
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549625; cv=none; b=Alh/QUPQJskDc+eoLKIdRYZiOIsIeZ7EAUspv4yK1fKvxdhjota/iS4jyOUrfZE+mcaFH1gh3uWb/qphYz2TUVxatisKdmMVriKOenCjg4gRfYfYY5nPtMDRar5/RTivHWqcvBzXDzi0xYbOLJXAeHC6IoCkOob7+5rROkZZ88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549625; c=relaxed/simple;
	bh=ji6GCepH8kSSb47OKXAEdHfFIEwmtzu8M/MoXQ+oc9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3FdUFoZw0H3WAnfOBQ73eDz0TysV4nAABFY8Dhwe2zTP3gHCH4AJf/KFAZckTwjgBXiyMzafUkzDlvfKmwDfwkM3sEe9GbJ8BMbkfYZ976wyJXFJcDWMOts3gEN53g++QXQ4EovVqyP24WQpRbFIPye/+4txlBDnq9pp+2mQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDgPqCbq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36503a4980aso2897355ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708549623; x=1709154423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAAZa1jDC6WKP3dR2NzQXLtAyykABKSP5MJcfQiYXKs=;
        b=fDgPqCbq+GFEfg5A2wEHyR/30VAq1XmAp+VwLsxp81acdyqCFx6qjMA4MV5hzxd/BR
         +tP9OX66qAagwV5UxuwZ6Gd2TvtSBxxKnfxc5yIEwVwIzxXMKsbrKnKBMjAs3WGRPyMN
         UO+3Vhoacs4PEcIoDO1KSO5CSy5Kfs1tFR6NPWiKOA5K4fhr4ekZ5N0nlm1n0U1CREqt
         jSIikTx5Bj7/7Uc/wBBvk+tXW/zLFcrMvTsJh0SWNyHb1PVGQJ31sEn0ryCswfoSpAvo
         YGmowUENEXOjgrK1nZ9T34xYJ4Mimkbu5xxiQIJXECJbvUqfMOjJyOrkXSc2+xGxtNVP
         CZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549623; x=1709154423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAAZa1jDC6WKP3dR2NzQXLtAyykABKSP5MJcfQiYXKs=;
        b=I2UfCi2+Vpng2zrnuFI4mM7UtDb+ZnaMJLhIsNSgiM4tha1IdxkyA0I6m5oRO4lPBF
         NNyXtsDibcKWZvHec/QUWHJD1Cg6GIKNs+YG2DzjkGGHS5atqPnmNS95/WcmlQHW/g5n
         XxReXBxY+6rN+7ezrlqZ4OWvw2gzgc2RRgyBZ9tk5z001BMGYtfmEBQx2vtyI/A1uyge
         f12RfLPvS1q/AZfhXz5oLqLaly5yieOm1OKC6LVJR2O9Yv4ygZPDAkr/rVaaz84ltxXr
         iNDbqZneJOkV3671aqnlXuWvrnZJI4kKA3rsGszcAPRvjbknVTiTkoehJNGUjFIR6zjI
         xS5w==
X-Forwarded-Encrypted: i=1; AJvYcCWDDA6o6XMsZFXii/YsTzAFkXSpGauwRhcU85xeVMdw5gtHX6Sb6POZNgDCTgiFTL2ll33Qm3kB1e+j5KFpXFVXT8iB6EaBDgqNn4Oru0An
X-Gm-Message-State: AOJu0YxSMZ3GqRCyenQ8BZofn9ag4r/51N4S7xcZwK+XXvecQxcKuYln
	D/wmaQzCeR2cIvaQ3K7rb15aecnw3oqAYYFGrnR49O6I9WFln7y9AIhgR6jT1A==
X-Google-Smtp-Source: AGHT+IGat+ZOlE3TaiF7TUr34C9oDGm5EHv4BN9HXA/+oFvVMsLjUVwjzy0AX0VUmgXwUPrLBRg1OQ==
X-Received: by 2002:a92:d790:0:b0:365:4aa1:8bd5 with SMTP id d16-20020a92d790000000b003654aa18bd5mr5504674iln.5.1708549622918;
        Wed, 21 Feb 2024 13:07:02 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id bd6-20020a056e02300600b00363807d5c4esm2799990ilb.13.2024.02.21.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:07:02 -0800 (PST)
Date: Wed, 21 Feb 2024 21:06:59 +0000
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
Subject: Re: [PATCH 5/9] rtc: test: Fix invalid format specifier.
Message-ID: <20240221210659.4p6cq4lhmoz3eaqj@google.com>
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

Hi,

On Wed, Feb 21, 2024 at 05:27:18PM +0800, David Gow wrote:
> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
>
> This was found by extending KUnit's assertion macros to use gcc's
> __printf attribute.
>
> Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>
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

Thanks
Justin

