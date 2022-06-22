Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7255551FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jun 2022 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377035AbiFVRHt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jun 2022 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377084AbiFVRHi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jun 2022 13:07:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC83740E69
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jun 2022 10:06:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c13so20339296eds.10
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jun 2022 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OqqiTD3gLybHOW4I6TLL5midAVTZ5DMLmHGaa4oXrwI=;
        b=LViXX25+dhqxoIkD3PVPh5xlkUUjEcGqJEAQ2qrZky+J2zu84mwCgGHlmhvMlgCsTZ
         /7+K0OsGs4c0r6Nxx1W3q3XWLkYo5PiFTkwvQoGEnBfp/rYyu9VMlF54QnNBcW6gxmeg
         udE1bX3CTw4mk+szaqUlm7iwY6sxk/Fp1YqJoi3c8VLcRlDc/GekR6NuuTqB5VoMO1dv
         RlTU9nDiD5VtqIMUKnNVdUrBu38/HydLxExUxcu7/Y4L75O1AA+/QDUzPv1hNPdlzD7Y
         R0gs5JfrNdgn6vrpQuSabxnMwLLVOxHRrZmJRtT1JLDE8OvV1VaUVKyjabfpdU8pgg0B
         PBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OqqiTD3gLybHOW4I6TLL5midAVTZ5DMLmHGaa4oXrwI=;
        b=NYieisKLp8HW/1dbbXN0NOkdwT/KT6GnWVvq3tt7AzXRKm48+5cxQB3w6Ze0/5Cref
         x2afA465MuXdlZBesJYmM7sL9dCqeUez9sOiNZ75ykZrWKuOPzlzg0se637142nz1wU3
         VJQSt8Ikbcm82L2zX3lLlLm6tr0opsxpoYNHSySQipHyHy4VV4P1l7j0gtLkl1KS6tYJ
         7o4i8ufjF/Ii2ntPGNKsisxyLM/nQnOG3oJbWQMk0yR0GvyDWEINC3kFtSSZw+TAlY93
         DZ+d7R0fLYIb4ZFknb3mTDpPWd9MaqSo0yDxZqDP0L1hgM/suTUkpY8PxdeJXGO9/A8K
         WodQ==
X-Gm-Message-State: AJIora+QGHs9lEBsBOTgDQUIBR2UM74yE6tPnPlSTcQLtW79l5HLuuhl
        dLnWwqFXgZ3EkfjROSHVtxkaUzSxNWQy5SJbPXNniQ==
X-Google-Smtp-Source: AGRyM1s9NziaB5rFGJn8nlqg9mHNGM6U4u3m7TD4UXdULiRqF9kKHp+l0vbLc2Qiez8orLLht/Ury4IBWPhFVGR8TKU=
X-Received: by 2002:a05:6402:438a:b0:435:bc23:d615 with SMTP id
 o10-20020a056402438a00b00435bc23d615mr2590960edc.283.1655917614113; Wed, 22
 Jun 2022 10:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220621200926.257002-1-maira.canal@usp.br> <20220621200926.257002-5-maira.canal@usp.br>
In-Reply-To: <20220621200926.257002-5-maira.canal@usp.br>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 22 Jun 2022 10:06:42 -0700
Message-ID: <CAGS_qxrynX=q7ZVmFSm-HO-3r3wGVnXMXVMejM3-ONvyJUrrPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] drm: selftest: convert drm_format selftest to KUnit
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 21, 2022 at 1:10 PM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Considering the current adoption of the KUnit framework, convert the
> DRM format selftest to the KUnit API.
>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>

Acked-by: Daniel Latypov <dlatypov@google.com>

Overall looks good from the KUnit side, just a few general suggestions belo=
w.

FYI, the warning email from kernel-test-robot is basically saying that
the compiler is not optimizing away the temporary variables internally
created in KUNIT_EXPECT_*.
So having too many KUNIT_EXPECT_.* in a single function is the trigger.
The main workaround you'd have is to split up the test into more test funct=
ions.
(I don't know if that's actually worth doing)

> +static void igt_check_drm_format_block_width(struct kunit *test)
> +{
> +       const struct drm_format_info *info =3D NULL;
> +
> +       /* Test invalid arguments */
> +       KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 0));
> +       KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, -1));
> +       KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 1));

Hmm, I think one of these two would be clearer here:
KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 0), 0);
KUNIT_EXPECT_EQ(test, 0, drm_format_info_block_width(info, 0));

I think this helps test readability (giving hints about the types) and
gives better error messages, more on that below.

The problem with using the boolean expectations is that given
  int foo =3D 2;
  KUNIT_EXPECT_FALSE(test, foo);
KUnit will only print out
    Expected foo to be false, but is true

Using EXPECT_EQ(foo, 0), we'd get
    Expected foo =3D=3D 0, but
        foo =3D=3D 2

Knowing exactly what the offending return value was can help debug
test failures a bit faster.

> +
> +       /* Test 1 plane format */
> +       info =3D drm_format_info(DRM_FORMAT_XRGB4444);
> +       KUNIT_EXPECT_TRUE(test, info);

FYI, you can now instead write
  KUNIT_EXPECT_NOT_NULL(test, info);
this new macro was merged into 5.19-rc1.
