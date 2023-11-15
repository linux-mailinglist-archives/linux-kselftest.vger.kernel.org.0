Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BFC7DC118
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 21:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjJ3UWW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 16:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjJ3UWV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 16:22:21 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476C210D
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 13:22:17 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5afb93d310fso34758007b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697336; x=1699302136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MZDC0C692oKqu67pAXxbmQTWTZ0RHUdPxw5a4EVzJM=;
        b=0VlrHSGhwJIJkMtZFxHFwGGbWJFDorb6gAu4FeP8UzhWC6LI3o3rn275cluUJjzhrU
         WU0uYGc8cMV9zuP17dEcv90eosCcRFFhpzgLIQNjipUuX7p8zpuI6Rbi9mcIA4HBXx38
         SREPRoWVKEATsdVRrYFFUUdon24wn5RL0+FkJ/42fPscZ2Lb3ky7NHPQ2Cgmq/GvL1ZG
         sHKp59MQeO33YokwkhO+x1QvzgyQHMDrNIf4NbZZzAPYqjmjYpHPsLE8mhHRDCEgj/j/
         xUJRVKTpXCxgCqpFzOo/QtW2l5RgJV3OpuqarEi9e8frRwznpiX3NFKQAmIjwA5i996n
         Nb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697336; x=1699302136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MZDC0C692oKqu67pAXxbmQTWTZ0RHUdPxw5a4EVzJM=;
        b=bmFoYDo0U1VTuoMyHhiKZamrB3rRo5PBPbCcOM0FGwlPFug433YDGTC6ZBdQ50nDtG
         wsWAhp6UyxnV5N4W/lkujRZqKSBJmlNmlOQbRsvZta8X7QC7+9th06wU1H92jGEHE3zR
         HYnN0KQcB4QrUS2tajNA/QTxSciXjhEESN0AXV9uOs08IbpgmFeOfWKo9a+xGKArttUJ
         qBe06sKIrOnkxhMHrJyZCK+CXm36T/ieiiZx4hyn2pYZwcOecP3mI3avCzRQhgTNgkcP
         1Y8PN592xXAq4AyhlcfYPQ/CceNZc3CsNclniRtRCti2uBhZZDaOxmYAVRDvamJgirhy
         QhQg==
X-Gm-Message-State: AOJu0YzrXGVu5RRVLWznlild/jKd5CItnd1vHYxg3IuYHJmLOz+9NOTK
        k/2yxsJ0VRTMZjKpqCx1B/XCJVB/q6nlnAm4wIgROQ==
X-Google-Smtp-Source: AGHT+IErTdQZnjT34lXTzXN3MzHAIzHtfhHdTZFEWa84Ne1hGq4DSlIR0kYYUcl8B03xzuvbq5tzsxkfTAgdkep7sF0=
X-Received: by 2002:a81:a987:0:b0:5a7:be1d:7ad3 with SMTP id
 g129-20020a81a987000000b005a7be1d7ad3mr11134229ywh.1.1698697335636; Mon, 30
 Oct 2023 13:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com> <20231028003819.652322-6-surenb@google.com>
 <ZUAOpmVO3LMmge3S@x1n>
In-Reply-To: <ZUAOpmVO3LMmge3S@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 30 Oct 2023 13:22:02 -0700
Message-ID: <CAJuCfpEbrWVxfuqRxCrxB482-b=uUnZw2-gqmjxENBUqhCQb8A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 30, 2023 at 1:14=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 27, 2023 at 05:38:15PM -0700, Suren Baghdasaryan wrote:
> > Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> > into destination buffer while checking the contents of both after
> > the move. After the operation the content of the destination buffer
> > should match the original source buffer's content while the source
> > buffer should be zeroed. Separate tests are designed for PMD aligned an=
d
> > unaligned cases because they utilize different code paths in the kernel=
.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/mm/uffd-common.c     |  24 ++++
> >  tools/testing/selftests/mm/uffd-common.h     |   1 +
> >  tools/testing/selftests/mm/uffd-unit-tests.c | 141 +++++++++++++++++++
> >  3 files changed, 166 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/s=
elftests/mm/uffd-common.c
> > index 69e6653ad255..98957fd788d8 100644
> > --- a/tools/testing/selftests/mm/uffd-common.c
> > +++ b/tools/testing/selftests/mm/uffd-common.c
> > @@ -643,6 +643,30 @@ int copy_page(int ufd, unsigned long offset, bool =
wp)
> >       return __copy_page(ufd, offset, false, wp);
> >  }
> >
> > +int move_page(int ufd, unsigned long offset)
> > +{
> > +     struct uffdio_move uffdio_move;
> > +
> > +     if (offset >=3D nr_pages * page_size)
> > +             err("unexpected offset %lu\n", offset);
> > +     uffdio_move.dst =3D (unsigned long) area_dst + offset;
> > +     uffdio_move.src =3D (unsigned long) area_src + offset;
> > +     uffdio_move.len =3D page_size;
> > +     uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > +     uffdio_move.move =3D 0;
> > +     if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > +             /* real retval in uffdio_move.move */
> > +             if (uffdio_move.move !=3D -EEXIST)
> > +                     err("UFFDIO_MOVE error: %"PRId64,
> > +                         (int64_t)uffdio_move.move);
> > +             wake_range(ufd, uffdio_move.dst, page_size);
> > +     } else if (uffdio_move.move !=3D page_size) {
> > +             err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.mo=
ve);
> > +     } else
> > +             return 1;
> > +     return 0;
> > +}
> > +
> >  int uffd_open_dev(unsigned int flags)
> >  {
> >       int fd, uffd;
> > diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/s=
elftests/mm/uffd-common.h
> > index 19930fd6682b..c9526b2cb6b3 100644
> > --- a/tools/testing/selftests/mm/uffd-common.h
> > +++ b/tools/testing/selftests/mm/uffd-common.h
> > @@ -121,6 +121,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool=
 wp);
> >  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *ar=
gs);
> >  int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
> >  int copy_page(int ufd, unsigned long offset, bool wp);
> > +int move_page(int ufd, unsigned long offset);
> >  void *uffd_poll_thread(void *arg);
> >
> >  int uffd_open_dev(unsigned int flags);
> > diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testi=
ng/selftests/mm/uffd-unit-tests.c
> > index debc423bdbf4..89e9529ce941 100644
> > --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> > +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> > @@ -1064,6 +1064,133 @@ static void uffd_poison_test(uffd_test_args_t *=
targs)
> >       uffd_test_pass();
> >  }
> >
> > +static void uffd_move_handle_fault(
> > +     struct uffd_msg *msg, struct uffd_args *args)
> > +{
> > +     unsigned long offset;
> > +
> > +     if (msg->event !=3D UFFD_EVENT_PAGEFAULT)
> > +             err("unexpected msg event %u", msg->event);
> > +
> > +     if (msg->arg.pagefault.flags &
> > +         (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PA=
GEFAULT_FLAG_WRITE))
> > +             err("unexpected fault type %llu", msg->arg.pagefault.flag=
s);
> > +
> > +     offset =3D (char *)(unsigned long)msg->arg.pagefault.address - ar=
ea_dst;
> > +     offset &=3D ~(page_size-1);
> > +
> > +     if (move_page(uffd, offset))
> > +             args->missing_faults++;
> > +}
> > +
> > +static void uffd_move_test(uffd_test_args_t *targs)
> > +{
> > +     unsigned long nr;
> > +     pthread_t uffd_mon;
> > +     char c;
> > +     unsigned long long count;
> > +     struct uffd_args args =3D { 0 };
> > +
> > +     /* Prevent source pages from being mapped more than once */
> > +     if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
> > +             err("madvise(MADV_DONTFORK) failure");
> > +
> > +     if (uffd_register(uffd, area_dst, nr_pages * page_size,
> > +                       true, false, false))
> > +             err("register failure");
> > +
> > +     args.handle_fault =3D uffd_move_handle_fault;
> > +     if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> > +             err("uffd_poll_thread create");
> > +
> > +     /*
> > +      * Read each of the pages back using the UFFD-registered mapping.=
 We
> > +      * expect that the first time we touch a page, it will result in =
a missing
> > +      * fault. uffd_poll_thread will resolve the fault by moving sourc=
e
> > +      * page to destination.
> > +      */
> > +     for (nr =3D 0; nr < nr_pages; nr++) {
> > +             /* Check area_src content */
> > +             count =3D *area_count(area_src, nr);
> > +             if (count !=3D count_verify[nr])
> > +                     err("nr %lu source memory invalid %llu %llu\n",
> > +                         nr, count, count_verify[nr]);
> > +
> > +             /* Faulting into area_dst should move the page */
> > +             count =3D *area_count(area_dst, nr);
> > +             if (count !=3D count_verify[nr])
> > +                     err("nr %lu memory corruption %llu %llu\n",
> > +                         nr, count, count_verify[nr]);
> > +
> > +             /* Re-check area_src content which should be empty */
> > +             count =3D *area_count(area_src, nr);
> > +             if (count !=3D 0)
> > +                     err("nr %lu move failed %llu %llu\n",
> > +                         nr, count, count_verify[nr]);
> > +     }
> > +
> > +     if (write(pipefd[1], &c, sizeof(c)) !=3D sizeof(c))
> > +             err("pipe write");
> > +     if (pthread_join(uffd_mon, NULL))
> > +             err("join() failed");
> > +
> > +     if (args.missing_faults !=3D nr_pages || args.minor_faults !=3D 0=
)
> > +             uffd_test_fail("stats check error");
> > +     else
> > +             uffd_test_pass();
> > +}
> > +
> > +static int prevent_hugepages(void)
> > +{
> > +     /* This should be done before source area is populated */
> > +     if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
> > +             /* Ignore if CONFIG_TRANSPARENT_HUGEPAGE=3Dn */
> > +             if (errno !=3D EINVAL)
> > +                     return -errno;
> > +     }
> > +     return 0;
> > +}
> > +
> > +struct uffd_test_case_ops uffd_move_test_case_ops =3D {
> > +     .post_alloc =3D prevent_hugepages,
> > +};
> > +
> > +#define ALIGN_UP(x, align_to) \
> > +     (__typeof__(x))((((unsigned long)(x)) + ((align_to)-1)) & ~((alig=
n_to)-1))
> > +
> > +static char *orig_area_src, *orig_area_dst;
> > +static int pmd_align_areas(void)
> > +{
> > +     orig_area_src =3D area_src;
> > +     orig_area_dst =3D area_dst;
> > +     area_src =3D ALIGN_UP(area_src, page_size);
> > +     area_dst =3D ALIGN_UP(area_dst, page_size);
> > +     nr_pages--;
> > +
> > +     return 0;
> > +}
> > +
> > +static void pmd_restore_areas(void)
> > +{
> > +     area_src =3D orig_area_src;
> > +     area_dst =3D orig_area_dst;
> > +     nr_pages++;
> > +}
>
> Please stop using more global variables.. uffd tests are even less
> maintainable.
>
> Maybe you can consider add a flag for uffd_test_ctx_init()?  For allocati=
ng
> either small/thp/default?

I was considering that but was not sure which way would be more
preferable - using these new callbacks or adding new page size
requirements. I'll change to the latter.

>
>
> > +
> > +static int adjust_page_size(void)
> > +{
> > +     page_size =3D default_huge_page_size();
>
> This is hacky too, currently page_size is the real page_size backing the
> memory.
>
> To make thp test simple, maybe just add one more test to MOVE a large chu=
nk
> to replace the thp test, which may contain a few thps?  It also doesn't
> need to be fault based.

Sorry, I didn't get your suggestion. Could you please clarify? Which
thp test are you referring to?

Thanks,
Suren.

>
> > +     nr_pages =3D UFFD_TEST_MEM_SIZE / page_size;
> > +
> > +     return 0;
> > +}
> > +
> > +struct uffd_test_case_ops uffd_move_pmd_test_case_ops =3D {
> > +     .pre_alloc =3D adjust_page_size,
> > +     .post_alloc =3D pmd_align_areas,
> > +     .pre_release =3D pmd_restore_areas,
> > +};
> > +
> >  /*
> >   * Test the returned uffdio_register.ioctls with different register mo=
des.
> >   * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage tes=
t.
> > @@ -1141,6 +1268,20 @@ uffd_test_case_t uffd_tests[] =3D {
> >               .mem_targets =3D MEM_ALL,
> >               .uffd_feature_required =3D 0,
> >       },
> > +     {
> > +             .name =3D "move",
> > +             .uffd_fn =3D uffd_move_test,
> > +             .mem_targets =3D MEM_ANON,
> > +             .uffd_feature_required =3D UFFD_FEATURE_MOVE,
> > +             .test_case_ops =3D &uffd_move_test_case_ops,
> > +     },
> > +     {
> > +             .name =3D "move-pmd",
> > +             .uffd_fn =3D uffd_move_test,
> > +             .mem_targets =3D MEM_ANON,
> > +             .uffd_feature_required =3D UFFD_FEATURE_MOVE,
> > +             .test_case_ops =3D &uffd_move_pmd_test_case_ops,
> > +     },
> >       {
> >               .name =3D "wp-fork",
> >               .uffd_fn =3D uffd_wp_fork_test,
> > --
> > 2.42.0.820.g83a721a137-goog
> >
>
> --
> Peter Xu
>
