Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C876DE94
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjHCCz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHCCz4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:55:56 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EDB10A
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 19:55:55 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so159991cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 19:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691031354; x=1691636154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M31TVCZOo8aoSS85FtlkHAzcBWuXDtd8o0N06bFn5DM=;
        b=LHuFwi6Pl0tqGmEPZsDQ1WC65AmISRKLv2O1hD7+29C6o1j2vf3ffYQ8roiyhSns3C
         VM/bQEGSRB2lsQu5ehFiYLTLtdQaYtwcIE5i6feO4XiWeQ6+xNkb8ZzRE1BqfwjBfN9d
         UlYnVi5r18K2v3B1aUMjVfI+ohF5Uso6P1oxC8yg4W6R2wJo8h0Gl9V4OkIU4N7aHp/u
         xRyxhl+6vnhFDsK2LRVmGVEert0btyaCxbjgvgmufW7p2zbZOo69gwsVx+hpmoMFh7Qk
         KOPE4bBLRgtwouhGH6t7CnT3phYoMfT7oajwWhiyOOvzX7W37b85Fjv0QoNjwvq4wKsn
         pJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691031354; x=1691636154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M31TVCZOo8aoSS85FtlkHAzcBWuXDtd8o0N06bFn5DM=;
        b=kwPHMi47OhQN/wul7n2oD4LHlndaU4eqEXGu6327CNcaRKcFkoUkebc0kM/Na2bid/
         9Dj3GgQkiHrPUc357k88UDAiy83v4mu5EBOQUon1sHm3MkMa7HJXTPhV+w3PX5ic1Kov
         RrcwlH7Qmqx58+cmnneem7fAr96N+w53ZRchHM3oQz0YKbzxZbRwTflE82sQhAax7q8P
         2Pnu+uAc77tcJfMrEgfotc+1KDnTooBd0SXGMUcn/eM4BPo0IA1Ii70YsV+ebPFRQKqu
         0Th/BPJhMZ74a+Zw1X3MrKHfsET09UenTgmFNfqSPmXvFA8Zml4/VPtSKxIlhqj4jScr
         wf8A==
X-Gm-Message-State: ABy/qLbEOjilAFeyRZlV9PahHuZNLEk4Wm+3ae6hTV1oyE1WkK7lP4DI
        C3HlQBbtogs4H68Ldnsz8PQSrBYflzyBULt+ToaJRw==
X-Google-Smtp-Source: APBJJlF73+NS9Vpfcs/5wuufXMrWVC1pQV7T+HkRcsUyoLeIVFkRmDt+EQONQ8F1YR9KTuBCGcpdacstPqNWblXrEo0=
X-Received: by 2002:ac8:5c05:0:b0:3f8:e0a:3e66 with SMTP id
 i5-20020ac85c05000000b003f80e0a3e66mr1528975qti.3.1691031354105; Wed, 02 Aug
 2023 19:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <20230713143406.14342-4-cyphar@cyphar.com>
 <CALmYWFsusw5H6aa9Po6QyEKr7beUSTN+PmGzc0Er0tuGEmYCbA@mail.gmail.com> <20230803.022458-mundane.voyage.tricky.kinship-yaSxczr9O6cB@cyphar.com>
In-Reply-To: <20230803.022458-mundane.voyage.tricky.kinship-yaSxczr9O6cB@cyphar.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 2 Aug 2023 19:55:16 -0700
Message-ID: <CALmYWFs1DpVYnDTQwaZNuL+PyJEG44-gVwb6PSjdLwgRzgu=Zw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] selftests: memfd: error out test process when
 child test fails
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 2, 2023 at 7:25=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2023-07-19, Jeff Xu <jeffxu@google.com> wrote:
> > On Thu, Jul 13, 2023 at 7:34=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com=
> wrote:
> > >
> > > Before this change, a test runner using this self test would see a
> > > return code of 0 when the tests using a child process (namely the
> > > MFD_NOEXEC_SEAL and MFD_EXEC tests) failed, masking test failures.
> > >
> > > Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL =
MFD_EXEC")
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> > >  tools/testing/selftests/memfd/memfd_test.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testi=
ng/selftests/memfd/memfd_test.c
> > > index d8342989c547..8b7390ad81d1 100644
> > > --- a/tools/testing/selftests/memfd/memfd_test.c
> > > +++ b/tools/testing/selftests/memfd/memfd_test.c
> > > @@ -1219,7 +1219,24 @@ static pid_t spawn_newpid_thread(unsigned int =
flags, int (*fn)(void *))
> > >
> > >  static void join_newpid_thread(pid_t pid)
> > >  {
> > > -       waitpid(pid, NULL, 0);
> > > +       int wstatus;
> > > +
> > > +       if (waitpid(pid, &wstatus, 0) < 0) {
> > > +               printf("newpid thread: waitpid() failed: %m\n");
> > > +               abort();
> > > +       }
> > > +
> > > +       if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D 0) {
> > > +               printf("newpid thread: exited with non-zero error cod=
e %d\n",
> > > +                      WEXITSTATUS(wstatus));
> > > +               abort();
> > > +       }
> > > +
> > > +       if (WIFSIGNALED(wstatus)) {
> > > +               printf("newpid thread: killed by signal %d\n",
> > > +                      WTERMSIG(wstatus));
> > > +               abort();
> > > +       }
> > >  }
> > >
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
>
> Did you mean for this to a Reviewed-by?
>
Yes! Thanks for asking.

Reviewed-by: Jeff Xu <jeffxu@google.com>


> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>
