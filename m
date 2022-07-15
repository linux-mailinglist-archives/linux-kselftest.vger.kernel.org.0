Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDC57585A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 02:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiGOADW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 20:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiGOADW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 20:03:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC13B72EE9
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 17:03:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy29so5083319ejc.12
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fwraHTEP/uVZ9KCal2b2vqb8PKwKxo0TpTT7XGDLLZE=;
        b=Ew35vEVTCjHoWMpCvupFCvQMugpO31WL5+yFBGY/4vLy9c/2lHjyL0Qakj48tSo9RH
         hNkYdoFnwqRm4CGjLZBjKauF7HwHfGWwdC13A/boMmvLWcnyhh4i8G2eTmOcyNcmBCFQ
         yeSO6zvaQfPtjU23hSBzdEcTDEiS8BtsYVkCCVOdpnAfS95Xcqd83tRWzemWJYIVF0uG
         FsiLzam4+8VzlAhRc7TuzkTn0CgKium3YJ5axjlQyy4I5FFW0C5IhyyBw1NQz2Wo3RTh
         41K8Z0Qz6lO5I0SEC11jKfeGJAfHpc1G123IAYHpBuyPwj8qBz3lhqSa+BaX0q9QQqha
         KXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fwraHTEP/uVZ9KCal2b2vqb8PKwKxo0TpTT7XGDLLZE=;
        b=fJYgkRuIZdAKz2ImTTv58NWx08B2S+qV9z78fLBzkmKacpsgfEo3M02t7H9q2nH/im
         oKA2xhZuZpw2mE0BRbOHpVzqzXPWv2z9Q0tpHC03Nw+7qlU/HTcNhsI+o7TEE2aeoe6V
         fy2OCmn7XRv0r7tmWdj6yHyM4H8DMzQ9iFKBUa28QTiLzg2uHwJXgfq9Pn/6HvufDpmP
         DwcEmzABbLvA6cMYprqrCYYXluwXu/bjEEcnd46lBsc/vYQrKTU+WZ3Hut8GPFwoeCCs
         XXpbWXPtBxXqsH3Q5H2cFTql/XrLCJHarrhWsvEqS3hznW2qifFm0vDgRtuCUjvNsycS
         ZE1w==
X-Gm-Message-State: AJIora/vXL3UKjYePyUHdTgA7a2v6+/50lFH17tXsFKldD7Hf2j8yglF
        O7sCYSg3DSKTbPxc0YjV7VqIONj4tVhcFTak74hYtA==
X-Google-Smtp-Source: AGRyM1vbY7PEy17UlotgKN0DNZJDJvWNMdNGydoLgQZD6KQsvix4dz1Cwf5HUOIEMKSPpgkaLf+4J5OUcADUQzkaZiY=
X-Received: by 2002:a17:907:2718:b0:72b:6b65:37dc with SMTP id
 w24-20020a170907271800b0072b6b6537dcmr10960045ejk.425.1657843399208; Thu, 14
 Jul 2022 17:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220708203052.236290-1-maira.canal@usp.br> <20220708203052.236290-5-maira.canal@usp.br>
 <20220714235137.GA485839@roeck-us.net>
In-Reply-To: <20220714235137.GA485839@roeck-us.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 14 Jul 2022 17:03:07 -0700
Message-ID: <CAGS_qxrhy3=pST9f85fvxubKQShOq1XF6ZHALzMhXDOf5gnaUg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] drm: selftest: convert drm_format selftest to KUnit
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 14, 2022 at 4:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Jul 08, 2022 at 05:30:47PM -0300, Ma=C3=ADra Canal wrote:
> > Considering the current adoption of the KUnit framework, convert the
> > DRM format selftest to the KUnit API.
> >
> > Tested-by: David Gow <davidgow@google.com>
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
>
> This patch results in:
>
> Building powerpc:allmodconfig ... failed
> --------------
> Error log:
> drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_forma=
t_min_pitch':
> drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of 3=
712 bytes is larger than 2048 bytes
>
> presumably due to function nesting.

This can happen when there's a lot of KUNIT_EXPECT_* calls in a single func=
tion.
See [1] for some related context.
There were a number of patches that went into 5.18 ([2] and others) to
try and mitigate this, but it's not always enough.

Ideally the compiler would see that the stack-local variables used in
these macros don't need to stick around, but it doesn't always
happen...
One workaround would be to split up the test case functions into smaller ch=
unks.

[1] https://lore.kernel.org/linux-kselftest/20210929212713.1213476-1-brenda=
nhiggins@google.com/
[2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-1-dlatypo=
v@google.com/

Daniel
