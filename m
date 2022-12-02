Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFD641177
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 00:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiLBXYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 18:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiLBXYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 18:24:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7063F8989
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 15:24:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so9691756pjp.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 15:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=on58jY6T434zQgu2CSXS/icw6nLEfVeftPkBpeTWD00=;
        b=f9N08HoP3vjXrlBMoa1BWvaTSWYndYLcM4wvp+sp+YXl3LIIVsOpQuF46rZaSwVNfq
         nHVkSzNk6vjd6vvV4fmVD3rpGz5vZAwUikyB5tUcEHoW+afHzh1WXuoPSu784boKvqNM
         FdiMdq9PdHK4j0Q/imjoWxQ2FaNvTxNHqr7LrJfZ9lwi3EMqsJfwCF3hnBUWxxpwRTn0
         0jvlP5iIb4KaObAhu8XtR2n5TKJLYoG7RLWkUrDoas8k4jsWcAWlntQBnMiRZqlEYoTP
         H442pPWf0jqdJyXM05cDctKukg6U+w+JyvNaWMDjfVn+YuFO5hK7+MJnmg0T32oxYnDL
         oH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=on58jY6T434zQgu2CSXS/icw6nLEfVeftPkBpeTWD00=;
        b=4gFJyHcIO7z9tYftSjUMe4js1NwISh8Zaurw1D7Y19PrAZuVKrZ7MUeluF3qUk1eXa
         H6sxJFbE6BC8iJHY8HuZZYYIxVxtn6WzmVQUCuCjwvOVWrjGEedGCBo7/zIhoaNXNVhZ
         nBIV1zm44cjzjj3LiOIVkCSIrR0o3fd7SN6OejT5cadvMPCoRcT/SYIWotg9T8pY8KAa
         1hwJSxy5WxCIG2HusysWrRcb/ayA68G9v3vyNOpm8K6OV+lRX/al7SjCza2NVqPydNz1
         b+vLugrk0EXR7/XVEnaA8HuhYtLJobDLYCtHnpPpSZ2QfrdlgnikQA5lFmLVi6VHXBq+
         pe3g==
X-Gm-Message-State: ANoB5pkEFaoo/5FajGAuFwA3Y+SA0zc36WJ0rS8lvfq9Z5CXx/mxNdvJ
        5iaIxiv7+S3lgFq8UY//91rQ0Wxx34EUPjU0cGQxUw==
X-Google-Smtp-Source: AA0mqf5E8zMLU2q3bZ7mZyyna7VvQKkHk3cfGKZrg32/dY3cWByKKJPBLwGkdKGt4CtkQAcmr9HvbrVMpAETT+qUAP8=
X-Received: by 2002:a17:902:ec04:b0:189:894c:6b58 with SMTP id
 l4-20020a170902ec0400b00189894c6b58mr28915373pld.172.1670023454228; Fri, 02
 Dec 2022 15:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20221202013404.163143-1-jeffxu@google.com> <20221202013404.163143-6-jeffxu@google.com>
 <202212021457.EC46B27677@keescook>
In-Reply-To: <202212021457.EC46B27677@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 2 Dec 2022 15:23:37 -0800
Message-ID: <CALmYWFuQUcd1RYu1idS5cirAXNbynDLkxLYTHRAFS6yQE=gOmw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memfd: security hook for memfd_create
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Dec 2, 2022 at 2:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Dec 02, 2022 at 01:34:03AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > The new security_memfd_create allows lsm to check flags of
> > memfd_create.
> >
> > The security by default system (such as chromeos) can use this
> > to implement system wide lsm to allow only non-executable memfd
> > being created.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/lsm_hook_defs.h | 1 +
> >  include/linux/lsm_hooks.h     | 4 ++++
> >  include/linux/security.h      | 6 ++++++
> >  mm/memfd.c                    | 5 +++++
> >  4 files changed, 16 insertions(+)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index ec119da1d89b..fd40840927c8 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
> >  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
> >  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
> >        unsigned long arg)
> > +LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
> >  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
> >  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
> >        unsigned long prot, unsigned long flags)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 4ec80b96c22e..5a18a6552278 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -543,6 +543,10 @@
> >   *   simple integer value.  When @arg represents a user space pointer, it
> >   *   should never be used by the security module.
> >   *   Return 0 if permission is granted.
> > + * @memfd_create:
> > + *   @name is the name of memfd file.
> > + *   @flags is the flags used in memfd_create.
> > + *   Return 0 if permission is granted.
> >   * @mmap_addr :
> >   *   Check permissions for a mmap operation at @addr.
> >   *   @addr contains virtual address that will be used for the operation.
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index ca1b7109c0db..5b87a780822a 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
> >  int security_file_alloc(struct file *file);
> >  void security_file_free(struct file *file);
> >  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> > +int security_memfd_create(char *name, unsigned int flags);
> >  int security_mmap_file(struct file *file, unsigned long prot,
> >                       unsigned long flags);
> >  int security_mmap_addr(unsigned long addr);
> > @@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
> >       return 0;
> >  }
> >
> > +static inline int security_memfd_create(char *name, unsigned int flags)
> > +{
> > +     return 0;
> > +}
>
> I think this is missing the security/security.c changes for the
> non-inline version?
>
Yes. I will add that in V4.

> -Kees
>
> > +
> >  static inline int security_mmap_file(struct file *file, unsigned long prot,
> >                                    unsigned long flags)
> >  {
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 69e897dea6d5..96dcfbfed09e 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -346,6 +346,11 @@ SYSCALL_DEFINE2(memfd_create,
> >               goto err_name;
> >       }
> >
> > +     /* security hook for memfd_create */
> > +     error = security_memfd_create(name, flags);
> > +     if (error)
> > +             return error;
> > +
> >       if (flags & MFD_HUGETLB) {
> >               file = hugetlb_file_setup(name, 0, VM_NORESERVE,
> >                                       HUGETLB_ANONHUGE_INODE,
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
> >
>
> --
> Kees Cook
