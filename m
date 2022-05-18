Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9420752C535
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbiERVB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbiERVBJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 17:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E67813D0F
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652907647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=giY7Otcl1eOFxaYtRhGHE8IaPTXBsTDzw6ErsizqXsg=;
        b=d/Hy9/DpaOx+xGRFbsFbGfE6MvyviJ0tiBrpodNE3NSI2/9zgxen8e+xN2/Em5S+MPq705
        4+nPmeghwScaCP5H/Az4uULfyjjH7w2+4BLP9lBYPOrOXhKB3zP291guDP5bItY44tQRrt
        pGTQa4hLBwBHeJ5cRIVD8LaWSgMyyNI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-kwtze9R2NLO_UAwLcmlYAA-1; Wed, 18 May 2022 17:00:42 -0400
X-MC-Unique: kwtze9R2NLO_UAwLcmlYAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2BDC380670A;
        Wed, 18 May 2022 21:00:40 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69ACD2166B40;
        Wed, 18 May 2022 21:00:37 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH bpf-next v5 17/17] Documentation: add HID-BPF docs
Date:   Wed, 18 May 2022 22:59:24 +0200
Message-Id: <20220518205924.399291-18-benjamin.tissoires@redhat.com>
In-Reply-To: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
References: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Gives a primer on HID-BPF.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v5:
- amended for new API
- reworded most of the sentences (thanks to Peter Hutterer for the review)

changes in v4:
- fixed typos

new in v3
---
 Documentation/hid/hid-bpf.rst | 528 ++++++++++++++++++++++++++++++++++
 Documentation/hid/index.rst   |   1 +
 2 files changed, 529 insertions(+)
 create mode 100644 Documentation/hid/hid-bpf.rst

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
new file mode 100644
index 000000000000..af05667e72bb
--- /dev/null
+++ b/Documentation/hid/hid-bpf.rst
@@ -0,0 +1,528 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+HID-BPF
+=======
+
+HID is a standard protocol for input devices but some devices may require
+custom tweaks, traditionally done with a kernel driver fix. Using the eBPF
+capabilities instead speeds up development and adds new capabilities to the
+existing HID interfaces.
+
+.. contents::
+    :local:
+    :depth: 2
+
+
+When (and why) to use HID-BPF
+=============================
+
+We can enumerate several use cases for when using HID-BPF is better than
+using a standard kernel driver fix:
+
+Dead zone of a joystick
+-----------------------
+
+Assuming you have a joystick that is getting older, it is common to see it
+wobbling around its neutral point. This is usually filtered at the application
+level by adding a *dead zone* for this specific axis.
+
+With HID-BPF, we can apply this filtering in the kernel directly so userspace
+does not get woken up when nothing else is happening on the input controller.
+
+Of course, given that this dead zone is specific to an individual device, we
+can not create a generic fix for all of the same joysticks. Adding a custom
+kernel API for this (e.g. by adding a sysfs entry) does not guarantee this new
+kernel API will be broadly adopted and maintained.
+
+HID-BPF allows the userspace program to load the program itself, ensuring we
+only load the custom API when we have a user.
+
+Simple fixup of report descriptor
+---------------------------------
+
+In the HID tree, half of the drivers only fix one key or one byte
+in the report descriptor. These fixes all require a kernel patch and the
+subsequent shepherding into a release, a long and painful process for users.
+
+We can reduce this burden by providing an eBPF program instead. Once such a
+program  has been verified by the user, we can embed the source code into the
+kernel tree and ship the eBPF program and load it directly instead of loading
+a specific kernel module for it.
+
+Note: distribution of eBPF programs and their inclusion in the kernel is not
+yet fully implemented
+
+Add a new feature that requires a new kernel API
+------------------------------------------------
+
+An example for such a feature are the Universal Stylus Interface (USI) pens.
+Basically, USI pens require a new kernel API because there are new
+channels of communication that our HID and input stack do not support.
+Instead of using hidraw or creating new sysfs entries or ioctls, we can rely
+on eBPF to have the kernel API controlled by the consumer and to not
+impact the performances by waking up userspace every time there is an
+event.
+
+Morph a device into something else and control that from userspace
+------------------------------------------------------------------
+
+The kernel has a relatively static mapping of HID items to evdev bits.
+It cannot decide to dynamically transform a given device into something else
+as it does not have the required context and any such transformation cannot be
+undone (or even discovered) by userspace.
+
+However, some devices are useless with that static way of defining devices. For
+example, the Microsoft Surface Dial is a pushbutton with haptic feedback that
+is barely usable as of today.
+
+With eBPF, userspace can morph that device into a mouse, and convert the dial
+events into wheel events. Also, the userspace program can set/unset the haptic
+feedback depending on the context. For example, if a menu is visible on the
+screen we likely need to have a haptic click every 15 degrees. But when
+scrolling in a web page the user experience is better when the device emits
+events at the highest resolution.
+
+Firewall
+--------
+
+What if we want to prevent other users to access a specific feature of a
+device? (think a possibly broken firmware update entry point)
+
+With eBPF, we can intercept any HID command emitted to the device and
+validate it or not.
+
+This also allows to sync the state between the userspace and the
+kernel/bpf program because we can intercept any incoming command.
+
+Tracing
+-------
+
+The last usage is tracing events and all the fun we can do we BPF to summarize
+and analyze events.
+
+Right now, tracing relies on hidraw. It works well except for a couple
+of issues:
+
+1. if the driver doesn't export a hidraw node, we can't trace anything
+   (eBPF will be a "god-mode" there, so this may raise some eyebrows)
+2. hidraw doesn't catch other processes' requests to the device, which
+   means that we have cases where we need to add printks to the kernel
+   to understand what is happening.
+
+High-level view of HID-BPF
+==========================
+
+The main idea behind HID-BPF is that it works at an array of bytes level.
+Thus, all of the parsing of the HID report and the HID report descriptor
+must be implemented in the userspace component that loads the eBPF
+program.
+
+For example, in the dead zone joystick from above, knowing which fields
+in the data stream needs to be set to ``0`` needs to be computed by userspace.
+
+A corollary of this is that HID-BPF doesn't know about the other subsystems
+available in the kernel. *You can not directly emit input event through the
+input API from eBPF*.
+
+When a BPF program needs to emit input events, it needs to talk HID, and rely
+on the HID kernel processing to translate the HID data into input events.
+
+Available types of programs
+===========================
+
+HID-BPF is built "on top" of BPF, meaning that we use tracing method to
+declare our programs.
+
+HID-BPF has the following attachment types available:
+
+1. event processing/filtering with ``SEC("fmod_ret/hid_bpf_device_event")`` in libbpf
+2. actions coming from userspace with ``SEC("syscall")`` in libbpf
+3. change of the report descriptor with ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` in libbpf
+
+A ``hid_bpf_device_event`` is calling a BPF program when an event is received from
+the device. Thus we are in IRQ context and can act on the data or notify userspace.
+And given that we are in IRQ context, we can not talk back to the device.
+
+A ``syscall`` means that userspace called the syscall ``BPF_PROG_RUN`` facility.
+This time, we can do any operations allowed by HID-BPF, and talking to the device is
+allowed.
+
+Last, ``hid_bpf_rdesc_fixup`` is different from the others as there can be only one
+BPF program of this type. This is called on ``probe`` from the driver and allows to
+change the report descriptor from the BPF program. Once a ``hid_bpf_rdesc_fixup``
+program has been loaded, it is not possible to overwrite it unless the program which
+inserted it allows us by pinning the program and closing all of its fds pointing to it.
+
+Developer API:
+==============
+
+User API data structures available in programs:
+-----------------------------------------------
+
+.. kernel-doc:: include/uapi/linux/hid_bpf.h
+.. kernel-doc:: include/linux/hid_bpf.h
+
+Available tracing functions to attach a HID-BPF program:
+--------------------------------------------------------
+
+.. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
+   :functions: hid_bpf_device_event hid_bpf_rdesc_fixup
+
+Available API that can be used in all HID-BPF programs:
+-------------------------------------------------------
+
+.. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
+   :functions: hid_bpf_get_data
+
+Available API that can be used in syscall HID-BPF programs:
+-----------------------------------------------------------
+
+.. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
+   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_allocate_context hid_bpf_release_context
+
+General overview of a HID-BPF program
+=====================================
+
+Accessing the data attached to the context
+------------------------------------------
+
+The ``struct hid_bpf_ctx`` doesn't export the ``data`` fields directly and to access
+it, a bpf program needs to first call :c:func:`hid_bpf_get_data`.
+
+``offset`` can be any integer, but ``size`` needs to be constant, known at compile
+time.
+
+This allows the following:
+
+1. for a given device, if we know that the report length will always be of a certain value,
+   we can request the ``data`` pointer to point at the full report length.
+
+   The kernel will ensure we are using a correct size and offset and eBPF will ensure
+   the code will not attempt to read or write outside of the boundaries::
+
+     __u8 *data = hid_bpf_get_data(ctx, 0 /* offset */, 256 /* size */);
+
+     if (!data)
+         return 0; /* ensure data is correct, now the verifier knows we
+                    * have 256 bytes available */
+
+     bpf_printk("hello world: %02x %02x %02x", data[0], data[128], data[255]);
+
+2. if the report length is variable, but we know the value of ``X`` is always a 16-bit
+   integer, we can then have a pointer to that value only::
+
+      __u16 *x = hid_bpf_get_data(ctx, offset, sizeof(*x));
+
+      if (!x)
+          return 0; /* something went wrong */
+
+      *x += 1; /* increment X by one */
+
+Effect of a HID-BPF program
+---------------------------
+
+For all HID-BPF attachment types except for :c:func:`hid_bpf_rdesc_fixup`, several eBPF
+programs can be attached to the same device.
+
+Unless ``HID_BPF_FLAG_INSERT_HEAD`` is added to the flags while attaching the
+program, the new program is appended at the end of the list.
+``HID_BPF_FLAG_INSERT_HEAD`` will insert the new program at the beginning of the
+list which is useful for e.g. tracing where we need to get the unprocessed events
+from the device.
+
+Note that if there are multiple programs using the ``HID_BPF_FLAG_INSERT_HEAD`` flag,
+only the most recently loaded one is actually the first in the list.
+
+``SEC("fmod_ret/hid_bpf_device_event")``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Whenever a matching event is raised, the eBPF programs are called one after the other
+and are working on the same data buffer.
+
+If a program changes the data associated with the context, the next one will see
+the modified data but it will have *no* idea of what the original data was.
+
+Once all the programs are run and return ``0`` or a positive value, the rest of the
+HID stack will work on the modified data, with the ``size`` field of the last hid_bpf_ctx
+being the new size of the input stream of data.
+
+A BPF program returning a negative error discards the event, i.e. this event will not be
+processed by the HID stack. Clients (hidraw, input, LEDs) will **not** see this event.
+
+``SEC("syscall")``
+~~~~~~~~~~~~~~~~~~
+
+``syscall`` are not attached to a given device. To tell which device we are working
+with, userspace needs to refer to the device by its unique system id (the last 4 numbers
+in the sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``).
+
+To retrieve a context associated with the device, the program must call
+:c:func:`hid_bpf_allocate_context` and must release it with :c:func:`hid_bpf_release_context`
+before returning.
+Once the context is retrieved, one can also request a pointer to kernel memory with
+:c:func:`hid_bpf_get_data`. This memory is big enough to support all input/output/feature
+reports of the given device.
+
+``SEC("fmod_ret/hid_bpf_rdesc_fixup")``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``hid_bpf_rdesc_fixup`` program works in a similar manner to
+``.report_fixup`` of ``struct hid_driver``.
+
+When the device is probed, the kernel sets the data buffer of the context with the
+content of the report descriptor. The memory associated with that buffer is
+``HID_MAX_DESCRIPTOR_SIZE`` (currently 4kB).
+
+The eBPF program can modify the data buffer at-will and the kernel uses the
+modified content and size as the report descriptor.
+
+Whenever a ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program is attached (if no
+program was attached before), the kernel immediately disconnects the HID device
+and does a reprobe.
+
+In the same way, when the ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program is
+detached, the kernel issues a disconnect on the device.
+
+There is no ``detach`` facility in HID-BPF. Detaching a program happens when
+all the user space file descriptors pointing at a program are closed.
+Thus, if we need to replace a report descriptor fixup, some cooperation is
+required from the owner of the original report descriptor fixup.
+The previous owner will likely pin the program in the bpffs, and we can then
+replace it through normal bpf operations.
+
+Attaching a bpf program to a device
+===================================
+
+``libbpf`` does not export any helper to attach a HID-BPF program.
+Users need to use a dedicated ``syscall`` program which will call
+``hid_bpf_attach_prog(hid_id, program_fd, flags)``.
+
+``hid_id`` is the unique system ID of the HID device (the last 4 numbers in the
+sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``)
+
+``progam_fd`` is the opened file descriptor of the program to attach.
+
+``flags`` is of type ``enum hid_bpf_attach_flags``.
+
+We can not rely on hidraw to bind a BPF program to a HID device. hidraw is an
+artefact of the processing of the HID device, and is not stable. Some drivers
+even disable it, so that removes the tracing capabilies on those devices
+(where it is interesting to get the non-hidraw traces).
+
+On the other hand, the ``hid_id`` is stable for the entire life of the HID device,
+even if we change its report descriptor.
+
+Given that hidraw is not stable when the device disconnects/reconnects, we recommend
+accessing the current report descriptor of the device through the sysfs.
+This is available at ``/sys/bus/hid/devices/BUS:VID:PID.000N/report_descriptor`` as a
+binary stream.
+
+Parsing the report descriptor is the responsibility of the BPF programmer or the userspace
+component that loads the eBPF program.
+
+An (almost) complete example of a BPF enhanced HID device
+=========================================================
+
+*Foreword: for most parts, this could be implemented as a kernel driver*
+
+Let's imagine we have a new tablet device that has some haptic capabilities
+to simulate the surface the user is scratching on. This device would also have
+a specific 3 positions switch to toggle between *pencil on paper*, *cray on a wall*
+and *brush on a painting canvas*. To make things even better, we can control the
+physical position of the switch through a feature report.
+
+And of course, the switch is relying on some userspace component to control the
+haptic feature of the device itself.
+
+Filtering events
+----------------
+
+The first step consists in filtering events from the device. Given that the switch
+position is actually reported in the flow of the pen events, using hidraw to implement
+that filtering would mean that we wake up userspace for every single event.
+
+This is OK for libinput, but having an external library that is just interested in
+one byte in the report is less than ideal.
+
+For that, we can create a basic skeleton for our BPF program::
+
+  #include "vmlinux.h"
+  #include <bpf/bpf_helpers.h>
+  #include <bpf/bpf_tracing.h>
+
+  /* HID programs need to be GPL */
+  char _license[] SEC("license") = "GPL";
+
+  /* HID-BPF kfunc API definitions */
+  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
+			      unsigned int offset,
+			      const size_t __sz) __ksym;
+  extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+
+  struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096 * 64);
+  } ringbuf SEC(".maps");
+
+  struct attach_prog_args {
+	int prog_fd;
+	unsigned int hid;
+	unsigned int flags;
+	int retval;
+  };
+
+  SEC("syscall")
+  int attach_prog(struct attach_prog_args *ctx)
+  {
+	ctx->retval = hid_bpf_attach_prog(ctx->hid,
+					  ctx->prog_fd,
+					  ctx->flags);
+	return 0;
+  }
+
+  __u8 current_value = 0;
+
+  SEC("?fmod_ret/hid_bpf_device_event")
+  int BPF_PROG(filter_switch, struct hid_bpf_ctx *hid_ctx)
+  {
+	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 192 /* size */);
+	__u8 *buf;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if (current_value != data[152]) {
+		buf = bpf_ringbuf_reserve(&ringbuf, 1, 0);
+		if (!buf)
+			return 0;
+
+		*buf = data[152];
+
+		bpf_ringbuf_commit(buf, 0);
+
+		current_value = data[152];
+	}
+
+	return 0;
+  }
+
+To attach ``filter_switch``, userspace needs to call the ``attach_prog`` syscall
+program first::
+
+  static int attach_filter(struct hid *hid_skel, int hid_id)
+  {
+	int err, prog_fd;
+	int ret = -1;
+	struct attach_prog_args args = {
+		.hid = hid_id,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+		.ctx_in = &args,
+		.ctx_size_in = sizeof(args),
+	);
+
+	args.prog_fd = bpf_program__fd(hid_skel->progs.filter_switch);
+
+	prog_fd = bpf_program__fd(hid_skel->progs.attach_prog);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+	return err;
+  }
+
+Our userspace program can now listen to notifications on the ring buffer, and
+is awaken only when the value changes.
+
+Controlling the device
+----------------------
+
+To be able to change the haptic feedback from the tablet, the userspace program
+needs to emit a feature report on the device itself.
+
+Instead of using hidraw for that, we can create a ``SEC("syscall")`` program
+that talks to the device::
+
+  /* some more HID-BPF kfunc API definitions */
+  extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
+  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
+  extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
+			      __u8* data,
+			      size_t len,
+			      enum hid_report_type type,
+			      int reqtype) __ksym;
+
+
+  struct hid_send_haptics_args {
+	/* data needs to come at offset 0 so we can do a memcpy into it */
+	__u8 data[10];
+	unsigned int hid;
+  };
+
+  SEC("syscall")
+  int send_haptic(struct hid_send_haptics_args *args)
+  {
+	struct hid_bpf_ctx *ctx;
+	int i, ret = 0;
+	__u8 *data;
+
+	ctx = hid_bpf_allocate_context(args->hid);
+	if (!ctx)
+		return 0; /* EPERM check */
+
+	/* We can not use the context data memory directly in the hid_bpf call,
+	 * so we rely on the PTR_TO_MEM allocated in the hid_bpf_context
+	 */
+	data = hid_bpf_get_data(ctx, 0 /* offset */, 10 /* size */);
+	if (!data)
+		goto out; /* EPERM check */
+
+	__builtin_memcpy(data, args->data, sizeof(args->data));
+
+	ret = hid_bpf_hw_request(ctx,
+				 data,
+				 10,
+				 HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
+	if (ret < 0)
+		goto out;
+
+	/* not strictly required here because we did a SET_REPORT */
+	__builtin_memcpy(args->data, data, sizeof(args->data));
+
+    out:
+	hid_bpf_release_context(ctx);
+
+	return ret;
+  }
+
+And then userspace needs to call that program directly::
+
+  static int set_haptic(struct hid *hid_skel, int hid_id, __u8 haptic_value)
+  {
+	int err, prog_fd;
+	int ret = -1;
+	struct hid_send_haptics_args args = {
+		.hid = hid_id,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+		.ctx_in = &args,
+		.ctx_size_in = sizeof(args),
+	);
+
+	args.data[0] = 0x02; /* report ID of the feature on our device */
+	args.data[1] = haptic_value;
+
+	prog_fd = bpf_program__fd(hid_skel->progs.set_haptic);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+	return err;
+  }
+
+Now our userspace program is aware of the haptic state and can control it. The
+program could make this state further available to other userspace programs
+(e.g. via a DBus API).
+
+The interesting bit here is that we did not created a new kernel API for this.
+Which means that if there is a bug in our implementation, we can change the
+interface with the kernel at-will, because the userspace application is
+responsible for its own usage.
diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
index e50f513c579c..b2028f382f11 100644
--- a/Documentation/hid/index.rst
+++ b/Documentation/hid/index.rst
@@ -11,6 +11,7 @@ Human Interface Devices (HID)
    hidraw
    hid-sensor
    hid-transport
+   hid-bpf
 
    uhid
 
-- 
2.36.1

