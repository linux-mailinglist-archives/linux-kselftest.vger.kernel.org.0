Return-Path: <linux-kselftest+bounces-44762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65123C33413
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490C518C4878
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37370346E7D;
	Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYMDxhOF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785B339B38
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295956; cv=none; b=mWfjkYyZ26d3OF9GX2AUx2FoBoG22XENn8olRJwbHYHr3sCBgKIW4v6OPhOTQAY/8r/7fBZAMrUpC2gcGduZNzhJ+RJLkjWPuoRG1Ih8uEaAycGpXzUMvNAHo3hFB7+p5Ou5qIPg8DqITuXJ6oH8nei7ulhZXCFmJ990LYy1bKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295956; c=relaxed/simple;
	bh=qaM/YycVu4RVy+bT1TrwTWoAn6/Kw7T+6Ey2I1qpe/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RePkg+qOR7Nc/yiVdIuGapVW6MlnMQ1FfYxOBFFxBodMEr5tDJxKDJFG6NtfnVGzhkpMemeS+Uq5P/EN7WShkxbJFJbutO1PjIcrrv3PSFAfCWKf5YgBwv9zrPwYhR3df5vX1ud/5hX0YeYJJKco57LNttvJ5vFwVsvBU51h2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYMDxhOF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so78611555ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295953; x=1762900753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPomieP6y6cKKzxkcHQHYffWFCMJSj6awEpxYtimWiU=;
        b=RYMDxhOFseWUuK4ZoO6Q4IpPqgVPdE2SlsRFQpakBaVDpcGimutcZHApQ0z4phW8ea
         C4H6iQkYEwCdgGeED0o7m8tEL5AI9FoS6ReiQ/rjAcsmcdD61RsZppNP4HqNxQxP+cYS
         TUQzcdwqSiEpSMbIcICfT3tSdzwcTYIhIJB9N6LNbWXCnj2krvY5nNyw+6XgctPc8umM
         kNr6oR5THiOQanRxh7rcPfDFbGNmPdKP3N1dVmH05G4w6bZUJ5YJAj+VJK2q3OdMnWJC
         B8dozfD9+/qOZKy9ZrRF880mJuJ3rXOLi+QE110AxPo6RrbUEFc9tTzUM+Uk8cpYIQ9w
         un9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295953; x=1762900753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPomieP6y6cKKzxkcHQHYffWFCMJSj6awEpxYtimWiU=;
        b=cur9FUQzTGQ1BwtWaJFURHLpK6dj7oT7qIWzIUIxT6EL0wQeIq9LQCHc6lYlqWS3BN
         FRJWuFEcakp/6xH9+DtI9qD0SrTrkr5BaAAJ0f93fpXne5zy1M0BkIoMK7eWODYVRim6
         Z8taWWoDx4SHoPqWDsWrixmcPh550TlCJB2a3X9X0JYAr86EGw6SDz/jS/HIoRDQHCcj
         ZWSHHbh2iGARIJvPmRfnAD/KtZWVDKgCnyfvOCrOAdeA0x7xCTk3Q/RYjqT0ZjdHpmxw
         FDsjgqM4lq4y2/rVIgVn4B+R6PN6+yMTeGC3r06ifkZab+jDTISQfyK75V+cTsRS1Sgi
         eQig==
X-Forwarded-Encrypted: i=1; AJvYcCXrZlmhdUAuKWtcMnEzI6n0rys3j6iVMGJ/QxOUmKp+m/AQc92WyTIai2AvRFWNih2wRnTSRSli0Ke7qbrWor0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3KJrQU0IYSC38o6C4KoEu3Y52Y2IoKZLX3UdeB+DKuVklVqT
	+43Ts/96dcXrtPi95m/n75OKDLtsIYr3KGzzQS4mh6mjcykvOntkoH7j
X-Gm-Gg: ASbGncsVP0WG6wuI4WqKfcaqyYpeZVHpRnTk6tywuBz7VuOVO4Oz5lItUBHxLfailEo
	HPaskuZ2nHBf+4MLgHnN40VeDxrl6Tyz2WRNPHdLhvxqOB1EYHqBsDcBeKvaYOeOq+a9sMIA0UO
	L304iKfI9zKLdmkQ10gMJOC2o1nDIRy2BlKJ5iAgUIu6ApRF0bMzlZWl1+tqyt80fJWZG2nURNk
	macSQG+YsI7fRZY8+88S1utrfYkwtcSyQ4xJS/SZ5lG2q3JmVILi7Jvuz+qrL9et8u0W28kJDqs
	UxL8MQwy8GILsSamShAVMtplDDvLg53pMhtPPGvmkS5+cvqJQdeAABUgzER00xLyvMENqtx1/Br
	GhQqZYZas23CIg04if31xja282GEWOE5fw+oEzuOv7o5Zj4s6nPooJcXLoXPECx+sGfr82a/pIw
	==
X-Google-Smtp-Source: AGHT+IHD3n38ktdMLAtQTdG9dlRMpp5+qaB/a5F/5Hc82s9u1whde0uAmROI8lO0PC79msxpg9QR4Q==
X-Received: by 2002:a17:903:19e4:b0:290:cd9c:1229 with SMTP id d9443c01a7336-2962ad1f5d4mr15355965ad.19.1762295952976;
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998336sm38421705ad.31.2025.11.04.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:54 -0800
Subject: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
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

Change QEMU_OPTS to be initialized inside the vm_start(). This allows the
generated pidfile to passed to the string assignment, and prepares for
future vm-specific options as well (e.g., cid).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- mention QEMU_OPTS changes in commit message (Simon)
---
 tools/testing/selftests/vsock/vmtest.sh | 53 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 03dc4717ac3b..5637c98d5fe8 100755
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
@@ -480,8 +486,6 @@ do
 done
 shift $((OPTIND-1))
 
-trap cleanup EXIT
-
 if [[ ${#} -eq 0 ]]; then
 	ARGS=("${TEST_NAMES[@]}")
 else
@@ -496,7 +500,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -520,6 +525,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


