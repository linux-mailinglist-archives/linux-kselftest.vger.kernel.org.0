Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C62477D9B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 07:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbjHPFJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 01:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbjHPFJe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 01:09:34 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E551BD4
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 22:09:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a47e8e38dso125171cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 22:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692162571; x=1692767371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWYw8V7xEm9ZxKzv65n28jlWR3dMIFktpfCljWRtgVw=;
        b=GcIFyrj/ggB6oJDZSePiyLgPx6rtBBCftDf5qEB/y2PfHEaSZwVgRAFk717Vq7viPz
         4E/+eU3jWbqx2pUIsjWtHjjGeU1z7VYZBu0FDSnoUwDCTJVB6dxlytG671GLoTkFUv50
         mgyvJefV+5iwQw8xGNZ6hJdicXkoGuwVzG3gOuCIwQCpKEZSZ76ygOiEk1jQ8CSt5SLu
         VbAnN0GG5oX1AVK/AEBJZJ70EUKSnJaU2uwhXJ2P2loifrUXhyHCwVPorwg/X8L5wSC9
         nNpnLfN91lFvY+SSE82EZtBEdr8ZwvPJNfBJum4yjh5DVEuSC6hFQ/ViTiCcFQts8V0S
         DMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692162571; x=1692767371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWYw8V7xEm9ZxKzv65n28jlWR3dMIFktpfCljWRtgVw=;
        b=fULF7VbIIlk18ZcxF4Mih9mRSxzYf6bqI29rSKpfWt76OLLnSZTAD7yD1LZiO9ZhAP
         SYyOp6rm1lwQ8pX0Uxu+E61qzfKIgnCxOTyDphFK80EfVN37N3j9C1jzyDi2/1szKt0h
         KgEAmoNAcnW0dnyCGlRHF7j9vQgg3Hk1PiombusG4rv30Q/1SwMMFwnZCKhStpBt5pdJ
         10hYF7SYx88FpAQc22WkSp1ygUF7rTNFOS+HLb9fsY0jBryXwie6QkBPomJohTL7WtJQ
         z+PDFgfPDJdOHKtorPfAwMvNabcg27flnhmRiomqFxqlmIq37DD12FKde7WBIaM1E1ia
         yJEQ==
X-Gm-Message-State: AOJu0YwD5H1u9V0jJ76Zwg85FApJKQwYSTvfKSn/X+4PuwqqiWdlu2Nm
        XWPDAhAGz5QRcjrJ9f2KRaNlOFMm1t4dGSZqXwOkgg==
X-Google-Smtp-Source: AGHT+IEApM/HrVBOBFUDcS71XBKU9AMFPQfP6BMa03FaPq3RB+bSh3eaqt1r6H0QW8Gx2soPN3AzokmVW8dGTIkNeN8=
X-Received: by 2002:ac8:59c4:0:b0:410:385c:d1d9 with SMTP id
 f4-20020ac859c4000000b00410385cd1d9mr108035qtf.25.1692162570997; Tue, 15 Aug
 2023 22:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 15 Aug 2023 22:08:54 -0700
Message-ID: <CALmYWFuALsM-0nxp+X552VpuPkehtUNiC84gvmgZ7A1LLqkx_g@mail.gmail.com>
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

On Mon, Aug 14, 2023 at 1:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> The most critical issue with vm.memfd_noexec=3D2 (the fact that passing
> MFD_EXEC would bypass it entirely[1]) has been fixed in Andrew's
> tree[2], but there are still some outstanding issues that need to be
> addressed:
>
>  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(2) syscall=
s
>    because it will make it far to difficult to ever migrate. Instead it
>    should imply MFD_EXEC.
>
>  * The dmesg warnings are pr_warn_once(), which on most systems means
>    that they will be used up by systemd or some other boot process and
>    userspace developers will never see it.
>
>    - For the !(flags & (MFD_EXEC | MFD_NOEXEC_SEAL)) case, outputting a
>      rate-limited message to the kernel log is necessary to tell
>      userspace that they should add the new flags.
>
>      Arguably the most ideal way to deal with the spam concern[3,4]
>      while still prompting userspace to switch to the new flags would be
>      to only log the warning once per task or something similar.
>      However, adding something to task_struct for tracking this would be
>      needless bloat for a single pr_warn_ratelimited().
>
>      So just switch to pr_info_ratelimited() to avoid spamming the log
>      with something that isn't a real warning. There's lots of
>      info-level stuff in dmesg, it seems really unlikely that this
>      should be an actual problem. Most programs are already switching to
>      the new flags anyway.
>
>    - For the vm.memfd_noexec=3D2 case, we need to log a warning for every
>      failure because otherwise userspace will have no idea why their
>      previously working program started returning -EACCES (previously
>      -EINVAL) from memfd_create(2). pr_warn_once() is simply wrong here.
>
>  * The racheting mechanism for vm.memfd_noexec makes it incredibly
>    unappealing for most users to enable the sysctl because enabling it
>    on &init_pid_ns means you need a system reboot to unset it. Given the
>    actual security threat being protected against, CAP_SYS_ADMIN users
>    being restricted in this way makes little sense.
>
>    The argument for this ratcheting by the original author was that it
>    allows you to have a hierarchical setting that cannot be unset by
>    child pidnses, but this is not accurate -- changing the parent
>    pidns's vm.memfd_noexec setting to be more restrictive didn't affect
>    children.
>
That is not exactly what I said though.
From ChromeOS's position,  allowing downgrade is less secure, and this
setting was designed to be set at startup/reboot time from the very
beginning, such that the kernel command line or as part of the
container runtime environment (get passed to sandboxed container)
I understand your viewpoint,  from another distribution point of view,
 the original design might be too restricted, so if the kernel wants
to weigh more on ease of admin, I'm OK with your approach.
Though it is less secure for ChromeOS - i.e. we do try to prevent
arbitrary code execution  as much as possible, even for CAP_SYSADMIN.
And with this change, it is less secure and one more possibility for
us to consider.




>    Instead, switch the vm.memfd_noexec sysctl to be properly
>    hierarchical and allow CAP_SYS_ADMIN users (in the pidns's owning
>    userns) to lower the setting as long as it is not lower than the
>    parent's effective setting. This change also makes it so that
>    changing a parent pidns's vm.memfd_noexec will affect all
>    descendants, providing a properly hierarchical setting. The
>    performance impact of this is incredibly minimal since the maximum
>    depth of pidns is 32 and it is only checked during memfd_create(2)
>    and unshare(CLONE_NEWPID).
>
>  * The memfd selftests would not exit with a non-zero error code when
>    certain tests that ran in a forked process (specifically the ones
>    related to MFD_EXEC and MFD_NOEXEC_SEAL) failed.
>
> [1]: https://lore.kernel.org/all/ZJwcsU0vI-nzgOB_@codewreck.org/
> [2]: https://lore.kernel.org/all/20230705063315.3680666-1-jeffxu@google.c=
om/
> [3]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
> [4]: https://lore.kernel.org/f185bb42-b29c-977e-312e-3349eea15383@linuxfo=
undation.org/
>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> Changes in v2:
> - Make vm.memfd_noexec restrictions properly hierarchical.
> - Allow vm.memfd_noexec setting to be lowered by CAP_SYS_ADMIN as long
>   as it is not lower than the parent's effective setting.
> - Fix the logging behaviour related to the new flags and
>   vm.memfd_noexec=3D2.
> - Add more thorough tests for vm.memfd_noexec in selftests.
> - v1: <https://lore.kernel.org/r/20230713143406.14342-1-cyphar@cyphar.com=
>
>
> ---
> Aleksa Sarai (5):
>       selftests: memfd: error out test process when child test fails
>       memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=
=3D2
>       memfd: improve userspace warnings for missing exec-related flags
>       memfd: replace ratcheting feature from vm.memfd_noexec with hierarc=
hy
>       selftests: improve vm.memfd_noexec sysctl tests
>
>  include/linux/pid_namespace.h              |  39 ++--
>  kernel/pid.c                               |   3 +
>  kernel/pid_namespace.c                     |   6 +-
>  kernel/pid_sysctl.h                        |  28 ++-
>  mm/memfd.c                                 |  33 ++-
>  tools/testing/selftests/memfd/memfd_test.c | 332 +++++++++++++++++++++++=
------
>  6 files changed, 322 insertions(+), 119 deletions(-)
> ---
> base-commit: 3ff995246e801ea4de0a30860a1d8da4aeb538e7
> change-id: 20230803-memfd-vm-noexec-uapi-fixes-ace725c67b0f
>
> Best regards,
> --
> Aleksa Sarai <cyphar@cyphar.com>
>
