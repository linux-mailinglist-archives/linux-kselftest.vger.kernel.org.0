Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2EC741F30
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 06:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjF2EON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 00:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjF2EOL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 00:14:11 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D010FE
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 21:14:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a36b52b4a4so183355b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688012049; x=1690604049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFI0ylmPxIwEVqfEdxipNZjolrHgwmHjIaIurmggdCk=;
        b=lPERBNzh9oBZQ+QUplulviVjCOP/BA2YFs+vzqqvva8Lh9HBJ3T/XqpVdZVvIJCV5R
         oiUD0xCDsg8ZRy/IuoMjPMt6X0bw9U1BBP/72qABBfaPmwufk6rXtWqIwV0r5guJjFGN
         ODCSn8zVYcvXw+OlqM3CRrhAxTBJUNYWGe9PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688012049; x=1690604049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFI0ylmPxIwEVqfEdxipNZjolrHgwmHjIaIurmggdCk=;
        b=ibbZDI3lJTvp57IhAXpVhsEV/DBuEEQKMOgkOg4yEKGZuWnj+mEmMK8FXwXPufi9VO
         sQXDdysS4gkEE3rVdHsNsSFzXq3IwLLrM96DWqgwwsOccw0GegAsb4yX6mPfTBlAx27d
         V9xaLQsh/cRgVbBppEczo8dyIn2C5kdjwxD8zFJLmhu2hFX/lG6S6Zs6nw8Y3dwnY6Xn
         JlFP/U4vztAneF8kSRdW5teEHpUG6Gswr0I/6sPQ+oDRBSviD1FajEd2ncRXCy0/8jjg
         sg/njXf/Hy2Q/+NYMpUQog0a93NBF6x+o6aokLqVyO5XwLwqnT/3Mbf/YhOzWEhdgXld
         xuSQ==
X-Gm-Message-State: AC+VfDwecUwB3bx/E7TBeI+M3Q58wPNnStgDvYtecpNSSMjH6hfdvzsV
        sqUIv4BUOMGuKy5xSZ0Z9V9N+5x4Kb5lrthZ+bXldQ==
X-Google-Smtp-Source: ACHHUZ4SX0IpPrAi8VAGsBsq9P7eKVBPxCksuggGgL4DjpZRAebGQhJ6Xnawo7+AkZotPjkeDDXTPwlHAh/4d5FsqCM=
X-Received: by 2002:aca:bbc5:0:b0:3a0:54ea:e416 with SMTP id
 l188-20020acabbc5000000b003a054eae416mr2055075oif.17.1688012049129; Wed, 28
 Jun 2023 21:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221215001205.51969-1-jeffxu@google.com> <20221215001205.51969-4-jeffxu@google.com>
 <ZJwcsU0vI-nzgOB_@codewreck.org>
In-Reply-To: <ZJwcsU0vI-nzgOB_@codewreck.org>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 28 Jun 2023 21:13:58 -0700
Message-ID: <CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello.

Thank you for your email and interested in using memfd_noexec !

On Wed, Jun 28, 2023 at 4:43=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> jeffxu@chromium.org wrote on Thu, Dec 15, 2022 at 12:12:03AM +0000:
> > From: Jeff Xu <jeffxu@google.com>
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
> >         MFD_EXEC was set.
> > 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> >         MFD_NOEXEC_SEAL was set.
> > 2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
>
> So, erm, I'm a bit late to the party but I was just looking at a way of
> blocking memfd_create+exec in a container and this sounded perfect: my
> reading is that this is a security feature meant to be set for
> container's namespaces that'd totally disable something like
> memfd_create followed by fexecve (because we don't want weird binaries
> coming from who knows where to be executed on a shiny secure system),
> but. . . is this actually supposed to work?
> (see below)
>
> > [...]
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -263,12 +264,14 @@ long memfd_fcntl(struct file *file, unsigned int =
cmd, unsigned long arg)
> >  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
> >  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
> >
> > -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> > +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB |=
 MFD_NOEXEC_SEAL | MFD_EXEC)
> >
> >  SYSCALL_DEFINE2(memfd_create,
> >               const char __user *, uname,
> >               unsigned int, flags)
> >  {
> > +     char comm[TASK_COMM_LEN];
> > +     struct pid_namespace *ns;
> >       unsigned int *file_seals;
> >       struct file *file;
> >       int fd, error;
> > @@ -285,6 +288,39 @@ SYSCALL_DEFINE2(memfd_create,
> >                       return -EINVAL;
> >       }
> >
> > +     /* Invalid if both EXEC and NOEXEC_SEAL are set.*/
> > +     if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
> > +             return -EINVAL;
> > +
> > +     if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> > +             [code that checks the sysctl]
>
> If flags already has either MFD_EXEC or MFD_NOEXEC_SEAL, you don't check
> the sysctl at all.
>
> This can be verified easily:
> -----
> $ cat > memfd_exec.c <<'EOF'
> #define _GNU_SOURCE
>
> #include <errno.h>
> #include <stdio.h>
> #include <sys/mman.h>
> #include <sys/types.h>
> #include <sys/wait.h>
>
> #ifndef MFD_EXEC
> #define MFD_EXEC                0x0010U
> #endif
>
> int main() {
>     int fd =3D memfd_create("script", MFD_EXEC);
>     if (fd =3D=3D -1)l
>         perror("memfd");
>
>     char prog[] =3D "#!/bin/sh\necho Ran script\n";
>     if (write(fd, prog, sizeof(prog)-1) !=3D sizeof(prog)-1)
>             perror("write");
>
>     char *const argv[] =3D { "script", NULL };
>     char *const envp[] =3D { NULL };
>     fexecve(fd, argv, envp);
>     perror("fexecve");
> }
> EOF
> $ gcc -o memfd_exec memfd_exec.c
> $ ./memfd_exec
> Ran script
> $ sysctl vm.memfd_noexec
> vm.memfd_noexec =3D 2
> -----
> (as opposed to failing hard on memfd_create if flag unset on sysctl=3D2,
> and failing on fexecve with flag unset and sysctl=3D1)
>
> What am I missing?
>
>
At one point, I was thinking of having a security hook to block
executable memfd [1], so this sysctl only works for the application
that doesn't set EXEC bit. Now I think it makes sense to use
vm.memfd_noexec =3D 2 to block the MFD_EXEC also.
Anyway the commit msg says:
2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
Not doing that is a bug. I will send a fix for that.

[1] https://lore.kernel.org/lkml/20221206150233.1963717-7-jeffxu@google.com=
/

>
> BTW I find the current behaviour rather hard to use: setting this to 2
> should still set NOEXEC by default in my opinion, just refuse anything
> that explicitly requested EXEC.
>
At one point [2] (v2 of patch) there were two sysctls, one is doing
overwrite, one is enforcing, later I decided with one sysctl, the
rationale is the kernel will eventually get out of the business of
overwriting user space code.  Yes. It might take a long time to
migrate all of the userspace.

In the meantime,  to meet what you want, the solution is keep
vm.memfd_noexec =3D 1 (for overwrite), and a new security policy
(SELInux or Landlock) that uses security hook security_memfd_create,
this can block one process from creating executable memfd. Indeed,
security policy is better fit to cases like this than sysctl.

[2] https://lore.kernel.org/linux-mm/CABi2SkWGo9Jrd=3Di1e2PoDWYGenGhR=3DpG=
=3DyGsQP5VLmizTmg-iA@mail.gmail.com/

> Sure there's a warn_once that memfd_create was used without seal, but
> right now on my system it's "used up" 5 seconds after boot by systemd:
> [    5.854378] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=
=3D1 'systemd'
>
> And anyway, older kernels will barf up EINVAL when calling memfd_create
> with MFD_NOEXEC_SEAL, so even if userspace will want to adapt they'll
> need to try calling memfd_create with the flag once and retry on EINVAL,
> which let's face it is going to take a while to happen.
> (Also, the flag has been added to glibc, but not in any release yet)
>
Yes. Application will need to do some detection of the kernel. This is
not avoidable.

> Making calls default to noexec AND refuse exec does what you want
> (forbid use of exec in an app that wasn't in a namespace that allows
> exec) while allowing apps that require it to work; that sounds better
> than making all applications that haven't taken the pain of adding the
> new flag to me.
> Well, I guess an app that did require exec without setting the flag will
> fail in a weird place instead of failing at memfd_create and having a
> chance to fallback, so it's not like it doesn't make any sense;
> I don't have such strong feelings about this if the sysctl works, but
> for my use case I'm more likely to want to take a chance at memfd_create
> not needing exec than having the flag set. Perhaps a third value if I
> cared enough...
>
> --
> Dominique Martinet | Asmadeus

Thanks
-Jeff
