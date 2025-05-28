Return-Path: <linux-kselftest+bounces-33923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C52AC64A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607E6189AD8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3B26A0B3;
	Wed, 28 May 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXdvVccU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4C1F0992
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421758; cv=none; b=ItBrBM9fo3h0fL1vuPNkQlkNytp0SzlVB0OVxe61lETwHnz5Gkjj40VkdpZjCioIhG0YZZdJfui8blhIJLv58YDfMDSDzpqkJvFckHhp7Xdb3PgK1LWni9wYSSle4iRYVU4fm9ohkZE72w3bwl0hoCn7Ph+LpFU/atKEwHFC1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421758; c=relaxed/simple;
	bh=MQPDWV7r0RHu2w4W96VCQTnKfbdIE83e4A8rM/0jNHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPL5b0THiDu1xUpyEmnKfCkORBoBPNjEXfsqcw+reMkgECtC5WF3dg1TU9QyFLGLV9o3kEwlqy+FGyP1cR4uJrtwAZfFXiUQZUdMsfsx8RAwS8abkGV5KY3/MW2pk90wd1qYTfhMcVFyp1LlC5UNXfpncDraSi78rHMfIUgzkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXdvVccU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748421755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHVZFZS1fa9rWPWraBTZ2PRVzHOX2XKsUZnAQXgZ7Iw=;
	b=gXdvVccUWljGqKar7ewO3dubdFSXfIgyEQf0KGmd8IB/eTzcnhpV5fTUPQcIrklRGPauXu
	FK2bYkfF12escDiyUgTU+IOWuxQbMdinyqRsi+5M5pYG+iej5yQaZylKrJsWCAAc6oGq/C
	HeW8C0BpYSmdmv1K/+6od7t38Ng34hg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-_8e8mGBLMKO377-uFFQxBg-1; Wed, 28 May 2025 04:42:33 -0400
X-MC-Unique: _8e8mGBLMKO377-uFFQxBg-1
X-Mimecast-MFC-AGG-ID: _8e8mGBLMKO377-uFFQxBg_1748421752
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442dc6f0138so21564175e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 01:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748421752; x=1749026552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHVZFZS1fa9rWPWraBTZ2PRVzHOX2XKsUZnAQXgZ7Iw=;
        b=sG+TsRkPftrt3pqY/QfOiRqGhm94Pjxwi7O0a/gjGKvRmMJDQu0yrbZv0hmRRkgmBW
         oHs+mgfaWgHSA440/Nz/sDl8KdjTwVK2rnAG9+tnaA7yz6gSx9XtjaE4aFO4KpCqbA/T
         iwPFZUgt9/4VAy0ydxWRXqUWskuTIpO5y+f3JK5K6H52fD0x20kJOil6jSc5t6auSfrV
         SQDoklIrhRqFFbPXnJkgclBaJkhhyUX8zeKyo8oYmLT5CZmLCoc+puypwwXj8Ht2v69/
         5ucgX8UkxoiU/dAoqk5d+LjnvL5Uj2E9gbEKnmuo62Pyw1nsdpPdOq9uSE2e72LLYDYJ
         Ewmw==
X-Forwarded-Encrypted: i=1; AJvYcCWgLgUIGp0ci+Yk6479zJlrva2O8xk5RCi7enQWTIGBh0Pn0um8sT8WqoWkPIM5BCfsKKvL5p6tWZCaNpGqonM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2cSs24d/Ipy2BICDRq/fV98hWDfbVFwwem44lgeGf51uIpEb
	Su6UQMZ/39sP/lT1Sg77i1+WeW9q3rVSr7bo8n0pjzQfmAN3L6D98aGAjrJ4hHN6Pt9D7dx2C7I
	vM9F2+0/cHPEi5PAQk+y1p13tGVAB1G/GuYTekRCjTjTun+d5EPQz9ApzTj2BlD1dVzleDg==
X-Gm-Gg: ASbGnctTa6gB2qViPjezdV/ENNdceIOL0uGHusVfCWDhi1X0qSSE8hybD5zyAUmTEmf
	WSRYiikPbPdjgFnjO2eHhLWXPjrxD73ms/NfZ6I4nm1F/npcRim9n4d6RBFb39p/cOVsEdLZS8g
	yXP1I7PUZntVme/iYgZM0CJ9AIbCkq9J7Jz0dfYEz3XcIs7C+h1bJBDwaY6FEF0qrd96mMoVO5V
	YLHuyCA4H0HajcCVSPwvTmLABVEbChg87xmmJA/iA05HMTOENAC3AetdBtwl7hu47CLVhj21z5G
	ol7mqjkU9AtA7Vyyw5JYXw1REiYUzor05c12hSJm0fA0SkP5Z7gc/IYePYcS
X-Received: by 2002:a05:600c:470b:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-44c91dceb03mr175213745e9.16.1748421752049;
        Wed, 28 May 2025 01:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNuCW5HXGwi/4xGSaC2njkJeERkK949nit0Lq8CufwPmLuRJIhGmKIp/EVE+I3+UGcMKBYrw==
X-Received: by 2002:a05:600c:470b:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-44c91dceb03mr175213255e9.16.1748421751289;
        Wed, 28 May 2025 01:42:31 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44fcbd61630sm39727565e9.0.2025.05.28.01.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:42:30 -0700 (PDT)
Date: Wed, 28 May 2025 10:42:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <mti4hxjrs6rzleoijjhby5hdghgcvsegwfytizxngg7bjxs3ds@prhrn3b3o6os>
References: <20250527-vsock-vmtest-v9-1-24eaeec6fa55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250527-vsock-vmtest-v9-1-24eaeec6fa55@gmail.com>

On Tue, May 27, 2025 at 05:36:54PM -0700, Bobby Eshleman wrote:
>This commit introduces a new vmtest.sh runner for vsock.
>
>It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>H2G, and loopback. The testing tools from tools/testing/vsock/ are
>reused. Currently, only vsock_test is used.
>
>VMCI and hyperv support is included in the config file to be built with
>the -b option, though not used in the tests.
>
>Only tested on x86.
>
>To run:
>
>  $ make -C tools/testing/selftests TARGETS=vsock
>  $ tools/testing/selftests/vsock/vmtest.sh
>
>or
>
>  $ make -C tools/testing/selftests TARGETS=vsock run_tests
>
>Example runs (after make -C tools/testing/selftests TARGETS=vsock):
>
>$ ./tools/testing/selftests/vsock/vmtest.sh
>1..3
>ok 0 vm_server_host_client
>ok 1 vm_client_host_server
>ok 2 vm_loopback
>SUMMARY: PASS=3 SKIP=0 FAIL=0
>Log: /tmp/vsock_vmtest_m7DI.log
>
>$ ./tools/testing/selftests/vsock/vmtest.sh vm_loopback
>1..1
>ok 0 vm_loopback
>SUMMARY: PASS=1 SKIP=0 FAIL=0
>Log: /tmp/vsock_vmtest_a1IO.log
>
>$ mkdir -p ~/scratch
>$ make -C tools/testing/selftests install TARGETS=vsock INSTALL_PATH=~/scratch
> [... omitted ...]
>$ cd ~/scratch
>$ ./run_kselftest.sh
> TAP version 13
> 1..1
> # timeout set to 300
> # selftests: vsock: vmtest.sh
> # 1..3
> # ok 0 vm_server_host_client
> # ok 1 vm_client_host_server
> # ok 2 vm_loopback
> # SUMMARY: PASS=3 SKIP=0 FAIL=0
> # Log: /tmp/vsock_vmtest_svEl.log
> ok 1 selftests: vsock: vmtest.sh
>
>Future work can include vsock_diag_test.
>
>Because vsock requires a VM to test anything other than loopback, this
>patch adds vmtest.sh as a kselftest itself. This is different than other
>systems that have a "vmtest.sh", where it is used as a utility script to
>spin up a VM to run the selftests as a guest (but isn't hooked into
>kselftest).
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>---
>Changes in v9:
>- make kselftest build target depend on tools/testing/vsock sources (Stefano)
>- add check_vng() for vng version checking (Stefano)
>- add virtme_ssh_channel=tcp to kernel cmdline (Stefano)
>- Link to v8: https://lore.kernel.org/r/20250522-vsock-vmtest-v8-1-367619bef134@gmail.com

Cool, this 

>
>Changes in v8:
>- remove NIPA comment from commit msg
>- remove tap_* functions and TAP_PREFIX
>- add -b for building kernel
>- Link to v7: https://lore.kernel.org/r/20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com
>
>Changes in v7:
>- fix exit code bug when ran is kselftest: use cnt_total instead of KSFT_NUM_TESTS
>- updated commit message with updated output
>- updated commit message with commands for installing/running as
>  kselftest
>- Link to v6: https://lore.kernel.org/r/20250515-vsock-vmtest-v6-1-9af1cc023900@gmail.com
>
>Changes in v6:
>- add make cmd in commit message in vmtest.sh example (Stefano)
>- check nonzero size of QEMU_PIDFILE using -s conditional (Stefano)
>- display log file path after tests so it is easier to find amongst 
>other random names
>- cleanup qemu pidfile if qemu is unable to remove it
>- make oops/warning failures more obvious with 'FAIL' prefix in log
>  (simply saying 'detected' wasn't clear enough to identify failing
>  condition)
>- Link to v5: https://lore.kernel.org/r/20250513-vsock-vmtest-v5-1-4e75c4a45ceb@gmail.com
>
>Changes in v5:
>- make log file a tmpfile (Paolo)
>- make sure both default and user defined QEMU gets handled by the dependency check (Paolo)
>- increased VM boot up timeout from 1m to 3m for slow hosts (Paolo)
>- rename vm_setup -> vm_start (Paolo)
>- derive wait_for_listener from selftests/net/net_helper.sh to removes ss usage
>- Remove unused 'unset IFS' line (Paolo)
>- leave space after variable declarations (Paolo)
>- make QEMU_PIDFILE a tmp file (Paolo)
>- make everything readonly that is only read (Paolo)
>- source ktap_helpers.sh for KSFT_PASS and friends (Paolo)
>- don't check for timeout util (Paolo)
>- add missing usage string for -q qemu arg
>- add tap prefix to SUMMARY line since it isn't part of TAP protocol
>- exit with the correct status code based on failure/pass counts
>- Link to v4: https://lore.kernel.org/r/20250507-vsock-vmtest-v4-1-6e2a97262cd6@gmail.com
>
>Changes in v4:
>- do not use special tab delimiter for help string parsing (Stefano + Paolo)
>- fix paths for when installing kselftest and running out-of-tree (Paolo)
>- change vng to using running kernel instead of compiled kernel (Paolo)
>- use multi-line string for QEMU_OPTS (Stefano)
>- change timeout to 300s (Paolo)
>- skip if tools are not found and use kselftests status codes (Paolo)
>- remove build from vmtest.sh (Paolo)
>- change 2222 -> SSH_HOST_PORT (Stefano)
>- add tap-format output
>- add vmtest.log to gitignore
>- check for vsock_test binary and remind user to build it if missing
>- create a proper build in makefile
>- style fixes
>- add ssh, timeout, and pkill to dependency check, just in case
>- fix numerical comparison in conditionals
>- check qemu pidfile exists before proceeding (avoid wasting time waiting for ssh)
>- fix tracking of pass/fail bug
>- fix stderr redirection bug
>- Link to v3: https://lore.kernel.org/r/20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com
>
>Changes in v3:
>- use common conditional syntax for checking variables
>- use return value instead of global rc
>- fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
>- use SIGTERM instead of SIGKILL on cleanup
>- use peer-cid=1 for loopback
>- change sleep delay times into globals
>- fix test_vm_loopback logging
>- add test selection in arguments
>- make QEMU an argument
>- check that vng binary is on path
>- use QEMU variable
>- change <tab><backslash> to <space><backslash>
>- fix hardcoded file paths
>- add comment in commit msg about script that vmtest.sh was based off of
>- Add tools/testing/selftest/vsock/Makefile for kselftest
>- Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com
>
>Changes in v2:
>- add kernel oops and warnings checker
>- change testname variable to use FUNCNAME
>- fix spacing in test_vm_server_host_client
>- add -s skip build option to vmtest.sh
>- add test_vm_loopback
>- pass port to vm_wait_for_listener
>- fix indentation in vmtest.sh
>- add vmci and hyperv to config
>- changed whitespace from tabs to spaces in help string
>- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
>---
> MAINTAINERS                              |   1 +
> tools/testing/selftests/vsock/.gitignore |   2 +
> tools/testing/selftests/vsock/Makefile   |  17 ++
> tools/testing/selftests/vsock/config     | 114 ++++++++
> tools/testing/selftests/vsock/settings   |   1 +
> tools/testing/selftests/vsock/vmtest.sh  | 487 +++++++++++++++++++++++++++++++
> 6 files changed, 622 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 657a67f9031ef7798c19ac63e6383d4cb18a9e1f..3fbdd7bbfce7196a3cc7db70203317c6bd0e51fd 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -25751,6 +25751,7 @@ F:	include/uapi/linux/vm_sockets.h
> F:	include/uapi/linux/vm_sockets_diag.h
> F:	include/uapi/linux/vsockmon.h
> F:	net/vmw_vsock/
>+F:	tools/testing/selftests/vsock/
> F:	tools/testing/vsock/
>
> VMALLOC
>diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
>new file mode 100644
>index 0000000000000000000000000000000000000000..9c5bf379480f829a14713d5f5dc7d525bc272e84
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/.gitignore
>@@ -0,0 +1,2 @@
>+vmtest.log
>+vsock_test
>diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
>new file mode 100644
>index 0000000000000000000000000000000000000000..c407c0afd9388ee692d59a95f304182f067596e9
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/Makefile
>@@ -0,0 +1,17 @@
>+# SPDX-License-Identifier: GPL-2.0
>+
>+CURDIR := $(abspath .)
>+TOOLSDIR := $(abspath ../../..)
>+VSOCK_TEST_DIR := $(TOOLSDIR)/testing/vsock
>+VSOCK_TEST_SRCS := $(wildcard $(VSOCK_TEST_DIR)/*.c $(VSOCK_TEST_DIR)/*.h)
>+
>+$(OUTPUT)/vsock_test: $(VSOCK_TEST_DIR)/vsock_test
>+	install -m 755 $< $@
>+
>+$(VSOCK_TEST_DIR)/vsock_test: $(VSOCK_TEST_SRCS)
>+	$(MAKE) -C $(VSOCK_TEST_DIR) vsock_test
>+TEST_PROGS += vmtest.sh
>+TEST_GEN_FILES := vsock_test
>+
>+include ../lib.mk
>+
>diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
>new file mode 100644
>index 
>0000000000000000000000000000000000000000..3bffaaf98fff92dc0e3bc1286afa3d8d5d52f4c7
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/config
>@@ -0,0 +1,114 @@
>+CONFIG_BLK_DEV_INITRD=y
>+CONFIG_BPF=y
>+CONFIG_BPF_SYSCALL=y
>+CONFIG_BPF_JIT=y
>+CONFIG_HAVE_EBPF_JIT=y
>+CONFIG_BPF_EVENTS=y
>+CONFIG_FTRACE_SYSCALLS=y
>+CONFIG_FUNCTION_TRACER=y
>+CONFIG_HAVE_DYNAMIC_FTRACE=y
>+CONFIG_DYNAMIC_FTRACE=y
>+CONFIG_HAVE_KPROBES=y
>+CONFIG_KPROBES=y
>+CONFIG_KPROBE_EVENTS=y
>+CONFIG_ARCH_SUPPORTS_UPROBES=y
>+CONFIG_UPROBES=y
>+CONFIG_UPROBE_EVENTS=y
>+CONFIG_DEBUG_FS=y
>+CONFIG_FW_CFG_SYSFS=y
>+CONFIG_FW_CFG_SYSFS_CMDLINE=y
>+CONFIG_DRM=y
>+CONFIG_DRM_VIRTIO_GPU=y
>+CONFIG_DRM_VIRTIO_GPU_KMS=y
>+CONFIG_DRM_BOCHS=y
>+CONFIG_VIRTIO_IOMMU=y
>+CONFIG_SOUND=y
>+CONFIG_SND=y
>+CONFIG_SND_SEQUENCER=y
>+CONFIG_SND_PCI=y
>+CONFIG_SND_INTEL8X0=y
>+CONFIG_SND_HDA_CODEC_REALTEK=y
>+CONFIG_SECURITYFS=y
>+CONFIG_CGROUP_BPF=y
>+CONFIG_SQUASHFS=y
>+CONFIG_SQUASHFS_XZ=y
>+CONFIG_SQUASHFS_ZSTD=y
>+CONFIG_FUSE_FS=y
>+CONFIG_SERIO=y
>+CONFIG_PCI=y
>+CONFIG_INPUT=y
>+CONFIG_INPUT_KEYBOARD=y
>+CONFIG_KEYBOARD_ATKBD=y
>+CONFIG_SERIAL_8250=y
>+CONFIG_SERIAL_8250_CONSOLE=y
>+CONFIG_X86_VERBOSE_BOOTUP=y
>+CONFIG_VGA_CONSOLE=y
>+CONFIG_FB=y
>+CONFIG_FB_VESA=y
>+CONFIG_FRAMEBUFFER_CONSOLE=y
>+CONFIG_RTC_CLASS=y
>+CONFIG_RTC_HCTOSYS=y
>+CONFIG_RTC_DRV_CMOS=y
>+CONFIG_HYPERVISOR_GUEST=y
>+CONFIG_PARAVIRT=y
>+CONFIG_KVM_GUEST=y
>+CONFIG_KVM=y
>+CONFIG_KVM_INTEL=y
>+CONFIG_KVM_AMD=y
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_DIAG=y
>+CONFIG_VSOCKETS_LOOPBACK=y
>+CONFIG_VMWARE_VMCI_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
>+CONFIG_HYPERV_VSOCKETS=y
>+CONFIG_VMWARE_VMCI=y
>+CONFIG_VHOST_VSOCK=y
>+CONFIG_HYPERV=y
>+CONFIG_UEVENT_HELPER=n
>+CONFIG_VIRTIO=y
>+CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_MMIO=y
>+CONFIG_VIRTIO_BALLOON=y
>+CONFIG_NET=y
>+CONFIG_NET_CORE=y
>+CONFIG_NETDEVICES=y
>+CONFIG_NETWORK_FILESYSTEMS=y
>+CONFIG_INET=y
>+CONFIG_NET_9P=y
>+CONFIG_NET_9P_VIRTIO=y
>+CONFIG_9P_FS=y
>+CONFIG_VIRTIO_NET=y
>+CONFIG_CMDLINE_OVERRIDE=n
>+CONFIG_BINFMT_SCRIPT=y
>+CONFIG_SHMEM=y
>+CONFIG_TMPFS=y
>+CONFIG_UNIX=y
>+CONFIG_MODULE_SIG_FORCE=n
>+CONFIG_DEVTMPFS=y
>+CONFIG_TTY=y
>+CONFIG_VT=y
>+CONFIG_UNIX98_PTYS=y
>+CONFIG_EARLY_PRINTK=y
>+CONFIG_INOTIFY_USER=y
>+CONFIG_BLOCK=y
>+CONFIG_SCSI_LOWLEVEL=y
>+CONFIG_SCSI=y
>+CONFIG_SCSI_VIRTIO=y
>+CONFIG_BLK_DEV_SD=y
>+CONFIG_VIRTIO_CONSOLE=y
>+CONFIG_WATCHDOG=y
>+CONFIG_WATCHDOG_CORE=y
>+CONFIG_I6300ESB_WDT=y
>+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>+CONFIG_OVERLAY_FS=y
>+CONFIG_DAX=y
>+CONFIG_DAX_DRIVER=y
>+CONFIG_FS_DAX=y
>+CONFIG_MEMORY_HOTPLUG=y
>+CONFIG_MEMORY_HOTREMOVE=y
>+CONFIG_ZONE_DEVICE=y
>+CONFIG_FUSE_FS=y
>+CONFIG_VIRTIO_FS=y
>+CONFIG_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS=y

There are some CONFIG_ duplicated (e.g. CONFIG_VSOCKETS, 
CONFIG_VIRTIO_VSOCKETS, CONFIG_FUSE_FS), can we remove them?

The rest LGTM and now it's working on my side!
I think you can send the next version after the merge window.

Thanks,
Stefano

>diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
>new file mode 100644
>index 0000000000000000000000000000000000000000..694d70710ff08ac9fc91e9ecb5dbdadcf051f019
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/settings
>@@ -0,0 +1 @@
>+timeout=300
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>new file mode 100755
>index 0000000000000000000000000000000000000000..edacebfc163251eee9cd495eb5e704dc7adc958e
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -0,0 +1,487 @@
>+#!/bin/bash
>+# SPDX-License-Identifier: GPL-2.0
>+#
>+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
>+#
>+# Dependencies:
>+#		* virtme-ng
>+#		* busybox-static (used by virtme-ng)
>+#		* qemu	(used by virtme-ng)
>+
>+readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
>+readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
>+
>+source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
>+
>+readonly VSOCK_TEST="${SCRIPT_DIR}"/vsock_test
>+readonly TEST_GUEST_PORT=51000
>+readonly TEST_HOST_PORT=50000
>+readonly TEST_HOST_PORT_LISTENER=50001
>+readonly SSH_GUEST_PORT=22
>+readonly SSH_HOST_PORT=2222
>+readonly VSOCK_CID=1234
>+readonly WAIT_PERIOD=3
>+readonly WAIT_PERIOD_MAX=60
>+readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>+readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+
>+# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
>+# control port forwarded for vsock_test.  Because virtme-ng doesn't support
>+# adding an additional port to forward to the device created from "--ssh" and
>+# virtme-init mistakenly sets identical IPs to the ssh device and additional
>+# devices, we instead opt out of using --ssh, add the device manually, and also
>+# add the kernel cmdline options that virtme-init uses to setup the interface.
>+readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
>+readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
>+readonly QEMU_OPTS="\
>+	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>+	 -device virtio-net-pci,netdev=n0 \
>+	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>+	 --pidfile ${QEMU_PIDFILE} \
>+"
>+readonly KERNEL_CMDLINE="\
>+	virtme.dhcp net.ifnames=0 biosdevname=0 \
>+	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
>+"
>+readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>+readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly TEST_DESCS=(
>+	"Run vsock_test in server mode on the VM and in client mode on the host."
>+	"Run vsock_test in client mode on the VM and in server mode on the host."
>+	"Run vsock_test using the loopback transport in the VM."
>+)
>+
>+VERBOSE=0
>+
>+usage() {
>+	local name
>+	local desc
>+	local i
>+
>+	echo
>+	echo "$0 [OPTIONS] [TEST]..."
>+	echo "If no TEST argument is given, all tests will be run."
>+	echo
>+	echo "Options"
>+	echo "  -b: build the kernel from the current source tree and use it for guest VMs"
>+	echo "  -q: set the path to or name of qemu binary"
>+	echo "  -v: verbose output"
>+	echo
>+	echo "Available tests"
>+
>+	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
>+		name=${TEST_NAMES[${i}]}
>+		desc=${TEST_DESCS[${i}]}
>+		printf "\t%-35s%-35s\n" "${name}" "${desc}"
>+	done
>+	echo
>+
>+	exit 1
>+}
>+
>+die() {
>+	echo "$*" >&2
>+	exit "${KSFT_FAIL}"
>+}
>+
>+vm_ssh() {
>+	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
>+	return $?
>+}
>+
>+cleanup() {
>+	if [[ -s "${QEMU_PIDFILE}" ]]; then
>+		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
>+	fi
>+
>+	# If failure occurred during or before qemu start up, then we need
>+	# to clean this up ourselves.
>+	if [[ -e "${QEMU_PIDFILE}" ]]; then
>+		rm "${QEMU_PIDFILE}"
>+	fi
>+}
>+
>+check_args() {
>+	local found
>+
>+	for arg in "$@"; do
>+		found=0
>+		for name in "${TEST_NAMES[@]}"; do
>+			if [[ "${name}" = "${arg}" ]]; then
>+				found=1
>+				break
>+			fi
>+		done
>+
>+		if [[ "${found}" -eq 0 ]]; then
>+			echo "${arg} is not an available test" >&2
>+			usage
>+		fi
>+	done
>+
>+	for arg in "$@"; do
>+		if ! command -v > /dev/null "test_${arg}"; then
>+			echo "Test ${arg} not found" >&2
>+			usage
>+		fi
>+	done
>+}
>+
>+check_deps() {
>+	for dep in vng ${QEMU} busybox pkill ssh; do
>+		if [[ ! -x $(command -v "${dep}") ]]; then
>+			echo -e "skip:    dependency ${dep} not found!\n"
>+			exit "${KSFT_SKIP}"
>+		fi
>+	done
>+
>+	if [[ ! -x $(command -v "${VSOCK_TEST}") ]]; then
>+		printf "skip:    %s not found!" "${VSOCK_TEST}"
>+		printf " Please build the kselftest vsock target.\n"
>+		exit "${KSFT_SKIP}"
>+	fi
>+}
>+
>+check_vng() {
>+	local tested_versions
>+	local version
>+	local ok
>+
>+	tested_versions=("1.33" "1.36")
>+	version="$(vng --version)"
>+
>+	ok=0
>+	for tv in "${tested_versions[@]}"; do
>+		if [[ "${version}" == *"${tv}"* ]]; then
>+			ok=1
>+			break
>+		fi
>+	done
>+
>+	if [[ ! "${ok}" -eq 1 ]]; then
>+		printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
>+		printf "not function properly.\n\tThe following versions have been tested: " >&2
>+		echo "${tested_versions[@]}" >&2
>+	fi
>+}
>+
>+handle_build() {
>+	if [[ ! "${BUILD}" -eq 1 ]]; then
>+		return
>+	fi
>+
>+	if [[ ! -d "${KERNEL_CHECKOUT}" ]]; then
>+		echo "-b requires vmtest.sh called from the kernel source tree" >&2
>+		exit 1
>+	fi
>+
>+	pushd "${KERNEL_CHECKOUT}" &>/dev/null
>+
>+	if ! vng --kconfig --config "${SCRIPT_DIR}"/config; then
>+		die "failed to generate .config for kernel source tree (${KERNEL_CHECKOUT})"
>+	fi
>+
>+	if ! make -j$(nproc); then
>+		die "failed to build kernel from source tree (${KERNEL_CHECKOUT})"
>+	fi
>+
>+	popd &>/dev/null
>+}
>+
>+vm_start() {
>+	local logfile=/dev/null
>+	local verbose_opt=""
>+	local kernel_opt=""
>+	local qemu
>+
>+	qemu=$(command -v "${QEMU}")
>+
>+	if [[ "${VERBOSE}" -eq 1 ]]; then
>+		verbose_opt="--verbose"
>+		logfile=/dev/stdout
>+	fi
>+
>+	if [[ "${BUILD}" -eq 1 ]]; then
>+		kernel_opt="${KERNEL_CHECKOUT}"
>+	fi
>+
>+	vng \
>+		--run \
>+		${kernel_opt} \
>+		${verbose_opt} \
>+		--qemu-opts="${QEMU_OPTS}" \
>+		--qemu="${qemu}" \
>+		--user root \
>+		--append "${KERNEL_CMDLINE}" \
>+		--rw  &> ${logfile} &
>+
>+	if ! timeout ${WAIT_TOTAL} \
>+		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
>+		die "failed to boot VM"
>+	fi
>+}
>+
>+vm_wait_for_ssh() {
>+	local i
>+
>+	i=0
>+	while true; do
>+		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
>+			die "Timed out waiting for guest ssh"
>+		fi
>+		if vm_ssh -- true; then
>+			break
>+		fi
>+		i=$(( i + 1 ))
>+		sleep ${WAIT_PERIOD}
>+	done
>+}
>+
>+# derived from selftests/net/net_helper.sh
>+wait_for_listener()
>+{
>+	local port=$1
>+	local interval=$2
>+	local max_intervals=$3
>+	local protocol=tcp
>+	local pattern
>+	local i
>+
>+	pattern=":$(printf "%04X" "${port}") "
>+
>+	# for tcp protocol additionally check the socket state
>+	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>+	for i in $(seq "${max_intervals}"); do
>+		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
>+		   grep -q "${pattern}"; then
>+			break
>+		fi
>+		sleep "${interval}"
>+	done
>+}
>+
>+vm_wait_for_listener() {
>+	local port=$1
>+
>+	vm_ssh <<EOF
>+$(declare -f wait_for_listener)
>+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
>+EOF
>+}
>+
>+host_wait_for_listener() {
>+	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+}
>+
>+__log_stdin() {
>+	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
>+}
>+
>+__log_args() {
>+	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
>+}
>+
>+log() {
>+	local prefix="$1"
>+
>+	shift
>+	local redirect=
>+	if [[ ${VERBOSE} -eq 0 ]]; then
>+		redirect=/dev/null
>+	else
>+		redirect=/dev/stdout
>+	fi
>+
>+	if [[ "$#" -eq 0 ]]; then
>+		__log_stdin | tee -a "${LOG}" > ${redirect}
>+	else
>+		__log_args "$@" | tee -a "${LOG}" > ${redirect}
>+	fi
>+}
>+
>+log_setup() {
>+	log "setup" "$@"
>+}
>+
>+log_host() {
>+	local testname=$1
>+
>+	shift
>+	log "test:${testname}:host" "$@"
>+}
>+
>+log_guest() {
>+	local testname=$1
>+
>+	shift
>+	log "test:${testname}:guest" "$@"
>+}
>+
>+test_vm_server_host_client() {
>+	local testname="${FUNCNAME[0]#test_}"
>+
>+	vm_ssh -- "${VSOCK_TEST}" \
>+		--mode=server \
>+		--control-port="${TEST_GUEST_PORT}" \
>+		--peer-cid=2 \
>+		2>&1 | log_guest "${testname}" &
>+
>+	vm_wait_for_listener "${TEST_GUEST_PORT}"
>+
>+	${VSOCK_TEST} \
>+		--mode=client \
>+		--control-host=127.0.0.1 \
>+		--peer-cid="${VSOCK_CID}" \
>+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
>+
>+	return $?
>+}
>+
>+test_vm_client_host_server() {
>+	local testname="${FUNCNAME[0]#test_}"
>+
>+	${VSOCK_TEST} \
>+		--mode "server" \
>+		--control-port "${TEST_HOST_PORT_LISTENER}" \
>+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
>+
>+	host_wait_for_listener
>+
>+	vm_ssh -- "${VSOCK_TEST}" \
>+		--mode=client \
>+		--control-host=10.0.2.2 \
>+		--peer-cid=2 \
>+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
>+
>+	return $?
>+}
>+
>+test_vm_loopback() {
>+	local testname="${FUNCNAME[0]#test_}"
>+	local port=60000 # non-forwarded local port
>+
>+	vm_ssh -- "${VSOCK_TEST}" \
>+		--mode=server \
>+		--control-port="${port}" \
>+		--peer-cid=1 2>&1 | log_guest "${testname}" &
>+
>+	vm_wait_for_listener "${port}"
>+
>+	vm_ssh -- "${VSOCK_TEST}" \
>+		--mode=client \
>+		--control-host="127.0.0.1" \
>+		--control-port="${port}" \
>+		--peer-cid=1 2>&1 | log_guest "${testname}"
>+
>+	return $?
>+}
>+
>+run_test() {
>+	local host_oops_cnt_before
>+	local host_warn_cnt_before
>+	local vm_oops_cnt_before
>+	local vm_warn_cnt_before
>+	local host_oops_cnt_after
>+	local host_warn_cnt_after
>+	local vm_oops_cnt_after
>+	local vm_warn_cnt_after
>+	local name
>+	local rc
>+
>+	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
>+	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>+	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
>+
>+	name=$(echo "${1}" | awk '{ print $1 }')
>+	eval test_"${name}"
>+	rc=$?
>+
>+	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
>+	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>+		echo "FAIL: kernel oops detected on host" | log_host "${name}"
>+		rc=$KSFT_FAIL
>+	fi
>+
>+	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>+	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>+		echo "FAIL: kernel warning detected on host" | log_host "${name}"
>+		rc=$KSFT_FAIL
>+	fi
>+
>+	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>+		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
>+		rc=$KSFT_FAIL
>+	fi
>+
>+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>+		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
>+		rc=$KSFT_FAIL
>+	fi
>+
>+	return "${rc}"
>+}
>+
>+QEMU="qemu-system-$(uname -m)"
>+
>+while getopts :hvsq:b o
>+do
>+	case $o in
>+	v) VERBOSE=1;;
>+	b) BUILD=1;;
>+	q) QEMU=$OPTARG;;
>+	h|*) usage;;
>+	esac
>+done
>+shift $((OPTIND-1))
>+
>+trap cleanup EXIT
>+
>+if [[ ${#} -eq 0 ]]; then
>+	ARGS=("${TEST_NAMES[@]}")
>+else
>+	ARGS=("$@")
>+fi
>+
>+check_args "${ARGS[@]}"
>+check_deps
>+check_vng
>+handle_build
>+
>+echo "1..${#ARGS[@]}"
>+
>+log_setup "Booting up VM"
>+vm_start
>+vm_wait_for_ssh
>+log_setup "VM booted up"
>+
>+cnt_pass=0
>+cnt_fail=0
>+cnt_skip=0
>+cnt_total=0
>+for arg in "${ARGS[@]}"; do
>+	run_test "${arg}"
>+	rc=$?
>+	if [[ ${rc} -eq $KSFT_PASS ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${cnt_total} ${arg}"
>+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${cnt_total} ${arg} # SKIP"
>+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${cnt_total} ${arg} # exit=$rc"
>+	fi
>+	cnt_total=$(( cnt_total + 1 ))
>+done
>+
>+echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
>+echo "Log: ${LOG}"
>+
>+if [ $((cnt_pass + cnt_skip)) -eq ${cnt_total} ]; then
>+	exit "$KSFT_PASS"
>+else
>+	exit "$KSFT_FAIL"
>+fi
>
>---
>base-commit: 8066e388be48f1ad62b0449dc1d31a25489fa12a
>change-id: 20250325-vsock-vmtest-b3a21d2102c2
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@gmail.com>
>


