Return-Path: <linux-kselftest+bounces-11402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9042F900908
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A19284BE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6319D097;
	Fri,  7 Jun 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjMd8FoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3619D092;
	Fri,  7 Jun 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774136; cv=none; b=kACwCE2dUEOnwczk0OqW+jx3LHAA7CQzsrszNfS+nXCRbaPAmhg5ORotNZ9GLTK9AI3okJiyldq7PPAB5mym1dq7mW9ylhhP+FaOU/0c9Vr9Zu6jPa+hMByfKV9xRTSFPQw0iPQ6OhdSx5MQZB1rwMFSJmomCsck7waJmllptBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774136; c=relaxed/simple;
	bh=qsi2LhwRgYOASPM3LWMIAZPkz8idIEDnQJkydUOOih4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRpfAVWy95RIoKzhS5C/YuQHOTwEgDQtV2Lvq7yOfEVYTrO4e5vf1JUFUBaV33g/u4+HZotCE7c2Cm8IBtfR2f/8vzePLMK81bAtYvoik8+N+S2ONMzKn0KM3C4K4uHxfdpBUCva77fRZWBYIdW03XQKnsIfP59s2kQrN5uvPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjMd8FoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D9EC2BBFC;
	Fri,  7 Jun 2024 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774135;
	bh=qsi2LhwRgYOASPM3LWMIAZPkz8idIEDnQJkydUOOih4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cjMd8FoYFWxoKOQDVVtqO58gjvKAK+MwWpx4f4TCU9AO1GdCeOwNxlv6HL1Wgseyz
	 S7YbuC2dz05bvbqMSbSnvgqrE571+Kex4f2gJRUsKI/GJEeH4imMpennGF2q3/WwxI
	 7EwkgUdguM/ikZoDu2IvIitTV2rlh4SVRixIP9fkpPpKNwvm78RFNzOjOCjYpSMccT
	 5EeeiLC5SngFyz7hUmHJR7kBwCXPImsu3tTq8ryYpZ2Boi8JxknHtb/eyhDTQagQmR
	 9QgUbvLayDqLbcZChesAYks5EfB9CsxA+joXdBvSDGjMZP6vtHkrKlXtDLchWZuKUW
	 b1iBBULrRm7Bg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:30 +0200
Subject: [PATCH HID v2 10/16] Documentation: HID: amend HID-BPF for
 struct_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-10-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=14074;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=qsi2LhwRgYOASPM3LWMIAZPkz8idIEDnQJkydUOOih4=;
 b=HeljEuvcgEKmUYzGGaur59R4Ezq+0pYXB512zL/DJfAy+BxyinFvDVqh8Xj+A0v/lOBz0n7xG
 AX5avUlMSSpAAudHNNtLxHNU1PvJ5RQExxJ/4ZTUVpR6OiN90Gg0qEN
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now that we are using struct_ops, the docs need to be changed.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2
- use BPF_F_BEFORE
---
 Documentation/hid/hid-bpf.rst | 156 +++++++++++++++++++-----------------------
 include/linux/hid_bpf.h       |   8 +--
 2 files changed, 76 insertions(+), 88 deletions(-)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index 0765b3298ecf..456e15097d87 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -132,16 +132,17 @@ input events.
 Available types of programs
 ===========================
 
-HID-BPF is built "on top" of BPF, meaning that we use tracing method to
+HID-BPF is built "on top" of BPF, meaning that we use bpf struct_ops method to
 declare our programs.
 
 HID-BPF has the following attachment types available:
 
-1. event processing/filtering with ``SEC("fmod_ret/hid_bpf_device_event")`` in libbpf
+1. event processing/filtering with ``SEC("struct_ops/hid_device_event")`` in libbpf
 2. actions coming from userspace with ``SEC("syscall")`` in libbpf
-3. change of the report descriptor with ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` in libbpf
+3. change of the report descriptor with ``SEC("struct_ops/hid_rdesc_fixup")`` or
+   ``SEC("struct_ops.s/hid_rdesc_fixup")`` in libbpf
 
-A ``hid_bpf_device_event`` is calling a BPF program when an event is received from
+A ``hid_device_event`` is calling a BPF program when an event is received from
 the device. Thus we are in IRQ context and can act on the data or notify userspace.
 And given that we are in IRQ context, we can not talk back to the device.
 
@@ -149,37 +150,42 @@ A ``syscall`` means that userspace called the syscall ``BPF_PROG_RUN`` facility.
 This time, we can do any operations allowed by HID-BPF, and talking to the device is
 allowed.
 
-Last, ``hid_bpf_rdesc_fixup`` is different from the others as there can be only one
+Last, ``hid_rdesc_fixup`` is different from the others as there can be only one
 BPF program of this type. This is called on ``probe`` from the driver and allows to
-change the report descriptor from the BPF program. Once a ``hid_bpf_rdesc_fixup``
+change the report descriptor from the BPF program. Once a ``hid_rdesc_fixup``
 program has been loaded, it is not possible to overwrite it unless the program which
 inserted it allows us by pinning the program and closing all of its fds pointing to it.
 
+Note that ``hid_rdesc_fixup`` can be declared as sleepable (``SEC("struct_ops.s/hid_rdesc_fixup")``).
+
+
 Developer API:
 ==============
 
-User API data structures available in programs:
------------------------------------------------
+Available ``struct_ops`` for HID-BPF:
+-------------------------------------
 
 .. kernel-doc:: include/linux/hid_bpf.h
+   :identifiers: hid_bpf_ops
 
-Available tracing functions to attach a HID-BPF program:
---------------------------------------------------------
 
-.. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_device_event hid_bpf_rdesc_fixup
+User API data structures available in programs:
+-----------------------------------------------
+
+.. kernel-doc:: include/linux/hid_bpf.h
+   :identifiers: hid_bpf_ctx
 
-Available API that can be used in all HID-BPF programs:
--------------------------------------------------------
+Available API that can be used in all HID-BPF struct_ops programs:
+------------------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_get_data
+   :identifiers: hid_bpf_get_data
 
-Available API that can be used in syscall HID-BPF programs:
------------------------------------------------------------
+Available API that can be used in syscall HID-BPF programs or in sleepable HID-BPF struct_ops programs:
+-------------------------------------------------------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_input_report hid_bpf_allocate_context hid_bpf_release_context
+   :identifiers: hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_input_report hid_bpf_allocate_context hid_bpf_release_context
 
 General overview of a HID-BPF program
 =====================================
@@ -222,20 +228,21 @@ This allows the following:
 Effect of a HID-BPF program
 ---------------------------
 
-For all HID-BPF attachment types except for :c:func:`hid_bpf_rdesc_fixup`, several eBPF
-programs can be attached to the same device.
+For all HID-BPF attachment types except for :c:func:`hid_rdesc_fixup`, several eBPF
+programs can be attached to the same device. If a HID-BPF struct_ops has a
+:c:func:`hid_rdesc_fixup` while another is already attached to the device, the
+kernel will return `-EINVAL` when attaching the struct_ops.
 
-Unless ``HID_BPF_FLAG_INSERT_HEAD`` is added to the flags while attaching the
-program, the new program is appended at the end of the list.
-``HID_BPF_FLAG_INSERT_HEAD`` will insert the new program at the beginning of the
-list which is useful for e.g. tracing where we need to get the unprocessed events
-from the device.
+Unless ``BPF_F_BEFORE`` is added to the flags while attaching the program, the new
+program is appended at the end of the list.
+``BPF_F_BEFORE`` will insert the new program at the beginning of the list which is
+useful for e.g. tracing where we need to get the unprocessed events from the device.
 
-Note that if there are multiple programs using the ``HID_BPF_FLAG_INSERT_HEAD`` flag,
+Note that if there are multiple programs using the ``BPF_F_BEFORE`` flag,
 only the most recently loaded one is actually the first in the list.
 
-``SEC("fmod_ret/hid_bpf_device_event")``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+``SEC("struct_ops/hid_device_event")``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Whenever a matching event is raised, the eBPF programs are called one after the other
 and are working on the same data buffer.
@@ -258,17 +265,17 @@ with, userspace needs to refer to the device by its unique system id (the last 4
 in the sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``).
 
 To retrieve a context associated with the device, the program must call
-:c:func:`hid_bpf_allocate_context` and must release it with :c:func:`hid_bpf_release_context`
+hid_bpf_allocate_context() and must release it with hid_bpf_release_context()
 before returning.
 Once the context is retrieved, one can also request a pointer to kernel memory with
-:c:func:`hid_bpf_get_data`. This memory is big enough to support all input/output/feature
+hid_bpf_get_data(). This memory is big enough to support all input/output/feature
 reports of the given device.
 
-``SEC("fmod_ret/hid_bpf_rdesc_fixup")``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+``SEC("struct_ops/hid_rdesc_fixup")``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The ``hid_bpf_rdesc_fixup`` program works in a similar manner to
-``.report_fixup`` of ``struct hid_driver``.
+The ``hid_rdesc_fixup`` program works in a similar manner to ``.report_fixup``
+of ``struct hid_driver``.
 
 When the device is probed, the kernel sets the data buffer of the context with the
 content of the report descriptor. The memory associated with that buffer is
@@ -277,33 +284,31 @@ content of the report descriptor. The memory associated with that buffer is
 The eBPF program can modify the data buffer at-will and the kernel uses the
 modified content and size as the report descriptor.
 
-Whenever a ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program is attached (if no
-program was attached before), the kernel immediately disconnects the HID device
-and does a reprobe.
+Whenever a struct_ops containing a ``SEC("struct_ops/hid_rdesc_fixup")`` program
+is attached (if no program was attached before), the kernel immediately disconnects
+the HID device and does a reprobe.
 
-In the same way, when the ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` program is
-detached, the kernel issues a disconnect on the device.
+In the same way, when this struct_ops is detached, the kernel issues a disconnect
+on the device.
 
 There is no ``detach`` facility in HID-BPF. Detaching a program happens when
-all the user space file descriptors pointing at a program are closed.
+all the user space file descriptors pointing at a HID-BPF struct_ops link are closed.
 Thus, if we need to replace a report descriptor fixup, some cooperation is
 required from the owner of the original report descriptor fixup.
-The previous owner will likely pin the program in the bpffs, and we can then
+The previous owner will likely pin the struct_ops link in the bpffs, and we can then
 replace it through normal bpf operations.
 
 Attaching a bpf program to a device
 ===================================
 
-``libbpf`` does not export any helper to attach a HID-BPF program.
-Users need to use a dedicated ``syscall`` program which will call
-``hid_bpf_attach_prog(hid_id, program_fd, flags)``.
+We now use standard struct_ops attachment through ``bpf_map__attach_struct_ops()``.
+But given that we need to attach a struct_ops to a dedicated HID device, the caller
+must set ``hid_id`` in the struct_ops map before loading the program in the kernel.
 
 ``hid_id`` is the unique system ID of the HID device (the last 4 numbers in the
 sysfs path: ``/sys/bus/hid/devices/xxxx:yyyy:zzzz:0000``)
 
-``progam_fd`` is the opened file descriptor of the program to attach.
-
-``flags`` is of type ``enum hid_bpf_attach_flags``.
+One can also set ``flags``, which is of type ``enum hid_bpf_attach_flags``.
 
 We can not rely on hidraw to bind a BPF program to a HID device. hidraw is an
 artefact of the processing of the HID device, and is not stable. Some drivers
@@ -358,32 +363,15 @@ For that, we can create a basic skeleton for our BPF program::
   extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
 			      const size_t __sz) __ksym;
-  extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
 
   struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
 	__uint(max_entries, 4096 * 64);
   } ringbuf SEC(".maps");
 
-  struct attach_prog_args {
-	int prog_fd;
-	unsigned int hid;
-	unsigned int flags;
-	int retval;
-  };
-
-  SEC("syscall")
-  int attach_prog(struct attach_prog_args *ctx)
-  {
-	ctx->retval = hid_bpf_attach_prog(ctx->hid,
-					  ctx->prog_fd,
-					  ctx->flags);
-	return 0;
-  }
-
   __u8 current_value = 0;
 
-  SEC("?fmod_ret/hid_bpf_device_event")
+  SEC("struct_ops/hid_device_event")
   int BPF_PROG(filter_switch, struct hid_bpf_ctx *hid_ctx)
   {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 192 /* size */);
@@ -407,37 +395,37 @@ For that, we can create a basic skeleton for our BPF program::
 	return 0;
   }
 
-To attach ``filter_switch``, userspace needs to call the ``attach_prog`` syscall
-program first::
+  SEC(".struct_ops.link")
+  struct hid_bpf_ops haptic_tablet = {
+  	.hid_device_event = (void *)filter_switch,
+  };
+
+
+To attach ``haptic_tablet``, userspace needs to set ``hid_id`` first::
 
   static int attach_filter(struct hid *hid_skel, int hid_id)
   {
-	int err, prog_fd;
-	int ret = -1;
-	struct attach_prog_args args = {
-		.hid = hid_id,
-	};
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
-		.ctx_in = &args,
-		.ctx_size_in = sizeof(args),
-	);
+  	int err, link_fd;
 
-	args.prog_fd = bpf_program__fd(hid_skel->progs.filter_switch);
+  	hid_skel->struct_ops.haptic_tablet->hid_id = hid_id;
+  	err = hid__load(skel);
+  	if (err)
+  		return err;
 
-	prog_fd = bpf_program__fd(hid_skel->progs.attach_prog);
-
-	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
-	if (err)
-		return err;
+  	link_fd = bpf_map__attach_struct_ops(hid_skel->maps.haptic_tablet);
+  	if (!link_fd) {
+  		fprintf(stderr, "can not attach HID-BPF program: %m\n");
+  		return -1;
+  	}
 
-	return args.retval; /* the fd of the created bpf_link */
+  	return link_fd; /* the fd of the created bpf_link */
   }
 
 Our userspace program can now listen to notifications on the ring buffer, and
 is awaken only when the value changes.
 
 When the userspace program doesn't need to listen to events anymore, it can just
-close the returned fd from :c:func:`attach_filter`, which will tell the kernel to
+close the returned bpf link from :c:func:`attach_filter`, which will tell the kernel to
 detach the program from the HID device.
 
 Of course, in other use cases, the userspace program can also pin the fd to the
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 06ce3d688915..88ab4925bdaa 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -20,11 +20,9 @@ struct hid_device;
  * struct hid_bpf_ctx - User accessible data for all HID programs
  *
  * ``data`` is not directly accessible from the context. We need to issue
- * a call to ``hid_bpf_get_data()`` in order to get a pointer to that field.
+ * a call to hid_bpf_get_data() in order to get a pointer to that field.
  *
- * All of these fields are currently read-only.
- *
- * @hid: the ``struct hid_device`` representing the device itself
+ * @hid: the &struct hid_device representing the device itself
  * @allocated_size: Allocated size of data.
  *
  *                  This is how much memory is available and can be requested
@@ -41,6 +39,8 @@ struct hid_device;
  *        ``size`` must always be less or equal than ``allocated_size`` (it is enforced
  *        once all BPF programs have been run).
  * @retval: Return value of the previous program.
+ *
+ * ``hid`` and ``allocated_size`` are read-only, ``size`` and ``retval`` are read-write.
  */
 struct hid_bpf_ctx {
 	const struct hid_device *hid;

-- 
2.44.0


