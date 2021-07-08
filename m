Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200E33BF2F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 02:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGHAwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 20:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGHAwH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 20:52:07 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C07C061574
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jul 2021 17:49:26 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h190so6065983iof.12
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jul 2021 17:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=40Ix/AUk8i4dOSp4zyNjwJIGya7v30/pNgmPrpFMK9o=;
        b=GersDKlJ7hWxUWAXaQUiohxRrvUH8Ddo2UpECKFh292dEvc0fT8+tK/PtvYHdnIOsO
         JMdGKCv9aFR80bXhq2ehGDeBMOSzKvi/1cIuHotAg7w52J6s7TzIPG1PGEt5nZL1ln/W
         lqeo8xeZ+ktwFkt2fZIEtGoz6A67QJ8Gv56PpRtpC+I8Acsv+w1Jajq+2rVMD8Y1pLEd
         9y+EATwBTa6DAwJKQFmOW6nyWiP0+NTcOGozwlTIiuqvOi+LDRAu8wOQD6XejmOp0Dc9
         4+RniVFDatLP4FPkgqAbLJMkeskQDpmJ8beLwd0aouHxiJ06/QqeGSmPOchTVuTYlH/U
         Mo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=40Ix/AUk8i4dOSp4zyNjwJIGya7v30/pNgmPrpFMK9o=;
        b=WWbLHnvdfzDHot6029R9EMn/lWd5vnzQ3zXXuwg+WNWn/uddi/njaGjPC3rGtQJFCS
         bruHeyXebShGgf3wfz793Px5OqXha6Ili64QEOBAbUYLgIIBwMK82jMRb0LusEKX5E1n
         mnRuNHYHqZa8wVH+lRDyG2eYG0nVH7vWOYUAGLZbCH9tgAVYAl7PSOTXDe13Mfj01LSE
         hVsh32cc14JPCPxgQaSjm5au9+ODYNkP6lS8BhLR7I3kFcZZwezadq/F4Jih/e13ITIo
         0BViLkHMOzzhWrlq4KK/bP7U7/zSYBVOZ2tO2quEtG8zbvYljFj9FWJjySzTYL+a9bDz
         I+jg==
X-Gm-Message-State: AOAM530mKChjGUQ+uKqunJ0Kj2HUxUuUE0sfs7W+eKzBEb1wRZub3UGd
        GtLgJmwbF2GYhahF0nrQ/QpRMg9N8Q9CiEwAvozdEw==
X-Google-Smtp-Source: ABdhPJw1R4UqcE6rbX3U8Iny/+2Llo6Jr7HSSMBETLbzYnKb7g64OybcbYfbwfD50t2mhdFUwrWNL7GXhAXm/uWELUA=
X-Received: by 2002:a02:2b27:: with SMTP id h39mr24664169jaa.62.1625705365613;
 Wed, 07 Jul 2021 17:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
 <CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com> <ac99a1ca-ed9d-78e7-ad71-ac3c1219b2fe@riseup.net>
In-Reply-To: <ac99a1ca-ed9d-78e7-ad71-ac3c1219b2fe@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 7 Jul 2021 17:49:14 -0700
Message-ID: <CAGS_qxpPahxB_b-5FRHpxMj1GoaK_xT3hsQA4TPQCMWfVxrHSg@mail.gmail.com>
Subject: Re: KUnit Hackathon
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, ~lkcamp/discussion@lists.sr.ht,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Leandro Ribeiro <leandrohr@riseup.net>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 7, 2021 at 5:23 PM Andr=C3=A9 Almeida <andrealmeid@riseup.net> =
wrote:
>
> Hi Daniel,
>
> =C3=80s 03:48 de 07/07/21, Daniel Latypov escreveu:
> > On Mon, Jul 5, 2021 at 1:41 PM Andr=C3=A9 Almeida <andrealmeid@riseup.n=
et> wrote:
> >>
> >> Hello,
> >>
> >> We belong to two student groups, FLUSP [1] and LKCAMP [2], both of whi=
ch
> >> are focused on sharing kernel and free software development knowledge
> >> and experience with fellow free software developers and newcomers.
> >>
> >> As part of our efforts, we'll be organizing a KUnit hackathon in the
> >> next Saturday (July 10), where we intend to help newcomers convert
> >> existing runtime tests (the ones found at lib/) to KUnit and maybe
> >> create new ones. Depending on the number of attendees, a high volume o=
f
> >> patches may be sent throughout the day. We will do our best to review
> >> all patches before they go to the kernel mailing lists hoping to avoid
> >> wasting your time with minor patching issues.
> >
> > That sounds great!
> >
>
> :)
>
> >>
> >> So we wanted to let you know of all this beforehand and give you the
> >> time to send any suggestions or comments on all this. For instance, we
> >
> > Some random, unorganized thoughts:
> > * I (as a kernel newbie) found the ownership of tests under lib/ to be
> > a bit unclear.
> >
>
> Indeed, but we found that tests under lib/ are the easiest ones to
> convert, given that they deal with more "generic" programming aspects,
> like linked lists and sort, and doesn't requires subsystem specific
> knowledge.

Yeah, I think these are the best for a hackathon.

Plus they're a better fit for KUnit right now, since they're the more
standalone bits of code.
Writing tests for more subsystem-specific code can require a lot of
groundwork, e.g. davidgow@google.com is trudging through what needs to
be set in a superblock to write ext4 tests.
Eventually, we'd ideally have some chunks of shared code to setup
subsystem-specific structures for tests, but they don't exist yet.

I didn't articulate it well, but my concern was finding the "right"
people to review the patches.
It feels like an unfortunate risk that we'll have to take, having some
patches potentially sit unreviewed for a while.

>
> > * Make sure to base on 5.14, there's some new features that could be of=
 use
> >   * QEMU support in kunit.py: it's no longer as big of a deal if we
> > can't get tests running under UML. Brendan's made it fairly easy to
> > run tests in an x86 VM.
> >   * Skipped tests support: can now mark a test skipped. Some of the
> > lib/ tests could benefit, e.g. test_hash.c
> >   * another lib/ test conversion just landed in 5.14, [1], along with
> > kunit_kcalloc/kunit_malloc_array() helpers
> >   * Documentation/dev-tools/kunit/running_tips.rst - has instructions
> > for how to generate code coverage reports using UML/kunit.py
> >     * This seems like it could be useful... [2]
> >
>
> Thanks for those info! I wasn't aware of those features.
>
> > * I feel that the hackathon will surface a number of feature requests
> > for KUnit. Some patches might be blocked on these features (like your
> > uuid patch).
> >   * Might be good to track these as they come up and note which
> > patches are blocked.
> >
>
> Good suggestion, I'll try to track this.

Thanks!
Hopefully we can try and help get some of these resolved, but it might
take a while.

>
> > * Should we make a decision beforehand wrt renaming test files and
> > kconfig options to match the style guide? In the most recent
> > conversion [1], I left them as-is. The answer depends on the test
> > owner, but we should probably be consistent with what we do in the
> > v1's at least.
> >
>
> I believe that to left as-is is easier, and we will suggest people to do
> that.
>
> > * I assume test modules used in selftests (test_bitmap, test_printf,
> > etc.) should remain untouched for now ?
> >   * KUnit does *not* return a non-zero exit code when you modprobe the
> > test, as the userspace part of those tests assumes.
> >   * We could write a wrapper like kselftest/module.sh, but for KUnit
> > test modules, but this extra in-flight patch would become a dependency
> > for maybe multiple other conversions.
> >   * I'd like it if we had ^ eventually, but I don't know how others
> > feel about that.
> >
>
> Yeah, I don't think we would be able to deal with all of this in this
> hackathon, so we won't touch those tests for now.
>
> > * I had some small patches for converting test_min_heap.c and
> > test_sort.c that I should get around to sending out.
> >
>
> So this means that we shouldn't convert them, right?

Yeah, you can leave those ones to me.
I'll try and send them out real soon so people can just check the
mailing list to see what's in flight.

I'm not aware of anyone else working on converting the other tests
right now, so everything else should be fair game.

>
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Debd09577be6c15ee2d343cf60e5bb819946a5ee8
> > [2] I currently see
> >   Overall coverage rate:
> >   lines......: 16.4% (20034 of 122481 lines)
> >   functions..: 18.1% (2032 of 11205 functions)
> > with the following kunitconfig
> >   CONFIG_KUNIT=3Dy
> >   CONFIG_KUNIT_ALL_TESTS=3Dy
> >   CONFIG_DEBUG_KERNEL=3Dy
> >   CONFIG_DEBUG_INFO=3Dy
> >   CONFIG_GCOV=3Dy
> >
> > This might be a neat way to motivate participants by showing #s going u=
p.
> > Note: I'm more interested in the # of covered functions than anything e=
lse.
> > The %s are nice to look at, but not that useful since we're only
> > compiling a small fraction of kernel code.
>
> Cool! In the end of the hackathon we will compare the numbers to see how
> much we were able to do in the event.
>
> >
> >> may ask people to add a special tag to their patches so you may batch
> >> review them all at a later time if you wish.
> >>
> >> Anyhow, we'd really appreciate having your opinion on this.
> >> Thanks!
> >>
> >> [1] - https://flusp.ime.usp.br/
> >> [2] - https://lkcamp.dev/
> >>
> >> --
> >> You received this message because you are subscribed to the Google Gro=
ups "KUnit Development" group.
> >> To unsubscribe from this group and stop receiving emails from it, send=
 an email to kunit-dev+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/m=
sgid/kunit-dev/83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f%40riseup.net.
