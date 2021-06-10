Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F993A2ACF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJLzf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 07:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhFJLze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 07:55:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C79AC061760
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 04:53:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so6354094wmd.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Eq0t+BbPZXalrNecB2UGQAWr22SKkUMPp3zNFgboMxg=;
        b=SWP2nzuU3Iwl7GwTXjT7Eg6/XQ/xx2HwKHxn+zwHLLlnJT/t9Y4/2qqqZrwhdXIuMh
         GLPED/Zx4uDmqctc7nJYo/tAUReUz0LTfVwN39iB89rtwdMUDilAs5Oi+cSb2kjAIEAD
         j4j8hTq2OUNW1OfKUGbQImx7H+YjrJYMaU16NlTfsfO2BRADh7JcCVhvNkmT5WbgAywr
         Vbvl4gDMFUAP+G51prn886Oq0NVGMR5Rm/Qju4bY0NYlMFsUdHM9Bh5w5BvKmG2J5o6t
         mUcsoREqe6YyeB5PXrfSXIPHOnGGflTzFI3/9O/hDopg8H1ZQ5f4rUde3vjYBbJe9SQ0
         wR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Eq0t+BbPZXalrNecB2UGQAWr22SKkUMPp3zNFgboMxg=;
        b=nD9xPGR3pEWXsxNEFTBCDnjVlUrU40u6cI3uDsK9dP8oUnstWatXdRG6I0xCjg+NYt
         qu/5oSaywh8tnO/PzUinLEBMjfde+Jrffv7AzeLAEcvbj+l4w9f/KVmvOKgyjy9bkwzd
         Xtw7tI25KFghT0ygLwfyhwlEF9Z7TYsJGNc7GZHJ3z7QNPlEANk1+UDfvwxRwahaDmrR
         PJlpFLP1rcF1YCJPJ/CPPdgf/kvvc6bkImlKcYKBdic4637sGku7eEL+Y3OF9aveDDsy
         D3iOnr0H1lydtesHirlqSvdW9dGVs5tNmBIOofUr0UrrUNdcvylKHEvwdDroB5HkBcWj
         L9Yw==
X-Gm-Message-State: AOAM532Yax4EjcnhxI5xTtZWxSFnmf1qX7YqlC1e/mo9OuqlySJzqcfF
        wsw+tMs+0iufxdwyh5usvznZIelZ8gIDDplkToUj2OzHx34w2mJH
X-Google-Smtp-Source: ABdhPJy4j69xxBPqsrbnXCVu7/eWO0Do2HxE/drcDQIi6n9DWcqbRh4Y9PbOF3guYx6kj4PpjOkPF7aXpab6wN1N98c=
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr14839106wmi.151.1623326006488;
 Thu, 10 Jun 2021 04:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210609233730.164082-1-andrealmeid@collabora.com> <YMHX1mKuqoRCiHAF@smile.fi.intel.com>
In-Reply-To: <YMHX1mKuqoRCiHAF@smile.fi.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 10 Jun 2021 19:53:14 +0800
Message-ID: <CABVgOS=5xkYKD18YfU++u8snpUnL2s=V6bK1e4qc_jTmAuazkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] lib: Convert UUID runtime test to KUnit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
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

On Thu, Jun 10, 2021 at 5:14 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 09, 2021 at 08:37:29PM -0300, Andr=C3=A9 Almeida wrote:
> > Hi,
> >
> > This patch converts existing UUID runtime test to use KUnit framework.
> >
> > Below, there's a comparison between the old output format and the new
> > one. Keep in mind that even if KUnit seems very verbose, this is the
> > corner case where _every_ test has failed.
> >
> > * This is how the current output looks like in success:
> >
> >   test_uuid: all 18 tests passed
> >
> > * And when it fails:
> >
> >   test_uuid: conversion test #1 failed on LE data: 'c33f4995-3701-450e-=
9fbf-206a2e98e576'
> >   test_uuid: cmp test #2 failed on LE data: 'c33f4995-3701-450e-9fbf-20=
6a2e98e576'
> >   test_uuid: cmp test #2 actual data: 'c33f4995-3701-450e-9fbf-206a2e98=
e576'
> >   test_uuid: conversion test #3 failed on BE data: 'c33f4995-3701-450e-=
9fbf-206a2e98e576'
> >   test_uuid: cmp test #4 failed on BE data: 'c33f4995-3701-450e-9fbf-20=
6a2e98e576'
> >   test_uuid: cmp test #4 actual data: 'c33f4995-3701-450e-9fbf-206a2e98=
e576'
> >   test_uuid: conversion test #5 failed on LE data: '64b4371c-77c1-48f9-=
8221-29f054fc023b'
> >   test_uuid: cmp test #6 failed on LE data: '64b4371c-77c1-48f9-8221-29=
f054fc023b'
> >   test_uuid: cmp test #6 actual data: '64b4371c-77c1-48f9-8221-29f054fc=
023b'
> >   test_uuid: conversion test #7 failed on BE data: '64b4371c-77c1-48f9-=
8221-29f054fc023b'
> >   test_uuid: cmp test #8 failed on BE data: '64b4371c-77c1-48f9-8221-29=
f054fc023b'
> >   test_uuid: cmp test #8 actual data: '64b4371c-77c1-48f9-8221-29f054fc=
023b'
> >   test_uuid: conversion test #9 failed on LE data: '0cb4ddff-a545-4401-=
9d06-688af53e7f84'
> >   test_uuid: cmp test #10 failed on LE data: '0cb4ddff-a545-4401-9d06-6=
88af53e7f84'
> >   test_uuid: cmp test #10 actual data: '0cb4ddff-a545-4401-9d06-688af53=
e7f84'
> >   test_uuid: conversion test #11 failed on BE data: '0cb4ddff-a545-4401=
-9d06-688af53e7f84'
> >   test_uuid: cmp test #12 failed on BE data: '0cb4ddff-a545-4401-9d06-6=
88af53e7f84'
> >   test_uuid: cmp test #12 actual data: '0cb4ddff-a545-4401-9d06-688af53=
e7f84'
> >   test_uuid: negative test #13 passed on wrong LE data: 'c33f4995-3701-=
450e-9fbf206a2e98e576 '
> >   test_uuid: negative test #14 passed on wrong BE data: 'c33f4995-3701-=
450e-9fbf206a2e98e576 '
> >   test_uuid: negative test #15 passed on wrong LE data: '64b4371c-77c1-=
48f9-8221-29f054XX023b'
> >   test_uuid: negative test #16 passed on wrong BE data: '64b4371c-77c1-=
48f9-8221-29f054XX023b'
> >   test_uuid: negative test #17 passed on wrong LE data: '0cb4ddff-a545-=
4401-9d06-688af53e'
> >   test_uuid: negative test #18 passed on wrong BE data: '0cb4ddff-a545-=
4401-9d06-688af53e'
> >   test_uuid: failed 18 out of 18 tests
> >
> >
> > * Now, here's how it looks like with KUnit:
> >
> >   =3D=3D=3D=3D=3D=3D=3D=3D [PASSED] uuid =3D=3D=3D=3D=3D=3D=3D=3D
> >   [PASSED] uuid_correct_be
> >   [PASSED] uuid_correct_le
> >   [PASSED] uuid_wrong_be
> >   [PASSED] uuid_wrong_le
> >
> > * And if every test fail with KUnit:
> >
> >   =3D=3D=3D=3D=3D=3D=3D=3D [FAILED] uuid =3D=3D=3D=3D=3D=3D=3D=3D
> >   [FAILED] uuid_correct_be
> >       # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
> >       Expected uuid_parse(data->uuid, &be) =3D=3D 1, but
> >           uuid_parse(data->uuid, &be) =3D=3D 0
> >
> >   failed to parse 'c33f4995-3701-450e-9fbf-206a2e98e576'
> >       # uuid_correct_be: not ok 1 - c33f4995-3701-450e-9fbf-206a2e98e57=
6
> >       # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
> >       Expected uuid_parse(data->uuid, &be) =3D=3D 1, but
> >           uuid_parse(data->uuid, &be) =3D=3D 0
> >
> >   failed to parse '64b4371c-77c1-48f9-8221-29f054fc023b'
> >       # uuid_correct_be: not ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023=
b
> >       # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
> >       Expected uuid_parse(data->uuid, &be) =3D=3D 1, but
> >           uuid_parse(data->uuid, &be) =3D=3D 0
> >
> >   failed to parse '0cb4ddff-a545-4401-9d06-688af53e7f84'
> >       # uuid_correct_be: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f8=
4
> >       not ok 1 - uuid_correct_be
> >
> >   [FAILED] uuid_correct_le
> >       # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
> >       Expected guid_parse(data->uuid, &le) =3D=3D 1, but
> >           guid_parse(data->uuid, &le) =3D=3D 0
> >
> >   failed to parse 'c33f4995-3701-450e-9fbf-206a2e98e576'
> >       # uuid_correct_le: not ok 1 - c33f4995-3701-450e-9fbf-206a2e98e57=
6
> >       # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
> >       Expected guid_parse(data->uuid, &le) =3D=3D 1, but
> >           guid_parse(data->uuid, &le) =3D=3D 0
> >
> >   failed to parse '64b4371c-77c1-48f9-8221-29f054fc023b'
> >       # uuid_correct_le: not ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023=
b
> >       # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
> >       Expected guid_parse(data->uuid, &le) =3D=3D 1, but
> >           guid_parse(data->uuid, &le) =3D=3D 0
> >
> >   failed to parse '0cb4ddff-a545-4401-9d06-688af53e7f84'
> >       # uuid_correct_le: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f8=
4
> >       not ok 2 - uuid_correct_le
> >
> >   [FAILED] uuid_wrong_be
> >       # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
> >       Expected uuid_parse(*data, &be) =3D=3D 0, but
> >           uuid_parse(*data, &be) =3D=3D -22
> >
> >   parsing of 'c33f4995-3701-450e-9fbf206a2e98e576 ' should've failed
> >       # uuid_wrong_be: not ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
> >       # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
> >       Expected uuid_parse(*data, &be) =3D=3D 0, but
> >           uuid_parse(*data, &be) =3D=3D -22
> >
> >   parsing of '64b4371c-77c1-48f9-8221-29f054XX023b' should've failed
> >       # uuid_wrong_be: not ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
> >       # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
> >       Expected uuid_parse(*data, &be) =3D=3D 0, but
> >           uuid_parse(*data, &be) =3D=3D -22
> >
> >   parsing of '0cb4ddff-a545-4401-9d06-688af53e' should've failed
> >       # uuid_wrong_be: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
> >       not ok 3 - uuid_wrong_be
> >
> >   [FAILED] uuid_wrong_le
> >       # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
> >       Expected guid_parse(*data, &le) =3D=3D 0, but
> >           guid_parse(*data, &le) =3D=3D -22
> >
> >   parsing of 'c33f4995-3701-450e-9fbf206a2e98e576 ' should've failed
> >       # uuid_wrong_le: not ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
> >       # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
> >       Expected guid_parse(*data, &le) =3D=3D 0, but
> >           guid_parse(*data, &le) =3D=3D -22
> >
> >   parsing of '64b4371c-77c1-48f9-8221-29f054XX023b' should've failed
> >       # uuid_wrong_le: not ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
> >       # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
> >       Expected guid_parse(*data, &le) =3D=3D 0, but
> >           guid_parse(*data, &le) =3D=3D -22
> >
> >   parsing of '0cb4ddff-a545-4401-9d06-688af53e' should've failed
> >       # uuid_wrong_le: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
> >       not ok 4 - uuid_wrong_le

Note that this output is from the kunit_tool script, which parses the
test output.
It does include a summary line:
[04:41:01] Testing complete. 4 tests run. 0 failed. 0 crashed.

Note that this does only count the number of "tests" run --- the
individual UUIDs are parameters to the same test, so aren't counted
independently by the wrapper at the moment.

That being said, the raw output looks like this (all tests passed):
TAP version 14
1..1
   # Subtest: uuid
   1..4
   # uuid_correct_be: ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
   # uuid_correct_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
   # uuid_correct_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
   ok 1 - uuid_correct_be
   # uuid_correct_le: ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
   # uuid_correct_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
   # uuid_correct_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
   ok 2 - uuid_correct_le
   # uuid_wrong_be: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
   # uuid_wrong_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
   # uuid_wrong_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
   ok 3 - uuid_wrong_be
   # uuid_wrong_le: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
   # uuid_wrong_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
   # uuid_wrong_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
   ok 4 - uuid_wrong_le
ok 1 - uuid

A test which failed could look like this:
    # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
   Expected guid_parse(data->uuid, &le) =3D=3D 0, but
       guid_parse(data->uuid, &le) =3D=3D -22

failed to parse 'c33f499x5-3701-450e-9fbf-206a2e98e576'
   # uuid_correct_le: not ok 1 - c33f499x5-3701-450e-9fbf-206a2e98e576
   # uuid_correct_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
   # uuid_correct_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
   not ok 2 - uuid_correct_le

>
> Thanks!
>
> It's not your fault but I think we need to defer this until KUnit gains s=
upport
> of the run statistics. My guts telling me if we allow more and more conve=
rsions
> like this the point will vanish and nobody will care.

Did the test statistics patch we sent out before meet your expectations?
https://patchwork.kernel.org/project/linux-kselftest/patch/20201211072319.5=
33803-1-davidgow@google.com/

If so, we can tidy it up and try to push it through straight away, we
were just waiting for a review from someone who wanted the feature.


> I like the code, but I can give my tag after KUnit prints some kind of th=
is:
>
>  * This is how the current output looks like in success:
>
>    test_uuid: all 18 tests passed
>
>  * And when it fails:
>
>    test_uuid: failed 18 out of 18 tests
>

There are some small restrictions on the exact format KUnit can use
for this if we want to continue to match the (K)TAP specification
which is being adopted by kselftest. The patch linked above should
give something formatted like:

# test_uuid: (0 / 4) tests failed (0 / 12 test parameters)

Would that work for you?

Cheers,
-- David
