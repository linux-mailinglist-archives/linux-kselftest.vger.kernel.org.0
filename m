Return-Path: <linux-kselftest+bounces-42614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D7BAC0B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 10:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A4B17FF79
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D52F5327;
	Tue, 30 Sep 2025 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTBlHWqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491C2F5301
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220851; cv=none; b=ARlaze5LyddMRLJ4BaSRBjv3w278qfG4G1OreCfDXGXp4kZeRKoOjPvwsC28V/WeEC3tzG3woB6M08VAeOS6WDeodzNuqWIyh1HAtmx/iQssVSNYtp32dGnI4q9dCjIMpvuEe9JNFhLQCZ1kkAEzDAOJlJou8G7220zdtzhGGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220851; c=relaxed/simple;
	bh=OByUwkUqD2B2/nwZYmEaHE1jBaKbSJmFUJdyN/riHtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcwN/DIafgv7azllTr6JAVP/985efC9Cz8OYl4IfGxG1e3dBaWDwK9uKmoGth217/ZWxW2BCiSkSQlK1mt8dwgWRqX6pVpRqVCcW9lgNoA6bvxzjlOgtn0g+VRXzYv+xDxuA8mi8PKHkQzP2wx3iPNFOCVkr/hoiJ1YjQfHlFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTBlHWqV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759220848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k53564HVWSnWT4QeushBTs4QSP6pO7lgGYw2Y1kNtA=;
	b=LTBlHWqVtQkGJ5JN9YKXf4Bq6j0OGzwDE5w5zM+IU24HQTKC457ZBnI2btqZXPM4beck5S
	yCtjhQq9y3zuUNrq7xoGQ20KxLA2+Mg2Jo3qKol91q/1+0jPIfqCZRsLCxdTdhei1NzGUO
	ipvcBu5VWGc+2xR8KV0lLj7SdAq5PLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-LpcLqV-RP5eDR20JlmfH5g-1; Tue, 30 Sep 2025 04:27:08 -0400
X-MC-Unique: LpcLqV-RP5eDR20JlmfH5g-1
X-Mimecast-MFC-AGG-ID: LpcLqV-RP5eDR20JlmfH5g_1759220827
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso3481228f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 01:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220827; x=1759825627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k53564HVWSnWT4QeushBTs4QSP6pO7lgGYw2Y1kNtA=;
        b=NvF0XZuyDOrkKfJqvO8/do/t+WZey78/I9SwI18fmMNBgzDn4NNuqEXhxcaH+DBrlh
         r3b+H+Rj1mQ4meHskTSponTHzjQkEi77G9ZfvcMV1Tsgwbmb0+s8Yz44Na5K8J5ozFQq
         Q840jicFyR5btRUiKvKhjfg5QU21U7XzfDrYj1PBJDgMDnG1mOArY2EW4fPducXi6VIJ
         wg+WYK7wJHfO/m1u5UR3dP91jT0Gmo728JhJS8l1w5tXkv3+MKMF/DUX/Ukl7JfW8rUC
         LmK0lySNDFXmwbXCOLW1yHo1UsED2c1It5jl/w1I/Kq/vtLlBD7WvKArukSFW40pd/7E
         jNqg==
X-Forwarded-Encrypted: i=1; AJvYcCW9SOKM0m/BuNziMh2wYdYVjQCqkn7mH7r32rvzlco6x+4f94NRflbCVKo03zjiCwYID5toTxc1++xmXelAm/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88u+akyklaLUkqqhaR7Q5DN8ziXc41p8nWf7RQjoW+I8q2/Yn
	hvCc7WlfvSs83LX48+lMre2HwyBZi+X5DaG5fhcAaMmSogcscbICiBqg2FgiiEDsMbNQzDjVqX7
	/p7NgVt0OYMJ90pDEXb9sJowS4AAVjrr9lGpgDg8m0F+NSzGrAo883EIIlF/3El49Fkk/aQ==
X-Gm-Gg: ASbGncuSjCiMZfBjCeYVYhyvg734YrzNU6mpFHpcMNYMiSYIHLact/zIAUjeQfy3Ljr
	qlD1JPtK6kHcuY4HDulrHUIYKkadALgs70oYi/WOqydt76VUwEQkFpQNLfij5QZlius+ph4Jh3N
	De8rh76vWDFATdgPj3d5PHR2h7LPCoU4JpGTa8xwrZRTJB/oooZmXDD+6nZuPdIcRHiToHT97VM
	wzhq8riKdnNW6j6v8VC2J+N2BC/MJzAKycGPcFShh37mf0Au+vLBZo4qVCRkyVgWI4bE9cOObxX
	81s3rx6Uwy2XWSEtAulZ8xnKo1dxKVROFLdJA4CkcqM6BQ7FAQ1LOUgNf6fUt1lJ9heDRT7TB6o
	W3We8pvm5GIbWkQYsGoA1Dg==
X-Received: by 2002:a05:6000:610:b0:3ee:109a:3a83 with SMTP id ffacd0b85a97d-40e4ece5726mr16763797f8f.29.1759220826780;
        Tue, 30 Sep 2025 01:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErkmBK2pEHIR11t9h0fOhWc98uNL2Ww5V4K1p5cxBvz0HlJrGFndWMq/zucbPlLC+5Qu2udA==
X-Received: by 2002:a05:6000:610:b0:3ee:109a:3a83 with SMTP id ffacd0b85a97d-40e4ece5726mr16763764f8f.29.1759220826311;
        Tue, 30 Sep 2025 01:27:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603381sm23147503f8f.31.2025.09.30.01.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:27:05 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:26:55 +0200
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
Subject: Re: [PATCH net-next v6 7/9] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <f7oeyneht4vxtfolrgv36b5tu4zreffcwztimc6s5jixszjt75@yjkhcuhuwbpi>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-7-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-7-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:51PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Improve logging by adding configurable log levels. Additionally, improve
>usability of logging functions. Remove the test name prefix from logging
>functions so that logging calls can be made deeper into the call stack
>without passing down the test name or setting some global. Teach log
>function to accept a LOG_PREFIX variable to avoid unnecessary argument
>shifting.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 75 ++++++++++++++++-----------------
> 1 file changed, 37 insertions(+), 38 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..183647a86c8a 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -51,7 +51,12 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>-VERBOSE=0
>+readonly LOG_LEVEL_DEBUG=0
>+readonly LOG_LEVEL_INFO=1
>+readonly LOG_LEVEL_WARN=2
>+readonly LOG_LEVEL_ERROR=3
>+
>+VERBOSE="${LOG_LEVEL_WARN}"

If the default is 2, how the user can set 3 (error) ?

BTW I find a bit strange the reverse order.
Is this something specific to selftest?

The rest LGTM.

Thanks,
Stefano

>
> usage() {
> 	local name
>@@ -196,7 +201,7 @@ vm_start() {
>
> 	qemu=$(command -v "${QEMU}")
>
>-	if [[ "${VERBOSE}" -eq 1 ]]; then
>+	if [[ ${VERBOSE} -le ${LOG_LEVEL_DEBUG} ]]; then
> 		verbose_opt="--verbose"
> 		logfile=/dev/stdout
> 	fi
>@@ -271,60 +276,56 @@ EOF
>
> host_wait_for_listener() {
> 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>-}
>-
>-__log_stdin() {
>-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
>-}
>
>-__log_args() {
>-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
> }
>
> log() {
>-	local prefix="$1"
>+	local redirect
>+	local prefix
>
>-	shift
>-	local redirect=
>-	if [[ ${VERBOSE} -eq 0 ]]; then
>+	if [[ ${VERBOSE} -gt ${LOG_LEVEL_INFO} ]]; then
> 		redirect=/dev/null
> 	else
> 		redirect=/dev/stdout
> 	fi
>
>+	prefix="${LOG_PREFIX:-}"
>+
> 	if [[ "$#" -eq 0 ]]; then
>-		__log_stdin | tee -a "${LOG}" > ${redirect}
>+		if [[ -n "${prefix}" ]]; then
>+			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
>+		else
>+			cat
>+		fi
> 	else
>-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
>-	fi
>+		if [[ -n "${prefix}" ]]; then
>+			echo "${prefix}: " "$@"
>+		else
>+			echo "$@"
>+		fi
>+	fi | tee -a "${LOG}" > ${redirect}
> }
>
>-log_setup() {
>-	log "setup" "$@"
>+log_host() {
>+	LOG_PREFIX=host log $@
> }
>
>-log_host() {
>-	local testname=$1
>+log_guest() {
>+	LOG_PREFIX=guest log $@
>+}
>
>-	shift
>-	log "test:${testname}:host" "$@"
> }
>
>-log_guest() {
>-	local testname=$1
>
>-	shift
>-	log "test:${testname}:guest" "$@"
> }
>
> test_vm_server_host_client() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${TEST_GUEST_PORT}" \
> 		--peer-cid=2 \
>-		2>&1 | log_guest "${testname}" &
>+		2>&1 | log_guest &
>
> 	vm_wait_for_listener "${TEST_GUEST_PORT}"
>
>@@ -332,18 +333,17 @@ test_vm_server_host_client() {
> 		--mode=client \
> 		--control-host=127.0.0.1 \
> 		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
>+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>
> 	return $?
> }
>
> test_vm_client_host_server() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	${VSOCK_TEST} \
> 		--mode "server" \
> 		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
>+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>
> 	host_wait_for_listener
>
>@@ -351,19 +351,18 @@ test_vm_client_host_server() {
> 		--mode=client \
> 		--control-host=10.0.2.2 \
> 		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
>+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>
> 	return $?
> }
>
> test_vm_loopback() {
>-	local testname="${FUNCNAME[0]#test_}"
> 	local port=60000 # non-forwarded local port
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}" &
>+		--peer-cid=1 2>&1 | log_guest &
>
> 	vm_wait_for_listener "${port}"
>
>@@ -371,7 +370,7 @@ test_vm_loopback() {
> 		--mode=client \
> 		--control-host="127.0.0.1" \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}"
>+		--peer-cid=1 2>&1 | log_guest
>
> 	return $?
> }
>@@ -429,7 +428,7 @@ QEMU="qemu-system-$(uname -m)"
> while getopts :hvsq:b o
> do
> 	case $o in
>-	v) VERBOSE=1;;
>+	v) VERBOSE=$(( VERBOSE - 1 ));;
> 	b) BUILD=1;;
> 	q) QEMU=$OPTARG;;
> 	h|*) usage;;
>@@ -452,10 +451,10 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_setup "Booting up VM"
>+log_host "Booting up VM"
> vm_start
> vm_wait_for_ssh
>-log_setup "VM booted up"
>+log_host "VM booted up"
>
> cnt_pass=0
> cnt_fail=0
>
>-- 
>2.47.3
>


