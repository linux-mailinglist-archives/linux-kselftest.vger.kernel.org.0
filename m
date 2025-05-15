Return-Path: <linux-kselftest+bounces-33104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B2EAB8E19
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0148C1BC53AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A72256C9C;
	Thu, 15 May 2025 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjMyy3qr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43618F6E;
	Thu, 15 May 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331384; cv=none; b=X6YLF5yRTjgL5gzSz5Us3O7zLcYjF8rhbvvoaqhIH+SlkYVCqMiHegCgjUciQRc09TmLirXFIkb7NCVnma0Ya3kGBGcD04qtMO21UrG7dD1bESGPLDNtNxzqn8aT+T5zOy/5l62DAHB3tOOiGhEaQ8FGsej1NKekEiP+9CKZWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331384; c=relaxed/simple;
	bh=2QR5TyPrzmeOen4qiuO/gmZet7G2TlsdpV1Zci9lVP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gsuuA4b4gahKN5laMbfcvSClpdCnCItRDkjCGfsCJ9fJqj47eLVb8ZPhojeCKmKGGD/uoMJLGWYvbAbygN5hSfpqvYcpynG9OtitE4obFrJp4sHfo5dfsNxcCyCRJXGAj2iZizOIPj1xX9Aco+NGVtvddDMVy/+tpznq3EDq+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjMyy3qr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so2124819b3a.0;
        Thu, 15 May 2025 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331382; x=1747936182; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkCd3nc97/qxjI7JAxSPekrcxFFqr4Pq59BmsjI1Yo4=;
        b=UjMyy3qr1Dd0PoAvoMwyk/hlKCCqRra/Kci6COObRF2tv+BI8v+Z8Fo3/RLsSEj14s
         rF2XB4FmSOqhSNgVDnX1zJAGB6XeL2eL6dTkQORypkkpYxarOVN7AF4/zAGvVuPSaZy9
         EpcwPkI0j2dZFAK2aUbZCUEzHvITyBVxSVPhFrARoX9qZA6c7Wa82QqwKVmVYRg2+R14
         iJdyvFJfXe2SyQCWN7YBYuE/G2Z1BI2sE0+gab4ILyA4sU62k8t1Coet3i25yrwaQf4f
         mid5EwodM2jngekgUbQsh58cBODKdSDS3jGwZSeWPSGCbwNmiOLZkgA8tKQ2ubSj4C7f
         769w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331382; x=1747936182;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkCd3nc97/qxjI7JAxSPekrcxFFqr4Pq59BmsjI1Yo4=;
        b=tCQpLksaK5/YY+1bcJPasNm8w5i7cCDWQoYJbJruLHNlkrAN9IkwK8O58gMG+Ijdf9
         IuDuB6fE7Mb0+TH/F6MNzPq0Xii3YKVxopRFXTsN+X0UDtPZFhrcSN3jlBr+nALkbTvK
         GtVDrCpwnOJQWCbMAoaP9ggGQDc5iChxlDfkHQ6FZ+7R20SfZ2uKgNketiglWIZx0Vaw
         ilInz/k6jBYvgLtoYxPRxRh7jOGgZgDmSBTEGMOhLiVBxIT+yp22fqRwUFWPFbtExgu5
         Cz/XrrQzet5V5WYJB7p/y7sSFh6BH5dPImQfENZR1E0RSTUaYgWoXtTKHuas8rPjFQ1q
         cfIw==
X-Forwarded-Encrypted: i=1; AJvYcCUM/FMObxdgROv5/KFNrV4rGsftQJnAIlcv73Efy//XFRjU/ZuJw5sOpP+NmdnTE0HmC+aY5DBv@vger.kernel.org, AJvYcCVXxeE/FRS+Hwz2ytOmG3OoU1+jgC6vEfOozVvvMJH989JaA8hyCZbUGnFWOqLyPNAv+DIu5X4e3i4hUEo=@vger.kernel.org, AJvYcCWhkMQ2zXQeRMwvZw3ZIJEV6gnaLqXm2hWeWwJAMm0YXhNhVo7mqav98NJC80IqUd3BwTqVvmmj0GQ3qSD0W+UR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fdafDnY/X6q52D3r0iqSa7p8JiWcMDzwHSaxzDSzGJ8/iY/5
	MSJwuc7uFxqvwb57FgM2Z0v2CyRhG7I2xTPgS366i7TgsQ7/jPSL7P1d
X-Gm-Gg: ASbGncu4YL/I8iDnzMWmLlTmzrEZ2uzqdmqdbj/uK9I2DPZaI4wyYBjoCWrCf1TEEq2
	Zqm2hxlqjl2PVJf9FUOgiRkpYwG+4OgjWfUm1OmIB5/tmw9BYgEAvc2ryteZIeoDeP9zeyZZI6/
	UnW8LOtqQyap72A6Y2cDrdTE3MWjEf8an7VuHmf3/oel+S88dC/L4+/J9h/EK4gKhQkRNKStwxm
	M4P3uatE5Kck6t7O3qVPecCk57rJazapyH62STWa9uiZXc8tx/Au0f+gSn/aVDqjDdu/xc7z3ap
	ATPJLBiEbIFbkjJMPvc3/P/+h3ZtLgUdgEMG3YjtW99QF1NIN6m4ez0KFHM=
X-Google-Smtp-Source: AGHT+IF6C3W//X9Swj10FXUFH6DJ8v076HbrBZT65K6EhyvpCxjTbsuzc9DAg5P0TFNfnGjw7MMzNw==
X-Received: by 2002:a05:6a21:3a83:b0:1f2:f1a8:70ca with SMTP id adf61e73a8af0-2160d5f1db9mr6086338637.5.1747331381717;
        Thu, 15 May 2025 10:49:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf5a2cesm210246a12.9.2025.05.15.10.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 10:49:40 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 May 2025 10:49:35 -0700
Subject: [PATCH net-next v6] selftests/vsock: add initial vmtest.sh for
 vsock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-vsock-vmtest-v6-1-9af1cc023900@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC8pJmgC/13NS26EMBBF0a2gGlORq/zhM8o+ogyMKbqtBGhhZ
 HXUYu+RmIR4/HTue0GSLUqCvnrBJjmmuC7QV66uINz9chOMI/QVsGKrNFvMaQ1fmOdd0o6D9kw
 jk+LAUFfw2GSKzzP3AYvsuMhzh8+6gntM+7r9nD+Zzv1MGlL/k5mQcNLWtzT6oWvD+2328fstr
 PMZynzFTYEZCXWnyHOjNUlbYn3B3BZYIyG15CdHTk9aSmz+sFXls0FCJ+y7hh2H0ZXYXjDpAls
 kNNLYYLyxQYYrPo7jF/zM3zamAQAA
X-Change-ID: 20250325-vsock-vmtest-b3a21d2102c2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.14.2

This commit introduces a new vmtest.sh runner for vsock.

It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
H2G, and loopback. The testing tools from tools/testing/vsock/ are
reused. Currently, only vsock_test is used.

VMCI and hyperv support is automatically built, though not used.

Only tested on x86.

To run:

  $ make -C tools/testing/selftests TARGETS=vsock
  $ tools/testing/selftests/vsock/vmtest.sh

or

  $ make -C tools/testing/selftests TARGETS=vsock run_tests

Example runs:

$ ./tools/testing/selftests/vsock/vmtest.sh
TAP version 13
1..3
not ok 0 vm_server_host_client # exit=1
ok 1 vm_client_host_server
ok 2 vm_loopback
1..3

$ ./tools/testing/selftests/vsock/vmtest.sh vm_loopback
TAP version 13
1..1
ok 0 vm_loopback
1..1

Future work can include vsock_diag_test.

The tap output style copies mm's run_vmtests.sh.

Because vsock requires a VM to test anything other than loopback, this
patch adds vmtest.sh as a kselftest itself. This is different than other
systems that have a "vmtest.sh", where it is used as a utility script to
spin up a VM to run the selftests as a guest (but isn't hooked into
kselftest).

Testing in NIPA is still WIP.

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
Changes in v6:
- add make cmd in commit message in vmtest.sh example (Stefano)
- check nonzero size of QEMU_PIDFILE using -s conditional (Stefano)
- display log file path after tests so it is easier to find amongst other random names
- cleanup qemu pidfile if qemu is unable to remove it
- make oops/warning failures more obvious with 'FAIL' prefix in log
  (simply saying 'detected' wasn't clear enough to identify failing
  condition)
- Link to v5: https://lore.kernel.org/r/20250513-vsock-vmtest-v5-1-4e75c4a45ceb@gmail.com

Changes in v5:
- make log file a tmpfile (Paolo)
- make sure both default and user defined QEMU gets handled by the dependency check (Paolo)
- increased VM boot up timeout from 1m to 3m for slow hosts (Paolo)
- rename vm_setup -> vm_start (Paolo)
- derive wait_for_listener from selftests/net/net_helper.sh to removes ss usage 
- Remove unused 'unset IFS' line (Paolo)
- leave space after variable declarations (Paolo)
- make QEMU_PIDFILE a tmp file (Paolo)
- make everything readonly that is only read (Paolo)
- source ktap_helpers.sh for KSFT_PASS and friends (Paolo)
- don't check for timeout util (Paolo)
- add missing usage string for -q qemu arg
- add tap prefix to SUMMARY line since it isn't part of TAP protocol
- exit with the correct status code based on failure/pass counts
- Link to v4: https://lore.kernel.org/r/20250507-vsock-vmtest-v4-1-6e2a97262cd6@gmail.com

Changes in v4:
- do not use special tab delimiter for help string parsing (Stefano + Paolo)
- fix paths for when installing kselftest and running out-of-tree (Paolo)
- change vng to using running kernel instead of compiled kernel (Paolo)
- use multi-line string for QEMU_OPTS (Stefano)
- change timeout to 300s (Paolo)
- skip if tools are not found and use kselftests status codes (Paolo)
- remove build from vmtest.sh (Paolo)
- change 2222 -> SSH_HOST_PORT (Stefano)
- add tap-format output
- add vmtest.log to gitignore
- check for vsock_test binary and remind user to build it if missing
- create a proper build in makefile
- style fixes
- add ssh, timeout, and pkill to dependency check, just in case
- fix numerical comparison in conditionals
- check qemu pidfile exists before proceeding (avoid wasting time waiting for ssh)
- fix tracking of pass/fail bug
- fix stderr redirection bug
- Link to v3: https://lore.kernel.org/r/20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com

Changes in v3:
- use common conditional syntax for checking variables
- use return value instead of global rc
- fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
- use SIGTERM instead of SIGKILL on cleanup
- use peer-cid=1 for loopback
- change sleep delay times into globals
- fix test_vm_loopback logging
- add test selection in arguments
- make QEMU an argument
- check that vng binary is on path
- use QEMU variable
- change <tab><backslash> to <space><backslash>
- fix hardcoded file paths
- add comment in commit msg about script that vmtest.sh was based off of
- Add tools/testing/selftest/vsock/Makefile for kselftest
- Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com

Changes in v2:
- add kernel oops and warnings checker
- change testname variable to use FUNCNAME
- fix spacing in test_vm_server_host_client
- add -s skip build option to vmtest.sh
- add test_vm_loopback
- pass port to vm_wait_for_listener
- fix indentation in vmtest.sh
- add vmci and hyperv to config
- changed whitespace from tabs to spaces in help string
- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
---
 MAINTAINERS                              |   1 +
 tools/testing/selftests/vsock/.gitignore |   2 +
 tools/testing/selftests/vsock/Makefile   |  16 ++
 tools/testing/selftests/vsock/config     | 114 ++++++++
 tools/testing/selftests/vsock/settings   |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 448 +++++++++++++++++++++++++++++++
 6 files changed, 582 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 657a67f9031ef7798c19ac63e6383d4cb18a9e1f..3fbdd7bbfce7196a3cc7db70203317c6bd0e51fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25751,6 +25751,7 @@ F:	include/uapi/linux/vm_sockets.h
 F:	include/uapi/linux/vm_sockets_diag.h
 F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
+F:	tools/testing/selftests/vsock/
 F:	tools/testing/vsock/
 
 VMALLOC
diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..9c5bf379480f829a14713d5f5dc7d525bc272e84
--- /dev/null
+++ b/tools/testing/selftests/vsock/.gitignore
@@ -0,0 +1,2 @@
+vmtest.log
+vsock_test
diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..7ab4970e5e8a019be33f96a36f95c00573d7bfcf
--- /dev/null
+++ b/tools/testing/selftests/vsock/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ../../..)
+
+$(OUTPUT)/vsock_test: $(TOOLSDIR)/testing/vsock/vsock_test
+	install -m 755 $< $@
+
+$(TOOLSDIR)/testing/vsock/vsock_test:
+	$(MAKE) -C $(TOOLSDIR)/testing/vsock vsock_test
+
+TEST_PROGS += vmtest.sh
+TEST_GEN_FILES := vsock_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
new file mode 100644
index 0000000000000000000000000000000000000000..3bffaaf98fff92dc0e3bc1286afa3d8d5d52f4c7
--- /dev/null
+++ b/tools/testing/selftests/vsock/config
@@ -0,0 +1,114 @@
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_HAVE_EBPF_JIT=y
+CONFIG_BPF_EVENTS=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_KPROBES=y
+CONFIG_KPROBE_EVENTS=y
+CONFIG_ARCH_SUPPORTS_UPROBES=y
+CONFIG_UPROBES=y
+CONFIG_UPROBE_EVENTS=y
+CONFIG_DEBUG_FS=y
+CONFIG_FW_CFG_SYSFS=y
+CONFIG_FW_CFG_SYSFS_CMDLINE=y
+CONFIG_DRM=y
+CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_DRM_VIRTIO_GPU_KMS=y
+CONFIG_DRM_BOCHS=y
+CONFIG_VIRTIO_IOMMU=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_PCI=y
+CONFIG_SND_INTEL8X0=y
+CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SECURITYFS=y
+CONFIG_CGROUP_BPF=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_ZSTD=y
+CONFIG_FUSE_FS=y
+CONFIG_SERIO=y
+CONFIG_PCI=y
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_X86_VERBOSE_BOOTUP=y
+CONFIG_VGA_CONSOLE=y
+CONFIG_FB=y
+CONFIG_FB_VESA=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_KVM_GUEST=y
+CONFIG_KVM=y
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
+CONFIG_VSOCKETS=y
+CONFIG_VSOCKETS_DIAG=y
+CONFIG_VSOCKETS_LOOPBACK=y
+CONFIG_VMWARE_VMCI_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
+CONFIG_HYPERV_VSOCKETS=y
+CONFIG_VMWARE_VMCI=y
+CONFIG_VHOST_VSOCK=y
+CONFIG_HYPERV=y
+CONFIG_UEVENT_HELPER=n
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_NET=y
+CONFIG_NET_CORE=y
+CONFIG_NETDEVICES=y
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_INET=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_9P_FS=y
+CONFIG_VIRTIO_NET=y
+CONFIG_CMDLINE_OVERRIDE=n
+CONFIG_BINFMT_SCRIPT=y
+CONFIG_SHMEM=y
+CONFIG_TMPFS=y
+CONFIG_UNIX=y
+CONFIG_MODULE_SIG_FORCE=n
+CONFIG_DEVTMPFS=y
+CONFIG_TTY=y
+CONFIG_VT=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_INOTIFY_USER=y
+CONFIG_BLOCK=y
+CONFIG_SCSI_LOWLEVEL=y
+CONFIG_SCSI=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_CORE=y
+CONFIG_I6300ESB_WDT=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_OVERLAY_FS=y
+CONFIG_DAX=y
+CONFIG_DAX_DRIVER=y
+CONFIG_FS_DAX=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_ZONE_DEVICE=y
+CONFIG_FUSE_FS=y
+CONFIG_VIRTIO_FS=y
+CONFIG_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS=y
diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
new file mode 100644
index 0000000000000000000000000000000000000000..694d70710ff08ac9fc91e9ecb5dbdadcf051f019
--- /dev/null
+++ b/tools/testing/selftests/vsock/settings
@@ -0,0 +1 @@
+timeout=300
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
new file mode 100755
index 0000000000000000000000000000000000000000..e92e72a2c6480d918351bdd49baf106be4a29785
--- /dev/null
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -0,0 +1,448 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
+#
+# Dependencies:
+#		* virtme-ng
+#		* busybox-static (used by virtme-ng)
+#		* qemu	(used by virtme-ng)
+
+readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+
+source ${SCRIPT_DIR}/../kselftest/ktap_helpers.sh
+
+readonly TAP_PREFIX="# "
+readonly VSOCK_TEST=${SCRIPT_DIR}/vsock_test
+
+readonly TEST_GUEST_PORT=51000
+readonly TEST_HOST_PORT=50000
+readonly TEST_HOST_PORT_LISTENER=50001
+readonly SSH_GUEST_PORT=22
+readonly SSH_HOST_PORT=2222
+readonly VSOCK_CID=1234
+readonly WAIT_PERIOD=3
+readonly WAIT_PERIOD_MAX=60
+readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+
+# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
+# control port forwarded for vsock_test.  Because virtme-ng doesn't support
+# adding an additional port to forward to the device created from "--ssh" and
+# virtme-init mistakenly sets identical IPs to the ssh device and additional
+# devices, we instead opt out of using --ssh, add the device manually, and also
+# add the kernel cmdline options that virtme-init uses to setup the interface.
+readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
+readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
+readonly QEMU_OPTS="\
+	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
+	 -device virtio-net-pci,netdev=n0 \
+	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
+	 --pidfile ${QEMU_PIDFILE} \
+"
+readonly KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
+readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
+readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly TEST_DESCS=(
+	"Run vsock_test in server mode on the VM and in client mode on the host."
+	"Run vsock_test in client mode on the VM and in server mode on the host."
+	"Run vsock_test using the loopback transport in the VM."
+)
+
+VERBOSE=0
+
+usage() {
+	local name
+	local desc
+	local i
+
+	echo
+	echo "$0 [OPTIONS] [TEST]..."
+	echo "If no TEST argument is given, all tests will be run."
+	echo
+	echo "Options"
+	echo "  -v: verbose output"
+	echo "  -q: set the path to or name of qemu binary"
+	echo
+	echo "Available tests"
+
+	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
+		name=${TEST_NAMES[${i}]}
+		desc=${TEST_DESCS[${i}]}
+		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+	done
+	echo
+
+	exit 1
+}
+
+die() {
+	echo "$*" >&2
+	exit ${KSFT_FAIL}
+}
+
+vm_ssh() {
+	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
+	return $?
+}
+
+cleanup() {
+	if [[ -s "${QEMU_PIDFILE}" ]]; then
+		pkill -SIGTERM -F ${QEMU_PIDFILE} 2>&1 > /dev/null
+	fi
+
+	# If failure occurred during or before qemu start up, then we need
+	# to clean this up ourselves.
+	if [[ -e "${QEMU_PIDFILE}" ]]; then
+		rm "${QEMU_PIDFILE}"
+	fi
+}
+
+check_args() {
+	local found
+
+	for arg in "$@"; do
+		found=0
+		for name in "${TEST_NAMES[@]}"; do
+			if [[ "${name}" = "${arg}" ]]; then
+				found=1
+				break
+			fi
+		done
+
+		if [[ "${found}" -eq 0 ]]; then
+			echo "${arg} is not an available test" >&2
+			usage
+		fi
+	done
+
+	for arg in "$@"; do
+		if ! command -v > /dev/null "test_${arg}"; then
+			echo "Test ${arg} not found" >&2
+			usage
+		fi
+	done
+}
+
+check_deps() {
+	for dep in vng ${QEMU} busybox pkill ssh; do
+		if [[ ! -x "$(command -v ${dep})" ]]; then
+			echo -e "skip:    dependency ${dep} not found!\n"
+			exit ${KSFT_SKIP}
+		fi
+	done
+
+	if [[ ! -x $(command -v ${VSOCK_TEST}) ]]; then
+		printf "skip:    ${VSOCK_TEST} not found!"
+		printf " Please build the kselftest vsock target.\n"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+vm_start() {
+	local VNG_OPTS=""
+	local logfile=/dev/null
+	local qemu
+
+	qemu=$(command -v ${QEMU})
+
+	if [[ "${VERBOSE}" = 1 ]]; then
+		VNG_OPTS="--verbose"
+		logfile=/dev/stdout
+	fi
+	vng \
+		$VNG_OPTS \
+		--run \
+		--qemu-opts="${QEMU_OPTS}" \
+		--qemu="${qemu}" \
+		--user root \
+		--append "${KERNEL_CMDLINE}" \
+		--rw  &> ${logfile} &
+
+	timeout ${WAIT_TOTAL} \
+		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'
+	if [[ ! $? -eq 0 ]]; then
+		die "failed to boot VM"
+	fi
+}
+
+vm_wait_for_ssh() {
+	local i
+
+	i=0
+	while [[ true ]]; do
+		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
+			die "Timed out waiting for guest ssh"
+		fi
+		vm_ssh -- true
+		if [[ $? -eq 0 ]]; then
+			break
+		fi
+		i=$(( i + 1 ))
+		sleep ${WAIT_PERIOD}
+	done
+}
+
+# derived from selftests/net/net_helper.sh
+wait_for_listener()
+{
+	local port=$1
+	local interval=$2
+	local max_intervals=$3
+	local protocol=tcp
+	local pattern
+	local i
+
+	pattern=":$(printf "%04X" "${port}") "
+
+	# for tcp protocol additionally check the socket state
+	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+	for i in $(seq "${max_intervals}"); do
+		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
+		   grep -q "${pattern}"; then
+			break
+		fi
+		sleep "${interval}"
+	done
+}
+
+vm_wait_for_listener() {
+	local port=$1
+
+	vm_ssh <<EOF
+$(declare -f wait_for_listener)
+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+EOF
+}
+
+host_wait_for_listener() {
+	wait_for_listener ${TEST_HOST_PORT_LISTENER} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+}
+
+__log_stdin() {
+	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
+}
+
+__log_args() {
+	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
+}
+
+log() {
+	local prefix="$1"
+
+	shift
+	local redirect=
+	if [[ ${VERBOSE} -eq 0 ]]; then
+		redirect=/dev/null
+	else
+		redirect=/dev/stdout
+	fi
+
+	if [[ "$#" -eq 0 ]]; then
+		__log_stdin | tee -a ${LOG} > ${redirect}
+	else
+		__log_args | tee -a ${LOG} > ${redirect}
+	fi
+}
+
+log_setup() {
+	log "setup" "$@"
+}
+
+log_host() {
+	local testname=$1
+
+	shift
+	log "test:${testname}:host" "$@"
+}
+
+log_guest() {
+	local testname=$1
+
+	shift
+	log "test:${testname}:guest" "$@"
+}
+
+tap_prefix() {
+	sed -e "s/^/${TAP_PREFIX}/"
+}
+
+tap_output() {
+	if [[ ! -z "$TAP_PREFIX" ]]; then
+		read str
+		echo $str
+	fi
+}
+
+test_vm_server_host_client() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	vm_ssh -- "${VSOCK_TEST}" \
+		--mode=server \
+		--control-port="${TEST_GUEST_PORT}" \
+		--peer-cid=2 \
+		2>&1 | log_guest "${testname}" &
+
+	vm_wait_for_listener ${TEST_GUEST_PORT}
+
+	${VSOCK_TEST} \
+		--mode=client \
+		--control-host=127.0.0.1 \
+		--peer-cid="${VSOCK_CID}" \
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+
+	return $?
+}
+
+test_vm_client_host_server() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	${VSOCK_TEST} \
+		--mode "server" \
+		--control-port "${TEST_HOST_PORT_LISTENER}" \
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+
+	host_wait_for_listener
+
+	vm_ssh -- "${VSOCK_TEST}" \
+		--mode=client \
+		--control-host=10.0.2.2 \
+		--peer-cid=2 \
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+
+	return $?
+}
+
+test_vm_loopback() {
+	local testname="${FUNCNAME[0]#test_}"
+	local port=60000 # non-forwarded local port
+
+	vm_ssh -- ${VSOCK_TEST} \
+		--mode=server \
+		--control-port="${port}" \
+		--peer-cid=1 2>&1 | log_guest "${testname}" &
+
+	vm_wait_for_listener ${port}
+
+	vm_ssh -- ${VSOCK_TEST} \
+		--mode=client \
+		--control-host="127.0.0.1" \
+		--control-port="${port}" \
+		--peer-cid=1 2>&1 | log_guest "${testname}"
+
+	return $?
+}
+
+run_test() {
+	local host_oops_cnt_before
+	local host_warn_cnt_before
+	local vm_oops_cnt_before
+	local vm_warn_cnt_before
+	local host_oops_cnt_after
+	local host_warn_cnt_after
+	local vm_oops_cnt_after
+	local vm_warn_cnt_after
+	local name
+	local rc
+
+	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
+	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+
+	name=$(echo "${1}" | awk '{ print $1 }')
+	eval test_"${name}"
+	rc=$?
+
+	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
+		echo "FAIL: kernel oops detected on host" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
+		echo "FAIL: kernel warning detected on host" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
+		echo "FAIL: kernel oops detected on vm" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
+		echo "FAIL: kernel warning detected on vm" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	return ${rc}
+}
+
+QEMU="qemu-system-$(uname -m)"
+
+while getopts :hvsq: o
+do
+	case $o in
+	v) VERBOSE=1;;
+	q) QEMU=$OPTARG;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+if [[ ${#} -eq 0 ]]; then
+	ARGS=(${TEST_NAMES[@]})
+else
+	ARGS=($@)
+fi
+
+check_args "${ARGS[@]}"
+check_deps
+
+echo "TAP version 13" | tap_output
+echo "1..${#ARGS[@]}" | tap_output
+
+log_setup "Booting up VM"
+vm_start
+vm_wait_for_ssh
+log_setup "VM booted up"
+
+cnt_pass=0
+cnt_fail=0
+cnt_skip=0
+cnt_total=0
+exitcode=0
+for arg in "${ARGS[@]}"; do
+	run_test "${arg}"
+	rc=$?
+	if [[ ${rc} == $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "[PASS]" | tap_prefix
+		echo "ok ${cnt_total} ${arg}" | tap_output
+	elif [[ ${rc} == $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "[SKIP]" | tap_prefix
+		echo "ok ${cnt_total} ${arg} # SKIP" | tap_output
+		exitcode=$KSFT_SKIP
+	elif [[ ${rc} == $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "[FAIL]" | tap_prefix
+		echo "not ok ${cnt_total} ${arg} # exit=$rc" | tap_output
+		exitcode=$KSFT_FAIL
+	fi
+	cnt_total=$(( cnt_total + 1 ))
+done
+
+echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}" | tap_prefix
+echo "Log: ${LOG}" | tap_prefix
+
+if [ $((cnt_pass + cnt_skip)) -eq "$KSFT_NUM_TESTS" ]; then
+	exit "$KSFT_PASS"
+else
+	exit "$KSFT_FAIL"
+fi

---
base-commit: 8066e388be48f1ad62b0449dc1d31a25489fa12a
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@gmail.com>


