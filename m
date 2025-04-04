Return-Path: <linux-kselftest+bounces-30144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BBA7C3F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7585D189F769
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8BC21D3ED;
	Fri,  4 Apr 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="r2iv0ef4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC921D3DB
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795492; cv=none; b=rDMerTkYRmXwR3aOI2Lky3QaJdWQpYkAC/SA9sHcnzHsOHRNzb00vVo+prPaZtvrLzebWVVJ/7fKzLl1ustRqU5hJ8J7Uy+ufLR+8Jsvd0taCVggoTQAjQKx5HJ8x9rzyOUwMnrstg6PjAVWD4+wATXcQSxrj+QDNIds7G34JHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795492; c=relaxed/simple;
	bh=OWnTUtIeczm0jQ3tLKOSnVG07QY4zxIxvceyWqq7Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjD3ew7EriranteY3RZehAWNrCw75S041CGqIMkuYNq3NLyHSgrl7r7vhW7umxNZzVxhQRAt40ZJ5ZQJWaEnJfE9ALURbQ0qykvCZi7yZmYQfYExtjs6cn3qRJF07v4zHZY/veB4B9a/EfRFP9Xxkz0gPxaX6oQiarinhnFtuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=r2iv0ef4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769f3e19a9so16330471cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Apr 2025 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743795487; x=1744400287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4jU9dZ1c7Yovc2ioTyNiJ82SX9/E9otfhXZzP1ZTJc=;
        b=r2iv0ef4yKGEl8X3YPULea59OGt/Ztw4Gnxff+mVXhI+yZzM/xSWJe7xTVcbuvQksn
         bX6jgrjiPcN+CI+GZX+ot2UMdjau0j1fP8SKQvL74Z9yi7+0faDXca8k/rRJ5ZLbqmgW
         9H9Vzr/wj3tdiPmrEsN7PsnoesYqHtoOZ6lFANaUqfh6O6Gjz96zf492Yh8pYC05Qs6Z
         CPD4P16Z+lr1quV7ZZHx+dOl5pT0pbYWDblD0kJjjymm04T/59RBEttaJUmY4mWx2l+h
         WXOLQPwZ3P2q30CYFpn6bhNYetcdoFeEmkyQct6WNmZ/7iaXdoJQETbQPPRQrvZofMJy
         OHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795487; x=1744400287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4jU9dZ1c7Yovc2ioTyNiJ82SX9/E9otfhXZzP1ZTJc=;
        b=qEGODFZ8OTDNz1Z5PeLYM8t+EIy863boXM0T2xOafk5eQY/69Wv1jMhMCS9nJidkfc
         JgoFZ66kN7plyRerwSVCSi2bnqOSSf3FfloeU2mQ5FDInmzLRY2dEGd33dr6B3oXXbWx
         IgrX6dNIqeiBaqvdvgfijw/o90QNd964i5qfOjiIdJd9WwIjsuB+qyK+WjKJkzXA7ieY
         1dyEus3YyBI2Dhfft9nC1XqyoaUvkKMSLGr0KSehnJV7NCVCfBKaZ0NFrnJ3gncCIxix
         L69H8rzc2z57pJ/kLNtvVIT9sl7BingWtn/92YmxEMdxBNolKNqKfYPlOjqwYf+uFoGO
         jAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU967ZT6Xx4jycMBK+m5C/0lKTzbg4mjPgNM5LTcYoq1ZNHMPpsWfQQD8EvO0JX0zENFjcOqQQjPwxALiHLk3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9jIlB0pqXcQoJfaqOOeRbWx4kT+lmDzMfAu67/1JLyHeLq9V
	F1xijKB6LLVD+jir51zrOe5E/rgPab/oa7PzEclTVUrVqyYpg0NC0i/WCKrgdY4=
X-Gm-Gg: ASbGncuBYTRSD7NQe6WDpz3wULN42WsnXUpTyxJ0SARAongSJugu+r4oqLquDAnUUsZ
	abjRoSftCZlk8ZWuGBMARl9kCrEyOJtYukFhSmD9HJQ+FzD6GiDJNwYtv/oGp8UimUBdWMTkhPW
	ptKmec1UxGBDoRi8/Dvw/XeZO73xcx1RJYPeEud7vAtF3GXmJH4eMOOWeqqzy9xDuH8lOEV5ywd
	Fa66sP1gd7xR9s6kAaHZVtrnMeJEem9/+adJWOEgJUVbct0ln9ym4tPo1W8W064wnMqIiJJDIY+
	xXHGuYXLpzJ5ByaGIlabSx29xcNUF5MW1HKQzOD401A=
X-Google-Smtp-Source: AGHT+IFiV5JEVHf/H5z/o5TJU4SUbRPdcSgoWSnaiXwlzx82DlAB9Nhd813vrtCnLKQxfZsESH38BQ==
X-Received: by 2002:a05:622a:1a27:b0:476:8a83:960f with SMTP id d75a77b69052e-4792595086emr52294121cf.17.1743795487399;
        Fri, 04 Apr 2025 12:38:07 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4791b142b9bsm25853551cf.66.2025.04.04.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:38:06 -0700 (PDT)
Date: Fri, 4 Apr 2025 15:38:02 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
Message-ID: <20250404193802.GA373778@cmpxchg.org>
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
 <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
 <20250404181308.GA300138@cmpxchg.org>
 <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>

On Fri, Apr 04, 2025 at 02:55:35PM -0400, Waiman Long wrote:
> On 4/4/25 2:13 PM, Johannes Weiner wrote:
> > * Waiman points out that the weirdness is seeing low events without
> >    having a low configured. Eh, this isn't really true with recursive
> >    propagation; you may or may not have an elow depending on parental
> >    configuration and sibling behavior.
> >
> Do you mind if we just don't update the low event count if low isn't 
> set, but leave the rest the same like

What's the motivation for doing anything beyond the skip-on-!usage?

> @@ -659,21 +659,25 @@ static inline bool mem_cgroup_unprotected(struct 
> mem_cgro>
>   static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
>                                          struct mem_cgroup *memcg)
>   {
> +       unsigned long elow;
> +
>          if (mem_cgroup_unprotected(target, memcg))
>                  return false;
> 
> -       return READ_ONCE(memcg->memory.elow) >=
> -               page_counter_read(&memcg->memory);
> +       elow = READ_ONCE(memcg->memory.elow);
> +       return elow && (page_counter_read(&memcg->memory) <= elow);
>   }
> 
>   static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
>                                          struct mem_cgroup *memcg)
>   {
> +       unsigned long emin;
> +
>          if (mem_cgroup_unprotected(target, memcg))
>                  return false;
> 
> -       return READ_ONCE(memcg->memory.emin) >=
> -               page_counter_read(&memcg->memory);
> +       emin = READ_ONCE(memcg->memory.emin);
> +       return emin && (page_counter_read(&memcg->memory) <= emin);
>   }

This still redefines the empty case to mean excess. That's a quirk I
would have liked to avoid. I don't see why you would need it?

> @@ -5919,7 +5923,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, 
> struct s>
>                                  sc->memcg_low_skipped = 1;
>                                  continue;
>                          }
> -                       memcg_memory_event(memcg, MEMCG_LOW);
> +                       if (memcg->memory.low)
> +                               memcg_memory_event(memcg, MEMCG_LOW);

That's not right. In setups where protection comes from the parent, no
breaches would ever be counted.

