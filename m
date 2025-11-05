Return-Path: <linux-kselftest+bounces-44795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3FDC3553F
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527C14628EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1B30F7F8;
	Wed,  5 Nov 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcvEiSmm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq/LViCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77930CDAF
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341449; cv=none; b=COabwUQ3k0FbNXokaLyePPZSPQ+hOzQ5RNBCaF7qv7ad+XFOOI2vy5iSKABv4ECrhX1KaEe38gJnjJ/EnBnQZsOKCTUQhmKI1EG5D9j9yPUe/Vjq2tm+rcQ0wXaCGmya3aO8lqh7AbSY2KKUOvfmVkeYLbUKp0ayZuCXh+AsRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341449; c=relaxed/simple;
	bh=EIruf+q68s7Apk3JnbRaT8nDbQ4uqSCgVg4dKHFgp3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuQa/aZpeaKqX+LIgFCd3hfLTtYFfuMBHQ2I/cT77epKrfKBybt7SibtrNR3hzdK4R4Juj57SehmRP/WOL25fYq41fFy7rxjIHcfCanqONP1AdYns5GebD+gas8j10X3BSZujNp8dVi908Dz/8SnwELCGOshdoiJeq0BPhjoYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcvEiSmm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq/LViCL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762341446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
	b=BcvEiSmm3eNSzA1gQGm3+AyWvLhzGjG8y5ZJrNm0kD8NcFDmpKTn8bWiv0mbPR3gNtfX6v
	xFqaqyblKnk/1JptWw/VMnXaDPp7gNmMipqqLQHwH9DiDrBSEDnBHuaxA84+3A0K4u5PUa
	6DY8kBR6l/jaJuLXvWybvbEtr/EnTXw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-62C2Otp4PtO0IzVh3AikGQ-1; Wed, 05 Nov 2025 06:17:25 -0500
X-MC-Unique: 62C2Otp4PtO0IzVh3AikGQ-1
X-Mimecast-MFC-AGG-ID: 62C2Otp4PtO0IzVh3AikGQ_1762341444
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso74975895e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762341444; x=1762946244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
        b=Qq/LViCLXgEpV6/U0lNiB38+T1C0AH91AyA+6diE5t0rLt+LO5uloDj5+joYGYvCy0
         pS7hjMtsA4IJXAJ9BGY6OY1D+W/odH2TJaI8nNAXxLylTw1U+y+s553GwVDh+66nKQeG
         vvys8xUwzdPN8/nLD/7bB14GTa78MPz1hVqFfYidHa5GsYl+g6nKnGcPl/PFdabm7qUL
         W2EwGtBYZDAytDCGDmf1aOsr4BgehqrpselKyYp0HGWLp9Yn4M9tIaQ2ce5NMrjEI+Wq
         V7KcLqhmbiV29oGc3AFtRqBLkzPy9iSNH/0H+EqE25FwJU4QWa537G3PrhDE7VwmXGZ5
         rVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341444; x=1762946244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJvv5ndjic3rP/0jjQlvKlNTvtUhgk3xpudTBbq2U1A=;
        b=cBdcefvKRVkGsHlSXgVe6NBlvlh44hRh2VUy0LMmPEzo5SrciZiWOoeYYXHQpF8uAD
         94Oun84wbYguOJygshKAbj3DxDQgTFLWZ91ZXiQLkEDcH4rD8iWXvMxeonzmITIg567p
         mDrG8udXPYRXgH9luSKDF/J8aWI9MJEnDWJn5yPUSYRcWU4cEBUftfoGNprST6sSM+b7
         urfhgJITYPMn/u6sllXzSgihRQSN10VOfnc5pMbulspt1hDM5Rde03Eu6KIkJeUtpvje
         cHE4gXRuUUB55MghBDy+MCnBqSaKsrt8T85c2Kbks8i+qggZI+JGFm8h3BnW/AcpipqB
         /bFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVip99MGYmlkWiYwztwS1ZDOLC+GvDVX1LMW+RsDMOuSHrxqVaVYhnhSZBK5LwChPluDTozncvQfE5mmyHqaaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkI+rJqXRPhD76FAGb2G9BgToJxPY7bT2Msi80+Wzx+Zo3Sxh7
	2f2SIGqw7EcDm592sRjlrsHWh4K/V2f/gGLuN2Ia/Olv8oINMe30LXHpz2PUNZRFVFGraPXGkBn
	jYj5LKzgpl5nxrx9d8L3VVQp55WfUaFvaWSNP+qrxbU8qdZVJ2U2CVFI6WVqt9OreU++WXA==
X-Gm-Gg: ASbGnctNSavO/tS2cJcXQpoRWfddkloKVS3aLnf6HDmrAPU0KJPxWwcYC9YkidKwcgI
	k8rYdt6IDIyeg4dwqG2fmcr96z0i8WLtRROWr8Nz8E6Dzfg/7aX1r3FOl54urW/xMskvtHavW8m
	wrq/LAUoqWbNwMVjKyZC4mF2Esf2XfHEkFSoXbFancNRZfidCpJSQ9yIv7RtnUafzp9dFZ9m3lB
	6KS+PH57QbtTkcb1qVbnezQ5fNtw7PoFiF/Arhr9bg+ntDP+JEKUxGDoGthaOP9sYQgGE6b2bVW
	W0yZvtqf4iyglC5+6tavOWofrkC8iXSNt6f9mEP0hsDcOvjzVMiJLH1szwBJ5QIGBiYnuleD9f8
	glxw7
X-Received: by 2002:a05:600c:1c18:b0:471:1702:f41c with SMTP id 5b1f17b1804b1-4775ce26b5bmr35419345e9.35.1762341444083;
        Wed, 05 Nov 2025 03:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNzHvCUGAag3+wrnkfdKLHqAtmgiZqn0Kpfqlpb4QSMfUNSwUxHezyd0VrzCOLaf/mXC1/LA==
X-Received: by 2002:a05:600c:1c18:b0:471:1702:f41c with SMTP id 5b1f17b1804b1-4775ce26b5bmr35418935e9.35.1762341443637;
        Wed, 05 Nov 2025 03:17:23 -0800 (PST)
Received: from sgarzare-redhat ([78.211.197.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm42323005e9.5.2025.11.05.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:17:22 -0800 (PST)
Date: Wed, 5 Nov 2025 12:16:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Message-ID: <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>
References: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>

On Tue, Nov 04, 2025 at 01:50:50PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Sometimes VMs will have some intermittent dmesg warnings that are
>unrelated to vsock. Change the dmesg parsing to filter on strings
>containing 'vsock' to avoid false positive failures that are unrelated
>to vsock. The downside is that it is possible for some vsock related
>warnings to not contain the substring 'vsock', so those will be missed.
>
>Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Previously was part of the series:
>https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
>---
> tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..e1732f236d14 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -389,9 +389,9 @@ run_test() {
> 	local rc
>
> 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
>-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
> 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>
> 	name=$(echo "${1}" | awk '{ print $1 }')
> 	eval test_"${name}"
>@@ -403,7 +403,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)

In the previous hunk we quoted 'vsock', but here and in the next we did
not. Can we be consistent at least in the same patch ?

The rest LGTM.

Stefano

> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
> 		rc=$KSFT_FAIL
>@@ -415,7 +415,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
> 		rc=$KSFT_FAIL
>
>---
>base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
>change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


