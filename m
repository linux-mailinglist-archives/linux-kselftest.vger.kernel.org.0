Return-Path: <linux-kselftest+bounces-45388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F585C50D45
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 08:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B003B6F2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287692F6939;
	Wed, 12 Nov 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut7NuIs0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB292F39A7
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930552; cv=none; b=qi3XyzXAO6PutnEnPnzF4zwAFga0GJidzbUKCny7brHnxfA5lydbNfKf+TSJY31cXY7U/OJd/Wp762Msmu5RvWO+c2J4dLZUXimwWdx1T2Yy5OLr33IMtKon1QeuydwyXKCuFRAcUSKsYfzV0WHQ7jtAZtWnJHTHXRQFQyQ2Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930552; c=relaxed/simple;
	bh=1H3EUWCH7xSBo5TO1aY6eWGm6uEkReSWSwsgMjSlU2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RA8IyMZ++ukUF93dE+DKXKLneXNZzmBqKyqIoowFEdkMrcYyoX5iskMrnsw1WF8mAflivJZWWVwz7Q7txyBZQWcUTtyf+SJv5AU/QhAJLxjoSvPxsjUNALVdiN2wvcdnsqXnz6l59LJ4YEeiQeQLocHqxxftbVsgwEY54BlQgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut7NuIs0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so610560b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 22:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930546; x=1763535346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPZC3vwzZRkI5HZ/q+i3flgAzmARVxeU5m73M6Jn+5M=;
        b=Ut7NuIs0oTlD4N+J7tgkRdCyR0Z5nlLLCW5ACRgikDGPdazc2G34RS2REAs1HUx0eL
         uLbr7THog9JGNxW0wCnk+oXmm0GG4O9hEuUbCGBHFZ+0LqCvi9v12PN8bMbQsDdQ+kn5
         78TM19yRoMqrHhKIovQKylgJksjqK1DmPToJ9pti6fX0dQ1jZRUBj/nDkjQM8K3hb7uJ
         hlYwdHGxe7HZsNTDgIsy5+Tm94ZcDnx0c8kq11o7RSreQrgcvcR9YVqpfq9GRUjkdfrU
         wJ/ltMZKP+9XqHPe9zA7oj8cLGw7KOFC8Y8zNfxmiJ3eIqESUClpK4K64yswtLcipz5e
         YJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930546; x=1763535346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPZC3vwzZRkI5HZ/q+i3flgAzmARVxeU5m73M6Jn+5M=;
        b=XRFo46H/dCHmOiB7McUCA3AAPdxY9r+KxoOrr5gjReqzfqFFOXiZeQpZWtiIfwTEz1
         WWz5GS1wxKX8p92CVgDRtFIfb9jbkWUvzcbI5FPn3/3F6K5GlZDo7DEiVlh16M036+Im
         C1kBLW6qwsc1as9NGkFUPPQC2n531Vaa2391OABiykrPwFsLE7d7rRoLJdU/K4x98GxY
         y3n7R5HxpcCvcK6oDvvEUwpxXiIzB6cv0vwqSyNWysb5fHlfjLOVTD3Pc+GJ3SSfwM/G
         4FqJDsL9gIcuzwJJCt5UdxAI0wcmXVnQ+2dSCSxzFJVBBUC0eiCVrnH//chWuFchpVXn
         U4CA==
X-Forwarded-Encrypted: i=1; AJvYcCWLUmdSg3owazZWpcryYQI4KNEdpzEODzHU4D5jqb2cX1/X76Out4kIsRGmbeM+SxyU4vwVzJ8NO+SCnRIYz74=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrKEXuAcb9325KiXJfImJcP2Ylf4e9fEFas7dCF4Zws6Vpd68
	K8yFvVrE9Cy3ogaNbGeL7M3xl44RyPIAo6y14hD4XNQA/OP6BvKrXuLZ
X-Gm-Gg: ASbGncsYrV8X0Dt6IfrpOO6Zg7yjaDbg9naUTtiwxr4kKuPtzeFKdszCsFiM2lOcUVt
	J31HvFNr/qcAcCbKvDSXGfOY7zgKgV5Mo8LofzX+f3YSB02GwRUANSv8sEw67FypOIFY37FarYz
	cj0aB71ZYBBos4wOmSu7JJbtA8iGhSpeOL2APIJFTn/VRTJ1DzZYb/FY2DE7l8MfSyvF2CQVo73
	ioOBRAz6C5TA9usjqiSUG/futDr5uI9FXOXnEmxKmwkIis2lylPvc4xs1FHQdUPsgIIhMkKepYy
	RCQcuBhSqkWI5hVTJcMCYaoNSg80bNOqL1Bi48cvCQYeqlA9A9sPCQ3FzxvgAD1+sO964Kde6vC
	DEj+QjPMwW59jCjDyTXchCC1LhjR7wXvwWBeH5dCJn5CXxfUF3Bo4otgv9tjTLqU+e2/xLmSD
X-Google-Smtp-Source: AGHT+IF63wc5PyBiuw3bp1ZcuTXR2K3zypie/OPBry1LcGiDsecEoImp4LY23rndvM78wnDiolZbBA==
X-Received: by 2002:a05:6a20:7d9b:b0:351:1cf3:7f20 with SMTP id adf61e73a8af0-3590bb184d2mr2455933637.59.1762930546212;
        Tue, 11 Nov 2025 22:55:46 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf0fab0ef9sm1730860a12.9.2025.11.11.22.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:45 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:54 -0800
Subject: [PATCH net-next v9 12/14] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-12-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
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
 tools/testing/selftests/vsock/vmtest.sh | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ef5f1d954f8b..cc8dc280afdf 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -48,6 +48,10 @@ readonly TEST_NAMES=(
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
@@ -67,6 +71,17 @@ readonly TEST_DESCS=(
 
 	# ns_vm_local_mode_rejected
 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
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
@@ -558,6 +573,64 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+	vm_start "${pidfile1}" "${ns0}"
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+
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


