Return-Path: <linux-kselftest+bounces-45910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B59DC6B2B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3486E29E0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721803612D3;
	Tue, 18 Nov 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqQQM1MP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUx8QKNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF353612C4
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489766; cv=none; b=ZXnburCa9cnpKgwkF0Av9R/HN33UOERmmH06U7E7YYoF1nSP4E1E1Rm6Nhplv9+LCn6ulfX4HGAVDztlfX/1YdO+t+wb7KTjTyicUlLDnIkUeof0B27cB4aam91OeBsKFKSrx1OKhMsMeNYO6UYJSLll2fLHZMqD50PYCsuQ0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489766; c=relaxed/simple;
	bh=z9jngTjYXX2N3hDh12UT7kNeVGRmibW/GBVfuJWh90U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLBwCpI7NyWB9WivdBm3fMuPcVURQBKBzO0o9rqxtAFOLvWD2j5kM0Ux1Rm/8NLrVdQR9SdDLSobv/VNh5ueKvldNlTzF4wIkMZVtGQ2FczIQtDJm5bn/2yToQDnk8D8gNZ7/U/cji+GuV6x3DASk9137GoVUbRWnWuJXWPbhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqQQM1MP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUx8QKNE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
	b=iqQQM1MPXpsBf53y/U9eE+tvaP94wudEiy8B/pa5W+c8gLIecGPrqAy3qy2Rx+5Tkb+ub1
	j97kK9TpgvLMW6310Cyf3qbcTg4VumsGjmBnbKfmJI4lSrnUpoi+HAxhv9z0IrjYPkmKgX
	Pidf/XWE2aWzVaTte22m0tuFyaEcx+M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-KcQZkit4PLejN4O-ktkueg-1; Tue, 18 Nov 2025 13:16:00 -0500
X-MC-Unique: KcQZkit4PLejN4O-ktkueg-1
X-Mimecast-MFC-AGG-ID: KcQZkit4PLejN4O-ktkueg_1763489759
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6416581521eso5612969a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489759; x=1764094559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
        b=AUx8QKNErEgQv+mOvNtKSJyIqMXXtm+uHgDK9O1XHiF54XBZ0Spm52tcmMJz1xfwc8
         2RCqBZnEa0rhBRDCbGfIRWI2HBQziQQrGD2MtwZ29AMUpLC5UMjZanNs7NNRhQd0Ogwj
         zjuQXNhqjWiv/LdbN7snWjAN6XvekH1KP4KuFIiBmXHPSADxohoUjy5gf5+aPHBvR13V
         vz98b4x3syXPQ8M+ObY172k2odyTlg9MNDOhmS5tjch2WNMxLw8wAYvDTE6yO1R/1KPc
         dkwNhs56iukswuq+iyKiKqtt36fX0eW4tRwLRCxSoxf6OcKKsFfh+F32Dh6D68Wrs89A
         snMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489759; x=1764094559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
        b=LF/HexoRuaCiWZ+zWHiL6TdQp2R7sTKRu85JZaFr8jfsKe5MNhmQDnWDtIIK3clkoh
         FkXcNJ3dJYX2j2CYexPHRfSJGc7nsKXpSG70keRB1Jbflg6y4hG5ODztgB5BDa46xHXk
         rVVapAxk6VAMkEm1kKHeDNApkI+aI7GMWINnegkDfhn4JQo07ZcA8LMjg3IFNsQXjuML
         3NMQ6Tqw49cadNkoHIONp2dwtx89C70TBbiqarWLP30HvWwAFm9XC42KkdylIlEPVDtD
         dGZx6puf81SFYv+c7z31b+UqIKhOlAngnbqK0txVBYu46qTz8+Kq8w9ssjKqyEU1w74D
         AiXw==
X-Forwarded-Encrypted: i=1; AJvYcCWkCXB5RJoCi1dhe4ycooro2ff4mOS/b8GORAS5w8fRNsx6RstQT8QBMQdqnPbTyXub4A8y6Wca0KSkgj7Gh2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77octggsOn4lPBi8pkbNprssC1t3Eqm/lxQAe8vLUPhtphcsf
	6b7UnZEkbmm5QFO4VomOGQs5abY1BjTm0tXtPU8BYhHCP3JeCqC8a3U8DQQvWZBt70+SJTIkv8q
	81q/rdSD8GINZ/FGzUi6daX+7djup+9VGDmsAjTz6w+MpSyusdOQnO8zyNPT8tpox9xfEHQ==
X-Gm-Gg: ASbGnctmi6Y/MUhafwmhQPN6+Vs+uVWzUQQSSEwtAc4hA6JtmS69aFU8LLDeFDUb0/Z
	7s8GerwYNpnYzKSUBmzn/P2wAXwr37pqbWHgvLaw2I4Gz+pKJr7ztOHWBgp69p28H83vtwgiJzH
	tWbNy8RyTTQSdKE6Px1D09A1XjbGxaOTQXxnOonl9s4zzEpMJPkLAAid5pvIWbldujk8B3ElWDX
	OfQrUB05yRbGzn3baAMnSXMiRQhwc3aD9WdnCcpSs+15ps34jtxWaw6JgCEDaBayDOBMhn94x5d
	pEGl/ZF64eMxkSP6oIIi+Pk1PRlpjrQdARrDbp+PSKXvMqS2f9UOM7K+j59G7dpRsDX6tafMytM
	JznjO7cY4j7PyOzIJtTdgukyoetO/PjEaCQxYC1fORUlebNyVNNkm/XhXGp8=
X-Received: by 2002:a05:6402:42c4:b0:643:18c2:124e with SMTP id 4fb4d7f45d1cf-64350e0eedamr16148789a12.7.1763489758976;
        Tue, 18 Nov 2025 10:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoN0mxHlnHDgcN+NdZ5LOvg9qXOI9RJny5diigWO606GHOiHMHqYfRilSL5Y7K5784adc2+Q==
X-Received: by 2002:a05:6402:42c4:b0:643:18c2:124e with SMTP id 4fb4d7f45d1cf-64350e0eedamr16148731a12.7.1763489758430;
        Tue, 18 Nov 2025 10:15:58 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b28bbsm12919260a12.28.2025.11.18.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:15:56 -0800 (PST)
Date: Tue, 18 Nov 2025 19:15:50 +0100
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
Subject: Re: [PATCH net-next v10 11/11] selftests/vsock: add tests for
 namespace deletion and mode changes
Message-ID: <snj3w4fhh2az6wp6kf7ca3bgd6jp2aawvyic7thdnoktdumbx6@zmjqiorc2uda>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-11-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-11-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:34PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests that validate vsock sockets are resilient to deleting
>namespaces or changing namespace modes from global to local. The vsock
>sockets should still function normally.
>
>The function check_ns_changes_dont_break_connection() is added to re-use
>the step-by-step logic of 1) setup connections, 2) do something that
>would maybe break the connections, 3) check that the connections are
>still ok.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- more consistent shell style
>- clarify -u usage comment for pipefile
>---
> tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
> 1 file changed, 123 insertions(+)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 9c12c1bd1edc..2b6e94aafc19 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -66,6 +66,12 @@ readonly TEST_NAMES=(
> 	ns_same_local_loopback_ok
> 	ns_same_local_host_connect_to_local_vm_ok
> 	ns_same_local_vm_connect_to_local_host_ok
>+	ns_mode_change_connection_continue_vm_ok
>+	ns_mode_change_connection_continue_host_ok
>+	ns_mode_change_connection_continue_both_ok
>+	ns_delete_vm_ok
>+	ns_delete_host_ok
>+	ns_delete_both_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -135,6 +141,24 @@ readonly TEST_DESCS=(
>
> 	# ns_same_local_vm_connect_to_local_host_ok
> 	"Run vsock_test client in VM in a local ns with server in same ns."
>+
>+	# ns_mode_change_connection_continue_vm_ok
>+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
>+
>+	# ns_mode_change_connection_continue_host_ok
>+	"Check that changing NS mode of host namespace from global to 
>local after a connection is established doesn't break the connection"
>+
>+	# ns_mode_change_connection_continue_both_ok
>+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
>+
>+	# ns_delete_vm_ok
>+	"Check that deleting the VM's namespace does not break the socket connection"
>+
>+	# ns_delete_host_ok
>+	"Check that deleting the host's namespace does not break the socket connection"
>+
>+	# ns_delete_both_ok
>+	"Check that deleting the VM and host's namespaces does not break the socket connection"
> )
>
> readonly USE_SHARED_VM=(
>@@ -1256,6 +1280,105 @@ test_ns_vm_local_mode_rejected() {
> 	return "${KSFT_PASS}"
> }
>
>+check_ns_changes_dont_break_connection() {
>+	local pipefile pidfile outfile
>+	local ns0="global0"
>+	local ns1="global1"
>+	local port=12345
>+	local pids=()
>+	local rc=0
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+	vm_wait_for_ssh "${ns0}"
>+
>+	outfile=$(mktemp)
>+	vm_ssh "${ns0}" -- \
>+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
>+	pids+=($!)
>+
>+	# wait_for_listener() does not work for vsock because vsock does not
>+	# export socket state to /proc/net/. Instead, we have no choice but to
>+	# sleep for some hardcoded time.
>+	sleep "${WAIT_PERIOD}"

can we use `ss --vsock --listening` ?

>+
>+	# We use a pipe here so that we can echo into the pipe instead of using
>+	# socat and a unix socket file. We just need a name for the pipe (not a
>+	# regular file) so use -u.
>+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)

Should we remove this file at the end of the test?

>+	ip netns exec "${ns1}" \
>+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
>+	pids+=($!)
>+
>+	timeout "${WAIT_PERIOD}" \
>+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
>+
>+	if [[ $2 == "delete" ]]; then
>+		if [[ "$1" == "vm" ]]; then
>+			ip netns del "${ns0}"
>+		elif [[ "$1" == "host" ]]; then
>+			ip netns del "${ns1}"
>+		elif [[ "$1" == "both" ]]; then
>+			ip netns del "${ns0}"
>+			ip netns del "${ns1}"
>+		fi
>+	elif [[ $2 == "change_mode" ]]; then
>+		if [[ "$1" == "vm" ]]; then
>+			ns_set_mode "${ns0}" "local"
>+		elif [[ "$1" == "host" ]]; then
>+			ns_set_mode "${ns1}" "local"
>+		elif [[ "$1" == "both" ]]; then
>+			ns_set_mode "${ns0}" "local"
>+			ns_set_mode "${ns1}" "local"
>+		fi
>+	fi
>+
>+	echo "TEST" > "${pipefile}"
>+
>+	timeout "${WAIT_PERIOD}" \
>+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
>+
>+	if grep -q "TEST" "${outfile}"; then
>+		rc="${KSFT_PASS}"
>+	else
>+		rc="${KSFT_FAIL}"
>+	fi
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pids[@]}"
>+	rm -f "${outfile}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_mode_change_connection_continue_vm_ok() {
>+	check_ns_changes_dont_break_connection "vm" "change_mode"
>+}
>+
>+test_ns_mode_change_connection_continue_host_ok() {
>+	check_ns_changes_dont_break_connection "host" "change_mode"
>+}
>+
>+test_ns_mode_change_connection_continue_both_ok() {
>+	check_ns_changes_dont_break_connection "both" "change_mode"
>+}
>+
>+test_ns_delete_vm_ok() {
>+	check_ns_changes_dont_break_connection "vm" "delete"
>+}
>+
>+test_ns_delete_host_ok() {
>+	check_ns_changes_dont_break_connection "host" "delete"
>+}
>+
>+test_ns_delete_both_ok() {
>+	check_ns_changes_dont_break_connection "both" "delete"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>
>-- 
>2.47.3
>


