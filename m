Return-Path: <linux-kselftest+bounces-44766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE01C3346A
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 193A64EEE34
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F02348462;
	Tue,  4 Nov 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx/F4HeD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B8346FDC
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295959; cv=none; b=WVXS0v/lHfC6X6Erepy9prJmC+koiM/6a03TfTweau4w/yYYrwRJYIbbTIO8FoAXWwJDhTVjlqehBNvP+5ku/12Dv7wJea00qRiVvO2iBdzOG4L/UtEdyG0bQPRk6PFCEH3fMUXtaPilQuaxDVyp1IlbNFJEJZxfDdPfbaVufKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295959; c=relaxed/simple;
	bh=6JthngltpkcWftejwxT4QQ+XaYtKnwnkggaq1rsEx0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRPAV70M23Cdl9KChS5MGpTJZva0rQXS8TCW1dX5ee+0AxJpVrIXW05J4P3LLr1IL1aZpgDTLt1t9QGZVs5uIgiOgsnfB2MympNeTfZWpspCpONW2i7VbNFOekN0P4/lIIl3hqKfrsRnV9OvpMz5GhxTL7gIdIyoh4UO0Cmhlzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx/F4HeD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso750141a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295957; x=1762900757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDsH9kNNXBt4JKt5mitfCe2Rq8PZuvGot+36QHyMJvw=;
        b=Tx/F4HeDm+BFKSyBmuLkmH5BodI95/gSDjsipVOfv/1NFukSwECQX8AkHkfoW84fUv
         M8mflcwUkBtSASZAh/IsaJnrZlhTJbDgsEF+NHTcLtKPKH0R3ow7J6p5ucBl2EEOQCbQ
         xs4lmoD1VuuG3yvLAsm2ef9ELx2oc5RPWHEe80LmGPsM8rXcslXx8WBMvXbaG7gJ0ZGf
         PSpjxCY9Tkitb7ShVKCgiimy4bzjxUiJr+oomoAdaCNhOa8ocNnsLcXgSJeyflhxca36
         x0rTLFYaiw6augijMlOWnaph9Clpdirpu3dexf/xi9laVdfpLeBG7UnzOR69znv5ocLt
         wK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295957; x=1762900757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDsH9kNNXBt4JKt5mitfCe2Rq8PZuvGot+36QHyMJvw=;
        b=GHHGlk6CW86Qbr3Tvssbnsp1WA8gHHPgi/EQar++PnNUiKidRTXJ7Tg63M8uay5HqL
         kJ24g+2b2cRJn3xps5XQ7oEB8Su6ssUSnSZyXbRmvZ2jMIz6eZKZJvLYC6IDh4Mut71l
         /dKGIqx/U64f8AHQCD0CxW4QaECB32rRLGidnWTcAZcVQNUvHUDAELSW1mhXwiiLZqt1
         Z0pnsTIfK7HoBUMR72jlU7acmGbvq9r5YORf5CnuXi3Wg581oegPoGpXPTb5lBKq6cZw
         CMc+zuULoo9fmbi96DaogaDXD2NfmyUaF653YJ7CjWtzoFnj2TL7aDgQMuw6OrvetKQg
         gPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM4iMF9jb8SICuCx1BZYlQdD4QOXEN+uL9tbzqavuuEvUpBTGXtVYD7gODM3FD3QIOL5q7Lmtpx8S9MyFoIT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtitY7X8kqP1vjzHvz+toefAhX060YvKYIZTYzWDd1D5TIIFb
	QtOmSHT5kEC2ttAp5/hD/dwb27zV3KZtrOWdbX98vBWguU1AcKDRoURf
X-Gm-Gg: ASbGncsBU/MEF0rRdhy4QopZmug8FlFTzPXuYhqWQNcngNEHuZZ4RLMy7VFl5f1Eadx
	k4vnrlRV/Ed1OQFDIQNjyUfYk0yhed7mK/meG5C9cNU1IWPNNYe0E1/rFX9nbI/8pDFY3rqMU18
	4iUjD/WYzQrvw97cwzLuCxZpy7wxSd0cAS2IATm+dbF5AoQp5MCg6Z0OWTiHLR1XB+RX0DQjVDr
	p6LZMc4aihrIvEACycediGN1RAjbGZSl4PSHmUbe/HPYT9xkI03Z5AQFxHBpDOI09ElMVtSgCFp
	0G6llzpFhAagk2Tp5g3HWIY3u4BTZSBKwG72w3B+9PzO+xX8ooee+RmhLvInT3+tXUmzbZHS15W
	SYXULkQyHyar0tzkPZl5WZ9ZOvrZxiIi4JWgFzPzh+P3uPjJ+0GSYJvkOJVVgo14u7hKhxzuTLw
	==
X-Google-Smtp-Source: AGHT+IGmcX9KQhrwLWD8vDeS4NjjuNE+rklNtcRnYnJAg/yp6Cd7qau2TSc8kt5ZpkI4HpwFXvMX9w==
X-Received: by 2002:a17:90b:3e4e:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-341a6db60ebmr937766a91.23.1762295956648;
        Tue, 04 Nov 2025 14:39:16 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68e4149sm638270a91.16.2025.11.04.14.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:16 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:58 -0800
Subject: [PATCH net-next v2 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4ce93cef32e9..678c19e089a2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -443,7 +445,44 @@ test_vm_loopback() {
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
+		check_result $?
+	done
+}
+
+run_shared_vm_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -517,23 +556,21 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
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
-	check_result ${rc}
-done
 
-terminate_pidfiles "${pidfile}"
+if shared_vm_tests_requested "${ARGS[@]}"; then
+	log_host "Booting up VM"
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
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


