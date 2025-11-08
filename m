Return-Path: <linux-kselftest+bounces-45170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A437FC42F77
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AC63B59D7
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7C25A2DA;
	Sat,  8 Nov 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzlaOoEF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61600244660
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617721; cv=none; b=FQwU5fvOMSvEFbVRfXtHPO2tXT0ga8HAv84mq1/0KiSn0a41yeNHwOilGMt1BPLapTgp2LSPjU6Rt0ZFaC5j+uaYO7kXtJJrp7sqeDnDPnuUU9Eu1PwsBqwo2RVskq9kw2qm3r68Q3XxxYuLeYqeUK/vekodZFjsnnIyNTGDh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617721; c=relaxed/simple;
	bh=F9FsVtLt7rSsC+SslDdvx9EYIxO2ErB70trA08f7qAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr8Arw5/DZdgDG9mcrcfmO92zT61Dg4bqCejDeLqZn0c6vS1RPD2hGIJaaZ0bBf6ijAqxLMR0lKdMdWG9asTmunrLOrJPXFyIJK+QO4d8GoMEBOZnCz4eztdombV3MQRVbPocIfAaRvX1zwJQiRHsQ3+iPKdHVxZK/ca2LLVXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzlaOoEF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b991ddb06a9so1075009a12.3
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617719; x=1763222519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=EzlaOoEFGnQtWtAUK6QRETa5cr68VJ9uGYfHind4UB0drUaox0wHjkivoFsFuJenFp
         9AICGVsBtIUsaRZn9cOd9l8Anaa89KxldxiYzWAaeSgnzFTwSJiM7zY5TpLGnxwSSWdn
         m5dwQgysbz2CiywgJ9frT99wavGveNEp/y3ZqqXj9gWrS944EZrDz5FaendwuDI6xtii
         tQHk7NP9wIoBchac261RXLICQjcRAmJfSxO25HIpUxR9ZUT+e6SQSqDXKC83HdMljk21
         6gqIBElBgphRHF1xug/9LOMPNIcvqJ1cVZM9NShpvs9y4zhmP1Ni5H6uX2Ixx4MlhxlG
         0tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617719; x=1763222519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=MkKNbffb1b8QUmk57GJdv6y4Le/dstnPVakLrt/gwCIeJx3RJk3QLfXL+Wv8/RLCYk
         NczGpGVt+aK38LkjeTr9qID8XEB3gM0orakemW34zlyJ9XRcvp7V8Nr1TOTP4iY4QX3Y
         e6R3WhnYhFs5hoJOCsgGx4mqMZpPK/k2JcH21Me89xtPhWx/Hi2zU3u0LHYX0qqohHZE
         UdNLH6QccvPk4va5d4BVSSvAvrCbZS+/k88qYslG8udSY68+OTjXJTBPrbBqOEACzdUM
         lGU89Goe1tYRBIMgByAm+XtRekLfCtHzbNaP1mjClakt0V8NUzm9IzoFae53E/iVLQ3W
         LyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrnpUH0qkx6oqmFzUZJeyz1oCHi82HfbFA11XML3vNxcdGGFY5qsQpYZtwcJk7aZuYVd5z2a3zEcP/CFxWfKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn12jBoRrdK2o2HwDQsDyFWlFgikhRigWLkn/xShF+bWs4xZC0
	jKKFyc9YtLBzKpya/jLT2RdWnuiEsuA4jYO5cy4E2K1ximJRYU/0LCcI
X-Gm-Gg: ASbGncul6r8n027KPk9faHTTng4SSIKfoBPrIgLOU2JaisXJc9eTtoDRdGliWAOzQbA
	S+B6de6G6PD/KPcO9v8jZJ7HjKf95p+NC9rEPJyEKFVlOB0TB2oF3TK/hD8yvnB5E+7w3wOwR2C
	ac9+w6cE3/b7cj62bBIw8eAYsq109o0K2F6w0dWU+FMvT83w0KBiPRCT+u1/7epnEi9VgUEXCG5
	32440DI3INgIupiRZGdsuefSAvxFm5LsaZABk2gfHDtfrPpFWbFrvDZeJe58iDOdMP70yBMFbp8
	LhzaNM1ZVUBcH3d9Q5U3aHCeSaNoLV67jy2P4AVZpfkdIdLBMTxk+Y1pLsUxUWHOr3CfwP4kexe
	3VA/99Iz5/1X7XbbdQaEKUaMr5iuVC+O+rpuBIaEEGkz0r/hw6RtGRJ3TUjKNLuwijqHkPjeU9m
	kJUXaOgKc=
X-Google-Smtp-Source: AGHT+IHomY4YyVD8KS6qtG7MNKX+4x/II1DuyBNIdKkYHuI5hzRRInd+7+JdQ5vyk3YIsOnkaHnafw==
X-Received: by 2002:a17:902:ebc1:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-297e5663a67mr35112645ad.27.1762617718558;
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm93090585ad.92.2025.11.08.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:59 -0800
Subject: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- fix botched rebase
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 2dd9bbb8c4a9..a1c2969c44b6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -461,7 +463,44 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
-run_test() {
+shared_vm_test() {
+	local tname
+
+	tname="${1}"
+
+	for testname in "${USE_SHARED_VM[@]}"; do
+		if [[ "${tname}" == "${testname}" ]]; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+shared_vm_tests_requested() {
+	for arg in "$@"; do
+		if shared_vm_test "${arg}"; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+run_shared_vm_tests() {
+	local arg
+
+	for arg in "$@"; do
+		if ! shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		run_shared_vm_test "${arg}"
+		check_result "$?" "${arg}"
+	done
+}
+
+run_shared_vm_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -537,23 +576,21 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-pidfile="$(create_pidfile)"
-vm_start "${pidfile}"
-vm_wait_for_ssh
-log_host "VM booted up"
-
 cnt_pass=0
 cnt_fail=0
 cnt_skip=0
 cnt_total=0
-for arg in "${ARGS[@]}"; do
-	run_test "${arg}"
-	rc=$?
-	check_result "${rc}" "${arg}"
-done
 
-terminate_pidfiles "${pidfile}"
+if shared_vm_tests_requested "${ARGS[@]}"; then
+	log_host "Booting up VM"
+	pidfile="$(create_pidfile)"
+	vm_start "${pidfile}"
+	vm_wait_for_ssh
+	log_host "VM booted up"
+
+	run_shared_vm_tests "${ARGS[@]}"
+	terminate_pidfiles "${pidfile}"
+fi
 
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"

-- 
2.47.3


