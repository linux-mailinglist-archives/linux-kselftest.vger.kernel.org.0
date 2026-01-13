Return-Path: <linux-kselftest+bounces-48831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E1D16727
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 04:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64F5D302EAD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F6345CBC;
	Tue, 13 Jan 2026 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvKioUeq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745132D7F0
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273990; cv=none; b=Ks0PM1FsclO1bVJv27I2ojzHiKGF9P0C0DPN3O1z9tJMKA62FbDmgiVcj271i8sYdk3E5XPYoL+SKsR6UuHaFb/V6njzt7ExXZOgQyYMsO+TUkJYCf9qXn2IYAwUkP2Y+54Q/r7KjfI9y8GJEAhPLUtEAeU6WIQ0quxnwWBI0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273990; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmDDllgzHUpetFZ+H9iypMQK9lB1qjUY7dl8TsYTaeqyv72nnrvEMJM3iVv1IjDQsy7Knrcwhze29csNS/Hwy/5Fs7jrirwJ7k+2Bu7tTdV49n1PT8V54ZXCdT3qUlHFjgiPTkts6DSunjxJ3w8TnzvitejAqWWtfeON7oPsYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvKioUeq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fb9a67b06so49773937b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273986; x=1768878786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=GvKioUeqJuLgXz0GTYRTnFqU+1pyo22l7fcw4ynkxpj+ey80UuN3tYzpU2kMujz52S
         s+yskllsgQLGjnNi/D8mNh/PzPHuvlr+Cp0oE+5xE4yFopGJgOQgF/Ai01IInbuJhcKf
         Q37/CodOAib/BJmlG+bWstVR3nrbWVQJCX+HKOAQ7NWqkuxMs8ub9FZLVX2w45ONdomL
         /J0qzGvfhsh755mx1poZv2bblgJ/2PEJsM3IpLtsk0N2YaoTvDXcTWrXWrZnvg7Wmn4V
         4MUihvhyyTrKhXGeityiFQOmoxSxSx6XIyg68nj6iQfVvVmAA0UydPmqRcwqTScchCYr
         Lsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273986; x=1768878786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=NN2078EgJdNUDRmuRF4ddurvt3X1Iqv/yB5dlP8WAdBCCrg1Xr9w5elSvJQxjMEMaT
         YbXVnb+XVI8jAfNFw9BVr/6uhWNztEttG0F8Aq69/OkXgNISzx0zfgOoa25kXLJR9sag
         X4JZGsymvazNSdMWxbz4qumiqE1FUQymKEnLwlADDDu6nefGxZT5MnvBnyqDewyEXiHB
         lOt4uP4TcOax48DzlrrODPLJO3C/2BW3jex9Hpmj35Fco6rhEojJm2tMF5xbZbyXAhHI
         qjR5nTzQUFGGG30VHuNQW1MGhdyP233Vm3gFgL5leKYj3Y7fymhp/J7Fj9PhAYfELt7x
         cSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9zVrLp6kdh61XPriJbfr4h59Tmqf38nwG2ZCfm91sfJaFqyTTaJBtblq1jqjj8uwQ0fwYuungAJDPHRS1v5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44n1+PDy4vDndFrT+KUvCoPrXQpB0uSgSxeDfUe/xTZB0apca
	+y/el4Uo/nsd9iG1qcWqsp1ACGkySGiDk/B6+eGdAlglMI8IrKa0tYo6
X-Gm-Gg: AY/fxX41JiyJ9U15NSD1U7Nstu++mOcIkeqJFKSgj/nRgti/JE2OPQkGAqLOuucg/jO
	+W6voa6iRPsvKCspK0OqfNH5tT/uF7QU6Ll/5PQo5SnCwyE00Xr2W4tnlEYsBUyB99qFvZZxWEO
	Dm17wEzfv5AtH8xTMZc2ve/vHAimkuA/pySZYl2U7kddMtYoW36T8syoHKbh9VWdfvbqwV0ZHOu
	IBcHhqLuei8AlzFuEMvAwA5bHGTnpKZPA+Wm29mElOTq+iHOPSwKBJEeQziAK9ADcQGjwHTykMv
	l6jKPMkUsDliL6Q3rWqceYmiAyuYCbK2al9gVSnzzy9Ukqw15n5aOBl9fROhLTm2tgv88JOAfau
	hID1w196x/imprtxV+oph/komgqBOQ1tcsK9SL2MIJzkyZqlxuhkdvz+UwsBW6fbTe2CRPoQY/8
	apZqun4SBEBpmhUfKyIJZI
X-Google-Smtp-Source: AGHT+IERhF9/l61WGAQ1JPbNCa1uy97rBtlOCcNLY+Lr8nEdQsaCK1nAx9XYRA7ZWkcN16bvEB72Wg==
X-Received: by 2002:a05:690c:6f05:b0:792:7721:e072 with SMTP id 00721157ae682-7927721ee43mr68361877b3.11.1768273986386;
        Mon, 12 Jan 2026 19:13:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a3969sm75907927b3.43.2026.01.12.19.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:06 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:19 -0800
Subject: [PATCH net-next v14 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-10-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
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


