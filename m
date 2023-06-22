Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8F073A485
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFVPNh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjFVPNd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 11:13:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5121BD3;
        Thu, 22 Jun 2023 08:13:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so8134011e87.0;
        Thu, 22 Jun 2023 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687446806; x=1690038806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EVcgORFq1QsYVDtcKeh3S9zqJ/zZpa9LGaHHHVgS64s=;
        b=GQknYtc9USQ4J8zP4XfRRGzKYZycbIuzyO1q9WgnLODSOWCOprZ9IROyY2/YYgYpNF
         9Ai0FiFGN1GSxMgF5jIs30PJP1r+EPGVYVvnQTKZA+YmKIWPTW3HHXYDfhOFJfNuaZ75
         zxB0BXCQd6Jhc/C1zvDYE2sr4paLpyC/KMhCtnsuHPg2dCrM0Qf1cqUfPRA0WcaADqtm
         9z/9oEHe+7QyXtYfvk7aYguju7tL1gKcMLGd+8lqPVD5zpjXm8uBY5U9dDp/Ud8zeDRu
         BH0p/hwnC1v5nBBp1xpqrCvq3P3I4grAH4yFbl8Q+wXxX0VD5H/zBsbOaKm/U+sj7iR0
         3ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446806; x=1690038806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVcgORFq1QsYVDtcKeh3S9zqJ/zZpa9LGaHHHVgS64s=;
        b=SgGDZ0/MvuJnhX4+C5uxEoP8Ij3Bvzo3tNlMP7889hyHI+SQPtx5TuEfCVgRvHbUIM
         /wfgHCEcIcWVyUU2zbtBtfOZCwVDH68jz8k/psgjNHXLbHMvMikq+SUve16zWK2hk+BU
         uJRcecJMOkXqRSZQlG5GyIdMYD44mE1/KbmsGJ5SYLD3XJnrTjmDwLjP00JKojrmQpQl
         IjLd3qShLfbx+raiW6Uae4yDr0SFxaR3HEk2W/yc32KjuT37ysB72r2POrLsIgXJuy7v
         eHa+g27s+Z909j4DQCwkYVqBgzyzXRvnSfFX0XHqzOy877erAxzXofqZdLOpMS/gYZiw
         hsJQ==
X-Gm-Message-State: AC+VfDxbeBMB3nUDONPYgSjRgRNElPUQ2dM6No50bfSbrWN1kj5nvdRG
        XENF4IDgIE5YWfNHfVfLuBTXqWwlCRaLg/Hilq8=
X-Google-Smtp-Source: ACHHUZ71BeOSDI9I74VkFtO/kSQZYun4tEvGZRfWeEHbIknVdM9+UNlIInMa8oB+oewRf9gIqkz63Hc2uNQeXDSV06M=
X-Received: by 2002:a05:6512:3ba7:b0:4f9:6221:8fb7 with SMTP id
 g39-20020a0565123ba700b004f962218fb7mr2500233lfv.11.1687446805721; Thu, 22
 Jun 2023 08:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230622141802.135723-1-dangel101@gmail.com>
In-Reply-To: <20230622141802.135723-1-dangel101@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 22 Jun 2023 17:13:13 +0200
Message-ID: <CAFqH_51Ro3J1nwk7Os9VYV8_UpE86YRA8C0bfkSX17UikjHz_Q@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/input: introduce a test for the EVIOCGKEY ioctl
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dana Elfassy <dangel101@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Thanks for applying the changes.

Missatge de Dana Elfassy <delfassy@redhat.com> del dia dj., 22 de juny
2023 a les 16:18:

>
> This patch introduces a specific test case for the EVIOCGKEY ioctl.
> The test covers the case where len > maxlen in the
> EVIOCGKEY(sizeof(keystate)), keystate) ioctl.
>
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> ---
> Changes in v3:
> - Edited commit's subject and description
> - Renamed variable rep_values to keystate
> - Added argument to selftest_uinput_create_device()
> - Removed memset
>
> Changes in v2:
> - Added following note about the patch's dependency
>
> This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
> [1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/
>  tools/testing/selftests/input/evioc-test.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
> index ad7b93fe39cf..e0f69459f504 100644
> --- a/tools/testing/selftests/input/evioc-test.c
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -234,4 +234,21 @@ TEST(eviocsrep_set_repeat_settings)
>         selftest_uinput_destroy(uidev);
>  }
>
> +TEST(eviocgkey_get_global_key_state)
> +{
> +       struct selftest_uinput *uidev;
> +       int keystate = 0;
> +       int rc;
> +
> +       rc = selftest_uinput_create_device(&uidev, -1);
> +       ASSERT_EQ(0, rc);
> +       ASSERT_NE(NULL, uidev);
> +
> +       /* ioctl to create the scenario where len > maxlen in bits_to_user() */
> +       rc = ioctl(uidev->evdev_fd, EVIOCGKEY(0), keystate);
> +       ASSERT_EQ(0, rc);

So if I understand correctly this is only to trigger the following
code path (line 709 and 710) which is not covered by other input
tests.

    1154           1 :         case EVIOCGKEY(0):
    1155           1 :                 return
evdev_handle_get_val(client, dev, EV_KEY, dev->key,
    1156             :
KEY_MAX, size, p, compat_mode);
    1157             :

     886           1 : static int evdev_handle_get_val(struct
evdev_client *client,
     ...
     909             :
     910           1 :         ret = bits_to_user(mem, maxbit, maxlen,
p, compat);


     702           1 : static int bits_to_user(unsigned long *bits,
unsigned int maxbit,
     ...
     709           1 :         if (len > maxlen)
     710           1 :                 len = maxlen;

> +
> +       selftest_uinput_destroy(uidev);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.41.0
>

I ran the test with code coverage enabled and I can confirm the code
path is triggered, running libevdev tests plus this test increases the
code coverage for the EVIOCGKEY ioctl. so

Reviewed-by: Enric Balletbo i Serra <eballetbo@kernel.org>

Thanks,
  Enric
