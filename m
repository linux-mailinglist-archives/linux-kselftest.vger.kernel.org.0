Return-Path: <linux-kselftest+bounces-49208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C21A6D388A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F241130D0BD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B83A1E8B;
	Fri, 16 Jan 2026 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+J7wDKz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F74314D18
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598957; cv=none; b=WK0HUUQkLxxCvC6C/PgonJNK/LW0f1wQOozqn9JIMiwACSj32pYtQTrJpDBjNF6PoGO2Ryg/ECZwnNIpxqgePXICOV5d4JdBxBhU1C0l3RY0bkzg4tDkbqqvkP9b0rEVu2GTy0TVCHaWUeqA2HViIjJTohK69SElByKxxppoeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598957; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+S73Faot+x3hrICyBWZm/4Ni5ONmlzMYf26DJPEQ7KUtlkZghJe+2bphi97ZmwJiDfduEenc83HnQ+YZg+7gH5NspVS78j984B/Z75nTq3gW/SMvmW2Ce93ULwdKpCQAlRP9yO/97AxVzT01wuUd+RPg69tXrhV6hzwQx8KuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+J7wDKz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78f99901ed5so23485527b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598952; x=1769203752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=a+J7wDKzdI1mlppUc/PLN0epC9FKHMylZ9qQ7pjLvDrF2NQ816/qpleabYhKpysNn5
         WCsm3sBt7ZIuz8NMJBOJzIcE38lAGLol06hqMZF7wzF9RnvgKQwW8dP0mYpSFWFwKmtB
         MpV/pVvgsa417gDMCpjvE66PucWD5ES9Zce2IRL+ZcGk1KFZc1calnP2piQ8DQ/GvX0r
         SwdOX9mw3/++2/Dk6ue2ibRSC9sb5KyKo+5Sy1kpqSlJ3+dX4mSIpVLgnsGS82l+2lsy
         K193RTcJBZ66ErcbCrrwE5GS1m/oeR87fx1bPfm5BA3caHxrjvwRLYq1SAjnyESQiBGe
         suqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598952; x=1769203752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=XniCvCKy6PnQLahs8iQBlgOOJgaPqXVCkBCEBT8xqpVHsEWwgvlZgw8wwas/zMO82Q
         ZQA2T5ZwAZSe8OtlTUenj9fX12xxVtv4jXEr/3dadB1LqJrlRLyD9TilqFKyuf3QCfQt
         GO0TKOEBjUIFM+DRY2dC8qGzJA5lC+JeHaa+pFOoEjaV2ImXPJFnBxxD9Q6ahFdMagX4
         5+2rxXKfD3fapyF4SHxSIwC8b8lmyRkQrYWSyZeYOy3DsrxfHfKssoPJgita/CxAD4CQ
         3mgFImXnL7VOx//Cu6ZgR/h/fU1zLz5j68MTJ0IGpu4Jk5b+vjcfDXCNOBsr/S59DbzP
         FxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUvv8Lqrjyy9DV42BkzKZdgGslfPtyFTT3O/T8Qo6Ydlfz4MrwFkty2L0GqFCb/hO7oQA2dSBX5jAbUxqexWHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqcdTeu+20sF/27QHZaZigEKf2LPhP/TvsCZT0ogbFo6JIcIH
	2lpRx4QpXpHt3B4OuLj1iIITJLgiBgkBpABmSvTSHx3CDs4gFGpJWuuS
X-Gm-Gg: AY/fxX6EILqC7gUHYcrI3RCZuNeuY8expCiZY2/0XoktVNO0rxlAjXGmKP8ZKzzzkNb
	hJ4RwqfB7YtpRhjZ2pHltQ0jJhdGaKCbIm59dc93nToBaZT+x/w60oN9I0XZTgoeaW2041y605W
	Ttd1jDFrbu6WbPEweIkvmh2FXWjrKo1H+XcASQ1bdPoQpOndyWrYUO5HtVJUCYeDUZLJ0J21rKI
	FT4dj9HmW6RT2yIEPryM7+AN1dSjjKUKoE7OgWIzore7reUqGWMFaseJhX0Qmq5DaGa/cXVvgLp
	B8qVoWWMbo+ev48ws5vsM6E/PEHUqxeHcSyUbVaBYy6zeBdU9o2cl8lHcVhzgX7N/SDvJYwMNGa
	aLZf0oPQAwMEx4MdUG4qbup2pjbuJbAL7xqFl3T42vcvHfUaXAky8wdr9qG0dQbTUS0i0L2J4RX
	g6mMFshQq0ZNIxtQBJZqk=
X-Received: by 2002:a05:690c:883:b0:78d:6657:fd1a with SMTP id 00721157ae682-793c5393f96mr32809527b3.37.1768598951767;
        Fri, 16 Jan 2026 13:29:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66ed7a1sm13166067b3.14.2026.01.16.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:50 -0800
Subject: [PATCH net-next v15 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-10-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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
index 38785a102236..1bf537410ea6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -50,6 +50,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_child_ns_mode_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -66,6 +70,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_child_ns_mode_ok
 	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
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
@@ -577,6 +593,68 @@ test_ns_host_vsock_ns_mode_ok() {
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
 test_ns_host_vsock_child_ns_mode_ok() {
 	local orig_mode
 	local rc

-- 
2.47.3


