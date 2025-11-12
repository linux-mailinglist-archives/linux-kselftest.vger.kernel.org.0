Return-Path: <linux-kselftest+bounces-45417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5EC52C88
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6ED503536
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498BC30C364;
	Wed, 12 Nov 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjiHk8E9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lbBPNg4a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29632288515
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957393; cv=none; b=Bey2fHUzAfqgkRZJXVYD0KH46pBrGacc5wfzGZzyHxI4gSmfXa6cI+9fMER8kJAGplCu8Xj8xCeJFmOTB1fFr2+8RXD/Pacpqh1aNZuHnri5bX24dJUe+7FwNuYD1n600HpVmuGtSJ4hXV1QmrniOQ6VIYXjiPJNLACsklhresg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957393; c=relaxed/simple;
	bh=xAtY3c6CpUZwSzOd1O+wG9DPpRgDPowOvF8zaOO0db4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEzOYQp9T+kmyztwZfE7j8Bz7T2V/eO24jeu6gaepMDoTp6P0wEvfk31L4Wctl/ax7FDNtPgghF1aNDiSbdY2sYOCGihJDniyyswPdcHLnQanZaDYfomuB8Nqe92dqsBna1GrkdYCGsUN/yr40fQcJrh+CFtRmTf1j+qk9KjVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjiHk8E9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lbBPNg4a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762957390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPdaGkZ/e0uV0048TG9YCD2xEt1WOajvGWrxz83dORo=;
	b=fjiHk8E9Td7rrADIqoY1WnxmblAdCSqo+GDmmY2ar3MZ1ImgQSdbf1U6Ps9l3UEDMtL40g
	SfLTni5QmVEKAi5+EXOOoD3bEi+z3n3T8eHvM2As7PhmzLfSrMChIvgCtKDAXU4msb9qo6
	HcsK+V17MA74wet0iuA/BXth5enB9aw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-E-5935sZOUisNcbo8TFNUQ-1; Wed, 12 Nov 2025 09:23:09 -0500
X-MC-Unique: E-5935sZOUisNcbo8TFNUQ-1
X-Mimecast-MFC-AGG-ID: E-5935sZOUisNcbo8TFNUQ_1762957388
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22d590227so99118085a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762957388; x=1763562188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPdaGkZ/e0uV0048TG9YCD2xEt1WOajvGWrxz83dORo=;
        b=lbBPNg4aghAIw22UKGOfBcxu9bfSzhO+02DYcZR7QLLDBzq1b1UiEZ/so+nEgUaqY/
         +HvSEBv9lO4T3/CztsLCS7rpv164I6iXYWhqSPMXQhhYrkmQIOca6OL/jIuiP7g3C2kU
         YpLFzj5FEy3eIm1MyMy1rnaR9Rni2pyjgArlGjhBhLu7t1SAuFRt4MBzEdiToBi3bR7q
         w8fpNZ+5LWyDm1+C92vSufgokZQE6R9tCK5zkD2VbuvIG2hWE0ktqeg5wUWjkhPtRtiJ
         /wctXDjzM28tfpBZFlGrpU2kciNlBmRx0oeZDCFQPTO9S43JgVKqne87+03UF1smUnQt
         LdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957388; x=1763562188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPdaGkZ/e0uV0048TG9YCD2xEt1WOajvGWrxz83dORo=;
        b=r1jiePCTPLcRGPMD/MndQ3xCg+/rEST0FwG9L7r0NGBST5HkcajHb8G1F9E71rJNEs
         A0snNugFSErWnplRGMCrKD7phSO3qyhh+jgd5kzSVajW74Y6ygsmsPUd0jjs+8Pdy6Ht
         IfetKV8SslXk4f6NuyVzQNRNKCNxhW+Oe5rZRrVl+1cZzuKkQxpieBJFRHAwBdkictPo
         AAmo+g8m66Pa82edRgsYo2bkFHQ73r5b/Ecbtzm9Ji1TsnALeDkjXDe7CmCJSvGBikPR
         Pj88QuuuWSBi7YuUzqhviNfZFrMnIrsHAWYCvG2ViZPslTpF9bS4JOZ+uJWxy+cg69MG
         4fyg==
X-Forwarded-Encrypted: i=1; AJvYcCW+43VgKS0uoYeQV3fPuK5kHa8xLoAINNL3JWHRyQiQmsmx52n4HLRfiTexL3mgZ9sC0O68/LeEHjilpZk0+x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZT4xyFyLmJm8Cr+E5CW+/IPHfONVJGuubm8JQzjLdhmaHLwEL
	LvzLk1xlggYkCx2DFokvGtGQbgvA4G2HfH91Mx3+ZCHYOJ5xCIc6pppIQ8khkfsry7Ukn2otFa1
	e2zo3tDNuLyTWiNEPybG80Q3yOb/h1kwwbbwJbK/8Di+DEaMyJgioWTFn5Mv2yG7No4QtTA==
X-Gm-Gg: ASbGncsaSWuxU1TnFbDfNW6HXTu12VJMS0lZZYYozl+oYoLPk8/OU4dIbMnlKJpfmKA
	6l/xx45L7W2r2UF7Y1b8ZAoNXlBmoR31MistRW5K/BAh51ymHdOFzeQucK/LQwQQa1AHzdnSVPG
	a5jxvjn3trLIktwPLEVDAQyYyOvXBsolwRo7ke83elOX69m/P1lm4gQi/+AlKNqaB3NCY3wZ680
	a8843ZHc+K7A4UgdZ8SLDSB/iQQFtbTYqVRHk/gLlBImbdmKY0omSgQRKV0sjoYM4yUYKXa1FQg
	myQWP/ahHGAfKek7fmcSUgY6GXvgslVk0nYIecNJHyNqNi972LArALSxuF/eDtPFmeVWRhedQg0
	6xsL8cUsYQOJ4/XyOkARkIhQDJCaeWt677a2abi27RXD7TdGayKY=
X-Received: by 2002:ac8:58c1:0:b0:4ed:b1fa:ae22 with SMTP id d75a77b69052e-4eddbdda755mr33901161cf.72.1762957388417;
        Wed, 12 Nov 2025 06:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXioASOTUDB0lRqRI3w+6gwRpREA3iUwAx3NnMSdAJpSgUbYXqg8H9a/pegAedzHUwnr+Sww==
X-Received: by 2002:ac8:58c1:0:b0:4ed:b1fa:ae22 with SMTP id d75a77b69052e-4eddbdda755mr33900681cf.72.1762957387878;
        Wed, 12 Nov 2025 06:23:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85e0a9sm201452985a.20.2025.11.12.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:23:07 -0800 (PST)
Date: Wed, 12 Nov 2025 15:23:00 +0100
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
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 10/14] selftests/vsock: prepare vm management
 helpers for namespaces
Message-ID: <s626klsk5bzidowkph3j7dk4bxnn2f45kyfkespfwz4ykbzazl@mhpju54tahiu>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-10-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-10-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:52PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add namespace support to vm management, ssh helpers, and vsock_test
>wrapper functions. This enables running VMs and test helpers in specific
>namespaces, which is required for upcoming namespace isolation tests.
>
>The functions still work correctly within the init ns, though the caller
>must now pass "init_ns" explicitly.
>
>No functional changes for existing tests. All have been updated to pass
>"init_ns" explicitly.
>
>Affected functions (such as vm_start() and vm_ssh()) now wrap their
>commands with 'ip netns exec' when executing commands in non-init
>namespaces.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 100 ++++++++++++++++++++++----------
> 1 file changed, 68 insertions(+), 32 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index f78cc574c274..663be2da4e22 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -144,7 +144,18 @@ ns_set_mode() {
> }
>
> vm_ssh() {
>-	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
>+	local ns_exec
>+
>+	if [[ "${1}" == init_ns ]]; then
>+		ns_exec=""
>+	else
>+		ns_exec="ip netns exec ${1}"
>+	fi
>+
>+	shift
>+
>+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
>+
> 	return $?
> }
>
>@@ -267,10 +278,12 @@ terminate_pidfiles() {
>
> vm_start() {
> 	local pidfile=$1
>+	local ns=$2
> 	local logfile=/dev/null
> 	local verbose_opt=""
> 	local kernel_opt=""
> 	local qemu_opts=""
>+	local ns_exec=""
> 	local qemu
>
> 	qemu=$(command -v "${QEMU}")
>@@ -291,7 +304,11 @@ vm_start() {
> 		kernel_opt="${KERNEL_CHECKOUT}"
> 	fi
>
>-	vng \
>+	if [[ "${ns}" != "init_ns" ]]; then
>+		ns_exec="ip netns exec ${ns}"
>+	fi
>+
>+	${ns_exec} vng \
> 		--run \
> 		${kernel_opt} \
> 		${verbose_opt} \
>@@ -306,6 +323,7 @@ vm_start() {
> }
>
> vm_wait_for_ssh() {
>+	local ns=$1
> 	local i
>
> 	i=0
>@@ -313,7 +331,8 @@ vm_wait_for_ssh() {
> 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
> 			die "Timed out waiting for guest ssh"
> 		fi
>-		if vm_ssh -- true; then
>+
>+		if vm_ssh "${ns}" -- true; then
> 			break
> 		fi
> 		i=$(( i + 1 ))
>@@ -347,30 +366,40 @@ wait_for_listener()
> }
>
> vm_wait_for_listener() {
>-	local port=$1
>+	local ns=$1
>+	local port=$2
>
>-	vm_ssh <<EOF
>+	vm_ssh "${ns}" <<EOF
> $(declare -f wait_for_listener)
> wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
> EOF
> }
>
> host_wait_for_listener() {
>-	local port=$1
>+	local ns=$1
>+	local port=$2
>
>-	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+	if [[ "${ns}" == "init_ns" ]]; then
>+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+	else
>+		ip netns exec "${ns}" bash <<-EOF
>+			$(declare -f wait_for_listener)
>+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
>+		EOF
>+	fi
> }
>
> vm_vsock_test() {
>-	local host=$1
>-	local cid=$2
>-	local port=$3
>+	local ns=$1
>+	local host=$2
>+	local cid=$3
>+	local port=$4
> 	local rc
>
> 	# log output and use pipefail to respect vsock_test errors
> 	set -o pipefail
> 	if [[ "${host}" != server ]]; then
>-		vm_ssh -- "${VSOCK_TEST}" \
>+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
> 			--mode=client \
> 			--control-host="${host}" \
> 			--peer-cid="${cid}" \
>@@ -378,7 +407,7 @@ vm_vsock_test() {
> 			2>&1 | log_guest
> 		rc=$?
> 	else
>-		vm_ssh -- "${VSOCK_TEST}" \
>+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
> 			--mode=server \
> 			--peer-cid="${cid}" \
> 			--control-port="${port}" \
>@@ -390,7 +419,7 @@ vm_vsock_test() {
> 			return $rc
> 		fi
>
>-		vm_wait_for_listener "${port}"
>+		vm_wait_for_listener "${ns}" "${port}"
> 		rc=$?
> 	fi
> 	set +o pipefail
>@@ -399,22 +428,28 @@ vm_vsock_test() {
> }
>
> host_vsock_test() {
>-	local host=$1
>-	local cid=$2
>-	local port=$3
>+	local ns=$1
>+	local host=$2
>+	local cid=$3
>+	local port=$4
> 	local rc
>
>+	local cmd="${VSOCK_TEST}"
>+	if [[ "${ns}" != "init_ns" ]]; then
>+		cmd="ip netns exec ${ns} ${cmd}"
>+	fi
>+
> 	# log output and use pipefail to respect vsock_test errors
> 	set -o pipefail
> 	if [[ "${host}" != server ]]; then
>-		${VSOCK_TEST} \
>+		${cmd} \
> 			--mode=client \
> 			--peer-cid="${cid}" \
> 			--control-host="${host}" \
> 			--control-port="${port}" 2>&1 | log_host
> 		rc=$?
> 	else
>-		${VSOCK_TEST} \
>+		${cmd} \
> 			--mode=server \
> 			--peer-cid="${cid}" \
> 			--control-port="${port}" 2>&1 | log_host &
>@@ -425,7 +460,7 @@ host_vsock_test() {
> 			return $rc
> 		fi
>
>-		host_wait_for_listener "${port}"
>+		host_wait_for_listener "${ns}" "${port}"
> 		rc=$?
> 	fi
> 	set +o pipefail
>@@ -469,11 +504,11 @@ log_guest() {
> }
>
> test_vm_server_host_client() {
>-	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
>+	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>-	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
>+	if ! host_vsock_test "init_ns" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>@@ -481,11 +516,11 @@ test_vm_server_host_client() {
> }
>
> test_vm_client_host_server() {
>-	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
>+	if ! host_vsock_test "init_ns" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>-	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
>+	if ! vm_vsock_test "init_ns" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>@@ -495,13 +530,14 @@ test_vm_client_host_server() {
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>-	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
>+	vm_ssh "init_ns" -- modprobe vsock_loopback &> /dev/null || :
>
>-	if ! vm_vsock_test "server" 1 "${port}"; then
>+	if ! vm_vsock_test "init_ns" "server" 1 "${port}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>-	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
>+
>+	if ! vm_vsock_test "init_ns" "127.0.0.1" 1 "${port}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>@@ -559,8 +595,8 @@ run_shared_vm_test() {
>
> 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
> 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
>-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>+	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
>+	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
>
> 	name=$(echo "${1}" | awk '{ print $1 }')
> 	eval test_"${name}"
>@@ -578,13 +614,13 @@ run_shared_vm_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -i 'Oops' | wc -l)
> 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
> 		echo "FAIL: kernel oops detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>+	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host
> 		rc=$KSFT_FAIL
>@@ -630,8 +666,8 @@ cnt_total=0
> if shared_vm_tests_requested "${ARGS[@]}"; then
> 	log_host "Booting up VM"
> 	pidfile="$(create_pidfile)"
>-	vm_start "${pidfile}"
>-	vm_wait_for_ssh
>+	vm_start "${pidfile}" "init_ns"
>+	vm_wait_for_ssh "init_ns"
> 	log_host "VM booted up"
>
> 	run_shared_vm_tests "${ARGS[@]}"
>
>-- 
>2.47.3
>


