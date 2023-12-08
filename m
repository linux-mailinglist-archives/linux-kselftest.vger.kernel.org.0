Return-Path: <linux-kselftest+bounces-1411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ED6809B7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 06:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96371B20D3C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 05:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA036641;
	Fri,  8 Dec 2023 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR2gyJ10"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B11BF1
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 21:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702012050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DjOW++h2qpYv/KAC35xyOMKgc1I7IXf0474RhNm4+E=;
	b=NR2gyJ10zr6rJ7QI2Er/qlFTkrgErvHWCi6siRkAqjXYN9I4PfWpINNMMSamVquQNe280S
	1phRD0Kn3MYbaIWMEGZMiQkiY38ztLcZbABsP4fRJqW2pkzKYzgw+JW6JuG2BsOEnDU18m
	D/eR3V6ZAdRyK2zzFbeYAerX59iJP4w=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-7gu3wztRPxKm1T3ya4UsHQ-1; Fri, 08 Dec 2023 00:07:29 -0500
X-MC-Unique: 7gu3wztRPxKm1T3ya4UsHQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d03cf821e3so11795485ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 21:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702012048; x=1702616848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DjOW++h2qpYv/KAC35xyOMKgc1I7IXf0474RhNm4+E=;
        b=kLpfec612VJM968hYWl7y9yipJcB7sX5475JbLxm/w8gzRJf025ZtkcjCl6vSQo1bi
         OiI+9MgkgWuMoM6h0J9ovk/7ExSPS/HOkVmaYEmPIsaiZii7kYCqj3oif00lTCOwGIKH
         sXVu+LvsfLgAwjTN52QWsZb9JgbX6S5T9yk3v+NaHd7naXpPP02GFryXuSGYbjN7qIUf
         0GeykGhqvIBDKZHemGXf/7vfR4D9ujFZk1WiZjc3wgo7C4B7RQS9HgZjUBdUwSFRMcVl
         /UctK9e72uPtP0NLZdim1Bd3gqQoqfJzVR+ktObGG4gcuRCc9sBzR7Bb+7prH/utdIIv
         BkrQ==
X-Gm-Message-State: AOJu0YwngKYLbDMrC7QR5MYxNgu9UidmpDtQmJEGrIoh2sKwITJwE3SB
	UXA5wGyHG1R8uLD8BKCjrNHQlEdRD1B++pqN+GhcoanbLLDwwDW5OKwxDF/cSg6oJ9f5URewN/J
	3B+UsgRw8Ua2/k1B3J4uLAnMTNfEM
X-Received: by 2002:a17:903:228b:b0:1d0:b16a:b26a with SMTP id b11-20020a170903228b00b001d0b16ab26amr3435387plh.4.1702012048131;
        Thu, 07 Dec 2023 21:07:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6LlOSfQMdwKQHpCvinXE+YTOV9LAn4L/4e5piuadXfTGPzQr096NtqUuMnxxErVNRlrsErQ==
X-Received: by 2002:a17:903:228b:b0:1d0:b16a:b26a with SMTP id b11-20020a170903228b00b001d0b16ab26amr3435375plh.4.1702012047799;
        Thu, 07 Dec 2023 21:07:27 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902869800b001cf9ddd3552sm701722plo.85.2023.12.07.21.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 21:07:27 -0800 (PST)
Message-ID: <c8e1594e-1379-4fb3-904f-fba2cd194cdc@redhat.com>
Date: Fri, 8 Dec 2023 15:07:22 +1000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: selftests: Fix Assertion on non-x86_64 platforms
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
References: <20231208033505.2930064-1-shahuang@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231208033505.2930064-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 13:35, Shaoqin Huang wrote:
> When running the set_memory_region_test on arm64 platform, it causes the
> below assert:
> 
> ==== Test Assertion Failure ====
>    set_memory_region_test.c:355: r && errno == EINVAL
>    pid=40695 tid=40695 errno=0 - Success
>       1	0x0000000000401baf: test_invalid_memory_region_flags at set_memory_region_test.c:355
>       2	 (inlined by) main at set_memory_region_test.c:541
>       3	0x0000ffff951c879b: ?? ??:0
>       4	0x0000ffff951c886b: ?? ??:0
>       5	0x0000000000401caf: _start at ??:?
>    KVM_SET_USER_MEMORY_REGION should have failed on v2 only flag 0x2
> 
> This is because the arm64 platform also support the KVM_MEM_READONLY flag, but
> the current implementation add it into the supportd_flags only on x86_64
> platform, so this causes assert on other platform which also support the
> KVM_MEM_READONLY flag.
> 
> Fix it by using the __KVM_HAVE_READONLY_MEM macro to detect if the
> current platform support the KVM_MEM_READONLY, thus fix this problem on
> all other platform which support KVM_MEM_READONLY.
> 
> Fixes: 5d74316466f4 ("KVM: selftests: Add a memory region subtest to validate invalid flags")
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> This patch is based on the latest kvm-next[1] branch.
> 
> [1] https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=next
> ---
>   tools/testing/selftests/kvm/set_memory_region_test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


