Return-Path: <linux-kselftest+bounces-43828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8FBFEC72
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59BEE353F32
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76909223702;
	Thu, 23 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4ss6YHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B8175BF
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181231; cv=none; b=tpQP7f7m5K0lQ1uhSe+LAeSKX9DFNRCjDoQWBOb7wL/71+qgPDDM7yPhe4zijWFdllXZ0RsFcMwXKriAkMAKYxWb+fqv0ngvfZTJFi4kF9+JuuY1LLHiFccFXNrSma07P3+gxs3c+lYf0/NPxJNYEY+K46ifTlXTQgv8NFp5FS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181231; c=relaxed/simple;
	bh=FRgbksM3HIGYkwx36Cagrg47zhk41xhggIZrcI5RpEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilYZG1IYCfwBrIVPFIu0pJRCezt3xB3i/XMgmlQ8xOcUh9LblPSDv8L/RI2LzEnW/aMQZV/b0Vxy/nyBKv1fvhfv3BCJvbm+lMDbACmmbAt5NwVo2yVjEBFHSHNkQ6yRyT9XhoLY47SY+FRBbfxG8SMNTzhr6wL0fmNdydUea2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4ss6YHl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a265a02477so176271b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181228; x=1761786028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psdpZrmw9QO6xTkaBDSFoh7/I56QbRl0HPRaHD7JNxQ=;
        b=U4ss6YHladEgtC7kcVHqZgsO1MZwLwRCELSCBV/nYhsooNEz4GXej5NiogqpDNL62A
         X5uVsD2p+IMASJHhdPAjFKwrho30ftGsagbh1iABjCajVSqh2a4BRrbwmksEadksiB4q
         nzsnpaY529coywzXS0OcjjTAj739jZr5dn4N7oC//VpmvqNfE6jI3G7kzGmJoghj0hfx
         t21MSPqUINE39rRiMGL+FT+UVbqsVmmSF9544GFNiPEP6XwrgMKw7YdDQUAKomc5wzME
         xrUT8oSSd/w+sIf0WCWkXdQC4NndzTNGyvnCPm5e/JG8fTI/i/FeaL2oHV8OGHapb/RK
         vU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181228; x=1761786028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psdpZrmw9QO6xTkaBDSFoh7/I56QbRl0HPRaHD7JNxQ=;
        b=JayMQaFPcyLV0ugJv/ZfdW9ZbjO0AtPId8s0MPEpUjH2hXSBxxOE9fw2hR/6AIWepX
         OYVxICUSYJt3AEEMOiGnSjwRYsLIAFCm1z+dDIu1fSu2Fpoqr+3yJRG8O2SkOtaxKLI1
         BVgFAEN3ygCTq/DJO3Wb0+kkUUV6RsF/z5y3KpdpEnS2ua0M/YENgdkxjJFnOdPJUwXa
         JHcOGYZSzTnBQIG30sNe8QqTZKO+Kl3iRbwDjZLPpKGcVL3xymT9zMhGhxw0ag7rmQiK
         KRU09IviilIrtUgW4EiseyZOJd0OCUbXxpEt8MyFEwYr3yeh9hncisryDn4+4Rkj/NEm
         jy7A==
X-Forwarded-Encrypted: i=1; AJvYcCVEzLSVTC60dsVcMkGVWB39wc/VTs0nFzVchC4ufAyyU5/D52RLr4bSzfHR2KirUHNQSu4daCdeh7c0XT5lliQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouqkxbtM8EMIEvkCJQRGMAJY/wO9cqrFB9uM/qLKXTuiunHcc
	OF8t4gRYIzLS50mOnQPqFlQwQWJ3E7ZCo0gNnFi/LWQIINV/mqtCV8bW
X-Gm-Gg: ASbGncuFaZ8bbL6z915OuSee8DbYCMWk/nxlmEyIunS2DAWjsxtX3zPconAw+wMPO+v
	PY6MvcbTM1VSL7lDdxt2NfHMXHVQmzpPPdSXL8Ykd1h0GM5nszkm+O9RZSt9AKHxJJYnPCh45uk
	rwUFI5/K2j7qvqDKZH+MiY615zV+AV1VeIdOOPtM3vlL4ulKRAdDhGsW62adn5QPihzPdT+NMfn
	JX/2o/KFRT1EwdGORx7i9zxlI9tdePcutGcVoKMjqbiP+ebCj3yqrpTCrOQl+0SMZYtWFd3/aPI
	TNxcxG9c/pav2z4JYe00EMk2zIGg7wCAP3RhR4i/gznKeicD9rksCyX4Qqoh5IUVmWvDV5+4Y/s
	rzg0OP35i9u2hrpa9adZcg3OnqPo906niGLsHbfUNensnnYiaEkA8bssO3TS0NhGr6iepfZsH6E
	LlHEMaQlM=
X-Google-Smtp-Source: AGHT+IG2lMzcFjc7REx0pi6nhktqcdfljQ9tGmdpXH2R81kak7XIbbuULliQHZiUSV0Oy/z29QS5Nw==
X-Received: by 2002:a05:6a00:9518:b0:782:ec0f:d273 with SMTP id d2e1a72fcca58-7a2208fe6bfmr25768343b3a.1.1761181228171;
        Wed, 22 Oct 2025 18:00:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb3bdesm563096b3a.64.2025.10.22.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:08 -0700
Subject: [PATCH net-next 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-4-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 53 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 29b36b4d301d..9c72559aa894 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -23,7 +23,7 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,12 +33,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
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
@@ -89,17 +83,6 @@ vm_ssh() {
 	return $?
 }
 
-cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
-
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
-}
 
 check_args() {
 	local found
@@ -188,10 +171,26 @@ handle_build() {
 	popd &>/dev/null
 }
 
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
@@ -201,6 +200,13 @@ vm_start() {
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
@@ -209,14 +215,14 @@ vm_start() {
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
@@ -491,8 +497,6 @@ do
 done
 shift $((OPTIND-1))
 
-trap cleanup EXIT
-
 if [[ ${#} -eq 0 ]]; then
 	ARGS=("${TEST_NAMES[@]}")
 else
@@ -507,7 +511,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -531,6 +536,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


