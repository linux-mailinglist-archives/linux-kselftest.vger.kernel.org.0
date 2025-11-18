Return-Path: <linux-kselftest+bounces-45820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDF3C66F04
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1463A29DAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D4331239;
	Tue, 18 Nov 2025 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZNODQ4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71930328632
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431248; cv=none; b=hUAoakt/1DcUpLtkYWHfPInP5PU9gkIAxoPxbwk569mpTleG2Zlkgo+I7rKndMsETNibJC8AYbEh9NxOm2+iCcIM1t+w8tvQUBFg6OovG1uPbrd8nPY/qP9PVF7+vzOLYlhoBTXGftQZ7Z3XmA6k3bev+gvzoNeQr+cCDLy/rsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431248; c=relaxed/simple;
	bh=GOHovVPP3sa3rEV3HpfajQ6Y99pnpQNi1sXPkKn61uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nefQCeiaJri3UxPLQQ/b6NEnvFcYtFAcIWdTvm8HeeawYHo22mlgRnVdQOa+zL3DaYGRWiAjRIvjwk5R6QRQKIEmP5ZcGL3BIY4Q3dOfskltl77P5Xx4lrSPs6QHVnI4byxZUtTlgRwAotZqRptjcaYdg9/gIK+7DiFvOzZa0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZNODQ4H; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3437ea05540so4652392a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431241; x=1764036041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojZg+AuTuP1uKFswsO3FbXsz8LEDmbWQ1i6mei7DtIc=;
        b=nZNODQ4H2f7XTLYLGw02jIujpFewzLlQkk+2XthbzqMnBO/sC/MjK52J+cPNhdAlb3
         QQgmza5nhSi362YGfWUSoTZ1hm//7JHD7Luf/jQdobw5/6jbjVHTkRYIPM3DHERfSrk2
         rVlg82c9iII4zIS8C6lILgO614pG2ZKmo6Q2vhIdjHUZLtZCAeZArYpFvOAzXDbkgPPn
         4Oavt4W1aPXmmvBK6InivMMrA0fZ+yVhfNhAZlBqmoP7wJkn29AVuaZFNyXPufWDYrjw
         2IrtKqofF8ivybf7gb1KdwRKhz/wqCPHji+Esc86k1GHxkUBdLe05tBz6T9wJdsMuRHh
         7LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431241; x=1764036041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ojZg+AuTuP1uKFswsO3FbXsz8LEDmbWQ1i6mei7DtIc=;
        b=IeUIhATlfg6ePZ1Shmc5BTilsDNxrRcRhi2T4V2bWAw1CQ302BK6wmNrW/lrf7u3hN
         4+5f7VfFWxWhT8TBs34kVvRWqULe89VDYuq+RerUC2qAYhZdqz/tZLyodZRXwsJK30Jz
         sMFcDBOpHrJAc3t7zLWRiV+Y4/D0+fjob+ovQV1FaM2ZWSl/OZXY8nxvoDK6r0NgEDzT
         aAhIabSKZh8PG+FvBO7KanwI6+88uwSEIwVo573fBGLddEWnrEpW6AZSzfAqmjEgQpeo
         3LVqPMGlMOharh1kri9VPEWmmprIBYqVZxU9Ot3XnNIEv66yxVsHa1yDepCeZDOD2qEf
         rGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpyla37ZGORAROtFnEx0LIPxXYEkf1efY/LuW5T1SOfzvngN6w7IDLuVapMQnxABPFrIfsUZfTwT3bMKl0vyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUnHWkX5hTUVz6OeHEgecohKBuRubxhSejEf6UGJWHRrFxj2t
	NPpOaJu8e0p6ixR2isOEATHQeVzFBfM5YMUmU/SAJHgvxUh1QK5Wru+v
X-Gm-Gg: ASbGncsUICaMvJ/iRpW5Z8D/vaTzBuMY4KlG5/WPgAUqo+IF+9GQPzstYXuYfJIIUhu
	8dxaOw0cADro26O3w0FmSfN9LS3cIMIvQwP1SyOR/EunbYfCX4l9l4Y9mhqwUNK2JBAgpGFrGtV
	T1R4JYedq4uZXcd3TNu2OMOB1yOa4MRwrUlr1NSY0F4FWHGKYJRJTff0u6yD6GWT/o62zYZYk7G
	3xPkGTJLuJECm4MbN0E6YlRj+9ECcYaT0iuvkzGG/dTwkBwwGRfjCDaf9pqxuwUYMJRnd2RqFnY
	NgbD/Ftzy/pEc7m/d//yoleIxX/OIBlJBd6S4XJcodF60WGsixai2Xd/ggfHgHItu0UwIWIbkxF
	RW4pAl1WeJoe1zMMCEmj+LV2yL4Vc/QQuaffblbV8QbSo1D2H6xTsYShhBcYZ+ofeYJ7iDrcaLl
	l0G0wX/K9jS1jDwt65ADaUII1/cpO9/w==
X-Google-Smtp-Source: AGHT+IFmXdK6Jbwd3vBn123y4KjundCkIApjrLwMuiHqG6Ct/ZwKD1VG2QzQPrnW/V2jQffbQoI3yw==
X-Received: by 2002:a17:90b:388c:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-343fa63dc85mr15304600a91.29.1763431241236;
        Mon, 17 Nov 2025 18:00:41 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07952f8sm19773658a91.9.2025.11.17.18.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:40 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:34 -0800
Subject: [PATCH net-next v10 11/11] selftests/vsock: add tests for
 namespace deletion and mode changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-11-df08f165bf3e@meta.com>
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

Add tests that validate vsock sockets are resilient to deleting
namespaces or changing namespace modes from global to local. The vsock
sockets should still function normally.

The function check_ns_changes_dont_break_connection() is added to re-use
the step-by-step logic of 1) setup connections, 2) do something that
would maybe break the connections, 3) check that the connections are
still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- more consistent shell style
- clarify -u usage comment for pipefile
---
 tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 9c12c1bd1edc..2b6e94aafc19 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -66,6 +66,12 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_mode_change_connection_continue_vm_ok
+	ns_mode_change_connection_continue_host_ok
+	ns_mode_change_connection_continue_both_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -135,6 +141,24 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
+
+	# ns_mode_change_connection_continue_vm_ok
+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_host_ok
+	"Check that changing NS mode of host namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_both_ok
+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
+
+	# ns_delete_vm_ok
+	"Check that deleting the VM's namespace does not break the socket connection"
+
+	# ns_delete_host_ok
+	"Check that deleting the host's namespace does not break the socket connection"
+
+	# ns_delete_both_ok
+	"Check that deleting the VM and host's namespaces does not break the socket connection"
 )
 
 readonly USE_SHARED_VM=(
@@ -1256,6 +1280,105 @@ test_ns_vm_local_mode_rejected() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local pipefile pidfile outfile
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+	vm_wait_for_ssh "${ns0}"
+
+	outfile=$(mktemp)
+	vm_ssh "${ns0}" -- \
+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
+	pids+=($!)
+
+	# wait_for_listener() does not work for vsock because vsock does not
+	# export socket state to /proc/net/. Instead, we have no choice but to
+	# sleep for some hardcoded time.
+	sleep "${WAIT_PERIOD}"
+
+	# We use a pipe here so that we can echo into the pipe instead of using
+	# socat and a unix socket file. We just need a name for the pipe (not a
+	# regular file) so use -u.
+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
+
+	if [[ $2 == "delete" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ip netns del "${ns0}"
+		elif [[ "$1" == "host" ]]; then
+			ip netns del "${ns1}"
+		elif [[ "$1" == "both" ]]; then
+			ip netns del "${ns0}"
+			ip netns del "${ns1}"
+		fi
+	elif [[ $2 == "change_mode" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ns_set_mode "${ns0}" "local"
+		elif [[ "$1" == "host" ]]; then
+			ns_set_mode "${ns1}" "local"
+		elif [[ "$1" == "both" ]]; then
+			ns_set_mode "${ns0}" "local"
+			ns_set_mode "${ns1}" "local"
+		fi
+	fi
+
+	echo "TEST" > "${pipefile}"
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
+
+	if grep -q "TEST" "${outfile}"; then
+		rc="${KSFT_PASS}"
+	else
+		rc="${KSFT_FAIL}"
+	fi
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}"
+
+	return "${rc}"
+}
+
+test_ns_mode_change_connection_continue_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_host_ok() {
+	check_ns_changes_dont_break_connection "host" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_both_ok() {
+	check_ns_changes_dont_break_connection "both" "change_mode"
+}
+
+test_ns_delete_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "delete"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_changes_dont_break_connection "host" "delete"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_changes_dont_break_connection "both" "delete"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3


