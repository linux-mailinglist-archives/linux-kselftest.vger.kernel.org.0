Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE445CEBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 22:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbhKXVG6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 16:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbhKXVG6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 16:06:58 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD8C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 13:03:48 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h16so2955354ila.4
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRgEs5yEfhkrlGin3uE1wdrU8+VcrbvQSps4QjnAk0c=;
        b=dwie7mL2uy3cCFRAOewziMhsZTb0pZXsZEEvK34fBghiOgsq0ZmgtunpUR3Droo614
         QnZIjMPqWSwf6Tbk6K9QfG8W+PePkZUf9Q8Eb16XBVIRxMmcAVLD9J8ub0vTHzjWFZxJ
         UKKG5NylWtPOD897dmCZHcvZMIbvQE1dDUyYMSW10Z6n6upcrtSv4KmI8fZ0My/Lh7Vf
         iT10o+P53kPpMMj2soFmSc1sPIs78UkB7RcGNzwMxmuq2GCGtysNimwYCrx0Vv/4+lHy
         wwGB8MRZS2wKraVRa5sh4tDv/NMxD9LMxhPi7fuc3OlrZ/GPmHOzb4L+HPtvNCn1y3WL
         4Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRgEs5yEfhkrlGin3uE1wdrU8+VcrbvQSps4QjnAk0c=;
        b=USxgT0FrCTOD1vbR8CohdnfO3DR38wKaWg8Jk/0x1KCI3g0qeSGkR/YCSi2cUVubFH
         9hg7/o855S7Io1UKgqZTAhY4RYUYYBSd+5MJ5HwOJy14b8IsvfpzOYafcVnvCapEcyjC
         bfRIFrRRfLnqrqg0olHk5f6FOS3Ki6+wTNeCc6p7REGxUNep+HNMP87aQ0t79EKtxALL
         g6+oZZkdSQtvvVcJ/szmSCH+GaUyqRXli74Cgba75M4yWV41pFVDB1ARgb8lODIaW1uc
         ZYtkzg9oOY7I50eIRVQzaRz1goFIIgN0lKO+Rs4Jn8nrO74317wMqtRm0n7RwN0Vq2to
         /bqg==
X-Gm-Message-State: AOAM530gp+lRgsMyLggHdH+0PEuX1J+7xg8dhl/jv7ZoVLuXAg7Q9bUb
        Mvmu7sxsPcA0/RzkOoT6vM7ZNglcZGJvrij9Mm5VZQ==
X-Google-Smtp-Source: ABdhPJzDrYVvZMlQMF1f8Ii4oZBZ0b9X/HKX/rkq2WetLfBWG93Ny+25ZkGcpfW2TfjCBmr4K7leRbVVDdDK0JYc56o=
X-Received: by 2002:a05:6e02:1bc3:: with SMTP id x3mr15195842ilv.39.1637787827560;
 Wed, 24 Nov 2021 13:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20211123204644.3458700-1-yosryahmed@google.com>
 <6ebcffe2-9513-cbea-a206-15ba927416c7@oracle.com> <CAJD7tkYZY1g_b9E4ZP3yqHhT36nF57c4bzKRQM-SLftDCYNQ9A@mail.gmail.com>
 <a87c5768-9bd3-a2f5-7eb5-d2813b958514@oracle.com>
In-Reply-To: <a87c5768-9bd3-a2f5-7eb5-d2813b958514@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 24 Nov 2021 13:03:36 -0800
Message-ID: <CAHS8izNi0uY5LY2_jF6m0hzJHz87dK2AZ+Y=ggAkMNpW7kaonQ@mail.gmail.com>
Subject: Re: [PATCH] mm, hugepages: fix size in hugetlb mremap() test
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 23, 2021 at 7:42 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/23/21 18:19, Yosry Ahmed wrote:
> > On Tue, Nov 23, 2021 at 5:08 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 11/23/21 12:46, Yosry Ahmed wrote:
> >>> The hugetlb vma mremap() test mentions in the header comment that it
> >>> uses 10MB worth of huge pages, when it actually uses 1GB. This causes
> >>> the test to fail on devices with smaller memories.
> >>>
> >>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>> ---
> >>>  tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> I'll let Mina comment, but I think I know what happened.
> >
> > Thanks for taking the time to review this and explain what happened.
> >
> >>
> >>
> >> The original version of the test did indeed use 10MB.  However, the mremap
> >> code must 'unshare' and shared pmd mappings before remapping.  Since sharing
> >> requires mappings of at least 1GB, the size was changed to make sure unsharing
> >> worked.
> >>
> >> In the end, I believe I suggested adding hugepage-mremap to run_vmtests.sh.
> >> The script does not try to configure a GB worth of huge pages.  And, I think
> >> it is somewhat unreasonable to suggest users gave a spare GB to run the test.
> >
> > Alternatively, we can pass an optional argument to the test that makes it use
> > 1GB instead of 10MB. This way, if the test is run with run_vmtests.sh the
> > default behavior would be to use 10MB, making sure users do not run out of
> > memory. Otherwise, an interested user could run the test without run_vmtest.sh
> > and provide the extra argument to make the test use 1GB and make sure that
> > unsharing works correctly. Thoughts?
> >
>
> Passing a 'mapping size' argument as you suggest would be best.  That way
> run_vmtest.sh can pass in a size such as 10MB, but the test could be used
> independently with arbitrary size mappings.
>
> If you have the time to do this, go for it!

Yes, Mike's recollection of events makes sense to me. I think that was
the mistake that happened (sorry!)

Making it configurable makes sense to me. I'm out for the rest of the
week but I'll try to review sooner if possible.

Thanks for looking into this Yosry!
