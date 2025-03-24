Return-Path: <linux-kselftest+bounces-29626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8DA6D628
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 09:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1857D188C315
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1625C6FE;
	Mon, 24 Mar 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gMsoovib"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698A25D209
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804989; cv=none; b=ciQb9FitnVbVlAlzNCerQ7hoJZ8bqiwkMru1vyK/uyEhitAfAkDCRe7Fs9CiSITq9/3lj/gvXMMniN59dywLTja0YPLXKKtjn7WHpCLy394iegYoQhJMpf/CAKaa8agf7uiQQtMu1VEs7N/IUls4r41XIUzMn1pnYe+tcB4VMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804989; c=relaxed/simple;
	bh=NzJP8TqEb08WGj9kYfvDbx+CpZLoCO3wvBykc6g+6mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvQ8laPlv0W1GB+DnoBKOxwqdTCfrD6COtY4pnuazvsFgG9Ar+xxrpPdhTtkJ82af46jMF6neh5gwQs+ksLqSccX+DI8LwK5tcZtAvO+d0lbrd8UkxwPg5A5PDtZO5eATOwYem0xtZSSjP5g9FVbUuxuWd9mzw1Rb/hiEh944Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gMsoovib; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so69527045ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742804986; x=1743409786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qMUlDAaek7Ax30c0AGSTiyhNrDt/tYOpdl5MsMoLow=;
        b=gMsoovibKmSv81FaIAbJ9TjBXOxhesE6qDSuZej0OaUgJK9k9PZ43q2GBOsJ50HJSo
         BYlXxmAt2EBq60V91lo6qmWoOn0u4ZqDiCk75leuCFnH0zqpcKfhaAHbs9By3tswSTN8
         FPNGMuA6ndcnQkQ9JbLkSMR3WHZ2q4aQFQ02bLbfmTt2bIb2a9+UY2bLUjQ+75Socqol
         VuiT85EyHZ0AN1NHVNdSSDxBm9sJGn8UAK6tGtMGXqI4BR+2AMb9sMTBqaYAsugBxydW
         e1pTLS7nN4aKWsSUWv5d9DOYThG+qTy11Fi6a4Q2eZngH2BeEVLNl2Noq+E3cVZ11Rdm
         KA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742804986; x=1743409786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qMUlDAaek7Ax30c0AGSTiyhNrDt/tYOpdl5MsMoLow=;
        b=V0axGXAtd5JWcw6UOwsSBc/pRp99AN/vsRmMi2TGjB1E+xqQD67H4ZdzlFgEi7OhK4
         P4WmbSxIGPCbgnKP2skFybDm1oUcSjEErN8V4Xwk+fD5lbzr5zEcv9UxARWAEZIVzTBN
         CVlAeEGF6Qv/oc5BcZ8ROK7je3KyZdrOx5EAPpCXjXK6yxMzAfLitnKqJwdhHyg5cEuT
         Ykmd15i26HOEg92HH916srhl1w08DznvK3HJXCwE90apr2SXpnTqOe3EtKITcNdzXyTV
         nIyNV+teLzImpv7P7ChBSljFMcNR60jV3htg7uDjRuNWkQ55A75GgaAarEqFFhjEatp7
         UDIA==
X-Forwarded-Encrypted: i=1; AJvYcCWA9/k3Ri3VuFpWCsARkyWuvZL/mGGbltRUra2YUlL2xftw69vR0ZJkVvnPgX6mr6b7b5irf58DLQwWoU62fgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87eiA1BaiSX/9jfdh6BhGXO8Ot9A7GMaBqRv5Q8fcnt0I6Ipy
	yKJWejljVRVZkTV3fSPny4PDkAuSTb8soMdxGSkeoWVLrXEQJe0p+1MN6Noj9R0=
X-Gm-Gg: ASbGnctJJTs5XGmPJrwXarS1hdiAt8bt5LftNqsd1OzskSJb8G0nWjV7AS12C2HzmUe
	TVqvSIz30hrs2Ow3ApdxLq/YGFQZDSpfQhDpGcshrwS7k8YIGR5zQOBWk+S94eZP5Gf2A0Az9W8
	GeAFZTYLbjKQSJ6viz/FLHayO3HLc7T/xpNNFvXzz7gpcv1nNQxMZITP2Weu487RRekKS8HWgGr
	Au4t3WnuO7TMn5Tt1D5B4wZQcS5AcjPAs9tCmBo4HKiiF6ucvpIR1Q6D4F8+6n1HkH1CLtSh7JH
	R2hGdRHgff7omQmjhZ4vXbSbsEz5glLLL7ihVuT6wrXv60B+v9gjoZoadBmj4AwSbhdBEM2PLJY
	1jOvt/q78p3rMiA==
X-Google-Smtp-Source: AGHT+IE/svKRMr10qo5TWA29tMIKA3okBWKKu6uK4vQbAlDiEPBzS0bf2OPavcRs7sE+zsZm2iXV3g==
X-Received: by 2002:a05:6a20:a109:b0:1f5:7007:9eb7 with SMTP id adf61e73a8af0-1fe433193c6mr24677051637.37.1742804986196;
        Mon, 24 Mar 2025 01:29:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4747bsm6509935a12.68.2025.03.24.01.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 01:29:45 -0700 (PDT)
Message-ID: <779c137d-5030-4212-b957-3d2620448ea9@rivosinc.com>
Date: Mon, 24 Mar 2025 09:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/18] riscv: sbi: add new SBI error mappings
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-3-cleger@rivosinc.com>
 <20250322-cce038c88db88dd119a49846@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250322-cce038c88db88dd119a49846@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/03/2025 13:06, Andrew Jones wrote:
> On Mon, Mar 17, 2025 at 06:06:08PM +0100, Clément Léger wrote:
>> A few new errors have been added with SBI V3.0, maps them as close as
>> possible to errno values.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/sbi.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index bb077d0c912f..d11d22717b49 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -536,11 +536,20 @@ static inline int sbi_err_map_linux_errno(int err)
>>  	case SBI_SUCCESS:
>>  		return 0;
>>  	case SBI_ERR_DENIED:
>> +	case SBI_ERR_DENIED_LOCKED:
>>  		return -EPERM;
>>  	case SBI_ERR_INVALID_PARAM:
>> +	case SBI_ERR_INVALID_STATE:
>> +	case SBI_ERR_BAD_RANGE:
>>  		return -EINVAL;
>>  	case SBI_ERR_INVALID_ADDRESS:
>>  		return -EFAULT;
>> +	case SBI_ERR_NO_SHMEM:
>> +		return -ENOMEM;
>> +	case SBI_ERR_TIMEOUT:
>> +		return -ETIME;
>> +	case SBI_ERR_IO:
>> +		return -EIO;
>>  	case SBI_ERR_NOT_SUPPORTED:
>>  	case SBI_ERR_FAILURE:
>>  	default:
>> -- 
>> 2.47.2
>>
> 
> I'm not a huge fan sbi_err_map_linux_errno() since the mappings seem a bit
> arbitrary, but if we're going to do it, then these look pretty good to me.
> Only other thought I had was E2BIG for bad-range, but nah...

Yeah I also think some mappings are a bit odd even though I skimmed
through the whole errno list to find the best possible mappings. I'd be
happy to find something better though.

Thanks,

Clément

> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew


