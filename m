Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79263E0FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 20:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiK3Tr7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 14:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3Tr5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 14:47:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F675436B
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 11:47:56 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y17so9839486plp.3
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 11:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihh5oofyez3CtNOQIHwFTADZecAohqCOwiubz5fncqA=;
        b=mgji7ObiNmN8eVbpaz2mjgRdwSAUpuTFhzRs1nBB0wl7tOLWdgahWX5R8pzXzsKC1V
         Qtn1fkqFBjJjcQDgKlDh57l5mnYK+Ecoh1a2vOJcc2t63/bIEFUCiKEps0W/XWxLwcjS
         uEipbR9RmK8lHa3HKHs3GtiVqO61aYeRnQQBYU17wQNjkUKUZrQGXXWfYl9Buyk/5/mA
         FrKfxv15/oPRfpGjiNA5iuwI5hpZXV2Gr4+XrjCWbXfELTHOed6nOoV7sUsNVRnSsyxm
         lXB/RiZWL7eAwrTDd/bgWKDUr1Z4Q4M8R1g2bsjva2QnWftYdStcgeEeDNzrZS1jB//i
         HeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihh5oofyez3CtNOQIHwFTADZecAohqCOwiubz5fncqA=;
        b=nUdnKB2OxV3wiZcmt9iS5Cw/FOfPwas1DDxjMbA3B+XvKdOXI0JHTQ0Oai5KXeKfJA
         oyLwY0dtvJLGTKlw897Ahg73JtabnWf9RirWJ9nLJrv3dC5X/XGYs4xbj0/kzRUvHbM4
         +ddVE+qVUzo7mueELYHLHFmeyBlow2Hc+9WZdZ6DYmomG15KD38rQGg8vocbqCJWnNlB
         fcsasAlt8uvy28qlrCAnumD7qxkweSpl1AmRaRp+YHI00yfZLjZEzW9Y7LXea1xdtjJF
         cIMJBIZGstuPuxdeSbzTEyKmnEoP+iYvmeaFRiPqEB25sUD0aRv4oayNzvUKSjDMQnXn
         9qwg==
X-Gm-Message-State: ANoB5pnicUj0ai1LNukBf+YUJuCyT3ZYw5vWOoMUQ4ThzIYkg0lHKS4R
        ZrOFA4qt59WDhafuq+viFTCyjQHTJdKqeWSdp9blUA==
X-Google-Smtp-Source: AA0mqf7qPQwpY05hjWXylLqQi7yyJwO1Q1xUae2EZKtA8JJJtC3bef3O0Mr18W2iV3UxDeupUhFwyQrATnCV4d5QlPo=
X-Received: by 2002:a17:90a:5317:b0:213:34f7:fb14 with SMTP id
 x23-20020a17090a531700b0021334f7fb14mr70448861pjh.25.1669837675431; Wed, 30
 Nov 2022 11:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20221128020409.1545717-1-limin100@huawei.com> <1232e4f3-e4b8-ff23-61e8-5465c8406f6e@digikod.net>
 <7379a5fd-5593-c6ce-40fd-c543dcf70d2b@huawei.com> <e62a539b-614c-c008-873a-f9c57c7ecb33@digikod.net>
 <2bc18685-f975-497f-9c20-da99dbc296c0@huawei.com> <ed1f6874-0f24-8145-63d4-efe28545381b@digikod.net>
In-Reply-To: <ed1f6874-0f24-8145-63d4-efe28545381b@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 30 Nov 2022 11:47:18 -0800
Message-ID: <CALmYWFs0GG8o3WQw7PEGvT=qgHHGiTC_mE1kQ0oRVjNUJa36gA@mail.gmail.com>
Subject: Re: [PATCH -next] selftests/landlock: Fix selftest ptrace_test run fail
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     limin <limin100@huawei.com>, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 30, 2022 at 11:32 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
> I checked and the Landlock ptrace test failed because Yama is enabled,
> which is expected. You can check that with
> /proc/sys/kernel/yama/ptrace_scope
>
> Jeff Xu sent a patch to fix this case but it is not ready yet:
> https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
>
> Could you please send a new patch Jeff, and add Limin in Cc?
>
Yes. This work is planned for Dec. I will start working on it soon.
Jeff

>
> On 29/11/2022 12:26, limin wrote:
> > cat /proc/cmdline
> > BOOT_IMAGE=3D/vmlinuz-6.1.0-next-20221116
> > root=3DUUID=3Da65b3a79-dc02-4728-8a0c-5cf24f4ae08b ro
> > systemd.unified_cgroup_hierarchy=3D1 cgroup_no_v1=3Dall
> >
> >
> > config
> >
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/x86 6.1.0-rc6 Kernel Configuration
> > #
>
> [...]
>
> > CONFIG_SECURITY_YAMA=3Dy
>
> [...]
>
> > CONFIG_LSM=3D"landlock,lockdown,yama,integrity,apparmor"
> [...]
> >
> > On 2022/11/29 19:03, Micka=C3=ABl Sala=C3=BCn wrote:
> >> I tested with next-20221116 and all tests are OK. Could you share your
> >> kernel configuration with a link? What is the content of /proc/cmdline=
?
> >>
> >> On 29/11/2022 02:42, limin wrote:
> >>> I run test on Linux ubuntu2204 6.1.0-next-20221116
> >>>
> >>> I did't use yama.
> >>>
> >>> you can reproduce by this step:
> >>>
> >>> cd kernel_src
> >>>
> >>> cd tools/testing/selftests/landlock/
> >>> make
> >>> ./ptrace_test
> >>>
> >>>
> >>>
> >>>
> >>> On 2022/11/29 3:44, Micka=C3=ABl Sala=C3=BCn wrote:
> >>>> This patch changes the test semantic and then cannot work on my test
> >>>> environment. On which kernel did you run test? Do you use Yama or
> >>>> something similar?
> >>>>
> >>>> On 28/11/2022 03:04, limin wrote:
> >>>>> Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent,
> >>>>> trace parent return -1 when child=3D=3D 0
> >>>>> How to reproduce warning:
> >>>>> $ make -C tools/testing/selftests TARGETS=3Dlandlock run_tests
> >>>>>
> >>>>> Signed-off-by: limin <limin100@huawei.com>
> >>>>> ---
> >>>>>     tools/testing/selftests/landlock/ptrace_test.c | 5 ++---
> >>>>>     1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c
> >>>>> b/tools/testing/selftests/landlock/ptrace_test.c
> >>>>> index c28ef98ff3ac..88c4dc63eea0 100644
> >>>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
> >>>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> >>>>> @@ -267,12 +267,11 @@ TEST_F(hierarchy, trace)
> >>>>>             /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the
> >>>>> parent. */
> >>>>>             err_proc_read =3D test_ptrace_read(parent);
> >>>>>             ret =3D ptrace(PTRACE_ATTACH, parent, NULL, 0);
> >>>>> +        EXPECT_EQ(-1, ret);
> >>>>> +        EXPECT_EQ(EPERM, errno);
> >>>>>             if (variant->domain_child) {
> >>>>> -            EXPECT_EQ(-1, ret);
> >>>>> -            EXPECT_EQ(EPERM, errno);
> >>>>>                 EXPECT_EQ(EACCES, err_proc_read);
> >>>>>             } else {
> >>>>> -            EXPECT_EQ(0, ret);
> >>>>>                 EXPECT_EQ(0, err_proc_read);
> >>>>>             }
> >>>>>             if (ret =3D=3D 0) {
