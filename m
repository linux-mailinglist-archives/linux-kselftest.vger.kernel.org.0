Return-Path: <linux-kselftest+bounces-45163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A162EC42F20
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B45B14E7BBA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409C8225397;
	Sat,  8 Nov 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2nYmmAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA031FDA89
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617716; cv=none; b=HCbZ9pqPvHVSV9mLty8mxpQPXwg/5e7TP5zuyJSNvY3jNUn6B8BYHw9nVveGTGO4hT4nhVVsyk3liMpkchiIfpvlw+a8Oql3wIYl9hwDhEDpKGB9v3IBpiBv13eBIcqZPxlJfOs+XAlwhqmln86IggsyYhsbnSVzNkm5s+t+iDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617716; c=relaxed/simple;
	bh=KaZPXYApVo3gzuCQZxOqqdj7Oefz16QZ4HcopRgoUyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=teiOJH3q5g/v5V9dNkQ9vkDrO7bYNXijkHoL6XlfDXXvVZTpK2j7ZmSvJsShSY4t0qnOUKnUzoneLYsZSfShoa1r5F8DiDYJmDSvl+62gPb7FFy6q4X+B77S+dqzYd1upmsvBvBrFTp8mVYdrV/iSGt/V65y+ZVeEySTwWWryFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2nYmmAi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3437af844afso202627a91.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617712; x=1763222512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuFcuN4dciZC8eK8448U1zaLcwyfmGMtaq+xAMSDgTg=;
        b=W2nYmmAiA/Ru3TG/OkEGb4o7wuwewiw8M/MCOegkyCdB7IoXzVcJqZiMi0W18+3REV
         Oic4WsypsL5oZmUtDYoZOBoEYkTNo38GCLY73dOmrtSK/DPyZayF56ZEkpEsVbv6eHfX
         +gnXjpJT3di0TZFNH42qb9UUUwgcUGgyw7q8WjEDr+hkDGm497YgNJhgGGDrzgNvyfQb
         JTnGMvFVf7bFjTGyQCImuABdUZ9TaQCXkVYXjVn/qbi7vPRgunSYFkTDznkGpjeKJjRu
         pP1pa4U+mkfRe/BQ9ugslOiWzEBU4XteDFCKHmkUjTu6O25eIOcFTXUyr6SCLVghz1rm
         h7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617712; x=1763222512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KuFcuN4dciZC8eK8448U1zaLcwyfmGMtaq+xAMSDgTg=;
        b=X7xW80C/m4itBEaaPlDFjwxt6Y9sWVq6A7o4bhRPpRYM8MaPlUGwm9sZVpnPLotKEj
         8DymQlO+TerW6axmzLaLNTRYnvxEJwOguJHUh0pqhL9ekqzf1a4kpTCdsPgY1zkbUEWH
         FFS+aLbfDXX910yvCr2iGtU3ksswyaBepNo1WYk/pWpEtzViI1zLDi42HlKSb4fIwRzQ
         XTcgMexA+mkmPJzZdCkOm24/ga9K9dc2RQnfT6Sa08J0HUwwm1wg7Poa/UhyMvfOFz28
         RYkGPE21SPM6kJ+0vW3yqcgkOIAI4QqI9eHDGX1TEgtHt62ajK9qMl1KhDe76hVF2C2H
         Aerw==
X-Forwarded-Encrypted: i=1; AJvYcCXvfuDc+bCAYwiqvgxbug3Oj9wInVfFGKUT81k7Cva43VJ+wi8/JmQ9nqrdlOza+udTv4AYKwozoBbjj1UfIZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAuf+qJsweZy8vs3VRHZ9Ve5JqaK612lhCYKwX1FcrK27s4LyW
	OwJPJAjYAiBkBwabhueESGf4SfyWyUP/PDFOu0Hwx5BOAiFnyOq/OJWA
X-Gm-Gg: ASbGncuk68+QVIVivh9QFjartxAEIAJbCeysyZHDJlp9rljbon4Xx/ZCY2VNLA2JM37
	6EjLzSfa/cjiIM0dAK8Gn4v8na+kS6sSgJ68rxcYUTDPYiXM4/PWJsSK6SMiFK9UEqgnKBNDie1
	hoJ5OylUR/3dgrg//NCO5o1qA9TFjsJ9iPC15XtDXehD3g6Mwxi8FWw+jJ1VsG5ID5LXEMNGEgr
	1vYbcaA9HHt4JgRzwTsrUH36DnbEvDeW4xW7xh+UM2ZEJkwLjqOuVox9EKgbZgcI50negnDpwAT
	KWTPlxLU7LSzjwICS4NQizuugbrt4nw1mhrj4kUJ1N9vpxQHgxCl1hBQ7FjS6qmhz8aodS9XyxM
	uYVTpKd7EWWH6UqMOSu1fXZsbt89TtY0wEisipWCDKtJdbgnrnb7FxLuE3m0XQPGh36na0AgPPw
	==
X-Google-Smtp-Source: AGHT+IFfAGmgLKI4wsdRP449UjnWCEHQ8HjRd06GWOlMDD2Oh5K2oGmSXaRp75cZh2HiCmppgc3Cvw==
X-Received: by 2002:a17:90b:4a8d:b0:340:f05a:3ed1 with SMTP id 98e67ed59e1d1-3436cced91fmr3307290a91.21.1762617711672;
        Sat, 08 Nov 2025 08:01:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm5767493a91.5.2025.11.08.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:52 -0800
Subject: [PATCH net-next v4 01/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
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
Changes in v4:
- add quotes to "${redirect}" for consistency

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
index 8ceeb8a7894f..bc16b13cdbe3 100755
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
+	fi | tee -a "${LOG}" > "${redirect}"
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


