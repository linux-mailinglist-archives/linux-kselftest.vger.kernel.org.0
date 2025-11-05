Return-Path: <linux-kselftest+bounces-44815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6247C36256
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2761D3451C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2123BCED;
	Wed,  5 Nov 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXj03Umm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lXSKymJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF08239562
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354148; cv=none; b=H9Uhn/ifxFJ7D83+tyQmydufpH53mEUdh8mgLtkfvpS46oayI8qV8cq4GSCpuuf5JGNqaD6M9MnmCQV2aJrYgPeBFMn9nShqNHaztK6ys12o/FyvZ/GG2OH727dV9yXA/kXv9HQSeT8UJxZCqTyvl3Tla2Al8Ol522N8TXh180E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354148; c=relaxed/simple;
	bh=YfvMW72encoRkud0wVtm/A7j2WUacp04L3fsNBayHvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESOOGHaxuTlRS/5nBewcb76pPcijo8nC4SaMmF2mJofQlETcwwWY31ivKUhocqVmSmo/XjYLFWQ1sv3GeVes1Uvgm41J5ugLL+LOBSENGlchBJQGmruzieRZhk8ByljFBz/FGjw7uBuP/xvxaxzgejdkuoJAwCXov0ODmuC1PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXj03Umm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lXSKymJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
	b=KXj03Umm5zqC78KHtiI0lrsWdn1xNo2qS0DrCilMNvvmF6ZwBQzN8DzzIJbMkVC6pXGkiy
	d0GYO8T2HoCh4nvWFcgWJ1pNZZ5JsG4iKvVT/OuHwM0h7VRj+BVxZHzYejhkcCt+POyNVQ
	9ZAj5GcpKgBE0zZXy9zQrbrpKnFcpgQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-uvRwYGFTMWWneb85Hi4r2g-1; Wed, 05 Nov 2025 09:49:04 -0500
X-MC-Unique: uvRwYGFTMWWneb85Hi4r2g-1
X-Mimecast-MFC-AGG-ID: uvRwYGFTMWWneb85Hi4r2g_1762354143
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4774836c376so26797705e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 06:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762354143; x=1762958943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
        b=lXSKymJZLRal60Vh76tTo85Oz6Ng9PEp/SrkcphQ9kZ7PQyiuc+90rnnuzfn3ne7/I
         W3bc+6sREp9EkKnVgWIqvLfinym7NqMG1SW5b4isQkqah6R4F3w2yarBiutxX9/aeWqw
         M5HuZQmfSN5rwol1BkpVuUJx7F1zLe/9SmHm/prlIoQacB68rzeImmNmKdQFOtYoma7Q
         rnhIMZYmaGD8WdlBGq5g5Qr0jIqwf9dVxhhtX08Fjtv3RRUvGaVuOOLd7nIO9gtVGYw+
         iHtjaHQ+bxMqxSA3vR0YTMRxEovgjgwVtWuR4fzykypPbZEGxykQJhlr7NoZiHP3Nb74
         KwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354143; x=1762958943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43sHUCklMiFn+SiCjLKJSBqe6MedMG8UZiB50DllYfo=;
        b=E1kLMxPdT+SCWnhEuTJk7DzD+9ICZhXPC04kFAY4Rwohe1y7zvtL/OeYOq3Bq+6h1D
         9q6f0sa92LAGS7TVzL4KETWkZvr1kE+CULbwFYf8ZVXlhg64kuDylLK4WkdZABTzGEz5
         QUQ5uBU/qSYCRLLeJ3J4BXZSynk3yU25H/r3XJ+g2A5pwpZGdIHk4FYwcFCAOfkmi2bK
         EIatSBNTnxuFG2FIoWB/uQrxQ3vgPowabi4RdHtUEZqhN/9ftsGW1y6SmbJlZwuNyAkT
         /tmosaDSJZ7DZDI4rniqK5yYnDGmPAAcdcDgPmNI+fFNqthwQePX3/F3GNKYdi48CE5h
         ko0g==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7xMEtu0Svz7OgXpkw33VxiKqdn2GFQk7PvvuWoASSnAFLZJZ2tjZMQuq374HafyxQ0dafIw8mq/0Z08dILw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGTn+53mti7atEP+I+rzeGLoptyr5o49wR251MEz7nob/FUM1
	zGicvqf842xYDcjTcfTBy+O5E97tcT+gSikFeJtlJg6KR5IGjiRjEtsJ+SqryjvttkJyMxR1t0A
	TndmQBc0/nkBQdMlECjZ+zzD359pR4q+4e1RjjD+quap+s1vuMr4XOKT7oB1wjoXsIx1aDQ==
X-Gm-Gg: ASbGncvI1gR6epli2ZQFqTt2dPgED/wCZs2nxxr7cXJybKp+Wc9g86xZodGa+owMMeE
	iod/lvY7YeZENiDUHXdwiL7PS1P5OVdK0ZzWMqfPSk9ZGAx7ql+RvzmLs64Jc+rxjZqf9bfv3vu
	/GjHIuenBrcIXN4Zstma5++LaxqcXWgiBrPmKXlV/9ctojPV5dg3d8mi2qmi4q9o8NSnJLhxdpl
	9kwOUFfSUn36C9FIfyNK3qBRx6KTdQ9+tW4F2flfrtR5cO0H8JGJ+y3mZoPtOWBaHl0ZaFnwQGX
	jiUUbsNoYJPkvPG0iVD8dv3ljT4/YW45hpRZDqJK2+81BDWN4rAeFuIys7JMuby+c+e2xLQbd90
	=
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953905e9.6.1762354143238;
        Wed, 05 Nov 2025 06:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJCkXVCaYKB38WQ9mVlW2atyii43mXLtD2rPfe/M0bgqyi++PixdCT104cVwdbGCHZnaBsew==
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr30953665e9.6.1762354142802;
        Wed, 05 Nov 2025 06:49:02 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f41bsm10751085f8f.9.2025.11.05.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:49:01 -0800 (PST)
Date: Wed, 5 Nov 2025 15:48:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Message-ID: <ubfxj7koxuztrlrydfpjxenu7sdydq45rnhxkpmuurjfqvyh4j@mwzsqsioqzs5>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:39:01PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add vsock_loopback module loading to the loopback test so that vmtest.sh
>can be used for kernels built with loopback as a module.
>
>This is not technically a fix as kselftest expects loopback to be
>built-in already (defined in selftests/vsock/config). This is useful
>only for using vmtest.sh outside of kselftest.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 0657973b5067..cfb6b589bcba 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -434,6 +434,8 @@ test_vm_client_host_server() {
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
>+
> 	if ! vm_vsock_test "server" 1 "${port}"; then
> 		return "${KSFT_FAIL}"
> 	fi
>
>-- 
>2.47.3
>


