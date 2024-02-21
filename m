Return-Path: <linux-kselftest+bounces-5169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A6185DA31
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C361B2712F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF447E76D;
	Wed, 21 Feb 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3cSEKxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C17A71F;
	Wed, 21 Feb 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521970; cv=none; b=BmrVc0F3ZB4h8VvJekAyaAL4MLyQVCxVltTJDABTR1Fg4XiX4tDBcQO65doCVfP5P2uPAVkH0ZGmeW3XC83Tc+U0srJxse0Y2+TiNfIPyDNtjiTh+EAlPmpvtNc0+amzpPT5I5chu/CVuf3iOiDOi7aAG862Q7mLV5PxBpu8KoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521970; c=relaxed/simple;
	bh=6HTvQtivvUv0sLJZm9J7JKqLkCZa0evE7Yw4Q121nDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiN4fIZZ1xpqZQi+HpleelyViuk1J+hI3cEZfbXpLFBKc1mzr1QwURJOdjBdgKnYA2MD/mv8ILAeGyPdtaRL5E1X8+C9o5hljzDOQp2Ecy7tF+sgDetNz6PdlzqMxqCpjsYwLYyGrbVrWwDvAGOIFZ0kkOCIbClpekmog1p3MfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3cSEKxW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so2014883b3a.3;
        Wed, 21 Feb 2024 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521968; x=1709126768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WdZMlL2NstZAHt9MPKQqrlpZNmq6hiZjAQCRu2gHes=;
        b=Y3cSEKxWIxMbZW1mze4kIniDTJRRdly8f2hTpX94+3vYarBILq8EGISt1Ma9u6CRC6
         nECQ5knZXEDh8US3q3EIDXUssd4tKDmAAPbjMU+bJ83CgXDAsjVEboAZu6SpgnG4u6/b
         ksUF+H0ybmjfLq1ToLhgb31sYQZK5OErer5GL4o34OPB3YNcOSoAu+httZQC/oDFrBQe
         YfIFUNGOgUc7Q6TBlkJUSunIc0zSXZnMZQd9RglNfHVRxRgzy/bOeH7cI6KR7IEZcKjg
         rYWGPBQwMgITLA6dX/puwmOI/skVqwqbRhlIwKspVhIFeQNA1UfxkzhoNlR9np/elQGN
         tC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521968; x=1709126768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WdZMlL2NstZAHt9MPKQqrlpZNmq6hiZjAQCRu2gHes=;
        b=L5Whqh6d0UFASbO8KBqbibVfVRFr1FQWaMZaF5i7cWg4jsTj3Tg49vlV67jLWDqFHA
         mwqOzSZr7xtIuwbqaGPQLEA7Yyhih1JvqkG6l5gZVRnM3+qyK7uSJ7GRP6N71x2RvbY+
         SBfbQtrD8GsEfPuHuI+NTElHqxl8JLdAOeZYccp2IXeskjLpPzDgIcempM2D8AXZgrgV
         XphC3+TRcdWzBR8jJ5wTVRtX41xAdpMeNeoWXbrIl5MFMQIvc7sdQHU220XH1ZDXiU1A
         aeSu+TB+/X9tKcBNbBZfFihLwb4SLd4Fp3dx2KxoQd9N+MGmal+54AetdDwWpXH+Valx
         ZitA==
X-Forwarded-Encrypted: i=1; AJvYcCWeuzh5KKDbC5cuoT9nt1t0O2z+Sz0AbuJQlOaHBmKCivg4Ab1AvjeFnDYLcwwlEHhbsrnPUf1qzEvW1VECTHS//vh5LfrDXhBo9RuDf/Y/KLNVKN6O1vE41XbSCiD2c2c154D1wfFS0LhZSoMroSyPRkOax2NvAMRXBisYK+C7isEYwubv9/hZje91yQzuRy+A57xH72nWV6yGpVDMchPtEEyBjUZne1qUnZVD3wxy8O9YQCgq+OnL/orHLqv3O/SI
X-Gm-Message-State: AOJu0Yy9h7oBBztHe2eSgkquTlk1Qdx4d3zJ8VRn+SZZRu4j6Fhkbk7Z
	p13+nT2ns/edeE9fPnb3NXeV8/fUgwFBn8BOhpToUnG250rDFT6O
X-Google-Smtp-Source: AGHT+IFgfVve7IiqOMiET8ReqBSTf0PZGpuUUSOUxAlf0ZKI7g9iOQrLpYHKBMVPCKUI2YjVR4orQA==
X-Received: by 2002:a62:e10d:0:b0:6e2:9ff2:19b1 with SMTP id q13-20020a62e10d000000b006e29ff219b1mr10316723pfh.13.1708521967791;
        Wed, 21 Feb 2024 05:26:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b006e4751b964asm1599291pfx.205.2024.02.21.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:26:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:26:06 -0800
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
Subject: Re: [PATCH 5/9] rtc: test: Fix invalid format specifier.
Message-ID: <11e8fe13-3d10-451e-8a31-d273c9d9ea1b@roeck-us.net>
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

On Wed, Feb 21, 2024 at 05:27:18PM +0800, David Gow wrote:
> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
> 
> This was found by extending KUnit's assertion macros to use gcc's
> __printf attribute.
> 
> Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

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

