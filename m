Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF52DDA53
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 21:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgLQUvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 15:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgLQUvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 15:51:31 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12CC0617A7
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 12:50:50 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id et9so7711572qvb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 12:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqHfltIe6StadBZi2KkdxefX4rAbzFV9jepIFW1E6FY=;
        b=E/x8A5vMezHCFb9dLm6S0IXJq8Gyh+EPvo5BKs55Wk+POuD1PHi75XEpm0rMiyFNCO
         HHO1b2pGTYbUDh5Hiq7MA7CpWTSo63OwzfS273kvFBXKpSIfdWF1ZTUIIbb4brsNRlK5
         9spCH84mjZBmVt00zaRF6kNachiZDpPlmFdp9n2kbSsAFwA+VdZ4CFn9vTCc6LCSi4FW
         ei6BeLw9IBW0givRHd5+knksA6HoU9W/sihFUzVzR961sv/rWpvQQEk9M7EOvx/H7YHm
         oAk/kaZ+0uNu1UMZJxnoVx5JOwNnnEzv1DfYcMHinfAUV+6TYGsF8ZEtSili6jQXujtw
         4S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqHfltIe6StadBZi2KkdxefX4rAbzFV9jepIFW1E6FY=;
        b=IQUDIb7JZuE9s5l8v89G+ybEZa+CzTNpi1EQVK4xw9i42tS3i44Xq4/Co7Qd4k7109
         b6AlPR2hDsWVNw3DL2HTlbMxo7Gd5SSH7/E2IBZXeeUuc5GbrL9EvkGLAKwH4BL0zNEE
         BoZMKemG80HswN3Lh2sub+9/FYTJF9R+LsusT3mMrHklo/0OaVMZmP1jEoVgmatPgCd6
         Qgu5NaUCbVN8V7daLfJf/lGg/sIkINCNGJ7BsmyUVaEZgRWroMit2wLVjrY0U9K0+9xS
         N/KOtksMesA+99IHu6GaID9w1HraF5EbYHd3VFovOY931x7WVqZkB+h+oHwoK5XVMfLd
         cP+Q==
X-Gm-Message-State: AOAM533LOldMeH1nI0BwMkD9fHS6rAC2Y0MSwp6SrvbPQwQ6Y/rVeN9d
        aMmpdkhVeR5yjK+OB/tCQlbMxQ==
X-Google-Smtp-Source: ABdhPJxnMK/i8fyKRnAicH/iIJoa4TtlmAQCGTxXlVYSxs/wReGHF4jBJbTahp3EzGoSA6ywyXHl3Q==
X-Received: by 2002:a0c:ea34:: with SMTP id t20mr928397qvp.5.1608238250201;
        Thu, 17 Dec 2020 12:50:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id a5sm4381546qtn.57.2020.12.17.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 12:50:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kq0Ea-00CNWJ-NQ; Thu, 17 Dec 2020 16:50:48 -0400
Date:   Thu, 17 Dec 2020 16:50:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 08/10] mm/gup: limit number of gup migration failures,
 honor failures
Message-ID: <20201217205048.GL5487@ziepe.ca>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-9-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217185243.3288048-9-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 17, 2020 at 01:52:41PM -0500, Pavel Tatashin wrote:
> +/*
> + * Verify that there are no unpinnable (movable) pages, if so return true.
> + * Otherwise an unpinnable pages is found return false, and unpin all pages.
> + */
> +static bool check_and_unpin_pages(unsigned long nr_pages, struct page **pages,
> +				  unsigned int gup_flags)
> +{
> +	unsigned long i, step;
> +
> +	for (i = 0; i < nr_pages; i += step) {
> +		struct page *head = compound_head(pages[i]);
> +
> +		step = compound_nr(head) - (pages[i] - head);

You can't assume that all of a compound head is in the pages array,
this assumption would only work inside the page walkers if the page
was found in a PMD or something.

> +	if (gup_flags & FOLL_PIN) {
> +		unpin_user_pages(pages, nr_pages);

So we throw everything away? Why? That isn't how the old algorithm worked

> @@ -1654,22 +1664,55 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  				  struct vm_area_struct **vmas,
>  				  unsigned int gup_flags)
>  {
> -	unsigned long flags = 0;
> +	int migrate_retry = 0;
> +	int isolate_retry = 0;
> +	unsigned int flags;
>  	long rc;
>  
> -	if (gup_flags & FOLL_LONGTERM)
> -		flags = memalloc_pin_save();
> +	if (!(gup_flags & FOLL_LONGTERM))
> +		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> +					       NULL, gup_flags);
>  
> -	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
> -				     gup_flags);
> +	/*
> +	 * Without FOLL_WRITE fault handler may return zero page, which can
> +	 * be in a movable zone, and also will fail to isolate during migration,
> +	 * thus the longterm pin will fail.
> +	 */
> +	gup_flags &= FOLL_WRITE;

Is &= what you mean here? |= right?

Seems like we've ended up in a weird place if FOLL_LONGTERM always
includes FOLL_WRITE. Putting the zero page in ZONE_MOVABLE seems like
a bad idea, no?

> +	/*
> +	 * Migration may fail, we retry before giving up. Also, because after
> +	 * migration pages[] becomes outdated, we unpin and repin all pages
> +	 * in the range, so pages array is repopulated with new values.
> +	 * Also, because of this we cannot retry migration failures in a loop
> +	 * without pinning/unpinnig pages.
> +	 */

The old algorithm made continuous forward progress and only went back
to the first migration point.

> +	for (; ; ) {

while (true)?

> +		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> +					     NULL, gup_flags);

> +		/* Return if error or if all pages are pinnable */
> +		if (rc <= 0 || check_and_unpin_pages(rc, pages, gup_flags))
> +			break;

So we sweep the pages list twice now?

> +		/* Some pages are not pinnable, migrate them */
> +		rc = migrate_movable_pages(rc, pages);
> +
> +		/*
> +		 * If there is an error, and we tried maximum number of times
> +		 * bail out. Notice: we return an error code, and all pages are
> +		 * unpinned
> +		 */
> +		if (rc < 0 && migrate_retry++ >= PINNABLE_MIGRATE_MAX) {
> +			break;
> +		} else if (rc > 0 && isolate_retry++ >= PINNABLE_ISOLATE_MAX) {
> +			rc = -EBUSY;

I don't like this at all. It shouldn't be so flakey

Can you do migration without the LRU?

Jason
