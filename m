Return-Path: <linux-kselftest+bounces-48832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AADD16742
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 04:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32AFA303FCC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E03D330D32;
	Tue, 13 Jan 2026 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i13DtI2/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11E33065C
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273991; cv=none; b=Yd/VITzJK9+RVBPGFrBeN6OHHd9MHWx9SAC3Yeqk6u1LR8pnPHhHVZCCRaLi18oI9GXIZS4uCNZ80ad1FcVVLUzYzxb1xSR2GNEMeqwhdXGc6JtdBN+6CB9rbdraachwkw93Sz29L4DMTyss6SNhuRWZgEsPqTQhtrBnF0U0EOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273991; c=relaxed/simple;
	bh=6QUmPXIiGL+410murstvYOrCrrfblNae9n8rzJVPgNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3AXeB6cKZ5Y3LMqg/2LY3YBJPnpHfSw+uDmgI0MPSLgxHzd9HVEyiGxftMoDeMKcH3kt+l0Fi9gN9c2nNMe/BhmgqzIHL9BBzZB0H8Q6m8Vj//ZSUnDVec5YMnATOJFK9QWimtnLDeP+7/GNCbYgBXJ62TfN+xsjOW+8T8vXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i13DtI2/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fba1a1b1eso89085897b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273985; x=1768878785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQmVHUP1pyOgb3jgFlt+9dq9N6/cw4hdbt8Er7EM9Cw=;
        b=i13DtI2/oI3WgdRJAv+Qu67AnI17nH33SkZ71S6N8aI2V9FViBK0G1s+gjyYD1MS5+
         MdRIJR9kCRFcwnMZPn4wynydIHmzGwcSmp+a6zuecQPI9mS3eXkTgroUDJfVh+4LzqN7
         8w/jJJXhkv0P0X9ri9I0G16mFF8GKwW/ArIra69ZuLxkza+XnbCYuedIxoy01L2StkpN
         XdRhnKqQWTBMqpnkeTW+4P3NYKHUB5wwN5V5bYMk7/vosojggE2oJQDewBM5ry77Z16Y
         ZDxqWHBIxohOCjRaadAgDiklI+tNk0a9DcVpNXe/mSWxv9ZnZGB6FMqQhlm2sOdDSIaJ
         R5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273985; x=1768878785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQmVHUP1pyOgb3jgFlt+9dq9N6/cw4hdbt8Er7EM9Cw=;
        b=gufCn6EG0+n4/IM5140s11ovsvSZMlx7GCoZnZ+cgGJDPfeAjNTP+sCt0XjustvsoH
         xk5bmFXSpfSmr/48NTR4gHWcEt17LkCGb8UrzfLWKwFdhZFt7utYxuWazFZn5zZ32UQX
         SJVirZ2ALRVtuWrsniaCC1UP4TawAtrhlM6qtot3CS4FUDgrdrGa6iHjyebqaJvU+cYx
         NyPKnNV87sKNbZezsqoHwfoqbaU7438fo5UcSOpQrVT4tnZwhzlSIiV/+2NWnp1vTN2c
         eG3rmx507ZXtTUSvcfyaJbvvHqEhrg85G0bHy1KRnzpgxdl+owI/rG/xQb4IWWKw9iuY
         zb9g==
X-Forwarded-Encrypted: i=1; AJvYcCVtcCBpnuEaKvuPC5NQ9/WMIGpq15uziw1vsm/yqnhHXhWV/3BWmGsb/9Ggu+XxCTwYDgdAq+3fGVRLgRKHLb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/Jhn/Sbv1O0xwD/JFZtpRpp+hQc1FS2Y2xbq02N5/Db++Xdu
	ZTCE/4Y5i+y5WICcs2a3bdzx0n104xtyku5V+5BG57DnYSw0y55Kb2jF
X-Gm-Gg: AY/fxX6Gxt/dM/8Ci5HSSO+XFlXhTw4+aNVb3ZAWDBrHbcmDZmNdv7moMZW5w7UR3G1
	iNjE8oM1HF1AJMgz5jK9eJKz8HUZrwcg9424BWRbSgY+hpTga6FvN6olnT/ESu3zwaV8avzOTvD
	nlCM1Pn4zGH+eN4lIZbP8gOt3AQ1nmPet3RDD1U7ftM7LBYA24MGqKXe/kpLzu7Tx9zpj9+baqR
	Cq1U3DBw5G+WsJqYjmVd9fYYjby+0kaETSacVivE+/gaQBA2f9dHHZlZyMFlHV1zr+rBjSFCGUB
	9TDTVhh369GIKfKDGDk8IG2ieQo2dsNLplfoJhoApX/W7kwriuwlBMahJE4vRREsgLQfnPi/nqW
	r89FlanVcgvut2/q2NlEDV5sOmeBw0DtOj99KhJcnsuADkPP9g5X7KGbZBPmrMuc1h3mdLd0Vfj
	+c3nLH2luLIA==
X-Received: by 2002:a05:690c:dd6:b0:787:fa8f:bec2 with SMTP id 00721157ae682-7938d46dd04mr17161247b3.12.1768273985424;
        Mon, 12 Jan 2026 19:13:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6d93d1sm76251137b3.49.2026.01.12.19.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:05 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:18 -0800
Subject: [PATCH net-next v14 09/12] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-9-a5c332db3e2b@meta.com>
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

Add tests for the /proc/sys/net/vsock/{ns_mode,child_ns_mode}
interfaces. Namely, that they accept/report "global" and "local" strings
and enforce their access policies.

Start a convention of commenting the test name over the test
description. Add test name comments over test descriptions that existed
before this convention.

Add a check_netns() function that checks if the test requires namespaces
and if the current kernel supports namespaces. Skip tests that require
namespaces if the system does not have namespace support.

This patch is the first to add tests that do *not* re-use the same
shared VM. For that reason, it adds a run_ns_tests() function to run
these tests and filter out the shared VM tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- remove write-once test ns_host_vsock_ns_mode_write_once_ok to reflect
  removing the write-once policy
- add child_ns_mode test test_ns_host_vsock_child_ns_mode_ok
- modify test_ns_host_vsock_ns_mode_ok() to check that the correct mode
  was inherited from child_ns_mode

Changes in v12:
- remove ns_vm_local_mode_rejected test, due to dropping that constraint

Changes in v11:
- Document ns_ prefix above TEST_NAMES (Stefano)

Changes in v10:
- Remove extraneous add_namespaces/del_namespaces calls.
- Rename run_tests() to run_ns_tests() since it is designed to only
  run ns tests.

Changes in v9:
- add test ns_vm_local_mode_rejected to check that guests cannot use
  local mode
---
 tools/testing/selftests/vsock/vmtest.sh | 140 +++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0e681d4c3a15..38785a102236 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -41,14 +41,38 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+
+# Namespace tests must use the ns_ prefix. This is checked in check_netns() and
+# is used to determine if a test needs namespace setup before test execution.
+readonly TEST_NAMES=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+	ns_host_vsock_ns_mode_ok
+	ns_host_vsock_child_ns_mode_ok
+)
 readonly TEST_DESCS=(
+	# vm_server_host_client
 	"Run vsock_test in server mode on the VM and in client mode on the host."
+
+	# vm_client_host_server
 	"Run vsock_test in client mode on the VM and in server mode on the host."
+
+	# vm_loopback
 	"Run vsock_test using the loopback transport in the VM."
+
+	# ns_host_vsock_ns_mode_ok
+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
+
+	# ns_host_vsock_child_ns_mode_ok
+	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
 )
 
-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly USE_SHARED_VM=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+)
 readonly NS_MODES=("local" "global")
 
 VERBOSE=0
@@ -196,6 +220,20 @@ check_deps() {
 	fi
 }
 
+check_netns() {
+	local tname=$1
+
+	# If the test requires NS support, check if NS support exists
+	# using /proc/self/ns
+	if [[ "${tname}" =~ ^ns_ ]] &&
+	   [[ ! -e /proc/self/ns ]]; then
+		log_host "No NS support detected for test ${tname}"
+		return 1
+	fi
+
+	return 0
+}
+
 check_vng() {
 	local tested_versions
 	local version
@@ -519,6 +557,54 @@ log_guest() {
 	LOG_PREFIX=guest log "$@"
 }
 
+ns_get_mode() {
+	local ns=$1
+
+	ip netns exec "${ns}" cat /proc/sys/net/vsock/ns_mode 2>/dev/null
+}
+
+test_ns_host_vsock_ns_mode_ok() {
+	for mode in "${NS_MODES[@]}"; do
+		local actual
+
+		actual=$(ns_get_mode "${mode}0")
+		if [[ "${actual}" != "${mode}" ]]; then
+			log_host "expected mode ${mode}, got ${actual}"
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_host_vsock_child_ns_mode_ok() {
+	local orig_mode
+	local rc
+
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	rc="${KSFT_PASS}"
+	for mode in "${NS_MODES[@]}"; do
+		local ns="${mode}0"
+
+		if echo "${mode}" 2>/dev/null > /proc/sys/net/vsock/ns_mode; then
+			log_host "ns_mode should be read-only but write succeeded"
+			rc="${KSFT_FAIL}"
+			continue
+		fi
+
+		if ! echo "${mode}" > /proc/sys/net/vsock/child_ns_mode; then
+			log_host "child_ns_mode should be writable to ${mode}"
+			rc="${KSFT_FAIL}"
+			continue
+		fi
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+
+	return "${rc}"
+}
+
 test_vm_server_host_client() {
 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
@@ -592,6 +678,11 @@ run_shared_vm_tests() {
 			continue
 		fi
 
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}" "${arg}"
+			continue
+		fi
+
 		run_shared_vm_test "${arg}"
 		check_result "$?" "${arg}"
 	done
@@ -645,6 +736,49 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+run_ns_tests() {
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}" "${arg}"
+			continue
+		fi
+
+		add_namespaces
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+
+		host_oops_before=$(dmesg 2>/dev/null | grep -c -i 'Oops')
+		host_warn_before=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
+		eval test_"${name}"
+		rc=$?
+
+		host_oops_after=$(dmesg 2>/dev/null | grep -c -i 'Oops')
+		if [[ "${host_oops_after}" -gt "${host_oops_before}" ]]; then
+			echo "FAIL: kernel oops detected on host" | log_host
+			check_result "${KSFT_FAIL}" "${name}"
+			del_namespaces
+			continue
+		fi
+
+		host_warn_after=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
+		if [[ "${host_warn_after}" -gt "${host_warn_before}" ]]; then
+			echo "FAIL: kernel warning detected on host" | log_host
+			check_result "${KSFT_FAIL}" "${name}"
+			del_namespaces
+			continue
+		fi
+
+		check_result "${rc}" "${name}"
+
+		del_namespaces
+	done
+}
+
 BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
@@ -690,6 +824,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
 	terminate_pidfiles "${pidfile}"
 fi
 
+run_ns_tests "${ARGS[@]}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


