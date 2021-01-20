Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD42FD284
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 15:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbhATOU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 09:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388163AbhATOTT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 09:19:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B76C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 06:18:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id w1so33698699ejf.11
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 06:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZwlx8a2SEsD8Y2Brb387uwcRDdsHOUIO/KUuY9o6cI=;
        b=j9kZRkJt6XM/YJtw6elaTf7SDrT4bVch1ktg1bCbaQETKnigjTRqkxDSUO2X50DqU8
         ZoTtIuAsOg6j03jyo52Xos9i9XzC3Zi8qsrRe5G9x/mLzkpVC71uZvNFvYX27dYEXEXt
         PyeJ7Jvs9Pvp05A8DazANGflniIvTrQqg9LOODF2lIEP5WaOw6MJBQ1KOlPMdOItIK+C
         h07/NqETO30rEZKt9BYyCOgKWReY/ggoKT9OnNoGrGh6ADk74b7O9PXR6pkOuxsrEcwx
         nE09bh6yRT6LsIByxuM7ieVlWbTg67ovO8IDJHHcEJNx9XPyAueWj6jJGf5R5Lp+iaLZ
         dndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZwlx8a2SEsD8Y2Brb387uwcRDdsHOUIO/KUuY9o6cI=;
        b=rQW+KpdanxjpYKMDMZ/EXk6etFQYFJWd3PYaTkpyhvFcXpRovZjPnsIj4z8nHS4/Qb
         niMMRY0TT/pWZq8lFFkkF8LqmD9LKxSteDchYlDjIty230Fxnvr9c6J8EGeLU23d2VJu
         rtba76tsgVt1YquJCNSFyLZUVhFs9ttHs2SSs3/dpYuJSuFxwRpaN/zqDXpyTqjfAoYq
         8lji8rRBWqfi/0GhT6ftM1JfVDtu2JKpEW/QW3vrrwTzZiwteBKywY0N7YeyY8nf8ojv
         ewPvWUygvbIcWRnxI+2pCr9orgbwMazXLAcO1l8S2Bxiu01Jf/ggNhsbhttyI2peBfBq
         qyTQ==
X-Gm-Message-State: AOAM532MdmpVFsjiW5Nky2V+3wVfNuiJOcyQ3iANaLIkVMFCGZLibF81
        FNH3aCv1HUcPhCwoRB6iSHn1LX2XSjgEx0F5LHGtcA==
X-Google-Smtp-Source: ABdhPJyLaWYZ6FSbAJyquHkBR6XAVgE8S/PCjTzGk5y8JvrkcOU4V+zWzNQnaWNiH3frmKDvChsPxoWvTHd/LnRpupI=
X-Received: by 2002:a17:907:20aa:: with SMTP id pw10mr6125853ejb.314.1611152313325;
 Wed, 20 Jan 2021 06:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
 <20210120014333.222547-13-pasha.tatashin@soleen.com> <20210120131937.GG4605@ziepe.ca>
In-Reply-To: <20210120131937.GG4605@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 09:17:57 -0500
Message-ID: <CA+CK2bCb6A19X+fHL=ZB8EuA25rh3iNL4qkL5EDZBT1XTs-dpg@mail.gmail.com>
Subject: Re: [PATCH v6 12/14] mm/gup: longterm pin migration cleaup
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 20, 2021 at 8:19 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jan 19, 2021 at 08:43:31PM -0500, Pavel Tatashin wrote:
> > When pages are longterm pinned, we must migrated them out of movable zone.
> > The function that migrates them has a hidden loop with goto. The loop is
> > to retry on isolation failures, and after successful migration.
> >
> > Make this code better by moving this loop to the caller.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> >  mm/gup.c | 88 +++++++++++++++++++++++---------------------------------
> >  1 file changed, 36 insertions(+), 52 deletions(-)
>
> This looks OK, it is better
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> I really dislike we always have to go over the page list twice in pin
> mode

I agree, I also dislike that we have to loop twice.

>
> The is_pinnable_page() and LRU isolation should really be done inside
> __get_user_pages_locked() as each page is added to the output list
>
> But that is more of a larger issue than this series

We could also think about adding some optimization flags, i.e. clients
could tell gup that the pinned memory content can be discarded
FOLL_DISCARD. That way we could always allocate new pages in the right
zones as we do with this series and free existing translations. No
migration check would be necessary with such a flag.

>
> Jason
