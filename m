Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED51942CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 16:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgCZPP2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 11:15:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36803 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgCZPP2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 11:15:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so8272400wrs.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Mar 2020 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h4U844jPltBTNlYGJyCJI7cYyBDxAP1w1W8i3jCDF+o=;
        b=JS+pLv9fDBxaQfEl9AuZOvc6smAsjUyx44iUyuGoFgU/xI8ifgOiBmPf7q+EwOTzsM
         EpXbcerCl5zWUljBtjDrQNU+ZkQAqFlRHQHz/Sgm25kEXUNlFEgVkhizg/8hxJzJdDAS
         PYQbRcOI/8QO2YFg5KUYQWS6bgtNNhEfLsNFoYlSDT/OZl1Fx0zqAvWcc1Oz+/2RdmCh
         tbr6FAb7vhDHxKCfJZbU9sdwiG2jW86S1ndXd03uQjedW5jf3J76rCtzEGNUVFf9lyrB
         C5yF1EG2fkF7H4k4v/BRBp9E0hbz/YxHTs14FPCO/ijpTZfmiGnA+hkp0L+Dj3YF5Fhz
         nzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h4U844jPltBTNlYGJyCJI7cYyBDxAP1w1W8i3jCDF+o=;
        b=uQiWXMcg/t7PzuZdYsRfDq2KnOfvrI/Ao44AdB05lRYz18LqsRA+SuPzdzjHAc98z1
         abRNQBwrcHaIc+Jqk4Y2Sifj3nBrlaLm8DnHNPVGhbrU8t7Veo4PR3KVcHUsk7nSgyCL
         4NDM4hHkEubbH6fEkYDOPz9FxU+ivwLwEPSvapUI6Zj6qTJAUo/Dq3OctzO4E0MW4R2+
         c5bSvQTaTMHza2JrNi7TqvSj7O19yJ7MyPw/m9La567Nf7xsVj+I4EHMaKxq3vbGdS53
         mTvADZWw4Dvba9F9sqAml9lkbYAR/yI4MAyZyDh+TmzRdBhm6clwaXRouyvAsB7uWSQi
         1GcA==
X-Gm-Message-State: ANhLgQ06HMto4aqNZRY7wkfSwZ/LiR9XAnEzblFLo87Jy/1L6fTsXF++
        XkdtDchnDGgMkXIRTIoh74k/4sZOgmLQQ0hNEJqSFw==
X-Google-Smtp-Source: ADFU+vuDPVK8YAR70/g3YIqHaMwtOomcLHlX/P94KVdu/G2/oJGtgeTYOw+ZOJ/sbGEWuQqyqRyKHRotaEG256Qbo1A=
X-Received: by 2002:adf:efc9:: with SMTP id i9mr9415479wrp.23.1585235726390;
 Thu, 26 Mar 2020 08:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-4-trishalfonso@google.com> <CACT4Y+YHPfP3LP04=Zc4NgyhH8FMJ9m-eU_VPjmk5SmGWo_fTg@mail.gmail.com>
 <CAKFsvU+N=8=VmKVdNdf6os26z+vVD=vR=TL5GJtLQhR9FxOJUQ@mail.gmail.com> <CACT4Y+ZGcZhbkcAVVfKP1gUs7mg=LrSwBqhqpUozSX8Fof6ANA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZGcZhbkcAVVfKP1gUs7mg=LrSwBqhqpUozSX8Fof6ANA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Thu, 26 Mar 2020 08:15:14 -0700
Message-ID: <CAKFsvUK-9QU7SfKLoL0w75VgSOneO8DWciHTDYMfU8aD98Unbw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] KASAN: Port KASAN Tests to KUnit
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Thu, Mar 26, 2020 at 2:12 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Mar 24, 2020 at 4:05 PM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> >
> > On Tue, Mar 24, 2020 at 4:25 AM Dmitry Vyukov <dvyukov@google.com> wrot=
e:
> > >
> > > On Thu, Mar 19, 2020 at 5:42 PM 'Patricia Alfonso' via kasan-dev
> > > <kasan-dev@googlegroups.com> wrote:
> > > >
> > > > Transfer all previous tests for KASAN to KUnit so they can be run
> > > > more easily. Using kunit_tool, developers can run these tests with =
their
> > > > other KUnit tests and see "pass" or "fail" with the appropriate KAS=
AN
> > > > report instead of needing to parse each KASAN report to test KASAN
> > > > functionalities. All KASAN reports are still printed to dmesg.
> > > >
> > > > Stack tests do not work in UML so those tests are protected inside =
an
> > > > "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if stack
> > > > instrumentation is enabled.
> > > >
> > > > copy_user_test cannot be run in KUnit so there is a separate test f=
ile
> > > > for those tests, which can be run as before as a module.
> > >
> > > Hi Patricia,
> > >
> > > FWIW I've got some conflicts applying this patch on latest linux-next
> > > next-20200324. There are some changes to the tests in mm tree I think=
.
> > >
> > > Which tree will this go through? I would be nice to resolve these
> > > conflicts somehow, but I am not sure how. Maybe the kasan tests
> > > changes are merged upstream next windows, and then rebase this?
> > >
> > > Also, how can I apply this for testing? I assume this is based on som=
e
> > > kunit branch? which one?
> > >
> > Hmm... okay, that sounds like a problem. I will have to look into the
> > conflicts. I'm not sure which tree this will go through upstream; I
> > expect someone will tell me which is best when the time comes. This is
> > based on the kunit branch in the kunit documentation here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.g=
it/log/?h=3Dkunit
>
> I've checked out:
>
> commit 0476e69f39377192d638c459d11400c6e9a6ffb0 (HEAD, kselftest/kunit)
> Date:   Mon Mar 23 12:04:59 2020 -0700
>
> But the build still fails for me:
>
> mm/kasan/report.c: In function =E2=80=98kasan_update_kunit_status=E2=80=
=99:
> mm/kasan/report.c:466:6: error: implicit declaration of function
> =E2=80=98kunit_find_named_resource=E2=80=99 [-Werror=3Dimplicit-function-=
declar]
>   466 |  if (kunit_find_named_resource(cur_test, "kasan_data")) {
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/report.c:467:12: warning: assignment to =E2=80=98struct
> kunit_resource *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from i=
nteger without a cas]
>   467 |   resource =3D kunit_find_named_resource(cur_test, "kasan_data");
>       |            ^
> mm/kasan/report.c:468:24: error: =E2=80=98struct kunit_resource=E2=80=99 =
has no member
> named =E2=80=98data=E2=80=99
>   468 |   kasan_data =3D resource->data;
>       |                        ^~
>
> What am I doing wrong?

This patchset relies on another RFC patchset from Alan:
https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-a=
lan.maguire@oracle.com/T/#t

I thought I linked it in the commit message but it may only be in the
commit message for part 2/3. It should work with Alan's patchset, but
let me know if you have any trouble.

--
Best,
Patricia
