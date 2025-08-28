Return-Path: <linux-kselftest+bounces-40128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4BFB39000
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24A09806B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAA22D9E9;
	Thu, 28 Aug 2025 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/W7MEza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C622F77B;
	Thu, 28 Aug 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341107; cv=none; b=mUq/ILgDXAXZgcpiBIHCrQ4hGfnboOMk2FU/tqES7BqiKcrHe7yn9nfGj7Ubu+dBxWS2lD5l2ReMmDp3HsvUKpP0f2w9vI6pgmFc/XCXfJAQTKhl/y/fWIciHB0nnAPjcC58nUFBCXe49TupQKIgXC49sl0r+c6x6Z+WPjuzWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341107; c=relaxed/simple;
	bh=EcIbGeQZlwbG2n3LwrGpP4mEJH5ftJ79PCsbYjs89dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6n++z5D4KJIxJ9QoOeY2tbJEdbN0klhLW/jsQJAjxSWiFers9bA+HAIys9p95AJmwYezUypJQ2QWpHot9T3P1ZBFf1swfPAbFQzHo6R9/x69pCTgl7GFXNqEWNxHWfAs0qgCOu9zS43anLN1Jun+FhzZP8JJ1HbN5I9Thv5OnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/W7MEza; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771e4378263so372531b3a.0;
        Wed, 27 Aug 2025 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341104; x=1756945904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=m/W7MEzaKj/lLGAgthvRkn3hqYhqvXL2OnK2CsfuvT6TzE7vyXuXFA/1gjK7wNhIHg
         db9vhSLTIdk7AnBvxz78umSV+aAi2DxR1Ox4hF6DIKQgrYS1DVOuDxjgahdOdQ7WaCk7
         s03frKjhmUe+DcppQRSu1IE51+Z43usO7lRF4rdp4PT8bX2G7WTH0xoqLmAICcPtzSmJ
         Fq4/e1iOtaXZ8yHDUUdIa02GqHdkult5SHNnBMnSR86g6hQsFwsxbV7GSKiT+mZujyVy
         0GooIz+/86hX1tqXJhtQ9VfCGEPlLw3XJy7i0+74YOgGHxo1adLAG1Xl5NKWG5XM0ATp
         96Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341104; x=1756945904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=jEZFovwOu03xRc0npXwIyp3vrV0TotXm4SFZphdxic6T3o4hvmHbMECj7PftCXrCHF
         ie0LZbNEznbA+4f0PKiZOEgTUnL7zeKjthf7Ix3cIGBp7j4Idcxd9z8wmEd0kA6QxGTN
         3v4+hDadi3LlbhPEJFuKqVTCf2m0bKKMIzrwDRLZolXa58VtDPwTJrxETLo0Srtv+kqS
         AoBRmxZiXYoa4Tx8MCWuTaVlIyXpjGv4+kva5xFV6mvJ5uUir/6CNCjRznaNY2H81elJ
         obnKJtdQ11iWN9Hkd4/aaPsbwVMNFBZnjma3Z7N/FTeAfn5dKCWDxP/tqHS6uhFMGlyi
         vdsw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Bvm/yVIA33+d/FfSoNVQVnlo3oflJqbu0CK3Js01jho3aNOs6tRFuaTMsJe9CdBckaKkEekarVJ6kl45mSkH@vger.kernel.org, AJvYcCV+iy/cJfXMnp9loLETEcUhn43tCieU5pxCVOJXs7mMOHafdDDtP8xrCeSGVhQQymeQ5QS9auexvE/HELxQ@vger.kernel.org, AJvYcCV3/bGd4mMQrkHC3VmilZuKx9gmTTYDTndWl+VBUlABZv2SYA75jxF0KaSlIawOjYjGn1I=@vger.kernel.org, AJvYcCWPabSTL9jKJEtsxJhKVTplzXKuRNT/cpyQSXse+kECxSlOAOxgFXou9s08S5za757+HsbWaqly@vger.kernel.org, AJvYcCWeeaot0ZfvZ9uFioFFA3hEUmyHiDFMntxJ0YpNv5uROAHs7cGvRU+HvdivgXJ7xoJb/QfOmwC3A2mGikqb@vger.kernel.org
X-Gm-Message-State: AOJu0YyQn214Wcvop82+2xSbf4WwXT1wToIsKHE/u7TtC1f8MR6bfcXn
	S19qyDM6WFtE9JNKTOM2eksE1YLRe88aGDLI4B2LKM8PhLc8SKx48rxA
X-Gm-Gg: ASbGnctF4a5WO1o9ptvGIBMsgYcpt24GFPqdJFhZ5HqgSVzJ6B+KqkzD8jBmOcU2KVz
	wz+kBA3cELmNxqvNvg1NawyR33P75dcVEQJTE5DKjwvJXSzgnOzqNp4mh2DvDJleDIo1NKEZhvT
	s/mzXRLjqdyitpK6s8M8frrJdmjxhXwg0XLKQ8mMlSEVt1S+643cRtewJKZjP6dlX0qeVaHZTLF
	2CSjPz652biR8ci1pTbj6xXKnQLG9nl0+sIj0go3CUaPmDyKps2cUPSUlhWpkYdyQRCVbNf+/8G
	6ewGyoWX0Oal8RtVszh3BIwYcuUODlZ312aH4NZM9lU0+HOka2C5AEnQliJdiLMgisYWCGV5ZHy
	O3JlqwsE2MJIyDS4nLFgl8wRTbOiy1wo=
X-Google-Smtp-Source: AGHT+IEJbr3HMmIrqKif6m9C2MhdHBoHOAYBHt+zVuuv9LxC3u4ctZQ3MSl9h0oZOwFhJ8SGLu9S4g==
X-Received: by 2002:a05:6a00:b52:b0:772:114c:bcbb with SMTP id d2e1a72fcca58-772114cc0d7mr3414779b3a.4.1756341104472;
        Wed, 27 Aug 2025 17:31:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040010834sm14170599b3a.46.2025.08.27.17.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:43 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:35 -0700
Subject: [PATCH net-next v5 7/9] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-7-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
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


