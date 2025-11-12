Return-Path: <linux-kselftest+bounces-45391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485CBC50D63
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 08:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64BA3B8EBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 06:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9972FB095;
	Wed, 12 Nov 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+hAUMn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8192F5318
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930555; cv=none; b=eP9nQHJ+kQ+2nEh8fDJfQ3gsRbUE8/S8JuyWifnas80DNhtl4Ww+QWMHgQCCHTEpk8j1Ta4lHkfY4Jsd8wSSElb+AU41NNQh1qJHgcS9LdL4MzBL/Prxcn6VuV6BTVAGhjXMrAwuurxYQ3zUzSMfuiIumitAOcC8yzQfFXOUdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930555; c=relaxed/simple;
	bh=2x6tXKfLWbVuFVgQa4tz65Vr8N2Tjd8KuOypZPv1PZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBhUf9g7XXlK9z/TXER0CTUP0wKydbsAdaqYgwWRbKFMxHHNGXwbmpfvrHvPWp9oe1aWdr7bNfVjtb82vCTzANoSW3HQY3/h4SAFpukEVuxZJjbR8LUv0h0iRytdTvsf3hvJZNFIkhtLK3YeWi+oH0/v5F+tmYXALsbeQu/CnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+hAUMn3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so556640a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930548; x=1763535348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2Aq5H/xV16rV80h2YAfjR+YfGHuS02VHlhxoZgbHhs=;
        b=d+hAUMn3x7tIXqwWshRiRF0WMqe/0gb5PyYRQyYR+LM00dducCz71vZ014Bed2NH7T
         X8UWFAb+cSf1BGaibPxunfQ/Q1Z+KU73VSiIXeimo/KHhByG8b1lYT3m08u7UlqYYW4M
         1ZVTU0hN4PQ5xy8lZmpN7CY+KZctjJ1cIG8eqVjS2FODwOG8WV5l91Dlmp8JPpfDGo9Q
         ACnQEcqCyyYHDj9yE6cPn710DzhELpaVGHA6wBWJHgcdnFFaV8qRtwE3ZMkQTkvHgZ3m
         XUuDOhfbNDg8Rktq41Nve+mzoR47thJc2jdSpUJb1FFR0ber6N4EM4ONcBz7TdryeVBN
         siKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930548; x=1763535348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z2Aq5H/xV16rV80h2YAfjR+YfGHuS02VHlhxoZgbHhs=;
        b=Z/9vF44S+MeM0ZX/LStr/f+eRUOiKIgMh6tMtwqGYAGcxHXqJ51Ad4M0yT5L6TPnOO
         JlRT43aIFzN/KXmnZ7GVxKc7SBbuEpwO0sCSqMbrDIHWB8jC23K9JbX5+beZR6CEWuj+
         mJy3foPIJJ1g0Nods7VylbvmdJxa6As+HklWhwBrVmSqHsAW2W0iAW1VbqsNx6CfFJGr
         BX0es2Ck56QErYvZH4Yec/nIZ28NhCMbghk2LKyQFer3oA8mK2Mk9LhMtKMHs7ZnFU1B
         kPk3nsbjD8HLkdyX/bWAcQwm7Vlx196mT32l0zsoRQUXHWquId3foBWddmsAFup3EF6F
         8fLw==
X-Forwarded-Encrypted: i=1; AJvYcCU/q4Aa+iCfqtb80tiKM5HhtDsjvLVCFU45Q3qf966OSokZ+TCduR09pB6VpxB5m3lVHdD5jODC8RxN/UH5rJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBkG/OZ3yW5YDyehnOsHjMUSqspCJbVNKzImlA6PQNz8vH5IO
	h0SIEqEXRzko0Ycq51+cMtuZYlStT2/BizEsNNn5InwdoRp1dKtswg/7
X-Gm-Gg: ASbGncu/PdIBYsigxxRwyFOqBVpkaJcxzDesnOmNkuaI5+QBnsRrRjI3JwPsMItGhkU
	7gTsrQJbzuoA3LpB10Xjwpqc5bukJpLYSp7/jJ5WDivgYUTuJzPcgurhVe3srecsyq4MTIl07Gi
	cBwYAU907iYgkO/+orgVUmKOOlEvdsTH+fdcpdpVYwy05QNyVSyIE6lMhAPDzkCYvEz8JJVf9zl
	w4pGkC+Og3pZJAr8KWmUXUk73hGxP0ZhZGjxWmh6aQ14ZoyvhMX7XSympp+CkfIKbZ4Nms2put6
	F22YCREZl0wA03p0ZKSNHo8FHcUWk4ynrFIY2Kb5fhgFXoj6NvVa6mry2DzBfo9vC7I3PLyTnYY
	LbCmj19NVsA7bnNFE7nL06ch9lCDKWC2rx7v0IovX8t/62RkloFeCTE9BNLzi2xBos50D0SBg
X-Google-Smtp-Source: AGHT+IEaZPpXWBU5yvAAeuuj9Tkp7JSk1UFCUgBMoGGBK6v0KgdeYa3c4wyx7v7WbG4uqOJvA0o3rQ==
X-Received: by 2002:a17:90b:270e:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-343dde8b47fmr2468405a91.19.1762930547964;
        Tue, 11 Nov 2025 22:55:47 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5a517sm17168405b3a.57.2025.11.11.22.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:47 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:56 -0800
Subject: [PATCH net-next v9 14/14] selftests/vsock: add tests for namespace
 deletion and mode changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-14-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests that validate vsock sockets are resilient to deleting
namespaces or changing namespace modes from global to local. The vsock
sockets should still function normally.

The function check_ns_changes_dont_break_connection() is added to re-use
the step-by-step logic of 1) setup connections, 2) do something that
would maybe break the connections, 3) check that the connections are
still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- more consistent shell style
- clarify -u usage comment for pipefile
---
 tools/testing/selftests/vsock/vmtest.sh | 124 ++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 111059924287..4caa7d47f407 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -66,6 +66,12 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_mode_change_connection_continue_vm_ok
+	ns_mode_change_connection_continue_host_ok
+	ns_mode_change_connection_continue_both_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -135,6 +141,24 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
+
+	# ns_mode_change_connection_continue_vm_ok
+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_host_ok
+	"Check that changing NS mode of host namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_both_ok
+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
+
+	# ns_delete_vm_ok
+	"Check that deleting the VM's namespace does not break the socket connection"
+
+	# ns_delete_host_ok
+	"Check that deleting the host's namespace does not break the socket connection"
+
+	# ns_delete_both_ok
+	"Check that deleting the VM and host's namespaces does not break the socket connection"
 )
 
 readonly USE_SHARED_VM=(
@@ -1172,6 +1196,106 @@ test_ns_vm_local_mode_rejected() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pidfile
+	local outfile
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+	vm_wait_for_ssh "${ns0}"
+
+	outfile=$(mktemp)
+	vm_ssh "${ns0}" -- \
+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
+	pids+=($!)
+
+	# wait_for_listener() does not work for vsock because vsock does not
+	# export socket state to /proc/net/. Instead, we have no choice but to
+	# sleep for some hardcoded time.
+	sleep "${WAIT_PERIOD}"
+
+	# We use a pipe here so that we can echo into the pipe instead of using
+	# socat and a unix socket file. We just need a name for the pipe (not a
+	# regular file) so use -u.
+	local pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
+
+	if [[ $2 == "delete" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ip netns del "${ns0}"
+		elif [[ "$1" == "host" ]]; then
+			ip netns del "${ns1}"
+		elif [[ "$1" == "both" ]]; then
+			ip netns del "${ns0}"
+			ip netns del "${ns1}"
+		fi
+	elif [[ $2 == "change_mode" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ns_set_mode "${ns0}" "local"
+		elif [[ "$1" == "host" ]]; then
+			ns_set_mode "${ns1}" "local"
+		elif [[ "$1" == "both" ]]; then
+			ns_set_mode "${ns0}" "local"
+			ns_set_mode "${ns1}" "local"
+		fi
+	fi
+
+	echo "TEST" > "${pipefile}"
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
+
+	if grep -q "TEST" "${outfile}"; then
+		rc="${KSFT_PASS}"
+	else
+		rc="${KSFT_FAIL}"
+	fi
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}"
+
+	return "${rc}"
+}
+
+test_ns_mode_change_connection_continue_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_host_ok() {
+	check_ns_changes_dont_break_connection "host" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_both_ok() {
+	check_ns_changes_dont_break_connection "both" "change_mode"
+}
+
+test_ns_delete_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "delete"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_changes_dont_break_connection "host" "delete"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_changes_dont_break_connection "both" "delete"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3


