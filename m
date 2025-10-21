Return-Path: <linux-kselftest+bounces-43714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986EBF95A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC15484FB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2AA2F617D;
	Tue, 21 Oct 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9Kph4+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E32EDD72
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090444; cv=none; b=AWxVHnvckIHYg9/uJ+mod4EpDN5voizNmh5RZ/ExX3ojB2GkidBj5MsB2Yzz3WY8C8pTkbc/wcaoEcWqkltgbkfCuJf8k+0wgqMHnFsjirWxgKW52XlmqVBvf4i7sAUjAlgjlkx7INcg/SacYuKXKEM2QxGGd5Ej4YpL3GwRHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090444; c=relaxed/simple;
	bh=lSmQpIOx2H+wwJpTKFrN8deypuk5nLfSt39JjhPsaKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sg0vR6XRlrfSeBnux+SvVSIftPxO16OtA0bLxDR0fUUQ+Iz9FTOC0ud92h0kbJMmgmHhtsp6B8V97gPzx8SfqsQ4uOvSi47LnCzW1l7Tkcqq05K3pCDuWKfJwASksY5JJoxJ7HaQGAxZ6jQJREbCV+I1xi8BsjR/qEV/5w0PB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9Kph4+0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8083631b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090436; x=1761695236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C11MVom9GcVVigp1JH83uYh4dJ6GwBGVsbP0u+3A/D8=;
        b=f9Kph4+0zDcKIBxfP0+EgWXBXt+CyK8sMV/E5hmt7T3LgSiCfpUV064w/7RaIn8TfH
         adbMJdAhV5KTscE7C3b/PVvSLCUzaHfOhHZI1S5Y5YoZzSiBMw3k+tD82HERenF1uaZa
         VLtfGPecQE1mve70L7MibxDd0GU0wDAI9T+QRoO2YZRpJEmxgZM/sUyC7B+/yEsaKqiz
         znL1lmBQEzO92yuAdmwcVhElCRNYwi0gN2zuLJevsCevD87AXgkil5Wr8LkxM8bd6zJ3
         wLiFZiSe9j6pNV39d6iTcczvLGUIbZKRKvibTz9s7KX4IYw5VjpLmB0BVZuEtrDGuIMA
         UpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090436; x=1761695236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C11MVom9GcVVigp1JH83uYh4dJ6GwBGVsbP0u+3A/D8=;
        b=FtJ4QU+83BptJbYrPTu7RtzFPG1JBi40/YDjlFF95pQYZ4w2TtKXCYufLQD1O5/U0P
         cCDhopy4yESfh07u+URpphh89nHiMo+KOFTv4Ex8qmd8sPVqYqijIfjEcKtx45xo6SYS
         7mD68BWCmnUDA5Kl3wYhhrqTNZKiYB3lN4OuejoUcQtgUWSLCt6FIwdNQLoJJBLTx+zK
         /+GActaETcIDy1dvHWqPxkGPQIHlRvSIzPRlkqv7iXEVVpQ+eTZ4a9P6TbzH6eAWW/LN
         FjESswaCWxUa3MTZcMqeZFo1Bwd8DufQnIV+qGOdi5RsLcfjH1qX3Xl4Hquownojpx9/
         Joyg==
X-Forwarded-Encrypted: i=1; AJvYcCVWERqVSa/DxtEIeOwvtUbXLRVy9tN3LsEiDvf8gyTBZLkC84f69IqQc+FivuqYsaqguvPPhwcLOJHWdXnyNu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GAbu1vlfvDn6tREDIi7ahbgMMQv4yEqF1ynQwf/6x9dSpq7E
	VfRiVPWLKHVqp5tKLU0Nr03fqSWzymEwPRESnxvjMYwwB9o3+Vmk+MTz
X-Gm-Gg: ASbGnctFMkPOwGU/MHK7gQjIUXWKOjsQ1Y/FZreXQV55x0SkVvn1yI14YZDVkMULUNV
	H1iFleWqQCimMhu0o3A2ehAeukXJ2OcZhcT0MRzzLO44soQzc3V8WhjSjy0i1HwFjsOZK0pya4w
	OiA/B/BunwYH5q5t4Lbk/nKAxj7cZkVuSWDIqzU2Lq7Qb8dY4pgpWvuU/827pZqb7GO+6peo+Mz
	hag2S4TGoivuwpLzd2V/uCgoyxavLtAZNnat4gxrc5g/rVMmBHtyejRcPpqCALKRE4KQQDmFhIJ
	1dlXIc2P/GZ5Gjn9H2+WRsctdJIJbZBtSHKAdS32ZfjVaP+5yR+/yBJQpkxn+v+101sUecDMgrE
	ZkChbbNyHUj7Hi2rRFqhNeAWrW3F2d0aYHIXnWRUPxTv9Pd/JFz5FrcVUTsuX3we1Wz4Cnz1/+A
	==
X-Google-Smtp-Source: AGHT+IFruEIphVWMplpeA2jQqUDuG27XuGu5lChapLWZrI9BuGwBvnIU/lhkYltuDcRgwCsCwNZgMg==
X-Received: by 2002:a05:6a21:8881:b0:33a:86cd:1553 with SMTP id adf61e73a8af0-33a86dc7f16mr2340882637.12.1761090436048;
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cdafadb8dsm833596a12.1.2025.10.21.16.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:01 -0700
Subject: [PATCH net-next v7 18/26] selftests/vsock: prepare vm management
 helpers for namespaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-18-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add namespace support to vm management, ssh helpers, and vsock_test
wrapper functions. This is in preparation for adding namespace tests
that rely on SSH and spinning up VMs in different namespaces. The
functions still work correctly within the init ns, though the caller
must now pass "init_ns" as the requested namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 102 ++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 49b3dd78efad..e8f938419e8e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -141,7 +141,18 @@ ns_set_mode() {
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
+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
+
 	return $?
 }
 
@@ -252,10 +263,12 @@ terminate_pidfiles() {
 
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
@@ -276,7 +289,11 @@ vm_start() {
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
@@ -291,6 +308,7 @@ vm_start() {
 }
 
 vm_wait_for_ssh() {
+	local ns=$1
 	local i
 
 	i=0
@@ -298,7 +316,8 @@ vm_wait_for_ssh() {
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+
+		if vm_ssh "${ns}" -- true; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -342,28 +361,42 @@ wait_for_listener()
 }
 
 vm_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
 
-	vm_ssh <<EOF
+	log "Waiting for listener on port ${port} on vm"
+
+	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
 wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
 EOF
 }
 
 host_wait_for_listener() {
-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	local ns=$1
+	local port=$2
+
+	if [[ "${ns}" == init_ns ]]; then
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
 
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
 		# log output and use pipefail to respect vsock_test errors
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=client \
 			--control-host="${host}" \
 			--peer-cid="${cid}" \
@@ -372,7 +405,7 @@ vm_vsock_test() {
 		rc=$?
 	else
 		# log output and use pipefail to respect vsock_test errors
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" \
@@ -384,7 +417,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${port}"
+		vm_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -393,22 +426,28 @@ vm_vsock_test() {
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
@@ -418,7 +457,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -462,11 +501,11 @@ log_guest() {
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
 
@@ -474,11 +513,11 @@ test_vm_server_host_client() {
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
 
@@ -488,11 +527,14 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	if ! vm_vsock_test "server" 1 "${port}"; then
+	vm_ssh "init_ns" -- modprobe vsock_loopback &> /dev/null || :
+
+	if ! vm_vsock_test "init_ns" "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+
+	if ! vm_vsock_test "init_ns" "127.0.0.1" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -550,8 +592,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
+	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -569,13 +611,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL
@@ -620,8 +662,8 @@ cnt_total=0
 if shared_vm_tests_requested "${ARGS[@]}"; then
 	log_host "Booting up VM"
 	pidfile=$(mktemp $PIDFILE_TEMPLATE)
-	vm_start "${pidfile}"
-	vm_wait_for_ssh
+	vm_start "${pidfile}" "init_ns"
+	vm_wait_for_ssh "init_ns"
 	log_host "VM booted up"
 
 	run_shared_vm_tests "${ARGS[@]}"

-- 
2.47.3


