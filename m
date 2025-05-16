Return-Path: <linux-kselftest+bounces-33167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D0AB9711
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 10:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67103A0328A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 08:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4193822CBC1;
	Fri, 16 May 2025 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hjos+Hzm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B994225A36
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382544; cv=none; b=GqdAqRnIpvQC+xJ5MweJtK+E32C8wZ9IrMOJMJ+FuD6KA1JF0hIqKYBSEBJSifeZA0HNoqOvVQiqEAfZlOrpoF5j8HKso5n2oAcEio0tRohGJhTKKFgb0Ochqeev6LlUzUx6VQ5MaypP++XV6nk5dUCh2xU6o5U6ZPdhefDN8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382544; c=relaxed/simple;
	bh=H3gGoNY17k//3FrPE7INqoVxNAhhPQXH8fJGugRmmyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6QE/S0ju2L1ewF+sM/5il/ABANxFNPGa0DxHsRRyyPOTzTRQa4XSNqNh5tgkmmtDmH5yZdSjB6eXDa1la32Ab6Jm+7QL9MROupzYtsXh6Kh38uYV9p9VlGGKuN5QnREvgE5YjEPZ8jq3KWw4a0UnWLBSKl40dzqpT8K64VrmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hjos+Hzm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747382541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZlDySxqINDrxm4UjNN3OmOU4dY+W91mBT9wkqzNyPtk=;
	b=Hjos+HzmjYeNhlpLBCspvTTxdHT5IQK/QQgYX8pnp4pVUsi1DAPEgbRouMN25Ik8FHHX2r
	w3NBpchuH0eoGYfC9/8SsGkIbJNjSTUVbkpyWhC0DGOO6LSdxhLHJ0s+Fd/ji6T68bZQmf
	PcjLWVCO1O7OqaGMMdhF3+4voF2+5CI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-jNSmngjxNOmQiWor7CHORw-1; Fri, 16 May 2025 04:02:19 -0400
X-MC-Unique: jNSmngjxNOmQiWor7CHORw-1
X-Mimecast-MFC-AGG-ID: jNSmngjxNOmQiWor7CHORw_1747382538
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-441d438a9b7so13586225e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747382538; x=1747987338;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZlDySxqINDrxm4UjNN3OmOU4dY+W91mBT9wkqzNyPtk=;
        b=H++ufimqchbPFdFxJIjIxtTbpibHo863EXDVC8uRaSISL5z/2M65WlNfT3AZkewh+g
         kMSbyV9gsW0KuLGgzXaI5t14jNRWyuzIYjfLlx8XM/2IDBVjMqyLmMz1jLEADFX4SL8o
         3P2AOeq73jyQ7+gIBZgO0QqC4si5alI5PHMDvgtf1GJOIpkB4yJhRn+jPW1tM92ZFGdb
         +/XwXVuSrltjyKZ+NmovvIhZ3+YsFmEb8PrGSMkZiQI2uHNsUtrLO3uo6OH29ws/nQt7
         Olqlxo3KQKSdraqxBdFtYeO/iOJtONcuxymxk0vsRyE989Rg7v4+dTkVHxgozBBr0SwE
         bHow==
X-Forwarded-Encrypted: i=1; AJvYcCVtrSFXPCSUnqLuAYe48RDkQQmdexTmgQqtGUNzJpTvx1J4hzZweVRwkO4A8UAkQKKWiFc+3RuqYKpW+JTV7Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/jgqsB2jCPsUSclH6PtEjYK1PUj1GOXoJ5IU3C9tNxTbIbhO
	ltxiOJlKDMTxSxYx+6Y6D0HTKbyVaAZTQeX49yY9ZzZRSqbx2sZLWb4D7VaVjrtb1tUerhbgGCi
	1Jv74sQ/ndmon9IPXipzXXpoUcraBGXMlthZDPr1oiGx86gtlyXH/mABuj9xXeCh7hNxEwQ==
X-Gm-Gg: ASbGnctcpfYjmt1tdB8uzVs4m3vviWzRM+NENtXCe9zV2l3ZYuGt48rTVN7ox/azP98
	qk8BXhWuA83sDtwsGUUJ+ajyZ5/3FMibFM8TXhIfAIABznsh/ibbLzvAk7R+NSMzFpOepdZ71dY
	RWfXjbJSA7jYR1RmKLVbcfamrY55ftWad9KsPH492UmtO+Xi7ZvPKxE/YfcyDHuPuN7wU53NiLf
	v/Ryt/AoGZOFWP0vXZuqi8lvBS/6k2Rm7CeYO4+clG+R7SEPi/AzCyPtNOMIn+kmfpT4iSXdZo1
	2qLfH+bfnqDuC8XmJTWBOvnWrjbqTJ2PyVPD04lN6aqC5QxTk8osKQpSoHDJAqvqSC3hR0Cd4EN
	4ici4orzTZXV51kdaMeHZsG7J6pQxse8Fg5ErZ0I=
X-Received: by 2002:a05:600c:a08c:b0:442:f861:3536 with SMTP id 5b1f17b1804b1-442fd94e353mr20683965e9.7.1747382538218;
        Fri, 16 May 2025 01:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGelgfYf1CtFX2ouWOGPMb4VwIumpsnFvLJhBDDEnBHD32A6BcPQixmIbH4BEGdqHTdU69TsQ==
X-Received: by 2002:a05:600c:a08c:b0:442:f861:3536 with SMTP id 5b1f17b1804b1-442fd94e353mr20683725e9.7.1747382537878;
        Fri, 16 May 2025 01:02:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602? (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583f71sm23537405e9.27.2025.05.16.01.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 01:02:17 -0700 (PDT)
Message-ID: <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
Date: Fri, 16 May 2025 10:02:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.05.25 10:57, Mark Brown wrote:
> The kselftest framework uses the string logged when a test result is
> reported as the unique identifier for a test, using it to track test
> results between runs. The gup_longterm test completely fails to follow
> this pattern, it runs a single test function repeatedly with various
> parameters but each result report is a string logging an error message
> which is fixed between runs.


As the person who wrote that test (that you apparently didn't CC for 
some reason), what exactly is the problem with that?

We run tests. If all pass, we're happy, if one fails, we investigate.

-- 
Cheers,

David / dhildenb


