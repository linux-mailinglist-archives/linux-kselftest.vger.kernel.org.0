Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFB63CAD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 22:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiK2V6e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 16:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiK2V6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:58:19 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19226F0EB
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:58:18 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id t15-20020a4a96cf000000b0049f7e18db0dso2352438ooi.10
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qNiwWVeUDZhUGkAMdWkcINE9IEMdNV90cmxq2ELUVsE=;
        b=Sj8m+nBoglCwGTAvzyCOZFPLzCTKOMoL4GBgeA2YK+rU5nZnxvl7BtjJRYWDdXLPl+
         ELsdJ0bO5IOPyfC179kLdQH7gqq9QX5TJwALmkWKyvDq7eKHaF0bMqOMGE+zizOBxBzt
         VOIHD13NJBVFWCIsyfHaadUqwwbr77vYjS8FGtTYbU5HoMCPgArR/S9Xhjfv9o/U4Usw
         pMjteBn+4ad6b0ODEzpZJ71grNR4s9TOfZhGjOeGc8bLjBnQGXJwLkgfYNBFyU+DR2Wa
         q9YBVCQArE19oVLsQHgpP0uMt5vlBuTNGcug5PDzHm/CzZrhrnY07uk5nGlEoaQHMkAx
         QOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNiwWVeUDZhUGkAMdWkcINE9IEMdNV90cmxq2ELUVsE=;
        b=0RHgfESIB35jiyDYtFeFbB0unD2SKN6k3zv5LU0PBAPadQKcegTA0f1P+tbHGKHcC2
         yIabgMdxOAv7mEzlMDGW6RXsks7qcerw4eQmzaBQHsrS5eY6nwQTjmmDwofYZrS1z7jk
         ekfbg+ysv9AMcg36qhSw/IEob6VC3a+N2YLP1d/bZIcxLzeV7c8bVR5kx4a6BjcAefBA
         URGdBGIOI3fmoIP20RpjrYGPar0AzAk1rEU/CGAYs62FiNZnUTegnUamnxXgMGodqdYD
         6Ka+xUR4LpSqd0lxjNmLNGBJo/+RV3lFJLhzuDlHbl3eW0/laKHRrI5l0EZIN51OavA2
         CZdA==
X-Gm-Message-State: ANoB5plm1CfRyTyzRTqOp5Paw6pIklzhxqi7qDZ4nq0OmnbLalmL8GDM
        ISqzRy1FRgrVE2hJk2W9ycY3pg5IVumFGNFn8UXSMg==
X-Google-Smtp-Source: AA0mqf6AFUPllnZD8NF7NKN1LHRFaxLM5PkE/hfisqVBxp8pN2Dh3n0d8uMbt2bezKPT0FwlLQX23RUNjBtSVA9Hlv0=
X-Received: by 2002:a4a:e0d3:0:b0:49f:de1:96c0 with SMTP id
 e19-20020a4ae0d3000000b0049f0de196c0mr24898644oot.7.1669759098052; Tue, 29
 Nov 2022 13:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20221129001234.606653-1-dlatypov@google.com> <CABVgOS=6nx2SGRVjN1Ek1htsXehcnU1fnp6FMc0ATdOJfRd0iQ@mail.gmail.com>
 <CAGS_qxqu+opwMusOGSS3s9fLo2GfpgsCQOgq6VZyBcVb+zS6Zg@mail.gmail.com>
In-Reply-To: <CAGS_qxqu+opwMusOGSS3s9fLo2GfpgsCQOgq6VZyBcVb+zS6Zg@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 29 Nov 2022 16:58:05 -0500
Message-ID: <CA+GJov6QKNy5fxkiu0P29WDtFgNs0GP4T27=X5Sva+V_BYc3+A@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: don't include KTAP headers and the like in
 the test log
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, brendanhiggins@google.com,
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

On Tue, Nov 29, 2022 at 12:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 12:31 AM David Gow <davidgow@google.com> wrote:
> >
> > On Tue, Nov 29, 2022 at 8:12 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > We print the "test log" on failure.
> > > This is meant to be all the kernel output that happened during the test.
> > >
> > > But we also include the special KTAP lines in it, which are often
> > > redundant.
> > >
> > > E.g. we include the "not ok" line in the log, right before we print
> > > that the test case failed...
> > > [13:51:48] Expected 2 + 1 == 2, but
> > > [13:51:48] 2 + 1 == 3 (0x3)
> > > [13:51:48] not ok 1 example_simple_test
> > > [13:51:48] [FAILED] example_simple_test
> > >
> > > More full example after this patch:
> > > [13:51:48] =================== example (4 subtests) ===================
> > > [13:51:48] # example_simple_test: initializing
> > > [13:51:48] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > > [13:51:48] Expected 2 + 1 == 2, but
> > > [13:51:48] 2 + 1 == 3 (0x3)
> > > [13:51:48] [FAILED] example_simple_test
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > I totally agree we should skip these from the log. (Unless
> > --raw_output is enabled, but that obviously doesn't apply.)
> >
> > Going forward, I think we should also probably disable
> > kunit.stats_enabled when running via kunit.py, too (again, unless
> > --raw_output is used.)
>
> I considered including that as a patch 2/2 here.
> But changing the behavior like that felt a bit iffy.
>
> We've basically been telling people that looking at .kunit/test.log is
> logically equivalent to running with kunit.py run --raw_output.
> That would no longer be true after such a change.
> So I'm torn between that and automatically filtering them out in the
> parser side.
>
> Cons of tweaking args based on --raw_output
> * now more magic, harder to explain (see above)
> * people might find test counts useful when looking at test.log
>
> Cons of filtering out test counts in the parser
> * risks false positives: filtering out other lines besides test counts
> * when there's missing output, this is less debuggable
>    * 99% of users are *not* going to dig into the python code
>   * but IMO users are fairly likely to notice the extra
> kunit.stats_enabled=0 cmdline arg
>
> And overall, the benefit of hiding these is very small and cosmetic in nature.
> So that means making a tradeoff to do so feels more iffy.
>
> The hiding done in this patch seemed fine since there was no tradeoff,
> we just needed to stop including lines we've already recognized as
> KTAP directives.
>

I tested and reviewed the changes and this all looks good to me. Nice
to no longer print the KTAP version line or test result lines in the
test logs.

To comment on the above discussion: of the options discussed, I would
prefer to either tweak the stats_enabled arg based on the raw_output
flag or simply leave the output as is. I personally think that
filtering out the test counts using the parser would be messy and does
not match the precedent set by this patch to not include only
recognized KTAP directives in the test log (with the exception of the
"# Subtest" line, which I am planning to propose for KTAP v2).

I agree with the cons to tweaking the arg based on the raw_output flag
Daniel mentioned above. Additionally, I think including the test
counts line in the log could actually be quite useful in the instance
of combining module results. Since the parser does not include a test
summary line with counts for failed subtests, this would save the time
counting up the number of failed/skipped/passed subtests for a
specific module. This would, in general, also apply to failing tests
with a large number of subtests within them.

That being said I would be ok with tweaking the stats_enabled arg
based on the raw_output flag as well. It does look cleaner without the
counts printed in the log, especially when there are only a few number
of tests or the test summary line of the parser repeats the same
information as the test counts line.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
Rae

> >
> > In any case, this looks good and works well here.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
