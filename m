Return-Path: <linux-kselftest+bounces-43956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B315CC02F6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F519A7D2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44434D4ED;
	Thu, 23 Oct 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQWhhgZy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170834E75C
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244106; cv=none; b=hUvApsH6tHyTh7E829CH8nOMH8rslTvoDhyMhKTb6aE4vebIEpE+AMIz2Q3cDmQzCMOitLwT3Qv7Ij50dS+NjVcIULFh5uSkTefr0jtRGcnXGAKoh1L9QAwcvz2rvHPe7n01ntYsootTSwsoSe+0O+7VGi9cpibpkFMByK93nPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244106; c=relaxed/simple;
	bh=nCwFeZ8diIl+Vmg31T+GDQCeQIxohZr7CtqwP+S/5mU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLpIU4Mj6D5A+jYEIdSruhD6OsVEcTEMQEtvrYzyqA8nGxipfXSj/WOCtTrXGM2xivqit/SemLA9J/mb2945U3hiZqQvLVEipJ6mCWwjOUnMCrV5V5l2iEqvC9ckEaRZfCZFrPag6UuvcQ5yhNUjcKf4AioOg6CkT84Z0WuXvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQWhhgZy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so887710a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244097; x=1761848897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTSoHMa1ECvViVefFGUUb5Kl2E+j9pc5hHuWE2XXc6Y=;
        b=MQWhhgZynm0v+4efubT77xG/483p6T6H6EOO+0nw5WSVSbZrfADAiTFmdTlwEUqE2h
         gsagKmxvns59AZI2jhEZJJ1/nNT3cw+Dpo1hZRLCUwQCVeYivjTnsQOZOhC4xIHUvPtK
         yf7r/rlPFu4sA71Ww2qCeQPxQzC5owyRD166c6pTsM6u++xx+dc1YhMobKz2WN2egRBL
         gK/UInaF6f9TpQ//h/NYxyjhj8bu9QC691lZcidDCWWig13cYMcGIXGVMdSIxMVqB/E/
         6GPjL1XAJylML2z7SS58QEM0yTL8MUtR8dqg9OHC17R7UdJPbJjFpFpft5Ilh9/VQxza
         1b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244097; x=1761848897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTSoHMa1ECvViVefFGUUb5Kl2E+j9pc5hHuWE2XXc6Y=;
        b=lEXXamIlW4dRbdezeQ0mqmcbGK2suLdhU4sQpVOR0Tvli27ZWlCiTbitOHvL+E7CMW
         k7g0R67UEpVrlm6fOHtCw9xu/Y9/gFrYw3doSP+cZTUnR8UfEFfAGZdew/TUl4jiwPy1
         iN4D0Xhyv/8cZsCb3QtTXdmCj5EB4oJuz6YQ26PVGmulfBV+mrMk+SK+B3Ha2VmCshbo
         m4eo00+UeSFEhUvaovMu29hk7fSB9nnnvL6SovV0T0vqNLfqUggtEQfI6mNFS12nw4eq
         kbR4FBYukbJcW/HBX7siiJ+rBxTkK4QW01ZFx3s+nVA2d8W5WGulvpBJPbAiKOA3Xze5
         qYtg==
X-Forwarded-Encrypted: i=1; AJvYcCWTT0YtxPKcBl3wrQnjIrvOLMufIabL6Gq8FxjSHpZCtD8M6SW/rUKosit3wRu3qr+XzOe2Vhs29SozVh9w/hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2F7Did2dpWrE9SkEuiQB1HJlYy2+YIYb6Stka76xfp8Pxmlct
	4yMAOyVMHDqoDDIo/oiYOSKKMTbExPLyWdrER9iXJlR2651R15HXZ6Fc
X-Gm-Gg: ASbGnctnAmjvTpjL7st/ifIqY5RE720ZEzSTjg6AxsAsRmmANtmE2ZusyHjOMheSYWo
	tBSxrtTnthcMlMS0YF3n06Cej0Wqp2F7G/KaswB9A+Lk7L/8djxPhSH761hfZXtLW5ro9Utxwus
	ja258rG6WRLlg5W5nGsOvnIFQgjfxV4aLAqH9zdgH1c7LdYeW3QF1BiDqln/FUF4cQh4ligBvnn
	7tdmEMiIzZieQfH7UNeGz+OAU/ffkumWO0eNBoEhfRkG7nXwgbxH1fcEIT8tpJFR9AOvxPSQv8m
	zdfmxMR1V055/YHf6T8U+eET/ryUe09FTC2BW4L17qAfXoM9DrUhCT0qMbMAEKGbculBg8QWaks
	yiQnPFK9w6rW0AZDJDmG1O7mEFhiU8kqzhcET/+2m8EyF7RVsL4c1LL4rHr5lXpxt9Gm63uKkGW
	1gfITOc+A=
X-Google-Smtp-Source: AGHT+IEfA/bSltyjOG9wZ+WmbSBtdgfkQrMpjZ6PQb1xglAEmOrL+4zgNNCU9qQD5oAa9hkC0DmEfg==
X-Received: by 2002:a17:903:2884:b0:266:3098:666 with SMTP id d9443c01a7336-290ca121a21mr213942785ad.32.1761244096855;
        Thu, 23 Oct 2025 11:28:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dde9880sm30458105ad.26.2025.10.23.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:52 -0700
Subject: [PATCH net-next v8 13/14] selftests/vsock: add tests for namespace
 deletion and mode changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-13-dea984d02bb0@meta.com>
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

Add tests that validate vsock sockets are resilient to deleting
namespaces or changing namespace modes from global to local. The vsock
sockets should still function normally.

The function check_ns_changes_dont_break_connection() is added to re-use
the step-by-step logic of 1) setup connections, 2) do something that
would maybe break the connections, 3) check that the connections are
still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 60d349c80153..014cecd93858 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -62,6 +62,12 @@ readonly TEST_NAMES=(
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
@@ -129,6 +135,24 @@ readonly TEST_DESCS=(
 
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
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -1143,6 +1167,105 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pidfile
+	local outfile
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
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
+	sleep ${WAIT_PERIOD}
+
+	# We use a pipe here so that we can echo into the pipe instead of
+	# using socat and a unix socket file.
+	local pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout ${WAIT_PERIOD} \
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
+	timeout ${WAIT_PERIOD} \
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


