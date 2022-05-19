Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBDC52DC1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiESR5O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 13:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbiESR5L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 13:57:11 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86247CEBAA
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 10:57:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id m6so6568904iob.4
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTvwJwfDzauPQ+of5JXtLLkQatXip/21hHhzryuEKQA=;
        b=j3LimxuhjsDMbf3h7pgM2pWwYSD4AVDqwr9ip1QCctj49RKDncQaqTHeIyXLl50zzU
         4LG3je7shHcDY1r8jzTsxpcHjD9pp0lfGzlQqhuk55gzgWRRU5pqfxpRJbcJFKW03pa3
         LLtD7ehpQwpgyXa+eY0hUTZk4ioiKf7glMqpvtARWpYoJpPWD8StCBp85+mKbJnmGOEO
         TBKLipGuUQdEgRWPXm1GzIGIFeMe5N0+DDsTrPgxpZj900S2UeEVlLAND2cbavGFIQGt
         CTjt5zWmLaAZRopYq3odW6ZOoq4jz7+VypCEx0y6zLBALPoGbIsN3k2WOTSsu3sefi7x
         DLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTvwJwfDzauPQ+of5JXtLLkQatXip/21hHhzryuEKQA=;
        b=rfxVx8SwZeIh3birmxQHdOU/XLqc3k5f6p5TWrCWZoxrqjWI5cglFeil0GHuP2b5KD
         dtp/T33iLL2slO6lQivaCXY6aUyIq84Hl6ArLxnR2z6ovlY3Z8oeTPKhbcmAUfkACjY9
         PXkrR8lkDaZ3NPiLsSx0uTpwBgWjeEot4gsVD+1nz+KRcNb1+JY2ZzQYR4fyP8/Xv2bZ
         w51pxD1olIiOoTUVmmLLecGzCMfN4tHWaM5dBzBS8ufoKmUaD6yLPTMAyZmCNXCxV2Rg
         ow13A0pI/eeYHzhqD754FhbdvD7f/jFVczUDxTcKBs5awjDPqkphsR30Txvh2aAWUTx3
         Bsqg==
X-Gm-Message-State: AOAM5303OCTUBm7OkH0Abu8AwNKCpAAlDjZr+Bi1QKqbcHUX34nQH1ha
        rI7EseNNtQmg/pjrmnsKCaaQv3YBsm596GTyGAIb2w==
X-Google-Smtp-Source: ABdhPJxLnLPad++snwSrGlFPy2lO2WAmvA7axVeAQ6DyfojYPDblWdyjk16yhcxDogtbfCy3V2mwhAIveq3XhTsBM0Y=
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id
 y2-20020a5d94c2000000b0060bbd34bb6fmr3044953ior.32.1652983028426; Thu, 19 May
 2022 10:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-4-axelrasmussen@google.com> <a6f7ff80-ea77-75d0-2454-99d14f164708@linuxfoundation.org>
In-Reply-To: <a6f7ff80-ea77-75d0-2454-99d14f164708@linuxfoundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 19 May 2022 10:56:32 -0700
Message-ID: <CAJHvVciqx17ERazHNLyyFDGV6Fh0K=SyZ78DTO62xL4rqOTdgw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] userfaultfd: selftests: modify selftest to use /dev/userfaultfd
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 26, 2022 at 9:16 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/22/22 3:29 PM, Axel Rasmussen wrote:
> > We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
> > working into the future, so just run the test twice, using each
> > interface.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >   tools/testing/selftests/vm/userfaultfd.c | 31 ++++++++++++++++++++++--
> >   1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > index 92a4516f8f0d..12ae742a9981 100644
> > --- a/tools/testing/selftests/vm/userfaultfd.c
> > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > @@ -77,6 +77,9 @@ static int bounces;
> >   #define TEST_SHMEM  3
> >   static int test_type;
> >
> > +/* test using /dev/userfaultfd, instead of userfaultfd(2) */
> > +static bool test_dev_userfaultfd;
> > +
> >   /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
> >   #define ALARM_INTERVAL_SECS 10
> >   static volatile bool test_uffdio_copy_eexist = true;
> > @@ -383,13 +386,31 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
> >       }
> >   }
> >
> > +static void __userfaultfd_open_dev(void)
> > +{
> > +     int fd;
> > +
> > +     uffd = -1;
> > +     fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> > +     if (fd < 0)
> > +             return;
> > +
> > +     uffd = ioctl(fd, USERFAULTFD_IOC_NEW,
> > +                  O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> > +     close(fd);
> > +}
> > +
> >   static void userfaultfd_open(uint64_t *features)
> >   {
> >       struct uffdio_api uffdio_api;
> >
> > -     uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> > +     if (test_dev_userfaultfd)
> > +             __userfaultfd_open_dev();
> > +     else
> > +             uffd = syscall(__NR_userfaultfd,
> > +                            O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> >       if (uffd < 0)
> > -             err("userfaultfd syscall not available in this kernel");
> > +             err("creating userfaultfd failed");
>
> This isn't an error as in test failure. This will be a skip because of
> unmet dependencies. Also if this test requires root access, please check
> for that and make that a skip as well.

Testing with the userfaultfd syscall doesn't require any special
permissions (root or otherwise).

But testing with /dev/userfaultfd will require access to that device
node, which is root:root by default, but the system administrator may
have changed this. In general I think this will only fail due to a)
lack of kernel support or b) lack of permissions though, so always
exiting with KSFT_SKIP here seems reasonable. I'll make that change in
v3.

>
> >       uffd_flags = fcntl(uffd, F_GETFD, NULL);
> >
> >       uffdio_api.api = UFFD_API;
> > @@ -1698,6 +1719,12 @@ int main(int argc, char **argv)
> >       }
> >       printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
> >              nr_pages, nr_pages_per_cpu);
> > +
> > +     test_dev_userfaultfd = false;
> > +     if (userfaultfd_stress())
> > +             return 1;
> > +
> > +     test_dev_userfaultfd = true;
> >       return userfaultfd_stress();
> >   }
> >
> >
>
> thanks,
> -- Shuah
