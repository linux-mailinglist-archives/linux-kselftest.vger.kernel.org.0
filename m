Return-Path: <linux-kselftest+bounces-5170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ADC85DA36
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130F61C23374
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579057E77F;
	Wed, 21 Feb 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O35X0ehm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C37E779;
	Wed, 21 Feb 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521979; cv=none; b=fKWs1Gsxm3JS5jxQeBS/M5Doy1epvMadxsv34J16Rz7DBhGYi2VAB5OSOA4x3YC9ETQ6SsStakFtUWxUsTRj/jfTtFyuPDuyQ3HkZw0QibCYj4b13wKwORsCUa45K+gyVqUB7WKiP/5S6x7Q/6MfLIZ7VBjP1g/tljDBwqTULfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521979; c=relaxed/simple;
	bh=eE3/bomKMDTFIxKQCeFuMaEUWGDLS9gKKCSvRUQn4hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff7PvF9tCSkfTP1f25OCHKCLnyIjm4zZtvdpEdI+bpq4s7uiPndI5KNH+r6KImS75T3BHtXKac+kqwGd5fQ16BxvnN7XFIW78zRFoa/Si3LQqjYTjoZYoxqB5mRIadJAhePb8t0CTlw8ntI0gZIURcNO6hL/rGQWZCs2W1wa78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O35X0ehm; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e471f5f1a5so1785166b3a.1;
        Wed, 21 Feb 2024 05:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521977; x=1709126777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOwKwIo9qeiCkgHyNiwGJN1M6e+EUTE46anx0P12eDw=;
        b=O35X0ehmz8nrDE8ynQYkeFR6w0/vtrqyeiB8kQ488ZQmuyS94hhb/be9MonKk5bmpm
         raJ2Yx+M0mvavcq5QCrvpdNgs5zt9CmKuYBWgywrjT4IVUMf44pz5pkTmTs5EPWYsNOO
         5hgH2OQ2nthGQcXWCg5dY5dukKMDO8gm9S4AGHlHLWcfI4uqiADG71V0uKy5ilOa8TRz
         HSZRniYxy+pIZ7Hc8kmT7yWjBF3YjURvx7Os6u3qvxXSTobtK7uFf2Mc8+DPqvuxw4yG
         i7XDdJzgp5jwMAdDeFm4/tdBzy6W4ltDt0x/z8N+HDQAYdskjYv4otMr0+jEf8rop+yT
         Nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521977; x=1709126777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOwKwIo9qeiCkgHyNiwGJN1M6e+EUTE46anx0P12eDw=;
        b=QkbeiaaFN/iwDC/fjPDaDIlQAJZBtc+KUR0BpbSpB9BEx1OwkI3D6sEmeCAw42wOkY
         6XKWkE+RDiVT/iLk3d1yG/84ftQxs8ouELM91YkWFKg5lxuN1o7j4aVXL/MrqSFfjXEA
         DQmL1hPnHbWDoS2thlV1uHTCRmBoEZk248fatyHpf9DdkdRgR9sdK6kXlhi7fvqllzSX
         e1r2Dxv+HAy2oZ52XD2EdbVutPziMfFKMjZDyn1VIRXL8F6Wq8K1N52cJSyolqEFJ6yT
         y+09PA3G0ecD2Q5HBwx3oSmdGjPLq/3UoDT4heGgXh/3AQQI+zwnyVRrPg9ssdQT/Kju
         uaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs/NGOW5AB2v8aa8TwpMiFtz/cuTjj0BgawVBvZRBXab7i0pS4Glke5GeeoWS//lr6+HQ/oOuKxMW7DhFRNg4ZAip1uKNYqr81IulxzR2/58+6VgIo4hNa9AMV32Bagu5F1PeXh1pvdMw4HEL5JZaMrYE8u1Np7rpDZtpApyin7Zco7MoOIpEktXqgp2E06mTDRKBokjhIJiwgKlMCEGP7fkpY42S+cwyGgosdAJ1l8Jfry18XmagdHbhkyifkVKYT
X-Gm-Message-State: AOJu0YyQxg1+V0xf+nHzppmcgp+LbYBmXZUlmtpSMUmUc88prE9ichZI
	0qNSidSntLor9JYC/Hns+IgvoJMWiC0f1dJr1ZalHlp557Q14ouk
X-Google-Smtp-Source: AGHT+IEpqgPN7zDMA7v77khmYtSnsGRumshpqIw6lmoY7DLU+j9Nal0lhvV42JBX7JUxiyCDJ01QUg==
X-Received: by 2002:a05:6a00:2196:b0:6e4:5dc0:233c with SMTP id h22-20020a056a00219600b006e45dc0233cmr11468603pfi.6.1708521976589;
        Wed, 21 Feb 2024 05:26:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b006e46df9f1acsm5269415pfa.148.2024.02.21.05.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:26:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:26:15 -0800
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
Subject: Re: [PATCH 6/9] net: test: Fix printf format specifier in
 skb_segment kunit test
Message-ID: <1a85d2bf-e38c-4fa7-bfbe-c80148b50317@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-7-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-7-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:19PM +0800, David Gow wrote:
> KUNIT_FAIL() accepts a printf-style format string, but previously did
> not let gcc validate it with the __printf() attribute. The use of %lld
> for the result of PTR_ERR() is not correct.
> 
> Instead, use %pe and pass the actual error pointer. printk() will format
> it correctly (and give a symbolic name rather than a number if
> available, which should make the output more readable, too).
> 
> Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  net/core/gso_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/gso_test.c b/net/core/gso_test.c
> index 4c2e77bd12f4..358c44680d91 100644
> --- a/net/core/gso_test.c
> +++ b/net/core/gso_test.c
> @@ -225,7 +225,7 @@ static void gso_test_func(struct kunit *test)
>  
>  	segs = skb_segment(skb, features);
>  	if (IS_ERR(segs)) {
> -		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
> +		KUNIT_FAIL(test, "segs error %pe", segs);
>  		goto free_gso_skb;
>  	} else if (!segs) {
>  		KUNIT_FAIL(test, "no segments");
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

