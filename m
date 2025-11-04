Return-Path: <linux-kselftest+bounces-44759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04171C33401
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839BC4EBC0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C9315761;
	Tue,  4 Nov 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq+IaYBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61D31329D
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295952; cv=none; b=lTcatgOLDB5Cg+QOL3VncaKloLf//ylefS6/1xMliCeFcy7WjEHasqjMvAWQK1blL4pz9sETurY4si+R44SHcS+YqEui0UQLgeCHftcWXH6uSYWbln8ZAkP/a1uSYFdfy9WFrdUzZmOd62n9Pbp5SFd+/fEr3X7fSKR6gFSkcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295952; c=relaxed/simple;
	bh=d0lXSaAPV1hSCbv4riJfsbPBoHPeUelaGN5Zg0VyKzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls/fcbbdXraLaInT+yNtNkWdy2+mr+taH5D5aetl6eRCTj9SEkYOSfOpIP9z4dxijieMdTEwCJ41yPCWs3Xpsy3+PPQZt3RXk+SX9850vG+8H2QMcF7uIInl1d+tp4lJSZqkBZa5fskEOLaEIq0FmmaeKmqRZyOrk1GO2+ZONE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq+IaYBH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2947d345949so54346975ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295950; x=1762900750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SCnFxkAKvo4bMRASv7XIHpGepGtL4M3i1ZyZegDajE=;
        b=Tq+IaYBH1ZvjquGGM6pV2Uxv+rsFwYW4p2GqoKwwitOgI+xMa1/O2vLTYJ6XT8/s1V
         HFOkXieNN7z7q9GWlRxw07kPuDTYblPzlQdpE5w7G7yB8cCaQBQxLnRVOAx3x6GWOf5R
         HbeeeQ4IJNAD+X28gpbMphlI/EJCEoxuClVhp4EA11oEaVghVV+dQNgQwt8WKbTljgoi
         jMyNqZtwqgPpRmj2qXF3jhh4+Vbo/N5K8Qmx+EpEtrdX2kxbKI+KnPjCuw5PnlSsxXd5
         MXdAitSt4wC4u4mJYsmiSb4ytUEeujIRXAjUrZqUZhV58Vb/q6AAe4YzwuBdTXpDrSeT
         z/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295950; x=1762900750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SCnFxkAKvo4bMRASv7XIHpGepGtL4M3i1ZyZegDajE=;
        b=M/yjs12GbLkLRfh31AfQDUXECfmKmToCiu86er90i4IqekhzXOoRPscYe2aFELO4ND
         d0RjmiqWjmrVzWqcrmQTd79UD74g+a6EW4SXwkSSmIQCMuNv+Eb026sbe34/taraGACY
         GG5Z/fqZpsa6X4MJk4V0xVA5e9x5d6fTo27yAktKvM8QFE8TSfo3tzgyah+EiOjt9d5g
         XEF4loXcJlZKaLw7WsiAmZ2/mY8Y/uMqP9ibMmXGSBUEY1qnLAbW/h6egaEyQ7mu9XsZ
         pXXd6pu8QC1rggNMkcR0YxGtj873tLnadwgi/o4H/KR6pqRGyeM0wfpIX/iksTX9eweZ
         1B/A==
X-Forwarded-Encrypted: i=1; AJvYcCUw/8nA0hwtzO3m6o2y7I8eT4I46w26dL1hztyzMQ7WQxm5LESb92x4Zx8I0LaNxltimIkYB5XbEls9ZB5Qqa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkukRHn53eQRjLDOIkpqsvGo898SUzLTtRGLn7v3PcR21ILkb
	JJxaQKd7dCCiKCdUsUjZ2nHODOTeGZUfU/d8NDsgks5WTAxI0XJ1DVVF
X-Gm-Gg: ASbGncsdHhgMKAayAXNWmkEQr5xtvzuv3ZR552nHoIJ3hmP9c19axfIgPfGVqy2a+HE
	5QbZQNrjmheET0a3ek0CN2ICRo7z0ny9G8ve6gdODdAKHmacOVB4c7ZnYs65NXrFKFJh0jp89+h
	LFUPUSOBlr4CDc9nr7oCuQa9TxNiIIbjn6uPdE1CAGpF84iA3B7hzrV13ffQl8FPM8mVQSpnUhk
	Q0gkjRimOyzOGChXRu4r71RMHLQE0Knvx8L9M7n0filQ/J3ABhkXPRVeqhuJLS1HVNzV3QlHtlC
	M/iuNUiMybX5YuiukfT3wekpVV7l9Wpj17t4crs00HbuwE0OVrv9OlypLPycs+G+6bv15o9FkOp
	DdCGJfGEZKhvfTydpWksFPZnBANPAtJL9Y9tjT01FXWzF/Ce7k5NQvKtviar40X5gGeupXZ+9
X-Google-Smtp-Source: AGHT+IFj0ralhxCw9gtXMNxyl9Kpp7b0xZeMtfhdxLBXWpHqRS7iX83xZgLhRxoK9y2BWDEiCj0m4A==
X-Received: by 2002:a17:902:d2c6:b0:295:7453:b58b with SMTP id d9443c01a7336-2962adb29cdmr12165085ad.4.1762295950273;
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a609c8sm38264015ad.92.2025.11.04.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:51 -0800
Subject: [PATCH net-next v2 01/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-1-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Improve usability of logging functions. Remove the test name prefix from
logging functions so that logging calls can be made deeper into the call
stack without passing down the test name or setting some global. Teach
log function to accept a LOG_PREFIX variable to avoid unnecessary
argument shifting.

Remove log_setup() and instead use log_host(). The host/guest prefixes
are useful to show whether a failure happened on the guest or host side,
but "setup" doesn't really give additional useful information. Since all
log_setup() calls happen on the host, lets just use log_host() instead.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- add quotes around $@ in log_{host,guest} (Simon)
- remove unnecessary cat for piping into awk (Simon)

Changes from previous series:
- do not use log levels, keep as on/off switch, after revising the other
  patch series the levels became unnecessary.
---
 tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..1715594cc783 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -271,60 +271,51 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
-}
-
-__log_stdin() {
-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
-}
 
-__log_args() {
-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
 }
 
 log() {
-	local prefix="$1"
+	local redirect
+	local prefix
 
-	shift
-	local redirect=
 	if [[ ${VERBOSE} -eq 0 ]]; then
 		redirect=/dev/null
 	else
 		redirect=/dev/stdout
 	fi
 
+	prefix="${LOG_PREFIX:-}"
+
 	if [[ "$#" -eq 0 ]]; then
-		__log_stdin | tee -a "${LOG}" > ${redirect}
+		if [[ -n "${prefix}" ]]; then
+			awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
+		else
+			cat
+		fi
 	else
-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
-	fi
-}
-
-log_setup() {
-	log "setup" "$@"
+		if [[ -n "${prefix}" ]]; then
+			echo "${prefix}: " "$@"
+		else
+			echo "$@"
+		fi
+	fi | tee -a "${LOG}" > ${redirect}
 }
 
 log_host() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:host" "$@"
+	LOG_PREFIX=host log "$@"
 }
 
 log_guest() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:guest" "$@"
+	LOG_PREFIX=guest log "$@"
 }
 
 test_vm_server_host_client() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${TEST_GUEST_PORT}" \
 		--peer-cid=2 \
-		2>&1 | log_guest "${testname}" &
+		2>&1 | log_guest &
 
 	vm_wait_for_listener "${TEST_GUEST_PORT}"
 
@@ -332,18 +323,17 @@ test_vm_server_host_client() {
 		--mode=client \
 		--control-host=127.0.0.1 \
 		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
 	return $?
 }
 
 test_vm_client_host_server() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	${VSOCK_TEST} \
 		--mode "server" \
 		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
 
 	host_wait_for_listener
 
@@ -351,19 +341,18 @@ test_vm_client_host_server() {
 		--mode=client \
 		--control-host=10.0.2.2 \
 		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
 
 	return $?
 }
 
 test_vm_loopback() {
-	local testname="${FUNCNAME[0]#test_}"
 	local port=60000 # non-forwarded local port
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}" &
+		--peer-cid=1 2>&1 | log_guest &
 
 	vm_wait_for_listener "${port}"
 
@@ -371,7 +360,7 @@ test_vm_loopback() {
 		--mode=client \
 		--control-host="127.0.0.1" \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}"
+		--peer-cid=1 2>&1 | log_guest
 
 	return $?
 }
@@ -399,25 +388,25 @@ run_test() {
 
 	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
+		echo "FAIL: kernel oops detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
+		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
+		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
+		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
@@ -452,10 +441,10 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_setup "Booting up VM"
+log_host "Booting up VM"
 vm_start
 vm_wait_for_ssh
-log_setup "VM booted up"
+log_host "VM booted up"
 
 cnt_pass=0
 cnt_fail=0

-- 
2.47.3


