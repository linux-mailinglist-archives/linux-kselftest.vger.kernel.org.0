Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66005882E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 21:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiHBT4p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiHBT4o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 15:56:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD1193FD
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 12:56:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a89so18962591edf.5
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aJ1IcxOV9HzMYe6hVZtqnJn+GQ6Pavsgk4lqFt7I3lw=;
        b=sXGeyqMMqOkad+RCWTMV6mSoOaruh1YofncGb1u4yrwObF/bOve9wzUZS6sMEArJ94
         4Sze74yUYk/8A5Q0In8NaQP+Hs6EftL19ZOryX1WBM34/nYPlz+KRk5ZfY7qOf9YIk9O
         PRhsKNZin8kDJ/qKSbM5nbv+c5HPPhOImYray8aH+raXEUtK3GyAsNwOeImfujFYMCQ7
         N0uemyvXNysOH0xf7Jd76tQU+NTcrFI8IHWLPm7PWQhZbqRVa9W40kiIgd86j4A8pRk0
         buMGpmgfTDzIooyLhVvKnquywHTFFzHst/KYxbj6FVGzc1+icDhEi6Obove9GJR1bb5L
         Agfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aJ1IcxOV9HzMYe6hVZtqnJn+GQ6Pavsgk4lqFt7I3lw=;
        b=U1Xok+eBRr5J6Ug4qv1atiPo+y1SHY/TKEHuEeIz+UevGqlPDnQyNpF8YjLWjZLMcI
         JnT8+zMlIEyb3M3GF5TxLL67/nPNW/4ZejMXsdJM0IRmq8/t+j7ZkQcq/tk2KfRvc3xI
         UT29psiPTCailjgidagneBHCQ4//e47M8JMQFcArz1RjPBxF0jKyUwN9rz/TpxEQliTJ
         37ufQFeXAywsCueQzRe8mwoB/rN/M65wGjJo0ZAq0Rz4IejcW1I5EDOFIwayWp57O6/X
         Pnt6amAr29u0Hc3W6pjlOS/ym5RbrXaNb+Nvx1Z1S584aLqeNM4zj7TIdd7BYn6x1BoR
         00Hw==
X-Gm-Message-State: ACgBeo2WbPWOcB/fAESAbwgXBq3UQYIjtBT3ebPX33IwmkNsB0KFggNh
        +54o7Y/R0taSTC4N6RzAS3nRlwbxDO63x+sVqhQryw==
X-Google-Smtp-Source: AA6agR4OsZ+EfKuXZurYk1nJbB+3WJs6h2ZjSsZHPoJMS/i0MdtpPLVh4pPn8WZaZTBtU4lAiItoxwJrUTL1nfNR4cc=
X-Received: by 2002:a05:6402:4385:b0:43d:4820:4532 with SMTP id
 o5-20020a056402438500b0043d48204532mr17385855edc.233.1659470202039; Tue, 02
 Aug 2022 12:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220802161206.228707-1-mairacanal@riseup.net>
 <20220802161206.228707-3-mairacanal@riseup.net> <5c9038fd-a247-d0d3-841c-ba1e606bc309@riseup.net>
 <CAGS_qxodPndQZ_ypy-QP=ViNUvwZk1z1u8EAv9k5XzDEC4WSGQ@mail.gmail.com> <5931f10d-09ac-84f3-f5d1-65039478ae97@riseup.net>
In-Reply-To: <5931f10d-09ac-84f3-f5d1-65039478ae97@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 12:56:30 -0700
Message-ID: <CAGS_qxrYGrvg--bmdJ8zOV8+hCcY6=OZj0FtqheNtGP81XFL6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: add KUnit array assertions to the example_all_expect_macros_test
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        melissa.srw@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        jose.exposito89@gmail.com, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, davidgow@google.com,
        davem@davemloft.net, Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, airlied@linux.ie, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 2, 2022 at 12:00 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
> > I don't know how we make a maximally fool-proof version of this macro :=
\
>
> This is a hard one also. I believe that use KUNIT_EXPECT_ARREQ(test,
> expected, expected, sizeof(expected)); is more compliant to the
> memcpy/memset/memcmp signature. Moreover, this problem also occur for
> the KUNIT_EXPECT_EQ(test, memcmp(expected, expected, sizeof(expected)), 0=
);
>
> I believe that the number of array elements will make it easier for
> users to avoid mistakes.

Actually, another idea: perhaps KUNIT_EXPECT_MEMEQ?
I think that might be clearer in terms of the semantics and people
could more easily infer the right unit (bytes).

Daniel
