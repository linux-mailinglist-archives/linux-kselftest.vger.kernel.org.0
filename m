Return-Path: <linux-kselftest+bounces-46244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC18C7A50A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4CD232E252
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBB2C08AD;
	Fri, 21 Nov 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/mV/FfA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vgyji7nI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17552BD58A
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736774; cv=none; b=QQEo6r0rNwPKxwv5TADP8cfV3Og1Jh+JQMCgm31QHv+NCqfhIZ0pvAKpPZwV9WxGLr5eG1Jy69sH09NeYEWLpZhNy/vrTWjJX6GgfP4u2SMSwuLvexm4bVuDZGEW/s/0zCpxKcmbvQ8Di3dYQdxl320FzHpbO5IbsA5gldGAgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736774; c=relaxed/simple;
	bh=qHGaT+KEnutFeRuVKyx2OkSZIlSrO3rVFd29maHqrn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDnNA26b6aM2oj6CppY97IDhFluXGzeOjDjf5YtpCzlfcKQgwLQ+vTW/f4ShRdldHo/tdJzMB1TVoWarP8iQavEkOPg+95P/961397S3lvslMqQmELjnu5wQq4yaofszbWywleElAQWxkDCc5FTCTcVlPK0Ap+xoIvzEKi1vvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/mV/FfA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vgyji7nI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suiCbDa+mn4EDoD5zj/zTHxqISSYIuySMfrm06o5yo8=;
	b=P/mV/FfA9Y+5jbOkJeM8Rh7YO51YVbaqgjtAbWwzu3oyo5suee/4mlEQgb3UGGil8di+Ms
	hCXRRZkGhCKzuZOm/QlBoeINeaDDN0g8+DTxtp7jOR8pjLrdJdyV7T29rh8AzZDxBUGZJ8
	K3z0h+L3ilGOfr5d64HUj+LAKXCPHn4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-VRlx2-qaMiSrO2bm5n1dwA-1; Fri, 21 Nov 2025 09:52:48 -0500
X-MC-Unique: VRlx2-qaMiSrO2bm5n1dwA-1
X-Mimecast-MFC-AGG-ID: VRlx2-qaMiSrO2bm5n1dwA_1763736767
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-640cdaf43aeso2048570a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763736767; x=1764341567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suiCbDa+mn4EDoD5zj/zTHxqISSYIuySMfrm06o5yo8=;
        b=Vgyji7nIyKhALGbrg8UM2oJ5r9n7kOJ2T1RspnoPKk4X0Myu6AT3if94yxgf/oajng
         xHbypcvfcdMktY7H304s/C/gtUaYYWDWrT+L54fGGDndBDzHnq9aMc9VaxYGCiL8DFPz
         IvZ4xhGHdcqOuXtRMLqAsWK2osSgie2lIAX7ZqnZOxVq3zTDBP6THLfwnVG+m+Ey3fIc
         0QUg7klv0xRc79iuKUD33sBuR3fpyTjV/p8UjcaG5QKoLlEeVH0HmEFvvsfPbxAtzo57
         yfZO+MrYNapYk014OYsF9jUx/dM0ygbiLoo/qzEWPXcueHVlQaNjxPzHu5nj/7pVbKJA
         CTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736767; x=1764341567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suiCbDa+mn4EDoD5zj/zTHxqISSYIuySMfrm06o5yo8=;
        b=SXIf9ppm9/eCZ7iHcdTDcRN+Cp8TA0BACyjinbS2gapso4Cd7wzB34B36awTDl6eMr
         CYDGarflkWDWCCAAjkQTLs2dk8h/Jj7hTn8uZfJwgnp1v77xrKP32Gm4HpGbm7UYb+rk
         shQa2SqOca6H0uaok/SzyRMNnVtxk24DeCaEG7iyQfVGshySe6UHft4D0Wg8u1bXlTet
         AZcOq45V1ZLoR8+9e6zt2as/PS3URdmwBwC2QzH5k2Ksrli+Qj/iamS/BY5la1NgAsWf
         xaVIHV8dqM9t/DAWk0s+D/m3wZtimTNWKYrirqPkD2UhtQ2wS9rOcbMN8+x63Nhe4fNI
         utpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtqlPC+p28Cnr9Gpx7T7QRNfKugdKO+AxdY6hBZG3B79rD7tgwF7Ol7jzsKCgj0SqCnVg25Nd8NBjeS8deopc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0iW1M/m4WZ7yUyAegN7HZpgfxORbwS5ulYpUHKXU/bYSQSHX
	qySntN5dxrI9fj0flRa58TqlujvVOv6CMstONyz3DkTcfIPQ6oSXtFWCFuYBshutC0sSV1ZfVYX
	Nahnq1X9brPaLz0AgvNFCyXaH6vweCh4i69py9m6HGawrB6zW8+A26QXJLSAz/dj6cP52cg==
X-Gm-Gg: ASbGncuvlSCjeq00+9TRjNlrkebe2d53eCkc4ccLHMHRfaRHeIutk9rUvQw/YwsBJtQ
	j/TbUeeVvRm5H0ETYvO2OQR/vvgzP53uO+LdBBSS5eNti8txV3Yuwl63bX7rBl9r0T0Gm3Hd48T
	PDEvqlG9vRIWu5cpJZJOf3rqXaRXfVuQlJl2pX1x16hhI+LRieYaRq4qQlhIozkN9p9e0ckwuUl
	eW6QhG5i//33My5wpBCqxxc9FbREo1+ljyek+b+y0K39MiiZGJ62Az68CsU8zsW+tl5eTaKLcCv
	8qCPls1Xdu7dajDj2GjBMnGCVHizYZl5FhZqg/7zQG6lkZ7wlJWT0EDSMZp27BBASturZ/kNkKJ
	i13uhjfe3zwZzq+Tm86k9yQaW7OscKih0lc24XQ9q5DdYXKEy/Ce3mMbg7Zmc6g==
X-Received: by 2002:a05:6402:34c7:b0:634:ab36:3c74 with SMTP id 4fb4d7f45d1cf-645544544edmr2037783a12.9.1763736767020;
        Fri, 21 Nov 2025 06:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI6y4ruC73hu0nPb3bJJUp9tZiVIgIF9Bpw94JoMzrDESJS5hx4cy9fmSdZgb5hDgYuy6AiA==
X-Received: by 2002:a05:6402:34c7:b0:634:ab36:3c74 with SMTP id 4fb4d7f45d1cf-645544544edmr2037755a12.9.1763736766471;
        Fri, 21 Nov 2025 06:52:46 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5e97sm4620191a12.9.2025.11.21.06.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:52:45 -0800 (PST)
Date: Fri, 21 Nov 2025 15:52:40 +0100
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
Subject: Re: [PATCH net-next v11 12/13] selftests/vsock: add tests for host
 <-> vm connectivity with namespaces
Message-ID: <5hjgwfskymdc5va5ot6uyfb3zu266syqdwcfhjg5znxzviongi@udb62nt5245s>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-12-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-12-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:44PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests to validate namespace correctness using vsock_test and socat.
>The vsock_test tool is used to validate expected success tests, but
>socat is used for expected failure tests. socat is used to ensure that
>connections are rejected outright instead of failing due to some other
>socket behavior (as tested in vsock_test). Additionally, socat is
>already required for tunneling TCP traffic from vsock_test. Using only
>one of the vsock_test tests like 'test_stream_client_close_client' would
>have yielded a similar result, but doing so wouldn't remove the socat
>dependency.
>
>Additionally, check for the dependency socat. socat needs special
>handling beyond just checking if it is on the path because it must be
>compiled with support for both vsock and unix. The function
>check_socat() checks that this support exists.
>
>Add more padding to test name printf strings because the tests added in
>this patch would otherwise overflow.
>
>Add vm_dmesg_start() and vm_dmesg_check() to encapsulate checking dmesg
>for oops and warnings.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v11:
>- add 'sleep "${WAIT_PERIOD}"' after any non-TCP socat LISTEN cmd
>  (Stefano)

I guess you meant wait_for_listener, right?

>- add host_wait_for_listener() after any socat TCP-LISTEN (Stefano)
>- reuse vm_dmesg_{oops,warn}_count() inside vm_dmesg_check()
>- fix copy-paste in test_ns_same_local_vm_connect_to_local_host_ok()
>  (Stefano)
>
>Changes in v10:
>- add vm_dmesg_start() and vm_dmesg_check()
>
>Changes in v9:
>- consistent variable quoting
>---
> tools/testing/selftests/vsock/vmtest.sh | 557 +++++++++++++++++++++++++++++++-
> 1 file changed, 555 insertions(+), 2 deletions(-)

LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index f84da1e8ad14..dfa895abfc7f 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -7,6 +7,7 @@
> #		* virtme-ng
> #		* busybox-static (used by virtme-ng)
> #		* qemu	(used by virtme-ng)
>+#		* socat
> #
> # shellcheck disable=SC2317,SC2119
>
>@@ -55,6 +56,19 @@ readonly TEST_NAMES=(
> 	ns_local_same_cid_ok
> 	ns_global_local_same_cid_ok
> 	ns_local_global_same_cid_ok
>+	ns_diff_global_host_connect_to_global_vm_ok
>+	ns_diff_global_host_connect_to_local_vm_fails
>+	ns_diff_global_vm_connect_to_global_host_ok
>+	ns_diff_global_vm_connect_to_local_host_fails
>+	ns_diff_local_host_connect_to_local_vm_fails
>+	ns_diff_local_vm_connect_to_local_host_fails
>+	ns_diff_global_to_local_loopback_local_fails
>+	ns_diff_local_to_global_loopback_fails
>+	ns_diff_local_to_local_loopback_fails
>+	ns_diff_global_to_global_loopback_ok
>+	ns_same_local_loopback_ok
>+	ns_same_local_host_connect_to_local_vm_ok
>+	ns_same_local_vm_connect_to_local_host_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -86,6 +100,45 @@ readonly TEST_DESCS=(
>
> 	# ns_local_global_same_cid_ok
> 	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
>+
>+	# ns_diff_global_host_connect_to_global_vm_ok
>+	"Run vsock_test client in global ns with server in VM in another global ns."
>+
>+	# ns_diff_global_host_connect_to_local_vm_fails
>+	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
>+
>+	# ns_diff_global_vm_connect_to_global_host_ok
>+	"Run vsock_test client in VM in a global ns with server in another global ns."
>+
>+	# ns_diff_global_vm_connect_to_local_host_fails
>+	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
>+
>+	# ns_diff_local_host_connect_to_local_vm_fails
>+	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
>+
>+	# ns_diff_local_vm_connect_to_local_host_fails
>+	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
>+
>+	# ns_diff_global_to_local_loopback_local_fails
>+	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
>+
>+	# ns_diff_local_to_global_loopback_fails
>+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
>+
>+	# ns_diff_local_to_local_loopback_fails
>+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
>+
>+	# ns_diff_global_to_global_loopback_ok
>+	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
>+
>+	# ns_same_local_loopback_ok
>+	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
>+
>+	# ns_same_local_host_connect_to_local_vm_ok
>+	"Run vsock_test client in a local ns with server in VM in same ns."
>+
>+	# ns_same_local_vm_connect_to_local_host_ok
>+	"Run vsock_test client in VM in a local ns with server in same ns."
> )
>
> readonly USE_SHARED_VM=(
>@@ -117,7 +170,7 @@ usage() {
> 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
> 		name=${TEST_NAMES[${i}]}
> 		desc=${TEST_DESCS[${i}]}
>-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
>+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
> 	done
> 	echo
>
>@@ -236,7 +289,7 @@ check_args() {
> }
>
> check_deps() {
>-	for dep in vng ${QEMU} busybox pkill ssh ss; do
>+	for dep in vng ${QEMU} busybox pkill ssh ss socat; do
> 		if [[ ! -x $(command -v "${dep}") ]]; then
> 			echo -e "skip:    dependency ${dep} not found!\n"
> 			exit "${KSFT_SKIP}"
>@@ -287,6 +340,20 @@ check_vng() {
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
>@@ -335,6 +402,14 @@ terminate_pidfiles() {
> 	done
> }
>
>+terminate_pids() {
>+	local pid
>+
>+	for pid in "$@"; do
>+		kill -SIGTERM "${pid}" &>/dev/null || :
>+	done
>+}
>+
> vm_start() {
> 	local pidfile=$1
> 	local ns=$2
>@@ -473,6 +548,28 @@ vm_dmesg_warn_count() {
> 	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
> }
>
>+vm_dmesg_check() {
>+	local pidfile=$1
>+	local ns=$2
>+	local oops_before=$3
>+	local warn_before=$4
>+	local oops_after warn_after
>+
>+	oops_after=$(vm_dmesg_oops_count "${ns}")
>+	if [[ "${oops_after}" -gt "${oops_before}" ]]; then
>+		echo "FAIL: kernel oops detected on vm in ns ${ns}" | log_host
>+		return 1
>+	fi
>+
>+	warn_after=$(vm_dmesg_warn_count "${ns}")
>+	if [[ "${warn_after}" -gt "${warn_before}" ]]; then
>+		echo "FAIL: kernel warning detected on vm in ns ${ns}" | log_host
>+		return 1
>+	fi
>+
>+	return 0
>+}
>+
> vm_vsock_test() {
> 	local ns=$1
> 	local host=$2
>@@ -597,6 +694,461 @@ test_ns_host_vsock_ns_mode_ok() {
> 	return "${KSFT_PASS}"
> }
>
>+test_ns_diff_global_host_connect_to_global_vm_ok() {
>+	local oops_before warn_before
>+	local pids pid pidfile
>+	local ns0 ns1 port
>+	declare -a pids
>+	local unixfile
>+	ns0="global0"
>+	ns1="global1"
>+	port=1234
>+	local rc
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+	ip netns exec "${ns1}" \
>+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
>+			UNIX-CONNECT:"${unixfile}" &
>+	pids+=($!)
>+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}" "tcp"
>+
>+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
>+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
>+	pids+=($!)
>+	host_wait_for_listener "${ns0}" "${unixfile}" "unix"
>+
>+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
>+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}" "tcp"
>+	host_vsock_test "${ns1}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pids "${pids[@]}"
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_diff_global_host_connect_to_local_vm_fails() {
>+	local oops_before warn_before
>+	local ns0="global0"
>+	local ns1="local0"
>+	local port=12345
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	outfile=$(mktemp)
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns1}"; then
>+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns1}"
>+	oops_before=$(vm_dmesg_oops_count "${ns1}")
>+	warn_before=$(vm_dmesg_warn_count "${ns1}")
>+
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
>+	vm_wait_for_listener "${ns1}" "${port}" "vsock"
>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" == "TEST" ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_diff_global_vm_connect_to_global_host_ok() {
>+	local oops_before warn_before
>+	local ns0="global0"
>+	local ns1="global1"
>+	local port=12345
>+	local unixfile
>+	local dmesg_rc
>+	local pidfile
>+	local pids
>+	local rc
>+
>+	init_namespaces
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
>+	host_wait_for_listener "${ns0}" "${port}" "tcp"
>+
>+	ip netns exec "${ns1}" \
>+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
>+	pids+=($!)
>+	host_wait_for_listener "${ns1}" "${unixfile}" "unix"
>+
>+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
>+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		terminate_pids "${pids[@]}"
>+		rm -f "${unixfile}"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	vm_vsock_test "${ns0}" "10.0.2.2" 2 "${port}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pids[@]}"
>+	rm -f "${unixfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+
>+}
>+
>+test_ns_diff_global_vm_connect_to_local_host_fails() {
>+	local ns0="global0"
>+	local ns1="local0"
>+	local port=12345
>+	local oops_before warn_before
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
>+	pid=$!
>+	host_wait_for_listener "${ns1}" "${port}" "vsock"
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		terminate_pids "${pid}"
>+		rm -f "${outfile}"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_host_connect_to_local_vm_fails() {
>+	local ns0="local0"
>+	local ns1="local1"
>+	local port=12345
>+	local oops_before warn_before
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	outfile=$(mktemp)
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns1}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns1}"
>+	oops_before=$(vm_dmesg_oops_count "${ns1}")
>+	warn_before=$(vm_dmesg_warn_count "${ns1}")
>+
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
>+	vm_wait_for_listener "${ns1}" "${port}" "vsock"
>+
>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_vm_connect_to_local_host_fails() {
>+	local oops_before warn_before
>+	local ns0="local0"
>+	local ns1="local1"
>+	local port=12345
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
>+	pid=$!
>+	host_wait_for_listener "${ns1}" "${port}" "vsock"
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		rm -f "${outfile}"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
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
>+
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
>+	pid=$!
>+	host_wait_for_listener "${ns1}" "${port}" "vsock"
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
>+test_ns_diff_global_to_local_loopback_local_fails() {
>+	init_namespaces
>+
>+	if ! __test_loopback_two_netns "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_to_global_loopback_fails() {
>+	init_namespaces
>+
>+	if ! __test_loopback_two_netns "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_to_local_loopback_fails() {
>+	init_namespaces
>+
>+	if ! __test_loopback_two_netns "local0" "local1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_global_to_global_loopback_ok() {
>+	init_namespaces
>+
>+	if __test_loopback_two_netns "global0" "global1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_same_local_loopback_ok() {
>+	init_namespaces
>+
>+	if __test_loopback_two_netns "local0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_same_local_host_connect_to_local_vm_ok() {
>+	local oops_before warn_before
>+	local ns="local0"
>+	local port=1234
>+	local dmesg_rc
>+	local pidfile
>+	local rc
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+
>+	if ! vm_start "${pidfile}" "${ns}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns}"
>+	oops_before=$(vm_dmesg_oops_count "${ns}")
>+	warn_before=$(vm_dmesg_warn_count "${ns}")
>+
>+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_same_local_vm_connect_to_local_host_ok() {
>+	local oops_before warn_before
>+	local ns="local0"
>+	local port=1234
>+	local dmesg_rc
>+	local pidfile
>+	local rc
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+
>+	if ! vm_start "${pidfile}" "${ns}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns}"
>+	oops_before=$(vm_dmesg_oops_count "${ns}")
>+	warn_before=$(vm_dmesg_warn_count "${ns}")
>+
>+	host_vsock_test "${ns}" "server" "${VSOCK_CID}" "${port}"
>+	vm_vsock_test "${ns}" "10.0.2.2" 2 "${port}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> namespaces_can_boot_same_cid() {
> 	local ns0=$1
> 	local ns1=$2
>@@ -894,6 +1446,7 @@ fi
> check_args "${ARGS[@]}"
> check_deps
> check_vng
>+check_socat
> handle_build
>
> echo "1..${#ARGS[@]}"
>
>-- 
>2.47.3
>


