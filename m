Return-Path: <linux-kselftest+bounces-45816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC12C66EC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3668129D4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852D314A6B;
	Tue, 18 Nov 2025 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMHcTCzL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2283090E5
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431241; cv=none; b=O+kdF42roxbLYghKmTWJ/8FElXncSE7S89D+fCDV89u5izplFr/vOO33z1Zsc/LChfRLeZBKA4dOt1ZNOJc/lM97t1n/xkJW+OyDb4fPL+MMAhd+9RT7fTTMr69YwVAyAB6IyDi0fiNpnZWbryjkvPcVmmZZ/C7ucrxFsNh6Fac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431241; c=relaxed/simple;
	bh=RSMm3eERoFaaRZ1jaG0xuUBAwDeKQLiQTsE/Ogn/QGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hsgQ4nC9IhHI4YwpBnuNIXZ3qIGZ6YYMbKWSVH4fXh3MUtUUahDqwJbR/4tTSEAjidSPPB6sCyaXQfRn73v1383C3FFUcRwbE0rs2bhiJLNRg9zfgmNouMxJPepVXRCipm/yfsfW0ZKLbEfFqH6cXT8ubR0eMnJFjJ7Qe1+WKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMHcTCzL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso1016205b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431237; x=1764036037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qtkcbdYM4WCxN5aS//lF0J6bT3rLhQLvWok9FW61UQ=;
        b=TMHcTCzLtRztB4vt5mMF0B72Q12NU6yINDQh9nFGcEhnhxHtFZuFvBzh6BAuPl+zFQ
         Y93bxfJqyJqiijPtPuGns+R+6lr7QZ3eojBhBIUZyOiodAs+Y/gPJMs0SJcpgT3kezSu
         1MKU/6GrSV0kqco0oduyjQq6wGh6vGILI4i/XemiSPnKwGttqygmKOeOWUCfahVeyXjk
         /7JC+Wh52oL0RYcZ771U50CKNnfridZti3x9J3RCu3WetEvkTSyy82JxmOjSMMqIMuRR
         S/9BRT1nDfFNIkK99NbsD2ElhKU3Y3oQW+JuMdVJ1hlI14G+L4H067wnHV2TsGDLRuR8
         pPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431237; x=1764036037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qtkcbdYM4WCxN5aS//lF0J6bT3rLhQLvWok9FW61UQ=;
        b=BZh640lCuFvyTn8TKvONGccMZ60thuCkGcTvC0vELCCLRdeFLqm3d4gElQuAry28yQ
         oo7e2Qm46ZKM9k6qZOp4fSGWb6bye1QUtoQWjV/BdCW/uVhz9M18FV/YFREO7iFt+oiF
         dSbO0sHa5ktblOOe6bZpQqruwP+OdwRjlUvTvRIvA+WGq2ixEKcW8DPrXk9TVWIqrGLi
         IxLU5luViqJDsHVBz9s5hxXYOjbOUgbJlB0mJbrQy2CpeDnpBg4ooFy/I1lOCIuI6SGk
         PFXmqfllYawHzw5peY3xSdfnYw/gVctj0hD4LsgvJUK1BjbxjfSxDsJ80y6dPCUMO/l8
         mWNg==
X-Forwarded-Encrypted: i=1; AJvYcCVbgNzHoVPqPWWbIqpUkw9xrS7e9CkRDEvD4z7sJTV0KAmcrCsUuNq/3Az3vUKa3hp9+DlEYX6lrScNFdnJgEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6UG3yRUW6KNoJ9DBdjL849pOqR9KRHK/zHJOAM5RBayuDcBl
	/8Cj8t5awzLR9frnXDwveNr/cI09k93FZkux4ekW5a5rNiqM6bnEVTW5
X-Gm-Gg: ASbGnctG0FGJZeWdcpdzqS6TK33Nes0E6UsMLFLPAHN5bIHOjwwOzj89NwiLThrs0OI
	kKhZUVyM3z9CBQ5XHZ1w1ouqon1B01CvF61QcAiI3is2Hqp0ycUqLXoOQ6nzgFCAEwJ2BLNceNz
	NWF72JqP9uzRrbg7VOA8A5eWsoOQ7M6rDjjlrp31DkFSasqwMSf2vCpXJYGyRGg5KwnscT4s+R6
	5HmLNRQyebxa+ErxIP2r0lDcq23iJmmRzdhY8/s/1w9tntJJMOCUn1f803XVJVl1PepgxB8zP52
	uLJkcUIfNSSNvb8G6v4NUTUsGoTug0yTjNGVDakIsHdLCtHt35sAQEs1b1jpI8zLImEj4m8ZMSZ
	a9c3ac0EB5KrbqzmdaeZORx0nFjboefAP4UYa5JJ3vTUnaCx4gP4HYJZ7w5iypAtog/AFTjntKy
	g8hjm6un07GA28co0x2C3DdcFMyMXpKgo=
X-Google-Smtp-Source: AGHT+IG6339/NjJgXR+YTgVZQfk6Ocu2FLR6xEvhDIx9eY7e/aXidaGFs0oY4dZZOWsn9iPKWy6rGg==
X-Received: by 2002:a05:6a21:999a:b0:34f:ce39:1f47 with SMTP id adf61e73a8af0-35ba1d8b9femr16998433637.38.1763431237085;
        Mon, 17 Nov 2025 18:00:37 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36e8a58c4sm13363438a12.9.2025.11.17.18.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:36 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:30 -0800
Subject: [PATCH net-next v10 07/11] selftests/vsock: prepare vm management
 helpers for namespaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-7-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add namespace support to vm management, ssh helpers, and vsock_test
wrapper functions. This enables running VMs and test helpers in specific
namespaces, which is required for upcoming namespace isolation tests.

The functions still work correctly within the init ns, though the caller
must now pass "init_ns" explicitly.

No functional changes for existing tests. All have been updated to pass
"init_ns" explicitly.

Affected functions (such as vm_start() and vm_ssh()) now wrap their
commands with 'ip netns exec' when executing commands in non-init
namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 102 +++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index f78cc574c274..1a7c810f282f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -144,7 +144,18 @@ ns_set_mode() {
 }
 
 vm_ssh() {
-	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
+	local ns_exec
+
+	if [[ "${1}" == init_ns ]]; then
+		ns_exec=""
+	else
+		ns_exec="ip netns exec ${1}"
+	fi
+
+	shift
+
+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
+
 	return $?
 }
 
@@ -267,10 +278,12 @@ terminate_pidfiles() {
 
 vm_start() {
 	local pidfile=$1
+	local ns=$2
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
 	local qemu_opts=""
+	local ns_exec=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -291,7 +304,11 @@ vm_start() {
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
 
-	vng \
+	if [[ "${ns}" != "init_ns" ]]; then
+		ns_exec="ip netns exec ${ns}"
+	fi
+
+	${ns_exec} vng \
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
@@ -306,6 +323,7 @@ vm_start() {
 }
 
 vm_wait_for_ssh() {
+	local ns=$1
 	local i
 
 	i=0
@@ -313,7 +331,8 @@ vm_wait_for_ssh() {
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+
+		if vm_ssh "${ns}" -- true; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -347,30 +366,40 @@ wait_for_listener()
 }
 
 vm_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
 
-	vm_ssh <<EOF
+	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
 wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
 EOF
 }
 
 host_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
 
-	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	if [[ "${ns}" == "init_ns" ]]; then
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	else
+		ip netns exec "${ns}" bash <<-EOF
+			$(declare -f wait_for_listener)
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+		EOF
+	fi
 }
 
 vm_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=client \
 			--control-host="${host}" \
 			--peer-cid="${cid}" \
@@ -378,7 +407,7 @@ vm_vsock_test() {
 			2>&1 | log_guest
 		rc=$?
 	else
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" \
@@ -390,7 +419,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${port}"
+		vm_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -399,22 +428,28 @@ vm_vsock_test() {
 }
 
 host_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
+	local cmd="${VSOCK_TEST}"
+	if [[ "${ns}" != "init_ns" ]]; then
+		cmd="ip netns exec ${ns} ${cmd}"
+	fi
+
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=client \
 			--peer-cid="${cid}" \
 			--control-host="${host}" \
 			--control-port="${port}" 2>&1 | log_host
 		rc=$?
 	else
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" 2>&1 | log_host &
@@ -425,7 +460,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${port}"
+		host_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -469,11 +504,11 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
-	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+	if ! host_vsock_test "init_ns" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -481,11 +516,11 @@ test_vm_server_host_client() {
 }
 
 test_vm_client_host_server() {
-	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+	if ! host_vsock_test "init_ns" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+	if ! vm_vsock_test "init_ns" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -495,13 +530,14 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+	vm_ssh "init_ns" -- modprobe vsock_loopback &> /dev/null || :
 
-	if ! vm_vsock_test "server" 1 "${port}"; then
+	if ! vm_vsock_test "init_ns" "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+
+	if ! vm_vsock_test "init_ns" "127.0.0.1" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -559,8 +595,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
+	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -577,14 +613,14 @@ run_shared_vm_test() {
 		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
-
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
+	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL
@@ -630,8 +666,8 @@ cnt_total=0
 if shared_vm_tests_requested "${ARGS[@]}"; then
 	log_host "Booting up VM"
 	pidfile="$(create_pidfile)"
-	vm_start "${pidfile}"
-	vm_wait_for_ssh
+	vm_start "${pidfile}" "init_ns"
+	vm_wait_for_ssh "init_ns"
 	log_host "VM booted up"
 
 	run_shared_vm_tests "${ARGS[@]}"

-- 
2.47.3


