Return-Path: <linux-kselftest+bounces-45396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5FDC51DE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDD2F34C863
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C02E8B7D;
	Wed, 12 Nov 2025 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw/Ik6NT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2iZv6jk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D42BE634
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946114; cv=none; b=NM/CoLUiMVS+0NkvForJdkSwSG+rzLRdT3W6nTIVYCyxDUlSzEfNkzqBoL2XWQevL0/0Vki/AZgatEjv5F/Cjgr1OEXO47psAn1V7M0I5mzTr7QpA4PmvJ2WXjXjcKZGyR3pOwlfRsHht4ifzMMXdsd17KzDgKQseN4LKVU6FUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946114; c=relaxed/simple;
	bh=QJ7RsItWW94sQLYSWk24Ndul83P/s6M1Pj6x+zsl1P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCrDGeT/1bIl40+wwbKaSPYH5B/gOvIRPwDu51Zsc41LPiAGUv0H7svTCYOU3hgHdV7oRQpGL/9XnXQS5BP1xa/MKhPj6uLhyVSSX4oLPko/aP5go07FXwPHSMZ/2Kq9Bqa+0Qq/vhZ2sX3OChBgDF3JthC9s65X63zcAplgDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rw/Ik6NT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2iZv6jk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
	b=Rw/Ik6NTBCay3EpLKolrzqjaqodsp1xuD2dY792GGFLh1ejEHm/AxlZ2GIGjnE+DLaLh+k
	tTsvMH3PxBxwEUSmD+wcLrlYMhrk5NiaFaMA/zyME6HdNW7WQ6DuUjVT1RiccWRow4wube
	PcjE7Xs375AcFTcNT1z78EWSiRJGhxk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-uzqapr1dPe-OEF58PmPbCA-1; Wed, 12 Nov 2025 06:15:10 -0500
X-MC-Unique: uzqapr1dPe-OEF58PmPbCA-1
X-Mimecast-MFC-AGG-ID: uzqapr1dPe-OEF58PmPbCA_1762946110
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22d590227so75381285a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946110; x=1763550910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
        b=B2iZv6jkd/5HO4LZRYErbuKpHm1UwabumFpGY9l5LNAUnm3EIVRPwlgEpK+8oaTtpo
         tyi0By9GTba40ichXEcMm+GvefbGaGVgPtMNG8ZjCci79IBeyoKedmai0COaJ6F1GNnb
         Vkkd1pKzem1btV/d0HkGiiRBKIP8AFq/gvQ3WdCdQb9nKPYf4WN4rZplnhDYC85+EPcT
         9iR7Y6AmXjgqVyHRysMOlu8Gj12HEPz6g/JDrYNHhzI0maiI8QDN1MmAhV8qgY7prkzS
         Rny1FXTURllBsW7RtCaTF/WLWXoOr/sCJIrs36onezB4S/r9BuMoudBpPfBHFV+Eae5m
         toLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946110; x=1763550910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
        b=WCPU6pg2sAcTQWE5ryGyW9HS3SGF3M3xN7ZlOE3hxQxcLu7ARavMCD7QKokHPhehxy
         FEgxa/cUggj9N7zmHwlfL3a2UsN3uyL8gj8j/0KN/kLtzcQBHP8gbAgh8qHP/rXjSotw
         HfcFewPS8XxnycPs1sd5DAoTOkqU5DVU2wgBNcexdC6a5ulVzkZowFlhvCasYsZ9ZyDk
         5EcZUsoJcsDW2GBOsqYfo8tOMcr08iSXAO7gYyMJjhA7hbXQmznySXjgArvpT3+wMg2R
         lOFCCy2f/waHoeQQ/a3r7F2F1zsbDna2zxpRUgWp3Los7ByrpTQxkp6Z6icbH+ryF4Zw
         TrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOzqJw5Beq965XGAbgHHcyYXOaDNrVwJ+oan0DhgKG97CD0braEltQg0xZu8IvGKJl5sqOkfKxrQ+U6WRZmcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaRMv1rXo5L0H/MbO6noarroNjmeUz+lsIUobSxZmg3R9yYmB
	DiJIMRDMRf7PziYMy1sX4sZC6aITyBf3mrIiDbLN7L9dnRcCHx0036Ge9A9KsLzACfUSZ9LuBGl
	2KVpFVwEY7siJiJoOBg7UBcFykS2prMyMWXSOvnzK25xGr34S+hBEJfJ2YEuARTUZqVg9sg==
X-Gm-Gg: ASbGncsqIsnYr6EnjELvNbZ93mtG7W57gPdag+tVACshBDKWZTtomLlPy+z2HNJnlBv
	SO0naNZ5Y14s61Pw7L4q8ZNgCjruZOoYeE/Ax4MrIRssAQV5hBEOTx/Ctx2W66BM8fGt2Y9cYVh
	fgBMrbz8B8MpGMr3/EpEQPvRon+cH2S9nT1eRQ/z9k25HLp+60eQ1IOB0+9vbnOqbfW+JFGY2ck
	8Yy0Znp+SZh0DPQUSAKMg6S6knzlRWrPcdMD5A/XGOvOMDd9nFV0s9WpPgEqFcB5ssJ2YYsp+31
	72Q/aygVhqbZg8KPKKKjJ1JM87foKCmwbmLSBzgOUXG+Z4X2cEO7ylBsbUYFCNPATaCSFbbL13y
	aOhHg6lLWWmohJMXbp+AUndknum0q8r52TuwxKJ4FpyDVJTZi5pE=
X-Received: by 2002:a05:620a:44ca:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b29b78a980mr307073585a.37.1762946109819;
        Wed, 12 Nov 2025 03:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtAKTvMbP3cFM+QNIMi0izCHSApoyYNJQFMwUCPX7a0E+uO7ILp2ns+ST+uoNT4M7IO7oCPw==
X-Received: by 2002:a05:620a:44ca:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b29b78a980mr307070285a.37.1762946109277;
        Wed, 12 Nov 2025 03:15:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa277ecsm170269385a.58.2025.11.12.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:15:08 -0800 (PST)
Date: Wed, 12 Nov 2025 12:15:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <kitbuqe5a2tyjbtjcyijcpqioidmrxa4b3iq7kulmbngofyt4l@d73gmgipbiid>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:52AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Improve usability of logging functions. Remove the test name prefix from
>logging functions so that logging calls can be made deeper into the call
>stack without passing down the test name or setting some global. Teach
>log function to accept a LOG_PREFIX variable to avoid unnecessary
>argument shifting.
>
>Remove log_setup() and instead use log_host(). The host/guest prefixes
>are useful to show whether a failure happened on the guest or host side,
>but "setup" doesn't really give additional useful information. Since all
>log_setup() calls happen on the host, lets just use log_host() instead.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- add quotes to "${redirect}" for consistency
>
>Changes in v2:
>- add quotes around $@ in log_{host,guest} (Simon)
>- remove unnecessary cat for piping into awk (Simon)
>
>Changes from previous series:
>- do not use log levels, keep as on/off switch, after revising the other
>  patch series the levels became unnecessary.
>---
> tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
> 1 file changed, 29 insertions(+), 40 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 8ceeb8a7894f..bc16b13cdbe3 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -271,60 +271,51 @@ EOF
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
> 	if [[ ${VERBOSE} -eq 0 ]]; then
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
>+			awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
>+		else
>+			cat
>+		fi
> 	else
>-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
>-	fi
>-}
>-
>-log_setup() {
>-	log "setup" "$@"
>+		if [[ -n "${prefix}" ]]; then
>+			echo "${prefix}: " "$@"
>+		else
>+			echo "$@"
>+		fi
>+	fi | tee -a "${LOG}" > "${redirect}"
> }
>
> log_host() {
>-	local testname=$1
>-
>-	shift
>-	log "test:${testname}:host" "$@"
>+	LOG_PREFIX=host log "$@"
> }
>
> log_guest() {
>-	local testname=$1
>-
>-	shift
>-	log "test:${testname}:guest" "$@"
>+	LOG_PREFIX=guest log "$@"
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
>@@ -332,18 +323,17 @@ test_vm_server_host_client() {
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
>@@ -351,19 +341,18 @@ test_vm_client_host_server() {
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
>@@ -371,7 +360,7 @@ test_vm_loopback() {
> 		--mode=client \
> 		--control-host="127.0.0.1" \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}"
>+		--peer-cid=1 2>&1 | log_guest
>
> 	return $?
> }
>@@ -399,25 +388,25 @@ run_test() {
>
> 	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
> 	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
>+		echo "FAIL: kernel oops detected on host" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
>+		echo "FAIL: kernel warning detected on host" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
> 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
>+		echo "FAIL: kernel oops detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
>+		echo "FAIL: kernel warning detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
>@@ -452,10 +441,10 @@ handle_build
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


