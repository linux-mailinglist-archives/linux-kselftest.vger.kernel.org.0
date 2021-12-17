Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5574795B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhLQUqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbhLQUqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:46:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971DBC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:46:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z9so12491806edb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvtI4+YSdquMi4008PNndF9RQGlniB2TT2AdOD25k8M=;
        b=TiDJROI9W5ycY3V9UTpl5dSHKHMEZnWf33NVmEsRwKuJFClSlc4drizCRjtvX0nU1J
         mcXdn9RlVnT274Z77xOxrX9ujv1qBIOdnmYLgr3mJtCslSOMD3PQUkkkx6ZV6OQDfbmN
         vDn6BLFj3k3shFoPGq1aawhK/RRcCUCSrsyjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvtI4+YSdquMi4008PNndF9RQGlniB2TT2AdOD25k8M=;
        b=jLg4H+VMnL+ICOJ9xYd0Zb4Yt97tvV4ijNkWD5jnvKHiYPaQVFvytV9iwEfYKk+tzS
         OSh1xuBgpgsIbfZM0ln/i4inuwgfk6L72Irnj3KB2EbQnN7ZMKsOnEArYdugvTFvTI1N
         3IHHkHxoZ5QmNR49hzuabv98T10iAEona/uamxbsc92xFwcSIlQUi5DzKrxY15THHHi0
         n4a7iq9o9OSy4d/WcerOd4b7pxdyoJ6zcMqwfIZ4q5ky2/JO6+Ui+1NPYzSoYQ4cbSra
         yw5jWKZuAQ44AsKbGBewW90vq3avToUZ9RXi5K5wrmuVRTpIb/EA1lRJXf4iP4ubU82d
         UTBA==
X-Gm-Message-State: AOAM530UXlNwtawjP9iemLlSzJCOqJD3r0zJRRCLfqGJzXQE6SG657tu
        xiw23ATM6TQ1ejv1rlq96nTdjOpQiS1USKtv6yk=
X-Google-Smtp-Source: ABdhPJzAdBxht9vwE14HJ/2wFolhHxuQ7GiOXPCIv0VVW56IsUK+Una1Pt10MxTbSYItW5O6vEQhng==
X-Received: by 2002:a50:bb2a:: with SMTP id y39mr4468646ede.348.1639773972032;
        Fri, 17 Dec 2021 12:46:12 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id g7sm948266ejt.29.2021.12.17.12.46.11
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:46:11 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so2262885wms.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:46:11 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr4080563wms.144.1639773961365;
 Fri, 17 Dec 2021 12:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com>
In-Reply-To: <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:45:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
Message-ID: <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 12:42 PM David Hildenbrand <david@redhat.com> wrote:
>
> > Then somebody else modified that page, and you got exactly what you
> > asked for - a COW event. The original R/O pin has the original page
> > that it asked for, and can read it just fine.
>
> Where in the code did I ask for a COW event? I asked for a R/O pin, not
> any kind of memory protection.

Why didn't you ask for a shared pin, if that is what you want?

We already support that.

If you don't like the read-only pins, don't use them. It's that simple.

              Linus
