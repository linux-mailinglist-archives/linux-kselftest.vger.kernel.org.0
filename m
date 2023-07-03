Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0074584F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjGCJ0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGCJ0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 05:26:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4507CD;
        Mon,  3 Jul 2023 02:26:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so5318200a12.1;
        Mon, 03 Jul 2023 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688376390; x=1690968390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6XhJFjT4U1VeHdjNxkEyj9oVsBY01R/+JVcfOOgqEA=;
        b=o5CYOXGgUWy3FHAqYl5iinsBcaajRSbFuuAavb1p5+LDz9sSozz2O0WrGsvnyYTRh5
         GscxwJeJBI/UEuaFIpzZhHmP7+kVTDj56kuDz63heHHZntQfk0NL9hrdO4fPM3HMXFwb
         1ckd1Dp8VPLrkMXajtdPHVzLas1kv/Cl1ZkPr2un2G6XbsonDYiVZYgY//qVTL0HTIa6
         KyF6lnj+py5ppdNpcvXLCrXhUJFo1vTlYol6vQsgULilvAB4gqfdzFvg1bqufikB2Ydx
         S2U/JcioiTm3FP6S+cCUN+BD/tbglO52SQDNyPpXqKLXQ4RlfQVlrb7gICTXxDoJhaus
         efHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376390; x=1690968390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6XhJFjT4U1VeHdjNxkEyj9oVsBY01R/+JVcfOOgqEA=;
        b=SwVr+6kDgOVpWTV6mCYWSVzSQPJV9pfq5lqji1PHn3mtNsfHv5vtoLaNqiQb8T4COx
         UVJA4KmlnMVwc7N2B5N1DSR1qQs6PHm/BYc33LtzEYYGcCX+8isolKSM62tF+9jBnxdr
         oEnr0MMHjpYUTlqRUYsdLiuGj5MfG3HfOjYZ8GGKYC3vxs4UCxzR8/XZu0zut0YBM9AA
         uRBIh0LmMK5i3mTF480DY7+txhMUx5Bgc4kUZpjmOzqYnLfjhXZR5U1qEmv5uaiSmPQE
         WO34jEJOy8Zjg2CRmyzvIs2XMCxJWnK6g3fLPP2HCqpTaWKsqoiT7V9F5tfUt4i8KHs3
         FpIg==
X-Gm-Message-State: ABy/qLZBdZUqgx7jXznFfYeayV3G1+NGlWZMortev71wSEisue3bVPGk
        KBotwe2FvQnnjLpcpcZdodBEIl7kMqCiovgQFj4=
X-Google-Smtp-Source: APBJJlEAxcBioR5TJwszhz+Bruj0CP8tAOLVhJDYGJyGcBnYe3UzCfBmlz1btMn9Bek/NwwC5rd4kWsT6UDbN9fFKkU=
X-Received: by 2002:aa7:c616:0:b0:51d:d2b9:54a0 with SMTP id
 h22-20020aa7c616000000b0051dd2b954a0mr6631514edq.2.1688376390084; Mon, 03 Jul
 2023 02:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230703081801.900093-1-dangel101@gmail.com>
In-Reply-To: <20230703081801.900093-1-dangel101@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 3 Jul 2023 11:26:18 +0200
Message-ID: <CAFqH_53X+RnFppzWgowQsWZuTYX83132foRrohPTok59hO-qBg@mail.gmail.com>
Subject: Re: [PATCH] selftests/input: add tests for the EVIOCSCLOCKID ioctl
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     shuah@kernel.org, usama.anjum@collabora.com, eballetbo@kernel.org,
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

Many thanks for the patch. Only a minor comment, see below.

Missatge de Dana Elfassy <delfassy@redhat.com> del dia dl., 3 de jul.
2023 a les 10:18:
>
> This patch introduces tests for the EVIOCSCLOCKID ioctl, for full
> coverage of the different clkids
>
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> ---
> This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
> [1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/
>
>  tools/testing/selftests/input/evioc-test.c | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
> index ad7b93fe39cf..81d5336d93ac 100644
> --- a/tools/testing/selftests/input/evioc-test.c
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -234,4 +234,36 @@ TEST(eviocsrep_set_repeat_settings)
>         selftest_uinput_destroy(uidev);
>  }
>
> +TEST(eviocsclockid_set_clockid)
> +{
> +       struct selftest_uinput *uidev;
> +       int clkid = 0;

instead of using "magic numbers" for all the CLOCK_* types I'd
recommend to use the defined ones in include/uapi/linux/time.h, so you
can use CLOCK_REALTIME,
CLOCK_MONOTONIC and CLOCK_BOOTTIME in the code.

> +       int rc;
> +
> +       rc = selftest_uinput_create_device(&uidev, -1);
> +       ASSERT_EQ(0, rc);
> +       ASSERT_NE(NULL, uidev);
> +
> +       // case CLOCK_REALTIME
> +       rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
> +       ASSERT_EQ(0, rc);
> +
> +       // case CLOCK_MONOTONIC
> +       clkid = 1;
> +       rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
> +       ASSERT_EQ(0, rc);
> +
> +       // case CLOCK_BOOTTIME
> +       clkid = 7;
> +       rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
> +       ASSERT_EQ(0, rc);
> +
> +       // case default
> +       clkid = -1;
> +       rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
> +       ASSERT_EQ(-1, rc);
> +
> +       selftest_uinput_destroy(uidev);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.41.0
>

Cheers,
  Enric
