Return-Path: <linux-kselftest+bounces-41629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31187B80182
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD5A1C0332E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D240D2EAD05;
	Tue, 16 Sep 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RaJg9tNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648D635
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063566; cv=none; b=DOFEeZ/jVvH2mXWKEBGn+HzpvtMA/yuEWKkwuKVqdt1Zb+wp73Y70JQK2pZzAC3/GBQKb9Aa8zhq3XxAwA0fZ/OzsBb7PSoaFu6PUEMnVGy49x95J58injthdhkh+65hpbyyRUWJtGXaxyMDSYNzCoow36gF2PwUMOaJn00HKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063566; c=relaxed/simple;
	bh=kYWD/1pnHOiVcV/86OAJQo2hlBq8UVutDfZZWO+nnUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SX9ASY7Awq+uOm3JFuMUsKuW0jkD5cdHNMyzqHHxCB5po5f3U/dBwMlqlVTjAOquGIdXQqX01sXg9H6UeLgW+B2XJdpicovUDJR8bY4qje/fx8fFLUE6rQ4VSLG5pC/tzXhAgAotZJnsZdv73SU5ntW51SwUVAPt0l2c93k/Uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RaJg9tNr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-827906ef3aeso341191785a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758063563; x=1758668363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2Sobvr9+5pGFbp47+ByPtEfYFFz5lnTSyJG9VlL420=;
        b=RaJg9tNrYLCV4vFhW3l2kOjm8ZyYitbIFQi0+ddGYWu5r/uh7Ql4Hl+ELB4YG/pyim
         UI25Iza0iTfYwvoIZt2oallEWaQPBBYeD59UWr7EEpS5LkNz9ogLH9GKDBvj/jxQv4+E
         wIiBtp9zLKtjp8+tyAOulREJoddlqFqOTF6z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063563; x=1758668363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2Sobvr9+5pGFbp47+ByPtEfYFFz5lnTSyJG9VlL420=;
        b=N404FehE7Iyjk6dz7q0z7kzB5MTqbwgr8tbfELFDfGkK9yv9sC+oGLPoSfPQ/jxarr
         UHWW427cZKPUJ94D0YfanCzG3LyYVSm5BwH/zYecUAsvRJX3bAvcS6eDL9ikOgGWPNK8
         k/SFlIEzjF2N4czGWUtC23F5QMaguSag2krjtidhHBHcbQXETxagg4f3F0zFOSIdaqzp
         nBeGjJvE8t9xpdRSYKaLJf+1P5sLHtCOl0I0D++sScRuFCTFsiQl4r4pWmAZZKeOBDr2
         tcQ5iIM86s7c4ePRTeCF2oreiCzX/pDBWkBWYocidZKa1VKRz8AsgYJGFXogvmIM5hgR
         BRhg==
X-Forwarded-Encrypted: i=1; AJvYcCUzoq9Qvsj9duAtJtz8RHU3QI+SmK/89+3PnFXFg6Se1lJpwy76OwGT9qXHKbZLdG1zCKI3zNqcBOFFXH7wCnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2dZnyNFotrljZZYXDN22+CUawQZ04OIUnsRJKwuDV3T4KK8W
	fSnfY8pzULOljBMRe3z+0YX9XHXSim0SuVw+VfJefaI+kSI4II8ivZYgyrkL79dZoto=
X-Gm-Gg: ASbGncusj3LkIq+7bEHLxiyPe59cqPyIq3F443/oFIQhScaiwhwlyRXStTXwlOAfbmP
	4NZ3XfAbQ/3gw6lHO1HC1vOXauXdQjrlstKAevUtZEC4DYXmUJFXaf0fu1MvA9hSUo+rF/AC9Ji
	iQsBCXgD+rSVBAvWBgYdx+7owEfaMdBOisBL6MJJV06xlTzXc8oE/YRjC5PhQQU/tgqalNqo/Zh
	pB0t/s3qEKDb1q4JkZejIXlG7pFwljgkyV+2WLtGEBvdkArPYimOxzCnFP1Iz++ExCc8s7RH7ag
	ZYjAOnFa3GnuMHB0eVG4tbddX0mIbTl9xaYZAXFMubudG2sWrvoE8W2GGCXXbZG7+iw7FySkjLV
	liu15oCcarW6vEsTE0WsvGXNvHFjUizbUd4A50tpWr343hB0XSqp6EA12HEStMybAwV8HdrAPYO
	t8iZ7NHJj1s86QgZwm/cPFcolABYhyViDZ8n3OHeqg03w=
X-Google-Smtp-Source: AGHT+IHPewFSAtglBYb72x7KGBoL3MPQo1PXWAxums+c5Qp8pXMLQan4rC8XJhOv0uEYkxN+tL5s9A==
X-Received: by 2002:a05:620a:4629:b0:828:ee0c:64da with SMTP id af79cd13be357-8310f02c9fcmr5639285a.43.1758063562631;
        Tue, 16 Sep 2025 15:59:22 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8281e956653sm613334885a.32.2025.09.16.15.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:59:22 -0700 (PDT)
Message-ID: <fef87364-80e9-4cbb-909d-22b1af0e9d3f@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:59:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in
 clean target to clean net/lib dependency
To: Jakub Kicinski <kuba@kernel.org>, Nai-Chen Cheng <bleach1827@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
 <20250911164137.29da651f@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250911164137.29da651f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 17:41, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 19:30:32 +0800 Nai-Chen Cheng wrote:
>> The selftests 'make clean' does not clean the net/lib because it only
>> processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
>> compiled objects in net/lib after cleaning, requiring manual cleanup.
>>
>> Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
>> dependency is properly cleaned.
> 
> Shuah, please LMK if think it makes sense for netdev to take this
> (net/lib is the only DEP_TARGET today).

No problems - take this through netdev

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

