Return-Path: <linux-kselftest+bounces-45907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D4DC6B25E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 928A524212
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DCF3612F0;
	Tue, 18 Nov 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9ITP2W4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRGoU0qO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E683612E1
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489637; cv=none; b=j7bG5h/aYOaVv7RI9GIxFyE8LpHJAIg6x+eXG9fGugX1NXml1f/n80KMBdyycPDUMSrHTaLxgE9BJFkqRcKmlKpWg900yLJXrInFZ2IReoGLMxSBI2/5AIBn0nLAus+IoHI2gRZMSbHsdNiVPTouHz75FF1Jd4jVKkEcOUZHKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489637; c=relaxed/simple;
	bh=t3HokRBvzk92tWqhfXFr5XVYUp8FzOUrOhuoJpPP+58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGgdJNWz6lGaXvcFX0LTPkiUpoNN7/zuIFI/ZkPglzmgz6G/+Mv+wsJbttAehtdVmjaL1pPqYng0Qcn8XtJ/jgeLqSWUJ3eUqQxHBi9tg0NmfmQdgv+fA8lAgE0UDgQ3NJEmC+DPiY6w87yTxqQ+uCg7Thbje3BBb6NExgbEhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9ITP2W4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRGoU0qO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
	b=f9ITP2W4itMRRUC1zNHUBPOywkCsLJg8uQ4gRF8chYn79Cb6qwpB380o8J7pmWFA6+fGTJ
	8lM15NTBfVG5j33OAhd42os/IVoQ5TYVTBLyWNx/vCjbHHvV6SB8Zelav/RAEJLvw8irpG
	+o6un2Yi58U+SIxjw/MgdqtSC7FTgdw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ft6v7zVHMpSii-hUMLX9KQ-1; Tue, 18 Nov 2025 13:13:48 -0500
X-MC-Unique: ft6v7zVHMpSii-hUMLX9KQ-1
X-Mimecast-MFC-AGG-ID: ft6v7zVHMpSii-hUMLX9KQ_1763489627
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a95586f1so9428635e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 10:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489627; x=1764094427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
        b=TRGoU0qOXQU59sd9K2fP/n2OpgYgX6vk4aAVcnK6n0PQLCVHrkDp8e4ccJuGIucWSp
         +wP4TRu3xEn7eVd2SxQRVijOMQaOUoklxK5v8PgBaXKFvPLuq4IeuQ2ZPtrSgZPgW908
         lyWelKTRtA0uC5MDuCXVkhqr3Z2w3v658u5zEpUB9ktjzE4GUpnAFWeCWyJ2mod1RDUt
         parzrgU6jAppwXYYgom3DVF4obWZoKkPGWjNknfxHFj2hHzxFVyobgdlbzdlfAfYs7co
         FplfLxKwERyMpF0W56IqeFCFqdgxrlZB3IZ75uzahJF7CBDlD67iTtrpbUdBjV8wU2Tg
         HO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489627; x=1764094427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
        b=JPl2kVGhDW96rYkM+xm8l3EYXtWxLG2i2iVQvEQNX+n7tBQuqPbkqGtQ/WM9Sw5LcK
         dCyQBQdHd6rdZVMWb8FOOgdD9yOo7T1kJULHBfKoT542fRhTtFt14btcymDScLAC9XQ7
         Lx8I+eKpGPrz1L9qElmds4kwPdW1lwlZR3sVa6J4vYZ7nfBioKcRJwG15xxsFCdFqdyM
         VpTePfRZhqnpdSQz967M84Yw+Kq2B6ElMeJNKSjK7ENtH9CUMDc85CIGOUw+0DQwlZHA
         Y8YD0yXwrXmDdLvlBqSNWDcvk8BflfSsm9VG9TYIzIsjEX0VLlX8gVnQz/aXlJAey8Zh
         IElw==
X-Forwarded-Encrypted: i=1; AJvYcCUkmWZujNZhET5rq7Mxwph8unKw1sS137jkwyt48SL+2lpX/9ZwyYL4avziM8RimuZdBME9ltBUC7ogXINM17U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjswdIemCrddlc3/99bykyZJt10YobLeuiM51tEKamCY75nvpl
	B9FyQteIQqE6x6aVE9A+bC9jPOgvGI5mCEV2Zx2SDZj+sCn3qx+iYSW+bYyKyhJVUfnrUrYDmNa
	27KjitGFHQGwaKhnaMfbl1mZVQcemLXUnybKToojcneuv/yurh+kaYJQbtbF8FZB21pnPLA==
X-Gm-Gg: ASbGnctOPntCYt+8G9F6n4W+bQhyHZ/GyyqI+C36neJD5dlCOk/N6fxWfJCjsbKy76b
	SUdlYQclAkylPtZ8wZloLr6gYyUH1egpT85F55dvOtyrAijPXlTT3qCe5bT5bSN/0dqRMQPng+s
	ZleJq0nVoF4iyktL+jj5wEOKVSAIbW+YA28Bc1ITBvKMoTqYup4Sk810Oofzs0wxzxT0tYWgEsp
	rHZR4VDXSuISUoIOk4wGyQ2Btik+rj+BQdz+/HYO3Ows+pJ6LdcYiFUAr8T8v9yxtHVTI9lyKBm
	FSQ/qeUo/hPHnJq5ZS26+HN95AMvYdLUJJvtUzLHkqfi1Hq6gvNA3eRjFLDK11Q6vPiMVwmMhD9
	s/E3XsNffRLk756snUywd0GlYjopsYerN5UAvWh/gfAjT2ULmhd6pAr2h+58=
X-Received: by 2002:a05:600c:4fd2:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4778fe4fa18mr162302485e9.2.1763489626902;
        Tue, 18 Nov 2025 10:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJW+/iuChgFRraW70MIR1TDXfcEwMvm+w71wLHAdMua0RyeIpmzX027JJ8Fn6LsaDHZf5jnw==
X-Received: by 2002:a05:600c:4fd2:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4778fe4fa18mr162301985e9.2.1763489626387;
        Tue, 18 Nov 2025 10:13:46 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1022a32sm5350695e9.8.2025.11.18.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:13:45 -0800 (PST)
Date: Tue, 18 Nov 2025 19:13:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 08/11] selftests/vsock: add tests for proc
 sys vsock ns_mode
Message-ID: <4xfytzvgzk55cl4xbe7if56yodshsevfgvc34ubiwb5ozr6arn@nksp3rfq7jm6>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-8-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-8-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:31PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
>that it accepts "global" and "local" strings and enforces a write-once
>policy.
>
>Start a convention of commenting the test name over the test
>description. Add test name comments over test descriptions that existed
>before this convention.
>
>Add a check_netns() function that checks if the test requires namespaces
>and if the current kernel supports namespaces. Skip tests that require
>namespaces if the system does not have namespace support.
>
>Add a test to verify that guest VMs with an active G2H transport
>(virtio-vsock) cannot set namespace mode to 'local'. This validates
>the mutual exclusion between G2H transports and LOCAL mode.
>
>This patch is the first to add tests that do *not* re-use the same
>shared VM. For that reason, it adds a run_tests() function to run these
>tests and filter out the shared VM tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- Remove extraneous add_namespaces/del_namespaces calls.
>- Rename run_tests() to run_ns_tests() since it is designed to only
>  run ns tests.
>
>Changes in v9:
>- add test ns_vm_local_mode_rejected to check that guests cannot use
>  local mode
>---
> tools/testing/selftests/vsock/vmtest.sh | 140 +++++++++++++++++++++++++++++++-
> 1 file changed, 138 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 1a7c810f282f..86483249f490 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -41,14 +41,40 @@ readonly KERNEL_CMDLINE="\
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> "
> readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly TEST_NAMES=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_host_vsock_ns_mode_ok
>+	ns_host_vsock_ns_mode_write_once_ok
>+	ns_vm_local_mode_rejected
>+)
> readonly TEST_DESCS=(
>+	# vm_server_host_client
> 	"Run vsock_test in server mode on the VM and in client mode on the host."
>+
>+	# vm_client_host_server
> 	"Run vsock_test in client mode on the VM and in server mode on the host."
>+
>+	# vm_loopback
> 	"Run vsock_test using the loopback transport in the VM."
>+
>+	# ns_host_vsock_ns_mode_ok
>+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
>+
>+	# ns_host_vsock_ns_mode_write_once_ok
>+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
>+
>+	# ns_vm_local_mode_rejected
>+	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
> )
>
>-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly USE_SHARED_VM=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_vm_local_mode_rejected
>+)
> readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>@@ -205,6 +231,20 @@ check_deps() {
> 	fi
> }
>
>+check_netns() {
>+	local tname=$1
>+
>+	# If the test requires NS support, check if NS support exists
>+	# using /proc/self/ns
>+	if [[ "${tname}" =~ ^ns_ ]] &&

If check_netns() is based on the test name, IMO we should document that 
on top of TEST_NAMES.

Thanks,
Stefano

>+	   [[ ! -e /proc/self/ns ]]; then
>+		log_host "No NS support detected for test ${tname}"
>+		return 1
>+	fi
>+
>+	return 0
>+}
>+
> check_vng() {
> 	local tested_versions
> 	local version
>@@ -503,6 +543,32 @@ log_guest() {
> 	LOG_PREFIX=guest log "$@"
> }
>
>+test_ns_host_vsock_ns_mode_ok() {
>+	for mode in "${NS_MODES[@]}"; do
>+		if ! ns_set_mode "${mode}0" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_host_vsock_ns_mode_write_once_ok() {
>+	for mode in "${NS_MODES[@]}"; do
>+		local ns="${mode}0"
>+		if ! ns_set_mode "${ns}" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+
>+		# try writing again and expect failure
>+		if ns_set_mode "${ns}" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	return "${KSFT_PASS}"
>+}
>+
> test_vm_server_host_client() {
> 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
> 		return "${KSFT_FAIL}"
>@@ -544,6 +610,26 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>+test_ns_vm_local_mode_rejected() {
>+	# Guest VMs have a G2H transport (virtio-vsock) active, so they
>+	# should not be able to set namespace mode to 'local'.
>+	# This test verifies that the sysctl write fails as expected.
>+
>+	# Try to set local mode in the guest's init_ns
>+	if vm_ssh init_ns "echo local | tee /proc/sys/net/vsock/ns_mode &>/dev/null"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	# Verify mode is still 'global'
>+	local mode
>+	mode=$(vm_ssh init_ns "cat /proc/sys/net/vsock/ns_mode")
>+	if [[ "${mode}" != "global" ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>@@ -576,6 +662,11 @@ run_shared_vm_tests() {
> 			continue
> 		fi
>
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
> 		run_shared_vm_test "${arg}"
> 		check_result "$?" "${arg}"
> 	done
>@@ -629,6 +720,49 @@ run_shared_vm_test() {
> 	return "${rc}"
> }
>
>+run_ns_tests() {
>+	for arg in "${ARGS[@]}"; do
>+		if shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
>+		add_namespaces
>+
>+		name=$(echo "${arg}" | awk '{ print $1 }')
>+		log_host "Executing test_${name}"
>+
>+		host_oops_before=$(dmesg 2>/dev/null | grep -c -i 'Oops')
>+		host_warn_before=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
>+		eval test_"${name}"
>+		rc=$?
>+
>+		host_oops_after=$(dmesg 2>/dev/null | grep -c -i 'Oops')
>+		if [[ "${host_oops_after}" -gt "${host_oops_before}" ]]; then
>+			echo "FAIL: kernel oops detected on host" | log_host
>+			check_result "${KSFT_FAIL}" "${name}"
>+			del_namespaces
>+			continue
>+		fi
>+
>+		host_warn_after=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
>+		if [[ "${host_warn_after}" -gt "${host_warn_before}" ]]; then
>+			echo "FAIL: kernel warning detected on host" | log_host
>+			check_result "${KSFT_FAIL}" "${name}"
>+			del_namespaces
>+			continue
>+		fi
>+
>+		check_result "${rc}" "${name}"
>+
>+		del_namespaces
>+	done
>+}
>+
> BUILD=0
> QEMU="qemu-system-$(uname -m)"
>
>@@ -674,6 +808,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
> 	terminate_pidfiles "${pidfile}"
> fi
>
>+run_ns_tests "${ARGS[@]}"
>+
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>
>-- 
>2.47.3
>


