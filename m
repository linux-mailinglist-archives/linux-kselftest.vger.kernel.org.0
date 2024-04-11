Return-Path: <linux-kselftest+bounces-7678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D88A094F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 09:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631D01F22304
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97C13E051;
	Thu, 11 Apr 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH0dSsNK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213013DDAA;
	Thu, 11 Apr 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819388; cv=none; b=R9LsJKsAm7j4VjV6OqKsIlbzfO5KSgw2KtxIfO1us0f34pOWLQLPHClLP+9Oa3vr1WfdPzLFgTFRE3D/qLYRYuMWBmbDDpAfzuFaU2HEHrVTVuTyZijxHOFf4rTEg8RU18dEFRC7sYTquxK5ryN8L8Nv2aeMTWy4rHloyiH/pvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819388; c=relaxed/simple;
	bh=u/99Ell+Ur4SN7T9Ld3f5Z3d9TrEaJNxudkamV0EB6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN5+KU13dMTQV+RHW4FgZs+mIYjv7y9eJ0kf9EgY2FlitbYx5Wq8ReXWFzLhISr8/tiSxXM+75/qA2kewwC8ggwfzEDDAEFP0x7TquBwTH2wljAPIPUDYhvQksSrAgSCmPG1XcPHn6OXKMWlYUzoeIMuixg306LSxPlV+BFm/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH0dSsNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24342C433C7;
	Thu, 11 Apr 2024 07:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819387;
	bh=u/99Ell+Ur4SN7T9Ld3f5Z3d9TrEaJNxudkamV0EB6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sH0dSsNKGZ0nxZCZAbL3Ro+C+IXZ5BePFXxhMvlQJgOP7HIPWqyUVvknb+NJgf+Uc
	 J8vhySqc50b3f1XwffWMLEY57Opde8d1wdSCES0DNQKWx+yQM+GIq5osvZL1FwQFH3
	 I1bQqm3ujF2Ahd+UIiUMccNpKSTmk0MBXxPWJPI2f4UHL4bKCHRbYwu3kAneTYviEq
	 cblIL8Qcl/+SxIYRPJv9C3q1q/MKViBlayKu9Q0BjzCdGNhAJGJyuLgJ938jOZmOUm
	 jRYYTsxjXhU2Pm510SgArJEMLKdpBltdT9vhvxIjXMrCADvQRWdvCJolIx5aWdpHjq
	 Ji8Dl8SdlttJQ==
Date: Thu, 11 Apr 2024 09:09:43 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/18] HID: bpf: add first in-tree HID-BPF fix for the
 XPPen Artist 24
Message-ID: <6gnv3evwgshfonkkw4fiwgaweg2kd3dbitjgdrzeorunyvu3lh@xzf7mfwwfjvp>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
 <20240410-bpf_sources-v1-2-a8bf16033ef8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410-bpf_sources-v1-2-a8bf16033ef8@kernel.org>

On Apr 10 2024, Benjamin Tissoires wrote:
> This commit adds a fix for XPPen Artist 24 where the second button on
> the pen is used as an eraser.
> 
> It's a "feature" from Microsoft, but it turns out that it's actually
> painful for artists. So we ship here a HID-BPF program that turns this
> second button into an actual button.
> 
> Note that the HID-BPF program is not directly loaded by the kernel itself
> but by udev-hid-bpf[0]. But having the sources here allows us to also
> integrate tests into tools/testing/selftests/hid to ensure the HID-BPF
> program are actually tested.
> 
> [0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/bpf/progs/Makefile              |  91 +++++++++++
>  drivers/hid/bpf/progs/README                | 102 +++++++++++++
>  drivers/hid/bpf/progs/XPPen__Artist24.bpf.c | 229 ++++++++++++++++++++++++++++
>  drivers/hid/bpf/progs/hid_bpf.h             |  15 ++
>  drivers/hid/bpf/progs/hid_bpf_helpers.h     | 170 +++++++++++++++++++++
>  5 files changed, 607 insertions(+)
> 
> diff --git a/drivers/hid/bpf/progs/Makefile b/drivers/hid/bpf/progs/Makefile
> new file mode 100644
> index 000000000000..63ed7e02adf1
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/Makefile
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0
> +OUTPUT := .output
> +abs_out := $(abspath $(OUTPUT))
> +
> +CLANG ?= clang
> +LLC ?= llc
> +LLVM_STRIP ?= llvm-strip
> +
> +TOOLS_PATH := $(abspath ../../../../tools)
> +BPFTOOL_SRC := $(TOOLS_PATH)/bpf/bpftool
> +BPFTOOL_OUTPUT := $(abs_out)/bpftool
> +DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
> +BPFTOOL ?= $(DEFAULT_BPFTOOL)
> +
> +LIBBPF_SRC := $(TOOLS_PATH)/lib/bpf
> +LIBBPF_OUTPUT := $(abs_out)/libbpf
> +LIBBPF_DESTDIR := $(LIBBPF_OUTPUT)
> +LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)/include
> +BPFOBJ := $(LIBBPF_OUTPUT)/libbpf.a
> +
> +INCLUDES := -I$(OUTPUT) -I$(LIBBPF_INCLUDE) -I$(TOOLS_PATH)/include/uapi
> +CFLAGS := -g -Wall
> +
> +VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
> +		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
> +		     ../../../../vmlinux				\
> +		     /sys/kernel/btf/vmlinux				\
> +		     /boot/vmlinux-$(shell uname -r)
> +VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> +ifeq ($(VMLINUX_BTF),)
> +$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
> +endif
> +
> +ifeq ($(V),1)
> +Q =
> +msg =
> +else
> +Q = @
> +msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
> +MAKEFLAGS += --no-print-directory
> +submake_extras := feature_display=0
> +endif
> +
> +.DELETE_ON_ERROR:
> +
> +.PHONY: all clean
> +
> +SOURCES = $(wildcard *.bpf.c)
> +TARGETS = $(SOURCES:.bpf.c=.bpf.o)
> +
> +all: $(TARGETS)
> +
> +clean:
> +	$(call msg,CLEAN)
> +	$(Q)rm -rf $(OUTPUT) $(TARGETS)
> +
> +%.bpf.o: %.bpf.c vmlinux.h $(BPFOBJ) | $(OUTPUT)
> +	$(call msg,BPF,$@)
> +	$(Q)$(CLANG) -g -O2 --target=bpf $(INCLUDES)			      \
> +		 -c $(filter %.c,$^) -o $@ &&				      \
> +	$(LLVM_STRIP) -g $@
> +
> +vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
> +ifeq ($(VMLINUX_H),)
> +	$(call msg,GEN,,$@)
> +	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
> +else
> +	$(call msg,CP,,$@)
> +	$(Q)cp "$(VMLINUX_H)" $@
> +endif
> +
> +$(OUTPUT) $(LIBBPF_OUTPUT) $(BPFTOOL_OUTPUT):
> +	$(call msg,MKDIR,$@)
> +	$(Q)mkdir -p $@
> +
> +$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
> +	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
> +		    OUTPUT=$(abspath $(dir $@))/ prefix=		       \
> +		    DESTDIR=$(LIBBPF_DESTDIR) $(abspath $@) install_headers
> +
> +ifeq ($(CROSS_COMPILE),)
> +$(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
> +	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
> +		    OUTPUT=$(BPFTOOL_OUTPUT)/				       \
> +		    LIBBPF_BOOTSTRAP_OUTPUT=$(LIBBPF_OUTPUT)/		       \
> +		    LIBBPF_BOOTSTRAP_DESTDIR=$(LIBBPF_DESTDIR)/ bootstrap
> +else
> +$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
> +	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
> +		    OUTPUT=$(BPFTOOL_OUTPUT)/ bootstrap
> +endif
> diff --git a/drivers/hid/bpf/progs/README b/drivers/hid/bpf/progs/README
> new file mode 100644
> index 000000000000..20b0928f385b
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/README
> @@ -0,0 +1,102 @@
> +# HID-BPF programs
> +
> +This directory contains various fixes for devices. They add new features or
> +fix some behaviors without being entirely mandatory. It is better to load them
> +when you have such a device, but they should not be a requirement for a device
> +to be working during the boot stage.
> +
> +The .bpf.c files provided here are not automatically compiled in the kernel.
> +They should be loaded in the kernel by `udev-hid-bpf`:
> +
> +https://gitlab.freedesktop.org/libevdev/udev-hid-bpf
> +
> +The main reasons for these fixes to be here is to have a central place to
> +"upstream" them, but also this way we can test them thanks to the HID
> +selftests.
> +
> +Once a .bpf.c file is accepted here, it is duplicated in `udev-hid-bpf`
> +in the `src/bpf/stable` directory, and distributions are encouraged to
> +only ship those bpf objects. So adding a file here should eventually
> +land in distributions when they update `udev-hid-bpf`
> +
> +## Compilation
> +
> +Just run `make`
> +
> +## Installation
> +
> +### Automated way
> +
> +Just run `sudo udev-hid-bpf install ./my-awesome-fix.bpf.o`
> +
> +### Manual way
> +
> +- copy the `.bpf.o` you want in `/etc/udev-hid-bpf/`
> +- create a new udev rule to automatically load it
> +
> +The following should do the trick (assuming udev-hid-bpf is available in
> +/usr/bin):
> +
> +```
> +$> cp xppen-ArtistPro16Gen2.bpf.o /etc/udev-hid-bpf/
> +$> udev-hid-bpf inspect xppen-ArtistPro16Gen2.bpf.o
> +[
> +  {
> +    "name": "xppen-ArtistPro16Gen2.bpf.o",
> +    "devices": [
> +      {
> +        "bus": "0x0003",
> +        "group": "0x0001",
> +        "vid": "0x28BD",
> +        "pid": "0x095A"
> +      },
> +      {
> +        "bus": "0x0003",
> +        "group": "0x0001",
> +        "vid": "0x28BD",
> +        "pid": "0x095B"
> +      }
> +    ],
> +...
> +$> cat <EOF > /etc/udev/rules.d/99-load-hid-bpf-xppen-ArtistPro16Gen2.rules
> +ACTION!="add|remove", GOTO="hid_bpf_end"
> +SUBSYSTEM!="hid", GOTO="hid_bpf_end"
> +
> +# xppen-ArtistPro16Gen2.bpf.o
> +ACTION=="add",ENV{MODALIAS}=="hid:b0003g0001v000028BDp0000095A", RUN{program}+="/usr/local/bin/udev-hid-bpf add $sys$devpath /etc/udev-hid-bpf/xppen-ArtistPro16Gen2.bpf.o"
> +ACTION=="remove",ENV{MODALIAS}=="hid:b0003g0001v000028BDp0000095A", RUN{program}+="/usr/local/bin/udev-hid-bpf remove $sys$devpath "
> +# xppen-ArtistPro16Gen2.bpf.o
> +ACTION=="add",ENV{MODALIAS}=="hid:b0003g0001v000028BDp0000095B", RUN{program}+="/usr/local/bin/udev-hid-bpf add $sys$devpath /etc/udev-hid-bpf/xppen-ArtistPro16Gen2.bpf.o"
> +ACTION=="remove",ENV{MODALIAS}=="hid:b0003g0001v000028BDp0000095B", RUN{program}+="/usr/local/bin/udev-hid-bpf remove $sys$devpath "
> +
> +LABEL="hid_bpf_end"
> +EOF
> +$> udevadm control --reload
> +```
> +
> +Then unplug and replug the device.
> +
> +## Checks
> +
> +### udev rule
> +
> +You can check that the udev rule is correctly working by issuing
> +
> +```
> +$> udevadm test /sys/bus/hid/devices/0003:28BD:095B*
> +...
> +run: '/usr/local/bin/udev-hid-bpf add /sys/devices/virtual/misc/uhid/0003:28BD:095B.0E57 /etc/udev-hid-bpf/xppen-ArtistPro16Gen2.bpf.o'
> +```
> +
> +### program loaded
> +
> +You can check that the program has been properly loaded with `bpftool`
> +
> +```
> +$> bpftool prog
> +...
> +247: tracing  name xppen_16_fix_eraser tag 18d389353ed2ef07  gpl
> +	loaded_at 2024-03-28T16:02:28+0100  uid 0
> +	xlated 120B  jited 77B  memlock 4096B
> +	btf_id 487
> +```
> diff --git a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
> new file mode 100644
> index 000000000000..e1be6a12bb75
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2023 Benjamin Tissoires
> + */
> +
> +#include "vmlinux.h"
> +#include "hid_bpf.h"
> +#include "hid_bpf_helpers.h"
> +#include <bpf/bpf_tracing.h>
> +
> +#define VID_UGEE 0x28BD /* VID is shared with SinoWealth and Glorious and prob others */
> +#define PID_ARTIST_24 0x093A
> +#define PID_ARTIST_24_PRO 0x092D
> +
> +HID_BPF_CONFIG(
> +	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_UGEE, PID_ARTIST_24),
> +	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_UGEE, PID_ARTIST_24_PRO)
> +);
> +
> +/*
> + * We need to amend the report descriptor for the following:
> + * - the device reports Eraser instead of using Secondary Barrel Switch
> + * - the pen doesn't have a rubber tail, so basically we are removing any
> + *   eraser/invert bits
> + */
> +static const __u8 fixed_rdesc[] = {
> +	0x05, 0x0d,                    // Usage Page (Digitizers)             0
> +	0x09, 0x02,                    // Usage (Pen)                         2
> +	0xa1, 0x01,                    // Collection (Application)            4
> +	0x85, 0x07,                    //  Report ID (7)                      6
> +	0x09, 0x20,                    //  Usage (Stylus)                     8
> +	0xa1, 0x00,                    //  Collection (Physical)              10
> +	0x09, 0x42,                    //   Usage (Tip Switch)                12
> +	0x09, 0x44,                    //   Usage (Barrel Switch)             14
> +	0x09, 0x5a,                    //   Usage (Secondary Barrel Switch)   16  /* changed from 0x45 (Eraser) to 0x5a (Secondary Barrel Switch) */
> +	0x15, 0x00,                    //   Logical Minimum (0)               18
> +	0x25, 0x01,                    //   Logical Maximum (1)               20
> +	0x75, 0x01,                    //   Report Size (1)                   22
> +	0x95, 0x03,                    //   Report Count (3)                  24
> +	0x81, 0x02,                    //   Input (Data,Var,Abs)              26
> +	0x95, 0x02,                    //   Report Count (2)                  28
> +	0x81, 0x03,                    //   Input (Cnst,Var,Abs)              30
> +	0x09, 0x32,                    //   Usage (In Range)                  32
> +	0x95, 0x01,                    //   Report Count (1)                  34
> +	0x81, 0x02,                    //   Input (Data,Var,Abs)              36
> +	0x95, 0x02,                    //   Report Count (2)                  38
> +	0x81, 0x03,                    //   Input (Cnst,Var,Abs)              40
> +	0x75, 0x10,                    //   Report Size (16)                  42
> +	0x95, 0x01,                    //   Report Count (1)                  44
> +	0x35, 0x00,                    //   Physical Minimum (0)              46
> +	0xa4,                          //   Push                              48
> +	0x05, 0x01,                    //   Usage Page (Generic Desktop)      49
> +	0x09, 0x30,                    //   Usage (X)                         51
> +	0x65, 0x13,                    //   Unit (EnglishLinear: in)          53
> +	0x55, 0x0d,                    //   Unit Exponent (-3)                55
> +	0x46, 0xf0, 0x50,              //   Physical Maximum (20720)          57
> +	0x26, 0xff, 0x7f,              //   Logical Maximum (32767)           60
> +	0x81, 0x02,                    //   Input (Data,Var,Abs)              63
> +	0x09, 0x31,                    //   Usage (Y)                         65
> +	0x46, 0x91, 0x2d,              //   Physical Maximum (11665)          67
> +	0x26, 0xff, 0x7f,              //   Logical Maximum (32767)           70
> +	0x81, 0x02,                    //   Input (Data,Var,Abs)              73
> +	0xb4,                          //   Pop                               75
> +	0x09, 0x30,                    //   Usage (Tip Pressure)              76
> +	0x45, 0x00,                    //   Physical Maximum (0)              78
> +	0x26, 0xff, 0x1f,              //   Logical Maximum (8191)            80
> +	0x81, 0x42,                    //   Input (Data,Var,Abs,Null)         83
> +	0x09, 0x3d,                    //   Usage (X Tilt)                    85
> +	0x15, 0x81,                    //   Logical Minimum (-127)            87
> +	0x25, 0x7f,                    //   Logical Maximum (127)             89
> +	0x75, 0x08,                    //   Report Size (8)                   91
> +	0x95, 0x01,                    //   Report Count (1)                  93
> +	0x81, 0x02,                    //   Input (Data,Var,Abs)              95
> +	0x09, 0x3e,                    //   Usage (Y Tilt)                    97
> +	0x15, 0x81,                    //   Logical Minimum (-127)            99
> +	0x25, 0x7f,                    //   Logical Maximum (127)             101
> +	0x81, 0x02,                    //   Input (Data,Var,Abs)              103
> +	0xc0,                          //  End Collection                     105
> +	0xc0,                          // End Collection                      106
> +};
> +
> +#define BIT(n) (1UL << n)
> +
> +#define TIP_SWITCH		BIT(0)
> +#define BARREL_SWITCH		BIT(1)
> +#define ERASER			BIT(2)
> +/* padding			BIT(3) */
> +/* padding			BIT(4) */
> +#define IN_RANGE		BIT(5)
> +/* padding			BIT(6) */
> +/* padding			BIT(7) */
> +
> +#define U16(index) (data[index] | (data[index + 1] << 8))
> +
> +SEC("fmod_ret/hid_bpf_rdesc_fixup")
> +int BPF_PROG(hid_fix_rdesc_xppen_artist24, struct hid_bpf_ctx *hctx)
> +{
> +	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
> +
> +	if (!data)
> +		return 0; /* EPERM check */
> +
> +	__builtin_memcpy(data, fixed_rdesc, sizeof(fixed_rdesc));
> +
> +	return sizeof(fixed_rdesc);
> +}
> +
> +static __u8 prev_state = 0;
> +
> +/*
> + * There are a few cases where the device is sending wrong event
> + * sequences, all related to the second button (the pen doesn't
> + * have an eraser switch on the tail end):
> + *
> + *   whenever the second button gets pressed or released, an
> + *   out-of-proximity event is generated and then the firmware
> + *   compensate for the missing state (and the firmware uses
> + *   eraser for that button):
> + *
> + *   - if the pen is in range, an extra out-of-range is sent
> + *     when the second button is pressed/released:
> + *     // Pen is in range
> + *     E:                               InRange
> + *
> + *     // Second button is pressed
> + *     E:
> + *     E:                        Eraser InRange
> + *
> + *     // Second button is released
> + *     E:
> + *     E:                               InRange
> + *
> + *     This case is ignored by this filter, it's "valid"
> + *     and userspace knows how to deal with it, there are just
> + *     a few out-of-prox events generated, but the user doesn´t
> + *     see them.
> + *
> + *   - if the pen is in contact, 2 extra events are added when
> + *     the second button is pressed/released: an out of range
> + *     and an in range:
> + *
> + *     // Pen is in contact
> + *     E: TipSwitch                     InRange
> + *
> + *     // Second button is pressed
> + *     E:                                         <- false release, needs to be filtered out
> + *     E:                        Eraser InRange   <- false release, needs to be filtered out
> + *     E: TipSwitch              Eraser InRange
> + *
> + *     // Second button is released
> + *     E:                                         <- false release, needs to be filtered out
> + *     E:                               InRange   <- false release, needs to be filtered out
> + *     E: TipSwitch                     InRange
> + *
> + */
> +SEC("fmod_ret/hid_bpf_device_event")
> +int BPF_PROG(xppen_24_fix_eraser, struct hid_bpf_ctx *hctx)
> +{
> +	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
> +	__u8 current_state, changed_state;
> +	bool prev_tip;
> +	__u16 tilt;
> +
> +	if (!data)
> +		return 0; /* EPERM check */
> +
> +	current_state = data[1];
> +
> +	/* if the state is identical to previously, early return */
> +	if (current_state == prev_state)
> +		return 0;
> +
> +	prev_tip = !!(prev_state & TIP_SWITCH);
> +
> +	/*
> +	 * Illegal transition: pen is in range with the tip pressed, and
> +	 * it goes into out of proximity.
> +	 *
> +	 * Ideally we should hold the event, start a timer and deliver it
> +	 * only if the timer ends, but we are not capable of that now.
> +	 *
> +	 * And it doesn't matter because when we are in such cases, this
> +	 * means we are detecting a false release.
> +	 */
> +	if ((current_state & IN_RANGE) == 0) {
> +		if (prev_tip)
> +			return HID_IGNORE_EVENT;
> +		return 0;
> +	}
> +
> +	/*
> +	 * XOR to only set the bits that have changed between
> +	 * previous and current state
> +	 */
> +	changed_state = prev_state ^ current_state;
> +
> +	/* Store the new state for future processing */
> +	prev_state = current_state;
> +
> +	/*
> +	 * We get both a tipswitch and eraser change in the same HID report:
> +	 * this is not an authorized transition and is unlikely to happen
> +	 * in real life.
> +	 * This is likely to be added by the firmware to emulate the
> +	 * eraser mode so we can skip the event.
> +	 */
> +	if ((changed_state & (TIP_SWITCH | ERASER)) == (TIP_SWITCH | ERASER)) /* we get both a tipswitch and eraser change at the same time */
> +		return HID_IGNORE_EVENT;
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int probe(struct hid_bpf_probe_args *ctx)
> +{
> +	/*
> +	 * The device exports 3 interfaces.
> +	 */
> +	ctx->retval = ctx->rdesc_size != 107;
> +	if (ctx->retval)
> +		ctx->retval = -EINVAL;
> +
> +	/* ensure the kernel isn't fixed already */
> +	if (ctx->rdesc[17] != 0x45) /* Eraser */
> +		ctx->retval = -EINVAL;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/drivers/hid/bpf/progs/hid_bpf.h b/drivers/hid/bpf/progs/hid_bpf.h
> new file mode 100644
> index 000000000000..7ee371cac2e1
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/hid_bpf.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2022 Benjamin Tissoires
> + */
> +
> +#ifndef ____HID_BPF__H
> +#define ____HID_BPF__H
> +
> +struct hid_bpf_probe_args {
> +	unsigned int hid;
> +	unsigned int rdesc_size;
> +	unsigned char rdesc[4096];
> +	int retval;
> +};
> +
> +#endif /* ____HID_BPF__H */
> diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
> new file mode 100644
> index 000000000000..1d53b10aaa2e
> --- /dev/null
> +++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
> @@ -0,0 +1,170 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2022 Benjamin Tissoires
> + */
> +
> +#ifndef __HID_BPF_HELPERS_H
> +#define __HID_BPF_HELPERS_H
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <linux/errno.h>
> +
> +extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> +			      unsigned int offset,
> +			      const size_t __sz) __ksym;
> +extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
> +extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
> +extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
> +			      __u8 *data,
> +			      size_t buf__sz,
> +			      enum hid_report_type type,
> +			      enum hid_class_request reqtype) __ksym;
> +
> +#define HID_MAX_DESCRIPTOR_SIZE	4096
> +#define HID_IGNORE_EVENT	-1
> +
> +/* extracted from <linux/input.h> */
> +#define BUS_ANY			0x00
> +#define BUS_PCI			0x01
> +#define BUS_ISAPNP		0x02
> +#define BUS_USB			0x03
> +#define BUS_HIL			0x04
> +#define BUS_BLUETOOTH		0x05
> +#define BUS_VIRTUAL		0x06
> +#define BUS_ISA			0x10
> +#define BUS_I8042		0x11
> +#define BUS_XTKBD		0x12
> +#define BUS_RS232		0x13
> +#define BUS_GAMEPORT		0x14
> +#define BUS_PARPORT		0x15
> +#define BUS_AMIGA		0x16
> +#define BUS_ADB			0x17
> +#define BUS_I2C			0x18
> +#define BUS_HOST		0x19
> +#define BUS_GSC			0x1A
> +#define BUS_ATARI		0x1B
> +#define BUS_SPI			0x1C
> +#define BUS_RMI			0x1D
> +#define BUS_CEC			0x1E
> +#define BUS_INTEL_ISHTP		0x1F
> +#define BUS_AMD_SFH		0x20
> +
> +/* extracted from <linux/hid.h> */
> +#define HID_GROUP_ANY				0x0000
> +#define HID_GROUP_GENERIC			0x0001
> +#define HID_GROUP_MULTITOUCH			0x0002
> +#define HID_GROUP_SENSOR_HUB			0x0003
> +#define HID_GROUP_MULTITOUCH_WIN_8		0x0004
> +#define HID_GROUP_RMI				0x0100
> +#define HID_GROUP_WACOM				0x0101
> +#define HID_GROUP_LOGITECH_DJ_DEVICE		0x0102
> +#define HID_GROUP_STEAM				0x0103
> +#define HID_GROUP_LOGITECH_27MHZ_DEVICE		0x0104
> +#define HID_GROUP_VIVALDI			0x0105
> +
> +/* include/linux/mod_devicetable.h defines as (~0), but that gives us negative size arrays */
> +#define HID_VID_ANY				0x0000
> +#define HID_PID_ANY				0x0000
> +
> +/* duplicated from incluse/linux/array_size.h
> + */

FWIW, Peter mentioned on the matching MR on udev-hid-bpf that this
comment was likely superflous:
https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/66#note_2365932

Cheers,
Benjamin

> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +
> +/* Helper macro to convert (foo, __LINE__)  into foo134 so we can use __LINE__ for
> + * field/variable names
> + */
> +#define COMBINE1(X, Y) X ## Y
> +#define COMBINE(X, Y) COMBINE1(X, Y)
> +
> +/* Macro magic:
> + * __uint(foo, 123) creates a int (*foo)[1234]
> + *
> + * We use that macro to declare an anonymous struct with several
> + * fields, each is the declaration of an pointer to an array of size
> + * bus/group/vid/pid. (Because it's a pointer to such an array, actual storage
> + * would be sizeof(pointer) rather than sizeof(array). Not that we ever
> + * instantiate it anyway).
> + *
> + * This is only used for BTF introspection, we can later check "what size
> + * is the bus array" in the introspection data and thus extract the bus ID
> + * again.
> + *
> + * And we use the __LINE__ to give each of our structs a unique name so the
> + * BPF program writer doesn't have to.
> + *
> + * $ bpftool btf dump file target/bpf/HP_Elite_Presenter.bpf.o
> + * shows the inspection data, start by searching for .hid_bpf_config
> + * and working backwards from that (each entry references the type_id of the
> + * content).
> + */
> +
> +#define HID_DEVICE(b, g, ven, prod)	\
> +	struct {			\
> +		__uint(name, 0);	\
> +		__uint(bus, (b));	\
> +		__uint(group, (g));	\
> +		__uint(vid, (ven));	\
> +		__uint(pid, (prod));	\
> +	} COMBINE(_entry, __LINE__)
> +
> +/* Macro magic below is to make HID_BPF_CONFIG() look like a function call that
> + * we can pass multiple HID_DEVICE() invocations in.
> + *
> + * For up to 16 arguments, HID_BPF_CONFIG(one, two) resolves to
> + *
> + * union {
> + *    HID_DEVICE(...);
> + *    HID_DEVICE(...);
> + * } _device_ids SEC(".hid_bpf_config")
> + *
> + */
> +
> +/* Returns the number of macro arguments, this expands
> + * NARGS(a, b, c) to NTH_ARG(a, b, c, 15, 14, 13, .... 4, 3, 2, 1).
> + * NTH_ARG always returns the 16th argument which in our case is 3.
> + *
> + * If we want more than 16 values _COUNTDOWN and _NTH_ARG both need to be
> + * updated.
> + */
> +#define _NARGS(...)  _NARGS1(__VA_ARGS__, _COUNTDOWN)
> +#define _NARGS1(...) _NTH_ARG(__VA_ARGS__)
> +
> +/* Add to this if we need more than 16 args */
> +#define _COUNTDOWN \
> +	15, 14, 13, 12, 11, 10, 9, 8,  \
> +	 7,  6,  5,  4,  3,  2, 1, 0
> +
> +/* Return the 16 argument passed in. See _NARGS above for usage. Note this is
> + * 1-indexed.
> + */
> +#define _NTH_ARG( \
> +	_1,  _2,  _3,  _4,  _5,  _6,  _7, _8, \
> +	_9, _10, _11, _12, _13, _14, _15,\
> +	 N, ...) N
> +
> +/* Turns EXPAND(_ARG, a, b, c) into _ARG3(a, b, c) */
> +#define _EXPAND(func, ...) COMBINE(func, _NARGS(__VA_ARGS__)) (__VA_ARGS__)
> +
> +/* And now define all the ARG macros for each number of args we want to accept */
> +#define _ARG1(_1)                                                         _1;
> +#define _ARG2(_1, _2)                                                     _1; _2;
> +#define _ARG3(_1, _2, _3)                                                 _1; _2; _3;
> +#define _ARG4(_1, _2, _3, _4)                                             _1; _2; _3; _4;
> +#define _ARG5(_1, _2, _3, _4, _5)                                         _1; _2; _3; _4; _5;
> +#define _ARG6(_1, _2, _3, _4, _5, _6)                                     _1; _2; _3; _4; _5; _6;
> +#define _ARG7(_1, _2, _3, _4, _5, _6, _7)                                 _1; _2; _3; _4; _5; _6; _7;
> +#define _ARG8(_1, _2, _3, _4, _5, _6, _7, _8)                             _1; _2; _3; _4; _5; _6; _7; _8;
> +#define _ARG9(_1, _2, _3, _4, _5, _6, _7, _8, _9)                         _1; _2; _3; _4; _5; _6; _7; _8; _9;
> +#define _ARG10(_1, _2, _3, _4, _5, _6, _7, _8, _9, _a)                     _1; _2; _3; _4; _5; _6; _7; _8; _9; _a;
> +#define _ARG11(_1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b)                 _1; _2; _3; _4; _5; _6; _7; _8; _9; _a; _b;
> +#define _ARG12(_1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c)             _1; _2; _3; _4; _5; _6; _7; _8; _9; _a; _b; _c;
> +#define _ARG13(_1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, _d)         _1; _2; _3; _4; _5; _6; _7; _8; _9; _a; _b; _c; _d;
> +#define _ARG14(_1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, _d, _e)     _1; _2; _3; _4; _5; _6; _7; _8; _9; _a; _b; _c; _d; _e;
> +#define _ARG15(_1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, _d, _e, _f) _1; _2; _3; _4; _5; _6; _7; _8; _9; _a; _b; _c; _d; _e; _f;
> +
> +
> +#define HID_BPF_CONFIG(...)  union { \
> +	_EXPAND(_ARG, __VA_ARGS__) \
> +} _device_ids SEC(".hid_bpf_config")
> +
> +#endif /* __HID_BPF_HELPERS_H */
> 
> -- 
> 2.44.0
> 

