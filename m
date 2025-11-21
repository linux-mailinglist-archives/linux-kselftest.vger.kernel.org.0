Return-Path: <linux-kselftest+bounces-46245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86AC7A5E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8247E34A626
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52134BA42;
	Fri, 21 Nov 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9nTWgxI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sX8KJDt7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7033F39B
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736830; cv=none; b=lbd3Z6ETq0gfmGMeRg0yFMa8cJte1f0LlX3cV3zENP0KiXkvnLp3WCItB5f0l7rZsvGMc2qjcxZlSuvIUDg0MvD51aespHtZmsWEW688PIPBEIy8gc1ujnDuKizQ+3r/Sxjymljo2bK5XR0BwSPweM0mRpHp8VqEGHCzbCmB5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736830; c=relaxed/simple;
	bh=9i20c00azjnqUlgHan1d4XMNEG+uCudRN41yfgEHmes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX+uQqSqN2Ov+NPPqXTQ42SQgswKvZ3/xlkeHMHRXkf9SmNvARzsTloTE/WQkxA/JuqdxXAdKMIYq2Mow7gBLcQkj41wXMxq5k3lQblRp2CpMndtR0cSzF6mhzWIgdpX7wO6rWWwPpQoppgqG4kls/14oWYvUqGBIS6MtfZSBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9nTWgxI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sX8KJDt7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i15YguCXHczhLUbubm2iHy9FziSXkCUAnCPJisIdinA=;
	b=G9nTWgxIpqX3TvJPa9i5JrPr9Cyn99o5YLo5SXi9tpfxmfbe6nPrxKDbhB3RQBSw9y9/pF
	eKyu738AvJ+wNWD/PbQb6Z8Bp0kacVoDXli412DhMRdEkTzGJse5Nh1xMNZRac6pkD+BZw
	kD30wdWz9ysYTqDsK4xAHgeposMBdWM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-lOIgpJGaPbWazO5qAMGLEA-1; Fri, 21 Nov 2025 09:53:42 -0500
X-MC-Unique: lOIgpJGaPbWazO5qAMGLEA-1
X-Mimecast-MFC-AGG-ID: lOIgpJGaPbWazO5qAMGLEA_1763736821
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-640cdaf43aeso2049272a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 06:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763736821; x=1764341621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i15YguCXHczhLUbubm2iHy9FziSXkCUAnCPJisIdinA=;
        b=sX8KJDt7aLbeBOuAOO5jvFctdrp/l+QvVbtzZ14vqKSDANLyCEATYDne6Hnv+quKjj
         Pp6FXQVV/9LgmnOd2yvfo5GJ5kJnVoeHJ6XMOJe+tIbKSxyhvyYnJt9Lnl75feZdlE6T
         dkvGcVR2M2B+uH3bnN2cUZhlNhIvwTORqCH3S3X3cQNHvrpjsvfm7v5aVmFzxl8z08E6
         4s0/+AqKy1WBFRbZVbMikuFYeXNwXAINkABwutZWyZXwiQe4R2Ju9vOBbGCbbUwQZp4M
         aokHW/qVCkq/rS8delRuTT8h0vKzCP5lX/LZ0lu1eyRZDtcUXre302QXJUcmN3qQNpps
         vUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736821; x=1764341621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i15YguCXHczhLUbubm2iHy9FziSXkCUAnCPJisIdinA=;
        b=dUHf36bQudHrZDEUtmkIQSbDGK/p7JYa4o91pJSVnowDLvfl7J9ffpaztn9eE0vEiD
         iFVK/q98l5owj9L4b8Kp+gb0X/DENWMejdc8QSx9Du0+lndXAbfuVwZxaiR1aTUo/2er
         f86KULypQWj3/K6VAnIxoZm0gjh5y/C0b2yyPh77DpUlFnBTyauCU08fmj58A5nH2zrP
         2rkJ4WOax7CdFCTesaBF5d+DtgXC+OeYGYzkC+UI2lUO9YZkgOUTzXOatTDK5z1ydxp0
         G79lC973uX7X5AkPHacXmcvYdxa2OUnU1EqA1Gq3/XWcX/Sp2Hrcp8Ko62Haf73FjKT9
         Q5xg==
X-Forwarded-Encrypted: i=1; AJvYcCVn/uenkDSQUQDFOLot4H/k2YjyUD4Fhg7gB7aKnJqDJKgKY9ce46FyzvvxvfuKC/nPHwD9CukiQS+Sr5aBuws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRmPfdoRHSbxUUG4O+BMv5/pURNMOCSaeAZO6f9wk7AF3vtSM
	YsuCT1KY/4PobqX57vw1oyky6OT1NrldA1J6+tN4EP5sQrKbP4+a9LoBvhk3jXpj0q++OJeuEM/
	ESKAvH0/uJ21mK1qoLFGEmK0GmzFJnqoF/uq8npmEEFE06ufzd2efAmoAJkKbBiGpnEZdoA==
X-Gm-Gg: ASbGncu53CQdvmc8hZ20n+nOhO+Ij52Y5dSdKD37QLYV643giL7N1EUkxLnJXxxPHBw
	d/bp80aNaP6ah7o3xU2eekX3gkp23EzcBad5vIqnEow7nmjPUT25ZAjgmci7T8F1bJcQG+2oQY2
	/xmKGeFeNOL401MTC6+izR1A/tEAJRV9VBm5ekgN7C/ouMKgiwP9Bvs5OSRtP4f2YaYb3lQ0LA9
	8izSJaXBnymYO3pZwIGowm0BR97y98v13xOtJPt5dYyWWcq/zyv0u8qGPJLITGcEyGsWJhRz9sJ
	bL6vQc3uOtwcgkYlnUK1GO8T8U6MbhRSIIPKjt7wYS3oZiLycfyIPqlYIMnVEBQds5U73W5cvCX
	O4vYacBmbx3x4jUMEtnSIuCgz6N7MNQo3JLi5Eg81Ph9r8NcJVznO3vVisV6gPQ==
X-Received: by 2002:a05:6402:1441:b0:641:7a6b:c849 with SMTP id 4fb4d7f45d1cf-64554685551mr2478235a12.17.1763736821097;
        Fri, 21 Nov 2025 06:53:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9lAz58HxsIFQMbOGAU3fWFoi5mI2ME6nIrXhogNlTDwdR9nwXgPrS61dad+A+0EqEdsUphw==
X-Received: by 2002:a05:6402:1441:b0:641:7a6b:c849 with SMTP id 4fb4d7f45d1cf-64554685551mr2478164a12.17.1763736820412;
        Fri, 21 Nov 2025 06:53:40 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645364437b2sm4562045a12.25.2025.11.21.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:53:39 -0800 (PST)
Date: Fri, 21 Nov 2025 15:53:37 +0100
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
Subject: Re: [PATCH net-next v11 13/13] selftests/vsock: add tests for
 namespace deletion and mode changes
Message-ID: <64qxswblwdupklcau5apgkawfgs3tfvhd3mq3yqfw7v5yi5h7b@26hrfdpqxv4c>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-13-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-13-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:45PM -0800, Bobby Eshleman wrote:
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
>Changes in v11:
>- remove pipefile (Stefano)
>
>Changes in v9:
>- more consistent shell style
>- clarify -u usage comment for pipefile
>---
> tools/testing/selftests/vsock/vmtest.sh | 119 ++++++++++++++++++++++++++++++++
> 1 file changed, 119 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index dfa895abfc7f..5f0b24845fad 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -69,6 +69,12 @@ readonly TEST_NAMES=(
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
>@@ -139,6 +145,24 @@ readonly TEST_DESCS=(
>
> 	# ns_same_local_vm_connect_to_local_host_ok
> 	"Run vsock_test client in VM in a local ns with server in same ns."
>+
>+	# ns_mode_change_connection_continue_vm_ok
>+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
>+
>+	# ns_mode_change_connection_continue_host_ok
>+	"Check that changing NS mode of host namespace from global to local after a connection is established doesn't break the connection"
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
>@@ -1288,6 +1312,101 @@ test_ns_vm_local_mode_rejected() {
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
>+	vm_wait_for_listener "${ns0}" "${port}" "vsock"
>+
>+	# We use a pipe here so that we can echo into the pipe instead of using
>+	# socat and a unix socket file. We just need a name for the pipe (not a
>+	# regular file) so use -u.
>+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
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
>+	rm -f "${outfile}" "${pipefile}"
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


