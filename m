Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043E7732B2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbjFPJLy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343718AbjFPJLa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 05:11:30 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE722728
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 02:10:16 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-43de86a069fso106759137.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686906616; x=1689498616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwoZWPuITfV7xtUPTayl5YgWaHXdGysybtbFzh1Z+XI=;
        b=z/NAXZXkCrcc8sa5iqtoksP8Bl6lvx6g85Fo610HsC3ZpAiNY7VBRRMgG1q/WenVpd
         adb2O6tskm/auS9Eav9jCsa9i9ZXqUh37QyR3MjTHn4C4r/NaScZdX6KbpK3DfUHFGsW
         x52C24QurUNv+C0We5di/1aFWum3pmGLgrvw3Yf1tU35jZihlv7f4z2xhOVlIrdcafze
         26wx0v6ww9TCLgHsn6Rr6vdMr7DlGij0mkfVJ0z8wTWrgxhPYJ2dnj3/TOnUegKtzZlq
         YUGSzcShl2ye9uj94tro/cynv7bmBumaqMsTtW/H20BNJmYlLVTLv4gVG1YU9sgwB3cr
         EWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906616; x=1689498616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwoZWPuITfV7xtUPTayl5YgWaHXdGysybtbFzh1Z+XI=;
        b=bnYfebNly9PIglvEN2wZzF0lomauaV4Um/kmhm2eNJCegF0NBWHFNv7Z3U2IVR9MvT
         OEtrVkfAQsPBVDJwt5qzUihgtmu4Ngp0xsy9IO9GGQoC33ljI6ldHbdRI98TKQGJmJOe
         jZUtUlAcgPJOnVYrLd4ae5ZgGNgx66i4wNNT8Ya/wAUTE1cV/Wls1NXKdPfs2364Be2e
         v4i+iTP1Twc6RtJmHOvPi9Qmz1XcFCJuYOpHaL1NNmOKU9ILsYlv/B+Ds9OEg31g26Xx
         2ehIJIUkIl+dwAXEPxLIX9HAT0gjMafW2kDvw8rXsGCsIj2994EBeLiedEHz5d3fjbzH
         joYA==
X-Gm-Message-State: AC+VfDxKkflv6li8oFqQVuT1be1rvKlYX8s+Rkj/Y8H3BIG2CU1ZZN3Z
        uclhSkDwS0cIyyZgnGUfFhr8sLz5K7lJivezolZ7rQ==
X-Google-Smtp-Source: ACHHUZ6C8sKhop3/ZyD3wgfQleYWH3WAE/H+n9ASg9+lsIcVmjyFmGIsh8+9xg61H2PzwGsam4GmlfnYNysqPmFrglY=
X-Received: by 2002:a67:f655:0:b0:43f:527e:8082 with SMTP id
 u21-20020a67f655000000b0043f527e8082mr952919vso.21.1686906615944; Fri, 16 Jun
 2023 02:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com> <20230411171521.29678-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230411171521.29678-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 16 Jun 2023 11:10:05 +0200
Message-ID: <CAMRc=MfOSsZ=d0m41HEvt1ZwFjwSk=_AyOarnSPMANeUtG5Crg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests: gpio: gpio-sim: Use same variable name
 for sysfs pathname
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 7:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> SYSFS_PATH can be used locally and globally, especially that has
> the same content.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  tools/testing/selftests/gpio/gpio-sim.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/sel=
ftests/gpio/gpio-sim.sh
> index fa2ce2b9dd5f..6fb66a687f17 100755
> --- a/tools/testing/selftests/gpio/gpio-sim.sh
> +++ b/tools/testing/selftests/gpio/gpio-sim.sh
> @@ -152,9 +152,9 @@ sysfs_set_pull() {
>         local PULL=3D$4
>         local DEVNAME=3D`configfs_dev_name $DEV`
>         local CHIPNAME=3D`configfs_chip_name $DEV $BANK`
> -       local SYSFSPATH=3D"/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_g=
pio$OFFSET/pull"
> +       local SYSFS_PATH=3D"/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_=
gpio$OFFSET/pull"
>
> -       echo $PULL > $SYSFSPATH || fail "Unable to set line pull in sysfs=
"
> +       echo $PULL > $SYSFS_PATH || fail "Unable to set line pull in sysf=
s"
>  }
>
>  # Load the gpio-sim module. This will pull in configfs if needed too.
> --
> 2.40.0.1.gaa8946217a0b
>

Applied, thanks!

Bart
