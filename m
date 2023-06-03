Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF09720CF2
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 03:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbjFCBTY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 21:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCBTX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 21:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC761D3
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685755118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acfZzs+Sz32fwYHtqNNYmLTK9zTzmicEiE02c1Yi1MU=;
        b=VS7T/N22YSo3Hf5kVmWUWE4OVn5FyZzkX4GenN7/50018VUV0AkoesJfZNRJTDv8y3IaPJ
        f/5gDNlpr1bZvyB3fYr9W/Luix3EewGRQmY48AbU7XqGyWZoFqtCsfRSJp6FmrionKmxgH
        DfA6BH9FNPdQ1rZ8NI1iAp9D+vAme0g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-2X3-IJZJPEuIgq1xqNobIw-1; Fri, 02 Jun 2023 21:18:36 -0400
X-MC-Unique: 2X3-IJZJPEuIgq1xqNobIw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62849c5e9f0so3076146d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 18:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685755116; x=1688347116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acfZzs+Sz32fwYHtqNNYmLTK9zTzmicEiE02c1Yi1MU=;
        b=e9pFpr7GtsY0nvC1TPjQGFWOCMdKLBsbbueKvgVDa2smNKdE1ad04OIJ8P0CSnStRz
         l+vLPDOOgcDoMulowjn9gpvouYMd7SJAKhONIJUoxW0mwz7kzS8u1ICniDyu9WDusMc0
         nZmuWJH0OywtJu7Bjg3eEiAKb7PQycVBkoUAk+rZzWFbLDcZJKgGDq48kqZAow59tuI1
         Wm4yKuVhII/DmlmTh5Uw1HynvEMKPJkuIH9Fiw19qMuYtZUAkeKD7bxaHkZvzehmWWkT
         IG5jsZuyXZNYwdsONugKpaRb1jLN/wiaQpiHbw4qQHBfgE4RI23R5ZMYoNVFJ3EyDf3u
         T92g==
X-Gm-Message-State: AC+VfDze3sd6gY7y5Tk+ommpVEXrN1inut306cmyBuiaPWJyydqccoWc
        i7oBQ0QouEJTLwKo9AgvuEj8+NMdGe+BIfQseHIAga4QNsg7aF6RqH9UpvKe49XK1gZJBPHgi0s
        MonFwDnnaiNc/cV2LHbRDUqGiZW8P
X-Received: by 2002:a05:6214:529c:b0:625:77a1:2a5f with SMTP id kj28-20020a056214529c00b0062577a12a5fmr13570227qvb.5.1685755116498;
        Fri, 02 Jun 2023 18:18:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Xw/XJL0EduiCR89X24e2H4ew9ONg/1wrueVo1QBSQY11bbgWadu8LV1r/8ab1L3EsiP0FlA==
X-Received: by 2002:a05:6214:529c:b0:625:77a1:2a5f with SMTP id kj28-20020a056214529c00b0062577a12a5fmr13570215qvb.5.1685755116159;
        Fri, 02 Jun 2023 18:18:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id mx8-20020a0562142e0800b006261e141f4bsm1508270qvb.87.2023.06.02.18.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:18:35 -0700 (PDT)
Date:   Fri, 2 Jun 2023 21:18:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/12] selftests/mm: move uffd* routines from vm_util.c
 to uffd-common.c
Message-ID: <ZHqU6j4PAzy7ene0@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-11-jhubbard@nvidia.com>
 <ZHoR+3v+zUENBhi4@x1n>
 <68549f29-fe41-04d4-f648-245f399c350b@nvidia.com>
 <ZHpvZcdik7VPsEcL@x1n>
 <990f222f-643c-3b8e-6e5f-84dc98c3f2e8@nvidia.com>
 <fed573c9-2045-e13b-15b5-91df2446ef42@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fed573c9-2045-e13b-15b5-91df2446ef42@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 05:43:19PM -0700, John Hubbard wrote:
> On 6/2/23 15:52, John Hubbard wrote:
> > On 6/2/23 15:38, Peter Xu wrote:
> > ...
> > > > I think we're in agreement that we want to only include uffd-common.h
> > > > where it's actually required. Likewise with the uffd*() routines. So I
> > > > would like to still move this over, yes, just to have things in their
> > > > best-named location.
> > > 
> > > Sorry I didn't get it - e.g. I'm confused why we need to export
> > > uffd_test_ops into ksm unit test, it doesn't make much sense to me..
> > 
> > Oh, I see what you mean, finally. Yes. ksm should not need that.
> > 
> 
> ...whoops, correction, our very own David Hildenbrand recently made
> changes that contradict the claim that "ksm and uffd selftests are
> independent". In fact, ksm now *intentionally* depends upon uffd, as of
> commit 93fb70aa5904c ("selftests/vm: add KSM unmerge tests"), aha!
> 
> That added commit added a call to test_unmerge_uffd_wp(), to
> ksm_functional_tests.c .
> 
> So this needs to stay approximately as-is, it seems.

So I think it depends on what is "as-is" to me in the above sentence. :)

test_unmerge_uffd_wp() impled its own uffd ioctls, and it still doesn't use
any of uffd-common.h of now (e.g. uffd_test_ops).

IMHO if we want we can let test_unmerge_uffd_wp() reuse either
uffd_get_features(), uffd_open(), uffd_register() etc., but still all of
them are provided by vm_util.h not uffd-common.h for now, and that's
intended (vm_util.h can contain uffd helpers, or whatever helpers as long
as generic mm/ unit tests need).

We can even move wp_range() from uffd-common.[ch] into vm_utils.[ch], then
it can also share that (need to replace err(), that's uffd-common
specific).  Not necessary anything must be done in this series, though.

Thanks,

-- 
Peter Xu

