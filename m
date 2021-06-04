Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E839C26C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 23:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFDVcM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFDVcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 17:32:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CFC061766
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Jun 2021 14:30:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 11so5304616plk.12
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jun 2021 14:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y82vlUdyWeMAr7e63Dj4j+wcqdc77Hu1B4Tw/o9SLMs=;
        b=aypJtca7l/KpD4E2paDroJDyKsinPUWC0yUQNyIzZl97PiuWTz2R5MdpTk0hKEJuW7
         Kcc0UXCRCYopCWV15JnD4HbUEqp7kTbswrmFf2W0oawdCIw03Zg26xdZyQcJnqFeOIW5
         xE/MogjtklkQa6qgBcTfprYMKyD0QmumUjGb9jl+tMXNas53ZrWRXLbzD3kwOSVlACP1
         KTq8Qqpzj39s5ARnPtF9BCTkAaQlMKQDh5NJtkSxbvn+bnIxH+hKPMGEf9/GRIcuNzKy
         oKlL6VKgGfZ3qEMk+Qdu2DVagZIUplPihiJ+cWPcTtvpNfBONJ26yQpDW1teceg451Rn
         OOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y82vlUdyWeMAr7e63Dj4j+wcqdc77Hu1B4Tw/o9SLMs=;
        b=kgO9pjLOyfksBmayPMAvpReNLK0WsGPQlfJ8//p48Mjpuhbs5AprnwJGmFI+8TWMH2
         /W9mzntqd7+OSybOIBtOugIQSrjiuXyW+w7OdMVj315QgK0IJWT3lvp4/9tfTTPJicjP
         cO7ExZ+LY+PKFf5GFlM+dxR+Nsmo0iflMRGl0MTdkMjYQA5GkGxgsJzleX/gk3sOxJU0
         L+ogB38P7qkGQ843eaPqtcwCNT+AHsTEnIX6QDlSz8JZe5XKwbs2bMTumv2t3IK96Gqf
         oazjtXamKM5hIcOkeiJlpj3J1yCOVJDhf81J89ivOMhwelsfeNUZ5StsBP22YQgaG9/a
         QwUQ==
X-Gm-Message-State: AOAM530owFUOyEd87DLq9xK9YtiUjUNzZeGeyIRbH1l1RvA+HEPaQKMu
        W4GcSlbfzVJr7tPalFfK5dg9SuHKPGHDaKOltFOmlw==
X-Google-Smtp-Source: ABdhPJwU4JpGr4VuZdZYSpiYMTBhSPdpK+DlYYWr/X1ghG8V2iJ/e10YXb/wDDgEdSkIzZhipi0sXH/wWOsoXo+QOxU=
X-Received: by 2002:a17:903:1c3:b029:f4:9624:2c69 with SMTP id
 e3-20020a17090301c3b02900f496242c69mr6292705plh.51.1622842224869; Fri, 04 Jun
 2021 14:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com> <20210528075932.347154-2-davidgow@google.com>
 <CAGS_qxpg7PdGPiP5kmzBthh=eHd+SYmyvUitQV40Weej3wD4QA@mail.gmail.com>
In-Reply-To: <CAGS_qxpg7PdGPiP5kmzBthh=eHd+SYmyvUitQV40Weej3wD4QA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 4 Jun 2021 14:30:13 -0700
Message-ID: <CAFd5g44VS==1yULMRS-JMxrArj9GFJRkuDCxoxnZHcj3PVbFHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: tool: Support skipped tests in kunit_tool
To:     Daniel Latypov <dlatypov@google.com>
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

On Tue, Jun 1, 2021 at 8:46 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, May 28, 2021 at 12:59 AM David Gow <davidgow@google.com> wrote:
> >
> > Add support for the SKIP directive to kunit_tool's TAP parser.
> >
> > Skipped tests now show up as such in the printed summary. The number of
> > skipped tests is counted, and if all tests in a suite are skipped, the
> > suite is also marked as skipped. Otherwise, skipped tests do affect the
> > suite result.
> >
> > Example output:
> > [00:22:34] ======== [SKIPPED] example_skip ========
> > [00:22:34] [SKIPPED] example_skip_test # SKIP this test should be skipped
> > [00:22:34] [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
> > [00:22:34] ============================================================
> > [00:22:34] Testing complete. 2 tests run. 0 failed. 0 crashed. 2 skipped.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Some minor remarks, but this looks good to me.
>
> Though I'm surprised there has not been any bikeshedding done about
> the color of the SKIPPED output.
> So I'll throw an opinion out there.
> I think yellow is fine, but I did somewhat recently change another
> similar tool to go from yellow => cyan for SKIPPED. The motivation
> there was to have a color for "flaky" tests that stood out, and the
> most appropriate ANSI color seemed to be yellow (between green for
> PASSED and red for FAILED).
> And I don't know if KUnit tool will ever get to the point where we
> automatically rerun tests on failure, as I can see an argument for
> that logic living a layer above.

I do have some sympathy for using a different color for each type of
message. I am not arguing against cyan, but I am also OK with yellow.
However, if we get to the point where we support flaky warnings, what
if we used orange for flaky?
