Return-Path: <linux-kselftest+bounces-35004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E613AD9C7A
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 13:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B79E1893F9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 11:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACF2737E4;
	Sat, 14 Jun 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHW8qs2g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55E272E6D;
	Sat, 14 Jun 2025 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749900332; cv=none; b=kyukAQMtkAbL2p7l5BhN56aOKuH4XSqrzRgNufXvW+tTvfYeA5puVqps1MX4jEYcura/VD5S77t4EGKQwhqgVN/woplhHhOztkGwn3nPM7/tehMieW1PGd8AUnjSycBjoPyE7H7zZzUMuRpI2/zg3gFuK6dPp5zFLOD7S9QzYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749900332; c=relaxed/simple;
	bh=hVRY+sNaVJCX/22UrodYL7lTYjItuQhZZBlWTI+k1yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi79rfQKrB8hfWzCJAKTnyVqK9IWtQw9SVDkpd94Y3Z74l9cZ28U1ZWPVlyrZmMpFs/QtWd3eZyireATI0pn9MasQI/zWSYFLlpQHYwel+aeuVErzfr5NyNEJs6eSGSk8MAE5e+EiKrqRD82nvhg6bbDEERbt0nG9C8YFhMJFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHW8qs2g; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-551efd86048so2801800e87.3;
        Sat, 14 Jun 2025 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749900329; x=1750505129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/55vMuY3MFkevHEM5hX66L59C6pwFDgIm2rAf0kmwbA=;
        b=BHW8qs2gEznZIzGT4kBurOyUHwnNlTM64YH6vEiVKyhDb6BjxTgS/9NKS+ToLPfwUr
         rGo6QTbMLfOa77eIGGjGZh+RM7vrzIJW6kDgQBZ0Tjv7igrn6BWNnm4YovJL4MeMseM+
         /b0O8LAGAafgwbbs+07TGle8fXByrIBEWq23qz1vBk2tEfSYFcnMRliFuzwybleESfiG
         UWbqycWHYZVALLXcwSjNGl9m3tusaISBSRt52iaRDHd8dLlS8gx8p8EBdi3Z34AN7xBh
         JxQ4W7tF6dEOYvjWWPuBTkIletu/VWoLUmDJ+ZLWpY5RWGqiKGMBy7LkLYJXoi73yztt
         e/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749900329; x=1750505129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/55vMuY3MFkevHEM5hX66L59C6pwFDgIm2rAf0kmwbA=;
        b=dyV5041PZlzVcUy55xkyKjEHXdiG/zJRWnsYj7SnnIcAV/N9sfqxDQfXmtSYe3IyhC
         jSch5V9jpELNK66M28JKgEMCdG9JZS3BDKxxaAD0D5+g8KP1kHUQwVpF8xU95cULSTEf
         MuZeOFx3SYln31aKczR8kKaRaguhhd6CxssHsEcR0lP5QkiG7XYzWWf003SETOUk4Qz8
         wM3gHUVbJLs7JwYjUAl/UMPddOrtydqmJJ8lFwVMhvDnyxNLjAfyrmCxQpG5igOsW/C1
         /QbW3I71mpQNENcvcmHARzLmgnJQNH89McYz5NMyByv953B75RRSyZ0veCYfqbbQqWxu
         Chpg==
X-Forwarded-Encrypted: i=1; AJvYcCVdsjoVg/GIPXDB7j757wSIcBnjNvNSkgBaedwqApbH/+aC5rsacrRtR7O3D7Po8so+kOpr1WsjLkPNR5O9@vger.kernel.org, AJvYcCWkdqleUNCw04nLTUDL1MCrNIihiPW042iSfoEKDsRwnaAaYlaF8JBjIA7gtfqDsdnr4vNcVi3+TBePiuuy8l27@vger.kernel.org, AJvYcCXMi6nioAu21BwQT1eZsPIpIxLP9CbU1QiIL+FphPLsFiH9PyglA0BPzahEIFaypgkzgxUdtUmj73w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4479FS/6pe2Gh2BcAyonlHGW1pVp9tLLrJcvmeK9ENAu2e9V
	yzixJM25vXML0geXJwhyns/JagXDs1UQxCSqI63z/RFlgjP7rLzSVDLoq24zmWzG
X-Gm-Gg: ASbGnctKYLnJhUuy6GvQzBacFmuTiJsJi0OWtGdJTQi24gban9FprRBmCXCmgoSEOBl
	eFGZmZSA/gZmWkuUTFdd3cfL/Wp7gExheKBPcEMl0dqJ+jzzn70R2DrCvp+amZDxsYMlU8f91JZ
	7T8+EVx5wtxkAY8SvM3NMltUMIxm1uMkLwGhfSGfFoETcbSMtCr+O6UWNWIJXjOuU7ZYsLQgbKF
	7dBRbu2TEPhqhNTvkgRPjotp+BYkUWddYPcEyydFlqRUQqmnotfGAHR4DjyAF/TbC6NUrRQXRal
	j6ZQaJWn+Lzd5vitjOO1rhJnim8+U2PCkYZEW0rvxHdoirIZTHqSEc8bOXUlEy+8XDS6rLFRV5n
	/lw==
X-Google-Smtp-Source: AGHT+IEkZs0hvtD2eJeR83LgbrqLik3Ia0PPRTMGtlUcyM0dpFxxvg4tZa9Pomsucl3vSdwEUtotdQ==
X-Received: by 2002:a05:6512:1150:b0:553:2c01:ff44 with SMTP id 2adb3069b0e04-553b6e7bde8mr493229e87.2.1749900328290;
        Sat, 14 Jun 2025 04:25:28 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-553ac11680fsm777892e87.5.2025.06.14.04.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 04:25:27 -0700 (PDT)
Date: Sat, 14 Jun 2025 13:25:27 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, rientjes@google.com, 
	hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, rdunlap@infradead.org, 
	mhocko@suse.com, Liam.Howlett@oracle.com, zokeefe@google.com, surenb@google.com, 
	jglisse@google.com, cl@gentwo.org, jack@suse.cz, dave.hansen@linux.intel.com, 
	will@kernel.org, tiwai@suse.de, catalin.marinas@arm.com, 
	anshuman.khandual@arm.com, dev.jain@arm.com, raquini@redhat.com, aarcange@redhat.com, 
	kirill.shutemov@linux.intel.com, yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com, 
	vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org, peterx@redhat.com, 
	willy@infradead.org, ryan.roberts@arm.com, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, david@redhat.com, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, corbet@lwn.net, akpm@linux-foundation.org
Subject: Re: [PATCH v6 1/4] mm: defer THP insertion to khugepaged
Message-ID: <fcd3phzewpgzghrzse3stxi7jz7b6l5uwnhqtswcfnqvuvktip@apqh2achkutn>
References: <20250515033857.132535-1-npache@redhat.com>
 <20250515033857.132535-2-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515033857.132535-2-npache@redhat.com>

Hi,

On 2025-05-14 21:38:54 -0600, Nico Pache wrote:
> setting /transparent_hugepages/enabled=always allows applications
> to benefit from THPs without having to madvise. However, the page fault
> handler takes very few considerations to decide weather or not to actually
> use a THP. This can lead to a lot of wasted memory. khugepaged only
> operates on memory that was either allocated with enabled=always or
> MADV_HUGEPAGE.
> 
> Introduce the ability to set enabled=defer, which will prevent THPs from
> being allocated by the page fault handler unless madvise is set,
> leaving it up to khugepaged to decide which allocations will collapse to a
> THP. This should allow applications to benefits from THPs, while curbing
> some of the memory waste.
> 
> Acked-by: Zi Yan <ziy@nvidia.com>
> Co-developed-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

...

> @@ -315,13 +318,20 @@ static ssize_t enabled_store(struct kobject *kobj,
>  
>  	if (sysfs_streq(buf, "always")) {
>  		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
>  		set_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
> +	} else if (sysfs_streq(buf, "defer")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
>  	} else if (sysfs_streq(buf, "madvise")) {
>  		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
>  		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
>  	} else if (sysfs_streq(buf, "never")) {
>  		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
>  		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
>  	} else
>  		ret = -EINVAL;
>  
> @@ -954,18 +964,31 @@ static int __init setup_transparent_hugepage(char *str)
>  			&transparent_hugepage_flags);
>  		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>  			  &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> +			  &transparent_hugepage_flags);
>  		ret = 1;
> +	} else if (!strcmp(str, "defer")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
> +			  &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> +			  &transparent_hugepage_flags);
> +		set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> +			  &transparent_hugepage_flags);

There should probably be a corresponding
		ret = 1;
here. Otherwise the cannot parse message will displayed even if defer
was set.

>  	} else if (!strcmp(str, "madvise")) {
>  		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
>  			  &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> +			  &transparent_hugepage_flags);
>  		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> -			&transparent_hugepage_flags);
> +			  &transparent_hugepage_flags);
>  		ret = 1;
>  	} else if (!strcmp(str, "never")) {
>  		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
>  			  &transparent_hugepage_flags);
>  		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>  			  &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> +			  &transparent_hugepage_flags);
>  		ret = 1;
>  	}
>  out:
> -- 
> 2.49.0
> 

Regards,
Klara Modin

