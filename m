Return-Path: <linux-kselftest+bounces-22837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E49E41A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B190B292DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667ED20C024;
	Wed,  4 Dec 2024 16:52:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CB1E519;
	Wed,  4 Dec 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331152; cv=none; b=V5UeJ+4ZGALZfituz9+PKlSZxej3Mk8/epJc2yEwPtGUSgPUB+4B1GzB4YtFkgIzpBZLe3CnDzO/XJNjOMIU1dYUPJomzz+Faq+D8/qThPK0S85XWMgKfMtw6J6cXHdKyvOI6aB5VT6zzrvAXDhvrrSJpOKFhK/wB7BqTzQZhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331152; c=relaxed/simple;
	bh=2QI/c+5/jYsqxFOIDikQVYFccJVitnHQCKH3LMUXxbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/8O6unS8jKpg7wn/QNGTxrz1QwJuikGLlhLUuXTNwXAW62+c3LVhuCHn+javc2MPgVZnWkia7KyB6y97XGM2KSHAXIYAatMF930eq9PyzdDXZsth6mV3cvQEV4phqLwFYF+mQOJ1JQuTPtbs8Op5DO7LTmcSua+gV4x3ypWBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so427033166b.3;
        Wed, 04 Dec 2024 08:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331149; x=1733935949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1ztnmpZ1V480u0PEjt05LklwDiz7UkUHQQZDIPZzzc=;
        b=pc4XPbgdSjmp90/r8GbUEswEIMOiV2lNJuRFsQSLjwNyHZKTcfeuNQ/I00RUdAtcEk
         3gPyIkhna/OYUyVV7tcoJGCeFDxPbiggdyAfurOtcqEnc/knzkoPWEfo++KWuAHO/huF
         nqXs6Y8Ur0pcFq1ccA+A/nNfDXeUOIXpr4U1W+o1qHOcYxnmQdxlR0AxtOQ05bmVOBjx
         /qD6kkOW96M8snFuT++qVLdycGl/wFbTpVgCtcSykdxUX7vZvPhbjNSLNSbiTZlfeAll
         xr5ja3MOY/k2ujvkuNQ3TIpeTEv3WPfsBcRGOUB4baOdAN5L9IwNNAYEIDC0KDVoSioJ
         ggMA==
X-Forwarded-Encrypted: i=1; AJvYcCWMOeU+Uq+U9fLvG9bPSN936QKp26DMOxNom4V2WPbhUdMdb4d2L1QV2RBQLKhErjmRNgKIerXJ19JhTfwq@vger.kernel.org, AJvYcCWjCd5VVLmdmA+F3If60XX1drMIpgT+MeTQRDvlj2DYYgu8znVp+YTBu2WkjjCyNU5+/jVZEXeQ@vger.kernel.org, AJvYcCWqJi6nQ2Ay0MFnSZpokNYY8w+N11tcvYnWxDwag3Gy5/8wWjtN2dZl8dc8KKhA9/5xAHphfQ6HEdY=@vger.kernel.org, AJvYcCXnln9QvjwH7VyqYXVcTHuhzNjkTB+LXs4e3EDny19hQZjNw52pmFLaiDoHBMWg7SwyzskXsYthNuAmVA++X8tR@vger.kernel.org
X-Gm-Message-State: AOJu0YyyenfkYg69X8YmnY9QQvSpLyCvvSUs+w7B4mMIgsvj4INDVYiC
	FqTo0CnIMrqyY5faJRdspRPnw7iyValIcr55nAQxOt9eX0RBQxHr
X-Gm-Gg: ASbGnctGpqw8coTbnLDriJgrXlkyrl5EvoANG6D63SHVtuaNTJOMHTDijyxZvpq5fVH
	oYS8tcIHUt8eOOr7A7SD56+AT5I21L2isXh3xlvIDnbPuUwr20yBGug6bbpLd2grfEV0Z6SQb0c
	id2u2DDn4gFXjoWRGwMu8gRAd+JsoDUVNenxlTdVBmTFD6uv25MeeiRAScQS4wT2RIHOEL9mbGz
	3FNam/lSi4BXsdi4R2EcxrTDNMG7QCkMPah2IXcRLNvgFjqNQDhiIWid63zF5l41wNavgsB1pzF
	3qo=
X-Google-Smtp-Source: AGHT+IGSdSwmi4IBhdNFu3BxulgaZW3uAZMxnZ/YLVpShFhLHsCvVVRc/PsbZIDqukvgCqtwNxi94A==
X-Received: by 2002:a05:6402:2553:b0:5cf:dfaf:d5f2 with SMTP id 4fb4d7f45d1cf-5d10cb5644dmr7711155a12.9.1733331148802;
        Wed, 04 Dec 2024 08:52:28 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59994b837sm747540766b.176.2024.12.04.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:52:28 -0800 (PST)
Date: Wed, 4 Dec 2024 08:52:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, max@kutsevol.com,
	thepacketgeek@gmail.com, vlad.wing@gmail.com,
	davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 2/4] netconsole: Add option to auto-populate CPU
 number in userdata
Message-ID: <20241204-smooth-fascinating-millipede-cc67b0@leitao>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
 <20241113-netcon_cpu-v1-2-d187bf7c0321@debian.org>
 <20241118183336.34e42b01@kernel.org>
 <20241119-talented-strong-grouse-1f02fd@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-talented-strong-grouse-1f02fd@leitao>

On Tue, Nov 19, 2024 at 09:07:45AM -0800, Breno Leitao wrote:
> > >  #endif
> > >  	bool			enabled;
> > >  	bool			extended;
> > 
> > > +	/* Check if CPU NR should be populated, and append it to the user
> > > +	 * dictionary.
> > > +	 */
> > > +	if (child_count < MAX_USERDATA_ITEMS && nt->userdata_auto & AUTO_CPU_NR)
> > > +		scnprintf(&nt->userdata_complete[complete_idx],
> > > +			  MAX_USERDATA_ENTRY_LENGTH, " cpu=%u\n",
> > > +			  raw_smp_processor_id());
> > 
> > I guess it may be tricky for backward compat, but shouldn't we return
> > an error rather than silently skip?
> 
> yes, this should be easy to do, in fact. Probably return -E2BIG to
> userspace when trying to update the entry. I thought about something as
> the following patch, and piggy-back into it.

Back to this topic, in fact, this is not needed at all. 

The configfs make item helper (userdatum_make_item()) checks for
exceeding entries, and fails if an additional entry is created.


	static struct config_item *userdatum_make_item(struct config_group *group,
							const char *name)
	{
		....
		child_count = list_count_nodes(&nt->userdata_group.cg_children);
		if (child_count >= MAX_USERDATA_ITEMS)
			return ERR_PTR(-ENOSPC);


I've sent an additional test for this mechanism, and make the check in
update_userdata() a warning instead of just silently dropping the entry.

https://lore.kernel.org/all/20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org/

