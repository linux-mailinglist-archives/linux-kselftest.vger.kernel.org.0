Return-Path: <linux-kselftest+bounces-44824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CEC36B36
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 17:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D810C5015D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECFE33556E;
	Wed,  5 Nov 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axC9Sd2L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8aOGak9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507632E743
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359400; cv=none; b=qsgxrogUKADozLD75jjeq4lJqU92tmkUUHEWrehm6rW8zAOoValR8tRmFeHap10z4kCOO3WqZK1Wh7JmaMp4peVM1k1hx7InLSvTXgH++pxBDjz6H5vSPqm41XDuOvvUWYnFtsy+Y+YePYrNBb9X7fuMsEFQGX0Caed7H3ppVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359400; c=relaxed/simple;
	bh=Z7eZPun2oefAkSM3+F0++XPUVNTkIWBrwjzNYiRkZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxLnre6ZX34pD0DZLP3MDo/QAeZB8hXira/HS+NGMBsjbmfP9K+WS4uS9pKt8/aSuYHQFVatxePjyPjMP4BYZBl/KpIaf0EtkJnMJheFn3e1s06WOJQ9qHcIzFWRVv6yYA5ZxiGnhOxOsMEpeRM/R6jq09gUHxX0uRwCF/Nx/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axC9Sd2L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8aOGak9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762359397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
	b=axC9Sd2LXQsrjAV+npcKVW72AOoC7Ott56th3kCxezbJv4+M/MyTHQIVS1kAXSIbugyg2+
	sjpK2ZKlJWLnOmCuiKmR3uAMFODkL6C2HTGF5tNeH9XQn0TgBzZlm3HCON7Ijl1IlPbcg5
	F3gKfcwzVguXOaVsxg5PuU5qg6mSUtU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-0kTa2ImwPwudkqrjBU41TQ-1; Wed, 05 Nov 2025 11:16:34 -0500
X-MC-Unique: 0kTa2ImwPwudkqrjBU41TQ-1
X-Mimecast-MFC-AGG-ID: 0kTa2ImwPwudkqrjBU41TQ_1762359393
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477212937eeso47252885e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762359393; x=1762964193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
        b=d8aOGak9u1t2OiNCqVmiW5WUQk/pefp2soSF1/PSBHpRnHYPIp6u/1kLlDmR0Ce4/B
         GD60rr1gue63FdJ03HRwTt5GhKYBNbaNI2h8Qh/j8z8lf2taO31ubQjQQszQE3C2lpEP
         A30K1hVwDS2P5XWilErfs6qTMxtW0GV4enyCuLqYMWlnG0zrL7stGJXGMtytfkmCq/XG
         ilbnOPkwq9ga57gD3ozMy3xxDvSjdjG+qVpsHOEiLIqKectvQiLBidjxERsqOlhLPoAm
         Vee7oFIc8AIgIrJHZMgBtEYMIp9W+3eRxzN6lYQjO5FFxWxae947Q3Pg0GEnSDyrjD2G
         cVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359393; x=1762964193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du/r5ksOWZtDfSJI4YOsWmAPKYTxSvBd3w3sn3Syt2A=;
        b=UdoMewyXceoEQh6N8/ali2FRj0/sQMSunOEQbOh3vmwR2wKARpZbs0zpKLpMni6mX7
         42yu3igaD0D9WAme6ShOjYVtBHyUTkhaNAoHHXp3DAF0hL7KpuNwv3qDryre72n6G+w+
         8p1RTWcjfHN7/ev2tRmnnxEyfqpbWrgfWTae6a7JpuuK0Zy9iNd2wufVBbQzOqwVDj0K
         Nv0kVqA87ZpisEGPaZiPZUO5q4TM1l1pyB+a8bO6bF8W8ynYWoiUQWZvk6YXDFEOBwSm
         cgkZd5siYTlrtDIfRRVVpYA9pKSEVHgewJUVxdmcovVbYtHvWRekIcJC2tixBXL1Xtb5
         oSVg==
X-Forwarded-Encrypted: i=1; AJvYcCXdFGSXYebLle0H8+inYuPYL1HqwYNmn8iK/SFRHgNuuysASAcfPjUjIVwMfp4P8fTRQPm8rANl8LiJDapP9Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3p0dNDy/Z7766lrpkRUQ02aW1ciEebDgVtQ9jC4rDHftRICEH
	SGddhIdoRNcf/ppVsyPGAz67gwoqBdNs+rFea+Mc/uabjxJlduQQcZi0xYCIILEtfR+pKJQVweY
	qA5EHuMADz/ODhWZ/++adCvQp03Sd7Y0FJM7ae/ODR2Pg8wnqe5XiRzDrzkooAk8WZ12i1g==
X-Gm-Gg: ASbGncvO25GV5ntIxb8CqRuHfLDU2d5hwOnsfl6PF3nyROLf8MMRPazC2aOZ3VzAqot
	1S8en3j5FhugDYVaupfwS8x7pE6Fa1eaGJ0PQOsWiLyOvaHvAzYgddc6VyvrowkNiOxj/qsRyfE
	Q20lL9CJivFzRieX+jDcab9xBv3esU5S5Qdy+bG/9rI/0Xaqx1cHewjLTpprcBZCnp0toF83ZPr
	JZTd0LSUVtXdnVCSzmA2glfefsMoJRxRMhHsaX9tAiQgPPQyFMW6RyIT0i+vMhVaUeL1igz/v31
	oghw2xeyxoeH9XkaS2xzKxW7xCkOIXKrgZ4F+9YR26gKODi2EHl0ojSnK8kRg2e2W/EItVTY6ye
	n0ow=
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr30986245e9.28.1762359392866;
        Wed, 05 Nov 2025 08:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1zaF9xjh7lShdpMKxs0x1j37UBOgMCZm7D8elWZkrx4hb3LonHqe/99De4jJ82rRpyZFkSA==
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr30985775e9.28.1762359392381;
        Wed, 05 Nov 2025 08:16:32 -0800 (PST)
Received: from sgarzare-redhat ([78.209.227.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5af7sm12313106f8f.28.2025.11.05.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:16:31 -0800 (PST)
Date: Wed, 5 Nov 2025 17:16:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
Message-ID: <5dkiqiatpxuq3wnizyq25c4hmiztglefh5icdcxpkvmej775nn@qw4gmh2bheyf>
References: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>

On Wed, Nov 05, 2025 at 07:59:19AM -0800, Bobby Eshleman wrote:
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
>Changes in v2:
>- use consistent quoting for vsock string
>- Link to v1: https://lore.kernel.org/r/20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com
>---
> tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index edacebfc1632..8ceeb8a7894f 100755
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
>+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
> 		rc=$KSFT_FAIL
>@@ -415,7 +415,7 @@ run_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
> 		rc=$KSFT_FAIL
>
>---
>base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
>change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


