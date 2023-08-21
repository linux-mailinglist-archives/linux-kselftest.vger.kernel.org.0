Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF61782B8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjHUOVG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjHUOVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 10:21:05 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B3188
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 07:20:41 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48d10c504a8so335098e0c.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692627632; x=1693232432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWG07LdVGn7VFP43KyVmejqn3QURW+mK8BYkazDvZEc=;
        b=NQo539YRUXe+f0Pd/a7rVllCjpqGN9LkjDJz8JkJsEv15dNe/OY4F74VMfOkCGHe/j
         9jexdGNy+28fkyz31IT36rJVp0nzsR4FGtFRHga+UMAAbrAZDAloZ1L9hxMRYD7O2eh0
         PWBIV89WIBMocZxvaMmEI1jQbtq4vSWgmvgToC+/bLLKrGQAQXamTLM4Bl9gtIERAPE0
         YSDlv09x8A5BZ7n2iKYIRzRLLvpqBpGy+9a9nn1ORSsSd7ClWecCtfSpdMLF9Fa6n5MS
         haLytHXvTYgR0wrbxwLcgTHJRO3TcfIbn8wS24suVM7tmR5r/0EgW1G1ATo/CSt6eiX9
         h6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627632; x=1693232432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWG07LdVGn7VFP43KyVmejqn3QURW+mK8BYkazDvZEc=;
        b=Oa0NKDO/QTyjpSrjpPenPgPmnCNzZGf8Ujzv44tlpCe9s4SsNtEuOj4ZUojFjg7xD4
         zOuGimT8IWQuRlWWXCxI35oCaCeep2dnbdJAypotw/cAuVbR4yjFVO2EeBOumNdJRiSR
         3sfnaKkIQZ+nBrimy+NWpbprmlKjbIj3KYk0psU0aWpOJvtKX+vW8xeNL4iFt5p+v/wr
         upDHFwt9v8JFkVuEe65evDF2452zODQhYl0Dou63Gff5Q8ZANHYyB2v9kP2Ih2ZpRKq+
         fb9zaEy1+CBrvDIeOroLAAUGKtneX6zDVliH1O/pAWcvt8VF9Wuegew5iRsAwpnt1T0D
         zNUQ==
X-Gm-Message-State: AOJu0YzF/EHzIcrSmBqBD+COczxLmYouwbSsdyJUbP+bHn7iT6l+IwP8
        oYsXlYrVKfvhUai+jZ3UE5ArHg2tNP93t/kul1c/evaubIKqg3m7
X-Google-Smtp-Source: AGHT+IEL7/lIT2DoE0nDuddm6ZZs7RBtHuj4HDAswtvPoZsdO4X81ZEyQeyt9+TjVQDnz2iWfFMWLqleLeNK9ffgCso=
X-Received: by 2002:a67:f310:0:b0:447:4316:415a with SMTP id
 p16-20020a67f310000000b004474316415amr5762575vsf.31.1692627632355; Mon, 21
 Aug 2023 07:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
 <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com> <CA+G9fYtRMde7Ksswa8pY8sFgnWVN-snRHfz4YRM04HSQ4LFBZQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtRMde7Ksswa8pY8sFgnWVN-snRHfz4YRM04HSQ4LFBZQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 21 Aug 2023 19:50:21 +0530
Message-ID: <CA+G9fYuRy_yJ0Fa1hxt4iPZvgw+qvdvXmqWtFV-rDME+pCdXiA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 18 Aug 2023 at 10:48, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> On Thu, 17 Aug 2023 at 21:24, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
> >
> > On Thu, Aug 17, 2023 at 3:51=E2=80=AFAM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > While building selftests landlock following warnings / errors noticed=
 on the
> > > Linux next with clang-17.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Build errors:
> > > ------------
> > > landlock/fs_test
> > > fs_test.c:4524:9: error: initializer element is not a compile-time co=
nstant
> >
> > Hi Naresh,
> > Can you tell me more about your specific version of clang-17?
>
>     compiler:
>         name: clang,
>         version: 17.0.0,
>         version_full: Debian clang version 17.0.0
> (++20230725053429+d0b54bb50e51-1~exp1~20230725173444.1)
>
> >
> > I believe a fix of mine to clang should address this. It landed in
> > clang-18, and was backported to clang-17 recently.
> > https://github.com/llvm/llvm-project-release-prs/commit/0b2d5b967d98375=
793897295d651f58f6fbd3034
> >
> > I suspect your clang-17 might need a rebuild.  Thanks for the report.
>
> I will rebuild / re-test and confirm soon.

LKFT team re-built containers and I have re-tested the builds
and reported build issues has been fixed.

Thank you !

Best regards
Naresh Kamboju
