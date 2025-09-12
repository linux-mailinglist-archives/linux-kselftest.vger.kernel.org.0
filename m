Return-Path: <linux-kselftest+bounces-41327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A103FB54B13
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA10487AAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FF301013;
	Fri, 12 Sep 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkQmSVTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB393009D6
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676973; cv=none; b=poTC0NBKPKcJlSKmulMAB4FuK1eyzuKFAChdjT8DhvgCWsmMbU+ked7mwNoIDNORGaoPbZJ48vpGA6aNitPTDS9ag+XB5IZ+89zCuTq4i0/U9sJrqeRB/OZttPjjklHHzbqZW337JHJJYC/AIcCeDtb2PK6uxR8krb9wAsMnees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676973; c=relaxed/simple;
	bh=6HhHl5Q9HyjWqX7Y9YXL8kJIJbLXHU49bGi4e4jAGxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJBiQGMYCCwf5jdPuaRuJRSeIkiQia7l5RE2UJ8OprtlRzvpN26x7TJvfIRxMdAwHJJ2i2F19UFWKhY3JX1/WxEynXKptbNGszr+s2RxfcF9HJmiOBieCC6bh0cAZ3Y1f2j17rRmOaBXhE4kUkcltHJlwyZod3VJQSBytlbju9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkQmSVTi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757676969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L4WTNdMCGh54uRDM/L4Uxaq4pm+e6gS6JQHYqsqi25s=;
	b=LkQmSVTi3w7CnHye2EjhRoGSBA6NribyJn6XBb04vhLAuyd3L/JSPCc5g0PCOB1IxVRLxH
	8cgQR6ObBes10ddyyg0U9ckXs0MYWVz2U2ppxxCZ3GSyfA+vlSTgKtr3lCP1vQaulkFWl1
	rD0H1qpcaPAdFjfs0qdLbdQQWvyZhII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-EBG_imfINVSMreeZdnS4YA-1; Fri, 12 Sep 2025 07:36:06 -0400
X-MC-Unique: EBG_imfINVSMreeZdnS4YA-1
X-Mimecast-MFC-AGG-ID: EBG_imfINVSMreeZdnS4YA_1757676965
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd9a66c3fso6481045e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 04:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676965; x=1758281765;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4WTNdMCGh54uRDM/L4Uxaq4pm+e6gS6JQHYqsqi25s=;
        b=Opsxe+A81sd22Fyg8SySSX9eWpeo0t7WHFPF8KU1JzUZ9RTEdMtMtQqFIJtltMbFSH
         SHLlUTK6tToSLy0IbZGVMvoZxy5RuqOaFcZUrWCfFFLUE21O3WGSoTqVHj4pzAL8/ed1
         oKeqWlX40SCM7kuqJLrjgoHx/lk9NycC8Jc22nrSE6PQufnGK35KIwdpM8W90s1/Okq5
         DHHlPBmPwnzW1X3eXlHtlnHhPc7W3MeiB9emVvFmm+wZPLzplbqPg1smhb0HgqCdADzH
         nrREvjazEWljLZbcTE4/7UT0HKfBiUCRmuzkGdGo2I6tdvobVIeEPMErzL+gM2zXXeTN
         pikg==
X-Forwarded-Encrypted: i=1; AJvYcCWX9LaMhixxfHfpolPGOpGZQlXzUtytvii+JzSippF4dMaGukSp78olsLeVe63BvvZBQlTAAbN5A2V/54LS9og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0J9sE3sp6ipyp4T5JQ+jq+l7bOCiI5OnkyKsl1FXKINVsvmN
	8gSuQsLLvS5hoBNWUOmhfqzQUKgsELbjYY2kceo0mWtU9gjOVkgTwb9Yvh8qLcO2eE9S5GV/W7L
	XhY1AbzGinERo+XsVffdU5xA5Su16QJgfO1EUERddi7Tpod5lFok0mlpyBtKoYA11wSd7hQ==
X-Gm-Gg: ASbGncvYPBBDczAYz4sob6MekITJJxvx/jAvSXyyuvVJ1gIWsISZz58Ms1P7OjsPYQ0
	X8SwEpkYDtnWYzY8Qs4lBE+R8GjNVZZKOyTZn5ue5Y7d4LTPlA4NQZfNFwdOybOVoMyvVsI1/yj
	jrDHVSpU+9eDmb2TAqf3iYHKcFGVJKlSlIjOXI3RS3zposHz41CG+EJ3wje1htYtIQu3goPOMLV
	4SbkHdmo32olorbZoAHMxOLfrMBVVdILxALyZkcDRDmmlqJx7/0saNZxyo5549VIs8iGvMl5ka5
	NY5XM6+9pEbI8B/o5nJqC/P8EAV7BfH9o27ggpQlMC0SjNTnOvuseimK1eXnMaq7NqrgJECEk0p
	0Wew/xituOSsAvz1UW+TIRFF7lOxiU9FqVHeYywNsLK2iBvL6579vWrg0cSXxOZ/ujN8=
X-Received: by 2002:a05:600c:4e4b:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-45f211d517emr27953545e9.11.1757676965163;
        Fri, 12 Sep 2025 04:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEApCot1i+5m775BUiDD6WRxTCaO0+qykFG5pVRf5Sw41hSYWcT5lrn+50Nw2D8nJepyAo5JA==
X-Received: by 2002:a05:600c:4e4b:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-45f211d517emr27953335e9.11.1757676964784;
        Fri, 12 Sep 2025 04:36:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775842sm6503959f8f.7.2025.09.12.04.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:36:04 -0700 (PDT)
Message-ID: <3f739d3e-f6fc-4a3f-9bbb-151a6dc6c083@redhat.com>
Date: Fri, 12 Sep 2025 13:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: transhuge-stress: fix potential memory leak on
 realloc failure
To: Haofeng Li <920484857@qq.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: 13266079573@163.com, lihaofeng@kylinos.cn, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com
References: <b6f38984-5f89-4a9d-a905-ddcdbd7510a3@redhat.com>
 <tencent_43768D3DB24034B62C249781C1DE7359C807@qq.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <tencent_43768D3DB24034B62C249781C1DE7359C807@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 12:10, Haofeng Li wrote:
> From: David Hildenbrand <david@redhat.com>
>> What do you think happens when a process exits? :)
> 
>> Correct! All memory ever allocated to that process gets freed, avoiding
>> any memory leaks.
> 
> Thanks for pointing this out. You are absolutely correct that the operating system will reclaim all allocated memory when a process exits, so there is no persistent memory leak in this specific scenario.
> 
> I opted to add explicit memory freeing in the error path primarily as a practice for better long-term maintainability:
> 
> It ensures correctness if the code structure changes in the future (e.g., becomes part of a longer-running routine).
> 
> It maintains consistency with other error paths in the codebase.
> 
> It prevents false positives from static analysis tools (like valgrind).
> 
> I'm happy to adjust it if you still think it's preferable to remove the free() in this context.

No code changes are required. This patch adds more complexity without 
any benefit.

-- 
Cheers

David / dhildenb


