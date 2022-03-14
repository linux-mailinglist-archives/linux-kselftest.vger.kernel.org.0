Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC81D4D9022
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbiCNXNR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Mar 2022 19:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343600AbiCNXNQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Mar 2022 19:13:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F193BFAB
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 16:12:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id yy13so37504729ejb.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13A/gfkIaAByq4gAjyXkarTV6d8yj2S6x1jqYzFsBbY=;
        b=XyhHGdtsqR5jO4+gdhJ+ojCimLghZaCx6WwKcAAr9p/2GHkSdRv19zrt+XUtu0LuJ1
         4Gi3j0ozCaHiWgxhJc4o3NtmD//SjQ72LePzqe4q9e8nM9zUasMsb8biiDYMtwoPpEiK
         HiEQwniQHvCSrEdIgduOKuvq5s7i1I61Hc25rgZasnYsPug81ADoCsCnTDZdjqQkvvrc
         u7MiR0TGkpcQ8Zcq8IwJmMfz/vudNt99WnaGo1qHlKZqAE+13K9TG1hMprm48aLrDHKG
         KLTxKsyGj+myiFI0F5MUapN41yj6qFYTl4WnkkqKuAziWcCDY/3yvCe8iF3wjdp+upo9
         pSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13A/gfkIaAByq4gAjyXkarTV6d8yj2S6x1jqYzFsBbY=;
        b=TlAczyHugFFHXKPyOEU6SDyIhrN8DLubM/PrFG5No9k6lp+aMpSs/d7Cn7sN5Qam0t
         ZHnN2ycLAHJQxh4O8L3MQpsLDNLp4iMHDNsHKTepj3ACAFqq+vxPO4Qp6bXfmDQa7zjd
         51jvoxsw/OMLqRw7B4LhczSmiwx5CMPrHGES0qaE/LJnn353wI5dHlIipX0VgkyQ51yn
         33uGNzPWToCpFUGpCBo/KhuN/l/gSm26wzZfvx39zCGLDu3YPdWOYumPLEsoqKgPCMfT
         +tcYJb9+ytur5iRGyr67lO6OGh2hGrSRGF+/101o/WR3f6bUmgHqVoAN1xjyds4VT0oh
         mivw==
X-Gm-Message-State: AOAM532ZDhRxHnM6dVBdVKaKtEPbWkmQ3FjFiT6Yj8pZMNlOTSx2LjSE
        YaxT6gzxfADMQmpctoQ97Paz06Mwnl/P197a5+yLDQ==
X-Google-Smtp-Source: ABdhPJxrYa+KB1WbMq/YAdFrphjTMXfrrUez93q/arw+NPP8ockEEmt+q4BVAJMOhiHKlLzSTBYxF0kk+h/zL39D7LI=
X-Received: by 2002:a17:906:36ce:b0:6d6:e540:ed65 with SMTP id
 b14-20020a17090636ce00b006d6e540ed65mr20941241ejc.330.1647299522669; Mon, 14
 Mar 2022 16:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220311162445.346685-1-vincent.whitchurch@axis.com> <20220311162445.346685-8-vincent.whitchurch@axis.com>
In-Reply-To: <20220311162445.346685-8-vincent.whitchurch@axis.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 14 Mar 2022 19:11:50 -0400
Message-ID: <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
Subject: Re: [RFC v1 07/10] iio: light: opt3001: add roadtest
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Mar 11, 2022 at 11:24 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Add a regression test for the problem fixed by the following patch,
> which would require specific environmental conditions to be able to be
> reproduced and regression-tested on real hardware:
>
>  iio: light: opt3001: Fixed timeout error when 0 lux
>  https://lore.kernel.org/lkml/20210920125351.6569-1-valek@2n.cz/
>
> No other aspects of the driver are tested.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../roadtest/roadtest/tests/iio/__init__.py   |  0
>  .../roadtest/roadtest/tests/iio/config        |  1 +
>  .../roadtest/tests/iio/light/__init__.py      |  0
>  .../roadtest/roadtest/tests/iio/light/config  |  1 +
>  .../roadtest/tests/iio/light/test_opt3001.py  | 95 +++++++++++++++++++
>  5 files changed, 97 insertions(+)
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py
>
> diff --git a/tools/testing/roadtest/roadtest/tests/iio/__init__.py b/tools/testing/roadtest/roadtest/tests/iio/__init__.py
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tools/testing/roadtest/roadtest/tests/iio/config b/tools/testing/roadtest/roadtest/tests/iio/config
> new file mode 100644
> index 000000000000..a08d9e23ce38
> --- /dev/null
> +++ b/tools/testing/roadtest/roadtest/tests/iio/config
> @@ -0,0 +1 @@
> +CONFIG_IIO=y
> diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/__init__.py b/tools/testing/roadtest/roadtest/tests/iio/light/__init__.py
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/config b/tools/testing/roadtest/roadtest/tests/iio/light/config
> new file mode 100644
> index 000000000000..b9753f2d0728
> --- /dev/null
> +++ b/tools/testing/roadtest/roadtest/tests/iio/light/config
> @@ -0,0 +1 @@
> +CONFIG_OPT3001=m
> diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py b/tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py
> new file mode 100644
> index 000000000000..abf20b8f3516
> --- /dev/null
> +++ b/tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright Axis Communications AB
> +
> +from typing import Any, Final
> +
> +from roadtest.backend.i2c import SMBusModel
> +from roadtest.core.devicetree import DtFragment, DtVar
> +from roadtest.core.hardware import Hardware
> +from roadtest.core.modules import insmod, rmmod
> +from roadtest.core.suite import UMLTestCase
> +from roadtest.core.sysfs import I2CDriver, read_float
> +
> +REG_RESULT: Final = 0x00
> +REG_CONFIGURATION: Final = 0x01
> +REG_LOW_LIMIT: Final = 0x02
> +REG_HIGH_LIMIT: Final = 0x03
> +REG_MANUFACTURER_ID: Final = 0x7E
> +REG_DEVICE_ID: Final = 0x7F
> +
> +REG_CONFIGURATION_CRF: Final = 1 << 7
> +
> +
> +class OPT3001(SMBusModel):
> +    def __init__(self, **kwargs: Any) -> None:
> +        super().__init__(regbytes=2, byteorder="big", **kwargs)
> +        # Reset values from datasheet
> +        self.regs = {
> +            REG_RESULT: 0x0000,
> +            REG_CONFIGURATION: 0xC810,
> +            REG_LOW_LIMIT: 0xC000,
> +            REG_HIGH_LIMIT: 0xBFFF,
> +            REG_MANUFACTURER_ID: 0x5449,
> +            REG_DEVICE_ID: 0x3001,
> +        }
> +
> +    def reg_read(self, addr: int) -> int:
> +        val = self.regs[addr]
> +
> +        if addr == REG_CONFIGURATION:
> +            # Always indicate that the conversion is ready.  This is good
> +            # enough for our current purposes.
> +            val |= REG_CONFIGURATION_CRF
> +
> +        return val
> +
> +    def reg_write(self, addr: int, val: int) -> None:
> +        assert addr in self.regs
> +        self.regs[addr] = val
> +
> +
> +class TestOPT3001(UMLTestCase):

I am partial to starting with UML since there are a lot of nice easy
things about starting there; however, I imagine people will eventually
want to use this on other architectures (speaking from experience).
How difficult do you think it would be to extend this to support
manipulating fake devices in say QEMU?

I also have some colleagues inside of Google that worked on some
projects to simulate simple devices on an FPGA to test software and
adjacent devices in a conceptually similar way; one of these teams
built a Domain Specific Language kind of like roadtest to implement
the tests and the environment for the tests. The main reason I mention
this here is I am thinking about maybe one day having an API you can
implement so you can run your roadtests on UML, QEMU, or on any
emulator or hardware testbed that implements the appropriate API.

I'll try to dig up some people who might be interested and add them here.

> +    dts = DtFragment(
> +        src="""
> +&i2c {
> +    light-sensor@$addr$ {
> +        compatible = "ti,opt3001";
> +        reg = <0x$addr$>;
> +    };
> +};
> +        """,
> +        variables={
> +            "addr": DtVar.I2C_ADDR,
> +        },
> +    )
> +
> +    @classmethod
> +    def setUpClass(cls) -> None:
> +        insmod("opt3001")
> +
> +    @classmethod
> +    def tearDownClass(cls) -> None:
> +        rmmod("opt3001")
> +
> +    def setUp(self) -> None:
> +        self.driver = I2CDriver("opt3001")
> +        self.hw = Hardware("i2c")
> +        self.hw.load_model(OPT3001)
> +
> +    def tearDown(self) -> None:
> +        self.hw.close()
> +
> +    def test_illuminance(self) -> None:
> +        data = [
> +            # Some values from datasheet, and 0
> +            (0b_0000_0000_0000_0000, 0),
> +            (0b_0000_0000_0000_0001, 0.01),
> +            (0b_0011_0100_0101_0110, 88.80),
> +            (0b_0111_1000_1001_1010, 2818.56),
> +        ]
> +        with self.driver.bind(self.dts["addr"]) as dev:
> +            luxfile = dev.path / "iio:device0/in_illuminance_input"
> +
> +            for regval, lux in data:
> +                self.hw.reg_write(REG_RESULT, regval)
> +                self.assertEqual(read_float(luxfile), lux)

I love the framework; this looks very easy to use.

One nit about this test; it seems like you cover just one test case
here - the happy path. Can you cover some other one? Particularly some
error paths?

Sorry, I am not trying to be cheeky here; it looks like this driver
actually should probably be fully (or very close to fully) testable
via roadtest as I understand it. It only looks like there are a
handful of cases to cover for the driver: the device is busy, the
device returned something invalid, the user requested something
invalid, and several SMBus read/write failures - it really only looks
like there are a handful of paths and I think they are all accessible
via the I2C interface (except for maybe the user requesting something
invalid).
