Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ECA5F5AF4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJEU1J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJEU1I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A6DFA4
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665001627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irL9v4RVF7/aYmYVm2x3MQE53BoPEWEw/ly3HFpcK3M=;
        b=SnAGyJ7IvDI3UJFeV53DkIOTwsBxjqrnYMHBMCQ60fvk4B3lUka0j/4Qxt8AM+S9CpEkG2
        s1bnHSw5IWeO8LePZW5WTM42t+ueeSUspoOzgDK68KfNSACpbH9GmqcWJIDRZUUDrbo4kC
        EXaTYYKOmX90Mye5nsslHInTRw/4ASE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-W_AsMI5AP7GFKh9RwDPCbg-1; Wed, 05 Oct 2022 16:27:06 -0400
X-MC-Unique: W_AsMI5AP7GFKh9RwDPCbg-1
Received: by mail-qt1-f197.google.com with SMTP id cg13-20020a05622a408d00b0035bb2f77e7eso11969340qtb.10
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=irL9v4RVF7/aYmYVm2x3MQE53BoPEWEw/ly3HFpcK3M=;
        b=okg3sHNb3SqOYAJj5s2J64GWjgdEYnQxncp+d2NivHvSfShSt25rTlSZhIosB+8Vew
         CLqzRNmxwINsgtmbOUk7l6JXqlwAyIASoNTOnjkjzco5IrFkoOcqzcbX4VbBFUEmH69k
         Xbb/j1k5wW2LP65fC7j+erkDfgdsUGBKBLlVCFk+75uvbIASrDMfQncUAP8OXm/Bdp4x
         U6Qj55o1bzd9pg1I8zSEIicP198A5x9VZxgNSR7/gW0p9b/2xDu7kscGC1HzpipNW4Z2
         JROCz67ZMmflMKX5q1pBl0zQS0WJfPhMRc9Xere50aBXbtn2PIQxzgHPEJn59ntN97fc
         lh4g==
X-Gm-Message-State: ACrzQf1nzXoe58p5A/lKi6mP5mjYWAzpJD1lQZSPNuTG0Ut6+zhL+IFP
        P06nUuskZ7G3Rb2P6VHOgKybFKYl/nq8YZfHAnj73b90tcimjJQf4qB6Ur0zwgLkbEQJSeZ6kmB
        EwPNVsOH47trjBdahyVbgCnwdkYcK
X-Received: by 2002:a05:622a:24d:b0:35d:4a77:3cf0 with SMTP id c13-20020a05622a024d00b0035d4a773cf0mr1058614qtx.28.1665001625599;
        Wed, 05 Oct 2022 13:27:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7SvsctwEXrw4dPRUCalzLH+RefoJ7FMG/zQCe6j6y45f5jAsslKsd1wQ1yesomiKMpK6FUTg==
X-Received: by 2002:a05:622a:24d:b0:35d:4a77:3cf0 with SMTP id c13-20020a05622a024d00b0035d4a773cf0mr1058603qtx.28.1665001625383;
        Wed, 05 Oct 2022 13:27:05 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i7-20020ac85c07000000b0035d420c4ba7sm16026331qti.54.2022.10.05.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:27:04 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:27:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 1/7] selftests/vm: add test to measure
 MADV_UNMERGEABLE performance
Message-ID: <Yz3ol51pE0XZM+Ah@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-2-david@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:25PM +0200, David Hildenbrand wrote:
> Let's add a test to measure performance of KSM breaking not triggered
> via COW, but triggered by disabling KSM on an area filled with KSM pages
> via MADV_UNMERGEABLE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

