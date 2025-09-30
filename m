Return-Path: <linux-kselftest+bounces-42616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC8BAC24E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 10:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A672B1924E2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A022F3C3D;
	Tue, 30 Sep 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmR1+jRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D82F49E0
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222742; cv=none; b=fmBJMauey8Q/Jv1xjuJ1kdATG4kTXU57Kzdx41wcxTF5redCK/2H+XPAMdVUYccAgp0p/Yc9RnU46QvStI47RA8GVsFjtD4FPIdC0UFnWM+NgYYuF1edqUbaZivzJVtckSyJbzPeoJCHskaAKrbG6bs7A0DTnjoImC9Sw6+WwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222742; c=relaxed/simple;
	bh=6JlwMGxzLpiSCA2uDGbk6t64G5dogw0hZHDnZzQEjIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwR4J67gouXlbU1v0wyOeP1NNxQkP75okIeqR6vpQpMTzm6LDtNHEKV4omSE6xlcbZHRSqBqebkre6luVk61ucNN1V2hkuwcJt3Uz7NuOPkuW0iZM07/57JzF+8/45mcvI7vFccM/I4ZbjcjALslAJi6Yj/syOthZFN6dqt7zlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmR1+jRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759222738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEFZTFMEkCeYoOiu3Ja74ytkW5sySmVg18QSHKrWafo=;
	b=MmR1+jRjsrR9Gxwd42o76C3h/oBeVswP9M7eJdxY/+CnDJKCzwF68zoYY6UjAiLlyCIoRY
	X5ggjmG4sj3ydCJlx9F1afSEE50WDpaiHRrmyuxyGn5mK2dAmPlI4NXP/3vxKNrZrcOC7B
	C358sW4MiIRIirBX2WK1AsNJNAP2gvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-jUzes63nMRCiMFz_jSv6Eg-1; Tue, 30 Sep 2025 04:58:56 -0400
X-MC-Unique: jUzes63nMRCiMFz_jSv6Eg-1
X-Mimecast-MFC-AGG-ID: jUzes63nMRCiMFz_jSv6Eg_1759222735
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso17600475e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 01:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222735; x=1759827535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEFZTFMEkCeYoOiu3Ja74ytkW5sySmVg18QSHKrWafo=;
        b=O2Rymm0QMFEWIfHbP6yW+Ck852Lk5KHY1lZIzyq9uNHjv5ABXreeb+IfIch+u5wB2i
         BOnsTeZ1Lw6eWvTuEhKJRq8TYdAEnjAaUcE/Oqz8PFwBprqvOZVzZbhZO486QRYmIDkY
         8AcCgOiFdZMrPESbKNdeb8hDK4TncTamUfDUqagtjBAE4zvcaD8xfE76z9YTen5jf3Nk
         UXjunIUxTkKdZrp8O2uqkwm0NZutL8ovh2XRWNv0htRsdg0YI9LG2wZVpEd1I6DQZ/E0
         NYpOhUI0uwzAxRVKoe+UjShRLGgrPpmg5uW3GKz/QrI2mX6EMnQL2I8sXCT69iG8JGpB
         6T3A==
X-Forwarded-Encrypted: i=1; AJvYcCWVx1CfQyZUBZ57jwKCtsuwj6febOzI1kEX9PayLjt4LBRaMe7bj0in93xh9uO3bRoTUzOGQ/1aesRIFrRcddA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJMzJfrWz7iXxrR5GOEVI8g6WdyRMthzDYTVnj9fZsTGu2ml0x
	GX1jT1wVY++zKJn69mj2FisXzGg/7wori7yMbSm6yEB3FuO2i4XRmPhqaXgT+PF8jdoutlfTWGq
	NBAKxZcf3qglknU/hjDkSrHh3FyyovIQY6lmn0fqazkoH/68GXT4Yprch+3oRa7xRdIhxWA==
X-Gm-Gg: ASbGnctwQjUG+lo60UagH8PrC4i9Bv6ba9eBSB8yCYP1E5FKzL2PyqYDDdFMihLN+da
	P/fJgm28tFNhyYPwN3Jl9UaT8PqB6KebKHyHuHZsUaoBd/Com5wfpU5t3criyxieoQab6u9d/vP
	bR66B2eCiwcFuS3u5kbWeT/cd8nLobog0AW6JUkTjvwNojp3kQpt+09Uj1xQ8FhqzVz3FW1DZcV
	3RCfH4gdtQb5sxtMOWNVr0wJZKzLC5HT1ZK3fBYJsmklYuKZs0smQsowxI4aWRAsRR4cKae/RAj
	qI2tJi7JfRWE+tS2c+kS45CJc2+FteqXdThIgpT4nUIyq/R4CyPHTIBA39cnsexi9+uxdwQP/eg
	dJ6k27HNBZfRCH2Jq31lFdA==
X-Received: by 2002:a05:600c:621b:b0:46e:36ef:fab7 with SMTP id 5b1f17b1804b1-46e36effbf9mr144049385e9.24.1759222734641;
        Tue, 30 Sep 2025 01:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+POlWAOIijzmnwfZO7t+EqW2M691RhtbqTOrwUKdG+qUUft05Dr1XdalJjbAWVEIk5wCl9g==
X-Received: by 2002:a05:600c:621b:b0:46e:36ef:fab7 with SMTP id 5b1f17b1804b1-46e36effbf9mr144048955e9.24.1759222733959;
        Tue, 30 Sep 2025 01:58:53 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56ee6b19sm53799005e9.0.2025.09.30.01.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:58:53 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:58:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 9/9] selftests/vsock: add namespace tests
Message-ID: <5kgnein4cq2ymeq3cozevld3ppbzbv62usavfigpi33krqjqde@k3sn3giizzvr>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-9-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-9-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:53PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests for namespace support in vsock. Use socat for basic connection
>failure tests and vsock_test for full functionality tests when
>communication is expected to succeed. vsock_test is not used for failure
>cases because in theory vsock_test could allow connection and some
>traffic flow but fail on some other case (e.g., fail on MSG_ZEROCOPY).
>
>Tests cover all cases of clients and servers being in all variants of
>local ns, global ns, host process, and VM process.
>
>Legacy tests are retained and executed in the init ns.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v6:
>- check for namespace support in vmtest.sh
>
>Changes in v5:
>- use /proc/sys/net/vsock/ns_mode
>- clarify logic of tests that reuse the same VM and tests that require
>  netns setup
>- fix unassigned BUILD bug
>---
> tools/testing/selftests/vsock/vmtest.sh | 954 ++++++++++++++++++++++++++++----
> 1 file changed, 849 insertions(+), 105 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 5e36d1068f6f..59621b32cf1a 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -7,6 +7,7 @@
> #		* virtme-ng
> #		* busybox-static (used by virtme-ng)
> #		* qemu	(used by virtme-ng)
>+#		* socat
>
> readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
>@@ -23,7 +24,7 @@ readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
> readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+readonly WAIT_QEMU=5
>
> # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> # control port forwarded for vsock_test.  Because virtme-ng doesn't support
>@@ -33,23 +34,146 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
> # add the kernel cmdline options that virtme-init uses to setup the interface.
> readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
>-readonly QEMU_OPTS="\
>-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>-	 -device virtio-net-pci,netdev=n0 \
>-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>-	 --pidfile ${QEMU_PIDFILE} \
>-"

I expected this patch to only add new tests, but we are changing a few things.
Are they related, or can they be moved to another preparation patch?

> readonly KERNEL_CMDLINE="\
> 	virtme.dhcp net.ifnames=0 biosdevname=0 \
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> "
> readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly TEST_NAMES=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	host_vsock_ns_mode_ok

can we use a `ns_` prefix for all ns related tests?

>+	host_vsock_ns_mode_write_once_ok
>+	global_same_cid_fails
>+	local_same_cid_ok
>+	global_local_same_cid_ok
>+	local_global_same_cid_ok
>+	diff_ns_global_host_connect_to_global_vm_ok
>+	diff_ns_global_host_connect_to_local_vm_fails
>+	diff_ns_global_vm_connect_to_global_host_ok
>+	diff_ns_global_vm_connect_to_local_host_fails
>+	diff_ns_local_host_connect_to_local_vm_fails
>+	diff_ns_local_vm_connect_to_local_host_fails
>+	diff_ns_global_to_local_loopback_local_fails
>+	diff_ns_local_to_global_loopback_fails
>+	diff_ns_local_to_local_loopback_fails
>+	diff_ns_global_to_global_loopback_ok
>+	same_ns_local_loopback_ok
>+	same_ns_local_host_connect_to_local_vm_ok
>+	same_ns_local_vm_connect_to_local_host_ok
>+)
>+
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
>+	# host_vsock_ns_mode_ok
>+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
>+
>+	# host_vsock_ns_mode_write_once_ok
>+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
>+
>+	# global_same_cid_fails
>+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
>+
>+	# local_same_cid_ok
>+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
>+
>+	# global_local_same_cid_ok
>+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
>+
>+	# local_global_same_cid_ok
>+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
>+
>+	# diff_ns_global_host_connect_to_global_vm_ok
>+	"Run vsock_test client in global ns with server in VM in another global ns."
>+
>+	# diff_ns_global_host_connect_to_local_vm_fails
>+	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
>+
>+	# diff_ns_global_vm_connect_to_global_host_ok
>+	"Run vsock_test client in VM in a global ns with server in another global ns."
>+
>+	# diff_ns_global_vm_connect_to_local_host_fails
>+	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
>+
>+	# diff_ns_local_host_connect_to_local_vm_fails
>+	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
>+
>+	# diff_ns_local_vm_connect_to_local_host_fails
>+	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
>+
>+	# diff_ns_global_to_local_loopback_local_fails
>+	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
>+
>+	# diff_ns_local_to_global_loopback_fails
>+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
>+
>+	# diff_ns_local_to_local_loopback_fails
>+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
>+
>+	# diff_ns_global_to_global_loopback_ok
>+	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
>+
>+	# same_ns_local_loopback_ok
>+	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
>+
>+	# same_ns_local_host_connect_to_local_vm_ok
>+	"Run vsock_test client in a local ns with server in VM in same ns."
>+
>+	# same_ns_local_vm_connect_to_local_host_ok
>+	"Run vsock_test client in VM in a local ns with server in same ns."

Should we run some test to check edge cases like namespace deletion
during active connections or changing ns mode from global to local while
running.

>+)
>+
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly USE_INIT_NETNS=(
>+	global_same_cid_fails
>+	local_same_cid_ok
>+	global_local_same_cid_ok
>+	local_global_same_cid_ok
>+	diff_ns_global_host_connect_to_global_vm_ok
>+	diff_ns_global_host_connect_to_local_vm_fails
>+	diff_ns_global_vm_connect_to_global_host_ok
>+	diff_ns_global_vm_connect_to_local_host_fails
>+	diff_ns_local_host_connect_to_local_vm_fails
>+	diff_ns_local_vm_connect_to_local_host_fails
>+	diff_ns_global_to_local_loopback_local_fails
>+	diff_ns_local_to_global_loopback_fails
>+	diff_ns_local_to_local_loopback_fails
>+	diff_ns_global_to_global_loopback_ok
>+	same_ns_local_loopback_ok
>+	same_ns_local_host_connect_to_local_vm_ok
>+	same_ns_local_vm_connect_to_local_host_ok
>+)
>+readonly REQUIRES_NETNS=(
>+	host_vsock_ns_mode_ok
>+	host_vsock_ns_mode_write_once_ok
>+	global_same_cid_fails
>+	local_same_cid_ok
>+	global_local_same_cid_ok
>+	local_global_same_cid_ok
>+	diff_ns_global_host_connect_to_global_vm_ok
>+	diff_ns_global_host_connect_to_local_vm_fails
>+	diff_ns_global_vm_connect_to_global_host_ok
>+	diff_ns_global_vm_connect_to_local_host_fails
>+	diff_ns_local_host_connect_to_local_vm_fails
>+	diff_ns_local_vm_connect_to_local_host_fails
>+	diff_ns_global_to_local_loopback_local_fails
>+	diff_ns_local_to_global_loopback_fails
>+	diff_ns_local_to_local_loopback_fails
>+	diff_ns_global_to_global_loopback_ok
>+	same_ns_local_loopback_ok
>+	same_ns_local_host_connect_to_local_vm_ok
>+	same_ns_local_vm_connect_to_local_host_ok
> )
>+readonly MODES=("local" "global")

What about NS_MODES ?

>
> readonly LOG_LEVEL_DEBUG=0
> readonly LOG_LEVEL_INFO=1
>@@ -58,6 +182,12 @@ readonly LOG_LEVEL_ERROR=3
>
> VERBOSE="${LOG_LEVEL_WARN}"
>
>+# Test pass/fail counters
>+cnt_pass=0
>+cnt_fail=0
>+cnt_skip=0
>+cnt_total=0
>+
> usage() {
> 	local name
> 	local desc
>@@ -77,7 +207,7 @@ usage() {
> 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
> 		name=${TEST_NAMES[${i}]}
> 		desc=${TEST_DESCS[${i}]}
>-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
>+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
> 	done
> 	echo
>
>@@ -89,21 +219,87 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+add_namespaces() {
>+	# add namespaces local0, local1, global0, and global1
>+	for mode in "${MODES[@]}"; do
>+		ip netns add "${mode}0" 2>/dev/null
>+		ip netns add "${mode}1" 2>/dev/null
>+	done
>+}
>+
>+init_namespaces() {
>+	for mode in "${MODES[@]}"; do
>+		ns_set_mode "${mode}0" "${mode}"
>+		ns_set_mode "${mode}1" "${mode}"
>+
>+		log_host "set ns ${mode}0 to mode ${mode}"
>+		log_host "set ns ${mode}1 to mode ${mode}"
>+
>+		# we need lo for qemu port forwarding
>+		ip netns exec "${mode}0" ip link set dev lo up
>+		ip netns exec "${mode}1" ip link set dev lo up
>+	done
>+}
>+
>+del_namespaces() {
>+	for mode in "${MODES[@]}"; do
>+		ip netns del "${mode}0"
>+		ip netns del "${mode}1"
>+		log_host "removed ns ${mode}0"
>+		log_host "removed ns ${mode}1"
>+	done &>/dev/null
>+}
>+
>+ns_set_mode() {
>+	local ns=$1
>+	local mode=$2
>+
>+	echo "${mode}" | ip netns exec "${ns}" \
>+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
>+}
>+
> vm_ssh() {
>-	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
>+	local ns_exec
>+
>+	if [[ "${1}" == none ]]; then
>+		local ns_exec=""
>+	else
>+		local ns_exec="ip netns exec ${1}"
>+	fi
>+
>+	shift
>+
>+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
>+
> 	return $?
> }
>
> cleanup() {
>-	if [[ -s "${QEMU_PIDFILE}" ]]; then
>-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
>-	fi
>+	del_namespaces
>+}
>
>-	# If failure occurred during or before qemu start up, then we need
>-	# to clean this up ourselves.
>-	if [[ -e "${QEMU_PIDFILE}" ]]; then
>-		rm "${QEMU_PIDFILE}"
>-	fi
>+terminate_pidfiles() {
>+	local pidfile
>+
>+	for pidfile in "$@"; do
>+		if [[ -s "${pidfile}" ]]; then
>+			pkill -SIGTERM -F "${pidfile}" 2>&1 > /dev/null
>+		fi
>+
>+		# If failure occurred during or before qemu start up, then we need
>+		# to clean this up ourselves.
>+		if [[ -e "${pidfile}" ]]; then
>+			rm -f "${pidfile}"
>+		fi
>+	done
>+}
>+
>+terminate_pids() {
>+	local pid
>+
>+	for pid in "$@"; do
>+		kill -SIGTERM "${pid}" &>/dev/null || :
>+	done
> }
>
> check_args() {
>@@ -133,7 +329,7 @@ check_args() {
> }
>
> check_deps() {
>-	for dep in vng ${QEMU} busybox pkill ssh; do
>+	for dep in vng ${QEMU} busybox pkill ssh socat; do
> 		if [[ ! -x $(command -v "${dep}") ]]; then
> 			echo -e "skip:    dependency ${dep} not found!\n"
> 			exit "${KSFT_SKIP}"
>@@ -147,6 +343,20 @@ check_deps() {
> 	fi
> }
>
>+check_test_deps() {
>+	local tname=$1
>+
>+	# If the test requires NS support, check if NS support exists
>+	# using /proc/self/ns
>+	if [[ "${tname}" =~ "${REQUIRES_NETNS[@]}" ]] &&
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
>@@ -170,6 +380,20 @@ check_vng() {
> 	fi
> }
>
>+check_socat() {
>+	local support_string
>+
>+	support_string="$(socat -V)"
>+
>+	if [[ "${support_string}" != *"WITH_VSOCK 1"* ]]; then
>+		die "err: socat is missing vsock support"
>+	fi
>+
>+	if [[ "${support_string}" != *"WITH_UNIX 1"* ]]; then
>+		die "err: socat is missing unix support"
>+	fi
>+}
>+
> handle_build() {
> 	if [[ ! "${BUILD}" -eq 1 ]]; then
> 		return
>@@ -194,9 +418,14 @@ handle_build() {
> }
>
> vm_start() {
>+	local cid=$1
>+	local ns=$2
>+	local pidfile=$3
> 	local logfile=/dev/null
> 	local verbose_opt=""
>+	local qemu_opts=""
> 	local kernel_opt=""
>+	local ns_exec=""
> 	local qemu
>
> 	qemu=$(command -v "${QEMU}")
>@@ -206,27 +435,37 @@ vm_start() {
> 		logfile=/dev/stdout
> 	fi
>
>+	qemu_opts="\
>+		 -netdev 
>user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>+		 -device virtio-net-pci,netdev=n0 \
>+		${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${cid} \

Have we removed QEMU_OPTS, right?

(I still prefer to have it defined on top, but maybe there is a reason
to remove it)

>+		--pidfile ${pidfile}
>+	"
>+
> 	if [[ "${BUILD}" -eq 1 ]]; then
> 		kernel_opt="${KERNEL_CHECKOUT}"
> 	fi
>
>-	vng \
>+	if [[ "${ns}" != "none" ]]; then
>+		ns_exec="ip netns exec ${ns}"
>+	fi
>+
>+	${ns_exec} vng \
> 		--run \
> 		${kernel_opt} \
> 		${verbose_opt} \
>-		--qemu-opts="${QEMU_OPTS}" \
>+		--qemu-opts="${qemu_opts}" \
> 		--qemu="${qemu}" \
> 		--user root \
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
>-	if ! timeout ${WAIT_TOTAL} \

So WAIT_TOTAL is now unused, right?

Can you explain better this change?

>-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
>-		die "failed to boot VM"
>-	fi
>+	timeout "${WAIT_QEMU}" \
>+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
> }
>
> vm_wait_for_ssh() {
>+	local ns=$1
> 	local i
>
> 	i=0
>@@ -234,7 +473,8 @@ vm_wait_for_ssh() {
> 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
> 			die "Timed out waiting for guest ssh"
> 		fi
>-		if vm_ssh -- true; then
>+
>+		if vm_ssh "${ns}" -- true; then
> 			break
> 		fi
> 		i=$(( i + 1 ))
>@@ -269,6 +509,7 @@ wait_for_listener()
> 		   grep -q "${pattern}"; then
> 			break
> 		fi
>+
> 		sleep "${interval}"
> 	done
>
>@@ -278,17 +519,29 @@ wait_for_listener()
> }
>
> vm_wait_for_listener() {
>-	local port=$1
>+	local ns=$1
>+	local port=$2
>+
>+	log "Waiting for listener on port ${port} on vm"
>
>-	vm_ssh <<EOF
>+	vm_ssh "${ns}" <<EOF
> $(declare -f wait_for_listener)
> wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
> EOF
> }
>
> host_wait_for_listener() {
>-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+	local ns=$1
>+	local port=$2
>
>+	if [[ "${ns}" == none ]]; then
>+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+	else
>+		ip netns exec "${ns}" bash <<-EOF
>+			$(declare -f wait_for_listener)
>+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
>+		EOF
>+	fi
> }
>
> log() {
>@@ -427,51 +680,506 @@ test_vm_client_host_server() {
> }
>
> test_vm_loopback() {
>+	vm_ssh "none" modprobe vsock_loopback || :
> 	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
> 	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
> }
>
>+test_host_vsock_ns_mode_ok() {
>+	add_namespaces
>
>+	for mode in "${MODES[@]}"; do
>+		if ! ns_set_mode "${mode}0" "${mode}"; then
>+			del_namespaces
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	del_namespaces
> }
>
>-test_vm_client_host_server() {
>+test_host_vsock_ns_mode_write_once_ok() {
>+	add_namespaces
>
>-	${VSOCK_TEST} \
>-		--mode "server" \
>-		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>+	for mode in "${MODES[@]}"; do
>+		local ns="${mode}0"
>+		if ! ns_set_mode "${ns}" "${mode}"; then
>+			del_namespaces
>+			return "${KSFT_FAIL}"
>+		fi
>
>-	host_wait_for_listener
>+		# try writing again and expect failure
>+		if ns_set_mode "${ns}" "${mode}"; then
>+			del_namespaces
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host=10.0.2.2 \
>-		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>+	del_namespaces
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
>-test_vm_loopback() {
>-	local port=60000 # non-forwarded local port
>+namespaces_can_boot_same_cid() {
>+	local ns0=$1
>+	local ns1=$2
>+	local pidfile1 pidfile2
>+	local cid=20
>+	readonly cid
>+	local rc
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest &
>+	pidfile1=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+	vm_start "${cid}" "${ns0}" "${pidfile1}"
>
>-	vm_wait_for_listener "${port}"
>+	pidfile2=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+	vm_start "${cid}" "${ns1}" "${pidfile2}"
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host="127.0.0.1" \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest
>+	rc=$?
>+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
>
>-	return $?
>+	return $rc
>+}
>+
>+test_global_same_cid_fails() {
>+	if namespaces_can_boot_same_cid "global0" "global1"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_local_global_same_cid_ok() {
>+	if namespaces_can_boot_same_cid "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_global_local_same_cid_ok() {
>+	if namespaces_can_boot_same_cid "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_local_same_cid_ok() {
>+	if namespaces_can_boot_same_cid "local0" "local0"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_diff_ns_global_host_connect_to_global_vm_ok() {
>+	local pids pid pidfile
>+	local ns0 ns1 port
>+	declare -a pids
>+	local unixfile
>+	ns0="global0"
>+	ns1="global1"
>+	port=1234
>+	local rc
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+
>+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+	ip netns exec "${ns1}" \
>+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
>+			UNIX-CONNECT:"${unixfile}" &
>+	pids+=($!)
>+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}"
>+
>+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
>+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
>+	pids+=($!)
>+
>+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
>+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns1}" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	for pid in "${pids[@]}"; do
>+		if [[ "$(jobs -p)" = *"${pid}"* ]]; then
>+			kill -SIGTERM "${pid}" &>/dev/null
>+		fi
>+	done
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ $rc -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_diff_ns_global_host_connect_to_local_vm_fails() {
>+	local ns0="global0"
>+	local ns1="local0"
>+	local port=12345
>+	local pidfile
>+	local result
>+	local pid
>+
>+	outfile=$(mktemp)
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+	if ! vm_start "${VSOCK_CID}" "${ns1}" "${pidfile}"; then
>+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
>+		return $KSFT_FAIL
>+	fi
>+
>+	vm_wait_for_ssh "${ns1}"
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
>+		return $KSFT_PASS
>+	fi
>+
>+	return $KSFT_FAIL
>+}
>+
>+test_diff_ns_global_vm_connect_to_global_host_ok() {
>+	local ns0="global0"
>+	local ns1="global1"
>+	local port=12345
>+	local unixfile
>+	local pidfile
>+	local pids
>+
>+	declare -a pids
>+
>+	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
>+
>+	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+
>+	ip netns exec "${ns0}" \
>+		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
>+	pids+=($!)
>+
>+	ip netns exec "${ns1}" \
>+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
>+	pids+=($!)
>+
>+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
>+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		terminate_pids "${pids[@]}"
>+		rm -f "${unixfile}"
>+		return $KSFT_FAIL
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+	vm_vsock_test "${ns0}" "client" "10.0.2.2" 2 "${port}"
>+	rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pids[@]}"
>+	rm -f "${unixfile}"
>+
>+	if [[ ! $rc -eq 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+
>+}
>+
>+test_diff_ns_global_vm_connect_to_local_host_fails() {
>+	local ns0="global0"
>+	local ns1="local0"
>+	local port=12345
>+	local pidfile
>+	local result
>+	local pid
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:${port} STDOUT &> "${outfile}" &
>+	pid=$!
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		terminate_pids "${pid}"
>+		rm -f "${outfile}"
>+		return $KSFT_FAIL
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_diff_ns_local_host_connect_to_local_vm_fails() {
>+	local ns0="local0"
>+	local ns1="local1"
>+	local port=12345
>+	local pidfile
>+	local result
>+	local pid
>+
>+	outfile=$(mktemp)
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+	if ! vm_start "${VSOCK_CID}" "${ns1}" "${pidfile}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		return $KSFT_FAIL
>+	fi
>+
>+	vm_wait_for_ssh "${ns1}"
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
>+		return $KSFT_PASS
>+	fi
>+
>+	return $KSFT_FAIL
>+}
>+
>+test_diff_ns_local_vm_connect_to_local_host_fails() {
>+	local ns0="local0"
>+	local ns1="local1"
>+	local port=12345
>+	local pidfile
>+	local result
>+	local pid
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
>+	pid=$!
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+	if ! vm_start "${VSOCK_CID}" "${ns0}" "${pidfile}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		rm -f "${outfile}"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+__test_loopback_two_netns() {
>+	local ns0=$1
>+	local ns1=$2
>+	local port=12345
>+	local result
>+	local pid
>+
>+	modprobe vsock_loopback &> /dev/null || :
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
>+	pid=$!
>+
>+	log_host "Launching socat in ns ${ns0}"
>+	echo TEST | ip netns exec "${ns0}" socat STDIN VSOCK-CONNECT:1:"${port}" 2>/dev/null
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" == TEST ]]; then
>+		return 0
>+	fi
>+
>+	return 1
>+}
>+
>+test_diff_ns_global_to_local_loopback_local_fails() {
>+	if ! __test_loopback_two_netns "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_diff_ns_local_to_global_loopback_fails() {
>+	if ! __test_loopback_two_netns "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_diff_ns_local_to_local_loopback_fails() {
>+	if ! __test_loopback_two_netns "local0" "local1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_diff_ns_global_to_global_loopback_ok() {
>+	if __test_loopback_two_netns "global0" "global1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_same_ns_local_loopback_ok() {
>+	if __test_loopback_two_netns "local0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_same_ns_local_host_connect_to_local_vm_ok() {
>+	local ns="local0"
>+	local port=1234
>+	local pidfile
>+	local rc
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+
>+	if ! vm_start "${VSOCK_CID}" "${ns}" "${pidfile}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns}" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ $rc -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_same_ns_local_vm_connect_to_local_host_ok() {
>+	local ns="local0"
>+	local port=1234
>+	local pidfile
>+	local rc
>+
>+	pidfile=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+
>+	if ! vm_start "${VSOCK_CID}" "${ns}" "${pidfile}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns}" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ $rc -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+shared_vm_test() {
>+	local tname
>+
>+	tname="${1}"
>+
>+	for testname in "${USE_SHARED_VM[@]}"; do
>+		if [[ "${tname}" == "${testname}" ]]; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+
>+init_netns_test() {
>+	local tname
>+
>+	tname="${1}"
>+
>+	for testname in "${USE_INIT_NETNS[@]}"; do
>+		if [[ "${tname}" == "${testname}" ]]; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+check_result() {
>+	local rc num
>+
>+	rc=$1
>+	num=$(( cnt_total + 1 ))
>+
>+	if [[ ${rc} -eq $KSFT_PASS ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${num} ${arg}"
>+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${num} ${arg} # SKIP"
>+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${num} ${arg} # exit=$rc"
>+	fi
>+
>+	cnt_total=$(( cnt_total + 1 ))
> }
>
>-run_test() {
>+run_shared_vm_tests() {
>+	local start_shared_vm pidfile
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -483,42 +1191,99 @@ run_test() {
> 	local name
> 	local rc
>
>-	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
>-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	start_shared_vm=0
>
>-	name=$(echo "${1}" | awk '{ print $1 }')
>-	eval test_"${name}"
>-	rc=$?
>+	for arg in "${ARGS[@]}"; do
>+		if shared_vm_test "${arg}"; then
>+			start_shared_vm=1
>+			break
>+		fi
>+	done
>
>-	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
>-	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
>-		rc=$KSFT_FAIL
>+	pidfile=""
>+	if [[ "${start_shared_vm}" == 1 ]]; then
>+		pidfile=$(mktemp $PIDFILE_TEMPLATE)

PIDFILE_TEMPLATE is undefined.

>+		log_host "Booting up VM"
>+		vm_start "${VSOCK_CID}" "none" "${pidfile}"
>+		vm_wait_for_ssh "none"
>+		log_host "VM booted up"
> 	fi
>
>-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>-	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
>-		rc=$KSFT_FAIL
>-	fi
>+	for arg in "${ARGS[@]}"; do
>+		if ! shared_vm_test "${arg}"; then
>+			continue
>+		fi
>
>-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>-	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
>-		rc=$KSFT_FAIL
>-	fi
>+		if ! check_test_deps "${arg}"; then
>+			log_host "Skipping ${arg}"
>+			check_result "${KSFT_SKIP}"
>+			continue
>+		fi
>+
>+		host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
>+		host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>+		vm_oops_cnt_before=$(vm_ssh none -- dmesg | grep -c -i 'Oops')
>+		vm_warn_cnt_before=$(vm_ssh none -- dmesg --level=warn | wc -l)
>+
>+		name=$(echo "${arg}" | awk '{ print $1 }')
>+		log_host "Executing test_${name}"
>+		eval test_"${name}"
>+		rc=$?
>+
>+		host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
>+		if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>+			echo "FAIL: kernel oops detected on host" | log_host "${name}"
>+			rc=$KSFT_FAIL
>+		fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>-	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
>-		rc=$KSFT_FAIL
>+		host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>+		if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>+			echo "FAIL: kernel warning detected on host" | log_host "${name}"
>+			rc=$KSFT_FAIL
>+		fi
>+
>+		vm_oops_cnt_after=$(vm_ssh none -- dmesg | grep -i 'Oops' | wc -l)
>+		if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>+			echo "FAIL: kernel oops detected on vm" | log_host "${name}"
>+			rc=$KSFT_FAIL
>+		fi
>+
>+		vm_warn_cnt_after=$(vm_ssh none -- dmesg --level=warn | wc -l)
>+		if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>+			echo "FAIL: kernel warning detected on vm" | log_host "${name}"
>+			rc=$KSFT_FAIL
>+		fi
>+
>+		check_result "${rc}"
>+	done
>+
>+	if [[ -n "${pidfile}" ]]; then
>+		log_host "VM terminate"
>+		terminate_pidfiles "${pidfile}"
> 	fi
>+}
>+
>+run_isolated_vm_tests() {
>+	for arg in "${ARGS[@]}"; do
>+		if shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		add_namespaces
>+		if init_netns_test "${arg}"; then
>+			init_namespaces
>+		fi
>
>-	return "${rc}"
>+		name=$(echo "${arg}" | awk '{ print $1 }')
>+		log_host "Executing test_${name}"
>+		eval test_"${name}"
>+		check_result $?
>+
>+		del_namespaces
>+	done
> }
>
>+BUILD=0

Is this a fix for an existing issue?
Another patch in that case?

> QEMU="qemu-system-$(uname -m)"
>
> while getopts :hvsq:b o
>@@ -543,34 +1308,13 @@ fi
> check_args "${ARGS[@]}"
> check_deps
> check_vng
>+check_socat
> handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-vm_start
>-vm_wait_for_ssh
>-log_host "VM booted up"
>-
>-cnt_pass=0
>-cnt_fail=0
>-cnt_skip=0
>-cnt_total=0
>-for arg in "${ARGS[@]}"; do
>-	run_test "${arg}"
>-	rc=$?
>-	if [[ ${rc} -eq $KSFT_PASS ]]; then
>-		cnt_pass=$(( cnt_pass + 1 ))
>-		echo "ok ${cnt_total} ${arg}"
>-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>-		cnt_skip=$(( cnt_skip + 1 ))
>-		echo "ok ${cnt_total} ${arg} # SKIP"
>-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>-		cnt_fail=$(( cnt_fail + 1 ))
>-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
>-	fi
>-	cnt_total=$(( cnt_total + 1 ))
>-done
>+run_shared_vm_tests
>+run_isolated_vm_tests

Sorry, there are too many changes and reviewing it is complicated. Can 
you at least divide it into patches to fix pre-existing bugs, patches to 
support namespaces (and use init_ns for the ones we already have), and 
patches to add tests?

Thanks,
Stefano

>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>


