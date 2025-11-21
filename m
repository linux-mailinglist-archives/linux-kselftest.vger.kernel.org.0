Return-Path: <linux-kselftest+bounces-46241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A004C7A4CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A7A7348457
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437A34C81E;
	Fri, 21 Nov 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuXDjSRt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Diif1gUH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD9A2E6CD5
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736301; cv=none; b=HcBfr4EX4iZJcta4vfKumJrZrCAWae8b0ZzvjUvtTMSCBnUbTgcuMtRCygQeBMiczF3rWPnCiuvIyMUMaTe3CQy4iW2D4dOiinMegDUu09rY0/nYp44M5qJLdXcaXZZUlM2j9HgO3RGC7woF6U0Mbss+2UKOyRmVPMBLO9Mg5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736301; c=relaxed/simple;
	bh=LpHCzjPaaom0joBAVNNBcfd3LcwKpZxbH6ef2oWlCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDgO/7NxjNXrMO3sk5t3uBMy9LKmZq4c3XH6mRlJL7fCMCtFk1WUdtA05UbyS8VcdOn0YP7C5P+UXCqCsPVOueal1IkSFA2LCuLkQLl14O912oLqVc+owRntoQaL0qT9FItiNjuuINEoPAVoXFbxmFal43cxno+hG+6Zn//hcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuXDjSRt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Diif1gUH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgxHT5eune3fdqhzxzVzF3lvCJWC4Oxvps8mZB9DCRE=;
	b=PuXDjSRtMJriVWJEDeyAYAye6aVBtOtTE6AJkyIg7DO/WstB7y0UrkJ4KfTuOQhGsvAb62
	8iAYMuds0fbKpkhUpS1s1TqYwcDBqnsppYDu6nYC7OQplzBElmBKc/r7f2AXCABCm0r6k3
	QyuEVTWLdf3ab1LF2cw5TydfQfOJrXA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-eOoB95sgONWPYdXHtmTdQw-1; Fri, 21 Nov 2025 09:44:57 -0500
X-MC-Unique: eOoB95sgONWPYdXHtmTdQw-1
X-Mimecast-MFC-AGG-ID: eOoB95sgONWPYdXHtmTdQw_1763736296
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477771366cbso12938555e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763736296; x=1764341096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgxHT5eune3fdqhzxzVzF3lvCJWC4Oxvps8mZB9DCRE=;
        b=Diif1gUH2r5n7ETnZBnwfCzDBmJVTV+IdYaYcGl2zpPGdNnyiPRPSclgdWDWDOZRfE
         x9UjpQ/81G7D7d+OI5xfUE3EIEm5inMabGahd+8Js8ff8wLRZWUnr+ALDO/wVgzH5c0c
         8DP27rBYcMSYe0Sd97TJsDEqAcjcRi5aXh18dPe6Onxjryrx+uW8ALnoZMYC4VcuJ1tf
         07v9hh1lrRkCN3wOM8cC+YLBcsi7e4Sic/GRTZUMR2CmOrQk5707XriiZ2dTpJewVypg
         jBV1hRlZlO5a/YRTBF3gHJ4xBSL36Y220thEs+F6zouUGpsvDyeFTTq/0VTlVPvZnyKD
         zmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736296; x=1764341096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgxHT5eune3fdqhzxzVzF3lvCJWC4Oxvps8mZB9DCRE=;
        b=fAN0aXMyidO/DHFPYsZItp+qd5EG1Joetz4kCL8sLOr6AcuvlgYZ7MhzvngwnvtCA9
         3DRUObI9+H3wMnMpsDov5n+mF0zgXGlqVi6T4LZfcDUlucephQ6NOujVVHtmTWWjZ3tU
         C4B5VgtILYpXNbjExUo9vyVGh/tAaMsV5yqwPUAJJR++aU3vJBOtL2ilwsI0OiP4hego
         /HfLmDBESkUkeOVDTN9zNzgbzQ2oLx0iukYUoMOaK57mb/CJd4QICx3ixlb1dV19iSNz
         bJ4tBSIfkyHnLYAQms6/CgJ1Ms40M34kcnRr/3Sh82p6fqTCSI4ZyxzgSGEkuS1qI36w
         tr1g==
X-Forwarded-Encrypted: i=1; AJvYcCWes3HfBlJvQJP6ZZo7Zstfp8eYdqi7hbSJC241Q9/tS8moPkNI2wuWWdgK8WJnTU0SH63dvue1ctTzuJQ0tHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5RIMazEkFhJBbxwLL79QepJVC0OSsIe1ceAcrMm7aovwR7yrC
	s2W5l1p0meVyKUQRwTM8GdQlsExizv1wrFQKwRWBMP8AXPge4xED5Yi3nrb9YqDR/OTiYOMtfio
	RZFRQmKgxoOo6PsSfPgz8UKBBT6wJZLZaXHb+FvONNT5vj2oSliUVuwrqp1TDR4ndXF4jcg==
X-Gm-Gg: ASbGncscR46r5TQtjmDAii//vGOet8TApB4k2NRfyZmtotAd8h3Vegd2a7puExXege0
	P04w5mIozAcdMML+Ia+3ttqI5/G66FoIxBKJWFw1HITPO9sV5eLheAPUf/loIaMfH4qcdS58ByW
	VkUxle3wxOlXf43/2DrKGvW2HOqnsWGln/THKYX6uJqRKX07vxzWFgkFctQXhsN/F1081F+HQb0
	MTNNi6mgznxhj+jh5ItdMijefy1TEDAIk/HxAcx6N9Q2I0sGvnOrA7E/QeUBkIWH+sBsh3Ostl7
	HxWkuzgRkuOhlcEOybqxMHu//qbKU3hoX8F+8a8fUKZs0Z3kmqClSRBENlecWcMHaxdOz1W5dxW
	EniW2kFN2d9DR9GZA76wv4hMmd4IH6YhZOHGmS1FCNfCdWDgX36m4uQBXKO4i6A==
X-Received: by 2002:a05:600c:840f:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477c0176752mr30427775e9.12.1763736295834;
        Fri, 21 Nov 2025 06:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhQjxwhyo5mB3NzlUCXU/sejEOwPO9R/xIuzqaGzg0yODnw+n34JzOmiJ5FkYPMcPfuVw+Aw==
X-Received: by 2002:a05:600c:840f:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477c0176752mr30427475e9.12.1763736295264;
        Fri, 21 Nov 2025 06:44:55 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e556sm11270319f8f.5.2025.11.21.06.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:44:54 -0800 (PST)
Date: Fri, 21 Nov 2025 15:44:40 +0100
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
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 10/13] selftests/vsock: add tests for proc
 sys vsock ns_mode
Message-ID: <vkbkaqlc2zqltg5h3murtghok4jdlsbcynz5mir3hrky3ancus@3gyjwzplok3z>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-10-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-10-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:42PM -0800, Bobby Eshleman wrote:
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
>Changes in v11:
>- Document ns_ prefix above TEST_NAMES (Stefano)
>
>Changes in v10:
>- Remove extraneous add_namespaces/del_namespaces calls.
>- Rename run_tests() to run_ns_tests() since it is designed to only
>  run ns tests.
>
>Changes in v9:
>- add test ns_vm_local_mode_rejected to check that guests cannot use
>  local mode
>---
> tools/testing/selftests/vsock/vmtest.sh | 143 +++++++++++++++++++++++++++++++-
> 1 file changed, 141 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index e32997db322d..2e077e8a1777 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -41,14 +41,43 @@ readonly KERNEL_CMDLINE="\
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> "
> readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+
>+# Namespace tests must use the ns_ prefix. This is checked in check_netns() and
>+# is used to determine if a test needs namespace setup before test execution.
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
>@@ -205,6 +234,20 @@ check_deps() {
> 	fi
> }
>
>+check_netns() {
>+	local tname=$1
>+
>+	# If the test requires NS support, check if NS support exists
>+	# using /proc/self/ns
>+	if [[ "${tname}" =~ ^ns_ ]] &&
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
>@@ -528,6 +571,32 @@ log_guest() {
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
>@@ -569,6 +638,26 @@ test_vm_loopback() {
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
>@@ -601,6 +690,11 @@ run_shared_vm_tests() {
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
>@@ -654,6 +748,49 @@ run_shared_vm_test() {
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
>@@ -699,6 +836,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
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


