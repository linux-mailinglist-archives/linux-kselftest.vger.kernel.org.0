Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4623A2BC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJMld (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJMlc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 08:41:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD58C061574;
        Thu, 10 Jun 2021 05:39:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g4so3607662pjk.0;
        Thu, 10 Jun 2021 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uE9zevDQxYaPIwjXbI4q8ct+lsgcgQZE9rB/G5VDkeY=;
        b=tfuH4+B0VFYjWqiSQLaN//4EBznKsfARI33Ch7bU9AhJOO00FOQ/nwwCpv3oDUHKmn
         xlymOjdXAWB+dE074vCopkAVBGypU9xAnqG7cQQWcq/0Ku8wvNp5shy9pARAQGrjEs5h
         terbxPsfMgP8003YEWFWdVskSlFfYwkcWWZkDKodEtjotkQjbEhSrNaX6cI1AXBau0jJ
         jm5mZYdykZiBtliCuaMsp8cD7dZeq2i44A+gFpWeYBPGxuW+7boHiMm2YYLeD6rfgY1P
         IokS3SXa6csaThGR/iK/XQVhZhqwlYAv7mzObfB7ivmEKWyP5ClYn2p4kys/vH9kpaeP
         fNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uE9zevDQxYaPIwjXbI4q8ct+lsgcgQZE9rB/G5VDkeY=;
        b=aRzEgOmxsvbnpitOtMvQUpSLQ2p1/ioH2EO1vPCXh4qJ323npb5b9+y23hzqt+eUJS
         4coa/u9TxIbGCaCsJsHbS2s8a99LQnbx+bbdAIhHoNemdzPx2rk4OOHkvYs3ZC5lKNwO
         eY7VM3HPRo8ZnIYgKurzvAyvC4jRf7lgtyiXLnYbZcfDu1H0vfkAli+ghlgn+IIQojk/
         Fu3KmenCjfimIuQ++Kcx+fePGBTcVOCESMRL/i3s/KoiNE56NNEbBJW/sfVs4JzciV2v
         Mm0vX1ydjjF81s85pGnOLMUy971pMAvjVWo9uKAcv3hKOYE226XqmqYcd5RRQK0G82jB
         U0Vg==
X-Gm-Message-State: AOAM531GWbKdIgouJUE2ZvcHv6jNmnsWHDwWivfgfEskoxYy0NWZqPUQ
        tc6O/tofXTfS9MhVmXUVjYUmysTvi1aEjoWd0iJ3tZ2NOqk=
X-Google-Smtp-Source: ABdhPJy5MSsAX/mTKbGgXWIYp1rrkDUDDWHFKkv3ve1Af0GBq+dfT0dZIVMUV3px1MkLOYRk5gR/Vnn5pf0lZbUYbis=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr3236175pja.181.1623328762809;
 Thu, 10 Jun 2021 05:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210609233730.164082-1-andrealmeid@collabora.com>
 <YMHX1mKuqoRCiHAF@smile.fi.intel.com> <CABVgOS=5xkYKD18YfU++u8snpUnL2s=V6bK1e4qc_jTmAuazkw@mail.gmail.com>
In-Reply-To: <CABVgOS=5xkYKD18YfU++u8snpUnL2s=V6bK1e4qc_jTmAuazkw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 15:39:06 +0300
Message-ID: <CAHp75VdRaztt6gPUuznCa_5yBRNF3WFYq78Tq-ozh=DBA5-FEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] lib: Convert UUID runtime test to KUnit
To:     David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        Daniel Latypov <dlatypov@google.com>, tales.aparecida@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 10, 2021 at 2:54 PM David Gow <davidgow@google.com> wrote:
> On Thu, Jun 10, 2021 at 5:14 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jun 09, 2021 at 08:37:29PM -0300, Andr=C3=A9 Almeida wrote:

...

> Note that this output is from the kunit_tool script, which parses the
> test output.
> It does include a summary line:
> [04:41:01] Testing complete. 4 tests run. 0 failed. 0 crashed.

> Note that this does only count the number of "tests" run --- the
> individual UUIDs are parameters to the same test, so aren't counted
> independently by the wrapper at the moment.
>
> That being said, the raw output looks like this (all tests passed):
> TAP version 14
> 1..1
>    # Subtest: uuid
>    1..4
>    # uuid_correct_be: ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
>    # uuid_correct_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>    # uuid_correct_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>    ok 1 - uuid_correct_be
>    # uuid_correct_le: ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
>    # uuid_correct_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>    # uuid_correct_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>    ok 2 - uuid_correct_le
>    # uuid_wrong_be: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
>    # uuid_wrong_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
>    # uuid_wrong_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
>    ok 3 - uuid_wrong_be
>    # uuid_wrong_le: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
>    # uuid_wrong_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
>    # uuid_wrong_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
>    ok 4 - uuid_wrong_le
> ok 1 - uuid
>
> A test which failed could look like this:
>     # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
>    Expected guid_parse(data->uuid, &le) =3D=3D 0, but
>        guid_parse(data->uuid, &le) =3D=3D -22
>
> failed to parse 'c33f499x5-3701-450e-9fbf-206a2e98e576'
>    # uuid_correct_le: not ok 1 - c33f499x5-3701-450e-9fbf-206a2e98e576
>    # uuid_correct_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>    # uuid_correct_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>    not ok 2 - uuid_correct_le
>
> >
> > Thanks!
> >
> > It's not your fault but I think we need to defer this until KUnit gains=
 support
> > of the run statistics. My guts telling me if we allow more and more con=
versions
> > like this the point will vanish and nobody will care.
>
> Did the test statistics patch we sent out before meet your expectations?
> https://patchwork.kernel.org/project/linux-kselftest/patch/20201211072319=
.533803-1-davidgow@google.com/

Let me look at it at some point.

> If so, we can tidy it up and try to push it through straight away, we
> were just waiting for a review from someone who wanted the feature.
>
>
> > I like the code, but I can give my tag after KUnit prints some kind of =
this:
> >
> >  * This is how the current output looks like in success:
> >
> >    test_uuid: all 18 tests passed
> >
> >  * And when it fails:
> >
> >    test_uuid: failed 18 out of 18 tests
> >
>
> There are some small restrictions on the exact format KUnit can use
> for this if we want to continue to match the (K)TAP specification
> which is being adopted by kselftest. The patch linked above should
> give something formatted like:
>
> # test_uuid: (0 / 4) tests failed (0 / 12 test parameters)
>
> Would that work for you?

Can you decode it for me, please?

(Assuming that the above question arisen, perhaps some rephrasing is
needed. The idea that user should have clear understanding on how many
test cases were run and how many of them successfully finished or
failed. According to this thread I have to see the cumulative number
of 18 (either as one number or sum over test cases or how you call
them, I see 4 here).



--=20
With Best Regards,
Andy Shevchenko
