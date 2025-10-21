Return-Path: <linux-kselftest+bounces-43716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A7BF95BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C27584728
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73F285041;
	Tue, 21 Oct 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Bkbsg0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5C2F3624
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090446; cv=none; b=H8VXIHlUbvM99Q+xOZllDvvHBuTmRHF+cDMFSXOqbqzNjpnNA5db7gBJl8SIJMvtBj6h0NTeInLwL5V0DK99LZcFSIKrRtpYKNAHMrGfvz8x0d5fGKwpJzWRNH7C9YEP2k1oZjcfiZk++kZyeWZbHwMU4CcGyvrb+DXspB4rcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090446; c=relaxed/simple;
	bh=tkMGIMswqfAEZyDr4Cl0t0E9LZdA/zAbPpZnx5/so6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k32G2MFiucIOMqytzAZmoS6eKib6NkR2qm/n6UHmZz2R73Ii/0bc5gsvMLk2+lTfTaAUrYP6NVCwPCYeBgsmnFNAnHq0Ejt8mGxvVQi+KXfIfMjWQKYhLzdx79TgL53fUQM3jmhI/I00cclN6lGV2pCleI/Lk/CRF9a+P30Js3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1Bkbsg0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33bbeec2ed7so5399008a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090439; x=1761695239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUSawlw3KS8OKu+neqC1xDDribwG4GyG+WJRI7AbHRY=;
        b=d1Bkbsg0KhrDQf0d4BSBKXEcgdAB5m1jsXNlG8+h7rM+KytqQx01sJEyhK5m9h62yM
         7kjrR7TpGTC16SyrHdXYc41vjLbSx621FxFVTfF3EmcuBIagtatVVRfpcyArwpru/NLq
         PVf5scU26XLWGQ/h7ZIs4jvYzOSj49OqmIOFkJFzNgT6HE4XG9PR0alQmW1niDUxO5Qf
         fLdv0CjLdgA+gse/uNPCW3gF5daIRttSD2sNkHXEbPj6wSJjbnsHbEfLH0XvxOYEEgD4
         uRPkSx+vb9P9r+aGIlGEq1ZiC2bqkNELwTwMPz6oPQCLbRALUtRVoMm8oO7407IrNufs
         7iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090439; x=1761695239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUSawlw3KS8OKu+neqC1xDDribwG4GyG+WJRI7AbHRY=;
        b=Ge6GLI1P+I0SVyk+pvYTPgWOqqIdg9W/kkbaYIIHgzzZvKQmt/dh9QtpLXLxmk8e+a
         6bJgR/Ji130Fnss4AU1xOBSrjozE25eDXk7mI+c5Q89c9E54KkgRy08Myi5tsXNjTH/f
         NMGixf3bn/AKEi0JPmi+umB/5G9YQxTjydsJNfVIZYm8nUkSXLrUbAB5g0oyWvnJspQI
         do9yWTVzllp1DKmQR6RiIO9PWJrBt3MsVmLUzewDnwfuzGBJr03ZiSg/AerBfJSKzWBt
         Pt3u+xB9nLH/Q5NxtTbSJwZi3eVmAFNxnJ5EdgI2q/bMI2PoVqgq7uEagzvCJ2GYUFku
         eALQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWR5CjDIlsSUQLEiaGAupbTtvDZJEBvU6lIVDgqua5eo9RpEmykMscl4uDlUxCFaLwNUFhq+tGy7uXXtM0OL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5S/rQPNrW1Uo22fmayMW/zvIqZIAA4Neem09oF8K8d17Pfc5U
	uREk7bqPTJkJggVW6bwUyU+bhKKfEwED2vkqrH1lJjmSOhmyoL4JdHho2gV/IV3e
X-Gm-Gg: ASbGncv1vGVtE9HCcU9p27cYqvtFfc1Cm8SMX54PrTCXCQVw5av80Stmd26xHq5JHWB
	tcpjhWIPkWqGUY98U+MzaNfllQrFNrr7XwKqTTHQQT/pmoazU5hHHfPKjk1CWXQsJ8eL2UNw41R
	YZQJ97EACtvMR+qnhk+yqFxd6dJdSOj3Z8dO1FqSBzkwNXUQU2t1vEKvw/glLmbJzAQEnaa39Zr
	M64n1zmcx/OWRDwDFr8xrtiG6iKK4owtAGUUMs+gDUCvSORQPO7zZloTuXWHgYUPOAroCF/d7Xh
	ExnFrB3lyIyYAcDniHlAUonJLHGXWgZcbBdA0aSx9iTwzDhcQN3tOlHqMmDRcA4CHvQIqDcH9wt
	meYqwTyY0ID3q00Rh6vlzGf50SVMLIlyzoiWqL5h2Opl/2KjPpSDw9bAmeEuxm3/uGVJhRG/Dtb
	3pkDZkXZPN
X-Google-Smtp-Source: AGHT+IFovlERrPh42B70YTWXTmz2rKyfI2eDHBwzjrpjJJS/U4lT6i41uck3W1mtdr1D6DfW2bDl7g==
X-Received: by 2002:a17:90b:2d83:b0:32e:5b07:15dd with SMTP id 98e67ed59e1d1-33bcf8628demr21493620a91.1.1761090438795;
        Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm12570317b3a.22.2025.10.21.16.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:04 -0700
Subject: [PATCH net-next v7 21/26] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-21-0661b7b6f081@meta.com>
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

Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
that it accepts "global" and "local" strings and enforces a write-once
policy.

Start a convention of commenting the test name over the test
description. Add test name comments over test descriptions that existed
before this convention.

Add a check_netns() function that checks if the test requires namespaces
and if the current kernel supports namespaces. Skip tests that require
namespaces if the system does not have namespace support.

This patch is the first to add tests that do *not* re-use the same
shared VM. For that reason, it adds a run_tests() function to run these
tests and filter out the shared VM tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 99 ++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b129976e27fc..4defadad5701 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -38,11 +38,28 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly TEST_NAMES=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+	ns_host_vsock_ns_mode_ok
+	ns_host_vsock_ns_mode_write_once_ok
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
+	# ns_host_vsock_ns_mode_write_once_ok
+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -201,6 +218,20 @@ check_deps() {
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
@@ -500,6 +531,43 @@ log_guest() {
 	LOG_PREFIX=guest log $@
 }
 
+test_ns_host_vsock_ns_mode_ok() {
+	add_namespaces
+
+	for mode in "${NS_MODES[@]}"; do
+		if ! ns_set_mode "${mode}0" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	del_namespaces
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_host_vsock_ns_mode_write_once_ok() {
+	add_namespaces
+
+	for mode in "${NS_MODES[@]}"; do
+		local ns="${mode}0"
+		if ! ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+
+		# try writing again and expect failure
+		if ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	del_namespaces
+
+	return "${KSFT_PASS}"
+}
+
 test_vm_server_host_client() {
 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
@@ -573,6 +641,11 @@ run_shared_vm_tests() {
 			continue
 		fi
 
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}"
+			continue
+		fi
+
 		run_shared_vm_test "${arg}"
 		check_result $?
 	done
@@ -626,6 +699,28 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+run_tests() {
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}"
+			continue
+		fi
+
+		add_namespaces
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+		eval test_"${name}"
+		check_result $?
+
+		del_namespaces
+	done
+}
+
 BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
@@ -671,6 +766,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
 	terminate_pidfiles "${pidfile}"
 fi
 
+run_tests "${ARGS[@]}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


