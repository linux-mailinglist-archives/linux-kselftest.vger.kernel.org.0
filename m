Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA96B3097
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 23:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjCIW2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 17:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCIW2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 17:28:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DED5A909
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Mar 2023 14:28:06 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k14so4232701lfj.7
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Mar 2023 14:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678400884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29CZKSnro71XuZ/X2KIXin8EzPbyFRqqtGaiLs6Be54=;
        b=ticBqftLOEJj1O6T3FL+5n3IsSOfX3ueB2Y43c8FDQ4uOap3RiQmFGRUOH0CB76bmW
         N4BGaFG13x1VB9kT7Z8vnkrRrGYaw77ky/ykS/Jmwl71i3RmTDV4O+xeeuwHr4iE1dgv
         JAIyFgMl9jpJ+0UVxiYjYFnwr670JmKMbOVIwPKo69cU7FGny9TbyTP+gLuuGLQLE3Zv
         fzD3zBQe5tY7651xIBF57WbqmhFJ4mUepK3lQQ0vSdYk9sw/A2m4DRm7oq0l+v72ZL69
         eL7guQznFBOxwk8BviPN0K1jHCUmLQTgJCAAjCSb0wk3j4VK5EL/MjbBQnCJSWtqCsuC
         JtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678400884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29CZKSnro71XuZ/X2KIXin8EzPbyFRqqtGaiLs6Be54=;
        b=x58pi4S1Juuv7KZGfMWuqOO0DGvD1IsERHoa90XMje1QcRj0iAXUoOtwPVWo258ZEb
         SIVhlpERsx2qDo+QcD167RTT7kfktXPeRBzI4097sTv4zdkFQqUYgpdN1RL87gEzLLFd
         xC34oMihMLCrPwvLnrEH/eOwLeDIA/12Yx/TS0dpSwXH5Uw0954riXELcUyF77yUxtV7
         p8f936So9hmXRajMOtWJnujPIUJp4fQkE21fmsq6fw6SWtbM3x8mLEscN+LfbGJM5muC
         5GZNnPVIWjXcyh2xIe3gcRo6CeMkkLkh8+DMiOFSw3BMk25qoStsvgpvWCSNDzkpyoSg
         4tOA==
X-Gm-Message-State: AO0yUKWlt18z1vKhBsFinxjZ/mHg1U02MuBCQvU90u7FjW2PkRCs/m0N
        kKozvxEEQ5TKeAg1cCUsBdbBuTbDFNWcjtleojoqog==
X-Google-Smtp-Source: AK7set8XKEHB+Eqae38HNHUfYvdzRQBggEBNTeVTBQ831nGlT2poOPKyEfQFXV6pveIx4Q21go/izYSd6MSOZsP2EmI=
X-Received: by 2002:ac2:53aa:0:b0:4dc:807a:d140 with SMTP id
 j10-20020ac253aa000000b004dc807ad140mr7177100lfh.10.1678400884282; Thu, 09
 Mar 2023 14:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20230308221932.1548827-1-axelrasmussen@google.com>
 <20230308221932.1548827-5-axelrasmussen@google.com> <ZAmikuHeF3hhqZlD@kernel.org>
In-Reply-To: <ZAmikuHeF3hhqZlD@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 9 Mar 2023 14:27:27 -0800
Message-ID: <CAJHvVchQF+9=TbhzJFhnwmfeT7e42=ReoFhqV_p+r-aOxifTXw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
 install WP PTEs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 9, 2023 at 1:11=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Wed, Mar 08, 2023 at 02:19:32PM -0800, Axel Rasmussen wrote:
> > UFFDIO_COPY already has UFFDIO_COPY_MODE_WP, so when installing a new
> > PTE to resolve a missing fault, one can install a write-protected one.
> > This is useful when using UFFDIO_REGISTER_MODE_{MISSING,WP} in
> > combination.
> >
> > This was motivated by testing HugeTLB HGM [1], and in particular its
> > interaction with userfaultfd features. Existing userfaultfd code
> > supports using WP and MINOR modes together (i.e. you can register an
> > area with both enabled), but without this CONTINUE flag the combination
> > is in practice unusable.
> >
> > So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
> > as UFFDIO_COPY_MODE_WP, but for *minor* faults.
> >
> > Update the selftest to do some very basic exercising of the new flag.
> >
> > [1]: https://patchwork.kernel.org/project/linux-mm/cover/20230218002819=
.1486479-1-jthoughton@google.com/
> >
> > Acked-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>
> > ---
> >  fs/userfaultfd.c                         | 8 ++++++--
> >  include/linux/userfaultfd_k.h            | 3 ++-
> >  include/uapi/linux/userfaultfd.h         | 7 +++++++
> >  mm/userfaultfd.c                         | 5 +++--
> >  tools/testing/selftests/mm/userfaultfd.c | 4 ++++
> >  5 files changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/user=
faultfd.h
> > index 005e5e306266..14059a0861bf 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -297,6 +297,13 @@ struct uffdio_writeprotect {
> >  struct uffdio_continue {
> >       struct uffdio_range range;
> >  #define UFFDIO_CONTINUE_MODE_DONTWAKE                ((__u64)1<<0)
> > +     /*
> > +      * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
> > +      * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
> > +      * write protected ioctl is implemented for the range
> > +      * according to the uffdio_register.ioctls.
> > +      */
> > +#define UFFDIO_CONTINUE_MODE_WP                      ((__u64)1<<1)
>
> Please add the description of the new flag to Documentation/ and to the
> userfaultfd man pages.

Funny enough, neither flag is mentioned in Documentation/ today - I'll
add a short passage about both.

Happy to update the man pages as well, I'll send that patch separately.

Thanks for reviewing!

>
> >       __u64 mode;
> >
> >       /*
>
> --
> Sincerely yours,
> Mike.
