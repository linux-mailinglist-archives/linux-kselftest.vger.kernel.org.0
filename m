Return-Path: <linux-kselftest+bounces-32733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C4AB0BCE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 09:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D74E62F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF5B26FD8B;
	Fri,  9 May 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqMo78rL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF123D2AF
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776026; cv=none; b=tvQgTiDYc6NDD6RUKB2vp6Up6rUMhBAz0HyURRYpTOdFb35Dn6GdvSsmKXDWKWnDVoVfcQLYoqJL+r8isCCNyI4+ubum7MjhURYaN9Wq1iYU589eQAvp/vhBqB8qIhN1SWhvS8n13dbQLXLkanJIxOWn+xUwQRwPjRZhWHd7en0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776026; c=relaxed/simple;
	bh=FWyuxhoonZwohLikNd7BSVrApuwXrx4iVj+WWJE6P+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLmZA2jeDBc+ecSeuK8z+HTzS184JMh34l5zDVwfCxW2D8nz9s6JtfIcL0YPFwinHxD9s61wQx2PETudXan4iCL1ywBAklv/4DPftWoFZy3hRr7g2dQGXv3tPbUIjRV0LVoSXUr2oYNEzfPcMUh37gHuOzjaCy54S+LaoD6VnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqMo78rL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746776024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VpG7PvH0UplrJjw105ZtScpJjsINX/Nh8S8T5pYtBeg=;
	b=NqMo78rLEop9adMqbY1hkrc5avVgSNUkKvVLpEJO6C8HANhn16uORfmy6TbKeQETU6xMw6
	Bw/uZXE3PvDiNalqeSmU8e9RB/AOjrqBJtc1e6j81lHOmgK1WQwyhHyPnCahe9fSS+8XkT
	Mu6N3NUVb6hNQIquUmg9JC4zt3uLn+4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Sp94Y0e4P0mRnE-pNgc2Xw-1; Fri, 09 May 2025 03:33:42 -0400
X-MC-Unique: Sp94Y0e4P0mRnE-pNgc2Xw-1
X-Mimecast-MFC-AGG-ID: Sp94Y0e4P0mRnE-pNgc2Xw_1746776022
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so8858285e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 00:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776021; x=1747380821;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VpG7PvH0UplrJjw105ZtScpJjsINX/Nh8S8T5pYtBeg=;
        b=JzU4Up5jF/r4odR8B+qUaz/3Al+JvfwiWqFWT8SE7NnAa5FbRnvHDSoxFlyeS9zNM0
         fEfa2vzrjkyYVXn/hqOeh+rnnMlKyBv1h6UNkYuZ4/p6mtouseoOaTJN0PyGpoUlpzxt
         ZycHPxauMZhsc1kzaSUEgcjEpIygVxRMBEURieYqS/spciYiBP7sEcithXrkWhQdtlSL
         avFalMm/9bIXuf8wk6kO9lyQk5++7vylRWLD005wcoPQZaJdPZrHbFnAywC4lVOurUrG
         hJIKTylUkEIw/OB7/FWd70v8nRGpNvRIOtP3/vXAm/K1yk8PNcjgUCgxyT6dIXe+ocAJ
         G6kA==
X-Forwarded-Encrypted: i=1; AJvYcCUWpPbL+mHRqDh5iQs0NPsSGe5E4lJRr+L6DhvjPKUXYO8u7mP1Dkh1lKdOqpf0q81l/FCS3thgxG3gUN7PSs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3E7RwVFvR8i3zUkCWheStvn7+oIDK9sHIyw7DynX6Cf51LYy
	QHJ9hSbKkR42n5aX53uhJNhIk8+WeinFQAv654kIv42U2m2t9D9XDURBPM2Uo71mPiUF454cTmx
	gg4GtS87zCdtEJxHgBFlof31dep2wDUAf8ohbWW2jPDO0QP/sEjALGkbKIF73JQE7Ng==
X-Gm-Gg: ASbGnct+9cEUTFQFCdGQr5uLDPdsEUq08FVvo4w5uSV/M0grA0ifD/9SLS7DPkhezd1
	3NcKTEaiwChjQi8AZBmv85btXvIU0elhHoo3V7YHPy+iLdXTUhz9xuCzj0V+c+nC2adK9LHWDyv
	hwm42BJ5WIvKYws7JzT+815h6gFZw57/SyO4ZsuRKwu1GYmjHghdxD8+vcOflcYvM6oOju/HnOQ
	RZ+WgS8+l/F3rfZfwgeax87gRus5WHqxQ4RMHi3MsM+0Fg45F1pFPXHKT0WjyM7RfPPt4Fqd5SM
	Zatr7BTy5Y5ppVGAX5P/fQ8qUc/oqG7aZIPbH3XdNHqMe4B2c00c8LN6aYxF5UcusPFI4s6fevT
	AvoQUlSFCXIezqtva5vNvF9J/4zacbiKZB6M9gbo=
X-Received: by 2002:a05:6000:2ce:b0:3a0:b7e7:1076 with SMTP id ffacd0b85a97d-3a1f646d9ecmr1609196f8f.11.1746776021675;
        Fri, 09 May 2025 00:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLJJiTiA7hsFL7Ee2bBJr6joX3bZAuOsH7kejhhjJDWeCmlPlWcMLLBoFlmQYM8P+6GnsmoQ==
X-Received: by 2002:a05:6000:2ce:b0:3a0:b7e7:1076 with SMTP id ffacd0b85a97d-3a1f646d9ecmr1609184f8f.11.1746776021306;
        Fri, 09 May 2025 00:33:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd? (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de. [2003:d8:2f45:5500:8267:647f:4209:dedd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32835dsm62966135e9.6.2025.05.09.00.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:33:40 -0700 (PDT)
Message-ID: <d91f6f10-a17e-4bbc-94a1-41b43b41c1ec@redhat.com>
Date: Fri, 9 May 2025 09:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
To: Dev Jain <dev.jain@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250508222041.1647645-1-david@redhat.com>
 <ecd0bc7e-8af5-40d6-b118-1604d2851f6b@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ecd0bc7e-8af5-40d6-b118-1604d2851f6b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.05.25 07:35, Dev Jain wrote:
> 
> 
> On 09/05/25 3:50 am, David Hildenbrand wrote:
>> Let's test some basic functionality using /dev/mem. These tests will
>> implicitly cover some PAT (Page Attribute Handling) handling on x86.
>>
>> These tests will only run when /dev/mem access to the first two pages
>> in physical address space is possible and allowed; otherwise, the tests
>> are skipped.
> 

Hi Dev,

> Some generic comments:
> 1. I think you should also update .gitignore?

I wonder if we could add a checkpatch warning for that, it keeps on 
happening :)

> 2. You can use ksft_exit_fail_perror() for wherever you want to print
> strerror(errno).


Makes sense, thanks!


-- 
Cheers,

David / dhildenb


