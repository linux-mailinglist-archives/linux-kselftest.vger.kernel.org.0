Return-Path: <linux-kselftest+bounces-45399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDEFC51F31
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B693118844EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107930AD12;
	Wed, 12 Nov 2025 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ibot0fyW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Od4EkHKh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689E35958
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946573; cv=none; b=hWr6oP7p6b+jPh397nmtBOGqhkAPMeymIUgXJuHaEsziCbfZ36HBZ3rYYC+N+blM0g1lco1RihoNPMhsEuMGtWFhhN7lceQm2PkupBT0N/esZvfWze0YnSFxfDU3qc4nSUHTYv5B6u1YvdPMQ91vVAqXaCg0ezqYpTbeAEutIWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946573; c=relaxed/simple;
	bh=VscW6L4TRLVaUV+OMnFLbNYIs/Ms82BMyVM2NevGrMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/YxQZg6P02nCEwojyIj2sEkGsqT8OOhuEcvu3vK2xrbZGEKl3qP61ih+CDf+iEVvpUHj+HxeOhHnohgtuFs4b57TNymNRfSCPZ45faBOZ9HMzwuOnj3hWZd30JTphU1+Vj3t70/dVeHHAAjVVHvPSJVVxFpYgWsDu+eWFT5eZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ibot0fyW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Od4EkHKh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQOIQDhY7o0sAkMRKEMYJWvC/pedPTBEzV4lKuummL0=;
	b=Ibot0fyWB7mQlqaPCrxiU9MAilNZ5fE4ES6nSY52kJvJ4NMAZjbMkiWfHmSPIwr8dUw6hl
	JBE9RD9FQXiCqHjepnhbNpo6trBSOEzU5jq3lgk9GgSp2CDF0t8pZulOYVivQbp/M5XpTF
	swvYeOO8Rnazlyy93TqSo08MlHTktZg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-URN8qhfSORm2yZsNW0BcEQ-1; Wed, 12 Nov 2025 06:22:47 -0500
X-MC-Unique: URN8qhfSORm2yZsNW0BcEQ-1
X-Mimecast-MFC-AGG-ID: URN8qhfSORm2yZsNW0BcEQ_1762946567
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88050bdc2abso18872136d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946567; x=1763551367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQOIQDhY7o0sAkMRKEMYJWvC/pedPTBEzV4lKuummL0=;
        b=Od4EkHKhW3O9wv0dFyc7U4BWMyAAUT6d+fAouaFJW5yS46/SRafvdK8jqpwb903zy3
         cU+NMcOcvd+nA1V3iv5vImEt1PeZiVyz7FakU9rxIMjDlE4mcahfgaRk04m0bfOXk+VL
         zwaMkfvWFDZ3HODhnCSf0r12F6Oc8WX2jNKwL/cPWQPFwvSGj+T6yFLM6kw334T2k66m
         BICAbF63lQZw0VAJNBSL28triajemWbSsmAFFG73u8ThmFlpfAt/rJvPiQd6dzWjbnC0
         7zqU1DMD7PdWUKXfmAVcWbchovVqmPsrW49dkLzuWxuHNKv/p+VNiA/y5yMk1erq4JaB
         V4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946567; x=1763551367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQOIQDhY7o0sAkMRKEMYJWvC/pedPTBEzV4lKuummL0=;
        b=AdJ/lpsj9uY+QBDfuZ69vlEaAoG1otiOR8qlwxl0hodV5MQbvcB3rTkYQcxCwRcDn/
         FRwT81Yuroa3w6EE0//VXuUkP6LmAuTboRYoOOxZezx0Sj7qo72x+EgYqTi86dK9n4/I
         uK4qSID/WHmN/Q9veQenZKyzfGV1LdY8vkeAS6QRkSp+YIaSciTy62VTN0fOnD3syWgI
         9zQM/bmHeBXKxCP0Lj1qPDUAw7XRWUwRizLJZhetRlhUXGTiVNgSWMMyL3P1U8IEjc6S
         8pHjYW8nEjGlZy/bIg1/EtJ6cjAbe5ZVJUaiaCeCLzKaAMgpfmqqx353ht1nK5uM6Tco
         kJKw==
X-Forwarded-Encrypted: i=1; AJvYcCV8BctETB+ywgq49MQpWSh09ukuQhG5LyZxnmR2lqn19CQvyKGR89XZdGg/u49SVJVQuCZq9YkLzUlBMnXSPE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR35GhhiPQu7LT2r9npGBKJxoMzUP1ik0NEX02t9pLknjIoET1
	UnQiVhrlcU5U+6toNl3QjKyKTuiUVubONPaPTUrp1I5r2sWdUUFmSw0IX5TEBtvyLg9q12RiO3C
	gtFtDmVSL4EaMmINBICPr84SD182czfpmiZTNMkAtdAvOQARUa8pz4OIH8c2WYqjWg+E1Gg==
X-Gm-Gg: ASbGncvCGcEOWvk1z2fc1gjAorc/QYnLHfRKIM0Cl0gBlcfbykV5SufJS/dP71F3DjO
	Hn8Pg48Z+ft71IvkrkDkfLbGEZWkLkfWrDmRH/cdo2BlFT8xglotZ24NBP0j4HhI66HVJE/mYaC
	2Qn1L0QFkGkMkFNeEkbv0dZUFK0XGmfe/6+wX3sshhvriFwhkd5uTf+eO6bo9a+6N4eBAGIxF6N
	hKgx9RGlaewC4MKDEOkBhB078pd8gufi/T5hmPggBdGhT1kfMYMi9TbDy4J3Y6JMtU2zQALyj+t
	lggLWQqtdYa0D2N1X+AGOFysVNA34RIij8xwKZqdSJXaWL6nTHuhitg98x1yBa1lOvm/lAyEa4j
	QaEGZ5V6YyxkKULYxaj+XXztCWh56CYZu8+Qf70UwKTCK+H747xc=
X-Received: by 2002:a05:6214:628:b0:882:44cc:f590 with SMTP id 6a1803df08f44-8827196c120mr33091956d6.17.1762946566929;
        Wed, 12 Nov 2025 03:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqYLLUPKJIhO1usMYZBZTm6T+uWhl/OzYeE42ktzFP1X9W5/fpalqufI3dtFeRXv+BAFIHsg==
X-Received: by 2002:a05:6214:628:b0:882:44cc:f590 with SMTP id 6a1803df08f44-8827196c120mr33091756d6.17.1762946566474;
        Wed, 12 Nov 2025 03:22:46 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b2936asm89469516d6.31.2025.11.12.03.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:22:45 -0800 (PST)
Date: Wed, 12 Nov 2025 12:22:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <sljr5fiyqg4syuhpfvese2dflrbse4cej5ydpazbphon2qr57w@vyn7athtpyf2>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-4-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-4-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:55AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Change QEMU to use generated pidfile names instead of just a single
>globally-defined pidfile. This allows multiple QEMU instances to
>co-exist with different pidfiles. This is required for future tests that
>use multiple VMs to check for CID collissions.
>
>Additionally, this also places the burden of killing the QEMU process
>and cleaning up the pidfile on the caller of vm_start(). To help with
>this, a function terminate_pidfiles() is introduced that callers use to
>perform the cleanup. The terminate_pidfiles() function supports multiple
>pidfile removals because future patches will need to process two
>pidfiles at a time.
>
>Change QEMU_OPTS to be initialized inside the vm_start(). This allows
>the generated pidfile to be passed to the string assignment, and
>prepares for future vm-specific options as well (e.g., cid).
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- use terminate_pidfiles() in cleanup (Simon)
>- use associative array for PIDFILES and remove pidfiles as they are
>  terminated (Simon)
>
>Changes in v3:
>- do not add unneeded -u to mktemp (Stefano)
>- quote $PIDFILE_TEMPLATE (Stefano)
>- do not remove cleanup(). Though it is expected that vm_start() does
>  not exit(2) and its caller is responsible for pidfile cleanup,
>  retaining cleanup() on EXIT is worth keeping as ill-timed kill signals
>  (i.e., during manual runs) may leak those files.
>- add create_pidfile() function to generate pidfile and automatically
>  add it to array for cleanup() to terminate and remove later.
>
>Changes in v2:
>- mention QEMU_OPTS changes in commit message (Simon)
>---
> tools/testing/selftests/vsock/vmtest.sh | 62 +++++++++++++++++++++++----------
> 1 file changed, 43 insertions(+), 19 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 3bccd9b84e4a..13b685280a67 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -23,7 +23,8 @@ readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
> readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
>+declare -A PIDFILES
>
> # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> # control port forwarded for vsock_test.  Because virtme-ng doesn't support
>@@ -33,12 +34,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
> # add the kernel cmdline options that virtme-init uses to setup the interface.
> readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
>-readonly QEMU_OPTS="\
>-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>-	 -device virtio-net-pci,netdev=n0 \
>-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>-	 --pidfile ${QEMU_PIDFILE} \
>-"
> readonly KERNEL_CMDLINE="\
> 	virtme.dhcp net.ifnames=0 biosdevname=0 \
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
>@@ -90,15 +85,7 @@ vm_ssh() {
> }
>
> cleanup() {
>-	if [[ -s "${QEMU_PIDFILE}" ]]; then
>-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
>-	fi
>-
>-	# If failure occurred during or before qemu start up, then we need
>-	# to clean this up ourselves.
>-	if [[ -e "${QEMU_PIDFILE}" ]]; then
>-		rm "${QEMU_PIDFILE}"
>-	fi
>+	terminate_pidfiles "${!PIDFILES[@]}"
> }
>
> check_args() {
>@@ -188,10 +175,37 @@ handle_build() {
> 	popd &>/dev/null
> }
>
>+create_pidfile() {
>+	local pidfile
>+
>+	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
>+	PIDFILES["${pidfile}"]=1
>+
>+	echo "${pidfile}"
>+}
>+
>+terminate_pidfiles() {
>+	local pidfile
>+
>+	for pidfile in "$@"; do
>+		if [[ -s "${pidfile}" ]]; then
>+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
>+		fi
>+
>+		if [[ -e "${pidfile}" ]]; then
>+			rm -f "${pidfile}"
>+		fi
>+
>+		unset "PIDFILES[${pidfile}]"
>+	done
>+}
>+
> vm_start() {
>+	local pidfile=$1
> 	local logfile=/dev/null
> 	local verbose_opt=""
> 	local kernel_opt=""
>+	local qemu_opts=""
> 	local qemu
>
> 	qemu=$(command -v "${QEMU}")
>@@ -201,6 +215,13 @@ vm_start() {
> 		logfile=/dev/stdout
> 	fi
>
>+	qemu_opts="\
>+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>+		 -device virtio-net-pci,netdev=n0 \
>+		 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>+		--pidfile ${pidfile}
>+	"
>+
> 	if [[ "${BUILD}" -eq 1 ]]; then
> 		kernel_opt="${KERNEL_CHECKOUT}"
> 	fi
>@@ -209,14 +230,14 @@ vm_start() {
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
> 	if ! timeout ${WAIT_TOTAL} \
>-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
>+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
> 		die "failed to boot VM"
> 	fi
> }
>@@ -499,7 +520,8 @@ handle_build
> echo "1..${#ARGS[@]}"
>
> log_host "Booting up VM"
>-vm_start
>+pidfile="$(create_pidfile)"
>+vm_start "${pidfile}"
> vm_wait_for_ssh
> log_host "VM booted up"
>
>@@ -523,6 +545,8 @@ for arg in "${ARGS[@]}"; do
> 	cnt_total=$(( cnt_total + 1 ))
> done
>
>+terminate_pidfiles "${pidfile}"
>+
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>
>-- 
>2.47.3
>


