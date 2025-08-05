Return-Path: <linux-kselftest+bounces-38338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB07DB1BC1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16774185400
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8CD2BE7AF;
	Tue,  5 Aug 2025 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGXTktsu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCF25A347;
	Tue,  5 Aug 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430570; cv=none; b=uFBB8HdXUbSJMKlpkWDOGGo9I43bzFnYYmysqPUZho4rDc9MPY232KJumSjIZcoMCeUGoKoN6VNlIwIzAjv35JuTwLqmcoIEylKr0BmekW5qOb68S99zkPpXszaI23RLUPuOA+oBig0KogNmV9aD4zkfjCvc7hvQ15IQ/80h9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430570; c=relaxed/simple;
	bh=EcIbGeQZlwbG2n3LwrGpP4mEJH5ftJ79PCsbYjs89dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qz9JgmNwAP6wp9thaKO3KAimu/zcO3QK6q3dygt22vL2qx1UMjz5TuCZ9jKDI6rt+lr/DouigYzth+f1iyvV0K9JcrpApFWZ7y9m2ye3JZNAdpQ1Qt67dTI5YONCl7/VIQ3R7N3BhSjy2trG56y3pBB3MCSlgQ3YD83S9FZY2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGXTktsu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bde897110so3926218b3a.3;
        Tue, 05 Aug 2025 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430569; x=1755035369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=VGXTktsu5JXSPJKCuquYy1l5y0tQs5n2ZmnTNXard82fvw5wKFWryuSpJGbkEmIkOD
         Z8mlZDK+A7U6L/Wje8crULyn8f1kfd0zlcj0J+rjt96F3KCTqL+oeA03YoHGB4PjAvBq
         WVcMU0DTEiUpmo2AQDsTaJ/Gb2GVNJO4b5mCxu76TUYGs0p4qUmTxvdBIV6oR4qexn9R
         E2FNtv6M2gilNKFXpURcprYDRBtSqBwK+Ysy5pisCE11yqpB7tTE9NUjzM5GGi8ma8kv
         SaYERdFh5iE9W2aedZA8928cZycXWpBcgAVmaGt3Kze1JYHO0tx5hrDX8ycIXlgC8+/4
         U5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430569; x=1755035369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=CFKG630MfrSGpqjc2CaiDaQFU0Fz2FLV/LEYEf8XFt9ADraBRCYAqCprKS9RIcmFUk
         TDpTpZQ9tiVi4VT8tGR81tlEab+MnO+3KP73OLJGGBfjpFd0eRsjLRLiHZ5XROiZbZ9z
         YaOU619ZLA4ksYWpR7ky+dS6MDHvMWg6iOWnCikDahvw1JvP1POTRu9PK+w81nMPDZnr
         FLgTZunoCk+dcXsE6DywQ63sk3fvU+2OH9NGnSiBf3oKaG1c9d2bDaNNPqwrGmg3P3SU
         gpjd9aV75SZfiyF8RKYewwS/3uh9OVqmr09HIv02/m4MDIodpYDjtZwmIET84dqZbVfD
         rX0A==
X-Forwarded-Encrypted: i=1; AJvYcCUKQFJiGOz02Y7Gef/strIqCjFVdpgB6y54TFaw95PhlONvIveCloypDwrBFHnY3ktJ0OCYmXQcpkasgfj9@vger.kernel.org, AJvYcCV5OXigWaM+YMtzoXU5CnCo+zPTL6gph4TEopUXEFRZzRHQK8jXarEbfe8Xyf9EzPGM/ST8CIkbErpPLA7M@vger.kernel.org, AJvYcCVPpJvvs1dkA0VlaUPbEPOV2Gq89d6wjqgm52KzJsGLQfjF34f/rnj6h9AtfrNWW42d2oC5DQc4qVP17PY92bFR@vger.kernel.org, AJvYcCVjkRTG76/4bjzgge40dIzPZ9/YzDzxagaBa6FAQbLYiz4OU9eH8qhW92QN+RH2yA6MzZo=@vger.kernel.org, AJvYcCWKeJX+5Xg88eMXSjLVB8FfH/tERS+ma6HbjAFDizB4gMZNcZub3Fx1Y2MJDdkaAhUqDpp95RJM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Yfdf4HBt75u2gShnWngteN+vuejaW/w9Ntggs6OtPb9O8siq
	4QQnglrC3vfXSB/HjiZHUcZ7MR6TtQ0Qkbiloh8AwHHLFwnLvRfmYLPd
X-Gm-Gg: ASbGncvVHmx2DbUdJ75GqSayeoMVA9VzAy2xZ6a/RQVXP7cNs96pPf9mjOmEHg5Z9wM
	t1XKu51N1ybKE5C/2nUL6fPbf9/Lo5+1To0ZvJnZ24oCaOYHVGwM15GLvElwQczd33xxfw7Irm3
	+B/YoxEd0es/PqRKYQ9gZbG0qmfNrnZGNT0u/sgZHnyGid9AzYXdCGVQkekYucwnBSxxULLT11y
	15zbRoBWL584t+PnUWmZ5YpgaXIxIS8Y3Se1bx+g0L17x37vwOQd+Tp+e4uaHNxxHl773x6dvH1
	b2vre+KGbB2Y2DPjryweUUOWGOnocMQroxq90OW73w5Pm0yOcOu+xXuKlPhpLyqJ5gc2nbanPNX
	EpEHEX64E3D+p5AQemI0=
X-Google-Smtp-Source: AGHT+IHDiccVFKt2foX9cebWCbcaO5d4WSAdQ7P+8EpIETJhLNYp3VcDpYhvm/jSZPHzCAGnogLnzA==
X-Received: by 2002:a05:6a20:1591:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240330fa38fmr182206637.30.1754430568726;
        Tue, 05 Aug 2025 14:49:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfc0a2asm13891503b3a.70.2025.08.05.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:28 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:18 -0700
Subject: [PATCH RFC net-next v4 10/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-10-059ec51ab111@meta.com>
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

Improve logging by adding configurable log levels. Additionally, improve
usability of logging functions. Remove the test name prefix from logging
functions so that logging calls can be made deeper into the call stack
without passing down the test name or setting some global. Teach log
function to accept a LOG_PREFIX variable to avoid unnecessary argument
shifting.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 75 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..183647a86c8a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -51,7 +51,12 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
-VERBOSE=0
+readonly LOG_LEVEL_DEBUG=0
+readonly LOG_LEVEL_INFO=1
+readonly LOG_LEVEL_WARN=2
+readonly LOG_LEVEL_ERROR=3
+
+VERBOSE="${LOG_LEVEL_WARN}"
 
 usage() {
 	local name
@@ -196,7 +201,7 @@ vm_start() {
 
 	qemu=$(command -v "${QEMU}")
 
-	if [[ "${VERBOSE}" -eq 1 ]]; then
+	if [[ ${VERBOSE} -le ${LOG_LEVEL_DEBUG} ]]; then
 		verbose_opt="--verbose"
 		logfile=/dev/stdout
 	fi
@@ -271,60 +276,56 @@ EOF
 
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
-	if [[ ${VERBOSE} -eq 0 ]]; then
+	if [[ ${VERBOSE} -gt ${LOG_LEVEL_INFO} ]]; then
 		redirect=/dev/null
 	else
 		redirect=/dev/stdout
 	fi
 
+	prefix="${LOG_PREFIX:-}"
+
 	if [[ "$#" -eq 0 ]]; then
-		__log_stdin | tee -a "${LOG}" > ${redirect}
+		if [[ -n "${prefix}" ]]; then
+			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
+		else
+			cat
+		fi
 	else
-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
-	fi
+		if [[ -n "${prefix}" ]]; then
+			echo "${prefix}: " "$@"
+		else
+			echo "$@"
+		fi
+	fi | tee -a "${LOG}" > ${redirect}
 }
 
-log_setup() {
-	log "setup" "$@"
+log_host() {
+	LOG_PREFIX=host log $@
 }
 
-log_host() {
-	local testname=$1
+log_guest() {
+	LOG_PREFIX=guest log $@
+}
 
-	shift
-	log "test:${testname}:host" "$@"
 }
 
-log_guest() {
-	local testname=$1
 
-	shift
-	log "test:${testname}:guest" "$@"
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
 
@@ -332,18 +333,17 @@ test_vm_server_host_client() {
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
 
@@ -351,19 +351,18 @@ test_vm_client_host_server() {
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
 
@@ -371,7 +370,7 @@ test_vm_loopback() {
 		--mode=client \
 		--control-host="127.0.0.1" \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}"
+		--peer-cid=1 2>&1 | log_guest
 
 	return $?
 }
@@ -429,7 +428,7 @@ QEMU="qemu-system-$(uname -m)"
 while getopts :hvsq:b o
 do
 	case $o in
-	v) VERBOSE=1;;
+	v) VERBOSE=$(( VERBOSE - 1 ));;
 	b) BUILD=1;;
 	q) QEMU=$OPTARG;;
 	h|*) usage;;
@@ -452,10 +451,10 @@ handle_build
 
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


