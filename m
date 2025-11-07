Return-Path: <linux-kselftest+bounces-45035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8166AC3E04A
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE063A70E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86C127F4E7;
	Fri,  7 Nov 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYz1WX5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414F2E9EB8
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476594; cv=none; b=pTbGyxJ0KBXo1k+mez0hu+SQ4fx4KwJDB8/wLsyWgajG4c2EJu9Gj7y2NxmB43+CwvUFwT4mX/SrewjLFSUaBPG0V6l+2e9LFtv97fspBbHo5xTAcNfKXl1KfqJzBk7NHjDK6q2SXfHAl/iN7OejDx5H+6af/EhqihRnZRriMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476594; c=relaxed/simple;
	bh=Ys5kBUskDbPXQZnAqEoqIHnHJo/VOJneFvummyPz0NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRV4OOUd9FOnSAl6Ogu4mI00MHxVt0cdYZEqP37K8dnDDox+EGJqBwPH0EjnuOYwhfl8WkpC3tE/8vUBIFUtJkJcm1qfR8sMW+k5DUXb4x+hhGu+oCuQIe0peHEenwgvOExni7D5mH3UJ3qOlnmWj7F/2Q0wfYoWmNVoPFux2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYz1WX5I; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso327214b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476592; x=1763081392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St8d3RKISLkpZB5VPbgJXeIsZTPVvYqYQ1IGyhr4/ek=;
        b=GYz1WX5I1lKfO61vDYd5G1oNF35/yGUS5n24OQHoL/TEnz3df5v4/c6/tHDam45MbL
         oq/oIi/mF8tAdak/e24OganHwgmAwcMWMQxlKJrmfrxNa+VYyNPF7hJMIAOWFy/Ay7+p
         gbu00auWSFixBInWP/sxF3PwAQmfM8soHk8La2Px3GXHwRMFQdfeWaKed6zVbeyXOfdB
         ZkcYoBehN8diSfv/WvDtAlJ8gEXpNS6Pb/MTgYVapEMBieaFEeaKWs75pUpAVY9Q8Jd4
         mZEq8a4ifiqIUX7rnUynkDsgwgQkuAvvy8znvdrHReDQGs6aKKpY/k3osknrD09HJe5Z
         dsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476592; x=1763081392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=St8d3RKISLkpZB5VPbgJXeIsZTPVvYqYQ1IGyhr4/ek=;
        b=ndNBrIJ2zR+1fwmiq2D8ve41cdYAsCOUcFLKsNgdIpTPBueow9yOGxRXq5khk3SbA0
         kPACSBNEhivN3k9NzEHyjMZ7eYA1AXcLCI1OfULZMT14wOzeINIH/ze+n6IaVR8vGQ1q
         3lNSNR9yE4yuuKkC2fuL45bzZVIoI9VdD6KjguRslUnionx43E9lo9lxAnfqccmHVGsA
         yEPWUUTKq0lBmaTg03qO447VuRxwoWHY3QZJuwlKyJ3dK8dVYmnqezVDGmWELBjaPEpr
         h9BIXCxiKGszVza1pMAABv4EAllZo5dK6q5ZTNOph6Pa0ShqELspXemlRw+jnN/N//fx
         S3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR6mVs/cECtyOSxogx3JX5XkwaQR7BGwFv//ycIZD/SqP53BCgFORXYFjRz8KdF/IlVYK0lJsQUv8+IGm/8ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGI7+4FDWGbaFUGN/i2rebR3c6OkFHmB5cE4j0qLEAx67WFfy
	kWmwy5nkd591dr9DxJG5tbs7giBVdbiapTvtPFQxiWm/nGVx3argm//YBrz4zg==
X-Gm-Gg: ASbGnctMpCN6yuKN7ogHzkmEYu04HE+acMZMlA87G63LIGiOgqkPVVDB8PG3Z5cUCe0
	c+2o9HC8jBnha+mRFh/wYhqOqbFLGGY3HVV0lVBD/4euwd31XV4V9NZbs5FPrTAvjgBU9Bcr5W3
	pTR91OkTT1RavCaDB6KLDTDfINaa0XlLTwYHFODwTS+2ZmrvE42zX3Y3ODhS8si2nF69IvU5YDf
	GCCT3PhEiC9xhmjJPAZd3llY49SjYLTO2HOrhg4i4or2raZoO3c7A64Dihq51VtnWNTMoDTb3a0
	c2jEiqyPc4cSVZlNL5QtragecvWp+JXrOweLiEViLNn1jSh5kUyKJqnhfUwpmOqp5oYg/fRcwG/
	UFhSq+uqBOMDKjwoTTDV6s0ujkCFsdEKQGyRa0V1yOGw89MnpnWCVSYvkt0aMuV+xrN0/SY5obx
	iT+PZXqXPi
X-Google-Smtp-Source: AGHT+IHCKDXAldqg2joCiE35wH1SeQuDpvf5hunDzrqzuBwb8N3icQ5Tp5Ef7NQZ3yBDhicNR2g6/g==
X-Received: by 2002:aa7:88d0:0:b0:7ab:5d1b:2d18 with SMTP id d2e1a72fcca58-7b0bd992dbbmr1615280b3a.26.1762476592224;
        Thu, 06 Nov 2025 16:49:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm848318b3a.28.2025.11.06.16.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:45 -0800
Subject: [PATCH net-next v3 01/11] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-1-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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
index 8ceeb8a7894f..54bae61bf6d4 100755
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
 
 	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
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
 
 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
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


