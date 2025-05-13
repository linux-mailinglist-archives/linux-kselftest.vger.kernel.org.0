Return-Path: <linux-kselftest+bounces-32899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B58AB527F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 12:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC0D19E1885
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2824167D;
	Tue, 13 May 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yni1sjCp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBB241690
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130937; cv=none; b=ipOprowknUtWDOdme2rK9QcLbVz380Ps+ayoTEqIGyPGHnPUlXb/PGiDMWkh1Uo4B4nwje7nDoFFH1jkfPx1cI+hK04ceefkzdZU9m8/BgefWK/IepC64hETNNybR2oISC5r9o5l/LNN58ws6F0g3Jk01ACjgdruHzIl9u/j34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130937; c=relaxed/simple;
	bh=4VckvqPn7EO3j94yJh+DBfYD9uQ/3qARyzBskmt38UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baSCLlR5EXYJB5PXdfTyc2vwh1XkVv+LY36UwPUf/OEP9Y0Pox0YhbgaSGbtyfc35o+yAO3J3OqZF8ThMBfpDY6Sp4Zqc0IvuVPAHufLatcQlkt84kHkehdN9gM59W8JOeNl0Hq1rGLToRw65IxeUCePdphIK5IFTTFGTKPzwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yni1sjCp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747130933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3xt88UJJ72WfJejkpBXFIZcel7ydvHEDPDn9ATzxlg=;
	b=Yni1sjCpN7zOwpeSkWVCRB5W03WK80kXAbgLVk00x+ei0QdhunviaS7yLxv1JVUHdqOd4o
	CXw7dRwIyAl3yIAnVvKs/AHdg7Lybv+iVK7x/M8urn4DeKRWviPjGTTkI5wsq+WtZgkHeu
	0IkrtrdAVXPm2reqG8kCmIlvhC3YZxc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-IgSNsNB6OOGg8Rtb1_lWuA-1; Tue, 13 May 2025 06:08:52 -0400
X-MC-Unique: IgSNsNB6OOGg8Rtb1_lWuA-1
X-Mimecast-MFC-AGG-ID: IgSNsNB6OOGg8Rtb1_lWuA_1747130931
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43efa869b19so37071225e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747130931; x=1747735731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3xt88UJJ72WfJejkpBXFIZcel7ydvHEDPDn9ATzxlg=;
        b=n/1aIux55Q/GM9GgPuioGjVZqWDWb+eLmSQKpiH+FR6sHxRuEIQ1PsM7z/i2V0xU4g
         S0taQpsZYEO/vwL3MOl1cp+D6f3zhfUkjRts4vLRXqfzx2qtlb9k/UAUl7UVc4QvAHfD
         Eufrjl1KeseqKaG38MEm7P3vp/cpZUoX4AxQvKdeUEYxp/aOaz6thNQ/+ru7STaQi/H/
         DmCWPgiRpu5AiWYOkqO6UA1vLpzfdUTiDgPifrBtATAgrPuEznJ2xAAm8+zUAtQ8wJy/
         4BQ0OnwnLQ7blcrtL9vxmtzrj44qNMUYUCZ1w6HWOd1u6fegJsMBa5YasanJyLHKmBkQ
         wTzA==
X-Forwarded-Encrypted: i=1; AJvYcCUvmXbbruADVA4B7TKbW8jlj9gkt7VP9726Azd2KoWngtlEOu+WInMEJj7meatwgI/cjk0Sqv/3bWWYif8gC54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xYOAlZJ1ZCk8UnjgYvhgEdS2ywSWIZu0RCboJs/JOYKyTfif
	/lrK3V8e4gxqyeM0oJlZoeyUZckJXvoHu2dmvQn/cg8kuI/TLPg9THdJkpfmYmqXsffnKBDbsfv
	mfjVMbdyrIVQi9MVGVYG239r0WAINzHW/NDYVq4D2XnsVqCIRZ+a3lPpgBBZrB1Jw3w==
X-Gm-Gg: ASbGncum2QiHf8DFEnpDx30wsv/rwPgjhAxIV26XP2HuuMRZVWcVrTql+oppfaGR0ic
	t/tQfMlasGUsGHNd5ohc1VZ0CAFUEKAr2UbXPkEibFF+R7bQEijqSOTsqLaipiug+lk8bC/jgZh
	2QxHZ6pRAYbZUTk5gBgZRZYfjr00PNqFvUBd8uzgs0wmoT80Z8AzOta7wnqTOp+x4R7PMUfETsc
	OJWsasX02fAUgbhwWnwrZTZtsI2/vCYjrx2NCcruIcOaaG4sNmsKrPkoUaZVW1ad7Oa667sTZCB
	skS0dQYLKKRTzJQ2rLo=
X-Received: by 2002:a05:600c:384e:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-442d6ddf558mr112141725e9.28.1747130930747;
        Tue, 13 May 2025 03:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc8OLFYrx8vh1+DoUzPOC3tRCoxaxeynKtchE2ufa3vecTplBhEYOjpUDwCPgC6toCi02ytA==
X-Received: by 2002:a05:600c:384e:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-442d6ddf558mr112141325e9.28.1747130930180;
        Tue, 13 May 2025 03:08:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3af15bsm205900395e9.30.2025.05.13.03.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:08:49 -0700 (PDT)
Message-ID: <534195a0-e7be-42ba-ac0f-177526b127d7@redhat.com>
Date: Tue, 13 May 2025 12:08:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] selftests/vsock: add initial vmtest.sh for
 vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250507-vsock-vmtest-v4-1-6e2a97262cd6@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250507-vsock-vmtest-v4-1-6e2a97262cd6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 3:23 AM, Bobby Eshleman wrote:
> This commit introduces a new vmtest.sh runner for vsock.
> 
> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
> H2G, and loopback. The testing tools from tools/testing/vsock/ are
> reused. Currently, only vsock_test is used.
> 
> VMCI and hyperv support is automatically built, though not used.
> 
> Only tested on x86.
> 
> To run:
> 
>   $ tools/testing/selftests/vsock/vmtest.sh
> 
> or
> 
>   $ make -C tools/testing/selftests TARGETS=vsock run_tests
> 
> Output (vmtest.sh):
> TAP version 13
> 1..3
> not ok 1 vm_server_host_client # exit=1
> ok 1 vm_client_host_server
> ok 2 vm_loopback
> SUMMARY: PASS=2 SKIP=0 FAIL=1
> 1..3
> 
> Future work can include vsock_diag_test.
> 
> The tap output style copies mm's run_vmtests.sh.
> 
> Because vsock requires a VM to test anything other than loopback, this
> patch adds vmtest.sh as a kselftest itself. This is different than other
> systems that have a "vmtest.sh", where it is used as a utility script to
> spin up a VM to run the selftests as a guest (but isn't hooked into
> kselftest).
> 
> I've began testing this in one of the NIPA environments Jakub as
> graciously provided. I would expect at least one more revision to have
> that setup ironed out and fully tested.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> ---
> Changes in v4:
> - do not use special tab delimiter for help string parsing (Stefano + Paolo)
> - fix paths for when installing kselftest and running out-of-tree (Paolo)
> - change vng to using running kernel instead of compiled kernel (Paolo)
> - use multi-line string for QEMU_OPTS (Stefano)
> - change timeout to 300s (Paolo)
> - skip if tools are not found and use kselftests status codes (Paolo)
> - remove build from vmtest.sh (Paolo)
> - change 2222 -> SSH_HOST_PORT (Stefano)
> - add tap-format output
> - add vmtest.log to gitignore
> - check for vsock_test binary and remind user to build it if missing
> - create a proper build in makefile
> - style fixes
> - add ssh, timeout, and pkill to dependency check, just in case
> - fix numerical comparison in conditionals
> - check qemu pidfile exists before proceeding (avoid wasting time waiting for ssh)
> - fix tracking of pass/fail bug
> - fix stderr redirection bug
> - Link to v3: https://lore.kernel.org/r/20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com
> 
> Changes in v3:
> - use common conditional syntax for checking variables
> - use return value instead of global rc
> - fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
> - use SIGTERM instead of SIGKILL on cleanup
> - use peer-cid=1 for loopback
> - change sleep delay times into globals
> - fix test_vm_loopback logging
> - add test selection in arguments
> - make QEMU an argument
> - check that vng binary is on path
> - use QEMU variable
> - change <tab><backslash> to <space><backslash>
> - fix hardcoded file paths
> - add comment in commit msg about script that vmtest.sh was based off of
> - Add tools/testing/selftest/vsock/Makefile for kselftest
> - Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com
> 
> Changes in v2:
> - add kernel oops and warnings checker
> - change testname variable to use FUNCNAME
> - fix spacing in test_vm_server_host_client
> - add -s skip build option to vmtest.sh
> - add test_vm_loopback
> - pass port to vm_wait_for_listener
> - fix indentation in vmtest.sh
> - add vmci and hyperv to config
> - changed whitespace from tabs to spaces in help string
> - Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
> ---
>  MAINTAINERS                              |   1 +
>  tools/testing/selftests/vsock/.gitignore |   2 +
>  tools/testing/selftests/vsock/Makefile   |  17 ++
>  tools/testing/selftests/vsock/config     | 114 +++++++++
>  tools/testing/selftests/vsock/settings   |   1 +
>  tools/testing/selftests/vsock/vmtest.sh  | 423 +++++++++++++++++++++++++++++++
>  6 files changed, 558 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 657a67f9031e..3fbdd7bbfce7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25751,6 +25751,7 @@ F:	include/uapi/linux/vm_sockets.h
>  F:	include/uapi/linux/vm_sockets_diag.h
>  F:	include/uapi/linux/vsockmon.h
>  F:	net/vmw_vsock/
> +F:	tools/testing/selftests/vsock/
>  F:	tools/testing/vsock/
>  
>  VMALLOC
> diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
> new file mode 100644
> index 000000000000..9c5bf379480f
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/.gitignore
> @@ -0,0 +1,2 @@
> +vmtest.log
> +vsock_test
> diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
> new file mode 100644
> index 000000000000..71fca0a2b8da
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/Makefile
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CURDIR := $(abspath .)
> +TOOLSDIR := $(abspath ../../..)
> +
> +$(OUTPUT)/vsock_test: $(TOOLSDIR)/testing/vsock/vsock_test
> +	install -m 755 $< $@
> +
> +$(TOOLSDIR)/testing/vsock/vsock_test:
> +	$(MAKE) -C $(TOOLSDIR)/testing/vsock vsock_test
> +
> +TEST_PROGS += vmtest.sh
> +EXTRA_CLEAN += vmtest.log
> +TEST_GEN_FILES := vsock_test
> +
> +include ../lib.mk
> +
> diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
> new file mode 100644
> index 000000000000..3bffaaf98fff
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/config
> @@ -0,0 +1,114 @@
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_BPF=y
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_BPF_JIT=y
> +CONFIG_HAVE_EBPF_JIT=y
> +CONFIG_BPF_EVENTS=y
> +CONFIG_FTRACE_SYSCALLS=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_HAVE_DYNAMIC_FTRACE=y
> +CONFIG_DYNAMIC_FTRACE=y
> +CONFIG_HAVE_KPROBES=y
> +CONFIG_KPROBES=y
> +CONFIG_KPROBE_EVENTS=y
> +CONFIG_ARCH_SUPPORTS_UPROBES=y
> +CONFIG_UPROBES=y
> +CONFIG_UPROBE_EVENTS=y
> +CONFIG_DEBUG_FS=y
> +CONFIG_FW_CFG_SYSFS=y
> +CONFIG_FW_CFG_SYSFS_CMDLINE=y
> +CONFIG_DRM=y
> +CONFIG_DRM_VIRTIO_GPU=y
> +CONFIG_DRM_VIRTIO_GPU_KMS=y
> +CONFIG_DRM_BOCHS=y
> +CONFIG_VIRTIO_IOMMU=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SEQUENCER=y
> +CONFIG_SND_PCI=y
> +CONFIG_SND_INTEL8X0=y
> +CONFIG_SND_HDA_CODEC_REALTEK=y
> +CONFIG_SECURITYFS=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_SQUASHFS=y
> +CONFIG_SQUASHFS_XZ=y
> +CONFIG_SQUASHFS_ZSTD=y
> +CONFIG_FUSE_FS=y
> +CONFIG_SERIO=y
> +CONFIG_PCI=y
> +CONFIG_INPUT=y
> +CONFIG_INPUT_KEYBOARD=y
> +CONFIG_KEYBOARD_ATKBD=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_X86_VERBOSE_BOOTUP=y
> +CONFIG_VGA_CONSOLE=y
> +CONFIG_FB=y
> +CONFIG_FB_VESA=y
> +CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_HCTOSYS=y
> +CONFIG_RTC_DRV_CMOS=y
> +CONFIG_HYPERVISOR_GUEST=y
> +CONFIG_PARAVIRT=y
> +CONFIG_KVM_GUEST=y
> +CONFIG_KVM=y
> +CONFIG_KVM_INTEL=y
> +CONFIG_KVM_AMD=y
> +CONFIG_VSOCKETS=y
> +CONFIG_VSOCKETS_DIAG=y
> +CONFIG_VSOCKETS_LOOPBACK=y
> +CONFIG_VMWARE_VMCI_VSOCKETS=y
> +CONFIG_VIRTIO_VSOCKETS=y
> +CONFIG_VIRTIO_VSOCKETS_COMMON=y
> +CONFIG_HYPERV_VSOCKETS=y
> +CONFIG_VMWARE_VMCI=y
> +CONFIG_VHOST_VSOCK=y
> +CONFIG_HYPERV=y
> +CONFIG_UEVENT_HELPER=n
> +CONFIG_VIRTIO=y
> +CONFIG_VIRTIO_PCI=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_VIRTIO_BALLOON=y
> +CONFIG_NET=y
> +CONFIG_NET_CORE=y
> +CONFIG_NETDEVICES=y
> +CONFIG_NETWORK_FILESYSTEMS=y
> +CONFIG_INET=y
> +CONFIG_NET_9P=y
> +CONFIG_NET_9P_VIRTIO=y
> +CONFIG_9P_FS=y
> +CONFIG_VIRTIO_NET=y
> +CONFIG_CMDLINE_OVERRIDE=n
> +CONFIG_BINFMT_SCRIPT=y
> +CONFIG_SHMEM=y
> +CONFIG_TMPFS=y
> +CONFIG_UNIX=y
> +CONFIG_MODULE_SIG_FORCE=n
> +CONFIG_DEVTMPFS=y
> +CONFIG_TTY=y
> +CONFIG_VT=y
> +CONFIG_UNIX98_PTYS=y
> +CONFIG_EARLY_PRINTK=y
> +CONFIG_INOTIFY_USER=y
> +CONFIG_BLOCK=y
> +CONFIG_SCSI_LOWLEVEL=y
> +CONFIG_SCSI=y
> +CONFIG_SCSI_VIRTIO=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_VIRTIO_CONSOLE=y
> +CONFIG_WATCHDOG=y
> +CONFIG_WATCHDOG_CORE=y
> +CONFIG_I6300ESB_WDT=y
> +CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> +CONFIG_OVERLAY_FS=y
> +CONFIG_DAX=y
> +CONFIG_DAX_DRIVER=y
> +CONFIG_FS_DAX=y
> +CONFIG_MEMORY_HOTPLUG=y
> +CONFIG_MEMORY_HOTREMOVE=y
> +CONFIG_ZONE_DEVICE=y
> +CONFIG_FUSE_FS=y
> +CONFIG_VIRTIO_FS=y
> +CONFIG_VSOCKETS=y
> +CONFIG_VIRTIO_VSOCKETS=y
> diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
> new file mode 100644
> index 000000000000..694d70710ff0
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/settings
> @@ -0,0 +1 @@
> +timeout=300
> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> new file mode 100755
> index 000000000000..d7e727306175
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -0,0 +1,423 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
> +#
> +# Dependencies:
> +#		* virtme-ng
> +#		* busybox-static (used by virtme-ng)
> +#		* qemu	(used by virtme-ng)
> +
> +TAP_PREFIX="# "
> +VERBOSE=0
> +KSFT_PASS=0
> +KSFT_FAIL=1
> +KSFT_SKIP=4

Possibly you could source kselftest/ktap_helpers.sh for the above
'constant'. Otherwise it would be better to make them readonly.

> +SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> +VSOCK_TEST=${SCRIPT_DIR}/vsock_test
> +
> +TEST_GUEST_PORT=51000
> +TEST_HOST_PORT=50000
> +TEST_HOST_PORT_LISTENER=50001
> +SSH_GUEST_PORT=22
> +SSH_HOST_PORT=2222
> +VSOCK_CID=1234
> +WAIT_PERIOD=3
> +WAIT_PERIOD_MAX=20
> +WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
> +
> +QEMU_PIDFILE=/tmp/qemu.pid

You likely want to use mktemp for the above file name.

> +# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> +# control port forwarded for vsock_test.  Because virtme-ng doesn't support
> +# adding an additional port to forward to the device created from "--ssh" and
> +# virtme-init mistakenly sets identical IPs to the ssh device and additional
> +# devices, we instead opt out of using --ssh, add the device manually, and also
> +# add the kernel cmdline options that virtme-init uses to setup the interface.
> +QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> +QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
> +QEMU_OPTS="\
> +	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
> +	 -device virtio-net-pci,netdev=n0 \
> +	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
> +	 --pidfile ${QEMU_PIDFILE} \
> +"
> +KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
> +
> +LOG=${SCRIPT_DIR}/vmtest.log

Same here.

> +TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
> +TEST_DESCS=(
> +	"Run vsock_test in server mode on the VM and in client mode on the host."
> +	"Run vsock_test in client mode on the VM and in server mode on the host."
> +	"Run vsock_test using the loopback transport in the VM."
> +)
> +
> +usage() {
> +	local name
> +	local desc
> +	local i

Minor nit, plewase leave an empty line between variables declaration and
the actual code.

[...]
> +check_deps() {
> +	for dep in vng ${QEMU} busybox timeout pkill ssh; do

You don't need to check for 'timeout', as that is part of the coreutils
and supposed to be available on all the running hosts.

> +		if [[ ! -x "$(command -v ${dep})" ]]; then
> +			echo -e "skip:    dependency ${dep} not found!\n"
> +			exit ${KSFT_SKIP}
> +		fi
> +	done
> +
> +	if [[ ! -x $(command -v ${VSOCK_TEST}) ]]; then
> +		printf "skip:    ${VSOCK_TEST} not found!"
> +		printf " Please build the kselftest vsock target.\n"
> +		exit ${KSFT_SKIP}
> +	fi
> +}
> +
> +vm_setup() {

Possibly 'vm_start()' ?

> +	local VNG_OPTS=""
> +	local logfile=/dev/null
> +
> +	if [[ "${VERBOSE}" = 1 ]]; then
> +		VNG_OPTS="--verbose"
> +		logfile=/dev/stdout
> +	fi
> +	vng \
> +		$VNG_OPTS \
> +		--run \
> +		--qemu-opts="${QEMU_OPTS}" \
> +		--qemu="${QEMU}" \
> +		--user root \
> +		--append "${KERNEL_CMDLINE}" \
> +		--rw  &> ${logfile} &
> +
> +	timeout ${WAIT_TOTAL} \
> +		bash -c 'while [[ ! -e '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'
> +	if [[ ! $? -eq 0 ]]; then
> +		die "failed to boot VM"
> +	fi
> +}
> +
> +vm_wait_for_ssh() {
> +	i=0
> +	while [[ true ]]; do
> +		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then

WAIT_PERIOD_MAX == 20 is possibly a little low for some systems (i.e.
the 'host' itself could be a VM)

> +			die "Timed out waiting for guest ssh"
> +		fi
> +		vm_ssh -- true
> +		if [[ $? -eq 0 ]]; then
> +			break
> +		fi
> +		i=$(( i + 1 ))
> +		sleep ${WAIT_PERIOD}
> +	done
> +}
> +
> +wait_for_listener() {
> +	local port=$1
> +	local interval=$2
> +	local max_intervals=$3
> +	local i=0
> +	while ! ss -ltn | grep -q ":${port}"; do
> +		if [[ ${i} -gt ${max_intervals} ]]; then
> +			die "Timed out waiting for listener on port ${port}"
> +		fi
> +		i=$(( i + 1 ))
> +		sleep ${interval}
> +	done
> +}

FTR there is a very similar helper in selftests/net/net_helper.sh

> +
> +vm_wait_for_listener() {
> +	local port=$1
> +	vm_ssh <<EOF
> +$(declare -f wait_for_listener)
> +wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
> +EOF
> +}
> +
> +host_wait_for_listener() {
> +	wait_for_listener ${TEST_HOST_PORT_LISTENER} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
> +}
> +
> +__log_stdin() {
> +	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
> +}
> +
> +__log_args() {
> +	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
> +}
> +
> +log() {
> +	local prefix="$1"
> +	shift
> +
> +	local redirect=
> +	if [[ ${VERBOSE} -eq 0 ]]; then
> +		redirect=/dev/null
> +	else
> +		redirect=/dev/stdout
> +	fi
> +
> +	if [[ "$#" -eq 0 ]]; then
> +		__log_stdin | tee -a ${LOG} > ${redirect}
> +	else
> +		__log_args | tee -a ${LOG} > ${redirect}
> +	fi
> +}
> +
> +log_setup() {
> +	log "setup" "$@"
> +}
> +
> +log_host() {
> +	testname=$1
> +	shift
> +	log "test:${testname}:host" "$@"
> +}
> +
> +log_guest() {
> +	testname=$1
> +	shift
> +	log "test:${testname}:guest" "$@"
> +}
> +
> +tap_prefix() {
> +	sed -e "s/^/${TAP_PREFIX}/"
> +}
> +
> +tap_output() {
> +	if [[ ! -z "$TAP_PREFIX" ]]; then
> +		read str
> +		echo $str
> +	fi
> +}
> +
> +test_vm_server_host_client() {
> +	local testname="${FUNCNAME[0]#test_}"
> +
> +	vm_ssh -- "${VSOCK_TEST}" \
> +		--mode=server \
> +		--control-port="${TEST_GUEST_PORT}" \
> +		--peer-cid=2 \
> +		2>&1 | log_guest "${testname}" &
> +
> +	vm_wait_for_listener ${TEST_GUEST_PORT}
> +
> +	${VSOCK_TEST} \
> +		--mode=client \
> +		--control-host=127.0.0.1 \
> +		--peer-cid="${VSOCK_CID}" \
> +		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
> +
> +	return $?
> +}
> +
> +test_vm_client_host_server() {
> +	local testname="${FUNCNAME[0]#test_}"
> +
> +	${VSOCK_TEST} \
> +		--mode "server" \
> +		--control-port "${TEST_HOST_PORT_LISTENER}" \
> +		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
> +
> +	host_wait_for_listener
> +
> +	vm_ssh -- "${VSOCK_TEST}" \
> +		--mode=client \
> +		--control-host=10.0.2.2 \
> +		--peer-cid=2 \
> +		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
> +
> +	return $?
> +}
> +
> +test_vm_loopback() {
> +	local testname="${FUNCNAME[0]#test_}"
> +	local port=60000 # non-forwarded local port
> +
> +	vm_ssh -- ${VSOCK_TEST} \
> +		--mode=server \
> +		--control-port="${port}" \
> +		--peer-cid=1 2>&1 | log_guest "${testname}" &
> +
> +	vm_wait_for_listener ${port}
> +
> +	vm_ssh -- ${VSOCK_TEST} \
> +		--mode=client \
> +		--control-host="127.0.0.1" \
> +		--control-port="${port}" \
> +		--peer-cid=1 2>&1 | log_guest "${testname}"
> +
> +	return $?
> +}
> +
> +run_test() {
> +	unset IFS

This is usually preceed by
	OLD_IFS=$IFS

and restored at the end of the relevant scope, to avoid side effects
elsewhere.

> +	local host_oops_cnt_before
> +	local host_warn_cnt_before
> +	local vm_oops_cnt_before
> +	local vm_warn_cnt_before
> +	local host_oops_cnt_after
> +	local host_warn_cnt_after
> +	local vm_oops_cnt_after
> +	local vm_warn_cnt_after
> +	local name
> +	local rc
> +
> +	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
> +	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
> +	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
> +	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
> +
> +	name=$(echo "${1}" | awk '{ print $1 }')
> +	eval test_"${name}"
> +	rc=$?
> +
> +	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
> +	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
> +		echo "${name}: kernel oops detected on host" | log_host ${name}
> +		rc=$KSFT_FAIL
> +	fi
> +
> +	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
> +	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
> +		echo "${name}: kernel warning detected on host" | log_host ${name}
> +		rc=$KSFT_FAIL
> +	fi
> +
> +	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
> +	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
> +		echo "${name}: kernel oops detected on vm" | log_host ${name}
> +		rc=$KSFT_FAIL
> +	fi
> +
> +	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
> +	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> +		echo "${name}: kernel warning detected on vm" | log_host ${name}
> +		rc=$KSFT_FAIL
> +	fi
> +
> +	return ${rc}
> +}
> +
> +while getopts :hvsq: o
> +do
> +	case $o in
> +	v) VERBOSE=1;;
> +	q) QEMU=$OPTARG;;
> +	h|*) usage;;
> +	esac
> +done
> +shift $((OPTIND-1))
> +
> +trap cleanup EXIT
> +
> +if [[ ${#} -eq 0 ]]; then
> +	ARGS=(${TEST_NAMES[@]})
> +else
> +	ARGS=($@)
> +fi
> +
> +check_args "${ARGS[@]}"
> +check_deps
> +
> +QEMU=$(command -v ${QEMU:-qemu-system-$(uname -m)})

Should the QEMU variable be initialized before check_deps() - where it's
used?

To me tt looks like this is almost ready, thank you for the great effort!

/P


