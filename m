Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E03BE348
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 08:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhGGGv6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGGv6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 02:51:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEEC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jul 2021 23:49:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v3so1677591ioq.9
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jul 2021 23:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a7uL/oPB5i1I9w73FKJk3bpkvp5li9awT1HJMZPU03I=;
        b=vmD7bYT0oe73Px04GkCXnIyNIMn0dhgylqiIkNb3qhA4li9/SrsbPFq/0G3y7gvG5Q
         cJmD8GRMe0ptE+ikXJtA226NywNPosf9s+a3BmLWBBVlPqDYY2toYdNmYZHDP+BAMznA
         +j8d0cGZD0wxYaqxVC3qKC3l4QzVrfp5JG0GV1oDIssj+FjHql1wpaFPDbdHtDEhjNi0
         5pWdAuPm7ej6JQHrHwDPjJ3QRJOJDbXExDOZ8z2uwya0g3gyRXfsn1h1KntxT6w9F9In
         v0gMEsPewL8ZoHeYNzyM8yUtknEyJStXQEnmGag243tCCSV2MOzYwvsR7QRXfKVSmfaB
         HSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a7uL/oPB5i1I9w73FKJk3bpkvp5li9awT1HJMZPU03I=;
        b=jf/0o3GfBNG+32FGUhjVL/Pj2hRLD6BgauxPjtc5tOkDff2jGdc54KPKTj/BEaYLvn
         Uu4ItlGPYjjNPrE/uqaJU0UNdn2xsSpwNYj3WMBXLgiIELhzRKkFUa9rptRkHK/NEGMc
         7oZn/qkLLEo+MLoagc4wZWUzyHL5qOPHJhnq+qJbRcXukU3OGjRTlLGgGNKtijDBuApH
         PcbxlkezfrMpy9JuZC1Anv27dRnenSWNwZ+suZ3TkbIw2mMuildwjyZjmIBk2yNLa9sZ
         pg8byqpkArMUVrL4hVFCWB42Nxn6vu1irnJfxF2EQJ7XAM4UdxbOzDMOmYDF3zy2ceXE
         xemQ==
X-Gm-Message-State: AOAM533p78efySOyQokCVVBildMJNEbmqzOspbLGFYygBj5bE3B0Ptxq
        RwkcFRP7q7TN3A3VMSqIznzyxsCbGvmayc1AfyoxrQ==
X-Google-Smtp-Source: ABdhPJwD87oxc0ENnJs8s+5fKQASkfDEvEaKfTIeeIz+p2xjqv13d9bXWVcuDURWEiy+bcjb0ffqW3cM7ZmTnopR8vo=
X-Received: by 2002:a02:2b27:: with SMTP id h39mr20704167jaa.62.1625640553951;
 Tue, 06 Jul 2021 23:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
In-Reply-To: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 6 Jul 2021 23:48:44 -0700
Message-ID: <CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com>
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

On Mon, Jul 5, 2021 at 1:41 PM Andr=C3=A9 Almeida <andrealmeid@riseup.net> =
wrote:
>
> Hello,
>
> We belong to two student groups, FLUSP [1] and LKCAMP [2], both of which
> are focused on sharing kernel and free software development knowledge
> and experience with fellow free software developers and newcomers.
>
> As part of our efforts, we'll be organizing a KUnit hackathon in the
> next Saturday (July 10), where we intend to help newcomers convert
> existing runtime tests (the ones found at lib/) to KUnit and maybe
> create new ones. Depending on the number of attendees, a high volume of
> patches may be sent throughout the day. We will do our best to review
> all patches before they go to the kernel mailing lists hoping to avoid
> wasting your time with minor patching issues.

That sounds great!

>
> So we wanted to let you know of all this beforehand and give you the
> time to send any suggestions or comments on all this. For instance, we

Some random, unorganized thoughts:
* I (as a kernel newbie) found the ownership of tests under lib/ to be
a bit unclear.

* Make sure to base on 5.14, there's some new features that could be of use
  * QEMU support in kunit.py: it's no longer as big of a deal if we
can't get tests running under UML. Brendan's made it fairly easy to
run tests in an x86 VM.
  * Skipped tests support: can now mark a test skipped. Some of the
lib/ tests could benefit, e.g. test_hash.c
  * another lib/ test conversion just landed in 5.14, [1], along with
kunit_kcalloc/kunit_malloc_array() helpers
  * Documentation/dev-tools/kunit/running_tips.rst - has instructions
for how to generate code coverage reports using UML/kunit.py
    * This seems like it could be useful... [2]

* I feel that the hackathon will surface a number of feature requests
for KUnit. Some patches might be blocked on these features (like your
uuid patch).
  * Might be good to track these as they come up and note which
patches are blocked.

* Should we make a decision beforehand wrt renaming test files and
kconfig options to match the style guide? In the most recent
conversion [1], I left them as-is. The answer depends on the test
owner, but we should probably be consistent with what we do in the
v1's at least.

* I assume test modules used in selftests (test_bitmap, test_printf,
etc.) should remain untouched for now ?
  * KUnit does *not* return a non-zero exit code when you modprobe the
test, as the userspace part of those tests assumes.
  * We could write a wrapper like kselftest/module.sh, but for KUnit
test modules, but this extra in-flight patch would become a dependency
for maybe multiple other conversions.
  * I'd like it if we had ^ eventually, but I don't know how others
feel about that.

* I had some small patches for converting test_min_heap.c and
test_sort.c that I should get around to sending out.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Debd09577be6c15ee2d343cf60e5bb819946a5ee8
[2] I currently see
  Overall coverage rate:
  lines......: 16.4% (20034 of 122481 lines)
  functions..: 18.1% (2032 of 11205 functions)
with the following kunitconfig
  CONFIG_KUNIT=3Dy
  CONFIG_KUNIT_ALL_TESTS=3Dy
  CONFIG_DEBUG_KERNEL=3Dy
  CONFIG_DEBUG_INFO=3Dy
  CONFIG_GCOV=3Dy

This might be a neat way to motivate participants by showing #s going up.
Note: I'm more interested in the # of covered functions than anything else.
The %s are nice to look at, but not that useful since we're only
compiling a small fraction of kernel code.

> may ask people to add a special tag to their patches so you may batch
> review them all at a later time if you wish.
>
> Anyhow, we'd really appreciate having your opinion on this.
> Thanks!
>
> [1] - https://flusp.ime.usp.br/
> [2] - https://lkcamp.dev/
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f%40riseup.net.
