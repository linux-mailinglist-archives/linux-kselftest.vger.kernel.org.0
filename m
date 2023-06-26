Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DFD73E6F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFZRx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFZRx1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 13:53:27 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91519130
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 10:53:26 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5633d6e22d3so1001685eaf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687802006; x=1690394006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn6vnK3NKWIIx8bWW3pUBU0wxmRL6bY7AP5Q2VzG4LU=;
        b=C7Kb4vfjPX0Yqwu9LdbOWEb2TQ/YoHmc5yYHKefUju3KJadAt2GJIBR7CBNt9Vsjwr
         KUqC+qrLF1vkYWRYLNvfdZfabF2e5SJtZXKCLw5bfF0pJ0vixNj5TWFF1qx7ZQRs0Gum
         RvwG4GtHz35leA1egsFL3GFBfgpqbrQRzKQ4UWS/e6iMsKoQeDHuCmxqZS+6iELmIfsZ
         V5ZpYIx133t2xbY1ROfE8hGF7DlcV3BJEPOACYPGQMYNBO76TR7Nc0kjp8x+lYrZdbJX
         /aGqCNxVslcqydAUcW+vaCXiETR9obcdnX/24M3m0Q8fvZ+rT8/Qqk8HFMRMDJIsks5e
         gEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802006; x=1690394006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn6vnK3NKWIIx8bWW3pUBU0wxmRL6bY7AP5Q2VzG4LU=;
        b=KJsYH3eNmsC3QRL/OYsHYpQoGxW96FhKlXb2pEfiS+4JLBtOhRGwFOXqzOoxEql7SL
         lmjD4PIiDnBpGB07QdnS6aH5yDcZi0T/XPcu2jxDyfFwKbCSO4R5t9g8G1lgQGaKm8NR
         6RuuhRnHpCzArBvKvSg04zuqd2hOLWIf8bcBz3FSb8FDpw4Xoa3toC6WmcCur2DhpuEw
         KX9SnCrO60RMG4tCQJcCDqhlwxDkHrGL/dyPCxpUfP7sqJ7xGtBJkUy8yrqBo757Ek2f
         Zue5YAg1NLL+vhu4Mq8UhCGUvLfaxlHlJFutCAo18btCUoYr11f/m5mjHJtMiGWUB4X6
         kLSw==
X-Gm-Message-State: AC+VfDxtlvtZ75dW2aC4G/Vi5fDXaioNmleUdBFpkQQGaCPQFG0Q2WAF
        FWWvMVtyv+1qV5wrvZKmTh/nK+YldBEkeis5BJlh7aQr9i7EkQBEyeJjrw==
X-Google-Smtp-Source: ACHHUZ7Swgs9121z+kuoRfiHB3OkW67hJZsKCgXapg8zVPdGaeR6+YSYh0xtyyAMKUOGr7rzXOWctORp5U5yyFztpH4=
X-Received: by 2002:a05:6808:1992:b0:3a0:ff3a:72f3 with SMTP id
 bj18-20020a056808199200b003a0ff3a72f3mr15244189oib.2.1687802005866; Mon, 26
 Jun 2023 10:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <b4bfd69f-2092-4d15-b7ce-b814f5f10ff2@sirena.org.uk> <CA+G9fYv=uyQaJs0JLMmZWLeLH0G5FF7WGcTa7y0bi0nCDfoi+A@mail.gmail.com>
 <20230626144157.GA20162@willie-the-truck>
In-Reply-To: <20230626144157.GA20162@willie-the-truck>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 26 Jun 2023 11:53:14 -0600
Message-ID: <CAEUSe79CRNw1jFopDvQ+f_FOSwQb-VJ6oWw-rJQXr0Yr3_P=YQ@mail.gmail.com>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in fpsimd_release_task
To:     Will Deacon <will@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On Mon, 26 Jun 2023 at 08:42, Will Deacon <will@kernel.org> wrote:
>
> On Thu, May 25, 2023 at 07:21:24PM +0530, Naresh Kamboju wrote:
> > On Tue, 23 May 2023 at 03:42, Mark Brown <broonie@kernel.org> wrote:
> > > On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
> > > > Test log links:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/b=
uild/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/test/=
check-kernel-kfence/log
> > > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/b=
uild/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/tests=
/
> > > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/b=
uild/v6.1.28-240-gb82733c0ff99/testrun/17007268/suite/kselftest-arm64/tests=
/
> > > >
> > > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/b=
uild/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/test/c=
heck-kernel-bug/log
> > > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/b=
uild/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/tests/
> > > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/b=
uild/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/kselftest-arm64/tests/
> > >
> > > None of these seem to provide me with information like what kernel
> > > config was used but I did manage to find
> > >
> > >   https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLiBcWR=
Muy6lXftDVQMvca/config
> > >
> > > which might be it?  Or one of them?  However even trying to use that =
I'm
> > > unable to reproduce issues with either the FVP or qemu.
> >
> > You got the right config file which we are using for testing
> > FVP selftests.
>
> Sadly, the config link above no longer works (404 file not found).
>
> However, I notice that the failure still seems to occur with 6.4:
>
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4/testr=
un/17767612/suite/log-parser-test/tests/
>
> Please can you point me at the config file for that run? I can't figure
> out which one I need from the web interface.

Kernel artifacts for that test run can be found here:
  https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ricfkwzy9jwZnHXNO=
etymU5t44/

(The labyrinth can be traversed this way: I went from that testrun
link, then test details [clicking on "check-kernel-kfence =E2=80=94 FAIL"],
then "job_url", then "build", then "tuxbuild directory".)

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
