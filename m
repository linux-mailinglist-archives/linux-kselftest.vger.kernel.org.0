Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F03C8199334
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgCaKMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 06:12:32 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40535 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaKM3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 06:12:29 -0400
Received: by mail-qv1-f66.google.com with SMTP id bp12so6529857qvb.7
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Mar 2020 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PpCiJ4Lui2bH+hihck/1M29XXQzUL8SEpkRFBSZWS3E=;
        b=QmT8jZjqQT6Ge6TZl0USa3Psy6X5Ku3sOlIKNsBoYH0OclG1nmg/DFtLjm36rBgkmV
         nwuOew2VCLGe7YZN2x9mbT76TiuQbhh5z0Gjlcxp/cMfKFyE8gpup4sQTsMkHIrQfAI3
         OSloK3Btgk2aslJnpj1h6w/9mDil5s+WQY0BawQ+AN6iy8eekzY91DB7zWabqsE1P7YA
         ALssG3mSvg+ZeN+D9a6LUMaU1/+4DfXisMTiVPsOsMX2i3bLpvVxBAp6VzEKC+KqTCV9
         EG0tIV2IaKAMbezizQKQIcEHNpjnMTX79kady7FAEaHBJC62qTd/pf9gSICBbnGcu/Iu
         qjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PpCiJ4Lui2bH+hihck/1M29XXQzUL8SEpkRFBSZWS3E=;
        b=A3k0dAAxOYWL+jDsT87ZtjDYAO7nkCif11p2Alonb+7McCOBWRvX5GWbStfW7JgLbq
         Cjblc8XKM5c8Daowq4OoavkI09ZEF9QgRL6x5E3e49LLc7MMxUAVrNWj0wxdPU9/E8kQ
         cno2TMKfToEwybMV8so0cHlfZFRZuSPrUiAwIqeoQqQrKd2KZVCYD+Wh4eWKFEnXEJuI
         rNApw25dT+HhmE7XVGuKV6Z040ayahjak6X0YxQuM4yXTmGdxS3EwCBuGDtRbCdRMJls
         SBsRkc0BbYzlt3fjQQIWiJgls+AFmgcVuc8hKi/y3U404/grYMFAypvVygQ3MrbRZwr4
         m15g==
X-Gm-Message-State: ANhLgQ3D6Je6qo1jb+a05GAeHKnVQxteCCEEoGZSfNivbDfJooGTXpJ1
        VPqqwBzWFbAkrs5oi5WmXpMsaIiVmCYa2dboCH0zhg==
X-Google-Smtp-Source: ADFU+vv3TFu2Ux8dJ2SbfkrLryByw+hIEf6FkvZrzCLuK96WA/ar1PPlUm5TyNUi4z0RnbGT2pLQSkrVjYUzE439wIA=
X-Received: by 2002:ad4:49d1:: with SMTP id j17mr16149922qvy.80.1585649546681;
 Tue, 31 Mar 2020 03:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-4-trishalfonso@google.com> <CACT4Y+YHPfP3LP04=Zc4NgyhH8FMJ9m-eU_VPjmk5SmGWo_fTg@mail.gmail.com>
 <CAKFsvU+N=8=VmKVdNdf6os26z+vVD=vR=TL5GJtLQhR9FxOJUQ@mail.gmail.com>
 <CACT4Y+ZGcZhbkcAVVfKP1gUs7mg=LrSwBqhqpUozSX8Fof6ANA@mail.gmail.com>
 <CAKFsvUK-9QU7SfKLoL0w75VgSOneO8DWciHTDYMfU8aD98Unbw@mail.gmail.com>
 <CACT4Y+ZhraraMNC+uvD9O7h3wMQntiEu5zSmVd_UYEaqvdxTaA@mail.gmail.com> <CAKFsvUKaeHnHp0Y9BUiB=RRHLd0TNoEA99VaUZVyfrQy8ptTqA@mail.gmail.com>
In-Reply-To: <CAKFsvUKaeHnHp0Y9BUiB=RRHLd0TNoEA99VaUZVyfrQy8ptTqA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 31 Mar 2020 12:12:15 +0200
Message-ID: <CACT4Y+Y_zQPispr5FgW1VWr0Kpc3Z-6AR3TxEFJN1zKB72C2XQ@mail.gmail.com>
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

On Mon, Mar 30, 2020 at 8:57 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> > On Thu, Mar 26, 2020 at 4:15 PM Patricia Alfonso
> > <trishalfonso@google.com> wrote:
> > > > > > <kasan-dev@googlegroups.com> wrote:
> > > > > > >
> > > > > > > Transfer all previous tests for KASAN to KUnit so they can be=
 run
> > > > > > > more easily. Using kunit_tool, developers can run these tests=
 with their
> > > > > > > other KUnit tests and see "pass" or "fail" with the appropria=
te KASAN
> > > > > > > report instead of needing to parse each KASAN report to test =
KASAN
> > > > > > > functionalities. All KASAN reports are still printed to dmesg=
.
> > > > > > >
> > > > > > > Stack tests do not work in UML so those tests are protected i=
nside an
> > > > > > > "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if sta=
ck
> > > > > > > instrumentation is enabled.
> > > > > > >
> > > > > > > copy_user_test cannot be run in KUnit so there is a separate =
test file
> > > > > > > for those tests, which can be run as before as a module.
> > > > > >
> > > > > > Hi Patricia,
> > > > > >
> > > > > > FWIW I've got some conflicts applying this patch on latest linu=
x-next
> > > > > > next-20200324. There are some changes to the tests in mm tree I=
 think.
> > > > > >
> > > > > > Which tree will this go through? I would be nice to resolve the=
se
> > > > > > conflicts somehow, but I am not sure how. Maybe the kasan tests
> > > > > > changes are merged upstream next windows, and then rebase this?
> > > > > >
> > > > > > Also, how can I apply this for testing? I assume this is based =
on some
> > > > > > kunit branch? which one?
> > > > > >
> > > > > Hmm... okay, that sounds like a problem. I will have to look into=
 the
> > > > > conflicts. I'm not sure which tree this will go through upstream;=
 I
> > > > > expect someone will tell me which is best when the time comes. Th=
is is
> > > > > based on the kunit branch in the kunit documentation here:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kself=
test.git/log/?h=3Dkunit
> > > >
> > > > I've checked out:
> > > >
> > > > commit 0476e69f39377192d638c459d11400c6e9a6ffb0 (HEAD, kselftest/ku=
nit)
> > > > Date:   Mon Mar 23 12:04:59 2020 -0700
> > > >
> > > > But the build still fails for me:
> > > >
> > > > mm/kasan/report.c: In function =E2=80=98kasan_update_kunit_status=
=E2=80=99:
> > > > mm/kasan/report.c:466:6: error: implicit declaration of function
> > > > =E2=80=98kunit_find_named_resource=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declar]
> > > >   466 |  if (kunit_find_named_resource(cur_test, "kasan_data")) {
> > > >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > mm/kasan/report.c:467:12: warning: assignment to =E2=80=98struct
> > > > kunit_resource *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer =
from integer without a cas]
> > > >   467 |   resource =3D kunit_find_named_resource(cur_test, "kasan_d=
ata");
> > > >       |            ^
> > > > mm/kasan/report.c:468:24: error: =E2=80=98struct kunit_resource=E2=
=80=99 has no member
> > > > named =E2=80=98data=E2=80=99
> > > >   468 |   kasan_data =3D resource->data;
> > > >       |                        ^~
> > > >
> > > > What am I doing wrong?
> > >
> > > This patchset relies on another RFC patchset from Alan:
> > > https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-e=
mail-alan.maguire@oracle.com/T/#t
> > >
> > > I thought I linked it in the commit message but it may only be in the
> > > commit message for part 2/3. It should work with Alan's patchset, but
> > > let me know if you have any trouble.
> >
> > Please push your state of code to some git repository, so that I can
> > pull it. Github or gerrit or whatever.
>
> Here's a Gerrit link: https://kunit-review.googlesource.com/c/linux/+/351=
3

This worked well for me! Thanks!

The first thing I hit is that my default config has panic_on_warn=3D1
set, which has the same effect as the "multi shot" setting.
I think we need to save/restore panic_on_warn the same way we do for
multi shot (+rename kasan_multi_shot_init/exit to something more
generic).

After removing panic_on_warn=3D1 I was able to run the tests
successfully on x86_64.

And after injecting some simple bugs, I got expected test failures:

[    3.191793] # kasan_memchr: EXPECTATION FAILED at lib/test_kasan.c:509
[    3.191793] Expected kasan_data->report_expected =3D=3D
kasan_data->report_found, but
[    3.191793] kasan_data->report_expected =3D=3D 1
[    3.191793] kasan_data->report_found =3D=3D 0
[    3.191852] not ok 30 - kasan_memchr
[    3.195588] # kasan_memcmp: EXPECTATION FAILED at lib/test_kasan.c:523
[    3.195588] Expected kasan_data->report_expected =3D=3D
kasan_data->report_found, but
[    3.195588] kasan_data->report_expected =3D=3D 1
[    3.195588] kasan_data->report_found =3D=3D 0
[    3.195659] not ok 31 - kasan_memcmp


All of these should be static:

struct kunit_resource resource;
struct kunit_kasan_expectation fail_data;
bool multishot;
int kasan_multi_shot_init(struct kunit *test)
void kasan_multi_shot_exit(struct kunit *test)

With the comments in the previous emails, this looks good to me.
