Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD21E4DDD44
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiCRPux (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 11:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiCRPux (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 11:50:53 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81A2D0241;
        Fri, 18 Mar 2022 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647618572;
  x=1679154572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wcKA0KxoiU/AM8nvFRewTqVOc2fCyIBAGriShKCLLSk=;
  b=dfmcli8lf8C/XrNUNuU0x786nL0kFuaD/1YntgoYgOkvvwBibABvLFqR
   8YnSP88uLG367QGRmB6CtOph3gD/bKCJsKLqXV51LZxaJ4A3Wb51+XcVv
   gRLTNBMRpvtE8DYR12nTyt4z17lK/ZTk8odYASip4n5FVK0cgSvQkO6gu
   iVVn9Ymg/3zeVY154dMkslySSKtEGFqvwOPIRZOJliBSQBAo+F4Nd7zHO
   j5ZtfM2r5MK/8TkH6j1v9l0lmmoRRM2/sZKjAghrqU05Ko+lztH4yDDx4
   5tYjz0V8FC5RJNZE2641t2usoyopTo2t2IhXLjTsh+2yfm/56KAYRel2R
   g==;
Date:   Fri, 18 Mar 2022 16:49:27 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 07/10] iio: light: opt3001: add roadtest
Message-ID: <20220318154927.GA32172@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-8-vincent.whitchurch@axis.com>
 <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 15, 2022 at 12:11:50AM +0100, Brendan Higgins wrote:
> On Fri, Mar 11, 2022 at 11:24 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > +class TestOPT3001(UMLTestCase):
> 
> I am partial to starting with UML since there are a lot of nice easy
> things about starting there; however, I imagine people will eventually
> want to use this on other architectures (speaking from experience).
> How difficult do you think it would be to extend this to support
> manipulating fake devices in say QEMU?

It should be possible, but upstream QEMU doesn't have everything that we
need so some work is needed there.  Also, of course work is need to
provide user space for running the tests and communicating between the
virtual machine and the backend:

- We need user space, so build scripts would need to be provided to
  cross-compile busybox and Python (and whatever libraries it needs) for
  the target architecture.

- We also use UML's hostfs feature to make things transparent to the
  user and to avoid having to set up things like networking for
  communication between the host and the backend.  I think QEMU's 9pfs
  support can be used as a rootfs too but it's not something I've
  personally tested.

- We use virtio-i2c and virtio-gpio and use virtio-uml which uses the
  vhost-user API to communicate from UML to the backend.  The latest
  version of QEMU has support for vhost-user-i2c, but vhost-user-gpio
  doesn't seem to have been merged yet, so work is needed on the QEMU
  side.  This will also be true for other buses in the future, if they
  are implemented with new virtio devices.

- For MMIO, UML has virtio-mmio which allows implementing any PCIe
  device (and by extension any platform device) outside of UML, but last
  I checked, upstream QEMU did not have something similar.

> I also have some colleagues inside of Google that worked on some
> projects to simulate simple devices on an FPGA to test software and
> adjacent devices in a conceptually similar way; one of these teams
> built a Domain Specific Language kind of like roadtest to implement
> the tests and the environment for the tests. The main reason I mention
> this here is I am thinking about maybe one day having an API you can
> implement so you can run your roadtests on UML, QEMU, or on any
> emulator or hardware testbed that implements the appropriate API.
> 
> I'll try to dig up some people who might be interested and add them here.
> 
> > +    dts = DtFragment(
> > +        src="""
> > +&i2c {
> > +    light-sensor@$addr$ {
> > +        compatible = "ti,opt3001";
> > +        reg = <0x$addr$>;
> > +    };
> > +};
> > +        """,
> > +        variables={
> > +            "addr": DtVar.I2C_ADDR,
> > +        },
> > +    )
> > +
> > +    @classmethod
> > +    def setUpClass(cls) -> None:
> > +        insmod("opt3001")
> > +
> > +    @classmethod
> > +    def tearDownClass(cls) -> None:
> > +        rmmod("opt3001")
> > +
> > +    def setUp(self) -> None:
> > +        self.driver = I2CDriver("opt3001")
> > +        self.hw = Hardware("i2c")
> > +        self.hw.load_model(OPT3001)
> > +
> > +    def tearDown(self) -> None:
> > +        self.hw.close()
> > +
> > +    def test_illuminance(self) -> None:
> > +        data = [
> > +            # Some values from datasheet, and 0
> > +            (0b_0000_0000_0000_0000, 0),
> > +            (0b_0000_0000_0000_0001, 0.01),
> > +            (0b_0011_0100_0101_0110, 88.80),
> > +            (0b_0111_1000_1001_1010, 2818.56),
> > +        ]
> > +        with self.driver.bind(self.dts["addr"]) as dev:
> > +            luxfile = dev.path / "iio:device0/in_illuminance_input"
> > +
> > +            for regval, lux in data:
> > +                self.hw.reg_write(REG_RESULT, regval)
> > +                self.assertEqual(read_float(luxfile), lux)
> 
> I love the framework; this looks very easy to use.
> 
> One nit about this test; it seems like you cover just one test case
> here - the happy path. Can you cover some other one? Particularly some
> error paths?
> 
> Sorry, I am not trying to be cheeky here; it looks like this driver
> actually should probably be fully (or very close to fully) testable
> via roadtest as I understand it. It only looks like there are a
> handful of cases to cover for the driver: the device is busy, the
> device returned something invalid, the user requested something
> invalid, and several SMBus read/write failures - it really only looks
> like there are a handful of paths and I think they are all accessible
> via the I2C interface (except for maybe the user requesting something
> invalid).

Yes, there are more things that could be tested in this driver.
However, as the commit message says, I only indented this particular
test to serve as a regression test for the specific bug fix, which would
need an environment where the chip detects 0 lux to be able to test on
real hardware.  There are a few reasons for this:

 - Unlike the other drivers being tested in this series, I don't have
   access to boards with this chip so my interest in this particular
   piece of hardware is limited.

 - I actually started writing more tests for this driver earlier on
   (specifically, testing the configuration which uses interrupts), but
   I quickly discovered that this driver has race conditions which
   result in unbalanced mutex locking (in brief: the ok_to_ignore_lock
   stuff is broken).  This shows the value of the test framework, but I
   also didn't want to write non-trivial fixes for drivers where I
   didn't have real hardware to test.

 - Also, some paths in this driver needs a modification to be tested
   under roadtest.  It uses wait_event_timeout() with a fixed value, but
   we cannot guarantee that this constraint is met in the test
   environment since it depends on things like CPU load on the host.

   (Also, we use UML's "time travel" feature which essentially
   fast-forwards through idle time, so the constraint can never be met
   in practice.)
   
   So the timeout parameter would have to be made adjustable via say a
   module parameter, to be able to make it infinite (to test the normal
   case) and not (to be able to test timeout handling).  I think this
   could be done fairly cleanly with a one- or two-liner patch to the
   driver and by hiding the details in a header file behind a
   roadtest-specific config option, but I wanted to avoid having to
   patch the kernel proper for the initial version of the framework.

For vcnl4000, I have actually inherited some out-of-tree patches which
are in need of mainlining so the tests are a bit more complete since I'm
hoping to send some patches to that driver soon.  The period mode busy
handling is not tested there either though, I can try to add that.

As for I2C API failures, I have not added tests for them in any of the
drivers.  There's not much the test cases could assert, other than
perhaps error propagation, so it's unclear if there is enough value
compared to the effort required to implement test cases to make sure
that every I2C transaction's failure path is tested.

But I think that we do want to at least make sure the error paths are
executed, to check that drivers don't crash or deadlock due to faulty
cleanups and the like.  A way to solve this could be to implement fault
injection support in the I2C framework.  The fail-nth feature could be
used to systemically trigger each and every I2C transaction failure and
check that the driver doesn't blow up, while using the roadtest as a
means to hit the various code paths in the driver during each of the
iterations of fail-nth.  Fault injection support would also be helpful
when testing on real hardware.
