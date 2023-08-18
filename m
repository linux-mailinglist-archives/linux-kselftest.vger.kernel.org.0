Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8F7805AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 07:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbjHRF3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 01:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358080AbjHRF2n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 01:28:43 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D7D4C05
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 22:20:02 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a02252eb5dso128217241.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 22:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692335933; x=1692940733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kpLB9nUoya1zg6wDKkXayE7Tz/XHKIUeAAVe5xKhK0=;
        b=KaJjLiyhBSvhpgsm8YiFaBS8xI7UGZoG5drkaowj2GP6x3bnrlC3xOI9td0TTSOaAe
         U8CIrSHQWflISPqATW2Jo4GQiAlJPU0m/8d2f85PGndrz8aD8hfh2jAjRsTiH+CTkLXa
         m7Jyn6jzSFdoWq8Cj3ukeolSvabGfHWqd3VkCvjM329jQTuiE3+JNp4UdwbXKk2U9XJN
         +sVLZ11JcehL6jteXQVA0W10g46ms6XNkh0ocrcENaiTzXDHMmhQV2Yk2ioO5jxIIELt
         b9a3SmTagu6fnJsvmeaZRCTHEiUrhVsd+wOWsCbL+Vw6pMR3+OvW+biIoAtgD8wdZeIS
         w68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692335933; x=1692940733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kpLB9nUoya1zg6wDKkXayE7Tz/XHKIUeAAVe5xKhK0=;
        b=hv1YALQNyuK35eqiwAg8qFEZzYzOqcNexdydMuq3Xli+i6ovsUCJb7wBlnwTdp0L9Z
         TIJATemdGpSL3gEIXxjp98LhNwHh6IXPxc2CWdJzFm9JfuvO1hsDvpENT0P7iujNEz2x
         7RXwW6MeatjG+oGHk6lE/J8hfcF3hvvty2vCB2YUXrxiHYY+ZacGwkpGvOVM9jheccs6
         b3OnPWjw1WIyrF+xfJ765jgsN2VSOeTf1qJm8d2OIHbRa+mbwHcwu0UEySkplMcaJFP2
         wrnAgIvFb5fKiCgaIosM4kk3vhgFdpfX7PBRikdckUJxXHc9sOD0DVxXhNvDvVCYC1TH
         q47w==
X-Gm-Message-State: AOJu0YwKvWkI72I0vfvBqxNBa+dSJ2QrX7qP/RSvSffJvOfbysjRHMRX
        M11AvCTBpCn+PlfGVlOiWXkdadHyDtj43wtWhAvJrQ==
X-Google-Smtp-Source: AGHT+IEf2oEZW2NUvuhCzB/XQOkZOamd12TFRt7JdNd8j2TpdIAQwd5X10QtMAXKbXbUwLs+I54R8FqOfRXoI/bJsKM=
X-Received: by 2002:a67:b648:0:b0:44a:c20a:ebb1 with SMTP id
 e8-20020a67b648000000b0044ac20aebb1mr1545884vsm.13.1692335932647; Thu, 17 Aug
 2023 22:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
 <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 18 Aug 2023 10:48:41 +0530
Message-ID: <CA+G9fYtRMde7Ksswa8pY8sFgnWVN-snRHfz4YRM04HSQ4LFBZQ@mail.gmail.com>
Subject: Re: landlock: fs_test: fs_test.c:4524:9: error: initializer element
 is not a compile-time constant
To:     Nick Desaulniers <ndesaulniers@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 17 Aug 2023 at 21:24, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> On Thu, Aug 17, 2023 at 3:51=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > While building selftests landlock following warnings / errors noticed o=
n the
> > Linux next with clang-17.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build errors:
> > ------------
> > landlock/fs_test
> > fs_test.c:4524:9: error: initializer element is not a compile-time cons=
tant
>
> Hi Naresh,
> Can you tell me more about your specific version of clang-17?

    compiler:
        name: clang,
        version: 17.0.0,
        version_full: Debian clang version 17.0.0
(++20230725053429+d0b54bb50e51-1~exp1~20230725173444.1)

>
> I believe a fix of mine to clang should address this. It landed in
> clang-18, and was backported to clang-17 recently.
> https://github.com/llvm/llvm-project-release-prs/commit/0b2d5b967d9837579=
3897295d651f58f6fbd3034
>
> I suspect your clang-17 might need a rebuild.  Thanks for the report.

I will rebuild / re-test and confirm soon.

- Naresh
