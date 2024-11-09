Return-Path: <linux-kselftest+bounces-21728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9699C2E9F
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540F61C20B16
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B519B59C;
	Sat,  9 Nov 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfK3obs8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E878185B62;
	Sat,  9 Nov 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731171623; cv=none; b=GP7URYzA/z+bNJes2E+N8nzBkfPxnMZyVgq8K1hhL+xbCrybpJb4JaTCagyNsNQVqfLponjpV/AZ4/m4u1Eml42VxE04U4d8FQng1MQVJ6gC5jp1hfsLv7AMr/aVhjlC0FawBLy8UuG0UXjiRj1viw4q1qUHlJGJ6VsNW18FS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731171623; c=relaxed/simple;
	bh=u5scnLZLwY2FrTEPy1XtFTVHaKQX0cobUjw+HNnOA8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzkIQCa3hgk5ApH+AvEn+gohiKwPfl+wAPN5CZss1o4HpJCkFnL9tiq3TnTS6VwNZSl9QMO38ptO3o4FhfiOxh47VHb1BLLSZgT3XnDFmvVU5Qa503IquT9AzrxfeTKOiMLCbLu08DXaB4m+9JTZuGdk1+uBzWz4h5mVb9Llj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfK3obs8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2172398a12.0;
        Sat, 09 Nov 2024 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731171621; x=1731776421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4v2BrVPkFAdgLqCbQRyHL6NHvgl+OQEh3RGuNlf+/k=;
        b=DfK3obs83ppXilif6P3ah5KL0vcoh7TsnWFMGTcO1K6VJi7W6WkNOReGiP9TgYsSBU
         Qr2vnWm3YUdd3cfXTztiwcVsOq69sOjmlusJhRJkB4l8/IDzX+9t4zuxP5q97NkqJmJ7
         skgq1kOoW9y0+YHUbaBiYz0ywcHhP5cC9OdXBhkjNb0sEMrOdZ5fJSWPHnzSlPkVRj7X
         dBFGE1NYiXM8tlhpe7ABN5REB3rUUV9zxhRnLDVbS4YUhRGZzKEm23frSMZIFN37Wnx/
         qZMX0HVT7DPH5legjfd71BHoGKdWHb1TeeeJ23PuQyhWUkaTQoVzQHvPFoOW3brQXjeo
         dMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731171621; x=1731776421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4v2BrVPkFAdgLqCbQRyHL6NHvgl+OQEh3RGuNlf+/k=;
        b=Wa80cFqypcY4d1Ktsua63kG0ogJ4xHSOtw3zvGFSw8I7DcSgJng2es4wwf9YDkg61K
         QgxB7fS1tY0+jGGG2kIDqHw6RMWT440i2zrIConP5MM7kvMz8CKJZLMG+pnW/ZXdpX79
         X2mCvlPOnNW3lS6kULm6YWLNXJDQXSnMZKK/VRbaGGeSNncdzBgchUAeLukiSYrmIKIL
         BQm3ncM9tFut95EJGsW2DMIu/5kq2B7+fwGvfUP8iiJWc9sB3dKqNpJttJf1SdAsVAMK
         LX37+KH3F6WhmkfKEvFEi1H/QmpDOxaMnmrMu3jfr9IVpiwc8QEau7Lu3A5AjkJqHP4y
         zNgw==
X-Forwarded-Encrypted: i=1; AJvYcCU1jQJT7GeIJhJZR2vhLqyFtxBPgTECoZJlzhEof/f2j2tSxmGoH0uc8vfuvDBOC5T+QL54OEezX+jP3O20OSym@vger.kernel.org, AJvYcCWfu5tn7arvgoPgmR2uSekwHg7XU3yWpXF/PzmsFE8hCEDOgkX4nzRPzFQJBjwPV81mLW+c115dDm86spyp@vger.kernel.org, AJvYcCX4F3O5P3f70ddtQdS1IWthk3vdiWAzqssSoISf449jLCpBfaTJ/83x6pEdXDQAWfl9naxS9HeYk48D04m9u7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLaeBjvVOsJPPX0IuXv1B+UIYXvpYaTnznD0tmuJ0Kyb1Ntyls
	vryzF2QvZfLR8wQtu5MshAnQDLoWWRKdUDnvtO/z6oNsS458HuCH
X-Google-Smtp-Source: AGHT+IGOskJ4MODwLJWxMgYhRx/EKHJ32NRWIqV7i+O56ZXWXSxb+M483n2T9botM5pIAd17tzKx/A==
X-Received: by 2002:a17:90b:2f0d:b0:2e0:80e8:a31a with SMTP id 98e67ed59e1d1-2e9b174633bmr8519338a91.35.1731171621404;
        Sat, 09 Nov 2024 09:00:21 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8292sm48922305ad.46.2024.11.09.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 09:00:20 -0800 (PST)
Date: Sun, 10 Nov 2024 01:00:17 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kunit: skb: use "gfp" variable instead of hardcoding
 GFP_KERNEL
Message-ID: <Zy+VIXDPuU613fFd@visitorckw-System-Product-Name>
References: <57a8d38a-6299-4d2c-bb2e-c9d1e3bf1c99@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a8d38a-6299-4d2c-bb2e-c9d1e3bf1c99@stanley.mountain>

On Mon, Nov 04, 2024 at 08:16:30PM +0300, Dan Carpenter wrote:
> The intent here was clearly to use the gfp variable flags instead of
> hardcoding GFP_KERNEL.  All the callers pass GFP_KERNEL as the gfp
> flags so this doesn't affect runtime.
> 
> Fixes: b3231d353a51 ("kunit: add a convenience allocation wrapper for SKBs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

The kernel doc comment for kunit_zalloc_skb() is missing a mention of
the gfp parameter. Additionally, the comment says "Allocate a new
struct sk_buff with GFP_KERNEL," which should replace GFP_KERNEL with
@gfp. It might be better to fix both issues in the comment together.
With the above corrections:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
> ---
>  include/kunit/skbuff.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
> index 44d12370939a..345e1e8f0312 100644
> --- a/include/kunit/skbuff.h
> +++ b/include/kunit/skbuff.h
> @@ -29,7 +29,7 @@ static void kunit_action_kfree_skb(void *p)
>  static inline struct sk_buff *kunit_zalloc_skb(struct kunit *test, int len,
>  					       gfp_t gfp)
>  {
> -	struct sk_buff *res = alloc_skb(len, GFP_KERNEL);
> +	struct sk_buff *res = alloc_skb(len, gfp);
>  
>  	if (!res || skb_pad(res, len))
>  		return NULL;
> -- 
> 2.45.2
> 
> 

