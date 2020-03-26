Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93273193B8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 10:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCZJMr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 05:12:47 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44226 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgCZJMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 05:12:45 -0400
Received: by mail-qv1-f66.google.com with SMTP id ef12so488429qvb.11
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Mar 2020 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+0dBf2eFnAW/4J/Q/Labg8qpjK7rs2ogArALHG5odA=;
        b=Gv9m6hr2zx8V43ouYC90W+WpqUQaUbvBX4B0T54UwF4vWD5Hbht+vOnuVnWuwKi5TK
         Yk7ThJBYMcTJpxL8hro5KlxbWqDL/YJQBGYTnjKzg2vA5xItaveOcbnM/pi6uZkdEfgf
         xife3Zm58h4poDbeaZsqTrAiMLY7BpeYmGmCcWDBn+4g0plB8jgYiERrh6xHnQPj2qUP
         F5dITJYCQcKVK1/KXPb75RHuUYCbyQJV3sNjG8nbNZ4QlEfh1bK2AfxC1epA7sYBed1L
         UJktfwEgMAVRdT28ntII8Vqd/cS/3tbNFQe7aGrbC78yfrp+3tDink4xwIcuEzFYTUPk
         Aa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+0dBf2eFnAW/4J/Q/Labg8qpjK7rs2ogArALHG5odA=;
        b=AoWXUZ7efE7QzOMhp06XdcwIe/FlkvCQtmwaljba1ZYH12mryqR1ZrHjC8ggmPMCEl
         zBVmGj9wja12a9GotA08H1GeOMtwLtIafIgjWQyuAIJKtZ3qE9qvXXXqagl/ZiL8p0Ba
         0UzrqqG9ZtxORkgr9GCrf/mRQIbK0o32UMcWdX0fV07ur8YTU8LbUxi+E05S7IqRVMnS
         Qg48bt/kM6B7qqE1RGVExBjxHpR46RkDdXVlLQVQeJESY2nfV96QCmud+S1qwrrRARqH
         u03e7eKn+XQN1vhJ5m1BM2q4vryqDcIhleIJ+g5cmglPe5iFBWWPRQUpjNAt87KDRTCA
         wwKw==
X-Gm-Message-State: ANhLgQ2Ss2cRFqiZT/eBMfn2x2YOMJW737Q+Bevkza4oHNvE4YCMDxGY
        4JJdL4NNN3SUGs2ABAo2PQI2fAcwhUmM45wgsSgBQg==
X-Google-Smtp-Source: ADFU+vuHXXvVpboLvAg8eqmR74HRV0d1GIZyViCdIz3vmQ2AalMzFQ/ny6JlNYpH3XXobXfDtVEat/xCcVjqU3YGOE0=
X-Received: by 2002:a0c:a8e2:: with SMTP id h34mr6828428qvc.22.1585213964095;
 Thu, 26 Mar 2020 02:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-4-trishalfonso@google.com> <CACT4Y+YHPfP3LP04=Zc4NgyhH8FMJ9m-eU_VPjmk5SmGWo_fTg@mail.gmail.com>
 <CAKFsvU+N=8=VmKVdNdf6os26z+vVD=vR=TL5GJtLQhR9FxOJUQ@mail.gmail.com>
In-Reply-To: <CAKFsvU+N=8=VmKVdNdf6os26z+vVD=vR=TL5GJtLQhR9FxOJUQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 26 Mar 2020 10:12:33 +0100
Message-ID: <CACT4Y+ZGcZhbkcAVVfKP1gUs7mg=LrSwBqhqpUozSX8Fof6ANA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] KASAN: Port KASAN Tests to KUnit
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 24, 2020 at 4:05 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> On Tue, Mar 24, 2020 at 4:25 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Mar 19, 2020 at 5:42 PM 'Patricia Alfonso' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > >
> > > Transfer all previous tests for KASAN to KUnit so they can be run
> > > more easily. Using kunit_tool, developers can run these tests with th=
eir
> > > other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> > > report instead of needing to parse each KASAN report to test KASAN
> > > functionalities. All KASAN reports are still printed to dmesg.
> > >
> > > Stack tests do not work in UML so those tests are protected inside an
> > > "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if stack
> > > instrumentation is enabled.
> > >
> > > copy_user_test cannot be run in KUnit so there is a separate test fil=
e
> > > for those tests, which can be run as before as a module.
> >
> > Hi Patricia,
> >
> > FWIW I've got some conflicts applying this patch on latest linux-next
> > next-20200324. There are some changes to the tests in mm tree I think.
> >
> > Which tree will this go through? I would be nice to resolve these
> > conflicts somehow, but I am not sure how. Maybe the kasan tests
> > changes are merged upstream next windows, and then rebase this?
> >
> > Also, how can I apply this for testing? I assume this is based on some
> > kunit branch? which one?
> >
> Hmm... okay, that sounds like a problem. I will have to look into the
> conflicts. I'm not sure which tree this will go through upstream; I
> expect someone will tell me which is best when the time comes. This is
> based on the kunit branch in the kunit documentation here:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git=
/log/?h=3Dkunit

I've checked out:

commit 0476e69f39377192d638c459d11400c6e9a6ffb0 (HEAD, kselftest/kunit)
Date:   Mon Mar 23 12:04:59 2020 -0700

But the build still fails for me:

mm/kasan/report.c: In function =E2=80=98kasan_update_kunit_status=E2=80=99:
mm/kasan/report.c:466:6: error: implicit declaration of function
=E2=80=98kunit_find_named_resource=E2=80=99 [-Werror=3Dimplicit-function-de=
clar]
  466 |  if (kunit_find_named_resource(cur_test, "kasan_data")) {
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~
mm/kasan/report.c:467:12: warning: assignment to =E2=80=98struct
kunit_resource *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cas]
  467 |   resource =3D kunit_find_named_resource(cur_test, "kasan_data");
      |            ^
mm/kasan/report.c:468:24: error: =E2=80=98struct kunit_resource=E2=80=99 ha=
s no member
named =E2=80=98data=E2=80=99
  468 |   kasan_data =3D resource->data;
      |                        ^~

What am I doing wrong?
