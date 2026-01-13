Return-Path: <linux-kselftest+bounces-48879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD0D19FC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91BEA3009D5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A93939D5;
	Tue, 13 Jan 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRmf0DE3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiWvd68g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635FF3939B2
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319088; cv=none; b=oMRrAGYykUerYEVVhmwg8YB8alEtrjTp41Qd3uMKpUIuNi+5L3IjgTLh//j999cO39L9fmpOGcM4E0drigjFve0ai57wpq188yqee+AO3b6LFTtT9pQgkx603U/CR37zf68YlfB3/2+xyxYlzSGmOUeevoG9KybcU8S5mKqt1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319088; c=relaxed/simple;
	bh=JhyhgZnijw5QpfbaydtI94PP620au/36IgAqarY1YUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWwEFJTLuco1AehHHpKJUFZJqwsgnpAOEUXQGnHSr8aQT/yqMVZm7/WGkjcmhLNU1gckEws4hUcp/tDeIqTG+rOM4DWVVD3EST9FiVkmFL0Nd8x40dil6RdPi9j7b+qOFAvuYsPRyxY2Sv/omP/qOMFBhYDuqx6Dbvs2oZeEA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRmf0DE3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiWvd68g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768319086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
	b=NRmf0DE3PGccHUCcghfnjAm+gBhkLGAeP/zsT9bNbNQ3xiTUX1dyVCPbCKy+WY51IpM3vW
	l+HlQ2QqL+cOQGGJJ0pNCpSPd+fl1IRGXgAdJZ9im+UDhqUmSpCCT60aJwNE3BIkRLWDN4
	U1uIkaweLrZ++YHMC5XZC6BnCKaUYhs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-YdcbC92vPRePyQsVSHuvrQ-1; Tue, 13 Jan 2026 10:44:44 -0500
X-MC-Unique: YdcbC92vPRePyQsVSHuvrQ-1
X-Mimecast-MFC-AGG-ID: YdcbC92vPRePyQsVSHuvrQ_1768319084
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47918084ac1so71346085e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768319083; x=1768923883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
        b=PiWvd68gfa0m6UBoisTezMckQcjuYjQdc6PRvxiZgVXJZTnsA3r2iZvMOcBF5uJ4Ah
         Ki4En/71cvoqpmiwxHrXVW+9L3QcEJKB968+o4eOzTgh8HkNClttAHFJGnY7QJjUXx5t
         XhLnEM6WxuuiaRD1JiXT4e0ySsbJdVNZ18n6j8RGtzBnulaUjUpb0qGzgnOG0mRQ5ndO
         bil8OQKBbVyeWYoQSCtJjoVe29y8YWbDkNdcQWeB0zwFXZMzbItUhUJVlkWQ4QacEmby
         yoS+iAHwzoed8eRX3ewEai0eYgb5aQ9Fvqo51zsNjHhxv2ItQKFI7Je2WhZEFX5a081F
         OdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768319083; x=1768923883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
        b=hWnj+Pcm2Wvx3Ek1kN3WVzYgY8NkBynjmuxbND4KQgf+dmZhmaMfCiQH6yU1Ht9qCQ
         OhfKZfttrloLK957Bzshv15h2ngY8cmdffuAv/8YQ0+a2PNC9qjks317FpGoFw1wOLDc
         ORU4FT0IIP/Zt2hEmpRdV5/E38xSKi+s9HTYmxDQtuIni3ryJEueqYCGLmHMAMQot1Or
         LQURbkzPjBpGub8pMYledpSNXBayafvaFvpJj7mmMtPQRTMnW94kBcNpo6CHGxrtAMJe
         7USbCql1BI0AWcc5SWKXdElt+49HSry8XoDsnBV/gmqzWFTmVx/9kjwAf5QnT6El8K5r
         Fllw==
X-Forwarded-Encrypted: i=1; AJvYcCXzPPYfcOWzCvfherEfx3GH3EzkVF8gwOX78nYhwX6QXSL+eGEhlrmDTYYA2kr/Ghap1+AwIh4yxiV4zLnomwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBZ7jtXaocDvGSdIX95Ilk6e3nvkt7n8+DoQKquL+E4j7om1fV
	h5oeKsvvX+dfdd+Uy+xw4rbloRa+hTl/F+j+m3dqU52iVrqGjKubXeEh7xWJ+mVx6xjDvYPg6HC
	pdP9KUY/acApUquKHq7rbwF0GMMlPlNhpTnC5yNqpJQGjlCnJtYPTISmPpyUa/s+wuMrwuw==
X-Gm-Gg: AY/fxX60qYuTGpbtG6yXiuEL2dEg5bkIiiQWnBpSC3HP1zshEmv1HZdefMNlbh9GXuc
	kBuryRCm8TYm3u1xd8MtX/8FGIQW785FqhE4HsAanh59JuU4lDNXuEqLSyjJ2W7yXIFc3DrZmOu
	16GuIOrEtEbG3lSeqnIAkjwNs+Jad65VT237w45EnEO55C59tIK7X7lhB1RKSfaXQK78cyoaLA/
	9533glYPqP56IW9bkVbduntttzHAzCySI+t1BBqlQ/EWoHXNsQpxhEzk0fxCSuatz3Xe9Mi7hws
	8cHKwX8xEPgJNN8goRK/bbU3L+gsE0W8TA+HHKGsyv0VH/SZQo/8V3Ye2kYSp2yPSh1pdUlpxla
	x22VZjugD349wJcd50mdXo4kP0Pnt9j6rEoySS8xYZwLW1TVMIq0EH3W9hTkYmw==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr251937905e9.11.1768319083543;
        Tue, 13 Jan 2026 07:44:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdMqU/UT6yusYgmo7wLLK1QpcbQzRIghkGQravCSZ1TVNgzar9pv/6xyu/8mM8bGjn/QJ4Cg==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr251937595e9.11.1768319083140;
        Tue, 13 Jan 2026 07:44:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm402645575e9.0.2026.01.13.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:44:42 -0800 (PST)
Date: Tue, 13 Jan 2026 16:44:39 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 05/12] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <aWZoXUGyoMjKCm2u@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:14PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The add_namespaces() function initializes global0, local0, etc... with
>their respective vsock NS mode by toggling child_ns_mode before creating
>the namespace.
>
>Remove namespaces upon exiting the program in cleanup(). This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- intialize namespaces to use the child_ns_mode mechanism
>- remove setting modes from init_namespaces() function (this function
>  only sets up the lo device now)
>- remove ns_set_mode(ns) because ns_mode is no longer mutable
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index c7b270dd77a9..c2bdc293b94c 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
> )
>
> readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>
>@@ -103,6 +104,36 @@ check_result() {
> 	fi
> }
>
>+add_namespaces() {
>+	local orig_mode
>+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
>+
>+	for mode in "${NS_MODES[@]}"; do
>+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
>+		ip netns add "${mode}0" 2>/dev/null
>+		ip netns add "${mode}1" 2>/dev/null
>+	done
>+
>+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
>+}
>+
>+init_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		# we need lo for qemu port forwarding
>+		ip netns exec "${mode}0" ip link set dev lo up
>+		ip netns exec "${mode}1" ip link set dev lo up
>+	done
>+}
>+
>+del_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		ip netns del "${mode}0" &>/dev/null
>+		ip netns del "${mode}1" &>/dev/null
>+		log_host "removed ns ${mode}0"
>+		log_host "removed ns ${mode}1"
>+	done
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -110,6 +141,7 @@ vm_ssh() {
>
> cleanup() {
> 	terminate_pidfiles "${!PIDFILES[@]}"
>+	del_namespaces
> }
>
> check_args() {
>
>-- 
>2.47.3
>


