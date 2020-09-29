Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C758627D52D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgI2Rz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 13:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2Rz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 13:55:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C9C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 10:55:26 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c62so5225757qke.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ZNnkzAFolvu6loEFUCNXafFTWzkfs/zAnBvd6ABHu4=;
        b=ZpTZHWVvwxozfjUlDLnIpEwgeqdqJOUtrAs7iTklXyJsXWIZCE/UCcbieWAuzgy0Xb
         UlE2fIZWIwUB/1ZuycAItnHPYWfjLcbdHspaMc+oCeIJtx4xhqkwdaKnR3aWXJRHcuPR
         3+myR0wJOTuJ4zbdcjAR2EYfLImD2FRBurs1gZXzpLFNQBOSXDa8Qb+HqODbUqAkqIe1
         J7ncyzuDahlWYxtz42s+FYC6hfqNXGFl7KA1fHerNFAPXK0EkD66RlRRAPeakBY8l420
         DFzD1qmnUpasrmcgpc0Te4FnzOd6pFxnRY1BvdgqEARYAj4MjkRtCDe2TfXgMQjukv81
         3UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ZNnkzAFolvu6loEFUCNXafFTWzkfs/zAnBvd6ABHu4=;
        b=qh60V4RmRFyBhcriZbJneGzLV2eSuVbipTD9bH2zCZJcmccO+A2dySd+2MPIp+6/Z+
         kdpsU72AOUpQfLwYOz+jVHuKnf7+Iw2FFY+waUNVq1EGiJNDpic1bU+lI9XZy4pDwqHu
         MI52HsgNckNyndXhNvxVNGKoN7+IpvSIJOSGdlMQfp/fbNfJ3rmIvZNn60OBUB2FR1Jt
         +EIcTZ82Q5Mb3AXtsklGeoJduABtiKoSirsngePxfNxtXqi9QaXbgwqVUUpbh/adsd2n
         +n/sd+HUCQuz9LdfpDnS3ZApMICZfu1tViFPcFe0xiK3eIsR0/S67jRbraDNWyT5gCpI
         21qw==
X-Gm-Message-State: AOAM531Kz1SrUw/m9VL+KR+FJ+kXTBbQ++dXXTFjHBhXbO0kRZfpR6cX
        s64knfkHP2I+59WKy137BHHxD78NHEYsms+e
X-Google-Smtp-Source: ABdhPJzHLX2ByFHv32dS3gnU4tapsxvQAY3sZxaCPbXUtUBQirGrga7lViq5kS/qYAkv5k6qJ2xeeQ==
X-Received: by 2002:a05:620a:1657:: with SMTP id c23mr5436789qko.382.1601402125757;
        Tue, 29 Sep 2020 10:55:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a3sm6216379qtp.63.2020.09.29.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:55:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNJqW-003DRg-DU; Tue, 29 Sep 2020 14:55:24 -0300
Date:   Tue, 29 Sep 2020 14:55:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
Message-ID: <20200929175524.GX9916@ziepe.ca>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
 <20200929163507.GV9916@ziepe.ca>
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 29, 2020 at 10:44:31AM -0700, John Hubbard wrote:
> On 9/29/20 9:35 AM, Jason Gunthorpe wrote:
> > On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
> > > On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
> > > > On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
> > > > > diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> > > > > index d1ae706d9927..9cc6bc087461 100644
> > > > > +++ b/tools/testing/selftests/vm/Makefile
> > > > > @@ -130,3 +130,5 @@ endif
> > > > >    $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
> > > > >    $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
> > > > > +
> > > > > +$(OUTPUT)/gup_test: ../../../../mm/gup_test.h
> > > > 
> > > > There is no reason to do this, the auto depends will pick up header
> > > > files, and gup_test.h isn't a generated file
> > > > 
> 
> Oh, I misread your comment! You were talking about this Makefile
> dependency that I'm adding, rather than the ../'s in the path.
> 
> Well, for that though, it also has to stay as shown in this patch,
> because of this:
> 
> I don't see any "gcc -m" type of dependency generation pass happening
> in this relatively simple Make system. 

It happens with -MD, all the deps are stored in files like mm/.init-mm.o.cmd
and sucked into the build.

> And so, without including an explicit header file dependency (at
> least, that's the simplest way), changes to gup_test.h are not
> detected.

Shouldn't be

> Both the Makefile code and the observed behavior back this up. (I
> expect that this is because there is less use of header files in
> this area, because most unit tests are self-contained within a
> single .c file.)

Something else is very wrong then.

Jason
