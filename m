Return-Path: <linux-kselftest+bounces-45821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B36C66F4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7CF636162F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE0329E7A;
	Tue, 18 Nov 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3dpsW5V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7213233E5
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431250; cv=none; b=SCy3kkDY9Lf85ANKpUqM4nKcRUGbsnyIuESLJiSFH+YdS8jRoQPQg/3kJqD8mL9yDGazhlBz+BN3Ji4opmvWTfWUJhJ2QMo8DS2lpAh/zc6odfW3KYwURq09t0wor1hg48o1kZ+SUX116aoPq18VtcqD3hRdYfbCSJHuDAy6IdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431250; c=relaxed/simple;
	bh=C74tPtLEcFlxKPQiq+20Ok+iNGw0X0cvYTmDWlPCWgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQhRB1Zb9EKbE6DXJAI+QqM/iLLmD7TeV66xJ4GjiNPrR9COgWqgzq5t5oudiX+rCnlokbChZiHUd6ZzlFur/DNMtZFlPY8wVclwkQup9XRVq/UUv99tQ+Z5r4/ErmKxiuCYJvoUbuXXu6Jsf0De3AgDsWgqk6tQPAqk78OUI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3dpsW5V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4292965b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431236; x=1764036036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=X3dpsW5VD1iHZMZBeS9LTTM+cu7GT7shshUYdIbgPDyWAkj5lxHNEk3tw8aCR33Y/C
         6MmtHlbuW87dR1DK5O+R+oya3a7iSkQZ6ZtOaVF09e2+l5eyL5DCpAAhj9C62oT53WbC
         WxJi55It+J/zb8LdF7I/f5qTPUHxFdTy8/8kSRgyPOx6IBK1sfVX+V6a140r52ZhvXCW
         yzQRcTqzWnzEPkBtEWBNnFYYQD3cK3KsHTMbnb8mZ18V8jLOQDoSlp9w/+bur2Gf1/dT
         r9ci3lwe6GC9ErU0M43rrZXabJGZUjl10sDzLf2WrsmuWCbrfN70zdtIIpYIVFJXqJcn
         +ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431236; x=1764036036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=llHQNwSijv0+nqQiGe//RKWbYy3Xn1z1S1mIdr8Lg/14xYHtmFxyhJnyzQoYGht8PO
         MkpZsW9UpkZ5rFK1CGmF+QSn6FhymzCocDtnP1T+CevdNBezoFnpYOFYWERMJVyHJdLt
         CWYe3qB2bhRAHmI/8m+Tf4KXGh6FZNnxU/girfu7fS/Fy2QBUBVWn8iN2kEqhyY/xh1S
         TUCPABM0beJKW/XRJdZwVsjlQxQM0IdbrVh5ptdQbOpBowUtJy4yry0upaALAw9tprDo
         WqEvAycJpeaUVbse3NStbvwlHa9m0pr1N2JiyF5R4A7HCmySQYT8vXeSd/t6LqWu80B8
         9aHg==
X-Forwarded-Encrypted: i=1; AJvYcCVVlLW9JrPAn4MYWe67QAuS7j9Ojcz6ioaaUPxwklJ+Al5Z4jh/3w6Hm6ZjFYs2xzwkQZaAdrk/+Spddlq+Xx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRM+feyLta2KsJuwcMohSgB0ZvclH0KAswDI5e+IY3FjjSdfh
	Gev9Ix5DUNrydEpMxrglQbPFPKQVtYhUhx4sChCSRfI2QkakJOfreAaG
X-Gm-Gg: ASbGncslSwTW5lv//pycNUeVxlfZ2Y3PdMZFvucS2bowZumnkVKPh5fQ0vA+DaDrRh3
	eFu2HvLEp6cFdhKry5aDFwVSfe6BsgzbZZIa1sCIoUe/wom9IlqeIfgJHb+3ze95TdwXF9mjlaX
	OOgBYkXhddwwh69WAxrZ1skvfkNYM+XUyZ2hk609chnCodSGeLwxvnNuyJrkHuuzDsPHYFReyn/
	pAvyV5WiMkP4fbDMv3HAwQomA36GmEm1C+jh+JIsFtF0KPeczWUy5IWB9ZJZmNlEq48DLwzoKc8
	VEzrANke/qbvsFeJWUu1I1VNnWvkswSkVsLbvVV3d7uLUtcXXJHlM6s9NHjb3hPxvMnL5URujyH
	r0DbqK343JsychA+kR5wRHAtGUtbtnS7XmPBc5HfYZRu/eYAs/XCwVGJPepMrlYwNwW8ygHKVtK
	vmERl49zGoyVcfPGp29j/y
X-Google-Smtp-Source: AGHT+IEmbu2Oq+eI39o+T4uA9OHsNgBlxQx43D24whybJe4Uoof/z/T6SCWomsjNpxxj053tcafmCw==
X-Received: by 2002:a05:6a00:2d1e:b0:7b8:c7f7:645e with SMTP id d2e1a72fcca58-7ba3c07eeebmr20196264b3a.17.1763431235927;
        Mon, 17 Nov 2025 18:00:35 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92714e298sm14608613b3a.34.2025.11.17.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:35 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:29 -0800
Subject: [PATCH net-next v10 06/11] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
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
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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


