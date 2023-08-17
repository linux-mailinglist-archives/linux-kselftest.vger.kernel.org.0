Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6657477FB4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353383AbjHQPze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353469AbjHQPz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 11:55:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E32B30E9
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 08:54:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76d1dc1ebfdso51486185a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692287693; x=1692892493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdyk/H9C92iJ/nBsFz7KxfsAvK+nt2wqCERHewxGWDU=;
        b=cSQl7yt9otQXr+oR1mB0nAUMSggLBbl+x+yeuUh1BRvaPLY+5BVUHA9XY5vpaXnLwQ
         I+HaTYsLWZHnC7qtaOHGmjwLl2/5BHmdv59N00yHP6YIcH7jJklGoMStSDd1TVKHohCi
         pampRnwpD239s80gaLdHchFzC+a0w1oyAyFF1jWVzncrcQ0lgekpayKIU84Rd1wDjF4I
         2/9khJ3u2ek6tzpqBd6IcgbZJC/89kWqNXeD8h1HeTAz3F/rP/W+L+zXszK4BEOLJ0b4
         3bbWj4Gz0sm0DQOMRz2udncq5GAXL9t8Thff9BLCqlRWq9CksSuetZI7++mKz8RzoAHd
         WVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692287693; x=1692892493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdyk/H9C92iJ/nBsFz7KxfsAvK+nt2wqCERHewxGWDU=;
        b=Jc8ylrW6E9wxL+Xq8PirUfWTQ49yQ1a0EMEUHPxmViVhhIHzP2XIIYDa8wlmJNKpuL
         kde1fLb9rHyMOeRLAiDqx72TUvIrAGnIS7xbwEaHpjmHGegEPxVqCJlfDkmRXkQeznj/
         AZrd4f95aCNH8M0qNm2OWGzb077o9nEV+dwJN3AvrQkXKu19V9HAD5R8pIV75L6+3Y7S
         OLJHDaH39mCw4+rlMaGyAnEzc1zo+mhK9q+eGAeihvqGXedMkAJQTpUF+IJ4jDGCmUZH
         Osnv0Kj9SHPJZA3DbiIN7JrJmz0Eh+OHKjZZ17Bc7e9ts1TL2UBkNJUqYtsjFK14zAUv
         MryA==
X-Gm-Message-State: AOJu0Yw0gFJtSteAXPzRHF422a0hFdTP+Csrn7f2sROTvbV5f0PhVgMO
        OYE4TmDdTwQXK15ZWg1n9ym71jN7OtyuwtpsiR/w/7JrKwZ2KfbRVGXmaw==
X-Google-Smtp-Source: AGHT+IHBoKIXOzw8g/P24SXKwipUqCn2o2dUKOdGE5ZCNm3euEjtUFmlPq+7vYSmTIjnuxYVtNffFqtgOHvxVmtNMww=
X-Received: by 2002:a0c:e094:0:b0:61b:65f4:2a15 with SMTP id
 l20-20020a0ce094000000b0061b65f42a15mr4345292qvk.12.1692287692656; Thu, 17
 Aug 2023 08:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
In-Reply-To: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Aug 2023 08:54:41 -0700
Message-ID: <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com>
Subject: Re: landlock: fs_test: fs_test.c:4524:9: error: initializer element
 is not a compile-time constant
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Richard Weinberger <richard@nod.at>
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

On Thu, Aug 17, 2023 at 3:51=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While building selftests landlock following warnings / errors noticed on =
the
> Linux next with clang-17.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build errors:
> ------------
> landlock/fs_test
> fs_test.c:4524:9: error: initializer element is not a compile-time consta=
nt

Hi Naresh,
Can you tell me more about your specific version of clang-17?

I believe a fix of mine to clang should address this. It landed in
clang-18, and was backported to clang-17 recently.
https://github.com/llvm/llvm-project-release-prs/commit/0b2d5b967d983757938=
97295d651f58f6fbd3034

I suspect your clang-17 might need a rebuild.  Thanks for the report.

>  4524 |         .mnt =3D mnt_tmp,
>       |                ^~~~~~~
> 1 error generated.
>
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7e=
RU4UUygecrDx/
>
> Steps to reproduce:
> tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7A=
aypfY7eRU4UUygecrDx/config
> LLVM=3D1 LLVM_IAS=3D1 dtbs dtbs-legacy headers kernel kselftest modules
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>


--=20
Thanks,
~Nick Desaulniers
