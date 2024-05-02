Return-Path: <linux-kselftest+bounces-9265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6C8B9C42
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CF31F214CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F413C818;
	Thu,  2 May 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQwZ5rnr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793213C805
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660117; cv=none; b=qqlxPu0j8Y6KQqaSoTfmGsNYx2wvvUzq89O2VT2EpEQMOCiBI7a8hEiIt9mktLY6aMN3lcvP8KCyHur7miTsgxQe0fWPsE8+KbjWb1zEUxYCJH45wejvu2YQCwR56epp0DeNA6kvNpElU+o1OrBWZ+uXe/DVhsw+TlhKXxfLZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660117; c=relaxed/simple;
	bh=xrvi/XNbujJMaV8uWdtME/cTUAf+3r2xBYiOeWywrt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4mISDd+q6JTT9tIWq3LAdXQTrtwxNhwlyhHdn+nioRKxr3Z7NGGoJTqitf4LW3owz2bYiMHf75mb0EtvjekL5+t+wpVAQ7IDSafzm+pa0llWEPKlG9ra2IvQjvPkXDMbEIVNDexm1SAur28Qwo/wMFCZcSiQeqGnMMvV/l0UIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQwZ5rnr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714660114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+ivPoi6ke+3px410keu+dd6owA+zUKCHd3sR9ExU08=;
	b=RQwZ5rnr41BiiyG9j6DxgN17kxbRkDTGrwfOHHBxuX1Keq7pce66BVwfqt665H4dxFuISr
	zJqnTqV3zR4KKdFZ91KCyBBY9IlEO4lsQ9b6Sc1K+vUPQCNXn/mXiOgVjO+nJM9t5hrPew
	OnsDa0iF1WkOWAhOG0e2k6wC9HUJqwM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-FCH87Oz8MKG2YoARki1LHQ-1; Thu, 02 May 2024 10:28:31 -0400
X-MC-Unique: FCH87Oz8MKG2YoARki1LHQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4347df2ad8cso4720001cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 07:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714660111; x=1715264911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+ivPoi6ke+3px410keu+dd6owA+zUKCHd3sR9ExU08=;
        b=ngPO/6WyOjWnGBEH1IsxGNffEeXRwa5Orpw/dYhyUk/xmgVOmlbTsQDExtWvcEzpB5
         prob0tfsRhJxG9OB584aPn1c2VOVQQt8QkXFnLfJwYlP8B1lKfpMG6PUAAIPl+r0ocB4
         8JS83CbBxKVJJX1quWIxvPw0dGSh64LTycWXINs+ktW80c6QaXDMN0qLPmCNEVpR5j28
         A2zMfmdQwKUpl/DqbsAy0sPJc7QZ+L2D4fiU/96qld8+1UGCCA/BqIyWz+A5hykLvDEV
         nTm3H6oScMKP+Qd8KFs9sFB8mgXNLSHIPbg1B1rF0sK270+8k+Ftday54vfhSesYY0NS
         fxpg==
X-Forwarded-Encrypted: i=1; AJvYcCVsmy6p0ejk+znJQqfP+OoO6fIUp5ddKHeK8rkM537cc4kKMCKHb20eOstKsV+xMHPGyB13Hxjxc6HEi8GvbZc4PdvBTsBPldqYHPnyo2CA
X-Gm-Message-State: AOJu0YzWS1NUWBNr1csOIZsPlSpmFvMTjPU4ZsZaNcLXRs+BCTzFH2by
	P+QDd19UnTKLwvd0VyEwDaSjZrbwbnIG/+6XMJbiocjaz2cT57ce4VbEyytQkJxCrC0hBbLyonf
	L/TPLcyJz+b2GJlr0Ofg5Q6BvyWakIm6N6VszWtWmICuZ+MK7514phJ9X1X6bwCsb4A==
X-Received: by 2002:a05:620a:2552:b0:790:8c20:e281 with SMTP id s18-20020a05620a255200b007908c20e281mr6180832qko.4.1714660110393;
        Thu, 02 May 2024 07:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzEHkYGvVezmJhlmRGMyVZvZwOyDVQMnlBj4RTlQm3Y1h6k6uZy2NH5X5lS7CqgbZdnDaBww==
X-Received: by 2002:a05:620a:2552:b0:790:8c20:e281 with SMTP id s18-20020a05620a255200b007908c20e281mr6180786qko.4.1714660109594;
        Thu, 02 May 2024 07:28:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id j16-20020a05620a001000b0078ede0c25b5sm406909qki.23.2024.05.02.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:28:29 -0700 (PDT)
Date: Thu, 2 May 2024 10:28:27 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 2/2] mm/hugetlb: document why hugetlb uses
 folio_mapcount() for COW reuse decisions
Message-ID: <ZjOjCwrWg-Fd9gtI@x1n>
References: <20240502085259.103784-1-david@redhat.com>
 <20240502085259.103784-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240502085259.103784-3-david@redhat.com>

On Thu, May 02, 2024 at 10:52:59AM +0200, David Hildenbrand wrote:
> Let's document why hugetlb still uses folio_mapcount() and is prone to
> leaking memory between processes, for example using vmsplice() that
> still uses FOLL_GET.
> 
> More details can be found in [1], especially around how hugetlb pages
> cannot really be overcommitted, and why we don't particularly care about
> these vmsplice() leaks for hugetlb -- in contrast to ordinary memory.
> 
> [1] https://lore.kernel.org/all/8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com/
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/hugetlb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 417fc5cdb6eeb..a7efb350f5d07 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5963,6 +5963,13 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  	/*
>  	 * If no-one else is actually using this page, we're the exclusive
>  	 * owner and can reuse this page.
> +	 *
> +	 * Note that we don't rely on the (safer) folio refcount here, because
> +	 * copying the hugetlb folio when there are unexpected (temporary)
> +	 * folio references could harm simple fork()+exit() users when
> +	 * we run out of free hugetlb folios: we would have to kill processes
> +	 * in scenarios that used to work. As a side effect, there can still
> +	 * be leaks between processes, for example, with FOLL_GET users.
>  	 */
>  	if (folio_mapcount(old_folio) == 1 && folio_test_anon(old_folio)) {
>  		if (!PageAnonExclusive(&old_folio->page)) {

Thanks for preparing such updates, David.

However is fork+exit the real problem?  E.g. if a child simply fork, do
something, then exit, I don't see a major issue even if we follow refcount
here (despite the "check against 1 or 2 or 3" issue, where hugetlb_fault
can take one already).  As long as the child quits, all ref / map counts
will be released then.  If the child needs to write to ANON|PRIV it needs
to manage hugetlb reservations anyways.

In the case of vmsplice it's kind of malicious, and holding that refcount
(with 0 mapcount) doesn't sound the common scenario to me.

IIUC if we need to keep this, it was more about the case where (as you
correctly mentioned in another follow up reply) hugetlb isn't that flexible
to memory overcommits, and in many cases it won't have extra pages floating
around to allow adhoc CoWs?  While random refcount boost is easy to happen,
and here the problem is we simply cannot identify that v.s. vmsplice()
malicious takers.

Thanks,

-- 
Peter Xu


