Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE04260E1FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiJZNWH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiJZNVo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 09:21:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505613135D;
        Wed, 26 Oct 2022 06:21:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b29so10808479pfp.13;
        Wed, 26 Oct 2022 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHPP9My845lPPpHorojUrpJmkzrewrykow1RhCFqWhQ=;
        b=Bn4YxATbe3yVDzwdP7KKXjbWlk/YiGjPUPeN/fWnH8BCQFVfesbsjGrqnA2Cer0YGw
         3IGavYAj7Q/WI4OWw3PrlMPeTiaZqxfOT9CmC4lfO600hDfiUvvZMpKrbqj6/OemKJVZ
         Uxccb8VJ4ZJ8TTN6Ai5zCkHhdIH3kxCZHvY9WF4Qjv73AJo+473PPFVvhs8ZlJ2SAtPg
         FlTtjZ1hmkhSfSWpMy3dHDfJRhq0PHsetKo32XxUCO/YvhiHP+xyc5fmlraQu7lmdLgf
         6e4GqIBInQu2+WZiKvnDCXYxkL6x7pppUO5Rsemblqkoa6or1ejK5TJaFAg5S0xjfKdw
         azGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHPP9My845lPPpHorojUrpJmkzrewrykow1RhCFqWhQ=;
        b=ZgUpncpjyGAqrwLhKbjBUo0Yk9E1Y6eCY/O9/sb7gWE0hHSKOCvFlMW1UJwFj5x9ar
         fqcLBmErYRxR+X5nAacHyGtQZs/GQYMzWeQrKJGosa1e3JQkB5a11lF1N1Eu1rgBLr1/
         EqjNScMmQoW5Epjja//8dKnMW75Nq3kmJ0qLNRxp5XEY3PvsSSwumcUVTqvEw+4TisY0
         i93xarbCJEtNzIhhbMpQmDLcDZGNhMFWxgYU2g1C2r93M2S5IVgRXdosyfCcFUNG7B6a
         oaWZ4or1IwAWtxpCUZJIgK7CkD+2xXslvRSsZ2fNrmplawyS8X/CnjMSKl7ngHpLWxAN
         PrmQ==
X-Gm-Message-State: ACrzQf3wmbz34Mz3f9hLf924GXbMKL2U+f9Zxm6Ct/VgXwBnpiOCGY9j
        hbZk5H+kxiNr8fs/1svs2SE=
X-Google-Smtp-Source: AMsMyM6Rkdgsz4bGjJTPlKFReDxM9AA0u9DfuMBn9CYa94FdL0GaTv766/qjMw5HvHiQDB7r4xyTYg==
X-Received: by 2002:a05:6a00:14d4:b0:563:9296:f320 with SMTP id w20-20020a056a0014d400b005639296f320mr43310880pfu.27.1666790469827;
        Wed, 26 Oct 2022 06:21:09 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-29.three.co.id. [180.214.232.29])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b0017bb38e4588sm2890662plh.135.2022.10.26.06.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:21:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E7F96103CDB; Wed, 26 Oct 2022 20:21:05 +0700 (WIB)
Date:   Wed, 26 Oct 2022 20:21:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH hid v11 14/14] Documentation: add HID-BPF docs
Message-ID: <Y1k0QUxp38OhKg+1@debian.me>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
 <20221025093458.457089-15-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D+QQwxdKbJiJiOPW"
Content-Disposition: inline
In-Reply-To: <20221025093458.457089-15-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--D+QQwxdKbJiJiOPW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 11:34:58AM +0200, Benjamin Tissoires wrote:
> diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
> new file mode 100644
> index 000000000000..ba35aa2e2ba8
> --- /dev/null
> +++ b/Documentation/hid/hid-bpf.rst
> @@ -0,0 +1,513 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D
> +HID-BPF
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +HID is a standard protocol for input devices but some devices may require
> +custom tweaks, traditionally done with a kernel driver fix. Using the eB=
PF
> +capabilities instead speeds up development and adds new capabilities to =
the
> +existing HID interfaces.
> +
> +.. contents::
> +    :local:
> +    :depth: 2
> +
> +
> +When (and why) to use HID-BPF
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +There are several use cases when using HID-BPF is better
> +than standard kernel driver fix:
> +
> +Dead zone of a joystick
> +-----------------------
> +
> +Assuming you have a joystick that is getting older, it is common to see =
it
> +wobbling around its neutral point. This is usually filtered at the appli=
cation
> +level by adding a *dead zone* for this specific axis.
> +
> +With HID-BPF, we can apply this filtering in the kernel directly so user=
space
> +does not get woken up when nothing else is happening on the input contro=
ller.
> +
> +Of course, given that this dead zone is specific to an individual device=
, we
> +can not create a generic fix for all of the same joysticks. Adding a cus=
tom
> +kernel API for this (e.g. by adding a sysfs entry) does not guarantee th=
is new
> +kernel API will be broadly adopted and maintained.
> +
> +HID-BPF allows the userspace program to load the program itself, ensurin=
g we
> +only load the custom API when we have a user.
> +
> +Simple fixup of report descriptor
> +---------------------------------
> +
> +In the HID tree, half of the drivers only fix one key or one byte
> +in the report descriptor. These fixes all require a kernel patch and the
> +subsequent shepherding into a release, a long and painful process for us=
ers.
> +
> +We can reduce this burden by providing an eBPF program instead. Once suc=
h a
> +program  has been verified by the user, we can embed the source code int=
o the
> +kernel tree and ship the eBPF program and load it directly instead of lo=
ading
> +a specific kernel module for it.
> +
> +Note: distribution of eBPF programs and their inclusion in the kernel is=
 not
> +yet fully implemented
> +
> +Add a new feature that requires a new kernel API
> +------------------------------------------------
> +
> +An example for such a feature are the Universal Stylus Interface (USI) p=
ens.
> +Basically, USI pens require a new kernel API because there are new
> +channels of communication that our HID and input stack do not support.
> +Instead of using hidraw or creating new sysfs entries or ioctls, we can =
rely
> +on eBPF to have the kernel API controlled by the consumer and to not
> +impact the performances by waking up userspace every time there is an
> +event.
> +
> +Morph a device into something else and control that from userspace
> +------------------------------------------------------------------
> +
> +The kernel has a relatively static mapping of HID items to evdev bits.
> +It cannot decide to dynamically transform a given device into something =
else
> +as it does not have the required context and any such transformation can=
not be
> +undone (or even discovered) by userspace.
> +
> +However, some devices are useless with that static way of defining devic=
es. For
> +example, the Microsoft Surface Dial is a pushbutton with haptic feedback=
 that
> +is barely usable as of today.
> +
> +With eBPF, userspace can morph that device into a mouse, and convert the=
 dial
> +events into wheel events. Also, the userspace program can set/unset the =
haptic
> +feedback depending on the context. For example, if a menu is visible on =
the
> +screen we likely need to have a haptic click every 15 degrees. But when
> +scrolling in a web page the user experience is better when the device em=
its
> +events at the highest resolution.
> +
> +Firewall
> +--------
> +
> +What if we want to prevent other users to access a specific feature of a
> +device? (think a possibly broken firmware update entry point)
> +
> +With eBPF, we can intercept any HID command emitted to the device and
> +validate it or not.
> +
> +This also allows to sync the state between the userspace and the
> +kernel/bpf program because we can intercept any incoming command.
> +
> +Tracing
> +-------
> +
> +The last usage is tracing events and all the fun we can do we BPF to sum=
marize
> +and analyze events.
> +
> +Right now, tracing relies on hidraw. It works well except for a couple
> +of issues:
> +
> +1. if the driver doesn't export a hidraw node, we can't trace anything
> +   (eBPF will be a "god-mode" there, so this may raise some eyebrows)
> +2. hidraw doesn't catch other processes' requests to the device, which
> +   means that we have cases where we need to add printks to the kernel
> +   to understand what is happening.
> +
> +High-level view of HID-BPF
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +The main idea behind HID-BPF is that it works at an array of bytes level.
> +Thus, all of the parsing of the HID report and the HID report descriptor
> +must be implemented in the userspace component that loads the eBPF
> +program.
> +
> +For example, in the dead zone joystick from above, knowing which fields
> +in the data stream needs to be set to ``0`` needs to be computed by user=
space.
> +
> +A corollary of this is that HID-BPF doesn't know about the other subsyst=
ems
> +available in the kernel. *You can not directly emit input event through =
the
> +input API from eBPF*.
> +
> +When a BPF program needs to emit input events, it needs to talk with the=
 HID
> +protocol, and rely on the HID kernel processing to translate the HID dat=
a into
> +input events.
> +
> +Available types of programs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +HID-BPF is built "on top" of BPF, meaning that we use tracing method to
> +declare our programs.
> +
> +HID-BPF has the following attachment types available:
> +
> +1. event processing/filtering with ``SEC("fmod_ret/hid_bpf_device_event"=
)`` in libbpf
> +2. actions coming from userspace with ``SEC("syscall")`` in libbpf
> +3. change of the report descriptor with ``SEC("fmod_ret/hid_bpf_rdesc_fi=
xup")`` in libbpf
> +
> +A ``hid_bpf_device_event`` is calling a BPF program when an event is rec=
eived from
> +the device. Thus we are in IRQ context and can act on the data or notify=
 userspace.
> +And given that we are in IRQ context, we can not talk back to the device.
> +
> +A ``syscall`` means that userspace called the syscall ``BPF_PROG_RUN`` f=
acility.
> +This time, we can do any operations allowed by HID-BPF, and talking to t=
he device is
> +allowed.
> +
> +Last, ``hid_bpf_rdesc_fixup`` is different from the others as there can =
be only one
> +BPF program of this type. This is called on ``probe`` from the driver an=
d allows to
> +change the report descriptor from the BPF program. Once a ``hid_bpf_rdes=
c_fixup``
> +program has been loaded, it is not possible to overwrite it unless the p=
rogram which
> +inserted it allows us by pinning the program and closing all of its fds =
pointing to it.
> +
> +Developer API:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +User API data structures available in programs:
> +-----------------------------------------------
> +
> +.. kernel-doc:: include/uapi/linux/hid_bpf.h
> +.. kernel-doc:: include/linux/hid_bpf.h
> +
> +Available tracing functions to attach a HID-BPF program:
> +--------------------------------------------------------
> +
> +.. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
> +   :functions: hid_bpf_device_event hid_bpf_rdesc_fixup
> +
> +Available API that can be used in all HID-BPF programs:
> +-------------------------------------------------------
> +
> +.. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
> +   :functions: hid_bpf_get_data
> +
> +Available API that can be used in syscall HID-BPF programs:
> +-----------------------------------------------------------
> +
> +.. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
> +   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_allocate_c=
ontext hid_bpf_release_context
> +
> +General overview of a HID-BPF program
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Accessing the data attached to the context
> +------------------------------------------
> +
> +The ``struct hid_bpf_ctx`` doesn't export the ``data`` fields directly a=
nd to access
> +it, a bpf program needs to first call :c:func:`hid_bpf_get_data`.
> +
> +``offset`` can be any integer, but ``size`` needs to be constant, known =
at compile
> +time.
> +
> +This allows the following:
> +
> +1. for a given device, if we know that the report length will always be =
of a certain value,
> +   we can request the ``data`` pointer to point at the full report lengt=
h.
> +
> +   The kernel will ensure we are using a correct size and offset and eBP=
F will ensure
> +   the code will not attempt to read or write outside of the boundaries::
> +
> +     __u8 *data =3D hid_bpf_get_data(ctx, 0 /* offset */, 256 /* size */=
);
> +
> +     if (!data)
> +         return 0; /* ensure data is correct, now the verifier knows we
> +                    * have 256 bytes available */
> +
> +     bpf_printk("hello world: %02x %02x %02x", data[0], data[128], data[=
255]);
> +
> +2. if the report length is variable, but we know the value of ``X`` is a=
lways a 16-bit
> +   integer, we can then have a pointer to that value only::
> +
> +      __u16 *x =3D hid_bpf_get_data(ctx, offset, sizeof(*x));
> +
> +      if (!x)
> +          return 0; /* something went wrong */
> +
> +      *x +=3D 1; /* increment X by one */
> +
> +Effect of a HID-BPF program
> +---------------------------
> +
> +For all HID-BPF attachment types except for :c:func:`hid_bpf_rdesc_fixup=
`, several eBPF
> +programs can be attached to the same device.
> +
> +Unless ``HID_BPF_FLAG_INSERT_HEAD`` is added to the flags while attachin=
g the
> +program, the new program is appended at the end of the list.
> +``HID_BPF_FLAG_INSERT_HEAD`` will insert the new program at the beginnin=
g of the
> +list which is useful for e.g. tracing where we need to get the unprocess=
ed events
> +from the device.
> +
> +Note that if there are multiple programs using the ``HID_BPF_FLAG_INSERT=
_HEAD`` flag,
> +only the most recently loaded one is actually the first in the list.
> +
> +``SEC("fmod_ret/hid_bpf_device_event")``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Whenever a matching event is raised, the eBPF programs are called one af=
ter the other
> +and are working on the same data buffer.
> +
> +If a program changes the data associated with the context, the next one =
will see
> +the modified data but it will have *no* idea of what the original data w=
as.
> +
> +Once all the programs are run and return ``0`` or a positive value, the =
rest of the
> +HID stack will work on the modified data, with the ``size`` field of the=
 last hid_bpf_ctx
> +being the new size of the input stream of data.
> +
> +A BPF program returning a negative error discards the event, i.e. this e=
vent will not be
> +processed by the HID stack. Clients (hidraw, input, LEDs) will **not** s=
ee this event.
> +
> +``SEC("syscall")``
> +~~~~~~~~~~~~~~~~~~
> +
> +``syscall`` are not attached to a given device. To tell which device we =
are working
> +with, userspace needs to refer to the device by its unique system id (th=
e last 4 numbers
> +in the sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``).
> +
> +To retrieve a context associated with the device, the program must call
> +:c:func:`hid_bpf_allocate_context` and must release it with :c:func:`hid=
_bpf_release_context`
> +before returning.
> +Once the context is retrieved, one can also request a pointer to kernel =
memory with
> +:c:func:`hid_bpf_get_data`. This memory is big enough to support all inp=
ut/output/feature
> +reports of the given device.
> +
> +``SEC("fmod_ret/hid_bpf_rdesc_fixup")``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``hid_bpf_rdesc_fixup`` program works in a similar manner to
> +``.report_fixup`` of ``struct hid_driver``.
> +
> +When the device is probed, the kernel sets the data buffer of the contex=
t with the
> +content of the report descriptor. The memory associated with that buffer=
 is
> +``HID_MAX_DESCRIPTOR_SIZE`` (currently 4kB).
> +
> +The eBPF program can modify the data buffer at-will and the kernel uses =
the
> +modified content and size as the report descriptor.
> +
> +Whenever a ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program is attached (=
if no
> +program was attached before), the kernel immediately disconnects the HID=
 device
> +and does a reprobe.
> +
> +In the same way, when the ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` progra=
m is
> +detached, the kernel issues a disconnect on the device.
> +
> +There is no ``detach`` facility in HID-BPF. Detaching a program happens =
when
> +all the user space file descriptors pointing at a program are closed.
> +Thus, if we need to replace a report descriptor fixup, some cooperation =
is
> +required from the owner of the original report descriptor fixup.
> +The previous owner will likely pin the program in the bpffs, and we can =
then
> +replace it through normal bpf operations.
> +
> +Attaching a bpf program to a device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``libbpf`` does not export any helper to attach a HID-BPF program.
> +Users need to use a dedicated ``syscall`` program which will call
> +``hid_bpf_attach_prog(hid_id, program_fd, flags)``.
> +
> +``hid_id`` is the unique system ID of the HID device (the last 4 numbers=
 in the
> +sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``)
> +
> +``progam_fd`` is the opened file descriptor of the program to attach.
> +
> +``flags`` is of type ``enum hid_bpf_attach_flags``.
> +
> +We can not rely on hidraw to bind a BPF program to a HID device. hidraw =
is an
> +artefact of the processing of the HID device, and is not stable. Some dr=
ivers
> +even disable it, so that removes the tracing capabilies on those devices
> +(where it is interesting to get the non-hidraw traces).
> +
> +On the other hand, the ``hid_id`` is stable for the entire life of the H=
ID device,
> +even if we change its report descriptor.
> +
> +Given that hidraw is not stable when the device disconnects/reconnects, =
we recommend
> +accessing the current report descriptor of the device through the sysfs.
> +This is available at ``/sys/bus/hid/devices/BUS:VID:PID.000N/report_desc=
riptor`` as a
> +binary stream.
> +
> +Parsing the report descriptor is the responsibility of the BPF programme=
r or the userspace
> +component that loads the eBPF program.
> +
> +An (almost) complete example of a BPF enhanced HID device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +*Foreword: for most parts, this could be implemented as a kernel driver*
> +
> +Let's imagine we have a new tablet device that has some haptic capabilit=
ies
> +to simulate the surface the user is scratching on. This device would als=
o have
> +a specific 3 positions switch to toggle between *pencil on paper*, *cray=
 on a wall*
> +and *brush on a painting canvas*. To make things even better, we can con=
trol the
> +physical position of the switch through a feature report.
> +
> +And of course, the switch is relying on some userspace component to cont=
rol the
> +haptic feature of the device itself.
> +
> +Filtering events
> +----------------
> +
> +The first step consists in filtering events from the device. Given that =
the switch
> +position is actually reported in the flow of the pen events, using hidra=
w to implement
> +that filtering would mean that we wake up userspace for every single eve=
nt.
> +
> +This is OK for libinput, but having an external library that is just int=
erested in
> +one byte in the report is less than ideal.
> +
> +For that, we can create a basic skeleton for our BPF program::
> +
> +  #include "vmlinux.h"
> +  #include <bpf/bpf_helpers.h>
> +  #include <bpf/bpf_tracing.h>
> +
> +  /* HID programs need to be GPL */
> +  char _license[] SEC("license") =3D "GPL";
> +
> +  /* HID-BPF kfunc API definitions */
> +  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> +			      unsigned int offset,
> +			      const size_t __sz) __ksym;
> +  extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 f=
lags) __ksym;
> +
> +  struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 4096 * 64);
> +  } ringbuf SEC(".maps");
> +
> +  struct attach_prog_args {
> +	int prog_fd;
> +	unsigned int hid;
> +	unsigned int flags;
> +	int retval;
> +  };
> +
> +  SEC("syscall")
> +  int attach_prog(struct attach_prog_args *ctx)
> +  {
> +	ctx->retval =3D hid_bpf_attach_prog(ctx->hid,
> +					  ctx->prog_fd,
> +					  ctx->flags);
> +	return 0;
> +  }
> +
> +  __u8 current_value =3D 0;
> +
> +  SEC("?fmod_ret/hid_bpf_device_event")
> +  int BPF_PROG(filter_switch, struct hid_bpf_ctx *hid_ctx)
> +  {
> +	__u8 *data =3D hid_bpf_get_data(hid_ctx, 0 /* offset */, 192 /* size */=
);
> +	__u8 *buf;
> +
> +	if (!data)
> +		return 0; /* EPERM check */
> +
> +	if (current_value !=3D data[152]) {
> +		buf =3D bpf_ringbuf_reserve(&ringbuf, 1, 0);
> +		if (!buf)
> +			return 0;
> +
> +		*buf =3D data[152];
> +
> +		bpf_ringbuf_commit(buf, 0);
> +
> +		current_value =3D data[152];
> +	}
> +
> +	return 0;
> +  }
> +
> +To attach ``filter_switch``, userspace needs to call the ``attach_prog``=
 syscall
> +program first::
> +
> +  static int attach_filter(struct hid *hid_skel, int hid_id)
> +  {
> +	int err, prog_fd;
> +	int ret =3D -1;
> +	struct attach_prog_args args =3D {
> +		.hid =3D hid_id,
> +	};
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
> +		.ctx_in =3D &args,
> +		.ctx_size_in =3D sizeof(args),
> +	);
> +
> +	args.prog_fd =3D bpf_program__fd(hid_skel->progs.filter_switch);
> +
> +	prog_fd =3D bpf_program__fd(hid_skel->progs.attach_prog);
> +
> +	err =3D bpf_prog_test_run_opts(prog_fd, &tattrs);
> +	return err;
> +  }
> +
> +Our userspace program can now listen to notifications on the ring buffer=
, and
> +is awaken only when the value changes.
> +
> +Controlling the device
> +----------------------
> +
> +To be able to change the haptic feedback from the tablet, the userspace =
program
> +needs to emit a feature report on the device itself.
> +
> +Instead of using hidraw for that, we can create a ``SEC("syscall")`` pro=
gram
> +that talks to the device::
> +
> +  /* some more HID-BPF kfunc API definitions */
> +  extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_i=
d) __ksym;
> +  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
> +  extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
> +			      __u8* data,
> +			      size_t len,
> +			      enum hid_report_type type,
> +			      enum hid_class_request reqtype) __ksym;
> +
> +
> +  struct hid_send_haptics_args {
> +	/* data needs to come at offset 0 so we can do a memcpy into it */
> +	__u8 data[10];
> +	unsigned int hid;
> +  };
> +
> +  SEC("syscall")
> +  int send_haptic(struct hid_send_haptics_args *args)
> +  {
> +	struct hid_bpf_ctx *ctx;
> +	int ret =3D 0;
> +
> +	ctx =3D hid_bpf_allocate_context(args->hid);
> +	if (!ctx)
> +		return 0; /* EPERM check */
> +
> +	ret =3D hid_bpf_hw_request(ctx,
> +				 args->data,
> +				 10,
> +				 HID_FEATURE_REPORT,
> +				 HID_REQ_SET_REPORT);
> +
> +	hid_bpf_release_context(ctx);
> +
> +	return ret;
> +  }
> +
> +And then userspace needs to call that program directly::
> +
> +  static int set_haptic(struct hid *hid_skel, int hid_id, __u8 haptic_va=
lue)
> +  {
> +	int err, prog_fd;
> +	int ret =3D -1;
> +	struct hid_send_haptics_args args =3D {
> +		.hid =3D hid_id,
> +	};
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
> +		.ctx_in =3D &args,
> +		.ctx_size_in =3D sizeof(args),
> +	);
> +
> +	args.data[0] =3D 0x02; /* report ID of the feature on our device */
> +	args.data[1] =3D haptic_value;
> +
> +	prog_fd =3D bpf_program__fd(hid_skel->progs.set_haptic);
> +
> +	err =3D bpf_prog_test_run_opts(prog_fd, &tattrs);
> +	return err;
> +  }
> +
> +Now our userspace program is aware of the haptic state and can control i=
t. The
> +program could make this state further available to other userspace progr=
ams
> +(e.g. via a DBus API).
> +
> +The interesting bit here is that we did not created a new kernel API for=
 this.
> +Which means that if there is a bug in our implementation, we can change =
the
> +interface with the kernel at-will, because the userspace application is
> +responsible for its own usage.
> diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
> index e50f513c579c..b2028f382f11 100644
> --- a/Documentation/hid/index.rst
> +++ b/Documentation/hid/index.rst
> @@ -11,6 +11,7 @@ Human Interface Devices (HID)
>     hidraw
>     hid-sensor
>     hid-transport
> +   hid-bpf
> =20
>     uhid
> =20

The wordings are somewhat confusing, so here's the alternative:

---- >8 ----

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index ba35aa2e2ba836..c59bce4b9cf214 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -27,88 +27,89 @@ Assuming you have a joystick that is getting older, it =
is common to see it
 wobbling around its neutral point. This is usually filtered at the applica=
tion
 level by adding a *dead zone* for this specific axis.
=20
-With HID-BPF, we can apply this filtering in the kernel directly so usersp=
ace
-does not get woken up when nothing else is happening on the input controll=
er.
+With HID-BPF, the filter can be applied in the kernel directly so that
+userspace does not get woken up when nothing else is happening on the input
+controller.
=20
-Of course, given that this dead zone is specific to an individual device, =
we
-can not create a generic fix for all of the same joysticks. Adding a custom
-kernel API for this (e.g. by adding a sysfs entry) does not guarantee this=
 new
-kernel API will be broadly adopted and maintained.
+Of course, given that dead zone filter is device-specific, it is not possi=
ble
+to create a generic fix for all of the same joysticks. Adding a custom
+kernel API for this (e.g. by adding a sysfs entry) does not guarantee that
+the API will be broadly adopted and maintained.
=20
-HID-BPF allows the userspace program to load the program itself, ensuring =
we
-only load the custom API when we have a user.
+HID-BPF allows the userspace program to load the program itself, ensuring =
that
+custom API is only needed for edge cases (like esoteric joysticks)
=20
 Simple fixup of report descriptor
 ---------------------------------
=20
 In the HID tree, half of the drivers only fix one key or one byte
 in the report descriptor. These fixes all require a kernel patch and the
-subsequent shepherding into a release, a long and painful process for user=
s.
+subsequent shepherding into a release, which can be a long and painful pro=
cess
+for users.
=20
-We can reduce this burden by providing an eBPF program instead. Once such a
-program  has been verified by the user, we can embed the source code into =
the
-kernel tree and ship the eBPF program and load it directly instead of load=
ing
-a specific kernel module for it.
+This burden can be reduced by providing an eBPF program instead. Once the
+program has been verified by the user, the unmodified driver source code
+can be shipped in the kernel tree with corresponding eBPF program. The lat=
ter
+can be loaded directly instead of loading a specific kernel module for the
+device.
=20
-Note: distribution of eBPF programs and their inclusion in the kernel is n=
ot
-yet fully implemented
+.. note::
+   Distribution of eBPF programs and their inclusion in the kernel is not
+   yet fully implemented
=20
 Add a new feature that requires a new kernel API
 ------------------------------------------------
=20
 An example for such a feature are the Universal Stylus Interface (USI) pen=
s.
 Basically, USI pens require a new kernel API because there are new
-channels of communication that our HID and input stack do not support.
-Instead of using hidraw or creating new sysfs entries or ioctls, we can re=
ly
-on eBPF to have the kernel API controlled by the consumer and to not
-impact the performances by waking up userspace every time there is an
-event.
+channels of communication that aren't yet supported by current HID/input
+kernel stack. Instead of using hidraw or creating new sysfs entries or ioc=
tls,
+eBPF program can be used to have existing kernel API consumed and adapted
+by users of such pens and to not impact performance by waking up userspace
+every time there is an event.
=20
 Morph a device into something else and control that from userspace
 ------------------------------------------------------------------
=20
 The kernel has a relatively static mapping of HID items to evdev bits.
-It cannot decide to dynamically transform a given device into something el=
se
-as it does not have the required context and any such transformation canno=
t be
-undone (or even discovered) by userspace.
+It cannot decide how to dynamically transform a given device into something
+else as it does not have the required context and any such transformation
+cannot be undone (or even discovered) by userspace.
=20
-However, some devices are useless with that static way of defining devices=
=2E For
-example, the Microsoft Surface Dial is a pushbutton with haptic feedback t=
hat
-is barely usable as of today.
+However, some devices requires such feature. For example, Microsoft Surface
+Dial is a pushbutton with haptic feedback that is barely usable as of toda=
y.
=20
-With eBPF, userspace can morph that device into a mouse, and convert the d=
ial
-events into wheel events. Also, the userspace program can set/unset the ha=
ptic
-feedback depending on the context. For example, if a menu is visible on the
-screen we likely need to have a haptic click every 15 degrees. But when
-scrolling in a web page the user experience is better when the device emits
-events at the highest resolution.
+With eBPF, userspace programs can morph the aforementioned device into a m=
ouse
+and convert the dial events into wheel events. Also, userspace programs can
+set/unset the haptic feedback depending on the context. For example, if th=
ere
+is a visible menu on the screen, it is likely to need having a haptic click
+every 15 degrees. On the other hand, when scrolling a web page, the user
+experience is better when the device emits events at the highest resolutio=
n.
=20
 Firewall
 --------
=20
-What if we want to prevent other users to access a specific feature of a
-device? (think a possibly broken firmware update entry point)
+What if there is a desire to prevent other users using a specific feature =
of
+the device? (think a possibly broken firmware update entry point)
=20
-With eBPF, we can intercept any HID command emitted to the device and
-validate it or not.
-
-This also allows to sync the state between the userspace and the
-kernel/bpf program because we can intercept any incoming command.
+With eBPF, any HID command emitted to the device can be intercepted and
+validated. This also allows to sync the state between userspace and kernel=
/bpf
+program.
=20
 Tracing
 -------
=20
-The last usage is tracing events and all the fun we can do we BPF to summa=
rize
-and analyze events.
+The last usage is tracing events, where BPF programs can be written to
+summarize and analyze events.
=20
 Right now, tracing relies on hidraw. It works well except for a couple
 of issues:
=20
-1. if the driver doesn't export a hidraw node, we can't trace anything
+1. if the driver doesn't export a hidraw node, tracing is impossible
    (eBPF will be a "god-mode" there, so this may raise some eyebrows)
 2. hidraw doesn't catch other processes' requests to the device, which
-   means that we have cases where we need to add printks to the kernel
-   to understand what is happening.
+   means that in some cases, adding debugging printks to the kernel is
+   needed to understand what is happening.
=20
 High-level view of HID-BPF
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
@@ -118,12 +119,13 @@ Thus, all of the parsing of the HID report and the HI=
D report descriptor
 must be implemented in the userspace component that loads the eBPF
 program.
=20
-For example, in the dead zone joystick from above, knowing which fields
-in the data stream needs to be set to ``0`` needs to be computed by usersp=
ace.
+For example, in the dead zone joystick example from above, knowing which f=
ields
+in the data stream that needs to be set to ``0`` needs to be determined by
+userspace.
=20
 A corollary of this is that HID-BPF doesn't know about the other subsystems
-available in the kernel. *You can not directly emit input event through the
-input API from eBPF*.
+available in the kernel. This means that you can not directly emit input e=
vent
+through the input API from eBPF.
=20
 When a BPF program needs to emit input events, it needs to talk with the H=
ID
 protocol, and rely on the HID kernel processing to translate the HID data =
into
@@ -132,28 +134,30 @@ input events.
 Available types of programs
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
-HID-BPF is built "on top" of BPF, meaning that we use tracing method to
-declare our programs.
+HID-BPF is built "on top" of BPF, meaning that you can use tracing method =
to
+write the program.
=20
-HID-BPF has the following attachment types available:
+HID-BPF has the following program types available, all available in libbpf:
=20
-1. event processing/filtering with ``SEC("fmod_ret/hid_bpf_device_event")`=
` in libbpf
-2. actions coming from userspace with ``SEC("syscall")`` in libbpf
-3. change of the report descriptor with ``SEC("fmod_ret/hid_bpf_rdesc_fixu=
p")`` in libbpf
+1. event processing/filtering with ``SEC("fmod_ret/hid_bpf_device_event")``
+2. actions coming from userspace with ``SEC("syscall")``
+3. changing report descriptor with ``SEC("fmod_ret/hid_bpf_rdesc_fixup")``
=20
-A ``hid_bpf_device_event`` is calling a BPF program when an event is recei=
ved from
-the device. Thus we are in IRQ context and can act on the data or notify u=
serspace.
-And given that we are in IRQ context, we can not talk back to the device.
+``hid_bpf_device_event`` calls a BPF program when an event is received from
+the device, which puts the program in IRQ context and can act on the data =
or
+notify userspace. However, you can not talk back to the device while in IRQ
+context.
=20
-A ``syscall`` means that userspace called the syscall ``BPF_PROG_RUN`` fac=
ility.
-This time, we can do any operations allowed by HID-BPF, and talking to the=
 device is
-allowed.
+``syscall`` means that userspace called the ``BPF_PROG_RUN`` command throu=
gh
+``bpf()`` syscall. You can do any operations allowed by HID-BPF, including
+talking to the device.
=20
-Last, ``hid_bpf_rdesc_fixup`` is different from the others as there can be=
 only one
-BPF program of this type. This is called on ``probe`` from the driver and =
allows to
-change the report descriptor from the BPF program. Once a ``hid_bpf_rdesc_=
fixup``
-program has been loaded, it is not possible to overwrite it unless the pro=
gram which
-inserted it allows us by pinning the program and closing all of its fds po=
inting to it.
+Last, ``hid_bpf_rdesc_fixup`` is different from the others as there can be
+only one BPF program of this type running. This is called on ``probe`` from
+the driver and allows to change the report descriptor from the program. On=
ce
+a ``hid_bpf_rdesc_fixup`` program has been loaded, it is not possible to
+overwrite it unless the program which inserted it allows pinning the progr=
am
+and closing all of its fds pointing to it.
=20
 Developer API:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -188,82 +192,87 @@ General overview of a HID-BPF program
 Accessing the data attached to the context
 ------------------------------------------
=20
-The ``struct hid_bpf_ctx`` doesn't export the ``data`` fields directly and=
 to access
-it, a bpf program needs to first call :c:func:`hid_bpf_get_data`.
+The ``struct hid_bpf_ctx`` doesn't export the ``data`` fields directly. To
+access it, a bpf program needs to first call :c:func:`hid_bpf_get_data`.
=20
-``offset`` can be any integer, but ``size`` needs to be constant, known at=
 compile
-time.
+``offset`` can be any integer, but ``size`` needs to be compile-time const=
ant.
=20
-This allows the following:
+Depending on report length, there are two possibilities:
=20
-1. for a given device, if we know that the report length will always be of=
 a certain value,
-   we can request the ``data`` pointer to point at the full report length.
+1. If you know that the report length will always be certain fixed value, =
you
+   can set ``data`` pointer to point at the full report length.
=20
-   The kernel will ensure we are using a correct size and offset and eBPF =
will ensure
-   the code will not attempt to read or write outside of the boundaries::
+   The kernel will ensure that data size and offset are correct and eBPF
+   will ensure the code will not attempt to read or write outside data
+   boundaries::
=20
      __u8 *data =3D hid_bpf_get_data(ctx, 0 /* offset */, 256 /* size */);
=20
+     /* check that the data is correct (256 byte length) */
      if (!data)
-         return 0; /* ensure data is correct, now the verifier knows we
-                    * have 256 bytes available */
+         return 0;
=20
      bpf_printk("hello world: %02x %02x %02x", data[0], data[128], data[25=
5]);
=20
-2. if the report length is variable, but we know the value of ``X`` is alw=
ays a 16-bit
-   integer, we can then have a pointer to that value only::
+2. if the report length is variable, but you know the value of ``x`` data =
is
+   always a 16-bit integer, you can simply have a pointer to the value::
=20
       __u16 *x =3D hid_bpf_get_data(ctx, offset, sizeof(*x));
=20
+      /* return 0 if the data is empty, otherwise increment the data
+       * pointer by one */
       if (!x)
-          return 0; /* something went wrong */
+          return 0;
=20
-      *x +=3D 1; /* increment X by one */
+      *x +=3D 1;
=20
 Effect of a HID-BPF program
 ---------------------------
=20
-For all HID-BPF attachment types except for :c:func:`hid_bpf_rdesc_fixup`,=
 several eBPF
-programs can be attached to the same device.
+For all HID-BPF program types except for :c:func:`hid_bpf_rdesc_fixup`,
+multiple eBPF programs can be attached to the same device.
=20
-Unless ``HID_BPF_FLAG_INSERT_HEAD`` is added to the flags while attaching =
the
-program, the new program is appended at the end of the list.
-``HID_BPF_FLAG_INSERT_HEAD`` will insert the new program at the beginning =
of the
-list which is useful for e.g. tracing where we need to get the unprocessed=
 events
-from the device.
+By default, new programs are appended at the end of the list when attached.
+With ``HID_BPF_FLAG_INSERT_HEAD`` flag, programs will instead be prepended
+at the beginning of programs list, which is useful for e.g. tracing where
+you need to get raw events from the device.
=20
-Note that if there are multiple programs using the ``HID_BPF_FLAG_INSERT_H=
EAD`` flag,
-only the most recently loaded one is actually the first in the list.
+Note that if there are multiple programs loaded with
+``HID_BPF_FLAG_INSERT_HEAD``, only the most recently loaded one is actuall=
y the first in the list.
=20
 ``SEC("fmod_ret/hid_bpf_device_event")``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-Whenever a matching event is raised, the eBPF programs are called one afte=
r the other
+Whenever a matching event is raised, the eBPF programs are called sequenci=
ally
 and are working on the same data buffer.
=20
-If a program changes the data associated with the context, the next one wi=
ll see
-the modified data but it will have *no* idea of what the original data was.
+If a program changes the data associated with the context, the next program
+will see the modified data but it will have no idea of what the original d=
ata
+was.
=20
-Once all the programs are run and return ``0`` or a positive value, the re=
st of the
-HID stack will work on the modified data, with the ``size`` field of the l=
ast hid_bpf_ctx
-being the new size of the input stream of data.
+Once all the programs are run and return ``0`` or positive value, the rest=
 of
+HID stack will work on the modified data, with the ``size`` field of the l=
ast
+hid_bpf_ctx being the new size of the input stream of data.
=20
-A BPF program returning a negative error discards the event, i.e. this eve=
nt will not be
-processed by the HID stack. Clients (hidraw, input, LEDs) will **not** see=
 this event.
+A BPF program returning a negative error discards the event, which will no=
t be
+processed by the HID stack. The stack users (hidraw, input, LEDs) will not=
 see
+the discarded event.
=20
 ``SEC("syscall")``
 ~~~~~~~~~~~~~~~~~~
=20
-``syscall`` are not attached to a given device. To tell which device we ar=
e working
-with, userspace needs to refer to the device by its unique system id (the =
last 4 numbers
-in the sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``).
+``syscall`` programs are not attached to a given device. To tell which dev=
ice
+is associated with such programs, userspace program needs to refer to the
+device by its unique system id (the base name in the sysfs path, e.g.
+``xxxx:yyyy:zzzz:0000`` for the path named
+``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``).
=20
 To retrieve a context associated with the device, the program must call
-:c:func:`hid_bpf_allocate_context` and must release it with :c:func:`hid_b=
pf_release_context`
-before returning.
-Once the context is retrieved, one can also request a pointer to kernel me=
mory with
-:c:func:`hid_bpf_get_data`. This memory is big enough to support all input=
/output/feature
-reports of the given device.
+:c:func:`hid_bpf_allocate_context` and must release it with
+:c:func:`hid_bpf_release_context` before returning.
+Once the context is retrieved, the program can also allocate a pointer to
+kernel memory with :c:func:`hid_bpf_get_data`. This memory is big enough to
+support all input/output/feature reports of the given device.
=20
 ``SEC("fmod_ret/hid_bpf_rdesc_fixup")``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -271,26 +280,24 @@ reports of the given device.
 The ``hid_bpf_rdesc_fixup`` program works in a similar manner to
 ``.report_fixup`` of ``struct hid_driver``.
=20
-When the device is probed, the kernel sets the data buffer of the context =
with the
-content of the report descriptor. The memory associated with that buffer is
+When the device is probed, the kernel sets data buffer of the context with
+the content of report descriptor. The buffer memory size is
 ``HID_MAX_DESCRIPTOR_SIZE`` (currently 4kB).
=20
 The eBPF program can modify the data buffer at-will and the kernel uses the
 modified content and size as the report descriptor.
=20
-Whenever a ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program is attached (if=
 no
-program was attached before), the kernel immediately disconnects the HID d=
evice
-and does a reprobe.
-
-In the same way, when the ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program =
is
-detached, the kernel issues a disconnect on the device.
+Whenever a program is attached (and no programs were attached before), the
+kernel immediately disconnects the HID device and does a reprobe. Likewise,
+when the ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program is detached, the
+kernel disconnects the device.
=20
 There is no ``detach`` facility in HID-BPF. Detaching a program happens wh=
en
 all the user space file descriptors pointing at a program are closed.
-Thus, if we need to replace a report descriptor fixup, some cooperation is
-required from the owner of the original report descriptor fixup.
-The previous owner will likely pin the program in the bpffs, and we can th=
en
-replace it through normal bpf operations.
+Consequently, if you need to replace a report descriptor fixup, you need to
+coordinate with the owner of original fixup. The owner will likely pin the
+program in bpffs, which you can then replace the fixup through normal bpf
+operations.
=20
 Attaching a bpf program to a device
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -299,54 +306,52 @@ Attaching a bpf program to a device
 Users need to use a dedicated ``syscall`` program which will call
 ``hid_bpf_attach_prog(hid_id, program_fd, flags)``.
=20
-``hid_id`` is the unique system ID of the HID device (the last 4 numbers i=
n the
-sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``)
+``hid_id`` is the unique system ID of the HID device.
=20
-``progam_fd`` is the opened file descriptor of the program to attach.
+``program_fd`` is the opened file descriptor of attached program.
=20
 ``flags`` is of type ``enum hid_bpf_attach_flags``.
=20
-We can not rely on hidraw to bind a BPF program to a HID device. hidraw is=
 an
-artefact of the processing of the HID device, and is not stable. Some driv=
ers
-even disable it, so that removes the tracing capabilies on those devices
-(where it is interesting to get the non-hidraw traces).
+You can not rely on hidraw to bind a BPF program to a HID device, because
+it is unstable. Some drivers even disable it, which means tracing capabili=
es
+on those devices are also removed (it is interesting to get traces on such
+devices via other means).
=20
-On the other hand, the ``hid_id`` is stable for the entire life of the HID=
 device,
-even if we change its report descriptor.
+On the other hand, ``hid_id`` is stable for the entire life of the HID dev=
ice,
+even if its report descriptor is changed.
=20
-Given that hidraw is not stable when the device disconnects/reconnects, we=
 recommend
-accessing the current report descriptor of the device through the sysfs.
-This is available at ``/sys/bus/hid/devices/BUS:VID:PID.000N/report_descri=
ptor`` as a
-binary stream.
+For the reason above, it is recommended to access the current report descr=
iptor
+of the device through the sysfs, which is available at
+``/sys/bus/hid/devices/BUS:VID:PID.000N/report_descriptor`` as a binary st=
ream.
=20
-Parsing the report descriptor is the responsibility of the BPF programmer =
or the userspace
-component that loads the eBPF program.
+Parsing the report descriptor is the responsibility of BPF program authors=
 or
+userspace components that load the eBPF program.
=20
 An (almost) complete example of a BPF enhanced HID device
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
-*Foreword: for most parts, this could be implemented as a kernel driver*
+*Foreword: for most parts, this example could be implemented as a kernel
+driver instead.*
=20
-Let's imagine we have a new tablet device that has some haptic capabilities
-to simulate the surface the user is scratching on. This device would also =
have
-a specific 3 positions switch to toggle between *pencil on paper*, *cray o=
n a wall*
-and *brush on a painting canvas*. To make things even better, we can contr=
ol the
-physical position of the switch through a feature report.
-
-And of course, the switch is relying on some userspace component to contro=
l the
-haptic feature of the device itself.
+Let's imagine that we have a new tablet device that has haptic capabilities
+to simulate the surface the user is scratching on. For this to happen,
+the device have 3 positions switch to toggle between *pencil on paper*, *c=
ray
+on a wall*, and *brush on a painting canvas*. To make things even better, =
the
+physical position of the switch can be controlled via feature report. Of
+course, the switch is relying on userspace to control the haptic feature of
+the device.
=20
 Filtering events
 ----------------
=20
-The first step consists in filtering events from the device. Given that th=
e switch
-position is actually reported in the flow of the pen events, using hidraw =
to implement
-that filtering would mean that we wake up userspace for every single event.
+The first step is filtering events from the device. Given that the switch
+position is actually reported in the form of the pen events, using hidraw =
to
+implement filtering would mean that we wake up userspace for every single
+event. This is OK for libinput, but having an external library that is only
+interested in one byte in the report is less than ideal.
=20
-This is OK for libinput, but having an external library that is just inter=
ested in
-one byte in the report is less than ideal.
-
-For that, we can create a basic skeleton for our BPF program::
+Based on the requirements above, we will write userspace BPF program, star=
ting
+with the skeleton::
=20
   #include "vmlinux.h"
   #include <bpf/bpf_helpers.h>
@@ -408,8 +413,8 @@ For that, we can create a basic skeleton for our BPF pr=
ogram::
 	return 0;
   }
=20
-To attach ``filter_switch``, userspace needs to call the ``attach_prog`` s=
yscall
-program first::
+To attach ``filter_switch``, the program needs to call ``attach_prog`` sys=
call
+first::
=20
   static int attach_filter(struct hid *hid_skel, int hid_id)
   {
@@ -431,17 +436,17 @@ program first::
 	return err;
   }
=20
-Our userspace program can now listen to notifications on the ring buffer, =
and
-is awaken only when the value changes.
+The program can now listen to notifications on the ring buffer. It is awak=
en
+only when the value changes.
=20
 Controlling the device
 ----------------------
=20
-To be able to change the haptic feedback from the tablet, the userspace pr=
ogram
-needs to emit a feature report on the device itself.
+To be able to change haptic feedback from the tablet, the program needs to
+emit feature report on the device.
=20
-Instead of using hidraw for that, we can create a ``SEC("syscall")`` progr=
am
-that talks to the device::
+Instead of using hidraw for the purpose, we can write a ``SEC("syscall")``
+routine that talks to the device::
=20
   /* some more HID-BPF kfunc API definitions */
   extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id)=
 __ksym;
@@ -480,7 +485,7 @@ that talks to the device::
 	return ret;
   }
=20
-And then userspace needs to call that program directly::
+The program needs to call the routine directly::
=20
   static int set_haptic(struct hid *hid_skel, int hid_id, __u8 haptic_valu=
e)
   {
@@ -503,11 +508,10 @@ And then userspace needs to call that program directl=
y::
 	return err;
   }
=20
-Now our userspace program is aware of the haptic state and can control it.=
 The
-program could make this state further available to other userspace programs
-(e.g. via a DBus API).
+Now the program is aware of the haptic state and can control it. The progr=
am
+could make this state further available to other userspace programs (e.g. =
via
+DBus API).
=20
-The interesting bit here is that we did not created a new kernel API for t=
his.
-Which means that if there is a bug in our implementation, we can change the
-interface with the kernel at-will, because the userspace application is
-responsible for its own usage.
+The interesting bit here is that no new kernel API is created. This means
+if there is a bug in the BPF program, the interface with the kernel can be
+changed if desired, because the program is responsible for its own usage.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--D+QQwxdKbJiJiOPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1k0PQAKCRD2uYlJVVFO
o8vnAQDrB7DATXb9t7xCgSl1/ozx9+QL5LsnM4DQzZao+KxObAEAvaKO81ITzLc6
HBDutFpWY+1FVMPtBo+8CZKp71QiGA0=
=8Cx3
-----END PGP SIGNATURE-----

--D+QQwxdKbJiJiOPW--
