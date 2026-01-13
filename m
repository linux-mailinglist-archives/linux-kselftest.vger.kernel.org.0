Return-Path: <linux-kselftest+bounces-48834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F90D16709
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 04:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DA693010513
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D234D916;
	Tue, 13 Jan 2026 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXXwQrrD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0F340D98
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273993; cv=none; b=GogtCxCTRh879lyhDAYo5lltFWoHxJspMLv4EdFIo/6ElU7pqlrQr6VD9I7QP8I3NNPvsLotW6XbuSGwcljBOx964aVqLSlbrqK6hHTqiU74wk/Zn/hqsLPBbxHP8cqK4xtQaraqHE1zXt0n2wgg8OGvR6Z2OwPmgj77+j1glMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273993; c=relaxed/simple;
	bh=vL5YpgYxz0FfLIIl5csPYBNFRkmEcElkoa8UW4/4fuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3ulK80Vmxsoe+GoMO/AagY5x2sHTtI+Q+rcaPPvT6xssZTvsofN2jwXqQkiwK9E9+6rCRIj35etBQoqfe54pi1qqZphH2bmZxKtNJThQpVIwFiAfVOz+6a7UffxVYbDaxjMA98N8f8oV8YMY37aAKRuXKlBjBF+/HD0BUaLOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXXwQrrD; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78f99901ed5so65438487b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273988; x=1768878788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDPkpLUOyafJq1ujPR6WZLawhOFGoQnGZ+I2HIEtiX8=;
        b=bXXwQrrDYMfkZXJmYWaiIUR7CQuJKh32VDZnSt0cV0ZYNPIsk7g0LAmZSPe1ff2omY
         dPllDCp8HSLwIcyt02G98bAIDO7m6+gnVSYLJ6SNxO1cWSKabvBPDVElLO6lYaG6CCHc
         3eT/y5/V6wQEnBoue0WBEOmx22Qqb6+7cYHGuFpPSHgNfA6s33o0OCeTLU/CSuTMlMHE
         M7hZK57lYrwyCgRd1C7pqhBApCY1vJGDz3ukN785e0Gk+h1pKV6rIFf/LYF6tnWf+z+v
         rz2vfhsk6AfwxVzZUeuELDcJTyYhPXdQx7FXcCPkeGjxb/R+51ciPPvSDeK6J21JwU79
         Jp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273988; x=1768878788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDPkpLUOyafJq1ujPR6WZLawhOFGoQnGZ+I2HIEtiX8=;
        b=EUF2sax6jCYHLv9HozHLmWDC9ObrhfJT8ikMTWfmb4CEPju4vgm47wEKYRokRTEa9D
         AgtMMgSrGlvoApEaYKhYuRTGYcq5fStpRQcr/hTFTvqTzBpTvwTpOCnAKMu2WTWoyjhb
         XYVAC+YpjFJ/GHfQ7pd5p1xr6d6kT4XtaPb0+iUAJA07R49XVCxzUsjYEUlsbULtJy8C
         YGyqJTM+eYflHtosphUMVWJdkrNYPHHjAQRoGvVumtrhfsPzsUI1MgBifjPxKtwJrbDq
         IKml6hgPgVIo7ClTALBMkVmbjQM46IgT+hHxkMf2hiEUyymM+tkxRbYjDSIXVaaq3A+J
         kObw==
X-Forwarded-Encrypted: i=1; AJvYcCX+v3H7y7lPw0Z64VvYGm6h0WAZPOTaLuSAhZSiWwCB4PpVL+caZAXRp9iy4hkjr5UmhMfvBebtZxkd0DHXzus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqTtmBtnLusJDe2SZjyy/L/K8vXVAMnMbDedl0ccKJK4O498y
	nOST56c7veaFEj823LzTLTYbTLWEEcI0rxLXpApm7kX+vlj5Zd+u8gQ3
X-Gm-Gg: AY/fxX69KoW17eBrPXiBf1Fv5h6/XTppfQSN8ZOuBznsq5LALzTsCl2836GAo7QlmXR
	1WximtNwqoV5SB6zpJ7Wa3ZUZtk9SEGUPCyXYnva+qnM9SzqZffqhbVqn/DenkwAOgsPFOpwqkc
	a06lKmJfd31Ze53w2hilNOwCwjQV0mzxYvynmvcmSQvFN+/lYkoVADjGPlOpx6AL+Bw7skPFQgV
	eqPxNf7qMrb0FS7TMAplr4GLQIg0kGJbHfvY96zOMu+TQkLxs0/B1jhi2NvhYMqYjyybjLJdoMy
	6HQ7MEnt8L2D5xJLFd6FWfTTuKx7XEp/qyQDVsr4baWoCNlENjDKOWfj+CEOlslAMK7QBMPa+zT
	qJP0WRTu+JnCIGWhkiZMBYbeM7rYLMEIizOXGbutGGgVCmme/pVr/S8vAY9IvQjqNazBQfLFAJ2
	ZsP2gfpM5jEQ==
X-Google-Smtp-Source: AGHT+IHd1z2Vy0IcewPDegvyMeNLCZPVYZSEeb3b15ASoNvhn+Cl3zuhAgznkRENrmtVV/zV5uYdfQ==
X-Received: by 2002:a05:690c:6911:b0:787:d2ee:e2d6 with SMTP id 00721157ae682-790b568d39bmr182211777b3.34.1768273987592;
        Mon, 12 Jan 2026 19:13:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa670b16sm76029297b3.35.2026.01.12.19.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:07 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:20 -0800
Subject: [PATCH net-next v14 11/12] selftests/vsock: add tests for host <->
 vm connectivity with namespaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-11-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

Add vm_dmesg_* helpers to encapsulate checking dmesg
for oops and warnings.

Add ability to pass extra args to host-side vsock_test so that tests
that cause false positives may be skipped with arg --skip.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v12:
- add test skip (vsock_test test 29) when host_vsock_test() uses client
  mode in a local namespace. Test 29 causes a false positive to trigger.

Changes in v11:
- add 'sleep "${WAIT_PERIOD}"' after any non-TCP socat LISTEN cmd
  (Stefano)
- add host_wait_for_listener() after any socat TCP-LISTEN (Stefano)
- reuse vm_dmesg_{oops,warn}_count() inside vm_dmesg_check()
- fix copy-paste in test_ns_same_local_vm_connect_to_local_host_ok()
  (Stefano)

Changes in v10:
- add vm_dmesg_start() and vm_dmesg_check()

Changes in v9:
- consistent variable quoting
---
 tools/testing/selftests/vsock/vmtest.sh | 572 +++++++++++++++++++++++++++++++-
 1 file changed, 568 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1bf537410ea6..a9eaf37bc31b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,7 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#		* socat
 #
 # shellcheck disable=SC2317,SC2119
 
@@ -54,6 +55,19 @@ readonly TEST_NAMES=(
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
@@ -82,6 +96,45 @@ readonly TEST_DESCS=(
 
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
 
 readonly USE_SHARED_VM=(
@@ -112,7 +165,7 @@ usage() {
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
-	for dep in vng ${QEMU} busybox pkill ssh ss; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat; do
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
@@ -321,6 +388,14 @@ terminate_pidfiles() {
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
@@ -459,6 +534,28 @@ vm_dmesg_warn_count() {
 	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
 }
 
+vm_dmesg_check() {
+	local pidfile=$1
+	local ns=$2
+	local oops_before=$3
+	local warn_before=$4
+	local oops_after warn_after
+
+	oops_after=$(vm_dmesg_oops_count "${ns}")
+	if [[ "${oops_after}" -gt "${oops_before}" ]]; then
+		echo "FAIL: kernel oops detected on vm in ns ${ns}" | log_host
+		return 1
+	fi
+
+	warn_after=$(vm_dmesg_warn_count "${ns}")
+	if [[ "${warn_after}" -gt "${warn_before}" ]]; then
+		echo "FAIL: kernel warning detected on vm in ns ${ns}" | log_host
+		return 1
+	fi
+
+	return 0
+}
+
 vm_vsock_test() {
 	local ns=$1
 	local host=$2
@@ -502,6 +599,8 @@ host_vsock_test() {
 	local host=$2
 	local cid=$3
 	local port=$4
+	shift 4
+	local extra_args=("$@")
 	local rc
 
 	local cmd="${VSOCK_TEST}"
@@ -516,13 +615,15 @@ host_vsock_test() {
 			--mode=client \
 			--peer-cid="${cid}" \
 			--control-host="${host}" \
-			--control-port="${port}" 2>&1 | log_host
+			--control-port="${port}" \
+			"${extra_args[@]}" 2>&1 | log_host
 		rc=$?
 	else
 		${cmd} \
 			--mode=server \
 			--peer-cid="${cid}" \
-			--control-port="${port}" 2>&1 | log_host &
+			--control-port="${port}" \
+			"${extra_args[@]}" 2>&1 | log_host &
 		rc=$?
 
 		if [[ $rc -ne 0 ]]; then
@@ -593,6 +694,468 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_diff_global_host_connect_to_global_vm_ok() {
+	local oops_before warn_before
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
+	pidfile="$(create_pidfile)"
+
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	ip netns exec "${ns1}" \
+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
+			UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}" "tcp"
+
+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
+	pids+=($!)
+	host_wait_for_listener "${ns0}" "${unixfile}" "unix"
+
+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}" "tcp"
+	host_vsock_test "${ns1}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pids "${pids[@]}"
+	terminate_pidfiles "${pidfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_diff_global_host_connect_to_local_vm_fails() {
+	local oops_before warn_before
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local dmesg_rc
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	oops_before=$(vm_dmesg_oops_count "${ns1}")
+	warn_before=$(vm_dmesg_warn_count "${ns1}")
+
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	vm_wait_for_listener "${ns1}" "${port}" "vsock"
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == "TEST" ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_diff_global_vm_connect_to_global_host_ok() {
+	local oops_before warn_before
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local unixfile
+	local dmesg_rc
+	local pidfile
+	local pids
+	local rc
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
+	host_wait_for_listener "${ns0}" "${port}" "tcp"
+
+	ip netns exec "${ns1}" \
+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
+	pids+=($!)
+	host_wait_for_listener "${ns1}" "${unixfile}" "unix"
+
+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pids[@]}"
+		rm -f "${unixfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	vm_vsock_test "${ns0}" "10.0.2.2" 2 "${port}"
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${unixfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
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
+	local oops_before warn_before
+	local dmesg_rc
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
+	pid=$!
+	host_wait_for_listener "${ns1}" "${port}" "vsock"
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pid}"
+		rm -f "${outfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
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
+	local oops_before warn_before
+	local dmesg_rc
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	oops_before=$(vm_dmesg_oops_count "${ns1}")
+	warn_before=$(vm_dmesg_warn_count "${ns1}")
+
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	vm_wait_for_listener "${ns1}" "${port}" "vsock"
+
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_vm_connect_to_local_host_fails() {
+	local oops_before warn_before
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local dmesg_rc
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
+	host_wait_for_listener "${ns1}" "${port}" "vsock"
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		rm -f "${outfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
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
+
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
+	pid=$!
+	host_wait_for_listener "${ns1}" "${port}" "vsock"
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
+	local oops_before warn_before
+	local ns="local0"
+	local port=1234
+	local dmesg_rc
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns}"
+	oops_before=$(vm_dmesg_oops_count "${ns}")
+	warn_before=$(vm_dmesg_warn_count "${ns}")
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+
+	# Skip test 29 (transport release use-after-free): This test attempts
+	# binding both G2H and H2G CIDs. Because virtio-vsock (G2H) doesn't
+	# support local namespaces the test will fail when
+	# transport_g2h->stream_allow() returns false. This edge case only
+	# happens for vsock_test in client mode on the host in a local
+	# namespace. This is a false positive.
+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}" --skip=29
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_same_local_vm_connect_to_local_host_ok() {
+	local oops_before warn_before
+	local ns="local0"
+	local port=1234
+	local dmesg_rc
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns}"
+	oops_before=$(vm_dmesg_oops_count "${ns}")
+	warn_before=$(vm_dmesg_warn_count "${ns}")
+
+	host_vsock_test "${ns}" "server" "${VSOCK_CID}" "${port}"
+	vm_vsock_test "${ns}" "10.0.2.2" 2 "${port}"
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 namespaces_can_boot_same_cid() {
 	local ns0=$1
 	local ns1=$2
@@ -882,6 +1445,7 @@ fi
 check_args "${ARGS[@]}"
 check_deps
 check_vng
+check_socat
 handle_build
 
 echo "1..${#ARGS[@]}"

-- 
2.47.3


