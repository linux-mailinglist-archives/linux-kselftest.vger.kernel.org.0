Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE00522174
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbiEJQqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiEJQqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:46:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7AF20BE2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:42:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s30so31744113ybi.8
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyIHSpV7urkNC/m60X3OuzStVpyeIryc1aK1Punw4D8=;
        b=V92PI4bmOdix/67urkG91/TJAjUY3Ex/AdHQvLC+n6j+EjO3mVD7v3Mz4eGUlGoEJ7
         zRNK7bexwodR/5e4GXaB5rQtzm4pkmocwRan7CNTEzgNkJXNdLAHUYpfx9bDBRNojZEj
         1aHaCp25650Pvre4A5jQlG2Ku68l073Z6vB/qyS6TUMrMEakIwuxYunG9ihkOykkv5aD
         n1Ui5FW3lbLiZagup2m7ABMIdbLVCmw7qTRG8mK3vm/NXR/wtXg2LAeBCA3FWtYN/fx6
         1PHDacN8QP0kfjppDBfC0ZgdsgdLqP288ie4lkFHXo0SLOZWiBUol1lgo7C3v2kNkaIE
         4Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyIHSpV7urkNC/m60X3OuzStVpyeIryc1aK1Punw4D8=;
        b=YgBdhXbNJp13Ryg5goMDeLl4GjYke3/N9uwzmWv7FOJNOeBfrzEXSnYwcH6KUVcge4
         H9GmNsLr/IQE7vwO1vRNP9YtO7pdPj2nhE6+qhNyvNE83yqwn7m+WDVDdzfK90cKRiZj
         72ljWg31sI7xxYcmNzCTmPQbq0tEUmKr4UHEpVg1ntjm2jYAljkRZ7wa6rpS2zchv5+2
         uVmKcZi/QGr+oLjwjQPWgCEmzHaaTAvHIz5LAPHqm+6SenL1fEnnSjWIFZcEHiRGtrvK
         wlxGc213Ue+fJAJgEivp3u8pfm7oKyBuMkoxqHw4eplwdd/lDZtAwlgI80b6fG5DfOTr
         2v4Q==
X-Gm-Message-State: AOAM531bK5FQqiJaaDv8+UIicGphaGhtIEpbPMhfaBkHCfh+g42Y1IPA
        +vrcOvpNkB3jbKsPsZpANzdOdMn1IW52h9VbSkuiLA==
X-Google-Smtp-Source: ABdhPJxZ/+tgVgvg8fQm/jcM9aB8pFitGhgZM6GXVcw+NtkFAeAj8nhv59Uys3MXLYyvAYh+f32/Oi2k53WS8hYVTeY=
X-Received: by 2002:a25:d55:0:b0:648:7008:61e0 with SMTP id
 82-20020a250d55000000b00648700861e0mr18424242ybn.282.1652200963633; Tue, 10
 May 2022 09:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com> <04858a5d-98c8-69be-025f-214e4b10d502@linuxfoundation.org>
 <CAJuCfpEAqEEf-SCi87-VZrFYcoPff8Gkda5uF8fYRyKQo_vkjw@mail.gmail.com> <ebaad398-110d-6a6b-70a5-3abeacfcb14a@linuxfoundation.org>
In-Reply-To: <ebaad398-110d-6a6b-70a5-3abeacfcb14a@linuxfoundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 May 2022 09:42:32 -0700
Message-ID: <CAJuCfpG5dDv61NFmBLi+8oNuOMgS51Q4Cq6SNvM68n9z0XE5cA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests: vm: add process_mrelease tests
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 10, 2022 at 9:36 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/10/22 10:29 AM, Suren Baghdasaryan wrote:
> > On Tue, May 10, 2022 at 8:43 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
> >>> Introduce process_mrelease syscall sanity tests. They include tests of
> >>> invalid pidfd and flags inputs, attempting to call process_mrelease
> >>> with a live process and a valid usage of process_mrelease. Because
> >>> process_mrelease has to be used against a process with a pending SIGKILL,
> >>> it's possible that the process exits before process_mrelease gets called.
> >>> In such cases we retry the test with a victim that allocates twice more
> >>> memory up to 1GB. This would require the victim process to spend more
> >>> time during exit and process_mrelease has a better chance of catching
> >>> the process before it exits.
> >>>
> >>
> >> +1 on Mike's comments on improving the change log. List what is getting
> >> tested as opposed to describing the test code.
> >
> > I'll try to improve the description but IMHO it does describe what
> > it's testing - the process_mrelease syscall with valid and invalid
> > inputs. I could omit the implementation details if that helps.
> >
> >>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>>    tools/testing/selftests/vm/Makefile        |   1 +
> >>>    tools/testing/selftests/vm/mrelease_test.c | 176 +++++++++++++++++++++
> >>>    tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
> >>>    3 files changed, 193 insertions(+)
> >>>    create mode 100644 tools/testing/selftests/vm/mrelease_test.c
> >>
> >> Please update .gitignore with the new executable.
> >
> > Ack.
> >
> >>
> >>>
> >>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> >>> index 04a49e876a46..733fccbff0ef 100644
> >>> --- a/tools/testing/selftests/vm/Makefile
> >>> +++ b/tools/testing/selftests/vm/Makefile
> >>> @@ -43,6 +43,7 @@ TEST_GEN_FILES += map_populate
> >>>    TEST_GEN_FILES += memfd_secret
> >>>    TEST_GEN_FILES += mlock-random-test
> >>>    TEST_GEN_FILES += mlock2-tests
> >>> +TEST_GEN_FILES += mrelease_test
> >>>    TEST_GEN_FILES += mremap_dontunmap
> >>>    TEST_GEN_FILES += mremap_test
> >>>    TEST_GEN_FILES += on-fault-limit
> >>> diff --git a/tools/testing/selftests/vm/mrelease_test.c b/tools/testing/selftests/vm/mrelease_test.c
> >>> new file mode 100644
> >>> index 000000000000..a61061bf8433
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/vm/mrelease_test.c
> >>> @@ -0,0 +1,176 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright 2022 Google LLC
> >>> + */
> >>> +#define _GNU_SOURCE
> >>> +#include <errno.h>
> >>> +#include <stdio.h>
> >>> +#include <stdlib.h>
> >>> +#include <sys/wait.h>
> >>> +#include <unistd.h>
> >>> +
> >>> +#include "util.h"
> >>> +
> >>> +static inline int pidfd_open(pid_t pid, unsigned int flags)
> >>> +{
> >>> +#ifdef __NR_pidfd_open
> >>> +     return syscall(__NR_pidfd_open, pid, flags);
> >>> +#else
> >>> +     errno = ENOSYS;
> >>
> >> This isn't an error - this would be skip because this syscall
> >> isn't supported.
> >
> > Ack.
> >
> >>
> >>> +     return -1;
> >>> +#endif
> >>
> >> Key off of syscall return instead of these ifdefs - same comment
> >> on all of the ifdefs
> >
> > Ack. I was using some other test as an example but I guess that was
> > not a good model.
> >
> >>
> >>> +}
> >>> +
> >>
> >> I am not seeing any reason for breaking this code up have a separate
> >> routine for pidfd_open().
> >
> > I'm a bit unclear what you mean. Do you mean that userspace headers
> > should already define pidfd_open() and I don't need to define it?
> >
>
> Do you need pidfd_open() or can this be part of main? Without the ifdefs,
> it is really a one line code.

Ah, I see. I think it's cleaner that way but I'll make them one-line
inline functions.

>
> thanks,
> -- Shuah
