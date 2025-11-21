Return-Path: <linux-kselftest+bounces-46188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A411C776D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E0264E6DAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2DC2FE053;
	Fri, 21 Nov 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAUOO0WH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB812FA0ED
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703900; cv=none; b=IPO71tVfilvjcKD2G4KNqIP0SR3K7bkg8upkdMNSzcN2SV93NeIjo0gYWkjP0E3tE6nWvUAahcM+F9OcxS+g5cGnD2wsoQM1uABgCRLiyMHERV4krDtGxjIFY1InA343MIdrs2WO/W4VA3IYGvGscOmAkRsagTxRyI3+UeMInLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703900; c=relaxed/simple;
	bh=uK+7wonqeqIE2+4J4eSHlB1BJW2sPOHiw05XtJHZdQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P34e05cf5WrIGwsBNxOVuESSuzNDt67Sajoigr87VAydNIEG8YfaO2jOs0guvi0jza5B6G1Qa4FZI+dgwctZgeUMNpxqlisDLr9OVMjUB6aZgiD4Wgr82ZHR6ZH9dvk/AvaUlLeJIG/z+/xLZVObqbGUjxmpPuLtzPncQ0lNDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAUOO0WH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-299d40b0845so26505205ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 21:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703897; x=1764308697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSkbmakY8QtibtOCdba8TmlxElnFph3vUeoyjgD6/iw=;
        b=QAUOO0WH3+qgxCZ6gMwgQYIf1kk8I60OZx+Wxe2+vqswILHB94RidaRv6PgCam5Q/2
         0QeqACwTPcokwZ1EwCE9dam0p5utVtxibxiUmQQP4AH9iFGNKaLyhRpYOEnHT9bSW9w3
         nhpWiRmeFGT2pphlhz6ckYZJZlrPTLQUtOx6da7bJ2js+q7FehULpnpD7Lku6lz3sXbN
         KC2TRvN/VeTSxcaaEOdNbgXjk0EKihxBvkR8mfc8eU2hGDUwvoJ3m3eWqgcg3guyA7O9
         MWl5ys8XEXnSXyMtIMLQuXdf5YL/w78Un6fNQG9qKtkWEIG1PTstwa2KYP0Ip0sZFAzt
         99RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703897; x=1764308697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fSkbmakY8QtibtOCdba8TmlxElnFph3vUeoyjgD6/iw=;
        b=q6gavxdjRE3MoX+h0XpkB2CNvLSXHpaMp0kyB/SArAyWd7YdVrMH9uQvt7VdWLBB5L
         z2nHxolsiHLe6yXsg7nvlFIrJpaJAlpzfAM+mhNWARciiwBJ13wGsQ+d+J++YhErq0s3
         Boxtr4tghEkpyGOOMERP3OQWaC9R7MLwZPdGWI4ntSOkX0ge2qN5hwyLeXBd1bdS4yPB
         yL7Dyeb+kG3b/SPTG+eCRDGmFcFb5zEbazTx6LpxMVbOcZByU/6E0HpMgELxK0TtqkD1
         52Z9r7PXU3IEUuFOYQLtURrC+aGfR9hxmMhlZmwMUIvEteL1g8DtMYC9YA/iem+A7MUM
         cfPw==
X-Forwarded-Encrypted: i=1; AJvYcCUxRYdYwrfKtWNHU5wpikL6HgFeZsbKDO1864RbqSzs597CPAqlygOoVpKRR3c1SGf2RQg+tL4IF/dMLUJHlwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiE63d1FsZa1g+XDGutvByWzFVIijCQLm37lAnxda5T39d8avr
	62ayuCT5kvoMc3xdvLqExFUgYW6YLvpx1WjAlKpFu8FuoydrYYG//d0y
X-Gm-Gg: ASbGncs3QVkUboKRtF+Vh31CsiG9dKyxM+DQsouYGh5/pYXj6oKNAbvRBr0osuMjO8A
	3ZrFZjgBKtyZ1dhuwfyoHBeH54kMlwTeigH+39g518Q1A5YwGg357nuOC5tZ9ApCvGgocEG8gj0
	1Hb0bI6BmQ+rgaENI0vqBSrUB8b0mMaaeAnYes1I+ervqptGom3obJasMH7MnXJX6Ufxrt+wx0q
	23MtcYL+rsB/fOIeAvyj7VWiXcDXs5uUd4EAxN0YM9JC64XZC6dLuvtV8i5XbRrp1f8KP6V8wv0
	LERSAmrosYdzHraioN1KuebPmGDoIMQMzX3ZzjZLpWF+BwHaaTvq2cVJd0g6KIfnS3ljDQIW0ar
	0PsPNRn5jfvPqB3ix3Ego9VyGwxo1B6xLtSWFcCq823vsVpe+TJs5XWvICPxF4Dg6GcdS+5oydA
	tJnv2jLPfSuMcuf/Vi2mE=
X-Google-Smtp-Source: AGHT+IGGsDu1q3vm1jDYt6q/UI5NUFr2N2GTMwEvCBun/hcx13LSj7midmn1ev74SGvBLriqPu/3+g==
X-Received: by 2002:a17:903:2ac5:b0:297:e59c:63cc with SMTP id d9443c01a7336-29b6bf19ef0mr14465525ad.35.1763703896832;
        Thu, 20 Nov 2025 21:44:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25c104sm44306755ad.54.2025.11.20.21.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:38 -0800
Subject: [PATCH net-next v11 06/13] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-6-55cbc80249a7@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The init_namespaces() function initializes global0, local0, etc...  with
their respective vsock NS mode. This function is separate so that tests
that depend on this initialization can use it, while other tests that
want to test the initialization interface itself can start with a clean
slate by omitting this call.

Remove namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

This patch is in preparation for later namespace tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..f78cc574c274 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,45 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	# add namespaces local0, local1, global0, and global1
+	for mode in "${NS_MODES[@]}"; do
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ns_set_mode "${mode}0" "${mode}"
+		ns_set_mode "${mode}1" "${mode}"
+
+		log_host "set ns ${mode}0 to mode ${mode}"
+		log_host "set ns ${mode}1 to mode ${mode}"
+
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
+ns_set_mode() {
+	local ns=$1
+	local mode=$2
+
+	echo "${mode}" | ip netns exec "${ns}" \
+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +150,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3


