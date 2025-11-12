Return-Path: <linux-kselftest+bounces-45403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC2DC5204B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40D154F593C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07B30BB96;
	Wed, 12 Nov 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAs6Fmxc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVQiZmhU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959983009D2
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946843; cv=none; b=U9hU2aHIufpuEdWOGV2cT8xX72jlOyog7ICOIXwjl5EueUs0GT/3cMNhXRF50M6rw6oXZp2yiyFLopp6dL0qi6pITlRzXMaZbp20l0JLYCygk4zA6m2o4dQFtaL1IXgfLFA8H+7kjyPYuB9NwqxP8Wk7ZLHyumbcTNFN5HSdCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946843; c=relaxed/simple;
	bh=4GFpYouVGxOOz3psCxGWSSpIfASjL19wnjG0Y6Ssa1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddXESq9GKY+DYrEtLugl9GOueeHLwsnHOfJ2ftKtgHoLOz8kvaDKIlwAK1WB04l5rtw839Zl8ZSv6bG62ACD1NpruGGputB7zMUxPwg3G2pW4Wqsdb8DrgNe4tHNuEYEF4vyeIXz2irUXHsBY9bHSOSTpEHg5L4i4mGUxWyo6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAs6Fmxc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVQiZmhU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
	b=JAs6FmxczLOe9kGN/JS3KoHxZ3f59VGcHRYA6KFvO1zDf9+CXkjL40/1ueaehjmsgjM5Dr
	owTCm20AhsBDT/XplV5jpoImydfWz8TLceQyoHthjnNgEOLu7FGrdeVuetNxPQuqtlHRtw
	BVQMByBgrLpDkLeslQ0q7hqCAX8TpVA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-U8OUowPMNjOGM7A-GW-4zw-1; Wed, 12 Nov 2025 06:27:19 -0500
X-MC-Unique: U8OUowPMNjOGM7A-GW-4zw-1
X-Mimecast-MFC-AGG-ID: U8OUowPMNjOGM7A-GW-4zw_1762946839
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b244ef3ed4so197732085a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946838; x=1763551638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
        b=AVQiZmhU8u0y8kKLuKhgICMGBOH5N1aaHyiKYKSEB9wdjDDuVWOE1+QieO3fPPLfaX
         mdG9r6W6RtDKl6yQgZar7wNXUcX6PPwz9MId3rwiNoxKHWbku0YEHsrs/3YK1m5XcWHI
         eBPEdsyMo4i7Ob/V1QKh6yU8MjuTgMf8q2kCS6O6CAm5b+qKiAfV4K4FeQgDfjWoHcn2
         o/s8/CFSZ0sAztih/FbjshJQgAMIh+p4ZUq1/XPcsnf+wgDeRn+VW067EyV6tQvll+4a
         5kgRjk2KB2Xq1d1xy6YxAmGuoyV5kKurLIrHd+V7dzD+8seAXdYulWrym85LOXT05S00
         VuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946838; x=1763551638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
        b=SEFagmiiqP+W5deWUOrMdbcqMl+EWzZ7XpXIsbM1SffALpr4bK6AQlbjBLEQQfUWor
         lcXIGskiFTFoetnSeNt5IB7iZnRr+IYVmzZyUk41arHzcVIDfD7Mrd9smxuyC18KpEPg
         8s6moXJf04wErDIG0c+dz9FN/kUYc6jqlWSJ1wwMB4i1t+wJws89EFwyPwgtZ08rG9ei
         0wV350pEZ6SPCAyAS6sfhzYD7xTBunrr3USJQ0R8g6MQg/4I9dP9wnrg2MsknugmqsUx
         92Cxvvm8OrPILLEJzIUz82d3hYsaqF7ucKTo7tYalg/IqOTn0rbFhl5SzqJ1OwyOG2m0
         wXSA==
X-Forwarded-Encrypted: i=1; AJvYcCWqfrafKfpZAmmgy98W1TwZUlk/tkddD1LnfZ2lFkDxzIWewfxQQ5jE1N3sfd8yg24lVZFJsEfK9KIFfGUtg9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOhyujHZ/5ygsoRlnUuTpEZW4f3vSnfYjt4mzIWVGesldO2H1
	Zd/7Ad6+NYUDlnqp5Y9aKTMMq7lFDq4tppwToEAp3+BJ5cHEsWMPrucHk0hQtcFSAQwt/Dlz7kT
	pDUvgQrzIPG+JRoI5xQO8OV6z67/bS70BSV7pkByNZRqqu769n0XqPWcdpuaiEflLUW5YglN5jl
	8prA==
X-Gm-Gg: ASbGncuVFZnHS9MPEcaTC3Kz7T+Atmgc8FtpLps3PKrRQ3pZPASQM9m8z0Me0hsOw7I
	QNqX7B2AKVOeVsssDNhDHoUA/pA6AshHJGGfuqJV3h4iHkxhgcfgxwiUEXW4BgNJSI3eCuylTwb
	PpYXnC0tIaQ3XPPITnI+r7w7TJ87zr91IAuDyUAMgkAvoghnpwVZf+KaPOlkyce+KucgGL1XaGM
	jiAWygLF1fTbulQmVEpw0dbAmZfIgDm/zfhN1/AfXkPIT204EK/iLXEieDpno0tGAnrTc1BfEBe
	4eIKud/OnPIPx22lZg6/Mjii3DRJZlB8qkKgoMQyxgkLdmfISyi9sTeAJUdSKtsvp4XvokMz2io
	a1duTaFdATpJUURx96yYSfo8C8chjx2L0fDqQSD2SUAo5H1jqcDE=
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301639085a.49.1762946838657;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiq2o9VPSKEA3WnYmptOCbMHYXZ1Xc1tiIgbtvh2JnbBd2gww/tn2z5FSFACTcc8Z6rSWeNw==
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301636985a.49.1762946838217;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84b075sm176497985a.7.2025.11.12.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:27:17 -0800 (PST)
Date: Wed, 12 Nov 2025 12:27:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <z2lxg6zlt5l3f2fhx6lwfeiu2tclm4o4et5wykraonyfjlayos@oatpvj3hk6om>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:59AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>In preparation for future patches that introduce tests that cannot
>re-use the same VM, add functions to identify those that *can* re-use a
>VM.
>
>By continuing to re-use the same VM for these tests we can save time by
>avoiding the delay of booting a VM for every test.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- fix botched rebase
>---
> tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 2dd9bbb8c4a9..a1c2969c44b6 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+
> VERBOSE=0
>
> usage() {
>@@ -461,7 +463,44 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>-run_test() {
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
>+shared_vm_tests_requested() {
>+	for arg in "$@"; do
>+		if shared_vm_test "${arg}"; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+run_shared_vm_tests() {
>+	local arg
>+
>+	for arg in "$@"; do
>+		if ! shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		run_shared_vm_test "${arg}"
>+		check_result "$?" "${arg}"
>+	done
>+}
>+
>+run_shared_vm_test() {
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -537,23 +576,21 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-pidfile="$(create_pidfile)"
>-vm_start "${pidfile}"
>-vm_wait_for_ssh
>-log_host "VM booted up"
>-
> cnt_pass=0
> cnt_fail=0
> cnt_skip=0
> cnt_total=0
>-for arg in "${ARGS[@]}"; do
>-	run_test "${arg}"
>-	rc=$?
>-	check_result "${rc}" "${arg}"
>-done
>
>-terminate_pidfiles "${pidfile}"
>+if shared_vm_tests_requested "${ARGS[@]}"; then
>+	log_host "Booting up VM"
>+	pidfile="$(create_pidfile)"
>+	vm_start "${pidfile}"
>+	vm_wait_for_ssh
>+	log_host "VM booted up"
>+
>+	run_shared_vm_tests "${ARGS[@]}"
>+	terminate_pidfiles "${pidfile}"
>+fi

I was expecting something in case the VM couldn't be shared, but I think 
we'll add that later. It's fine for now.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>


