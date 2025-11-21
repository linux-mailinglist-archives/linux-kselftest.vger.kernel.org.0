Return-Path: <linux-kselftest+bounces-46193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B2C77731
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2D8335FDD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC69302CBD;
	Fri, 21 Nov 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNf8Z88Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B82FF150
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703908; cv=none; b=DYQ2uOVizEHQG/1JlOdZqkOroZnSU1QdNH1oYNPg4zpsXgDVjaWrIzSZc67gTJimvBC7Emz/usv+ZRlG4+VNxDCo1MxYkcVOHTZYXDRR9QFbiPS68DaxA+fI2Fj3SmIDQfhshBAwfWNb2RXv07+LsYML3a/nsR/box4TPHJg/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703908; c=relaxed/simple;
	bh=S0OTYm3s0WeftWD4AqPQ/rzlCPMOTr3mHqDyBo2IzPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2A1KXW6XqkwP7vx0ILIbZ6B+c4AvdQf51SHG3ZDTV+0zvq1JOa+0ii44xCzSBbeebcWs51HI4zLxT3+bnJ5vK/y99urNt/x24YKMHJizOtOoBxKWnN+HoBZpBYWK3U29TCGlIA6ANX7l3GkRUXEW23TsOAjJw20b/mXeO/26OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNf8Z88Y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3437af8444cso1709776a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703902; x=1764308702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukEcgJRgkjZjmBgpWiJDnd24uu19PQYcukqnsJV0jE0=;
        b=FNf8Z88Y4Oz5X1VuMZOrmSJ4CyYP18JGMeaD3wE91y7au4XThrpiH8BZqKV3XUDEVl
         rxFqwwuDAVbK4fqMzsU9dAswOj3xEVv0+BvlWae09hSiV8PMc3FgD0BfC8BgNLNsoPyh
         kPjTeSTZsuuvlqYgKa7Zk3Y7DLdl2vpDh5tYMZA1adAV5VV3VPcaiEIRju/cCdcSYs1Q
         D0AEWZhC7tL33IS+cG6fUKMKGBSTfpXT+XpRAhNswlWS/hlRuYr+9VNe2JF5bp+FQwwX
         iJDoDsnfgRZQdflGqJaqxiilnOF5A7Z/9EvJ2AUNOyVGMQ3DnRUS1eKom9LkG61t6Z58
         2yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703902; x=1764308702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukEcgJRgkjZjmBgpWiJDnd24uu19PQYcukqnsJV0jE0=;
        b=VPHcATA7lffIbgPtIOKexMWXulqK/Z26ACxb4c53EQEg38iBa0MpfDiCRS5Zd+jOzg
         FEk0CT54RaAAYeAdCXHum8/f6d6pVaC53vJ+/QfO/JWHaWkRthqFjmtUwHVOU9ltxY9U
         Zd9gVAV151NGpzTZ1rGahZGCRdwB5oARpJAiGg3Jf3MtIbKGF4JWgpW4T+w2Prjlt2gO
         KzvROu943fgETh2eP/S31G3pEmUIkFQZvlELsQxHxHqdhfyB7qC1FdWBeChV5Ouzvf1a
         IWDp5FxMkGubdAZhZ1iELZs6f2ZZ2CCzUAt31+4vEFLgBKngljtv9SnAWhbxqrR9MjzF
         uIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMTxHGcxvlutPBeB00i3Ve4l3Eu0K9GRqExKEWfcmMhQGEQW7TuJwJ6J/wdErdcyY2cdcwWGpQa1/mLLs4Sf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+7zHHXEko+tfKVMMc61crG/oxyRS4hbzobUdmOrp8Wcz4oFH
	siKvaNuaRkS0iOrA0QW4AsNmGXveimozi3ikMZ12i0hEkIN8HA8QjGZG
X-Gm-Gg: ASbGncuJRkX9KXJaier8uu3dChxQs45QUo+ABC06y2X+rhiJe1R8WNv48wg3J2xbdmW
	cmUqZ6EBXf0g3rl0rnji+HcAvWQgWt/NY95zugUlLiphHEwqtVujm25kBl3asaTpMUVe3d7muYj
	q4qTTjezfkJkLZNWoo5KnE3RPXz4zX95VxHA/G9OlGJBtuW9t5ajCx/fs2dqGHTqp9i/2da1r37
	FYh/mPhxmjl8a/7CqixyPJ33h3aZpwzq6eJ4xTouxd477BQWsElibU3nif/5BLQT1zdzd0Vq0Q8
	MLWojD44m5HoymXBpiKhSRaCvKNV3Em/feDapZSJXZiftsQ/i59WQkH3AYbjE6tefayM9nlkKdV
	I4WxezJ2ilTQdfn6zGxExHwV0HaktdBCdLsXdxOd+NHluI8o3aOLiv2BlbUTbBrnLDIbvykwHG7
	FdUCJSB8uzNc+4LcDcnESp
X-Google-Smtp-Source: AGHT+IFELQgLCRsG8NRuOCsGBzSRJdEH8+ehXXOKkL8vFZuPvZ3QfZTp5lGjY+9g40dgcEdSszo9Aw==
X-Received: by 2002:a17:90a:c2cd:b0:339:eff5:ef26 with SMTP id 98e67ed59e1d1-34733f40d29mr1247312a91.30.1763703901651;
        Thu, 20 Nov 2025 21:45:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be2fa7sm4195843a91.6.2025.11.20.21.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:45:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:43 -0800
Subject: [PATCH net-next v11 11/13] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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
Changes in v11:
- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
  local0 twice. This check should pass, ensuring local namespaces do not
  collide (Stefano)
---
 tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 2e077e8a1777..f84da1e8ad14 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -51,6 +51,10 @@ readonly TEST_NAMES=(
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
 	ns_vm_local_mode_rejected
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -70,6 +74,18 @@ readonly TEST_DESCS=(
 
 	# ns_vm_local_mode_rejected
 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
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
 
 readonly USE_SHARED_VM=(
@@ -581,6 +597,68 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+
+	# The first VM should be able to start. If it can't then we have
+	# problems and need to return non-zero.
+	if ! vm_start "${pidfile1}" "${ns0}"; then
+		return 1
+	fi
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return "${rc}"
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
+	if namespaces_can_boot_same_cid "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"

-- 
2.47.3


