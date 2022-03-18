Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53954DE21E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 21:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiCRUKu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCRUKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 16:10:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBB523D76C;
        Fri, 18 Mar 2022 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=O6uGUdoW6Lxm5JY3J83NMEK8xoTghOZASOlRneAdaZw=;
        t=1647634168; x=1648843768; b=bQEwG1o/Vm4jlHUDF+ToofOnblLQp81bKySVJxlmbEbsTGn
        4gvHkbTR8d8B3MxOztQno0siDPdV5gVSqAWK19RmH5esSBx41VpshuQQbAes/L7fDsZlG1FvbE+yW
        km60nvngaxquE56d8CoLT9Pz71P0SHxF7cXiH4ITdhHSWhsZSluCGW/IxL43NADxXMySUK7FKMBCM
        ZSiZ5bR3aU9bPSnXeY0LgBzU2MZoKNjydhmBzZEJnWDyXfp+xRxlh13U0E6fFejC/ZBY37KCpiV3f
        exQi9IIl6VfLm+FroqGiypZHdOmoKjTfJbasmlV02WZMhDWilEIZixke0stAAqSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nVIuF-00F0HF-AC;
        Fri, 18 Mar 2022 21:09:03 +0100
Message-ID: <1e61b0f21794e67fb4e87dc41fab90829d3c7cd6.camel@sipsolutions.net>
Subject: Re: [RFC v1 07/10] iio: light: opt3001: add roadtest
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Date:   Fri, 18 Mar 2022 21:09:02 +0100
In-Reply-To: <20220318154927.GA32172@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
         <20220311162445.346685-8-vincent.whitchurch@axis.com>
         <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
         <20220318154927.GA32172@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-03-18 at 16:49 +0100, Vincent Whitchurch wrote:
> 
> It should be possible, but upstream QEMU doesn't have everything that we
> need so some work is needed there.  Also, of course work is need to
> provide user space for running the tests and communicating between the
> virtual machine and the backend:
> 
> - We need user space, so build scripts would need to be provided to
>   cross-compile busybox and Python (and whatever libraries it needs) for
>   the target architecture.

You could possibly use some nix recipes for all of this, but that's a
fairly arcane thing (we use it, but ...)

> - We also use UML's hostfs feature to make things transparent to the
>   user and to avoid having to set up things like networking for
>   communication between the host and the backend.  I think QEMU's 9pfs
>   support can be used as a rootfs too but it's not something I've
>   personally tested.

That works just fine, yes. We used to do exactly this in the wireless
test suite before we switched to UML, but the switch to UML was due to
the "time-travel" feature.

https://w1.fi/cgit/hostap/tree/tests/hwsim/vm

has support for both UML and qemu/kvm.

> - We use virtio-i2c and virtio-gpio and use virtio-uml which uses the
>   vhost-user API to communicate from UML to the backend.  The latest
>   version of QEMU has support for vhost-user-i2c, but vhost-user-gpio
>   doesn't seem to have been merged yet, so work is needed on the QEMU
>   side.  This will also be true for other buses in the future, if they
>   are implemented with new virtio devices.
> 
> - For MMIO, UML has virtio-mmio which allows implementing any PCIe
>   device (and by extension any platform device) outside of UML, but last
>   I checked, upstream QEMU did not have something similar.

I think you have this a bit fuzzy.

The virtio_uml[.c] you speak of is the "bus" driver for virtio in UML.
Obviously, qemu has support for virtio, so you don't need those bits.

Now, virtio_uml is actually the virtio (bus) driver inside the kernel,
like you'd have virtio-mmio/virtio-pci in qemu. However, virtio_uml
doesn't implement the devices in the hypervisor, where most qemu devices
are implemented, but uses vhost-user to run the device implementation in
a separate userspace. [1]

Now we're talking about vhost-user to talk to the device, and qemu
supports this as well, in fact the vhost-user spec is part of qemu:
https://git.qemu.org/?p=qemu.git;a=blob;f=docs/system/devices/vhost-user.rst;h=86128114fa3788a73679f0af38e141021087c828;hb=1d60bb4b14601e38ed17384277aa4c30c57925d3
https://www.qemu.org/docs/master/interop/vhost-user.html

The docs on how to use it are here:
https://www.qemu.org/docs/master/system/devices/vhost-user.html

So once you have a device implementation (regardless of whether it's for
use with any of the virtio-i2c, arch/um/drivers/virt-pci.c, virtio-gpio,
virtio-net, ... drivers) you can actually connect it to virtual machines
running as UML or in qemu.

(Actually, that's not strictly true today since it's
arch/um/drivers/virt-pci.c and I didn't get a proper device ID assigned
etc since it was for experimentation, I guess if we make this more
commonly used then we should move it to drivers/pci/controller/virtio-
pci.c and actually specify it in the OASIS virtio spec., at the very
least it'd have to be possible to compile this and lib/logic_iomem.c on
x86, but that's possible. Anyway I think PCI(e) is probably low on your
list of things ...)

>  - Also, some paths in this driver needs a modification to be tested
>    under roadtest.  It uses wait_event_timeout() with a fixed value, but
>    we cannot guarantee that this constraint is met in the test
>    environment since it depends on things like CPU load on the host.
> 
>    (Also, we use UML's "time travel" feature which essentially
>    fast-forwards through idle time, so the constraint can never be met
>    in practice.)

Wohoo! This makes me very happy, finally somebody else who uses it :-)



[1] As an aside, you might be interested in usfstl (which you can find
at https://github.com/linux-test-project/usfstl) which is one way you
could implement the device side - though the focus here is on making a
device implementation easy while under "time-travel" mode.

If you ever want to use time-travel with multiple machines or actually
with virtio devices, it also contains the necessary controller program
to glue the entire simulation together. We use this very successfully to
test the (real but compiled for x86) wifi firmware for iwlwifi together
with the real driver actually seeing a PCIe device in UML, under time-
travel :)

johannes
