Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E647B63C629
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiK2RJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 12:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiK2RJo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 12:09:44 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2818C5D684
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 09:09:43 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3b48b139b46so145202277b3.12
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVb3wvICcN747O+jvC7vxIAJjyL4j7lkEgDJJO1LR3A=;
        b=HcNP+fi/2uvAX7ADjQIyenv50ifVamDfOWHKACyaxt6TonIK8DsSruNpJx5/BmGAVm
         TI1jSraHtL8u11jMt47k/Djnx+VMzu9ez5lpo2jV7YtRKHxzgbHKiFvTkJTKfdlt5ULR
         XrdWHCk75/3edfoc9gDiDUUEe/afCqrJUR9NEZ1pAwddPzW7dY9N6hY7cBWQaw1R5vpC
         yriRlqG7CMxUTGv8wkJsxPkYDNcpmZa9IWSGSfi+/12SnN2VszZsMVvsnVqLDhGFuhIV
         mWnIajP0TGZhThRW3dZvV80uAL290eWJnfamZbuzdEFtNLjX9BSZ5AP369I2bA1poi04
         R4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVb3wvICcN747O+jvC7vxIAJjyL4j7lkEgDJJO1LR3A=;
        b=ol6Tkg1743Y9d3Ssqg4TX36esStWG2+W5NEyVL/V+2+mi0L6jVcsTyNr2eesrmt3RP
         sNSYkASClNNGhzWmhG8UWiXMPZ4RoSqmuUOGC1sLKoGkv+wT6SxGxT00dvXThtrbjQJD
         BKNiAw5j7TWN97L8G4hURFQC2Vsh0YosjGrQsJyGnOtkx5c42RmUXCzx65G7VU034oBC
         3qjJb4R2jmHX4KmhVB8f+qljwDnou0aRqlAS3Gl+gxJb56JxPJxMIEUe/fd0hcbyhyt7
         Uh9b0JvIR8TF0Aw1WvH7/kJ7izE+ctxV+ywIvc/R0grKLvwDIpoe4eNZrl8xpDdUKP9z
         AA7g==
X-Gm-Message-State: ANoB5pksbR0ksKIts2g3ZUN9LD5z84IATJ6KI2IyXqc59siMRl0z8bAo
        mVCB4S+sCgqMpxPIyPjkk+vXSgWdZsHXsESGFGoQRw==
X-Google-Smtp-Source: AA0mqf6J3hIbOQvZD3q3Mptj980X01dG/EjoeW5Zzv3ZIWc3NuiOSSTXN6VUtrRGWhTqbFh3aZ7551sTroNKupGKPTQ=
X-Received: by 2002:a81:de4e:0:b0:3c2:47c6:814 with SMTP id
 o14-20020a81de4e000000b003c247c60814mr14295515ywl.394.1669741781891; Tue, 29
 Nov 2022 09:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20221129001234.606653-1-dlatypov@google.com> <CABVgOS=6nx2SGRVjN1Ek1htsXehcnU1fnp6FMc0ATdOJfRd0iQ@mail.gmail.com>
In-Reply-To: <CABVgOS=6nx2SGRVjN1Ek1htsXehcnU1fnp6FMc0ATdOJfRd0iQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 29 Nov 2022 09:09:29 -0800
Message-ID: <CAGS_qxqu+opwMusOGSS3s9fLo2GfpgsCQOgq6VZyBcVb+zS6Zg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: don't include KTAP headers and the like in
 the test log
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 29, 2022 at 12:31 AM David Gow <davidgow@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 8:12 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > We print the "test log" on failure.
> > This is meant to be all the kernel output that happened during the test.
> >
> > But we also include the special KTAP lines in it, which are often
> > redundant.
> >
> > E.g. we include the "not ok" line in the log, right before we print
> > that the test case failed...
> > [13:51:48] Expected 2 + 1 == 2, but
> > [13:51:48] 2 + 1 == 3 (0x3)
> > [13:51:48] not ok 1 example_simple_test
> > [13:51:48] [FAILED] example_simple_test
> >
> > More full example after this patch:
> > [13:51:48] =================== example (4 subtests) ===================
> > [13:51:48] # example_simple_test: initializing
> > [13:51:48] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > [13:51:48] Expected 2 + 1 == 2, but
> > [13:51:48] 2 + 1 == 3 (0x3)
> > [13:51:48] [FAILED] example_simple_test
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I totally agree we should skip these from the log. (Unless
> --raw_output is enabled, but that obviously doesn't apply.)
>
> Going forward, I think we should also probably disable
> kunit.stats_enabled when running via kunit.py, too (again, unless
> --raw_output is used.)

I considered including that as a patch 2/2 here.
But changing the behavior like that felt a bit iffy.

We've basically been telling people that looking at .kunit/test.log is
logically equivalent to running with kunit.py run --raw_output.
That would no longer be true after such a change.
So I'm torn between that and automatically filtering them out in the
parser side.

Cons of tweaking args based on --raw_output
* now more magic, harder to explain (see above)
* people might find test counts useful when looking at test.log

Cons of filtering out test counts in the parser
* risks false positives: filtering out other lines besides test counts
* when there's missing output, this is less debuggable
   * 99% of users are *not* going to dig into the python code
  * but IMO users are fairly likely to notice the extra
kunit.stats_enabled=0 cmdline arg

And overall, the benefit of hiding these is very small and cosmetic in nature.
So that means making a tradeoff to do so feels more iffy.

The hiding done in this patch seemed fine since there was no tradeoff,
we just needed to stop including lines we've already recognized as
KTAP directives.

>
> In any case, this looks good and works well here.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
