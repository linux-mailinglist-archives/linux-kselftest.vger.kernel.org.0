Return-Path: <linux-kselftest+bounces-17175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D4196C80F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8ECE282AFE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081D1E7659;
	Wed,  4 Sep 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6BD8yNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFF1E6DDE;
	Wed,  4 Sep 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479894; cv=none; b=E1RwIoZIj4yfrE00EPG05RvmoS5fJsAxWFVONrS//vV/4bmoYg+JqMPMgx3OFO3tGf82EVWTK4prxZBQIS4jMz+JFSc3xy/EjauMPoe8MG4hG1tQwE6jnR/pZMIe10SzedouR2aWuFeEzzsuZ23YVh3PSLQYZtu0UVAfXcHB320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479894; c=relaxed/simple;
	bh=zavzUwXlxjfb5MjitZxKh7537njoiHYD+hBJaxyi3B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/px9yFoCO08trUqAWZBCqDzUm3tsvfZOp1Huk0Bc4JeeSgyOtG92wndC4+nslcWNLoLVjCvHBAQNbG5HVWIJLlF2FaTGoPTpMLHTxWS/4cDniZCYY4NQ8kTw25PyklK608cm8tO9Osih23O3cl+BCqyR/1brctZfylRq03STOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6BD8yNt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d4c923a3d7so13895a12.3;
        Wed, 04 Sep 2024 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479893; x=1726084693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPICdxGtZMm7EVbsBiDOXLzIL+MnaADtVMssqy1cp2c=;
        b=l6BD8yNtusMiXdWfUu8GV2zp9XUNyZIaWbXD2EYnLfLPmyExGc/METs+UcZUiQu+Xm
         sW6uOFkBq6/zJUpkYR167UbqsDllaX8vdIABYnjdbpR6EzPkV7H4s2QW6jbYsvY2+1p3
         PB+d46b9SlDV/1dlScUi+goWaxnceTLMCfLl4jHzRB3KQXb7jLt83nNcDGEhH+6t/UBK
         kZARl1TTptVaiBA2iS6rQACFaOXkVaxsHr4oDkMBBxjg5J8zrWjX+J7VLaT5askspSGY
         ZoV8gG+HLLV5ccbJ8A8HkuZe+lAZirE1R5CZrvlvvPNBM+j6pjI9KQ3KQ4Wddax2wd/A
         23Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479893; x=1726084693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPICdxGtZMm7EVbsBiDOXLzIL+MnaADtVMssqy1cp2c=;
        b=T24PGJje8wj19LxPfDtvXXgshlAt36rWG6aCvNGycmIs4U9UzgbRaySSgHYKynzR8I
         pt1+3p97JvXX6htq127+UL7VTnwF0WYfDjO3wiRL21E8y3QfuPMVSboUoyr65V4pIlDV
         GP/u2usjYBpn90G/+fdRNX5JaDyjnnUzbLwRkCE59qfS5wEYZEL3QNiJWVl9Yja0oORZ
         vcMBlnCIj+RP+jLpRFzW9wNACyjS5DmJsW5Gt3mN5YOp6uH6YRVWzILzrW4l1bkr5wD4
         9hFRDV7SR9frKryJLKXO3XlXXbamvo48mi4TFqvu4FA3AP9phzDAOI5drvnDxEeYUMpz
         bnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtgIVLvyTirjJcsZVmxHXfOtal/sW08oZFs+NDZjnJa5Ro3U0wGBXFPGJv/K54XH2aUOoPDliYCIPjdWcfVCVq@vger.kernel.org, AJvYcCXxltYLr3sSiZdHjwdZH6ga6boZ2lyHx1Oxt66cvHQrMATUbbOpWU3g5XtdSXIZzlPYENKv8RRAGJ71RJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5AUlvXtwDbXLW77fjjWAg4PAuyAiXZVddFelK+feYR7NGGmr
	A97NOkhrNzjk4aSUzHH+D9R5NfgbN2aOCqkx/YfsxKWRSxe0lf0U
X-Google-Smtp-Source: AGHT+IHiuHFL/47pKWStSEZDU1pmVIBJvuKjwmas3mljqR/n/RvBLMuLXDlS66q4XOAagB8218fbcQ==
X-Received: by 2002:a17:90a:70cf:b0:2d8:f12f:6bed with SMTP id 98e67ed59e1d1-2da5592440bmr7912187a91.3.1725479892758;
        Wed, 04 Sep 2024 12:58:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da53740084sm4907126a91.32.2024.09.04.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:58:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Sep 2024 12:58:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/vaddr-kunit: init maple tree without
 MT_FLAGS_LOCK_EXTERN
Message-ID: <b253cae1-8363-4f26-9698-97e76b4b17dd@roeck-us.net>
References: <20240904172931.1284-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904172931.1284-1-sj@kernel.org>

On Wed, Sep 04, 2024 at 10:29:31AM -0700, SeongJae Park wrote:
> damon_test_three_regions_in_vmas() initializes a maple tree with
> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> mt_lock of the maple tree will not be used.  And therefore the maple
> tree initialization code skips initialization of the mt_lock.  However,
> __link_vmas(), which adds vmas for test to the maple tree, uses the
> mt_lock.  In other words, the uninitialized spinlock is used.  The
> problem becomes clear when spinlock debugging is turned on, since it
> reports spinlock bad magic bug.
> 
> Fix the issue by excluding MT_FLAGS_LOCK_EXTERN from the maple tree
> initialization flags.  Note that we don't use empty flags to make it
> further similar to the usage of mm maple tree, and to be prepared for
> possible future changes, as suggested by Liam.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes from v1
> (https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org)
> - Keep lock usage and update the initialization flags (Liam)
> - Fix a typo: s/celar/clear/ (Guenter)
> 
>  mm/damon/tests/vaddr-kunit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 83626483f82b..a339d117150f 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>  		(struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
>  	};
>  
> -	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> +	mt_init_flags(&mm.mm_mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
>  	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
>  		kunit_skip(test, "Failed to create VMA tree");
>  
> -- 
> 2.39.2
> 

