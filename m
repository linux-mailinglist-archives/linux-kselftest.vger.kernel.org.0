Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA47816DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Aug 2023 04:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbjHSCv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 22:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbjHSCvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 22:51:01 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD94223;
        Fri, 18 Aug 2023 19:50:59 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RSNXZ4RVqz9skw;
        Sat, 19 Aug 2023 04:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692413454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fhTlw/KDqyUanTjcoZxqJpm0Dm5mWvJoRAWn5g99i9Q=;
        b=KaQmHEg9LbsvEytLoH9O5QzW7WwwCyvMfgmDFD87x6WhtAgb8utIhO1DdQgtwvMZP/BQ9v
        g4BpSHZsZkRwzWBUPe3DjxbA+iRmLhs7fJvj0l0TdPs7BKGyfZKZ4tnHb2/0fZfUtGgfBF
        KUlGYs4G7gfXBXD+xuZDx6hSHuLpPgRmSqCp6NP67T3mvwJjGKQRM2jade7vbRPXDf15nz
        4iZn/u9OF0+OplD2GhQzYrr2Zpm/2qQxLFMTm6LjdZRB8/HrZsCx4acNGQ6JM92vpnHSO4
        8CX9ii7twfB8BX6MVeIyCmK3bkM1PuGuK7fLHI20AzeoXo+7xvLoYWG3J1YVfA==
Date:   Sat, 19 Aug 2023 12:50:39 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/5] memfd: cleanups for vm.memfd_noexec
Message-ID: <20230819.022033-joyful.ward.quirky.defender-lpHlCTglJUSs@cyphar.com>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <CALmYWFuALsM-0nxp+X552VpuPkehtUNiC84gvmgZ7A1LLqkx_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cl6uohug5kcd6xoo"
Content-Disposition: inline
In-Reply-To: <CALmYWFuALsM-0nxp+X552VpuPkehtUNiC84gvmgZ7A1LLqkx_g@mail.gmail.com>
X-Rspamd-Queue-Id: 4RSNXZ4RVqz9skw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cl6uohug5kcd6xoo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-15, Jeff Xu <jeffxu@google.com> wrote:
> On Mon, Aug 14, 2023 at 1:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > The most critical issue with vm.memfd_noexec=3D2 (the fact that passing
> > MFD_EXEC would bypass it entirely[1]) has been fixed in Andrew's
> > tree[2], but there are still some outstanding issues that need to be
> > addressed:
> >
> >  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(2) sysca=
lls
> >    because it will make it far to difficult to ever migrate. Instead it
> >    should imply MFD_EXEC.
> >
> >  * The dmesg warnings are pr_warn_once(), which on most systems means
> >    that they will be used up by systemd or some other boot process and
> >    userspace developers will never see it.
> >
> >    - For the !(flags & (MFD_EXEC | MFD_NOEXEC_SEAL)) case, outputting a
> >      rate-limited message to the kernel log is necessary to tell
> >      userspace that they should add the new flags.
> >
> >      Arguably the most ideal way to deal with the spam concern[3,4]
> >      while still prompting userspace to switch to the new flags would be
> >      to only log the warning once per task or something similar.
> >      However, adding something to task_struct for tracking this would be
> >      needless bloat for a single pr_warn_ratelimited().
> >
> >      So just switch to pr_info_ratelimited() to avoid spamming the log
> >      with something that isn't a real warning. There's lots of
> >      info-level stuff in dmesg, it seems really unlikely that this
> >      should be an actual problem. Most programs are already switching to
> >      the new flags anyway.
> >
> >    - For the vm.memfd_noexec=3D2 case, we need to log a warning for eve=
ry
> >      failure because otherwise userspace will have no idea why their
> >      previously working program started returning -EACCES (previously
> >      -EINVAL) from memfd_create(2). pr_warn_once() is simply wrong here.
> >
> >  * The racheting mechanism for vm.memfd_noexec makes it incredibly
> >    unappealing for most users to enable the sysctl because enabling it
> >    on &init_pid_ns means you need a system reboot to unset it. Given the
> >    actual security threat being protected against, CAP_SYS_ADMIN users
> >    being restricted in this way makes little sense.
> >
> >    The argument for this ratcheting by the original author was that it
> >    allows you to have a hierarchical setting that cannot be unset by
> >    child pidnses, but this is not accurate -- changing the parent
> >    pidns's vm.memfd_noexec setting to be more restrictive didn't affect
> >    children.
> >
> That is not exactly what I said though.

Sorry, I probably should've phrased this as "one of the main arguments".
In the last discussion thread we had in the v1 of this patch, it was my
impression that this was the primary sticking point.

> From ChromeOS's position,  allowing downgrade is less secure, and this
> setting was designed to be set at startup/reboot time from the very
> beginning, such that the kernel command line or as part of the
> container runtime environment (get passed to sandboxed container)

If this had been implemented as a cmdline flag, it would be completely
reasonable that you need to reboot to change it. However, it was
implemented as a sysctl and the behaviour of sysctls is that admins can
(generally) change them after they've been set -- even for
security-related sysctls such as the fs.protected_* sysctls. The only
counter-example I know if the YAMA one, and if I'm being honest I think
that behaviour is also weird.

> I understand your viewpoint,  from another distribution point of view,
>  the original design might be too restricted, so if the kernel wants
> to weigh more on ease of admin, I'm OK with your approach.
> Though it is less secure for ChromeOS - i.e. we do try to prevent
> arbitrary code execution  as much as possible, even for CAP_SYSADMIN.
> And with this change, it is less secure and one more possibility for
> us to consider.

FWIW I still think the threat model where a &init_user_ns-privileged
CAP_SYS_ADMIN process can be tricked into writing a sysctl should be
protected against by memfd_create(MFD_EXEC) doesn't really make sense
for the vast majority of systems (if any).

If ChromeOS really wants the old vm.memfd_noexec=3D2 behaviour to be
enforced, this can be done with a very simple seccomp filter. If applied
to pid1, this would also not be possible to unset without a reboot.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cl6uohug5kcd6xoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZOAt/gAKCRAol/rSt+lE
b6Y+AP0Wm/MW4iFFZsjNk1Ve8p+43R1ThqUEhy9cNUa2A+qukwD/QNnCpAY1pDe8
3IaSvk3K4nMzrVgV/bxIOy2uMvt6QQY=
=W70o
-----END PGP SIGNATURE-----

--cl6uohug5kcd6xoo--
