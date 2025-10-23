Return-Path: <linux-kselftest+bounces-43957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1AC02FE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DDFD541233
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DE351FB7;
	Thu, 23 Oct 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFOh5Mll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA934EEEA
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244110; cv=none; b=ULcJtxWUXLbL9hrMI/u/O6MqcCuDpgNbwBAr6B7wpeyQhvgJvtpfVCHnFa7pP3+jalnsru5FtZG8/FhVyaggkzln3G/T5/CnRzVxoyVD89bQsb+AHSBX+3sPqCNKkn483ZXhEXXL5DYAahthlwFxjUhXaDxhXv2MSyyblV5S680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244110; c=relaxed/simple;
	bh=DATVn9l78Ucxc/Ezbj4GwTvu1QidY9Q1CcIHZV7CW9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIWWzwFA/sDPpC6Kx0PFODydUdLeGmOJlUFiOnLOOGUqZ3R3LKUEeKilY9n8KS2ZePhFSbVusJB+dzJhsBdscz6A1eeXNtFs9XlBYfZXb0qSqVpRIXMKoX227YNuUhJMyhe+vdViPnYetdAwgnRs6YtMm4plhfqLecYBPakYbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFOh5Mll; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso1035415a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244096; x=1761848896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4fh+9NF1cRg3HMz6qh1HzeidsHHUAmb+OlygIaMiAQ=;
        b=UFOh5MllyWGVfKmVkB9VGn5sf998NSeRFXj3X+o5pivYG0vfy448WETNn9SWadIdcO
         mJDXb1zfQqPlHDgcgX3WOh2UtJMjrV2Sq9+/Z47/sCK29GSAKI49xV1vV3mtCOhUUjE8
         5rA7zEoEpZznNrOe6jTO2J3XrGV0ESPj3cGXApjIq302BGZkAVeoBIVw5Tf3ou16KCvy
         5axr0qrdpyoB2O/poyISpMPZ5611/x2wKaOgsUViqY3r8lOkNEWZH+a5DEsi5V/3iiex
         9it7Y0xL09xPLCzU5ZMUZCmLEotvL7yXAbzV6CemXZk+LkI839v+wrXk2net7e90bmgF
         8Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244096; x=1761848896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4fh+9NF1cRg3HMz6qh1HzeidsHHUAmb+OlygIaMiAQ=;
        b=c0Qa5ih2C/doEfck7iwhsU4dg+d9MljGC+2+bK+x4kMCuXFEeuPugQ41JiqIpzhasB
         1qdxwpWdXM/sH32DYd9YzLtvfmL/K4kuaSMwgPjPECjthe3MCZHU86wVtXY7r9B4opZK
         ayglTCo4x5mB4DIcFuPCXwU2WvbX9gcwQub0eDZXDWhYBOIghQc2PACLDksLI0SgM14c
         11lVFoXUZJrCx3rZ8m9FIRafnk1nijQZ2jm28wX20Mg/rpXOSJPssMTLytR1H5H07G6c
         XwuNPKdo6/Rtm86csEt7GYJjscjrsRMaG/Prfvgfrp9B3lvDN3wHDMypGKc7Jblxgbm9
         Xbww==
X-Forwarded-Encrypted: i=1; AJvYcCWO4/MHuWEZLjBClKc+58yYWnQKurIfEUPBYINV7HuEtYt/5PxqdJYWKic/qSoqf63Hdwo3WL2YVAZyIsWu2/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/RY4anU4Sv5StUQuOnmH8disJaRo1/usKolgu2XeYlMIrKBV
	+pI8reS2rNpKhU1G/7rKoFxu9Uigu7TVj6+RvTujmNfWpTCs7AFXCNut
X-Gm-Gg: ASbGncvu6ir5a7SWeA3DMw6HjEOOQaZzEcESgPJQQIFerIkvS9VxtOmZE3UANbsPhXU
	XdN7G72MfOdUuHXj18PQmXe9tjSByLcNAEOFexkPXqUJYtUu0nJdNx62mO0+y30nSpzAh3/Ss44
	VcW7MHukvnAXrrfjJG8ZP/qwMG9wbjGkhy97qPnYuMmOIPXj9KO0naiS/2Cue+xFSOXknGCGwoh
	jdifnCsoDhBNGdrtUwbuZlokCPSGrZxZcBAOS+Z398jBrBtuFkU0QoNMCzfI3S2FR6j/oxF1vGh
	yKVMmRbQlNffWlAjWcheP+ELOkP8optjb8P9QA5c8iPDcCA7+Amj9U/fRMx+XDLQWodUmqZPZ6q
	dnMjey1W02e0JFvNQkjisT72CWeRzOqU8aMv6HDP3wYDw211bk60PFDQ7fqxKG9KwbGggpPnw0m
	W/mtqR2TZr
X-Google-Smtp-Source: AGHT+IErXfajXn2q4WAhMlSSu24gGUGVa+Ixo3wfJM8ssxCRXe6Ps1rHX+A8RwbvKc5b0HMQ1l6Rpg==
X-Received: by 2002:a17:90b:57ed:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-33e21f2c090mr10011442a91.14.1761244095910;
        Thu, 23 Oct 2025 11:28:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb67f151sm4572658a91.2.2025.10.23.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:51 -0700
Subject: [PATCH net-next v8 12/14] selftests/vsock: add tests for host <->
 vm connectivity with namespaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-12-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to validate namespace correctness using vsock_test and socat.
The vsock_test tool is used to validate expected success tests, but
socat is used for expected failure tests. socat is used to ensure that
connections are rejected outright instead of failing due to some other
socket behavior (as tested in vsock_test). Additionally, socat is
already required for tunneling TCP traffic from vsock_test. Using only
one of the vsock_test tests like 'test_stream_client_close_client' would
have yielded a similar result, but doing so wouldn't remove the socat
dependency.

Additionally, check for the dependency socat. socat needs special
handling beyond just checking if it is on the path because it must be
compiled with support for both vsock and unix. The function
check_socat() checks that this support exists.

Add more padding to test name printf strings because the tests added in
this patch would otherwise overflow.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 463 +++++++++++++++++++++++++++++++-
 1 file changed, 461 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index f2a99cde9fb4..60d349c80153 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,7 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#		* socat
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
@@ -48,6 +49,19 @@ readonly TEST_NAMES=(
 	ns_local_same_cid_ok
 	ns_global_local_same_cid_ok
 	ns_local_global_same_cid_ok
+	ns_diff_global_host_connect_to_global_vm_ok
+	ns_diff_global_host_connect_to_local_vm_fails
+	ns_diff_global_vm_connect_to_global_host_ok
+	ns_diff_global_vm_connect_to_local_host_fails
+	ns_diff_local_host_connect_to_local_vm_fails
+	ns_diff_local_vm_connect_to_local_host_fails
+	ns_diff_global_to_local_loopback_local_fails
+	ns_diff_local_to_global_loopback_fails
+	ns_diff_local_to_local_loopback_fails
+	ns_diff_global_to_global_loopback_ok
+	ns_same_local_loopback_ok
+	ns_same_local_host_connect_to_local_vm_ok
+	ns_same_local_vm_connect_to_local_host_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -76,6 +90,45 @@ readonly TEST_DESCS=(
 
 	# ns_local_global_same_cid_ok
 	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
+
+	# ns_diff_global_host_connect_to_global_vm_ok
+	"Run vsock_test client in global ns with server in VM in another global ns."
+
+	# ns_diff_global_host_connect_to_local_vm_fails
+	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
+
+	# ns_diff_global_vm_connect_to_global_host_ok
+	"Run vsock_test client in VM in a global ns with server in another global ns."
+
+	# ns_diff_global_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
+
+	# ns_diff_local_host_connect_to_local_vm_fails
+	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
+
+	# ns_diff_local_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
+
+	# ns_diff_global_to_local_loopback_local_fails
+	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
+
+	# ns_diff_local_to_global_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
+
+	# ns_diff_local_to_local_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
+
+	# ns_diff_global_to_global_loopback_ok
+	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
+
+	# ns_same_local_loopback_ok
+	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
+
+	# ns_same_local_host_connect_to_local_vm_ok
+	"Run vsock_test client in a local ns with server in VM in same ns."
+
+	# ns_same_local_vm_connect_to_local_host_ok
+	"Run vsock_test client in VM in a local ns with server in same ns."
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -102,7 +155,7 @@ usage() {
 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
 		name=${TEST_NAMES[${i}]}
 		desc=${TEST_DESCS[${i}]}
-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
 	done
 	echo
 
@@ -222,7 +275,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh socat; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -273,6 +326,20 @@ check_vng() {
 	fi
 }
 
+check_socat() {
+	local support_string
+
+	support_string="$(socat -V)"
+
+	if [[ "${support_string}" != *"WITH_VSOCK 1"* ]]; then
+		die "err: socat is missing vsock support"
+	fi
+
+	if [[ "${support_string}" != *"WITH_UNIX 1"* ]]; then
+		die "err: socat is missing unix support"
+	fi
+}
+
 handle_build() {
 	if [[ ! "${BUILD}" -eq 1 ]]; then
 		return
@@ -310,6 +377,14 @@ terminate_pidfiles() {
 	done
 }
 
+terminate_pids() {
+	local pid
+
+	for pid in "$@"; do
+		kill -SIGTERM "${pid}" &>/dev/null || :
+	done
+}
+
 vm_start() {
 	local pidfile=$1
 	local ns=$2
@@ -564,6 +639,389 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_diff_global_host_connect_to_global_vm_ok() {
+	local pids pid pidfile
+	local ns0 ns1 port
+	declare -a pids
+	local unixfile
+	ns0="global0"
+	ns1="global1"
+	port=1234
+	local rc
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	ip netns exec "${ns1}" \
+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
+			UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}"
+
+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
+	pids+=($!)
+
+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns1}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	for pid in "${pids[@]}"; do
+		if [[ "$(jobs -p)" = *"${pid}"* ]]; then
+			kill -SIGTERM "${pid}" &>/dev/null
+		fi
+	done
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_diff_global_host_connect_to_local_vm_fails() {
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_ns_diff_global_vm_connect_to_global_host_ok() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local unixfile
+	local pidfile
+	local pids
+
+	init_namespaces
+
+	declare -a pids
+
+	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+
+	ip netns exec "${ns0}" \
+		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+
+	ip netns exec "${ns1}" \
+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
+	pids+=($!)
+
+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pids[@]}"
+		rm -f "${unixfile}"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+	vm_vsock_test "${ns0}" "10.0.2.2" 2 "${port}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${unixfile}"
+
+	if [[ ! $rc -eq 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+
+}
+
+test_ns_diff_global_vm_connect_to_local_host_fails() {
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:${port} STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pid}"
+		rm -f "${outfile}"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_host_connect_to_local_vm_fails() {
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_ns_diff_local_vm_connect_to_local_host_fails() {
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		rm -f "${outfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+__test_loopback_two_netns() {
+	local ns0=$1
+	local ns1=$2
+	local port=12345
+	local result
+	local pid
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
+	pid=$!
+
+	log_host "Launching socat in ns ${ns0}"
+	echo TEST | ip netns exec "${ns0}" socat STDIN VSOCK-CONNECT:1:"${port}" 2>/dev/null
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == TEST ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
+test_ns_diff_global_to_local_loopback_local_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_to_global_loopback_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_to_local_loopback_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_global_to_global_loopback_ok() {
+	init_namespaces
+
+	if __test_loopback_two_netns "global0" "global1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_same_local_loopback_ok() {
+	init_namespaces
+
+	if __test_loopback_two_netns "local0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_same_local_host_connect_to_local_vm_ok() {
+	local ns="local0"
+	local port=1234
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_same_local_vm_connect_to_local_host_ok() {
+	local ns="local0"
+	local port=1234
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 namespaces_can_boot_same_cid() {
 	local ns0=$1
 	local ns1=$2
@@ -820,6 +1278,7 @@ fi
 check_args "${ARGS[@]}"
 check_deps
 check_vng
+check_socat
 handle_build
 
 echo "1..${#ARGS[@]}"

-- 
2.47.3


