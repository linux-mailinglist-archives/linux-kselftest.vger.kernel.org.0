Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F773705A8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEPWZ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPWZ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 18:25:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB459E0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 15:25:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso1661a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684275926; x=1686867926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsruOfx1bcVhMOcogHRbjQUtZfueJR8BYRLENPgR3EM=;
        b=nPMklpwuztnmJsZD5kYHbZk0A4Or9Gp42GrUE6S8mGkzO+p8Q1RGHNOcI9WUQKqniU
         gn0ajatAen6X7gzIymHoX91rfmlRWZySK/RySMNQAK5kOjMZlgPjP9hI6f4PqPpzcv1A
         LBGyQlE8hMCsRx6k7yS+9vCI2yhm6TyFxXN+0wWDEVAg6jByIHe8wrmjpYAM7Iz8TFFW
         EbMp6JKLcQV2GjBthPVWbAumM5Nq/xcQPdoYShR8dnGJP8ipVo9oyDAVf/X3Fw/CGfc6
         jP7xbBtYQAsh40WgMFQ0B7WQ0XW57W6jOlkhRKNG/uCkGGZ6UI5mWA0n5ZXSyAGT3RNj
         Eb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275926; x=1686867926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsruOfx1bcVhMOcogHRbjQUtZfueJR8BYRLENPgR3EM=;
        b=FD0l62KfMOoE83PvVWcv65NkzHBdLhGuv5HT/9Pl5o0e/lAeO5t//+YQuaUu3+ff/M
         EW5F58xUR0/jPCK1u/JPukGOp2RZ0qWypJNfSrZCWNvubH6aU7wY6T+nMdZd6jNRv1Rf
         kc1Ip1l+ZMSF6DPM5C1VlPgedG5ZuFeDEpQtpOaL4p80l4f5D0QH1LEhoWZYqIBSXeqm
         4ueA4mMtRg6WAPki71g5zQ1LM1JFpEXNPTmhbEoFBpjQnuBesOGGWNSHbG2Zs6ogFl5X
         XMyGpolsLKTw6qLvJwxnZBG0+gT9aSTmbNTtqNEpFhQJGftifqdR8WQcJLIr52a9w9gl
         I/mw==
X-Gm-Message-State: AC+VfDx/nH/j/X2eM+bj4AoA7Cl7/nKEu70qSSSTXlO4zEXxl/PY9PNZ
        p9V+h7WUV1GDJgJuH/24f2yVp7luVgzKTuvmt8QX+w==
X-Google-Smtp-Source: ACHHUZ51dfc73YPcyqVjoCb3D7RdXmZi/sdfnvq+Tb4ZqLn4Jn/M2T1iMMHGBEMD+Ydy/6sYnT5ZYuoTWrcrofrv5xQ=
X-Received: by 2002:a50:9515:0:b0:4bc:dee8:94ca with SMTP id
 u21-20020a509515000000b004bcdee894camr7459eda.7.1684275925862; Tue, 16 May
 2023 15:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-6-jeffxu@chromium.org>
 <202305161302.16BF756DEA@keescook>
In-Reply-To: <202305161302.16BF756DEA@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 15:24:49 -0700
Message-ID: <CALmYWFsPvDd2DQ+J3JpLWT_AD7F7kGN-f1o3dG5LbX7FO_Qhhg@mail.gmail.com>
Subject: Re: [PATCH 5/6] KEY: Apply PKEY_ENFORCE_API to munmap
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, dave.hansen@intel.com, luto@kernel.org,
        jorgelo@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 16, 2023 at 1:13=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, May 15, 2023 at 01:05:51PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > This patch enables PKEY_ENFORCE_API for the munmap
> > syscall.
> >
> > Signed-off-by: Jeff Xu<jeffxu@google.com>
> > ---
> >  include/linux/mm.h |  2 +-
> >  mm/mmap.c          | 34 ++++++++++++++++++++++++++--------
> >  mm/mremap.c        |  6 ++++--
> >  3 files changed, 31 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 27ce77080c79..48076e845d53 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3136,7 +3136,7 @@ extern unsigned long do_mmap(struct file *file, u=
nsigned long addr,
> >       unsigned long pgoff, unsigned long *populate, struct list_head *u=
f);
> >  extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *m=
m,
> >                        unsigned long start, size_t len, struct list_hea=
d *uf,
> > -                      bool downgrade);
> > +                      bool downgrade, bool syscall);
>
> For type checking and readability, I suggest using an enum instead of
> "bool". Perhaps something like:
>
> enum caller_origin {
>         ON_BEHALF_OF_KERNEL =3D 0,
>         ON_BEHALF_OF_USERSPACE,
> };
>
Sure, it makes sense.


>  extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>                          unsigned long start, size_t len, struct list_hea=
d *uf,
> -                        bool downgrade);
> +                        bool downgrade, enum caller_origin called);
>
> >  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
> >                    struct list_head *uf);
> >  extern int do_madvise(struct mm_struct *mm, unsigned long start, size_=
t len_in, int behavior);
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 13678edaa22c..29329aa794a6 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2498,6 +2498,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
> >   * @uf: The userfaultfd list_head
> >   * @downgrade: set to true if the user wants to attempt to write_downg=
rade the
> >   * mmap_lock
> > + * @syscall: set to true if this is called from syscall entry
> >   *
> >   * This function takes a @mas that is either pointing to the previous =
VMA or set
> >   * to MA_START and sets it up to remove the mapping(s).  The @len will=
 be
> > @@ -2507,7 +2508,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
> >   */
> >  int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >                 unsigned long start, size_t len, struct list_head *uf,
> > -               bool downgrade)
> > +               bool downgrade, bool syscall)
> >  {
> >       unsigned long end;
> >       struct vm_area_struct *vma;
> > @@ -2519,6 +2520,19 @@ int do_vmi_munmap(struct vma_iterator *vmi, stru=
ct mm_struct *mm,
> >       if (end =3D=3D start)
> >               return -EINVAL;
> >
> > +     /*
> > +      * When called by syscall from userspace, check if the calling
> > +      * thread has the PKEY permission to modify the memory mapping.
> > +      */
> > +     if (syscall && arch_check_pkey_enforce_api(mm, start, end) < 0) {
>
>         if (called =3D=3D ON_BEHALF_OF_USERSPACE &&
>             arch_check_pkey_enforce_api(mm, start, end) < 0) {
>
> > +             char comm[TASK_COMM_LEN];
> > +
> > +             pr_warn_ratelimited(
> > +                     "munmap was denied on PKEY_ENFORCE_API memory, pi=
d=3D%d '%s'\n",
> > +                     task_pid_nr(current), get_task_comm(comm, current=
));
> > +             return -EACCES;
> > +     }
> > +
> >        /* arch_unmap() might do unmaps itself.  */
> >       arch_unmap(mm, start, end);
> >
> > @@ -2541,7 +2555,7 @@ int do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
> >  {
> >       VMA_ITERATOR(vmi, mm, start);
> >
> > -     return do_vmi_munmap(&vmi, mm, start, len, uf, false);
> > +     return do_vmi_munmap(&vmi, mm, start, len, uf, false, false);
>
> +       return do_vmi_munmap(&vmi, mm, start, len, uf, false, ON_BEHALF_O=
F_KERNEL);
>
> > [...]
> >  SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
> >  {
> >       addr =3D untagged_addr(addr);
> > -     return __vm_munmap(addr, len, true);
> > +     return __vm_munmap(addr, len, true, true);
>
> +       return __vm_munmap(addr, len, true, ON_BEHALF_OF_USERSPACE);
>
> etc.
>
> --
> Kees Cook

Thanks!
-Jeff Xu
