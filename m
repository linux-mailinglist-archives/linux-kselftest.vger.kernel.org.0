Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F1641186
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 00:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiLBXdl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 18:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiLBXdj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 18:33:39 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79779D2932
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 15:33:37 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 136so5608077pga.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 15:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WfQbQ+1EE0fMDX/Q+9Du4Mqir+JlALTfkpbrkbmDKGs=;
        b=U7BO6/sCr4BvAijXi57j1gjHRzL7ZauFB6uT3qpzHVJiOpDuOiQY1cPj6T6lOy9u7A
         wHm/yY1/7ftQRfno3ov7QdAHNFpWNy/xvNi9Q/b4M5eQIWOvRnQo0RAfb6sdkxlVRYjC
         1eF9FDubS5CeXdxo7VR6ruRlZcmZ6xCJlJH6SsBZKBdM2ml+c6tPmcHdfCuMZUB7a0P/
         a/VvDqOcmi0XcyQlkvExZpwlm+5NC9amLuCLxbiZ8guhUkkiJRr+RJ+L67NG17pJ24/M
         Ue8WNcULJoC1ikQ9EzSbTt6mOr66/Yq9WoqyvGTKKgW3bz4h0ript0zpYo34mfPJEDJD
         v7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfQbQ+1EE0fMDX/Q+9Du4Mqir+JlALTfkpbrkbmDKGs=;
        b=RtR3K/M50g2ts6uKTs9M3HliIG4pF95CZv2tTP69QCTCzeRARn2Bo1PARqAgc62cVR
         FwyCJtzmWJrmYin2rqJbGdU7lM00Jq2BisBepp9+2+45YosFsBqjnJMAdzGM2C92Gjw2
         WdquutA+91yHLtpXtvQ4t1zJjyg6f8r7wG/Rqhlyt+6COJgtkSiGzaVk60IYiwTaKQsl
         7J2+1KRN6XyhP2o4A+1VFbB0r5jmwuM33W38UJfrDUb52rl0CkxzsMQHDyutkg/4aUDM
         6pYl6qCM5LfrChsc3Na3pyCj9T/oVLKhfpF64epTc19j3x977/YpmGMtUsSQx6wH59E4
         nGVg==
X-Gm-Message-State: ANoB5pnDlVPXM9nJkOvCyo7a997aKrMBJ5cDeaEvpk+y2m84Et3vJrcw
        kcg2fRRg1OK54a5qibNez0QT0swNSnFJI9Un9D6/fA==
X-Google-Smtp-Source: AA0mqf62o2WyBxZy2ztm76YtuYodYXP5g/qT3rWNrLy1Xy/S4gceyDzrRyYtvtOfZfpcnhjA/5yxSuGsv8u5vLvYN1A=
X-Received: by 2002:a63:2584:0:b0:478:5d6b:d1fd with SMTP id
 l126-20020a632584000000b004785d6bd1fdmr12962258pgl.249.1670024016718; Fri, 02
 Dec 2022 15:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20221202013404.163143-1-jeffxu@google.com> <20221202013404.163143-3-jeffxu@google.com>
 <202212021446.9D544DDF@keescook>
In-Reply-To: <202212021446.9D544DDF@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 2 Dec 2022 15:32:59 -0800
Message-ID: <CALmYWFsOGXKyutTArDR-QHaZoR+3bh2hQz_YN1QFtAqOXsbHFQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
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

On Fri, Dec 2, 2022 at 2:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Dec 02, 2022 at 01:34:00AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
> > set executable bit at creation time (memfd_create).
> >
> > When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> > (mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> > be executable (mode: 0777) after creation.
> >
> > when MFD_EXEC flag is set, memfd is created with executable bit
> > (mode:0777), this is the same as the old behavior of memfd_create.
> >
> > The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> > 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> >       MFD_EXEC was set.
> > 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> >       MFD_NOEXEC_SEAL was set.
> > 2:memfd_create() without MFD_NOEXEC_SEAL will be rejected.
>
>     ^ nit: missing space
>
> >
> > The sysctl allows finer control of memfd_create for old-software
> > that doesn't set the executable bit, for example, a container with
> > vm.memfd_noexec=1 means the old-software will create non-executable
> > memfd by default.
> >
> > Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
> > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/pid_namespace.h | 19 ++++++++++++++
> >  include/uapi/linux/memfd.h    |  4 +++
> >  kernel/pid_namespace.c        | 47 +++++++++++++++++++++++++++++++++++
> >  mm/memfd.c                    | 44 ++++++++++++++++++++++++++++++--
> >  4 files changed, 112 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> > index 07481bb87d4e..a4789a7b34a9 100644
> > --- a/include/linux/pid_namespace.h
> > +++ b/include/linux/pid_namespace.h
> > @@ -16,6 +16,21 @@
> >
> >  struct fs_pin;
> >
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > +/*
> > + * sysctl for vm.memfd_noexec
> > + * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
> > + *   acts like MFD_EXEC was set.
> > + * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
> > + *   acts like MFD_NOEXEC_SEAL was set.
> > + * 2: memfd_create() without MFD_NOEXEC_SEAL will be
> > + *   rejected.
> > + */
> > +#define MEMFD_NOEXEC_SCOPE_EXEC              0
> > +#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL               1
> > +#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED   2
> > +#endif
> > +
> >  struct pid_namespace {
> >       struct idr idr;
> >       struct rcu_head rcu;
> > @@ -31,6 +46,10 @@ struct pid_namespace {
> >       struct ucounts *ucounts;
> >       int reboot;     /* group exit code if this pidns was rebooted */
> >       struct ns_common ns;
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > +     /* sysctl for vm.memfd_noexec */
> > +     int memfd_noexec_scope;
> > +#endif
> >  } __randomize_layout;
> >
> >  extern struct pid_namespace init_pid_ns;
> > diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> > index 7a8a26751c23..273a4e15dfcf 100644
> > --- a/include/uapi/linux/memfd.h
> > +++ b/include/uapi/linux/memfd.h
> > @@ -8,6 +8,10 @@
> >  #define MFD_CLOEXEC          0x0001U
> >  #define MFD_ALLOW_SEALING    0x0002U
> >  #define MFD_HUGETLB          0x0004U
> > +/* not executable and sealed to prevent changing to executable. */
> > +#define MFD_NOEXEC_SEAL              0x0008U
> > +/* executable */
> > +#define MFD_EXEC             0x0010U
> >
> >  /*
> >   * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> > diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> > index f4f8cb0435b4..71dd9b0a0f62 100644
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -110,6 +110,10 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> >       ns->ucounts = ucounts;
> >       ns->pid_allocated = PIDNS_ADDING;
> >
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > +     ns->memfd_noexec_scope = MEMFD_NOEXEC_SCOPE_EXEC;
> > +#endif
>
> I think this should be inherited from the parent pid namespace instead?
>
OK, I will add logic to make the child name space to inherit from the
parent namespace at creation time,
but if the parent changes this setting later, the child will not pick
up the parent's change automatically, would that be OK ?

Or do we want the child to keep in sync with the parent, to the
highest value. For example,
if init namespace val=1, child namespace=1, later when init namespace
= 2, child namespace will automatically become 2.

Jeff

> > +
> >       return ns;
> >
> >  out_free_idr:
> > @@ -255,6 +259,45 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> >       return;
> >  }
> >
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > +int pid_mfd_noexec_dointvec_minmax(struct ctl_table *table, int write,
> > +     void *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +     struct pid_namespace *ns = task_active_pid_ns(current);
> > +     struct ctl_table table_copy;
> > +
> > +     if (write && !capable(CAP_SYS_ADMIN))
> > +             return -EPERM;
> > +
> > +     table_copy = *table;
> > +     if (ns != &init_pid_ns)
> > +             table_copy.data = &ns->memfd_noexec_scope;
> > +
> > +     /*
> > +      * set minimum to current value, the effect is only bigger
> > +      * value is accepted.
> > +      */
> > +     if (*(int *)table_copy.data > *(int *)table_copy.extra1)
> > +             table_copy.extra1 = table_copy.data;
>
> Yeah, I like this kind of enforcement.
>
> > +
> > +     return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
> > +}
> > +
> > +static struct ctl_table pid_ns_ctl_table_vm[] = {
> > +     {
> > +             .procname       = "memfd_noexec",
> > +             .data           = &init_pid_ns.memfd_noexec_scope,
> > +             .maxlen         = sizeof(init_pid_ns.memfd_noexec_scope),
> > +             .mode           = 0644,
> > +             .proc_handler   = pid_mfd_noexec_dointvec_minmax,
> > +             .extra1         = SYSCTL_ZERO,
> > +             .extra2         = SYSCTL_TWO,
> > +     },
> > +     { }
> > +};
> > +static struct ctl_path vm_path[] = { { .procname = "vm", }, { } };
> > +#endif
> > +
> >  #ifdef CONFIG_CHECKPOINT_RESTORE
> >  static int pid_ns_ctl_handler(struct ctl_table *table, int write,
> >               void *buffer, size_t *lenp, loff_t *ppos)
> > @@ -455,6 +498,10 @@ static __init int pid_namespaces_init(void)
> >  #ifdef CONFIG_CHECKPOINT_RESTORE
> >       register_sysctl_paths(kern_path, pid_ns_ctl_table);
> >  #endif
> > +
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > +     register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
> > +#endif
> >       return 0;
> >  }
> >
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 4ebeab94aa74..69e897dea6d5 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/hugetlb.h>
> >  #include <linux/shmem_fs.h>
> >  #include <linux/memfd.h>
> > +#include <linux/pid_namespace.h>
> >  #include <uapi/linux/memfd.h>
> >
> >  /*
> > @@ -263,12 +264,13 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
> >  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
> >  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
> >
> > -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> > +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
> >
> >  SYSCALL_DEFINE2(memfd_create,
> >               const char __user *, uname,
> >               unsigned int, flags)
> >  {
> > +     struct pid_namespace *ns;
> >       unsigned int *file_seals;
> >       struct file *file;
> >       int fd, error;
> > @@ -285,6 +287,36 @@ SYSCALL_DEFINE2(memfd_create,
> >                       return -EINVAL;
> >       }
> >
> > +     /* Invalid if both EXEC and NOEXEC_SEAL are set.*/
> > +     if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
> > +             return -EINVAL;
> > +
> > +     if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> > +#ifdef CONFIG_SYSCTL
> > +             int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
> > +
> > +             ns = task_active_pid_ns(current);
> > +             if (ns)
> > +                     sysctl = ns->memfd_noexec_scope;
> > +
> > +             if (sysctl == MEMFD_NOEXEC_SCOPE_EXEC) {
> > +                     flags |= MFD_EXEC;
> > +             } else if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL) {
> > +                     flags |= MFD_NOEXEC_SEAL;
> > +             } else {
> > +                     pr_warn_ratelimited(
> > +                             "memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d\n",
> > +                             task_pid_nr(current));
> > +                     return -EINVAL;
> > +             }
>
> Not a huge deal, but the above could be a switch statement to improve
> readability.
>
> > +#else
> > +             flags |= MFD_EXEC;
> > +#endif
> > +             pr_warn_ratelimited(
> > +                     "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d\n",
> > +                     task_pid_nr(current));
>
> Perhaps include process name as well -- makes admin lives easier. :)
>
>                 pr_warn_ratelimited(
>                         "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL: %s[%d]\n",
>                         current->comm, task_pid_nr(current));
>
> > +     }
> > +
> >       /* length includes terminating zero */
> >       len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
> >       if (len <= 0)
> > @@ -328,7 +360,15 @@ SYSCALL_DEFINE2(memfd_create,
> >       file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> >       file->f_flags |= O_LARGEFILE;
> >
> > -     if (flags & MFD_ALLOW_SEALING) {
> > +     if (flags & MFD_NOEXEC_SEAL) {
> > +             struct inode *inode = file_inode(file);
> > +
> > +             inode->i_mode &= ~0111;
> > +             file_seals = memfd_file_seals_ptr(file);
> > +             *file_seals &= ~F_SEAL_SEAL;
> > +             *file_seals |= F_SEAL_EXEC;
> > +     } else if (flags & MFD_ALLOW_SEALING) {
> > +             /* MFD_EXEC and MFD_ALLOW_SEALING are set */
> >               file_seals = memfd_file_seals_ptr(file);
> >               *file_seals &= ~F_SEAL_SEAL;
> >       }
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
> >
>
> Otherwise, looks good to me.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
