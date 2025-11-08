Return-Path: <linux-kselftest+bounces-45166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81106C42F4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4723B11FE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5650523E35B;
	Sat,  8 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKCOaJAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC0235072
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617718; cv=none; b=HAlDUTZ5gCmLZzaniTU6NVrXAnUCYG/37Zd+c5D9POgOpUuCyAvIPthYnqbAEbn1947d5osd2dkttpP+XKzg+QVxdR13M5nAKfGiEGAo4yksnwU8Sdf698+dAAat33D7a0+Ke6vqfDFP6ClXDRyfMkKk2ymfDbtWVv1W/Xnw2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617718; c=relaxed/simple;
	bh=/dJQ/7I3OQhP+yWr0bsAI2cwjILzUHF+RHQ7fT+3XdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxFgPIECD+tHUyyS5m26vpTFwuKNuV+hzEp7lK9ZRQBKkuRpbR+NuIz15s59yE4g8kto5f//muwTLUN9gsocJMTOGAM1sfUv/OxF9G+H6rnKpu9UDqIKrZEbry8ltjsBTu5/LS7mwrsLrejH0oq9e/HhCfwuotSAfFTMO/Us/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKCOaJAb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ba599137cf8so1047503a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617715; x=1763222515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4Urawj2//n5SfHIkQ4jAkZb6mHY043f4lqvaETaRcY=;
        b=iKCOaJAbaWz3jjJ+vz/274KDozpscf4nxIsqSI14wQ8prQ9cbrvrx+WGq39caurwmq
         vML4wcdp8EPkEG50k2zqdWEg85mMfCk0MTG0ZEwa6fu7g4ElSSFS1LMB89AfM+nZQmIt
         kJSmn8jl7rCzjaRBTBB9zlW6H5Oz0kGdArc3mk7OyeY3dBBMowxPMZ6vfjMwAq7n3L3t
         Yalzv8KMiiNZlDz3+maQStZR3YQhrvC6FHIUBd7yVqy5USFFaoAT1sMk1XsCoPAlICXj
         V08JlT5mmk9lyoEC9F42fnXipWW/KpUwY6mnV8N3SWPxjxd2CBzf9D6m5+9m7KPab/b4
         XhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617715; x=1763222515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4Urawj2//n5SfHIkQ4jAkZb6mHY043f4lqvaETaRcY=;
        b=Me79K5T7QrWIw6MXN/8FpKzrOXPEnA3lCCeqqiTr85pN9Cv/gpQuk2DjQvxsMV6uje
         hso/YhH7utkT67oh6JEBTpecFdAHo6mGfbU3DJi9a2oW7s4sSZ7VrORG8DUPjojYy4XD
         qEnVZz6wkj6IqlKFXUO1h1Ac1ovwOjZPVyXS3qOd23NSG3nC+ND6Uq3iyUYoMWr2cqUV
         yM8ClL3/VFCkew9Ueynqq984cjbg0GKfwZCkhihz55lUhxSwbEYsQDB/B9HQ11FN0srm
         qfUdiIG5+YtOO+MfODSiwE3X7jjP6g0ZU2X/ikTvey5/k6CvGvFADJxbsHGN3vinrJjW
         ssjg==
X-Forwarded-Encrypted: i=1; AJvYcCWwYlb/dYPTmU2nAsnHXnBUdF4XxvBCKtgLXPkUldAGVE9CzRzc1xvMO/gmtzIakZwMNZhqlJ4xRp1rAjv1q9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl7MsP0bOsINTBjMAljCvvv7/bfEf8Wzj12XlyWP8A7/hzVU5I
	VL9VFK6GbhPqBFR1sPoYUysTuM96q3XSIwMmlkZPcg9Cag83ROtGGekO
X-Gm-Gg: ASbGncvdzY4pUJ19Ac0KenUI1kO7/U7Mmtgc1XAldNwt2ALLWulCJO4evxDslWXkqZr
	oPWCPMV2rOj19IMXph4yvO26kKQkgOKpRen8Jk9BzHWvdcW4u8P0Owr7EUJO0eUHxxDXTZj8WB3
	+CxJCMc946h4WDTtMmF/Yq59mGfxC6wNVeHDw/52VxbBP+n1Zv9W1QL4Ov3cquDmc478KrqiwwF
	EuKE48kzhZQzPTOcM5k0Tc3Ocb8EYam3bCIoLRqFA82RaG444PEqTbFYUpQwGmufPvu2sVycNY2
	tBCoCgwvNEHEKCUMmw5+d+Rfn9shHke/55+iT7RbtQe0ZKgaqRAh7PoTR8kvSWwQKqlM40jbx6h
	EBx2Tyw1YIZVefQv1waI8V+RzpMNajyIX/JdmRfBo1cF8GBc2ngjnDytwLPMEbNw8E7Xv2Ui9jl
	+qmNhtDLX7
X-Google-Smtp-Source: AGHT+IHjnaq10HvTrkjlIQLeEstGDQ+eD2zoexE9N95h5RNKlq4D/zv3drStG+s5wuj4edCRNY4UGg==
X-Received: by 2002:a17:903:2cc:b0:295:82d0:9baa with SMTP id d9443c01a7336-297e1e34090mr44306595ad.17.1762617714935;
        Sat, 08 Nov 2025 08:01:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2964f2a9716sm95897525ad.0.2025.11.08.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:55 -0800
Subject: [PATCH net-next v4 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-4-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Change QEMU to use generated pidfile names instead of just a single
globally-defined pidfile. This allows multiple QEMU instances to
co-exist with different pidfiles. This is required for future tests that
use multiple VMs to check for CID collissions.

Additionally, this also places the burden of killing the QEMU process
and cleaning up the pidfile on the caller of vm_start(). To help with
this, a function terminate_pidfiles() is introduced that callers use to
perform the cleanup. The terminate_pidfiles() function supports multiple
pidfile removals because future patches will need to process two
pidfiles at a time.

Change QEMU_OPTS to be initialized inside the vm_start(). This allows
the generated pidfile to be passed to the string assignment, and
prepares for future vm-specific options as well (e.g., cid).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- use terminate_pidfiles() in cleanup (Simon)
- use associative array for PIDFILES and remove pidfiles as they are
  terminated (Simon)

Changes in v3:
- do not add unneeded -u to mktemp (Stefano)
- quote $PIDFILE_TEMPLATE (Stefano)
- do not remove cleanup(). Though it is expected that vm_start() does
  not exit(2) and its caller is responsible for pidfile cleanup,
  retaining cleanup() on EXIT is worth keeping as ill-timed kill signals
  (i.e., during manual runs) may leak those files.
- add create_pidfile() function to generate pidfile and automatically
  add it to array for cleanup() to terminate and remove later.

Changes in v2:
- mention QEMU_OPTS changes in commit message (Simon)
---
 tools/testing/selftests/vsock/vmtest.sh | 62 +++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 3bccd9b84e4a..13b685280a67 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -23,7 +23,8 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
+declare -A PIDFILES
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,12 +34,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
 # add the kernel cmdline options that virtme-init uses to setup the interface.
 readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
 readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
-readonly QEMU_OPTS="\
-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
-	 -device virtio-net-pci,netdev=n0 \
-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
-	 --pidfile ${QEMU_PIDFILE} \
-"
 readonly KERNEL_CMDLINE="\
 	virtme.dhcp net.ifnames=0 biosdevname=0 \
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
@@ -90,15 +85,7 @@ vm_ssh() {
 }
 
 cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
-
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
+	terminate_pidfiles "${!PIDFILES[@]}"
 }
 
 check_args() {
@@ -188,10 +175,37 @@ handle_build() {
 	popd &>/dev/null
 }
 
+create_pidfile() {
+	local pidfile
+
+	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
+	PIDFILES["${pidfile}"]=1
+
+	echo "${pidfile}"
+}
+
+terminate_pidfiles() {
+	local pidfile
+
+	for pidfile in "$@"; do
+		if [[ -s "${pidfile}" ]]; then
+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
+		fi
+
+		if [[ -e "${pidfile}" ]]; then
+			rm -f "${pidfile}"
+		fi
+
+		unset "PIDFILES[${pidfile}]"
+	done
+}
+
 vm_start() {
+	local pidfile=$1
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
+	local qemu_opts=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -201,6 +215,13 @@ vm_start() {
 		logfile=/dev/stdout
 	fi
 
+	qemu_opts="\
+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
+		 -device virtio-net-pci,netdev=n0 \
+		 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
+		--pidfile ${pidfile}
+	"
+
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
@@ -209,14 +230,14 @@ vm_start() {
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
-		--qemu-opts="${QEMU_OPTS}" \
+		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
 	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
 		die "failed to boot VM"
 	fi
 }
@@ -499,7 +520,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(create_pidfile)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -523,6 +545,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


