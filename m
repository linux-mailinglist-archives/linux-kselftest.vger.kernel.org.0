Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B78746BFD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGDIeA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGDIdX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 04:33:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B043F3;
        Tue,  4 Jul 2023 01:33:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so6843964a12.2;
        Tue, 04 Jul 2023 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688459597; x=1691051597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/c3Osc+qzYUVB7Nmy8eYbeJkEHcCe9Nkfgf5cJF1fR0=;
        b=Hu8GF4ume+33zVPcRcAzfhyWrGhX9CP3blkMI2wl00h4SA0+//2723sp9wvZ1XVLul
         dvwppSniPQAEJZ99Im1GCkvZtCspnWB1N6tZDUHxVMY4QJDGp0nyVDUh7jT6pJXCngax
         0s8hcExmv7HNFAleDneKdaYKCaLNmFATz6aABrUCQb7tj9l/92lxfTuaPQkrNFq7cVgW
         YO4nP46zRw2NYf/vHr0DSzYYm+jnzAF+RJyRrexI0Z8SMrB1FQGqOoumqfhpvY0glDgJ
         Y8Sj3IOX6QnW7DcnJxHW6kD4/4eIV+UcPiHgWevAGeG81pqsL4aOb/jJwJBwWCW7LYR9
         6H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459597; x=1691051597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c3Osc+qzYUVB7Nmy8eYbeJkEHcCe9Nkfgf5cJF1fR0=;
        b=P+CEn2kiO+LKrL1FAw2iO/qlBb69WyOM88GdU5NwmR7C5PUAGvACx/Hr39eeVfaX+n
         qalgsx9Ia0JuuikxOcutJxMpJegOa9r3MI/DXz9haV4QnvfboraX3CIyNbruB2BwCJc+
         rn/dy/dTIVy5VmOQ8SdEc8Hnabh4oEQocOQC8MEkCBaTt2tVuj3P8v5SxYiEkeSBm3Qb
         umFUzQX1P4H9fXYJObpETz4ACM/+i6LcyzlaBvxQFQuqTV1wff2NsZY/BL/V/nIYYiEt
         1w+jjT6OqQPlbmx1rTgbe5ncr9UWzLAeFRr8O3RSqwEdZaUCeptU5lWRicoAtsf72O52
         uCCQ==
X-Gm-Message-State: ABy/qLbSRFBNK0ZUXY9jSB2bbcES22U8xoHWVBeb5rufDYNd+DKSpP8H
        ePZZgylz64GmiyoQKomYPPUTG5rSj/iDMWjiKaE=
X-Google-Smtp-Source: APBJJlFP83Bj8mVZCOjb2sMOmBMemTEMEsFPAcrYr0NHdm6dy2d4qLyRt8n5yBV7ftnqEchbXDw6Fb9o53lTQQgdBeY=
X-Received: by 2002:aa7:cf18:0:b0:51e:cb4:2b40 with SMTP id
 a24-20020aa7cf18000000b0051e0cb42b40mr4771371edy.6.1688459596752; Tue, 04 Jul
 2023 01:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230703094722.909348-1-dangel101@gmail.com>
In-Reply-To: <20230703094722.909348-1-dangel101@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 4 Jul 2023 10:33:04 +0200
Message-ID: <CAFqH_52-DWon3u6c4=HBnrYKmg7OigT1Cri0xthxgPm5mvPyRQ@mail.gmail.com>
Subject: Re: [PATCHv2] selftests/input: add tests for the EVIOCSCLOCKID ioctl
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

Thank you for the patch.

Missatge de Dana Elfassy <delfassy@redhat.com> del dia dl., 3 de jul.
2023 a les 11:47:
>
> This patch introduces tests for the EVIOCSCLOCKID ioctl, for full
> coverage of the different clkids
>
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>

I ran the tests and look at code coverage of them and they cover what
is expected so

Reviewed-by: Enric Balletbo i Serra <eballetbo@kernel.org>

Cheers,
  Enric


> ---
> Changes in v2:
> - Replaced clkids numerical values with their equivalent definition
>
> This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
> [1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/
>
>  tools/testing/selftests/input/evioc-test.c | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
> index ad7b93fe39cf..83ce1a3c9b84 100644
> --- a/tools/testing/selftests/input/evioc-test.c
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -17,6 +17,7 @@
>  #include <sys/stat.h>
>  #include <time.h>
>  #include <unistd.h>
> +#include <linux/time.h>
>
>  #include "../kselftest_harness.h"
>
> @@ -234,4 +235,33 @@ TEST(eviocsrep_set_repeat_settings)
>         selftest_uinput_destroy(uidev);
>  }
>
> +TEST(eviocsclockid_set_clockid)
> +{
> +       struct selftest_uinput *uidev;
> +       int clkid = CLOCK_REALTIME;
> +       int rc;
> +
> +       rc = selftest_uinput_create_device(&uidev, -1);
> +       ASSERT_EQ(0, rc);
> +       ASSERT_NE(NULL, uidev);
> +
> +       rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
> +       ASSERT_EQ(0, rc);
> +
> +       clkid = CLOCK_MONOTONIC;
> +       rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
> +       ASSERT_EQ(0, rc);
> +
> +       clkid = CLOCK_BOOTTIME;
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
