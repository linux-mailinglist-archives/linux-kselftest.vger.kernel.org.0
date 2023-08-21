Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C289C7830C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHUTFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHUTFs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 15:05:48 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CB1B7
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 12:05:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40a47e8e38dso54941cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692644734; x=1693249534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=590/UzQEybat9jvi9JGXsnqP5LlShojALuYttZJVkzw=;
        b=mLJCVxdEfC9JgMq29KJ2oYsUJpED5y428av1O5YJ0jU6sB+lO8HWEVpuO8nKjgg9Ml
         gUTt3y395vdJFfIxWtCcB5HMdSaz3WnSebe4uGlVJ+urQr1ywHhfgIASLr6vK+utxaI5
         Z+4FMfFRAD2wOs67xCprm2kpV/KfQ0h0fYu6n1Y9q+Ibfk8y3L5t6vCtZofwbY153cGX
         kgmSLizjQG/KlPGgIcrjNBuwcUxEpiPhijxN1aMcXZE5tI8aFmxTUlp9SJPljx25YhVI
         G8wjE1ZHZ9q9adseOfJW/eM1JAC6Im/ND/0g+m0y7I+OOF8DC2NWr/4Ab4kg9x0Ll26F
         9Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644734; x=1693249534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=590/UzQEybat9jvi9JGXsnqP5LlShojALuYttZJVkzw=;
        b=O0oRf2H+z2HvJdnKhloxY7cxz+neI337NsWGn9gAN0stKkp6lGenZpQFs/HAcZ2ULS
         7bWGi7uCxvT2UrgIJ/Leyjj3z7i0tNy7z41Co0NqAgEe24r08bECDQLj91Ld6Lr6fGsQ
         rN8GV4U9Xt0PB3oV+OeJCoTAyultrUxwKoWYZH+ZsryxpdIjbnYhiei5bEgDTAkEjt7k
         ifq2ub9Awt+TXuC/fLYQzMOUHzTeGRD9oQNJ5qjTnnq5UFD9ztA8CnwUQkLnDQr/U1qo
         LBYTu0vZhqIJLoolvHhUrqid4xLGmFNHFnftmrDRlkBLgt6D+Fs9eIThtSkF+m4VbUDf
         JeDw==
X-Gm-Message-State: AOJu0Yxx7WKB2Mo9lOVMeV9gPj8So2Oz4Ub/ejPvJSX4TO+MltmPjoqc
        8ZR9hVUveZL7bcmLVZRdtFpwy4m9YO0pNXbqLToU7Q==
X-Google-Smtp-Source: AGHT+IHWSgMuae3sAcjkJjT268HxeCbcdoOrGPQCFnFxWh5gkeDKoKc++ZSNNxE25rj8mdxOygQIECLN3qRMn8mdGK8=
X-Received: by 2002:a05:622a:1045:b0:403:affb:3c03 with SMTP id
 f5-20020a05622a104500b00403affb3c03mr51253qte.10.1692644734007; Mon, 21 Aug
 2023 12:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <CALmYWFuALsM-0nxp+X552VpuPkehtUNiC84gvmgZ7A1LLqkx_g@mail.gmail.com> <20230819.022033-joyful.ward.quirky.defender-lpHlCTglJUSs@cyphar.com>
In-Reply-To: <20230819.022033-joyful.ward.quirky.defender-lpHlCTglJUSs@cyphar.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 21 Aug 2023 12:04:57 -0700
Message-ID: <CALmYWFth21j-iHrY8dgO50jUwOSPP99yr=jLitfTGtJR8n6jVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] memfd: cleanups for vm.memfd_noexec
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 7:50=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2023-08-15, Jeff Xu <jeffxu@google.com> wrote:
> > On Mon, Aug 14, 2023 at 1:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com=
> wrote:
> > >
> > > The most critical issue with vm.memfd_noexec=3D2 (the fact that passi=
ng
> > > MFD_EXEC would bypass it entirely[1]) has been fixed in Andrew's
> > > tree[2], but there are still some outstanding issues that need to be
> > > addressed:
> > >
> > >  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(2) sys=
calls
> > >    because it will make it far to difficult to ever migrate. Instead =
it
> > >    should imply MFD_EXEC.
> > >
> > >  * The dmesg warnings are pr_warn_once(), which on most systems means
> > >    that they will be used up by systemd or some other boot process an=
d
> > >    userspace developers will never see it.
> > >
> > >    - For the !(flags & (MFD_EXEC | MFD_NOEXEC_SEAL)) case, outputting=
 a
> > >      rate-limited message to the kernel log is necessary to tell
> > >      userspace that they should add the new flags.
> > >
> > >      Arguably the most ideal way to deal with the spam concern[3,4]
> > >      while still prompting userspace to switch to the new flags would=
 be
> > >      to only log the warning once per task or something similar.
> > >      However, adding something to task_struct for tracking this would=
 be
> > >      needless bloat for a single pr_warn_ratelimited().
> > >
> > >      So just switch to pr_info_ratelimited() to avoid spamming the lo=
g
> > >      with something that isn't a real warning. There's lots of
> > >      info-level stuff in dmesg, it seems really unlikely that this
> > >      should be an actual problem. Most programs are already switching=
 to
> > >      the new flags anyway.
> > >
> > >    - For the vm.memfd_noexec=3D2 case, we need to log a warning for e=
very
> > >      failure because otherwise userspace will have no idea why their
> > >      previously working program started returning -EACCES (previously
> > >      -EINVAL) from memfd_create(2). pr_warn_once() is simply wrong he=
re.
> > >
> > >  * The racheting mechanism for vm.memfd_noexec makes it incredibly
> > >    unappealing for most users to enable the sysctl because enabling i=
t
> > >    on &init_pid_ns means you need a system reboot to unset it. Given =
the
> > >    actual security threat being protected against, CAP_SYS_ADMIN user=
s
> > >    being restricted in this way makes little sense.
> > >
> > >    The argument for this ratcheting by the original author was that i=
t
> > >    allows you to have a hierarchical setting that cannot be unset by
> > >    child pidnses, but this is not accurate -- changing the parent
> > >    pidns's vm.memfd_noexec setting to be more restrictive didn't affe=
ct
> > >    children.
> > >
> > That is not exactly what I said though.
>
> Sorry, I probably should've phrased this as "one of the main arguments".
> In the last discussion thread we had in the v1 of this patch, it was my
> impression that this was the primary sticking point.
>
> > From ChromeOS's position,  allowing downgrade is less secure, and this
> > setting was designed to be set at startup/reboot time from the very
> > beginning, such that the kernel command line or as part of the
> > container runtime environment (get passed to sandboxed container)
>
> If this had been implemented as a cmdline flag, it would be completely
> reasonable that you need to reboot to change it. However, it was

You might already know that sysctl can be set in kernel command line,
thanks to Vlastimil Babka from SUSE. [1]
[1] https://lore.kernel.org/lkml/20200325120345.12946-1-vbabka@suse.cz/

> implemented as a sysctl and the behaviour of sysctls is that admins can
> (generally) change them after they've been set -- even for
> security-related sysctls such as the fs.protected_* sysctls. The only
> counter-example I know if the YAMA one, and if I'm being honest I think
> that behaviour is also weird.
>

> > I understand your viewpoint,  from another distribution point of view,
> >  the original design might be too restricted, so if the kernel wants
> > to weigh more on ease of admin, I'm OK with your approach.
> > Though it is less secure for ChromeOS - i.e. we do try to prevent
> > arbitrary code execution  as much as possible, even for CAP_SYSADMIN.
> > And with this change, it is less secure and one more possibility for
> > us to consider.
>
> FWIW I still think the threat model where a &init_user_ns-privileged
> CAP_SYS_ADMIN process can be tricked into writing a sysctl should be
> protected against by memfd_create(MFD_EXEC) doesn't really make sense
> for the vast majority of systems (if any).
>
I agree other distributions might not care much about running
arbitrary code on the host for CAP_SYS_ADMIN, similar to traditional
unix in this aspect. ChromeOS has some unique security features.

> If ChromeOS really wants the old vm.memfd_noexec=3D2 behaviour to be
> enforced, this can be done with a very simple seccomp filter. If applied
> to pid1, this would also not be possible to unset without a reboot.
>
In practice, host and process can have different values for
vm.memfd_noexec, it can't easily be implemented through seccomp.
Seccomp also requires no-new-priv set, there are implications if we
set it to pid 1 and apply to all its children.


> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>

Thanks
Best regards,
-Jeff
