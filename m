Return-Path: <linux-kselftest+bounces-46616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6023C8D391
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 08:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A148C4E523E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C70329C78;
	Thu, 27 Nov 2025 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYchrPpl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B6327217
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229682; cv=none; b=ds4I9khlpmM0ojObEkMCJ21zbhuUSJahSNOOZdl6pow3pdVqXNceywu41RJl7ChLTtZjnQ/ES+aDDIpUv087BxMhHOXkLWx67mvFmjNgrHGlob+UPL8TgaJEaVn5d/FnQEK+qEb91Wh4jeA1YLjJnllwlu9aJ6ovCvyBBImil7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229682; c=relaxed/simple;
	bh=/Awk+ZNAUSYj37xQmP8u5lLIpYhs6f3jnk3Fa/B/6hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GenWWuU0V1XiSu5TEjnAxyv3TC0Y37WWR7p4y/BNFP3NSNzAiL6mfJVA1cZyd7CTMRUnlaSRFsLuwB+uO55wNWTJgFOakOl2iYBHmsxmrEID4+mvlAbacHxgXlqAT9uFUxQEjwH0Xn9Tf0i73Z+OAjHIouaDxCwnWN+skCieWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYchrPpl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29ba9249e9dso6852105ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229674; x=1764834474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwxY3RrBqHReoCCTc0CExP42GtobWyxbXrcCgf7a+Ec=;
        b=eYchrPplPehlVONV2tShm8syxQbikMDbK31X02qr1WFUKIamsItRPtI1KoJAMlc+WK
         7hhzsked/rE8gwmwya2BNTeLRguSm5P4ImkNaSpJVXSuVVTzC4K83TlhFwtGtAnkcUSu
         KR6GbGGdsG4BTCLNMEXJv6bm3TxC/ll1u7RtDkI0FL3LzOJtJoDs/na1zCutCzGiM7o7
         W4mzH2UoC+esSVmi5JGiCIPtS+krXRcdby0KC/3iG3wdQ8kvcyuFDqdjSFAVJQuPnV/v
         NVk11bWY2PFyMOivvcFx4xKmGJaVMcFDDVQMqd7IYNwgePqkKdngzobjcTWUgH7/OQGw
         Uv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229674; x=1764834474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mwxY3RrBqHReoCCTc0CExP42GtobWyxbXrcCgf7a+Ec=;
        b=cfiucypxXq0BTVTOL3Aazp7PV6bjBED4CDyaC8FsXOOXnc53LeCT2qK9uwKabo1jEY
         jOl6J61mgfY5o0hiEA56FX60t707V6uxfFBzb/T0TjdU16GIRziBXMgcBHGAFTDLPp/e
         IJltXDd43q/85jHyQ+/4Kx7+PTrIGmjP8jRN49IuNyIxyMu4YNkgTz4ZERFF6w/o7i6l
         efzd3PgA2CoWXuij4n0/tLsXTeB0o0zKB0DB0hx21aSumpnQt4XyHDOGzN1+qPa3K5zD
         Y1NR1GgvzMHPTxnv5ePj9CmLg4AZmKVLwrLmLnUG/6G5pgkNKacKqiVXPy/ok51T0e68
         RIFw==
X-Forwarded-Encrypted: i=1; AJvYcCXlGb6tjNYcsG5TUARH8DHwL+QCNyeHc61Din23N6NyFLqzEKlqA07Ij2LF91Pfv594bROPEAtBgxCyqclxxus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEisYjmOdXAOJBzmC2Zrx6O0Nkaf4NDhQRnWvYHmqDUBAtT162
	LI/AQyGG+DCg5oZe6sVHyIB+Q8MtbPRN38cQkNxjMvJ/zotTOQjXmnC0
X-Gm-Gg: ASbGncsAWpaxLb8kdMUFFqwjWZzjhJ6599HhMoeQ6q6HGlMfEE+Dj4H7vTjXxm0kIOv
	n77AyqUHKREUTRoiTmAskSpQB/Ab/zHUSOyHyZQhdljgKRF7zqAV0aeLYqPViIt+cpET0lr6i7y
	v4OTMBjlNhaEB8KPhfGlsB9d1/HoqOTvfnoi8+WGxaELiHrfkuRq3q2eOmNpKKyL1Jz+DonZZ9B
	wVqcRK+BWoZPkdu9axYtVjmiU0Myc9yHEI0nFZ0YP0qRCAJDE71I0cqgq3ANq55ZT+ayz4unhmr
	rFksXN+8UTr2qrly1BRZCkTq6pjNtks2W4FgchcGuAqSVMFIhrWYvsEUqswzPyH3JYUQ7Hrb7t+
	JFvqwPp9fYjnHpkTKUWxwvIohkno5zAQLhvLTP2NerAl7wab4iltdjfV1fn4+3wriw2UUyN5IfJ
	mq1yaQJc12iG+rFnddlhBv
X-Google-Smtp-Source: AGHT+IHIlqze70ddD15adUvv30WNku5JRlVK0eu6g7d4TW5+OfNZ6dSJWF3hfK+35WHjCJXw8EQ6FQ==
X-Received: by 2002:a17:903:b86:b0:295:4d97:8503 with SMTP id d9443c01a7336-29b6c575180mr257859795ad.30.1764229674412;
        Wed, 26 Nov 2025 23:47:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce477e94sm8648415ad.43.2025.11.26.23.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:41 -0800
Subject: [PATCH net-next v12 12/12] selftests/vsock: add tests for
 namespace deletion and mode changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-12-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- remove pipefile (Stefano)

Changes in v9:
- more consistent shell style
- clarify -u usage comment for pipefile
---
 tools/testing/selftests/vsock/vmtest.sh | 119 ++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index da9198dc8ab5..a903a0bf66c4 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -68,6 +68,12 @@ readonly TEST_NAMES=(
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
@@ -1274,6 +1298,101 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local pipefile pidfile outfile
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
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
+	vm_wait_for_listener "${ns0}" "${port}" "vsock"
+
+	# We use a pipe here so that we can echo into the pipe instead of using
+	# socat and a unix socket file. We just need a name for the pipe (not a
+	# regular file) so use -u.
+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
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
+	rm -f "${outfile}" "${pipefile}"
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


