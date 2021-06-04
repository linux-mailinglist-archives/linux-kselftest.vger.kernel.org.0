Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94139C2C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDVqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFDVqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 17:46:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07A0C061766
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Jun 2021 14:44:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k16so11619568ios.10
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jun 2021 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDIwKF3tXJwdhNB+DHHLy82arK7mNJOODtr324WveQ8=;
        b=e41RXUqdJchuOB1w7K6NzyXtZGfne8AOS/sZPU047rJyTfwgHCq+qOHEHeIjSMEKSo
         PSEtOs7LP9MD45rauKeCzYDTBdj3ivoy7InidmkFLs7ufFfcMFVxMwMGv3+l5Y+yY+eH
         67QfgAHj/ksfBz7BV+ZcqpiYCaC4Zqgz/WGk3lqpb0Mzgns1qfe/qJDLuPbvwhuecbsQ
         HLUddJ4wn2WCjVNoMhx1tO0h0St9ay5nsLUtJYJmxx7wz+AJxvssgk43XD6bBWlKumV6
         HqPONZq2+d4WjY3VqwdyrnLDRi3fYcrsAukIt9ZjF+tNGxOAgk/ReGDwnB1JAiSikb8j
         0Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDIwKF3tXJwdhNB+DHHLy82arK7mNJOODtr324WveQ8=;
        b=PopMpruTreQKlJkqKEq/DSrkrZ96TBhdU/IkO1PGHrOl6KFzxi2gv1Ktxh4HrKjo6T
         NDmkib5g4pDY2lAQibkNEjhqr0chDsWohjg7KNqY2jD6BkaXlc4pCd1Vkyk2ctl7T/jp
         ueols7/QiuHULoAWFh2kHUZ0K0F63hdh2R7EJmoWPn6cNe0VkWWlZo3gJ+SYKbaOcz80
         s2BU/BKKCxAo5VtdQ8SrhWaTOexFAP+X1mMzsxqhQfpVKTyQTAUTDlVgzXjk67zXoBIu
         54glsuoEMosB10WNpFCugKEfWnSxpWOwpuQO5MnvdbCpjZt5fmim5V3CHSrkBBLOQcIm
         J2Cw==
X-Gm-Message-State: AOAM533fMWCge3IVSstJBQHYxVttddoP74psrG2Y+8ItFoe+cVJDPyoC
        Itv3I/QKSRt6GtMw7Y/OVMDW9faEgSUP6XaNdzNoCQ==
X-Google-Smtp-Source: ABdhPJx5T1BdLmEbI0r5D5cDt1NRgM/HF2frMpAd3LDm7Uut+c2oGltlQGL00VtKf37ht9Pi35X0zXwvL35nGlFCtyA=
X-Received: by 2002:a02:335c:: with SMTP id k28mr5867362jak.4.1622843055875;
 Fri, 04 Jun 2021 14:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com> <20210528075932.347154-2-davidgow@google.com>
 <CAGS_qxpg7PdGPiP5kmzBthh=eHd+SYmyvUitQV40Weej3wD4QA@mail.gmail.com> <CAFd5g44VS==1yULMRS-JMxrArj9GFJRkuDCxoxnZHcj3PVbFHg@mail.gmail.com>
In-Reply-To: <CAFd5g44VS==1yULMRS-JMxrArj9GFJRkuDCxoxnZHcj3PVbFHg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 4 Jun 2021 14:44:04 -0700
Message-ID: <CAGS_qxocLmAV9TDw1dqqhJa=UZMt=sa9ohqJpcQ=xFT=gz0CGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: tool: Support skipped tests in kunit_tool
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 4, 2021 at 2:30 PM 'Brendan Higgins' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Tue, Jun 1, 2021 at 8:46 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Fri, May 28, 2021 at 12:59 AM David Gow <davidgow@google.com> wrote:
> > >
> > > Add support for the SKIP directive to kunit_tool's TAP parser.
> > >
> > > Skipped tests now show up as such in the printed summary. The number of
> > > skipped tests is counted, and if all tests in a suite are skipped, the
> > > suite is also marked as skipped. Otherwise, skipped tests do affect the
> > > suite result.
> > >
> > > Example output:
> > > [00:22:34] ======== [SKIPPED] example_skip ========
> > > [00:22:34] [SKIPPED] example_skip_test # SKIP this test should be skipped
> > > [00:22:34] [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
> > > [00:22:34] ============================================================
> > > [00:22:34] Testing complete. 2 tests run. 0 failed. 0 crashed. 2 skipped.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> >
> > Some minor remarks, but this looks good to me.
> >
> > Though I'm surprised there has not been any bikeshedding done about
> > the color of the SKIPPED output.
> > So I'll throw an opinion out there.
> > I think yellow is fine, but I did somewhat recently change another
> > similar tool to go from yellow => cyan for SKIPPED. The motivation
> > there was to have a color for "flaky" tests that stood out, and the
> > most appropriate ANSI color seemed to be yellow (between green for
> > PASSED and red for FAILED).
> > And I don't know if KUnit tool will ever get to the point where we
> > automatically rerun tests on failure, as I can see an argument for
> > that logic living a layer above.
>
> I do have some sympathy for using a different color for each type of
> message. I am not arguing against cyan, but I am also OK with yellow.
> However, if we get to the point where we support flaky warnings, what
> if we used orange for flaky?

We can always change the colors later.
I don't seriously think this should hold up the patch.
I was partially just bemused that no one had chimed in about the
color, as that is the apocryphal thing to bikeshed. Was curious if
broaching the topic would elicit any response, but given the silence,
I think we can truly say that no one cares.

Also, orange only works if we're going to assume 256-color support,
which I'd be against*.

Given that, our options are:
Black, Red, Green, Yellow, Blue, Magenta, Cyan, White
(and the "bright" variations thereof)

So yellow is the closest we'd get, which is why I'd made the shift to
cyan for the aforementioned other projects.

>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAFd5g44VS%3D%3D1yULMRS-JMxrArj9GFJRkuDCxoxnZHcj3PVbFHg%40mail.gmail.com.
