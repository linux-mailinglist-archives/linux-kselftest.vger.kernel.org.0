Return-Path: <linux-kselftest+bounces-45908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A981C6B289
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC730362981
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D92350A2C;
	Tue, 18 Nov 2025 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyxFANt6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoIB6mbt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628E35FF5D
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489670; cv=none; b=oKiAtKyQPX2iokV1MHusmoU3BSgr6Z3EbSxz71joSCZIai9Xd+yOAurjJAWFnR+yQYMer8fLw1yhL+d8bWgWz9yF8jqYmY7pv05hwpmnjaoZQoDQUhFHC3nqDO5zMFbBpQGluPANb2oac3fCB7d9ab02sL309/ehNmrZ8ToUDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489670; c=relaxed/simple;
	bh=93pZ6dl5lFQD43TapInbMA0s7FqryaSyeA9SjB2/Swk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COPssjFdMo7pW6RUF7g3f+pRiQ7NBsly+ZPywZBxi2hRWbzYhbWYDgBvdZHOp0fKSFQPTteJDZJZUY+YxBZ5sJxBgInWmjjRwpYgoRtJIoCGOjHqiPGYAvK6odmQPS+Y+aliyfVNF4DDkFegkI3pEjW+JNMPVBHxoMApgfPyS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyxFANt6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoIB6mbt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
	b=JyxFANt6yvGLwFtZZXRMLe92T2h0WOcI+OzdkCO23MvE5GTFOQXXacMrTebz+tvtKp54vW
	APelpr78gDknDCu8a5GzGKrIZrBWLO324bY+qlCYo0LujHdNMWL4LhrO2GI65zqlBd8jl1
	+nVUZIOSHdA6FIFH5gtc+euy2xtdyXU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-pmT3mbTHMUGcZVuwVIfAhg-1; Tue, 18 Nov 2025 13:14:21 -0500
X-MC-Unique: pmT3mbTHMUGcZVuwVIfAhg-1
X-Mimecast-MFC-AGG-ID: pmT3mbTHMUGcZVuwVIfAhg_1763489660
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2f79759bso4163047f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489660; x=1764094460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
        b=FoIB6mbteb+Uo4T86irp/XzAl6AecdpoiX1D0DT6C3PRR71pDf/bnDxApUzfFSOtIt
         qq4r6VZwppZc2lahK+/F+IPRXCPfu/74Mbxv9dimzrI2PagLTlVw5DGveCMppD1U3DjV
         ziyEC8UTUUYUhs98KFd8xI56blKiIyDJUR8fk2kzm5ZVJZ7Dl9bM4mkJOE26AG/oXjO1
         MNM1o8q2G9KX85fRdGMpVQO3jort4EGrWpWkCbHWVSq3F4cc4NoHqHDhlNdBAJTCkCyF
         FZkZ4fqXExrsJPERHtiMld5kc9VtCqMYu3CswKL8xEFfgahzbZ0hDRQfSCGHgOuQakgp
         1FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489660; x=1764094460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogfCDQuwBr308yi4xavgkU0Sq9YiKn4sM5QwPOHCZ7A=;
        b=g58RQHlj+6k/ucipe02Zn2dmMVAy9n5QsayVR2o8FgZbv6rdi6Ft/9hi03i9jmzpo8
         /vyh2KgKQnpczma7EOgumfo/A4PzThXI7OzeMDOqNTB2DoXjUpFEcPcWE9ldwSCBFxMx
         lGjOF2qwysoZJatjK2WTntqbNN5zreRV0Sae7Y4qScELeDCNbi7/ujfOUjnw1tziFJLW
         ete2RNYoICndgveGm6Ow2LLTiuoMYmpDeeMRDCm9d6MDno+Rj/sCPMO56bnXijTj3TIJ
         7S9qf9MhB2yCzPqVnhVHEjgQRPDao/ITp6Xb4e4+stO8LqTeugGNggYNsBj6JQUUYZX/
         Q9xA==
X-Forwarded-Encrypted: i=1; AJvYcCVzM9oPCSFxITBTux71wrySYEszreCNohhZKK/+6kgTXd7+jS/58KXB9fI40PKd8HfEO6hefy104bsfVEkyHAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtaZmeUgdlPkx9sMtHPaQexB87AtXRenkkT4l281ADcEYVjN+
	zzZjBwFxQBx11aM2NijX70mViOvvU+dOa25MgNl2m/JUBsatya/5m+R0BtafVokIwMbyw5kq9RY
	dbAxwuLiJifx40xZYMQ7nDsGv5NAhkkx+eykhD6ikb060hH5uW+Tqnxx0jvl4OLpf7HD/sA==
X-Gm-Gg: ASbGncsDkgVwpPberHLpdt+Eh/AviyNZLouN4j3FPA9YSjmeVd2d6gwiw3VRSokY5Vi
	fShRTkO/V0DmPhLzjSpFw6Racd1pZnkaa9cerVFOX+c8rRNQDUIEtrTvlK8DF8kt5LqJKwe8MUp
	AG8BrgH479abChGDQOkASdY0qd7hTktxEyPpUFUzysl+ODp+Ig5zO7wN9HK02k1zCv8RX1Pn5Cu
	lDQJ4OfT/LX5H4piz2ygA+hEyrKvW/DTVlhNyhNNh1uElaxi2sA1W2UZQfKtK2DokygEAz5Npd/
	OEk7OmNs/XkZqqQWh0F+fcEGXzIwrGmOJmtOkz26Hyp272bd0CHgLpq65RcKH+C6gkn0wamJTdR
	Ba2+XsaGqwOH5/E++OutUOulj7nt2Fg203EN2qGLnDNoBJkwigwfKNEFfo6c=
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42b593849ffmr16260472f8f.46.1763489660378;
        Tue, 18 Nov 2025 10:14:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS8o+OnlcCO7Yj6XaGWOD+hRu7PmlcNwfKGvJu2ycvTutZuUYYNXih4+y5NlFSoF//9qYsmQ==
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42b593849ffmr16260434f8f.46.1763489659913;
        Tue, 18 Nov 2025 10:14:19 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm33992549f8f.37.2025.11.18.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:14:19 -0800 (PST)
Date: Tue, 18 Nov 2025 19:14:10 +0100
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
Subject: Re: [PATCH net-next v10 09/11] selftests/vsock: add namespace tests
 for CID collisions
Message-ID: <iyn62b6uwxgoz5r3rk3huca3ehwvh6zv4rx37hliqrkh3bknkt@qfmfnrwdd3ks>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:32PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests to verify CID collision rules across different vsock namespace
>modes.
>
>1. Two VMs with the same CID cannot start in different global namespaces
>   (ns_global_same_cid_fails)
>2. Two VMs with the same CID can start in different local namespaces
>   (ns_local_same_cid_ok)
>3. VMs with the same CID can coexist when one is in a global namespace
>   and another is in a local namespace (ns_global_local_same_cid_ok and
>   ns_local_global_same_cid_ok)
>
>The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
>make sure that ordering does not matter.
>
>The tests use a shared helper function namespaces_can_boot_same_cid()
>that attempts to start two VMs with identical CIDs in the specified
>namespaces and verifies whether VM initialization failed or succeeded.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 73 +++++++++++++++++++++++++++++++++
> 1 file changed, 73 insertions(+)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 86483249f490..a8bf78a5075d 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -48,6 +48,10 @@ readonly TEST_NAMES=(
> 	ns_host_vsock_ns_mode_ok
> 	ns_host_vsock_ns_mode_write_once_ok
> 	ns_vm_local_mode_rejected
>+	ns_global_same_cid_fails
>+	ns_local_same_cid_ok
>+	ns_global_local_same_cid_ok
>+	ns_local_global_same_cid_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -67,6 +71,17 @@ readonly TEST_DESCS=(
>
> 	# ns_vm_local_mode_rejected
> 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
>+	# ns_global_same_cid_fails
>+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
>+
>+	# ns_local_same_cid_ok
>+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
>+
>+	# ns_global_local_same_cid_ok
>+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
>+
>+	# ns_local_global_same_cid_ok
>+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
> )
>
> readonly USE_SHARED_VM=(
>@@ -553,6 +568,64 @@ test_ns_host_vsock_ns_mode_ok() {
> 	return "${KSFT_PASS}"
> }
>
>+namespaces_can_boot_same_cid() {
>+	local ns0=$1
>+	local ns1=$2
>+	local pidfile1 pidfile2
>+	local rc
>+
>+	pidfile1="$(create_pidfile)"
>+	vm_start "${pidfile1}" "${ns0}"

Should we check also this return value or return an AND of both?

>+
>+	pidfile2="$(create_pidfile)"
>+	vm_start "${pidfile2}" "${ns1}"
>+
>+	rc=$?
>+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_global_same_cid_fails() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "global1"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_local_global_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_global_local_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_local_same_cid_ok() {

IIUC the naming convention, should this be with _fails() suffix?

Thanks,
Stefano

>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "local0"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> test_ns_host_vsock_ns_mode_write_once_ok() {
> 	for mode in "${NS_MODES[@]}"; do
> 		local ns="${mode}0"
>
>-- 
>2.47.3
>


