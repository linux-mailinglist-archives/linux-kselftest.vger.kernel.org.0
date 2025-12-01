Return-Path: <linux-kselftest+bounces-46862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D8C9990F
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 00:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F02A4341C29
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 23:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED002522B6;
	Mon,  1 Dec 2025 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS2SK2Zm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZwcL92z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFA23D2B1
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631020; cv=none; b=pSaXVrXhIeoKLukEOh1c4bHoEXUFyeeDEwG9fJ5M6RcJc39MePFq5Y+4qWSi11IpaD7vP3NDL5DrDuyJ+q5Ifu4ttieRIA4J2RjnzRHcJWy7z1U6cqVkU6Fq2lG/98pOgWyzCQSTUEGs2pHtXhlsPBjjYzyWi7SN9hmP5BIyGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631020; c=relaxed/simple;
	bh=+lp93F6g8ek3RZ5nct/4V2jvnmStEmVEqjnyd/VFMow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mvwUzZh0wYLkJDuLw7fSqiFlJT+SwHxj7XuQRH7jjl378qUheEZFSvtYvKCQe4B4V8xNDdBjqLa302xKFZWMPaB0hjQgsl6X8cZKG5aBcI/ULmeHFDXrsSP/mg0RMfsly1G2HIzr0gC8uaF87orA3GZaV2TFOVy+0VxPZ+51+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BS2SK2Zm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZwcL92z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764631017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2JiQvYh5sm4dF/Ad/H8RwiLEUsI3vXlerU2PyyWqTY=;
	b=BS2SK2Zmb+G3uujdvGWMWHbnAZS0v8sxVIoChIYxDlKO/zdoSxOsaLwj26QvaYJCJalQst
	8+ZmDzqDyTtd2sGu69ejJrH4xBKLlY5REkF2FEkl2HV9DHgBE9Rcid/9nwjXaMi4XxnKTo
	UmzMXTV8/DE3LpcaoSHlgQqxBPFvtqU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-1uZbk_64OTWLqOvAO87-DA-1; Mon, 01 Dec 2025 18:16:56 -0500
X-MC-Unique: 1uZbk_64OTWLqOvAO87-DA-1
X-Mimecast-MFC-AGG-ID: 1uZbk_64OTWLqOvAO87-DA_1764631016
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297fbfb4e53so71728875ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 15:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764631015; x=1765235815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w2JiQvYh5sm4dF/Ad/H8RwiLEUsI3vXlerU2PyyWqTY=;
        b=VZwcL92z3sOcue09UMYWLcX4Z3qNkN5LE+Grl9bzeKH8QFQaKIvv9YHOO4xweLl1qr
         z5UWaB97oRgeROK8S8WDgwxQk0g2sc1DaueiFSeLG7s2ie47YuenJeVcc7ygNY3pgjk0
         PV1P/NQLcMhGRi36ePkICvYf+I4rSSIKdzm+H7CTZ7DLM/YYCfH1rQvUZ/7HWmDNujb+
         o7OIXcrmXtlO9VmCTiPG8ABSzz5x4TLqg2Dp+AQE400WWHDvoQ9VDcb4R2K91vQe7P2/
         rahnoT/SoIl0Yc/3D3udum2pQxhexoB94p2mvrYKBek5GsPjLLW6k0G/teRuo01nx1eI
         nf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764631015; x=1765235815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2JiQvYh5sm4dF/Ad/H8RwiLEUsI3vXlerU2PyyWqTY=;
        b=bKAyKVAmdc9Mz8xcjDquiwEqEMh13vXLLU2K+tvE0X05HQW3B5tagX1wb6CEFw/vXQ
         SVpedunFWfotz0DF7jy+pasZOkv6+UqwP9OLwB0yGJ6RsJqCUx0OzZcbPovCEAno7MYd
         /AlRzxmLrVwnVHWx5sO8VnNbBwLPccPja6m/IJn3yii0D1WSzB2Ki+EsnOLS4oS0tw2/
         KQuIVVjiZF2NVnLgahQIVPexzoEUOU/u26lCOAPqTcyKDvSDReSAed+kR4nTylG88EGs
         M9Xow2PzP9zX6jZqwl89M95VcASgs8llMEBkAaL27/fVZWb9QG0BUxvjJisfbtclVqqX
         VGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWxXFhKliiIv6KtSlPewZRGsXID+OxgQbFQ7e3mEwSWVEaSSdmLX7V0wCnJagNtUyDvf2z29nTRofbfJ0xIPw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ54K0NbGyI04B6TiEB5iDWqOYcc7NmsfyW9I0QKvJxTuzFIdj
	jM4p2fA4AjrZkxE3XJL+3US3nUZ5/n3VTpc9yhPyHaLd5JeSAGjeJU3/ptw79NSagldWHQRFOHW
	1xx0EYe9l04YrQ40nDO2vEcBPKvQ0zbIliT9jpTE5rSMimDav9OYwhNXWBD+I3F/Bo+Unug==
X-Gm-Gg: ASbGnctyo1XUlPsEKGo4brRrq5LOEZ6Fo821l/eV5heKtJKTQbpPMwi02Rj/smdYFoq
	rMNs5Sb6QBG2S7Yn+lt9d8+or4m7Z8haVFGTp0yhhhU3DsvouhxW3wbfk42nnL7+q7UPIMbTy2O
	DBDZy/69OaR5RfYgbP+SUxccoT+QUCitqU0RUF0NugHTplMHAyy3EyGY19X5PODvrhcCpcUuxCN
	BC+EIasomoHTqBdnv2xnIyM2mZ/ATR6r7JiXBk4a452p0sFwD+RqnEnRcurNU5GRAhW90Y1GPc7
	HvwSsRX0sb4lsRm97ynxZIuWQop+dFKFUl9mnAfR1iPlg9m04/22gg1EBVRcyvyFhWLgzdOAI4R
	014X0uYUfy5NB5pupVclcPHrm2KKZ0HZrVOcOi8HKb3Guae5rGw==
X-Received: by 2002:a17:902:fc4f:b0:29b:ab3c:83a3 with SMTP id d9443c01a7336-29bab3c8498mr289489415ad.5.1764631015610;
        Mon, 01 Dec 2025 15:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFyevsaXlVkZQPgAl9fthr313SLT72+cWZt8TDFYWvlLYtQ2urgXFCv6ronYdUQmllLwTzXA==
X-Received: by 2002:a17:902:fc4f:b0:29b:ab3c:83a3 with SMTP id d9443c01a7336-29bab3c8498mr289489255ad.5.1764631015302;
        Mon, 01 Dec 2025 15:16:55 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb27504sm134068245ad.61.2025.12.01.15.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 15:16:54 -0800 (PST)
Message-ID: <1c1860a0-91b0-40fc-acd0-97f04e6b3851@redhat.com>
Date: Tue, 2 Dec 2025 09:16:49 +1000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Fix core dump in rseq_test
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
 seanjc@google.com, shan.gavin@gmail.com
References: <20251124050427.1924591-1-gshan@redhat.com>
Content-Language: en-US
In-Reply-To: <20251124050427.1924591-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 11/24/25 3:04 PM, Gavin Shan wrote:
> In commit 0297cdc12a87 ("KVM: selftests: Add option to rseq test to
> override /dev/cpu_dma_latency"), a 'break' is missed before the option
> 'l' in the argument parsing loop, which leads to an unexpected core
> dump in atoi_paranoid(). It tries to get the latency from non-existent
> argument.
> 
>    host$ ./rseq_test -u
>    Random seed: 0x6b8b4567
>    Segmentation fault (core dumped)
> 
> Add a 'break' before the option 'l' in the argument parsing loop to avoid
> the unexpected core dump.
> 
> Fixes: 0297cdc12a87 ("KVM: selftests: Add option to rseq test to override /dev/cpu_dma_latency")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   tools/testing/selftests/kvm/rseq_test.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Could you help to take a look when getting a chance? :)

Thanks,
Gavin

> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 1375fca80bcdb..f80ad6b47d16b 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -215,6 +215,7 @@ int main(int argc, char *argv[])
>   		switch (opt) {
>   		case 'u':
>   			skip_sanity_check = true;
> +			break;
>   		case 'l':
>   			latency = atoi_paranoid(optarg);
>   			break;


