Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA522681CD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjA3Vfn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 16:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjA3Vfm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 16:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2144684
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 13:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675114494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BSxtpSj4BrAFBe1Q7X5Ylg8I71bsH6V8VmhxdA0ZpI=;
        b=TghO/WboHJlfs/sLkCc1Kthc8PPA2fTXKnVb0/1NKA9Y6YmfntcIct4Erxvg5Biq+9jDiC
        Xdcteu55q15Sbf6YUKcL3F206jU3jMTp14kX69fIX5MNMZFcm6ozmHk9+z5x+9hgvApz0R
        8L588CC5ig/U/4thv75C0902PBPFSsg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-Ff5dFyWnMf-gq_M8bkmFcQ-1; Mon, 30 Jan 2023 16:34:52 -0500
X-MC-Unique: Ff5dFyWnMf-gq_M8bkmFcQ-1
Received: by mail-qk1-f199.google.com with SMTP id g6-20020ae9e106000000b00720f9e6e3e2so1544617qkm.13
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 13:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BSxtpSj4BrAFBe1Q7X5Ylg8I71bsH6V8VmhxdA0ZpI=;
        b=CoW6w3mEeqUwEMLCVeub4AjkJegnRuKTE/VX0gJjBk0XHCUyl/7Mrl04XFyqnrU9Xp
         8LzMAt3JFqkeZpM36ZKWRRgCU8R9Akhgn9OSkaBPLTgXFFwwwRb65JD/67oVwZDmZcVv
         v1+qXVPSDQsHrSZTFeijZfqoThGlTZW2ltieOSIug5qmxSfCLgXibcjM4Ha3D1cq7nSV
         4Y0a4nIXwcWa6wAvvL/pTopD66ca9oxmVX2StSTie2bsmvk9ZkKSunu4WyDj5gtSKirr
         YpQQQwGFTddXO6JJnb28k4vek5z2pQY1lbKaj2U/Bd8qAwtctm8GC7qxS5kNZa3JKVOw
         SZsQ==
X-Gm-Message-State: AO0yUKVY840Z7C7sJQhEvZLbS+9g/20fHnmE9EDXTyhaIMLAcsssp4Hk
        21INiuuTdt+Sa0KdxPovmSebkuc6oJjFj/W9CavZ1FGpHkpBP+TtKOSd8NJGFITP7ZcfCXDFL4B
        pHeMQB8r7/aqrN5XX2v2AFkoUyw4U
X-Received: by 2002:ac8:550b:0:b0:3b8:4951:57bb with SMTP id j11-20020ac8550b000000b003b8495157bbmr3383751qtq.5.1675114492268;
        Mon, 30 Jan 2023 13:34:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+kUbZekNhe/Em61clYhE5CvtRxiubqnW3sSZZq/i2jVbSztFLD9L4HgdjzGzOWpE7h6EK0CA==
X-Received: by 2002:ac8:550b:0:b0:3b8:4951:57bb with SMTP id j11-20020ac8550b000000b003b8495157bbmr3383706qtq.5.1675114492023;
        Mon, 30 Jan 2023 13:34:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id l3-20020ac84a83000000b003a5c6ad428asm8589540qtq.92.2023.01.30.13.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:34:51 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:34:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y9g3+RdfYIH3N47i@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-4-usama.anjum@collabora.com>
 <Y9QLqY0mQ6eD6Zm+@x1n>
 <01bc1428-5340-5a75-6876-417194edba39@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01bc1428-5340-5a75-6876-417194edba39@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 30, 2023 at 04:12:25PM +0500, Muhammad Usama Anjum wrote:

[...]

> > 
> >> +#define IS_WP_ENGAGE_OP(a)	(a->flags & PAGEMAP_WP_ENGAGE)
> >> +#define IS_GET_OP(a)		(a->vec)
> > 
> > Having a->vec to imply the GET is fine, but IMHO not as clean as having
> > each OP a bit in the flags.
> > 
> > How about:
> > 
> > #define  PAGEMAP_OP_GET       (1UL << 0)
> > #define  PAGEMAP_OP_WP        (1UL << 1)
> > #define  PAGEMAP_OP_MASK      (PAGEMAP_OP_GET | PAGEMAP_OP_WP)
> > 
> > ?
> > 
> > Then a->vec requried for PAGEMAP_OP_GET.
> I had something like PAGEMAP_OP_GET and PAGEMAP_OP_WP flags once until I
> was asked to only keep WP flag and vec != NULL will imply GET flag in a
> previous review. I'm ready to change again if there are more notes on it?

Sorry to know that; that's somewhat frustrating when you need to go back
and forth on subjective comments like mine.  So if you still think your
original way is better then at least you have two votes now. :) Your call
to choose any, I have a preference as I said but not that strong.

[...]

> > 
> >> +			     struct pagemap_scan_private *p, unsigned long addr, unsigned int len)
> >> +{
> >> +	unsigned long bitmap, cur = PAGEMAP_SCAN_BITMAP(wt, file, pres, swap);
> >> +	bool cpy = true;
> >> +	struct page_region *prev = &p->prev;
> >> +
> >> +	if (HAS_NO_SPACE(p))
> >> +		return -ENOSPC;
> > 
> > This can be moved to below [1], we should stop scanning immediately if the
> > condition met.
> It would be definately possible. Wouldn't it be strange to return error
> when the operation was successful? A function should return error only when
> the current execution is unsuccessful. So I'm returning error only when the
> space is full and there is no space left in the buffer anymore.

I would expect the user to always provide some more space than they expect
because the merging of page_regions are kind of unpredictable from the
user's POV.

But yeah, maybe you're right.  I'm fine to keep that as is.

Thanks,

-- 
Peter Xu

