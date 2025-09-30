Return-Path: <linux-kselftest+bounces-42615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AD1BAC151
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746E93B1221
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9D2F49EF;
	Tue, 30 Sep 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQBwny17"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E10248F7F
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221488; cv=none; b=IaXQF3NcaYBUI4LHqnhYXlIAS8yKOOIH3CP+0bFiiYR3IGO57yYberRyfZpqjuoD2cPJ5v5iCll8SNPUQfbbTRTJsdezIhAzzySZU2dD3Zbkib/x1Qsv/NZXiM4kF0g1p+jVlwFH1LtgyWCcIi6NKTsx33NkpWeuNl19bAV2Bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221488; c=relaxed/simple;
	bh=xnpiQCURkOhfQrdwgPHiUaP8a9tkI+p9FQwCHjcwcds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEgEbR/syuoMbF3QYbX30+EQOfDp8BUf+hoQke0TWk4rvuO2XE5VeAv9/46F6+TYBDCmKs/1fIr/mS5FCAQV2WUabxcwqga49jUNg9RS+L5WZOrc6qiZBH7i5JgCNh/dhT3YyxRE/kTzw30xNgplpO8pZRK3qAoH3Bc7RpiV1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQBwny17; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759221484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VccAC6xB6U34Xf9cLOXrFM7PAx88aOBuUi8cY9wyl/8=;
	b=MQBwny17xUu/2fqKh6WfVUW6GJ0P70U1AT1dRoD3rw/1gf+AfCyD8c2nTMYBdTzG3yLthF
	HtEr2d1ppNoM7CMrxJf+pN1N8cqy3SmZgmmEGcBVH//098vku1C5HjJ8zr6w1MdPdJ8bQC
	Yu09rJR9dobc+Ca/5AjrTFMH9NkFZ1o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-uOBW2z-FPnS33MS_HNDxiw-1; Tue, 30 Sep 2025 04:38:00 -0400
X-MC-Unique: uOBW2z-FPnS33MS_HNDxiw-1
X-Mimecast-MFC-AGG-ID: uOBW2z-FPnS33MS_HNDxiw_1759221480
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso39235295e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 01:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221480; x=1759826280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VccAC6xB6U34Xf9cLOXrFM7PAx88aOBuUi8cY9wyl/8=;
        b=pAfcucMg7nhdHGJA72I36BqJORxOCuwMZ8QVnumKXueDHd4yLdCSyotldAgtlFokTX
         V2Oc3oS29ZEnC+hQ174wyvhRlfrQ/Lt/x0CUR7akgA05xkgCrLdVH6/w3AMuS+mH2VoI
         2kmNNCUVEQ0lJrfwLy6nZIyPrsV2aT9pojM9Zm45rU9qwCQ241f1iVtSD8bluDXdfOVy
         uUbsBwM3B48M488hDao26thVUotFMjjCi4/VDeP2GsxPoVnp/+il0fENytBk90eRHQXX
         60pYejEECkVlOS3tmnJUR9+J0FYIIQQSEA8xwRhr/UHFNS+xaOsS9DMpoaar/uuFF8m+
         Uxgw==
X-Forwarded-Encrypted: i=1; AJvYcCUN8yu2EsZ7Qwu3+Ny/kQqtvLnuYhnxTBjSgmFcs1qHuii/18PqevA09FKhY/+j4NPjjd1SrCohgAihro7lRXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzo53x9MVYb9l314Ll01iO5p8ul/QdwxXG9fKJQHQtg7KJEmm
	WvqcXd+qg/omjkGKqTNq5Nsn0l/3y3isrvDNF1E4GYg6cc6d0FQM56Cyv6BHQ1wvA3Z1H1gxmRn
	0+nHeylyir4bAQNNxpN9uvp2UohtaA7cNLcAXpuC/hbCSKZtcQBe6M3GO64a4C41zYG16Gg==
X-Gm-Gg: ASbGncsuPNhwEp1/A8fC+boU+3WO4ugQFTrg3QGYQgZj8Io0i0hADRQrp8I5ER56I6U
	7ydooP3hV9kxVkPb4rurFvyathXofIdAwCD7KHkVMEbJJynwctytM6UG5VR/VUDZMUwjJvfIvwq
	T4RYE968qQE0Tn29E52+R1RVYcyrmNE9ZxNSFctlgTS0nasIl6KQPyeonn1jNNpWmmaQbu3Mxuz
	0oEmqoGZPZpjoi53GuWzo+I11OnVmnJ1qG053Kkph5an83rCXBNfNokYiHo1YetGVGYGuuy6wCd
	5p5SMx4M8LG6xiJXrJfPVsXHT0Rn+v64cOJ2JBT62tB0PbSMYS2obyc9etfpi57bIjta36YVw7B
	DKvlvHGD5TAFqMJ7Hd/3L/w==
X-Received: by 2002:a05:600c:1f86:b0:46e:3d41:5fed with SMTP id 5b1f17b1804b1-46e5da8bd67mr7433135e9.11.1759221479631;
        Tue, 30 Sep 2025 01:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO1GaSyS8oGmkfg/b3GKSfbgVAIueIpwgEMFL2DPKaUi87iq81o8rzQl9AgYDOFKU8/6wPPw==
X-Received: by 2002:a05:600c:1f86:b0:46e:3d41:5fed with SMTP id 5b1f17b1804b1-46e5da8bd67mr7432535e9.11.1759221479106;
        Tue, 30 Sep 2025 01:37:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b577c87sm10285805e9.0.2025.09.30.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:37:58 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:37:52 +0200
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
Subject: Re: [PATCH net-next v6 8/9] selftests/vsock: invoke vsock_test
 through helpers
Message-ID: <2a2qhhyui2by6cw3nqepwgfxxrknyjx5rgaybt4dvqowflom2r@i55r2csxbmb4>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-8-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916-vsock-vmtest-v6-8-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:52PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add helper calls vm_vsock_test() and host_vsock_test() to invoke the
>vsock_test binary. This encapsulates several items of repeat logic, such
>as waiting for the server to reach listening state and
>enabling/disabling the bash option pipefail to avoid pipe-style logging
>from hiding failures.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 120 ++++++++++++++++++++++++++++----
> 1 file changed, 108 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 183647a86c8a..5e36d1068f6f 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -248,6 +248,7 @@ wait_for_listener()
> 	local port=$1
> 	local interval=$2
> 	local max_intervals=$3
>+	local old_pipefail
> 	local protocol=tcp
> 	local pattern
> 	local i
>@@ -256,6 +257,13 @@ wait_for_listener()
>
> 	# for tcp protocol additionally check the socket state
> 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>+
>+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
>+	# an error, causing the if-condition to fail when pipefail is set.
>+	# Instead, temporarily disable pipefail and restore it later.
>+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
>+	set +o pipefail
>+
> 	for i in $(seq "${max_intervals}"); do
> 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
> 		   grep -q "${pattern}"; then
>@@ -263,6 +271,10 @@ wait_for_listener()
> 		fi
> 		sleep "${interval}"
> 	done
>+
>+	if [[ "${old_pipefail}" == on ]]; then
>+		set -o pipefail
>+	fi
> }
>
> vm_wait_for_listener() {
>@@ -314,28 +326,112 @@ log_guest() {
> 	LOG_PREFIX=guest log $@
> }
>
>+vm_vsock_test() {
>+	local ns=$1
>+	local mode=$2
>+	local rc
>+
>+	set -o pipefail
>+	if [[ "${mode}" == client ]]; then
>+		local host=$3

I don't really like having the number and type of parameters of a 
function depend on others, maintaining it could become a mess.

Can we avoid “mode” altogether and use “host” to discriminate between 
server and client?

e.g. if “host” == server then we launch the server, otherwise we 
interpret it as IP, or something else.

>+		local cid=$4
>+		local port=$5
>+
>+		# log output and use pipefail to respect vsock_test errors
>+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
>+			--mode=client \
>+			--control-host="${host}" \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest
>+		rc=$?
>+	else
>+		local cid=$3
>+		local port=$4
>+
>+		# log output and use pipefail to respect vsock_test errors
>+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		vm_wait_for_listener "${ns}" "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
>+host_vsock_test() {
>+	local ns=$1
>+	local mode=$2
>+	local cmd
>+
>+	if [[ "${ns}" == none ]]; then
>+		cmd="${VSOCK_TEST}"
>+	else
>+		cmd="ip netns exec ${ns} ${VSOCK_TEST}"
>+	fi
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${mode}" == client ]]; then
>+		local host=$3

Ditto.

The rest LGTM.

Thanks,
Stefano

>+		local cid=$4
>+		local port=$5
>+
>+		${cmd} \
>+			--mode="${mode}" \
>+			--peer-cid="${cid}" \
>+			--control-host="${host}" \
>+			--control-port="${port}" 2>&1 | log_host
>+		rc=$?
>+	else
>+		local cid=$3
>+		local port=$4
>+
>+		${cmd} \
>+			--mode="${mode}" \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" 2>&1 | log_host &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${ns}" "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>
>+	return $rc
> }
>
> test_vm_server_host_client() {
>+	vm_vsock_test "none" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "none" "client" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+}
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${TEST_GUEST_PORT}" \
>-		--peer-cid=2 \
>-		2>&1 | log_guest &
>+test_vm_client_host_server() {
>+	host_vsock_test "none" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"
>+	vm_vsock_test "none" "client" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"
>+}
>
>-	vm_wait_for_listener "${TEST_GUEST_PORT}"
>+test_vm_loopback() {
>+	vm_vsock_test "none" "server" 1 "${TEST_HOST_PORT_LISTENER}"
>+	vm_vsock_test "none" "client" "127.0.0.1" 1 "${TEST_HOST_PORT_LISTENER}"
>+}
>
>-	${VSOCK_TEST} \
>-		--mode=client \
>-		--control-host=127.0.0.1 \
>-		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>
>-	return $?
> }
>
> test_vm_client_host_server() {
>
>-- 
>2.47.3
>


