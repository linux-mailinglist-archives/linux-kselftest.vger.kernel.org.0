Return-Path: <linux-kselftest+bounces-35364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41949AE0875
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9CC17BA09
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15909212B2B;
	Thu, 19 Jun 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="sfIKtBtm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714AB1D6187;
	Thu, 19 Jun 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342746; cv=none; b=EnKivHzxWGue/Y4p98x1YFemTMVP/3k+/g4cJrCrB6hMIG6awuptKRIt02AVK8H+jbWQPErZvDsm8Y3mVsFtCEmj/VXYyEePS41vSJUD3QLOopeHKIHXtgfuIgUD9fx5kJDTA6kXeOmf+s7YkL3OD7xO8R4I5OS3h4qy60wi3Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342746; c=relaxed/simple;
	bh=ss7iazria96I7YtSfmcL9zT0uqya5/2ZeIZbuBrsEOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHbj6KWwEIawrPt+kAgSFpJsbYEUaAFUOWq8PtUUEjnf7uq+ZEiSZKFBBL2vseLBIR+/xdVOJOt7V3l2RTTfKpOWKf1GxHqMamJnAWEPaRaiL9wGNPv5B0fHBdO8sr2ak+0H48oDPfbTZqEZO738ReZLVCxw9DdPlLRSVoudFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=sfIKtBtm; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750342219; bh=poAPVZRH/Ym2dVkMmx5T8JhCt5BXCY00Cmi30L1b95I=;
	h=From:To:Cc:Subject:Date:From:To:CC:Subject;
	b=sfIKtBtm3gk316hz4Ct+J7uUXhnT7tx+GMfmhgTzt68s49srMKTeQYHhX1XBLx7EZ
	 m9u10hAlLXJ46DW96J3xsfXhh2A/UIHY3p29kg1PkO5PuwlYS/otwRale5KIxS26Oy
	 g3GDcUDmNkiJ0vbHELl1q7NsLBL3ZeJOfwu8R6kRYt+hG/Epd02em9ym9aPdmtX2v+
	 v/sA9IQq8/bQ3gSVOLi39EfBoWEhuzlU9WN13QqVGbEWOUdUlaxVrdzUnikjcY0EnN
	 SEnWmJRR/VuMLFI+2hCmd9bO04aym0H+C3Dq/4my40kUJS58s7Ne3j+ZYTJhzFrVck
	 4WgmuBss5zGHw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bNMvH3KlFz8sr5;
	Thu, 19 Jun 2025 16:10:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3610:e200:f74c:d89c:f3eb:14e2
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3610:e200:f74c:d89c:f3eb:14e2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19ceJz6kt+8pw8G45x/Oq8NCBPARrdAk2Q=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bNMvD2k43z8slX;
	Thu, 19 Jun 2025 16:10:16 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	hbathini@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [PATCH bpf-next] selftests/bpf: Support ppc64el in vmtest
Date: Thu, 19 Jun 2025 16:08:53 +0200
Message-ID: <20250619140854.2135283-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a rootfs built using libbpf's BPF CI [1], we can run specific tests
as follows:

$ ../libbpf-ci/rootfs/mkrootfs_debian.sh --arch ppc64el --distro noble
$ PLATFORM=ppc64el CROSS_COMPILE=powerpc64le-linux-gnu- \
    tools/testing/selftests/bpf/vmtest.sh \
    -l libbpf-vmtest-rootfs-*-noble-ppc64el.tar.zst \
    -- ./test_progs -t verifier_array_access

Does not include a DENYLIST or support for KVM for now.

[1] https://github.com/libbpf/ci

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 tools/testing/selftests/bpf/config.ppc64el | 93 ++++++++++++++++++++++
 tools/testing/selftests/bpf/vmtest.sh      |  9 +++
 2 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/config.ppc64el

diff --git a/tools/testing/selftests/bpf/config.ppc64el b/tools/testing/selftests/bpf/config.ppc64el
new file mode 100644
index 000000000000..9acf389dc4ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.ppc64el
@@ -0,0 +1,93 @@
+CONFIG_ALTIVEC=y
+CONFIG_AUDIT=y
+CONFIG_BLK_CGROUP=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BONDING=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
+CONFIG_CGROUP_NET_CLASSID=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUPS=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=hvc0 wg.success=hvc1 panic_on_warn=1"
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPUSETS=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_FS=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DEVTMPFS=y
+CONFIG_EXPERT=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_FRAME_POINTER=y
+CONFIG_FRAME_WARN=1280
+CONFIG_HARDLOCKUP_DETECTOR=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HUGETLBFS=y
+CONFIG_HVC_CONSOLE=y
+CONFIG_INET=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_JUMP_LABEL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KPROBES=y
+CONFIG_MEMCG=y
+CONFIG_NAMESPACES=y
+CONFIG_NET_ACT_BPF=y
+CONFIG_NETDEVICES=y
+CONFIG_NETFILTER_XT_MATCH_BPF=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_VRF=y
+CONFIG_NET=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NONPORTABLE=y
+CONFIG_NR_CPUS=256
+CONFIG_PACKET=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_PCI=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_PPC64=y
+CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
+CONFIG_PPC_PSERIES=y
+CONFIG_PPC_RADIX_MMU=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROFILING=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_SECTION_MISMATCH_WARN_ONLY=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SMP=y
+CONFIG_SOC_VIRT=y
+CONFIG_SYSVIPC=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_THREAD_SHIFT=14
+CONFIG_TLS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS=y
+CONFIG_TUN=y
+CONFIG_UNIX=y
+CONFIG_UPROBES=y
+CONFIG_USER_NS=y
+CONFIG_VETH=y
+CONFIG_VLAN_8021Q=y
+CONFIG_VSOCKETS_LOOPBACK=y
+CONFIG_VSX=y
+CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 79505d294c44..2f869daf8a06 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -43,6 +43,15 @@ riscv64)
 	BZIMAGE="arch/riscv/boot/Image"
 	ARCH="riscv"
 	;;
+ppc64el)
+	QEMU_BINARY=qemu-system-ppc64
+	QEMU_CONSOLE="hvc0"
+	# KVM could not be tested for powerpc, therefore not enabled for now.
+	HOST_FLAGS=(-machine pseries -cpu POWER9)
+	CROSS_FLAGS=(-machine pseries -cpu POWER9)
+	BZIMAGE="vmlinux"
+	ARCH="powerpc"
+	;;
 *)
 	echo "Unsupported architecture"
 	exit 1

base-commit: cd7312a78f36e981939abe1cd1f21d355e083dfe
-- 
2.49.0


