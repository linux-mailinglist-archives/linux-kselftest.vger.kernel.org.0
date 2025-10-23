Return-Path: <linux-kselftest+bounces-43953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29CBC02F5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E313A3B1BCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154AE34A3BC;
	Thu, 23 Oct 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgTxk4Pt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58634CFD9
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244101; cv=none; b=EAgWGTYLuYjEaN3J28MFkrIjHHptbRumk+0rUt2PHQgM0SrvUdVUPksfi4gSVn4BRchao2gufqjCVFZGnPM3gSGaBTzEqnDyOmMb/ZjCS8sGL992ZvQMPZbDMeP6caiz3yON0eQ9GmM0LQC+F0it8ujfOcoHd9RQR/DTSL/+V2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244101; c=relaxed/simple;
	bh=qsdEM4mUEx6lc62dcdEXc4nlTIYZClzkDbVeOSxLeZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLZEdzpQ8TfflaiffUkLjF0qJuB/roRyjd8mEr47xk5YL0AD3u1G/Eq76edS2rDqjwRss35tlFGxRbM5wg8qUQz+JJBQOfmSrwA5W3v2AW6BGoILrnrAFCmUn6Qxmp1OwyM5Q62EtHzhis61SCJouZcAGVhEHtXvf3jQ2pr/1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgTxk4Pt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ac2ef203so11112255ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244092; x=1761848892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1bBkEHiFKeL/UsD+j471vNGh5kKPPSFbcwNUOh3PyM=;
        b=CgTxk4PtZgzYqEwUrxug9GUWlwAOlSb/4GiXga3xzuC8xsVvOkqAma2VKwORIOW7I2
         QMtsirQZM2E1Ydb3QkqIDrIat2ivOrUPcH43MbFS3SzsqWOvw9mubCVxWOVb3OIi/10r
         bQ1TOQpfyqn6DH8rO77mXUM/KV1CQliLqiWXhtntOTPaX6qXkLKW78hU6LgRcrx44Vkc
         PXKSbbmfxzqf0VlcNs2JqBsFzvvnpKzJVvgaETgKKK678wAseoGKpKLxF7VwbnerjfEK
         y2jJcLl3c6P0e+QoGkFum2l3IMdhkLDyJToz841o9imnGUzY6QwFJHMIBVzeo3urdrtN
         gcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244092; x=1761848892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1bBkEHiFKeL/UsD+j471vNGh5kKPPSFbcwNUOh3PyM=;
        b=fnAY7UsHZJOk1Qz8Ai86dme/KoarWq8iL8hOEPiWRNqXVtkuzABkLhMMQk5PzK1gcL
         S5Y+DkYF0KRoyKvga6s8tcEigN3uAWldtsiPIhA56I/MgVeoIIuGqRdPLZa6i9jMzvwm
         kK+csdmCvz9ctbSjtRJXID71U9peQr75fLVk9n0mc1jPcPJ7A8aTvWbUuPIb2Cpq1Krr
         aDaHj7jsUDkW0sRk/w07C890OLe2D3VOGKcVzQ1u+urakEprMrDKTkmqXtGk/6aJh07w
         pDyx7RgbyF7iCgonwT9QcFac04rjANT4XVALjT+mpkUDT1tlG+oQp7vsRUx0m1HI+xpg
         B2CA==
X-Forwarded-Encrypted: i=1; AJvYcCWksnZrbqJ7QHLmtWnxn1PJICG3rnfqWMp0QwTJCJOexkW2IY+BPC9cWGGaUAVKd4/Xk5MDEMZ5kQcnUKNTGdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iBx9UVNjstHZYyNreR775WVLWdCD7MRsIq8Le84i9ympw9Hh
	dLWJ1W3fm1xYudar7B2oc29nP1S8lzaGlA9gqMdvSZnXNV8CYARmMt2/
X-Gm-Gg: ASbGnctcj3yjpaOsmf4uecygZ32JaOiDQz7HBO5MCt1tYv+DHjiMxMdV2xuvINKni0V
	98FwgBKUOp8Z4sHuU20hWzKylcSbu1fAp1G0i8a+JXe5GpqE4ZBcTfmAX3F0GOP9zH62rP7N4O9
	lfFLyVJ/qSeKUGsaxibtzGMOQKiNeNaMMsAEU7sVVWt5Eyfrhlq1/C/DYvdGW6z5Mv/uGq9Nd78
	D2ytv39da5osypVHMru2BloCgc9qSgKNS+s4iECbc7i2U/l5UO6KCbf26KyI35BJKq1wJjjE8rp
	tVhbL3nX0RrOcImN+ycbG6ua0WLWZEatfAgIkG2byEnoMsVSZZreT+T7basBqKpFik/daRMHj7p
	l9DN4Evm0gujl6PayGCK+DzvJEycOs1KwQOFbhO9FHVeOqJSZWVvENjnYbGi324lKLKF60lWa
X-Google-Smtp-Source: AGHT+IE/dwExmoLUemuWd0Z4IzWtCnVPvukg5v4cVC/ETItw8BzfPltzLRhLMffJHMVaO6fvdpyktg==
X-Received: by 2002:a17:903:24f:b0:267:a95d:7164 with SMTP id d9443c01a7336-290cba42a8bmr268233595ad.60.1761244091859;
        Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec8d8sm30411195ad.36.2025.10.23.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:47 -0700
Subject: [PATCH net-next v8 08/14] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-8-dea984d02bb0@meta.com>
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 62b4f5ede9f6..5f4bae952e13 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -100,11 +101,55 @@ check_result() {
 	cnt_total=$(( cnt_total + 1 ))
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
 }
 
+cleanup() {
+	del_namespaces
+}
+
+trap cleanup EXIT
 
 check_args() {
 	local found

-- 
2.47.3


