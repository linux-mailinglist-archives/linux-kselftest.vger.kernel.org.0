Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FE38F761
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2019 01:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfHOXEn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 19:04:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42912 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfHOXEm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 19:04:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id o6so3460969oic.9
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2019 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnDOmTGQ3o7pm2PlYm7DMFTWVVgS28bW8niUC3OmY3w=;
        b=ZoBtX6rd9BDK0KbI0rdwSqYZ5NJuK/I/7QzlLuzyFuLG4CeV/MRR6lDFRJ4Vj+m8hu
         2iuvJhLlV17nJ21xUhIT0C959raTCLBgmzW+O852hn7pGsMFNY+NOhTJ1Ef9QTyUojq9
         swfe8RnSnO37cxLPnVY+TMl0VRyf6vxf61R6tuQ+DFqXjN16tHhZDpB4GT46EBCNXXO2
         2bIxnToWeWl4mCb+h6kj17XvjUZYO1LTA6ah2Ili4tZGL7+RGzZXokiPgZ2+wZI5cwQc
         5cc9ciThS+NvfmgJWLoGU3V2+2LwhJEZo75j5HvOAzg+42UzxBMu/y5rmWyI8AXAGr+u
         hNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnDOmTGQ3o7pm2PlYm7DMFTWVVgS28bW8niUC3OmY3w=;
        b=qeoaV7yPQmQZIJEmHSVMbOYPiylc7+IjEIpr3b2t2ywWOrWgIgmaVzn7gL0CaPWefz
         kXHnSKhafbZdU4T+Kg9voerUarJNCV43yyRLD5wCKcawKg32/tLfPyra/w8TRjy5wDZl
         tAwoURi/0dlARf1vW3+shgSmM0cDu7CJD4IJ7JkWZd5ZTm0akPUaD1hYKqvlle7cDmFV
         UmHo6vuclPpCWJEBDU+Hbq82fcy3gXYM7btc8w0qroOXnhIKCmsh2PuGxTk6PpzOQ9Xn
         q2uaMRVH1E0B0ZugHh6x07RliqkLfc+pWhQHoZ1GU5vzjDke+LQJ++gursCiECB2iIZT
         K+nA==
X-Gm-Message-State: APjAAAVEE7uggvLAc1A+MT2JcWv88B+BufpSrSXC+v0kmFvFIsY3vtJv
        fQC+faj3vi3jk7rvI4rr7jnqDlktyvrluRF/sy95Pw==
X-Google-Smtp-Source: APXvYqw4Yy5bzXdUc9Snyyz9V723NmP08UwPtEG2zwOktsUlVvQZUP2oDqYSYHcxv1vC8VABNTqpWTgoqi4Jyxhndq0=
X-Received: by 2002:aca:cfcb:: with SMTP id f194mr3333675oig.103.1565910281015;
 Thu, 15 Aug 2019 16:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com>
 <20190808231340.53601-5-almasrymina@google.com> <47cfc50d-bea3-0247-247e-888d2942f134@oracle.com>
 <9872cec9-a0fe-cfe0-0df6-90b6dd909f04@oracle.com>
In-Reply-To: <9872cec9-a0fe-cfe0-0df6-90b6dd909f04@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 15 Aug 2019 16:04:30 -0700
Message-ID: <CAHS8izOv3GjKhnzVmksfH0U9xZ6OnC0R-XEZsqVxOvrJ5u_BBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] hugetlb_cgroup: Add accounting for shared mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 14, 2019 at 9:46 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/13/19 4:54 PM, Mike Kravetz wrote:
> > On 8/8/19 4:13 PM, Mina Almasry wrote:
> >> For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
> >> in the resv_map entries, in file_region->reservation_counter.
> >>
> >> When a file_region entry is added to the resv_map via region_add, we
> >> also charge the appropriate hugetlb_cgroup and put the pointer to that
> >> in file_region->reservation_counter. This is slightly delicate since we
> >> need to not modify the resv_map until we know that charging the
> >> reservation has succeeded. If charging doesn't succeed, we report the
> >> error to the caller, so that the kernel fails the reservation.
> >
> > I wish we did not need to modify these region_() routines as they are
> > already difficult to understand.  However, I see no other way with the
> > desired semantics.
> >
>
> I suspect you have considered this, but what about using the return value
> from region_chg() in hugetlb_reserve_pages() to charge reservation limits?
> There is a VERY SMALL race where the value could be too large, but that
> can be checked and adjusted at region_add time as is done with normal
> accounting today.

I have not actually until now; I didn't consider doing stuff with the
resv_map while not holding onto the resv_map->lock. I guess that's the
small race you're talking about. Seems fine to me, but I'm more
worried about hanging off the vma below.

> If the question is, where would we store the information
> to uncharge?, then we can hang a structure off the vma.  This would be
> similar to what is done for private mappings.  In fact, I would suggest
> making them both use a new cgroup reserve structure hanging off the vma.
>

I actually did consider hanging off the info to uncharge off the vma,
but I didn't for a couple of reasons:

1. region_del is called from hugetlb_unreserve_pages, and I don't have
access to the vma there. Maybe there is a way to query the proper vma
I don't know about?
2. hugetlb_reserve_pages seems to be able to conduct a reservation
with a NULL *vma. Not sure what to do in that case.

Is there a way to get around these that I'm missing here?

FWIW I think tracking is better in resv_map since the reservations are
in resv_map themselves. If I do another structure, then for each
reservation there will be an entry in resv_map and an entry in the new
structure and they need to be kept in sync and I need to handle errors
for when they get out of sync.

> One issue I see is what to do if a vma is split?  The private mapping case
> 'should' handle this today, but I would not be surprised if such code is
> missing or incorrect.
>
> --
> Mike Kravetz
