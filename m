Return-Path: <linux-kselftest+bounces-43955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A638C02F6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B019A7E32
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46C8350295;
	Thu, 23 Oct 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3mXFKU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205234DB61
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244106; cv=none; b=jiEqxaUwArXCLGzXB+VbufySPD4qpw1fPPUPZEP4M6iBWF6eycjF4LF4mBBu7rUYhpQNR5e+4lSvclcziG0x/99ALAhMUDVTWoWWgTidBrJmZCgKFWaqamdNu0bKk5rwkWj1eEQH2OyrIX/hY4sCR5g9Xt2ftrF32wF/U34BAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244106; c=relaxed/simple;
	bh=5F5v73spaO6g7IkcyDH3GDS87tLNHAMWY+Aqa2TXZbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8DBvtXa5ACngr2R1M6rgCrgdhO32/m1tT/n0itxcniPToX2ugaZE1+aKmUu+2nC+2fgoKnFwOV5t9B6zp1fuSsXs1frCXwhXuOxBTDRPA4dgLkGt3eL/mqR6HLPxQzl1nlgCFM/Zc/NPrxRE/ivmxBZ3q00LsBnN8B6r+Ry0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3mXFKU1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1240402a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244095; x=1761848895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edpWGMd9VbWpBkt/1Y+NJ91tcxlgSe0i7beuNiNUjc4=;
        b=K3mXFKU1z8DIYxbpDKyktLYsC/hgT6Bvk5OrT5VySiqYV7V/79Ov1oDZSzNH1b62mG
         Hxp6rJy1jAY/7hVXibbWe1UFc/MvRkM1k5mHCYGDpC74WNKWwV8eYaYz3lr0kzE6p1tG
         DFepQjfMGH/K54xapxNktsHKS7Tm2lEsRW9Aha+yMUawDSqmMb7betN2QVpmoADlRqSI
         JEflOzK/A2WqCv1v+JKeS0596yhIqZ4kwVsK3s4qs0V3VXWyk3aNIqxl5oWHZjV44Q7f
         iiqBn56AagoeQHjtFsunyKzWTDc7qL4d2EZJzu/ytv9Zlvr9lKBhjDUG2CuwkTa58obc
         F89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244095; x=1761848895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edpWGMd9VbWpBkt/1Y+NJ91tcxlgSe0i7beuNiNUjc4=;
        b=QzK8NMDoI0/fj/8EZ7A/QsDkcAGaGMtz/Y4wK3Ib+TgZh6liwKtckcBOoYEQUQOhBq
         247tJlZ4Euu69uiZEdcg6ySLGbc8rajqjdpTa4GZ8IVASuh/SNDwczStD6ys24wzoqLn
         SQpDIM5PdTaYnOfRKGqlYGMFAuqTmIrdqHfnI9Od0sV41fgp3rmrNMyZwzG57rzNU3Sz
         q222gQpvfoqHntom97o4MmM/AsvACKqHibzgrD54O6bt938q5REvApNZ93FQvCkcxAGS
         UDy+h3TwLNmW+xYkuIXeLRXfvHGcielPGzf/q8m4Ub1KJWsZN6Q34smm3MMUG+I8GsqK
         X+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXatAiVd3b3CAnSnk9MbEEb82ez/QkjqH1LHTa8ZeiZ3TXbL3VMDCFm+rEgZsyWH3c5byZqlTqYqqdwzJYU3Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1Ztq+R7268232NDJikFyxGsr+ELxByK6UWhbxu3iZQvIs/bU
	pSB2kLL9cqFpggWly2rq8HfZPagt2HA1Tcx46w1IIRureCx8FkkKXHMj
X-Gm-Gg: ASbGncspqS10nIHM8Wxrce8D4IU59FSVM+3g6wCpVYUxYMo/o4Sop/tdKpa8DPWhY8t
	cgbLQsTlfQJGQzw5rd+Sxzy9pf6sof6OvVVn4qx1sk45VBHL0CrzHWfgI78+brwHw25eg2AU1tn
	/A/QCyM2dEeGgwr4vAg5QCIoKa5wv2xAzA3hSDB6jaX3EGJh/z+3AU+DqIvYqq6UnT7+mJXXre3
	qDpczfvtXRXsYKKJcD8ZqApdhvGy/E/38o6B3g+B0PPJ7DAuQexDRcTMgpUALNcGxk9GEMim4SJ
	dFv4oIPyFnJ8D43jew4QMY+66/Np0MSsh7HIEE3Qnn8D5keEVZBAX8Ld/O7amoK0NTWiRS81rRM
	SABT/bfuhs71QQy5qOO6YsnQ9xyW7NzDBqh5VRrSFJyzwY2ma0fQ7ysbbvYxyk9UQn8XkpTnnD7
	IYxoxw9IQ=
X-Google-Smtp-Source: AGHT+IHqGJGfE7/AR7EEKGb5aGT4lYi4Q0CdcUhFDN32WBMZZ/a+b4mtH/4xEGFnf/S5gHM7f9sTTQ==
X-Received: by 2002:a17:90b:2789:b0:329:e703:d00b with SMTP id 98e67ed59e1d1-33bcf8f769fmr34761255a91.19.1761244094881;
        Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff46d539sm3689641a91.13.2025.10.23.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:50 -0700
Subject: [PATCH net-next v8 11/14] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-11-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to verify CID collision rules across different vsock namespace
modes.

1. Two VMs with the same CID cannot start in different global namespaces
   (ns_global_same_cid_fails)
2. Two VMs with the same CID can start in different local namespaces
   (ns_local_same_cid_ok)
3. VMs with the same CID can coexist when one is in a global namespace
   and another is in a local namespace (ns_global_local_same_cid_ok and
   ns_local_global_same_cid_ok)

The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
make sure that ordering does not matter.

The tests use a shared helper function namespaces_can_boot_same_cid()
that attempts to start two VMs with identical CIDs in the specified
namespaces and verifies whether VM initialization failed or succeeded.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 74 +++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b775fb0cd4ed..f2a99cde9fb4 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -44,6 +44,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -60,6 +64,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_ns_mode_write_once_ok
 	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
+
+	# ns_global_same_cid_fails
+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
+
+	# ns_local_same_cid_ok
+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
+
+	# ns_global_local_same_cid_ok
+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
+
+	# ns_local_global_same_cid_ok
+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -548,6 +564,64 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1=$(mktemp $PIDFILE_TEMPLATE)
+	vm_start "${pidfile1}" "${ns0}"
+
+	pidfile2=$(mktemp $PIDFILE_TEMPLATE)
+	vm_start "${pidfile2}" "${ns1}"
+
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return $rc
+}
+
+test_ns_global_same_cid_fails() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "global1"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_local_global_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_global_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "local0"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	add_namespaces
 

-- 
2.47.3


