Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C303A708D47
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 03:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjESBW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 21:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjESBWY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 21:22:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15059171E
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:22:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f423c17bafso29175e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684459320; x=1687051320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqVmcIUSI4Xw+jP09wSJXm4OiN2hCwHu9FnNFUiMdYo=;
        b=wEdgpcJ7Dj3UtTNIU2HlM1dn84V1NZeOPc9e5NTTZ9Qn8Ec7oCYJok2TaVM4qFxyRM
         FbcmfZ9z2gaRNvuKFS2K8atqsFjmPb2UE2b0ugJLBPHiSjwFZgv5e6KPjpBEIq8m8afm
         XJHV0AN3KeoKo4bZoTm14Q1q8fo6IEKrrGU8fpXh6lu+6jeIuuAX/nECVHVPC9b3mlK3
         ym1FsB2/o21Em8ybiFGt4mpC7RspE4ILcTv8bq64xXEA4gccNf8v5xfOp1bGvPOWJl0v
         iSuFttY/MFvWUYEG0bu9PDAsRNQXBKlE1hQDE8ckKFe8niEpj9AyfVYkSUuvzNuYMhZw
         Fbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459320; x=1687051320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqVmcIUSI4Xw+jP09wSJXm4OiN2hCwHu9FnNFUiMdYo=;
        b=TlisAZLyzXN9cjXiIgBHAzUQlD/aXx5KSs0PXev368mG7juUow1/ug50FeZLJwwbA1
         EwUh7p+bItR4mBAD8mNrKnnBSjRIgm2pxSZGgyY9Krot4jufbzfB7rh8FdeyO5eHsLPD
         u/j4IDa9uV5qaxowOA2G2gvEk6j+RVfN7uVzUP125NmduCvFFlpTtNRFOsvW7a4Gqovr
         IHhj9GFtSX6yaJ9lKbnUtP9ZTU85Gak0l0nARpokFAQ4/Wmt7UpudJLSlVsm1A9byGBe
         WuGWbeQDV5g+aOsmNbaZYPvwbqBp+m7BN7nh/fn3WaLs11TNukjobfHgpYRRMjVpVi9+
         HGXA==
X-Gm-Message-State: AC+VfDyyJEAVcnbfgimG9Q8IMg2MQtYTbZMHKUg8txDCQmvfmLyNQXde
        KW16fabor/m9g0wJHHuFV7aHSiks0qa6ejikk7FgTw==
X-Google-Smtp-Source: ACHHUZ7M3/IbFNzSZ64MwfOjccnIXsHjJKpFlglqiau7g+2UhDxPQvtvdYUvEozRiR7XUuS8QbUg7zk5NYucG8i726c=
X-Received: by 2002:a05:600c:4994:b0:3f1:758c:dd23 with SMTP id
 h20-20020a05600c499400b003f1758cdd23mr89382wmp.7.1684459320145; Thu, 18 May
 2023 18:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230519011915.846407-1-jeffxu@chromium.org>
In-Reply-To: <20230519011915.846407-1-jeffxu@chromium.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 18 May 2023 18:21:24 -0700
Message-ID: <CALmYWFvk8mbx4JSddRnHVZ0EmeZKKA7gKMa2zsVkJ4GWcCMcLw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     jeffxu@chromium.org
Cc:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
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

This is updating code comments from v0.
There are on-going discussions related to threat-model and io_uring
which we can use the V0 thread.

On Thu, May 18, 2023 at 6:19=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> This is the first set of Memory mapping (VMA) protection patches using PK=
U.
>
> * * *
>
> Background:
>
> As discussed previously in the kernel mailing list [1], V8 CFI [2] uses
> PKU to protect memory, and Stephen R=C3=B6ttger proposes to extend the PK=
U to
> memory mapping [3].
>
> We're using PKU for in-process isolation to enforce control-flow integrit=
y
> for a JIT compiler. In our threat model, an attacker exploits a
> vulnerability and has arbitrary read/write access to the whole process
> space concurrently to other threads being executed. This attacker can
> manipulate some arguments to syscalls from some threads.
>
> Under such a powerful attack, we want to create a =E2=80=9Csafe/isolated=
=E2=80=9D
> thread environment. We assign dedicated PKUs to this thread,
> and use those PKUs to protect the threads=E2=80=99 runtime environment.
> The thread has exclusive access to its run-time memory. This
> includes modifying the protection of the memory mapping, or
> munmap the memory mapping after use. And the other threads
> won=E2=80=99t be able to access the memory or modify the memory mapping
> (VMA) belonging to the thread.
>
> * * *
>
> Proposed changes:
>
> This patch introduces a new flag, PKEY_ENFORCE_API, to the pkey_alloc()
> function. When a PKEY is created with this flag, it is enforced that any
> thread that wants to make changes to the memory mapping (such as mprotect=
)
> of the memory must have write access to the PKEY. PKEYs created without
> this flag will continue to work as they do now, for backwards
> compatibility.
>
> Only PKEY created from user space can have the new flag set, the PKEY
> allocated by the kernel internally will not have it. In other words,
> ARCH_DEFAULT_PKEY(0) and execute_only_pkey won=E2=80=99t have this flag s=
et,
> and continue work as today.
>
> This flag is checked only at syscall entry, such as mprotect/munmap in
> this set of patches. It will not apply to other call paths. In other
> words, if the kernel want to change attributes of VMA for some reasons,
> the kernel is free to do that and not affected by this new flag.
>
> This set of patch covers mprotect/munmap, I plan to work on other
> syscalls after this.
>
> * * *
>
> Testing:
>
> I have tested this patch on a Linux kernel 5.15, 6,1, and 6.4-rc1,
> new selftest is added in: pkey_enforce_api.c
>
> * * *
>
> Discussion:
>
> We believe that this patch provides a valuable security feature.
> It allows us to create =E2=80=9Csafe/isolated=E2=80=9D thread environment=
s that are
> protected from attackers with arbitrary read/write access to
> the process space.
>
> We believe that the interface change and the patch don't
> introduce backwards compatibility risk.
>
> We would like to disucss this patch in Linux kernel community
> for feedback and support.
>
> * * *
>
> Reference:
>
> [1]https://lore.kernel.org/all/202208221331.71C50A6F@keescook/
> [2]https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQ=
MyXgeaRHo/edit?usp=3Dsharing
> [3]https://docs.google.com/document/d/1qqVoVfRiF2nRylL3yjZyCQvzQaej1HRPh3=
f5wj1AS9I/edit
>
> * * *
> Current status:
>
> There are on-going discussion related to threat model, io_uring, we will =
continue discuss using v0 thread.
>
> * * *
> PATCH history:
>
> v1: update code related review comments:
> mprotect.c:
>         remove syscall from do_mprotect_pkey()
>         remove pr_warn_ratelimited
>
> munmap.c:
>         change syscall to enum caller_origin
>         remove pr_warn_ratelimited
>
> v0:
> https://lore.kernel.org/linux-mm/20230515130553.2311248-1-jeffxu@chromium=
.org/
>
> Best Regards,
> -Jeff Xu
>
>
> Jeff Xu (6):
>   PKEY: Introduce PKEY_ENFORCE_API flag
>   PKEY: Add arch_check_pkey_enforce_api()
>   PKEY: Apply PKEY_ENFORCE_API to mprotect
>   PKEY:selftest pkey_enforce_api for mprotect
>   PKEY: Apply PKEY_ENFORCE_API to munmap
>   PKEY:selftest pkey_enforce_api for munmap
>
>  arch/powerpc/include/asm/pkeys.h              |   19 +-
>  arch/x86/include/asm/mmu.h                    |    7 +
>  arch/x86/include/asm/pkeys.h                  |   92 +-
>  arch/x86/mm/pkeys.c                           |    2 +-
>  include/linux/mm.h                            |    8 +-
>  include/linux/pkeys.h                         |   18 +-
>  include/uapi/linux/mman.h                     |    5 +
>  mm/mmap.c                                     |   31 +-
>  mm/mprotect.c                                 |   17 +-
>  mm/mremap.c                                   |    6 +-
>  tools/testing/selftests/mm/Makefile           |    1 +
>  tools/testing/selftests/mm/pkey_enforce_api.c | 1312 +++++++++++++++++
>  12 files changed, 1499 insertions(+), 19 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/pkey_enforce_api.c
>
>
> base-commit: ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab
> --
> 2.40.1.606.ga4b1b128d6-goog
>
