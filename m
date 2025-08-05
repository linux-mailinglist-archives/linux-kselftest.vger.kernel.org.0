Return-Path: <linux-kselftest+bounces-38339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C65B1BC21
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318861859B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD42BEC5F;
	Tue,  5 Aug 2025 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4c/cagY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB992BEC27;
	Tue,  5 Aug 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430573; cv=none; b=aLfnZgsuj+BhBa2mVNJdtHGpnFUoDSnwSTGQtmb1dh8gyybx3BPOTgCXMPNjdu3T3X1n59u03Gvxq8rLV5UjbtSyoRZUhraJ/X5GZwIOWyX9lR6GTU4GlAEe8m6wpIrEbo71P6ejYjRIbqTDSHevO1NHtBXqO7pMFJ6zFKZ/dq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430573; c=relaxed/simple;
	bh=BquwX6HjvEBxZ0NOdjFPMl3JAQrw/BuuZkbNRV5kNDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/NIw+2XflmapA4F8d1WCkvyHYFj3aVNWYsDEm3BZaByaXeVostQx9fxzxOkAdVkYT41wLFOcTSuV0H1eScNGkGUrb8uUqcZvVFzkyTA+RXQKwaPbjN9GjTTSO2tiAHARdC/2SBS/l0ccxOD3TOObIJwvmVTVtBdQK1GcXp7Phw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4c/cagY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b424d2eb139so239121a12.1;
        Tue, 05 Aug 2025 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430570; x=1755035370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=Y4c/cagYxjV9HTEfY4NFiWhgBMKJTBNicyRpgcNyt1VhOtPMIn/N0GJtDilmTTe6W4
         coW6oK+Ako++0z0FAUcQjXJ9grF+tVv+BbyOsy8yvrSk7nVdncKM8DTxVx5Q3G7UcorO
         cpsFgKDOElHfSey8J0RqAMW1pEmQxJfPa6iS236fGFMLvvXGHd8vi5mluylaLN+NyeV7
         zQuqZo/8799ozcXf+7OSRYu6hLumOMQ7Ot8f32JVYQFrG4VrZRQbDRLJQtxz/ZFOqQ1j
         dwJnqdylAYsWxvypFn9Kmp6YLtHCHz3Jyqm2o5OBDUC0wo3aiZT+loCplKwKXUQnt0Zb
         0D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430570; x=1755035370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YyzkIGkPcN4s/5n8XbmWu5wXR7Mhh7fBZ/cTvP3v7E=;
        b=v1ofiwH/MOojlIo+x5JagG87AtuEqBlVFRM41Zqqg/fs2kHrKwYMVwfUWRI5yWwUMj
         pSeBpni+Yt97H7j1vKDzzLqS5XSYjnLQxtExYWMhsOX3lu2EdDRhy2eoJij4DSzMld0Y
         1s+SlK2PRX12bkBEqZzrq4Y6r4VD26NjDijKsXZz7rJjgbPGom9lkEdcvX6q+ATJRIsi
         3GKYrAwtUfDcStV945RaBdL9BBA6qvkQx849cIbfNoU3Q7BaZDQ/WhrqtsPCMhx8NHM1
         i4UBMYB46IGINs03ESROQKPwO1KXPHI8XJLHZrGBz7CZDyXafOeYxF0PlwFiFaGEeHXt
         UX8w==
X-Forwarded-Encrypted: i=1; AJvYcCUCgm8IrVQYEGU9FKSBIXRzo6zMOiTatvOFTEfIpnmSWOT6byyL97rWNC7WuFQxMqmDDEs10ZAcOhupaXL1@vger.kernel.org, AJvYcCUjLf1JPOLEtCxhAqLLKXK+lCZKbY5ur6Ij1Pr9nkpSs8FFQN1srZEAh7lIUXt1AtNqc66Y3jzx@vger.kernel.org, AJvYcCUjLuBOhGWOGiZbOtTtkaoaoGJAVqJr2rErf1i8GWKCPMr9aeixREzW/HBrYZiIR+xVOz4/+ojNGcvhmaP9@vger.kernel.org, AJvYcCWiGxua6/9uuf9d7SUZvq8Vop/GkDIwtPjbKLaD2HHyRi6YMCQ9rlZjYac4XfyBxxcq5So=@vger.kernel.org, AJvYcCXAP7Hte1OqKZVNnWXX51AP5sFJ+lyF/jXz4AISwR7bqUFtzZrLltHlQwhpM7zaRk2uN1lqDA67aTZsTdDWjcd9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9wFZkYe8NlvqWhG43GMEU2+HUADKGT+6g+QI4aNDxAI0vwkd
	RJc+wChAi+pcAicRT/cvEFvpUiE6jnK8V8Elg3jXiVuJNz2VHqwGSrVo
X-Gm-Gg: ASbGncsHnfrnKRiXChUrXoI4zyJgvhDLVyBa20fzfrO1Uh2HoYt93/9XJPIIhySYPv3
	RRl0EP35gwDBdHSLq3IJyPvtKWbWZMHGo+RHrTZtC5/6Ldcv5kYooAqxzI/kEl1T+4zh6mZJU4q
	fx9CnZa8bUdwHDFt+ffm0F8YOR4tX5pUq/FdwFMaW0NJpE2k1hErFchRGrlJKiOOpfKW3Kvs7DT
	layowXuGMrI2/aK7HGOPeeIbvHVtz+W0wXeqyM5zwgTOaT1zol7LRSKQN/YjLQqTQ/podwJdNl/
	m+m1eHjc/Ku6fPkfepNGOdS81xx4GDnfAstu2p3Zq1eOpqTr9g6KzhiBJ2qWDNXwLMVAl8O27Yb
	Fp9lUDewn+A97eilnoPdiwekY+4ZJRUs=
X-Google-Smtp-Source: AGHT+IEGF9ILDBnnoknWZKQ2G+wK9h51qA8kxxh5nsU0lZMy+4+a+iHFcBwZmFqZpGGoul2VL5iLww==
X-Received: by 2002:a17:90b:2801:b0:312:dbcd:b93d with SMTP id 98e67ed59e1d1-32166a3a19emr474676a91.14.1754430570367;
        Tue, 05 Aug 2025 14:49:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49e0sm17855734a91.24.2025.08.05.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:29 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:19 -0700
Subject: [PATCH RFC net-next v4 11/12] selftests/vsock: invoke vsock_test
 through helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-11-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add helper calls vm_vsock_test() and host_vsock_test() to invoke the
vsock_test binary. This encapsulates several items of repeat logic, such
as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 120 ++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 183647a86c8a..5e36d1068f6f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -248,6 +248,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -256,6 +257,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -263,6 +271,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {
@@ -314,28 +326,112 @@ log_guest() {
 	LOG_PREFIX=guest log $@
 }
 
+vm_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local rc
+
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			set +o pipefail
+			return $rc
+		fi
+
+		vm_wait_for_listener "${ns}" "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
+host_vsock_test() {
+	local ns=$1
+	local mode=$2
+	local cmd
+
+	if [[ "${ns}" == none ]]; then
+		cmd="${VSOCK_TEST}"
+	else
+		cmd="ip netns exec ${ns} ${VSOCK_TEST}"
+	fi
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${mode}" == client ]]; then
+		local host=$3
+		local cid=$4
+		local port=$5
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		local cid=$3
+		local port=$4
+
+		${cmd} \
+			--mode="${mode}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
 
+	return $rc
 }
 
 test_vm_server_host_client() {
+	vm_vsock_test "none" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "none" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+}
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
+test_vm_client_host_server() {
+	host_vsock_test "none" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
+test_vm_loopback() {
+	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
+	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
+}
 
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
-	return $?
 }
 
 test_vm_client_host_server() {

-- 
2.47.3


