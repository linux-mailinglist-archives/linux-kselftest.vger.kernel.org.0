Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6692739DCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFVJzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 05:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjFVJye (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 05:54:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E346A5;
        Thu, 22 Jun 2023 02:50:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988e6fc41ccso474464366b.3;
        Thu, 22 Jun 2023 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687427431; x=1690019431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey/Vv80nE8uwWSfVUbghuywv9z3ddX7tceISdZ9mqHQ=;
        b=ZuhJosSDsY60LXl7JXyeiDnvD/VEIpS8YfFW3xBvbs4IDk00SXPsap3eXc5LzTD35d
         rxBWcmgyf5m+UNAhBencyEfX0HkFE27AT+imGLcxrrEY2dRM3gBrgAOm3oawv+hjh/63
         pMYbJlaJvSvzoMN2q5bpR6dpGtxv1eB/JYdaOjF+09Ab9kkAUTFf19LasKBUp0w5lCoe
         Gvkk60v7g2vG35PNDTcHvn90MggKTeMCyDHftHjpMUTHSSOrwSbHjg2t0JuF3kkH44JF
         6KQPldWFgG3FYxca+lJr3sSeA/w8R4b14KDknQMmFtO5r7bL1oBMpXkEHpyHeRRtxnl/
         9GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427431; x=1690019431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey/Vv80nE8uwWSfVUbghuywv9z3ddX7tceISdZ9mqHQ=;
        b=daMiFjP/s3Srikjy4QgQ+8aYSSfKlmc5H+9l38BTnnDiss8eg/Wq2XdyoOcyJXABch
         lcIImGki+lYmE6ZO8qHdIjbz56csBLEAnoBq30p3BhfAgE/ldgNNx8nEWfuVnVKel+Jk
         XFlSKPChSH+zdIk7zCBEdiSKtgUXH9xjh7uzOiUiI9D0Wn1aDBrAlw/PDHEtZxC6YzLw
         wR0H2Ug7PxBY+kS2+TrrGKJVeMRbcFULv6PZ28NsQ7m9FoPiWv84pgLgektpAQCiFouE
         Wsx3mLzNBQe+H6cYjnf3PcO+8IMK1YFdyVtcTqH5BjDrxkhgvvJzbLe78rkxIpIiAEAt
         sB9w==
X-Gm-Message-State: AC+VfDzm+mzUuX+GAkBdaHvK+FtLC3qHsU/B30tFGMv5nF4ExvGgNNyL
        W45AkOidVULMCzxBWDra+s7GFqbSFap4WQ7BLeI=
X-Google-Smtp-Source: ACHHUZ6527t+J8MMkWFeOmQO7Za2SHvP3Mayb7ha8qPlC32cYy71sJCZIQaHbONVtaFEtSMKQ07vrrVykWvuFihlMWs=
X-Received: by 2002:a17:907:9303:b0:973:d06d:545f with SMTP id
 bu3-20020a170907930300b00973d06d545fmr13381565ejc.24.1687427431062; Thu, 22
 Jun 2023 02:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083026.591323-1-dangel101@gmail.com>
In-Reply-To: <20230621083026.591323-1-dangel101@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 22 Jun 2023 11:50:19 +0200
Message-ID: <CAFqH_50Td8iigXOJark5Exoa7bD7azg3E4wKWc=ySXTZ7bch9A@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/input: add test to cover len > maxlen in bits_to_user()
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     shuah@kernel.org, usama.anjum@collabora.com, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dana Elfassy <dangel101@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dana,

Thank you for the patch.

Missatge de Dana Elfassy <delfassy@redhat.com> del dia dc., 21 de juny
2023 a les 10:30:
>
> In order to cover this case, setting 'maxlen =3D 0', with the following
> explanation:
> EVIOCGKEY is executed from evdev_do_ioctl(), which is called from
> evdev_ioctl_handler().
> evdev_ioctl_handler() is called from 2 functions, where by code coverage,
> only the first one is in use.
> =E2=80=98compat=E2=80=99 is given the value =E2=80=980=E2=80=99 [1].
> Thus, the condition [2] is always false.
> This means =E2=80=98len=E2=80=99 always equals a positive number [3]
> =E2=80=98maxlen=E2=80=99 in evdev_handle_get_val [4] is defined locally i=
n
> evdev_do_ioctl() [5], and is sent in the variable 'size' [6]
>

Like the comment in my previous patch I think this is understandable
for someone that has some context, but I am not sure it is understood
for people that don't have such context. So I'd try to rephrase and
explain in a more plain way. I.e.

selftests/input: introduce a test for the EVIOCGKEY ioctl

This patch introduces a specific test case for the EVIOCGKEY ioctl.
The test covers the case where len > maxlen in the
EVIOCGKEY(sizeof(keystate)), keystate) ioctl.


> [1] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L1=
281
> [2] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L7=
05
> [3] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L7=
07
> [4] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L8=
86
> [5] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L1=
155
> [6] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L1=
141
>

Also, usually is not a good idea to add links in commit messages
reference to links that can easily end as dead links.

> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> ---
> Changes in v2:
> - Added following note about the patch's dependency
>
> This patch depends on '[v3] selftests/input: Introduce basic tests for ev=
dev ioctls' [1] sent to the ML.
> [1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214=
.15933-1-eballetbo@kernel.org/
>
>  tools/testing/selftests/input/evioc-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/s=
elftests/input/evioc-test.c
> index ad7b93fe39cf..b94de2ee5596 100644
> --- a/tools/testing/selftests/input/evioc-test.c
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -234,4 +234,23 @@ TEST(eviocsrep_set_repeat_settings)
>         selftest_uinput_destroy(uidev);
>  }
>
> +TEST(eviocgkey_get_global_key_state)
> +{
> +       struct selftest_uinput *uidev;
> +       int rep_values[2];

nit: rep_values sounds like repeat values, I'd use a variable name
more similar to what we really need to pass to the ioctl, like
keystate. Also I think this can be simply

int keystate;

> +       int rc;
> +
> +       memset(rep_values, 0, sizeof(rep_values));
> +

and then, this memset is not really needed.

> +       rc =3D selftest_uinput_create_device(&uidev);

This one without extra arguments need to be:

        rc =3D selftest_uinput_create_device(&uidev, -1);

otherwise the vararg loop is going to keep the room warm for no reason.

> +       ASSERT_EQ(0, rc);
> +       ASSERT_NE(NULL, uidev);
> +
> +       /* ioctl to create the scenario where len > maxlen in bits_to_use=
r() */
> +       rc =3D ioctl(uidev->evdev_fd, EVIOCGKEY(0), rep_values);
> +       ASSERT_EQ(0, rc);
> +

while we are here, and as it should be easy, maybe we can also extend
this to cover the normal workflow to get the global key status?

> +       selftest_uinput_destroy(uidev);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.41.0
>

Thanks,
  Enric
