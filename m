Return-Path: <linux-kselftest+bounces-44875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1332EC395E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 08:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E3B3BE7C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5992E54A8;
	Thu,  6 Nov 2025 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgiGz3vO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="USLIWSv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66B2DE70C
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413230; cv=none; b=f37dLzBYyt1OAQkzyjfA2VMwIrb19Cp06g8mixSYVYhYtuyTpSuqVjNvO9VxeVZ5OTxiVw2sM1JDvOECgRwM4zjn8agj9FCMO9lPhltSZjjAUW2GOG39x9QMYuk/9kkjJcxj9YUziRC6Y1efpzkBYAlisbLFohILyocn3LJufUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413230; c=relaxed/simple;
	bh=O8Kuzgwo8NxVtUGQ/sqROsYTAZBIAHhIOZ8Fv83q4tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0pVxtj7kvEBBsLR1ztA3dfM6zPZ/1LnCr3GbehuiCZ0GwNJNhinTZ/selASng9/a42GVm6kcEUVXydtD0l/lXpuEP2OcvXnbGebUeER4UBaZuQsaKwoA+8E1amFnb7DywoXbUHN994jysSN8kutxgLhl/wDSnwDkSNx3NQk7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgiGz3vO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=USLIWSv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762413226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
	b=BgiGz3vOUFyK1nci3w+69HxNd80AQJ/Uuckw38Y12hG7G3QvL4dUzltLOKZ/p1U9CBmU2V
	AKbqBppNzgixQfvyiZB6amZkBRixmSWV3zy/O6VyNtetfiToHNtVVTufdYkrrGZmgskpX9
	lBDgYLugOIP6cQMoCfk5X4elgy68uEI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-c6aadBWCN5ihQxzXkA4Jzg-1; Thu, 06 Nov 2025 02:13:44 -0500
X-MC-Unique: c6aadBWCN5ihQxzXkA4Jzg-1
X-Mimecast-MFC-AGG-ID: c6aadBWCN5ihQxzXkA4Jzg_1762413223
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso4007745e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 23:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762413223; x=1763018023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
        b=USLIWSv8jzi0XwvpacddR61/GSGBEEnW5HqdAGi9dOuVt5eZynS6+qOaziAkKnePa9
         WDzk/xevrJWhayw3YcdI52DeJEIyK/22xcwKQJs3uq91aj0whaQmsO2CkZAhe1vgI0Yp
         cfS2ZgeezRcKoLwpUPPZ9K4bKQu4DiKcp228wb0piIcBSUXXCOcb2zSnUWY7WWswF1K0
         NB1fPy2YNDQyfSMUrICVtZMABsGHF7kSA0zt4vJ0Sebet5o7DDBjqtuxhsITuURArDct
         w53a95XJwsFu30b1LXQj04HYoAkKHpHxSU1J2Ntn3P+WQMtSozboh68GD8UkPh2B/8v1
         Df8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413223; x=1763018023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
        b=hAB66KZzO+mIpb3b0O86I8vWpP1vKl/HaCC5WQNC3QyEZ3qKaP5EBwdb343fDQrsXt
         Kjud4y7G9Xmz11z41vmoZ3l7vaJ/q4UxNXM4TeCmiNg0qivGH6I6IbLg2iqBmA3oMtAc
         GPN7RlNo+Ne6VMbtVbcISKi88nj22W+j/gt0RUY3P+xvRTmkK5M5ARZWgiODJJ+AMQz2
         rZxMywR5+yHW56o8hyG4lxa2Xz87cEerrFtkkcb3iaBJrZJzG21lLc8qnjQrz+Oa3bx5
         4n5yyfeCgyEU47QKR1dvkWutCbGn9T++YvYHTvt2RCS+LOi/Zp7BjF7HJGU1jb66wpQI
         PIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUtLN+XxQP37yERJ/lU1JMISJalul1idRsFjx/kOXVB5ug8y3UTW7/4g6CPkF6u2eUdyh1f9+i/2BAEjwe8Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxxA+qFc5ycFlllEbFZbFpCKcOnLXJkJT1SvF18jRLftiar0v
	84MYg/+NVPqlFMqVnXwXxjzfJ5YIvggpyhE6GKh7ZKyxdchs4Bw185RmUK9N1z2Em01Kf6Aknaj
	eSKoZ4Kj9BM6+Jr2zSMwYTWPWShAqaSRsy/Ejhfda9fPbBdWDUSxqhUF3PVoXzqukfgrR6Q==
X-Gm-Gg: ASbGncvRWnNeTxuePONn4CCQb3TNrBHe4xyRXW2GvQnAscG2RH+7mj5q/F0tL2cknQW
	VaP53vkbCQEKZhxAKh384L7ha9H3Mj/rhW7BalVvicfgU1SNPiWOroydXTl2Q/7x/skewQwOWZO
	l1a9s0xKpNPS9JtHN3+LT0RsVsXOzbhbyl0eszq9piFKZ1gek02H4XKMl8ECbyRQ2T8+u24Pitk
	jGUsSM171ogELOvVQohBvAzZaSVpBiyWdTPkPenVq2sE1TZHEXJaYH/XVG1rRKg2saSnrModuRH
	GIml0298iJSWUU0M2jsWAHG1WrDGxcsa2WLbSTJGSDwQv/4v3xiZ7MZHvwJt3CHeXE8IW5q8v9U
	0jy6JJwDjXkoJjv7y1jDc3vdzf8SZwA==
X-Received: by 2002:a05:600c:3112:b0:477:54cd:202f with SMTP id 5b1f17b1804b1-4775cdbd575mr53958305e9.3.1762413223132;
        Wed, 05 Nov 2025 23:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUu7ukY7OdyVbeRYFijYbMWBIebeXNAL9BcWIWvL8Cng+u4L3PwJcTQmxc3W42nkhzCF1KSg==
X-Received: by 2002:a05:600c:3112:b0:477:54cd:202f with SMTP id 5b1f17b1804b1-4775cdbd575mr53958155e9.3.1762413222738;
        Wed, 05 Nov 2025 23:13:42 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4adde4sm3235490f8f.46.2025.11.05.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:13:41 -0800 (PST)
Date: Thu, 6 Nov 2025 08:13:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029191111.167537-3-arighi@nvidia.com>

Hi,

On 29/10/25 20:08, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Currently the DL server interface for applying parameters checks
> CFS-internals to identify if the server is active. This is error-prone
> and makes it difficult when adding new servers in the future.
> 
> Fix it, by using dl_server_active() which is also used by the DL server
> code to determine if the DL server was started.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/debug.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 6cf9be6eea49a..e71f6618c1a6a 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		return err;
>  
>  	scoped_guard (rq_lock_irqsave, rq) {
> +		bool is_active;
> +
>  		runtime  = rq->fair_server.dl_runtime;
>  		period = rq->fair_server.dl_period;
>  
> @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		update_rq_clock(rq);
> -		dl_server_stop(&rq->fair_server);
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
> +			update_rq_clock(rq);
> +			dl_server_stop(&rq->fair_server);
> +		}
>  
>  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
>  
> @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
>  					cpu_of(rq));
>  
> -		if (rq->cfs.h_nr_queued)
> +		if (is_active)
>  			dl_server_start(&rq->fair_server);

Something that I noticed while reviewing this series is that we still
start back a server even if the user put its runtime to zero (disabling
it) and I don't think we want to do that. It's not of course related to
this change or this series per-se, but something we probably want to fix
independently.

Thanks,
Juri


