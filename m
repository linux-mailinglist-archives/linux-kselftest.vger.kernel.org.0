Return-Path: <linux-kselftest+bounces-48827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A935D166DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 04:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 516F93042916
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC27731B117;
	Tue, 13 Jan 2026 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHW4Jb/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42A313E14
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273984; cv=none; b=tHl0sBeAscm0GzxWFzKr+EamOF0gW6Wlw4RPDFG0/uVOivVGs4a3NhJ/oQ7J4f9uMp9KfFx8sl6A3oClMkU/QEo99+Lxqo7A8ZXnJQ6I7eBiVVo58++09mn/8yMYwIAHzAnsY7JCMai4/gEXWVE6U/jfbq95ke3zWzZ3CTi8mos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273984; c=relaxed/simple;
	bh=A/Re4uBOGGe0FAXjhpo7AUAS6ISO6mznmR48rNydg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rdk4I0dnK0iuMRUyZXHutSqYE1dDfpDwEiZZJ2Hu6STdqUgPBNhHes7DhEStU38CK+SM90+IXCVvvR+Yimrm9Bnm9U6nuAv/SEePRgtCAXLzM8iJoUxVnSBW+GmJ239alpnc8ivKLxdgAKY7CnwBTyLw5xl1grcuKgQW9g8btNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHW4Jb/8; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64472121ad5so4851097d50.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273982; x=1768878782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=CHW4Jb/8fhd5vJDUj0zjCR2kjTvWSiK0d5E8xEs03aJjnzCJ6tJ/I2pf79/Ya7kaF6
         eZq4DmXtNQE4JDceVHeRAqHQsQFnRbTCx92onB9wVEHw+Z5jHz5D/C5lxsvWs9z8Ol2b
         KyROrKD3/50bMehrdeM2s9ZfO9LGQk3myUPkpp2IBByANYh7VtGsBgiU+SSIrfheOG2p
         eXkpigUKG+k5RLuEEyWFPLQcIS1cGiwR8ISMG54hu0/ZOw4Snis0+k89XFPjO8bUHrKQ
         dtqcaxl4v18oK/TlXWDaZla0g3ThPrkI5FGw3aedBtDOh9iD29HR22EzYJfbLITUjKew
         kIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273982; x=1768878782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=fW7+VuzkpfR2sCyACKnJvfIPssff3TgALZ7jTSMk0vVv0wtuxBuDLf9F3v+xTAEl0r
         1RbD1j3i8MFrAQPRJDLOj0H2PpNP6iRthwRDotRNMkF6ug7svmMQF8i4T+0BXNWH+Hi0
         v5Q/vX0oXQSxU8wvEucLOsObmPRIEfJOXKzj165Tqx/bGh6TdLYfDD6NtOU866/2cmdT
         sitiCQAUKt4e/lCLevaODfoQdjMDJhgWbTSvPGwav7Zhyli+sqy/yB3FW134hTLvf8hH
         yBRhcV0RP3jlwovAMsLB3m07BSDBIVzLDhikjoUA+u9aNDpOlkKiWTIcHUCKtcNzU5ln
         XFlg==
X-Forwarded-Encrypted: i=1; AJvYcCXceVKZlLb+/ZNSAqpnM6/udKhubsWQ98RoDTEYOQIl3ecGxjk7RFxWgA0UZp5xLDopnqy5lhmU8e/tIIx54kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKPJDUd0Ynp++dMiuGary09OfZgjPZdvkITFkxCAGFjpJavaY
	WOollT+rP6NzosdI924ldWgrz5uZ+tBRx7KH0/m8Dpb0EokfJZsrBKzh
X-Gm-Gg: AY/fxX7y+RNwMFwyHxbHA9ZKofX5YQJLfXAE7O2532zxPpjcDSOQfVk911a7OZ+wY0h
	hQ0Zpk+pOKjmhv5PGo68OOPaU6X7WzZDR2jk9SiYah0q3h6WYtAlkxPg8xR0bJpe/3CfDGApTWp
	WnE+NmW8MALe+xnS23jUGC1VwCTVZIpKurIOzNdmAaO5v3REyO/96yeTQYnlCAFEeu/3xB22tHc
	q3/jiI2qZNznnQuTMqN3fnlO0sqm6xBxpGECG+PIUxjMeMs4wtialZsWjlumamGYQmdIbzmI18E
	DFUqgB2u120T+LrPBKjm52zgptQkOJGOGA5nIXoAU+Dp85YLwyqNdKOLgXVPgfvXV1H7olr4man
	Hob8m/G5+7FElLERiJeoW5ULyIledfob5h0ZROS6k6dKJcdZxwfCsMbiiui3b3ss6BrYydLN1Jp
	2PoSradyS0bg==
X-Google-Smtp-Source: AGHT+IGkQoS0QBXW7yISdzqc/XM0pcHr9WRNy/nnkdRa0saRQjs66Xbn3T42Y7YnRdRrb2CT86Wdpw==
X-Received: by 2002:a05:690e:1907:b0:644:795a:391 with SMTP id 956f58d0204a3-64716c67b3bmr15939380d50.60.1768273981699;
        Mon, 12 Jan 2026 19:13:01 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b246fsm8746996d50.17.2026.01.12.19.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:14 -0800
Subject: [PATCH net-next v14 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The add_namespaces() function initializes global0, local0, etc... with
their respective vsock NS mode by toggling child_ns_mode before creating
the namespace.

Remove namespaces upon exiting the program in cleanup(). This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- intialize namespaces to use the child_ns_mode mechanism
- remove setting modes from init_namespaces() function (this function
  only sets up the lo device now)
- remove ns_set_mode(ns) because ns_mode is no longer mutable
---
 tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..c2bdc293b94c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,36 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	local orig_mode
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	for mode in "${NS_MODES[@]}"; do
+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
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
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +141,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3


