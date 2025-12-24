Return-Path: <linux-kselftest+bounces-47943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAF8CDAFEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 01:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968AA305E78A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68A29A30A;
	Wed, 24 Dec 2025 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP/uMwUV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C242139CE
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536153; cv=none; b=skh+BC82FR/oWylz6TffWos8ZXnYGi1+6hWSzhBBx3iujqZvfPRBnmtUF5/BI0ontBimj+HMGpboZXUVIm3vmo5vDyjlXBG8PBadtIsf17Pqw4HZDbeTbrrBsilKvqzF/8NNnARnIJb/xaO9NerPk2wZ/uhX44d3j4qCMtlHBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536153; c=relaxed/simple;
	bh=6QUmPXIiGL+410murstvYOrCrrfblNae9n8rzJVPgNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMDWWTY/TpahyUJhRgIq6GD5IATu4KJrv/xLYjuiW77+hJknAH7/+RooEl65fAQDdS7Fi6pmWK2dnGM86YJORHOzRo6AYufh2kTRxeQ4wEwPmOOP4Cpzhudwqon+7xIHpIHhfS6P8OvMxVn1x3lC7d7rQlj+VFmGDz28a+enXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP/uMwUV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7f121c00dedso7350465b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536146; x=1767140946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQmVHUP1pyOgb3jgFlt+9dq9N6/cw4hdbt8Er7EM9Cw=;
        b=MP/uMwUVd33VVkNQXgK4iQ+l+ZjYxyvPH5dMEZLMZbVt2i8VoG+Y6J8iVEzrRW0qae
         7Ihw+NEK/qeAjj93pVkhWlldibwu3Uzt5Y6Huuf43MbT4Hr+BbgafPXdu4Hq7Acj+cOE
         xSugxdTJxAn5pFcN1ip1Phixbn0mE5HLjs47voseB/yL5+aZZgih3Ug2gx6WtDkG4NrU
         xWqlQc7bNhntugOAt8u3/UKSUrkfytBysLvylHWzre9GL5gCOrOSJmB/awKye5CJdK8p
         6ocyMFJYYONIYsntOomXCNUHp+TcBYyOYlEuMA0FkvcQe+0M9kZWiNX4vVFrs87hg5FK
         6ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536146; x=1767140946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQmVHUP1pyOgb3jgFlt+9dq9N6/cw4hdbt8Er7EM9Cw=;
        b=VO7LcHgRuTtsSBIODLwaGhMy1lLzwr4aVQivkkHXNV3pBIpsoyItaSe32FJQtSigFP
         9HejTH42vulMPJJxYA71p8gmmgkNdvBohgVv7lyJGRmpss+XK7OdMydZtd+EjL/sC9rk
         oLrnosBA4NfXMUEBEv7o/mYfOto/FB/Edop8OTsKSLdMGLHb6pV6cti5Gx3yVEIartK0
         HQoxR421Gy3OakeCeBG81GEPflD9svv8Ys1sOSLKTRkore4CuR8kOIhk92GctqhvwrC8
         ry82XEQUJlKZyJ9qtEjeQDyY3gEn7hPbzSERhKVSx0fimd6CP6PRQtJ6gclQfF0eWuf6
         ZBFw==
X-Forwarded-Encrypted: i=1; AJvYcCUTLNCNlxcQ/mBUVPx54fF38w9caOKgzL3ePs6PFDKjkRTwI196QofbdZz43+zrcrtvv0kFtLAOshwCsBzaSew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBltmS4YJfrspfiVOOqBTkM/VTwxOtODyRCckRIZUJUqEsbsg
	m5djJ5IRqOhCUaviIDzmUl8ru5c4JLD07bQM+RZV7/OkH5nJvvdAn44Z
X-Gm-Gg: AY/fxX7B1TUl79MdkIsZu0gjhLE1HX1lzhUV2RQ/nbORIp0s9j54/2Ib/zp0KQclAj4
	r1oDmxrzjy8RdyiQhzaFjVxek0G6hd3NipxU9tXzJ3hXeeTUbeES+AlFS4+/xf/iHCiwyOweGMI
	H6ASEYC8WnPOKW7XA8ygzxaQjtekzrSXPZe+L4DTy9hUZcVCQwQHf+n8QHx/6W1tQ3Zn9Hqp3mW
	vpkWqg6QG8VOXj94Sfj7BYrjtoBmRMi/GFMtAIkue1lT2dW+RgMxG7LTL1KrDniZY5PsFcp3OsT
	f5NI+sB8173Vr1dUc2EVz7fta5dr3xtSjMTt/yNUDXL+k9C4ZlljflWEwOeOCDFpnz9IBPBvw0p
	MdDJzVOXN7ZRC7kU42NVlmSqnio3Cot87PMNJv0+poH6EF4DC2ODpGI7/dlefKw4uV/YM9GQhRL
	W1Us1YRnwnt5LfqrGU1ZLl
X-Google-Smtp-Source: AGHT+IFumnafalLOtC3U+OthHSSkJyXLk9uPmQi6VhZ8FKCPfETUT8MKNlhUlX6TF/xbrqoNYzMNsQ==
X-Received: by 2002:a05:6a00:bc90:b0:7e8:450c:61ad with SMTP id d2e1a72fcca58-7ff67063905mr15234546b3a.68.1766536146471;
        Tue, 23 Dec 2025 16:29:06 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7eb85f15sm14844998b3a.68.2025.12.23.16.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:06 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:44 -0800
Subject: [PATCH RFC net-next v13 10/13] selftests/vsock: add tests for proc
 sys vsock ns_mode
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-10-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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


