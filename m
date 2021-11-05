Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3346544696F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 21:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhKEUNA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 16:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhKEUNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 16:13:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED8C061205
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 13:10:20 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id i26so16797782ljg.7
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xctl1x0wAPIpZlnq6f38f2NZp6soUETgtNqOArwJJzM=;
        b=S901sIe1SJGG93aoKfsS855Gm77PThXsiZdupcnF8NawwhnX20BnCJNfQRT7I0TxMO
         7NcAAYhXDHJaMszjR1y7zPAZkWv7APWLkT8ZjLXDov83/KLwmoy6vSVUnhLxm7eKCBnK
         dnez262baGeTrvWDGsfHLH47V/gt1WwLxxsskLRbr4mPEUnmM1M9YLeaTXMjsmUhfvD0
         zPTBNTsyQG9JU5oXRLaS2d/xgnmCgHpaUo+yg0DZFT3D9+wtTukXpxUdHVEFlOneVsvW
         exrKtYaaOXZXXs6rOfxP6fuZjnNVZy5PAbZCtFKzOZ6w4c1y9/WRhoYskeoMslhytMZF
         qKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xctl1x0wAPIpZlnq6f38f2NZp6soUETgtNqOArwJJzM=;
        b=BCYN4xz3yvpxpFSiWxFafE6k2AcgofeKFFDzWmAGa/dqpVzqC7deu1++WPoZ357UWK
         CjquiFduyDc28Y4mItphnyHEUfOfY3kBTixuomFoBwKv8qISAYyQJm1r3FWq+2B2Nt58
         QE4J6+lSyePtsB+PIeAFgmx/5DhQVocoL9/TLMmU8tc0vyontCV6XvZKRcjg6sfU7pfX
         mgyPK4XKjI1GXYfC6cLpe8h4tjvlIUinceaGNgAuSANgKcYQ7zdZU4aTljykSdbJgILz
         UMgT0n7IZp4Yaa/mjVno+ozcq1EftaE5Vg2ytLT9IoSR86ZoQqG5huaEtpBXnoWZwkLp
         Aqhg==
X-Gm-Message-State: AOAM5331GcXplepxVRCoNj3b2qHQq4Iqyk7CyKSeCIUlY9PXjrWAC1nG
        lLBBdXjRmX3d0R6TV3XB4J86jqupI0fIXAImf/kDYA==
X-Google-Smtp-Source: ABdhPJz/pNuybxTziHGrKEHQAev7MHrqaTDzXDbZbR+tropi2HXYuNyxDQQ0qclanKRlpwBlP0UbmMJgxcTUW8EHNBU=
X-Received: by 2002:a2e:834b:: with SMTP id l11mr31087388ljh.339.1636143017849;
 Fri, 05 Nov 2021 13:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211105162530.3307666-1-anders.roxell@linaro.org>
In-Reply-To: <20211105162530.3307666-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:10:07 -0700
Message-ID: <CAKwvOd=zLuKqo__MyKYdftMgM1Y9K68ppSddokHunrw1Y5qfuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: cgroup: build error multiple outpt files
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, christian@brauner.io, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Andrew Delgadillo <adelg@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 9:25 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/cgroup: with clang the following error are seen:

Thanks for the patches!

typo in subject/oneline, and the `:` above can be dropped.

Andrew reported similar failures throughout selftests:
https://lore.kernel.org/linux-kselftest/20211005222739.2491124-1-adelg@google.com/

Both patches touch the same part of tools/testing/selftests/lib.mk.
This approach looks cleaner to me, but it should reconcile the changes
to tools/testing/selftests/filesystems/binderfs/Makefile that Andrew
made in the link above.

>
> clang -Wall -pthread    test_memcontrol.c cgroup_util.c ../clone3/clone3_selftests.h  -o /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol
> clang: error: cannot specify -o when generating multiple output files
> make[3]: *** [../lib.mk:146: /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol] Error 1
>
> Rework to add the header files to LOCAL_HDRS before including ../lib.mk,
> since the dependency is evaluated in '$(OUTPUT)/%:%.c $(LOCAL_HDRS)' in
> file lib.mk.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/cgroup/Makefile | 12 +++++++-----
>  tools/testing/selftests/lib.mk          |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> index 59e222460581..745fe25fa0b9 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -11,10 +11,12 @@ TEST_GEN_PROGS += test_core
>  TEST_GEN_PROGS += test_freezer
>  TEST_GEN_PROGS += test_kill
>
> +LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
> +
>  include ../lib.mk
>
> -$(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
> -$(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
> -$(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
> -$(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
> -$(OUTPUT)/test_kill: cgroup_util.c ../clone3/clone3_selftests.h ../pidfd/pidfd.h
> +$(OUTPUT)/test_memcontrol: cgroup_util.c
> +$(OUTPUT)/test_kmem: cgroup_util.c
> +$(OUTPUT)/test_core: cgroup_util.c
> +$(OUTPUT)/test_freezer: cgroup_util.c
> +$(OUTPUT)/test_kill: cgroup_util.c
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index fe7ee2b0f29c..a40add31a2e3 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -141,7 +141,7 @@ endif
>  # Selftest makefiles can override those targets by setting
>  # OVERRIDE_TARGETS = 1.
>  ifeq ($(OVERRIDE_TARGETS),)
> -LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
> +LOCAL_HDRS += $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
>  $(OUTPUT)/%:%.c $(LOCAL_HDRS)
>         $(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
>
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
