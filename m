Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F65783015
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjHUSPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 14:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjHUSPm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 14:15:42 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28671114
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 11:15:40 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-64b3504144cso21817016d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692641739; x=1693246539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f16g3dlm3PDplDbtrkl45zO6RDrmmDTeYGTidmrzBQ0=;
        b=JnVy9ycYPdyi6i70GY4h9cgWRRBCu1PFK2qdsvIOwnkOIqL6yV5yPaOgBlAFcZgsey
         wZq9BTY/2y0Mz054D2FiExeHpfNiaEJ1R6zu5FTGyKyHENgKEgwx+kN1ZUz0dV9GxPXy
         3RxdPczZtF+QNsR9zcapLA0COJ45oZOuD6G9rj+ladY41B6l3BfO4mLlMfOxYqO5w77R
         UxR/BSUpUdlMXS+9nHAbqqr2a7ef5Im0Gm35CJu9RVgAMaCCGOnHXk7/6wG3QGy5Mbem
         9+WWe4CdeIBov7vOa1XGLHoUDjsD+k7T9mkB0DZUYkpcMLvnjksUjXMPhWxTYYPsdUQe
         T6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641739; x=1693246539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f16g3dlm3PDplDbtrkl45zO6RDrmmDTeYGTidmrzBQ0=;
        b=OoMCXD1AhtpYW0NryDZXOTe47W1giNjCUN3qEUsV+HcMLz9CoNCIzmChld5rPNvTWQ
         pHNBnjSRUpWru2urpbGi7vrZVxKM2MRbRGtxBVjrrrLkmmTTeKegAfcEFo79cfA+n9cR
         9w91i/VxmH8nelK/2eRZmqqyLMYroAAnUdd7M0NtSo1IPzzkZmEWSpJ2RgSZj7gt7KxU
         +9nUCJpZSRXllyvOtfB9W5iab8MFhJ7VqWNg3RsfcK5nP+w4HXC6VcatyD+lyoe3NiwR
         AuP4E5Un9DvDH31LVBY9wHQ6mpGpc5raFAUgzi2CxOy9WWCk3ApKUlEbrNqReTTTWdam
         EslQ==
X-Gm-Message-State: AOJu0YwqYAz5T5qJiU4S2L6FGF9J5xfO+dz/uqRQVmxkrARmqkHtPDAY
        DaLfFtjgfOqZvO0qdsjVx4ItbNJi1oT8bDj8hzdxWw==
X-Google-Smtp-Source: AGHT+IHZJDN20DzukhtxuIQhSEd9Yr13VQln9/JtmGVrNYcDpo6lHrVJl3E0IepjoM+TAKRmiv7avS5d3deTVxlN9ak=
X-Received: by 2002:a0c:f483:0:b0:64f:4be7:b6c7 with SMTP id
 i3-20020a0cf483000000b0064f4be7b6c7mr655466qvm.4.1692641738964; Mon, 21 Aug
 2023 11:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtdRe5x=mS4Xonb+ZZsArO2o7vuNL+qJsv5DkNvcirQbA@mail.gmail.com>
In-Reply-To: <CA+G9fYtdRe5x=mS4Xonb+ZZsArO2o7vuNL+qJsv5DkNvcirQbA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Aug 2023 11:15:28 -0700
Message-ID: <CAKwvOdmMYzDNK0+un0xossc4f7-A3=EZo11VnVx5Bf0THWhhpw@mail.gmail.com>
Subject: Re: clang-17: selftests: sgx: clang: error: -z noexecstack: 'linker'
 input unused [-Werror,-Wunused-command-line-argument]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Nathan Chancellor <nathan@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
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

On Mon, Aug 21, 2023 at 6:52=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Recently we have updated the toolchain clang-17 version.
>
> While building selftests sgx following warnings / errors noticed on the
> Linux next with clang-17.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> sgx/main.o
> clang: error: -z noexecstack: 'linker' input unused
> [-Werror,-Wunused-command-line-argument]

Hi Naresh,
Thanks for the report.

I think in general for the kselftests, these aren't really
regressions; we've simply not spent the time to sit down and get them
all building.

That said, we should.

Since this isn't a recent regression, would you mind instead of
emailing the list instead file an individual issue at our issue
tracker per diagnostic identified?

https://github.com/ClangBuiltLinux/linux/issues

We are very active in tracking the progress on issues there. I would
love for you and the LKFT team to participate with us there.

https://github.com/ClangBuiltLinux/linux/issues/1698 is the meta issue
tracking the kselftest targets.

When we have a target building that regresses, then we should notify
the list, but until then I think it may be less noisy to get issues on
file.

>
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9U=
q9EFceoQd0VL/
>
> Steps to reproduce:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0TPLhjp9U=
q9EFceoQd0VL/tuxmake_reproducer.sh
>
> tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UHhSg0T=
PLhjp9Uq9EFceoQd0VL/config
> LLVM=3D1 LLVM_IAS=3D1 debugkernel cpupower headers kernel kselftest
> modules

Any chance you can extract the invocation of `make` from the above for
the bug reports?  I'm guessing

`make LLVM=3D1 debugkernel cpupower headers kernel kselftest`?
(LLVM_IAS=3D1 should be obsolete on mainline)

>
>
> --
> Linaro LKFT
> https://lkft.linaro.org



--=20
Thanks,
~Nick Desaulniers
