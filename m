Return-Path: <linux-kselftest+bounces-8218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B2E8A74D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17191F21BA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AAA1386C6;
	Tue, 16 Apr 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU5V0bVT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DEA13541F;
	Tue, 16 Apr 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295969; cv=none; b=T4BP92vnhL1zdfyZg0jcPN3LF3cBuqtdScufX/Y5BWZMbGmV9VGIML1Zs7LorOTj3sGJ7d9oQzT0vo3HVTlg37Co/Agjnl4jPU2lcnC2KhkcLAkt9euHXJ5Qnryi09xyegHWhEYjv03AIIb5AS3ca4VT/DL1cK8iNX9FwTZj48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295969; c=relaxed/simple;
	bh=I/hO0eOe4YB6IzK+K1OjKqka2paD2+CJJ6h1/oiAmAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICvDKZ/r5+OdbjbsPFeFmEtXKszILis5pg66ujR/75QpWWpepal8mA4mz5uoYlJhmGKIoZeO+0VUQORPIyBCq/rOz3Trt6PknCWdgzYZ9xu+MWGZCySs8rLsHMxr+AToxcS54dxUDPjtFpDja+l9vcPQHUz5RKlmfuHPNLR3jfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU5V0bVT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3f17c6491so41201315ad.2;
        Tue, 16 Apr 2024 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713295967; x=1713900767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEDpy+KIDUbfpAeVl3AnQZ5WnXTO3Q8SS3ZqkxRNcqQ=;
        b=BU5V0bVTB7Y/yV7gL1rSr1QbF9U3PYLvSgJA86SixydqPaUGTC/NT2Rq3wS1z3gost
         650gWffwcM9Ka2/1FdCRD5DdXIzpzsKI5YVl8rd5+fdrFdCY4+7LtjlF0ec9BBesSEaY
         1Ixa4eLV/azElt1HZ4E1lu+e7lQjGGyY7yYcP6IqMMlRPWamcX8WgJM4ytaNzYHbM9g2
         TrccC1u5/ossIzdCrhqdGIv1looqWD8lRC9Sbq06h2nlkRyYfIeB50UuPgZfcYk5RHf8
         NADXQgNGdknP/IvA6A/BjvJorwkfpYbMUIh/kiWMfnoH0KIezCiGSV3rwhNi01K5QcZk
         6b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295967; x=1713900767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEDpy+KIDUbfpAeVl3AnQZ5WnXTO3Q8SS3ZqkxRNcqQ=;
        b=XjcRSJBunm8zsNn5zOeMWCux4GeVc9rQ1QZoTHlO1zfspsxo1shS/Shl08U64LP0Uw
         6foi7wRvVnGS5RYlmp9jZJil4iyqsA/GudMO7qNx62DkD2trA7iqseDNpud8iZrTTH4U
         +BVnfeqyZKprwCgTe0J2MsJceYWlacfS+4E4Vc6wAycw83+yvoIGlyS1+QqDBEGJA99c
         TO2bThxhG0iYGEEJfSF5Dkr4NfBeJRFhUr6mucLQoP+HNqm3QKIm1a5AmYz5dvUXled6
         hxpJBUBqxKhHkliTElMg71qiuT4BhWdpTILQhjDYQVrenSKjKT0GvbynY19f+TFnZpCq
         Wtkg==
X-Forwarded-Encrypted: i=1; AJvYcCW64BmkA9cByQrmWcLRLbEtWs+I0hplf237eV+NLM4sEyzTB+guoDmJI19mPnjayTTxGBUT0drowy7569aQZcIYNRZ8bPlf1ME1GV3pjanLLDPXx4yBbarBZGxL2g5I5ahBOpht0hc5pEM07O6bhQUSm9JYyLTvJO8+O3JrOhuirdBR5X6KRum0
X-Gm-Message-State: AOJu0YxzA/bAEzZNMX41xh4CSzaf1kLbrM2v6E/fCX6KJRwBc9BrIG+q
	Mb6GEw0+yYYAjKlmNDhOfHX10szV1kMz3cFPV6A5qmZEbf5xCUG/
X-Google-Smtp-Source: AGHT+IEbbLHhwWxyXlCIk8S/OXxwgKIsI413Xgv8iveLC01IeJL80AMj/0wSuruUOvFGACrPYE4apQ==
X-Received: by 2002:a17:90b:3b48:b0:2a5:24ab:1a94 with SMTP id ot8-20020a17090b3b4800b002a524ab1a94mr11123312pjb.49.1713295966910;
        Tue, 16 Apr 2024 12:32:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id g33-20020a631121000000b005f05c9ee8d3sm9019948pgl.93.2024.04.16.12.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:32:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 09:32:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 0/6] pids controller events rework
Message-ID: <Zh7SXQSobt9qIQRG@slm.duckdns.org>
References: <20240416142014.27630-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416142014.27630-1-mkoutny@suse.com>

On Tue, Apr 16, 2024 at 04:20:08PM +0200, Michal Koutný wrote:
> This makes pids.events:max affine to pids.max limit.
> 
> How are the new events supposed to be useful?
> 
> - pids.events.local:max
>   - tells that cgroup's limit is hit (too tight?)
> - pids.events:*
>   - "only" directs top-down search to cgroups of interest

Generally look great to me. If you resend with the couple nits addressed,
I'll apply the rest of the series.

Thanks.

-- 
tejun

