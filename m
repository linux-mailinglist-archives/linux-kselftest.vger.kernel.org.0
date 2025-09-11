Return-Path: <linux-kselftest+bounces-41213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424AB52C21
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838F5A04BA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D52E543E;
	Thu, 11 Sep 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBtR5k2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDE29E11C
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580378; cv=none; b=pfldut+OXBkObycxziFj0XI89GlHIhWilqHj2ZKABdqLs2ARlX5ufREztpv4IHYX2udnC7nghaiVJs8Byz7PPfqrPenxUE9fGn2jUt2S4izLa+irEThQlHzREPRVS6PQJzozwN/BnKqJnV6YpZKaeS8vPSYm4hip9UofJPjkjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580378; c=relaxed/simple;
	bh=K1OfSduqwQRBsTKKg1BvFgKfn1PGIxJFKzG2KTEy5K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JX6oT2oHY9CfDN6JouKK1ZNGFGS+JYKIPCKHNm6Fg7ydGc2ZjMBE3cAScL3gyO+/x9SxeOiL5VWxV9Zc37w6zvSN2XYpmr7BHfO71SOXgjLWVKq0xnkTstbJzflnKoygJAEA2pb2Ed7MvksGNtyB2UDRILlaPrIFAd0nSF+4RcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBtR5k2Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757580375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ssCjsQRosnIsyQi6TRiWy/gOOQy1TqZDzUkPJYAbPso=;
	b=WBtR5k2ZA6cY/L+yclCcM5OI7cnSoOqs9qifEqLQSuSjGWo8+Hn0PMKW2Lc/UpKs7kMBqm
	ClvIiXOKbz4yas8IF/ZWjR/YJFYtyD2qqliF+bqurgZb7j62ns+L4yoi8IkZPRyw9lK/Us
	wdjxU4DLKDIEbFhkJPCNlP5y1tKnz5I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-OIXeobiSMSKLGpo-eItc5Q-1; Thu, 11 Sep 2025 04:46:14 -0400
X-MC-Unique: OIXeobiSMSKLGpo-eItc5Q-1
X-Mimecast-MFC-AGG-ID: OIXeobiSMSKLGpo-eItc5Q_1757580373
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45e05ff0b36so956205e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 01:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580373; x=1758185173;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssCjsQRosnIsyQi6TRiWy/gOOQy1TqZDzUkPJYAbPso=;
        b=RMFITYpahNvtk0cTWo5MVj0GL/X7pwWdeZ0zpF0B7o/23YkZpgfs+RKKvrqgSSefLx
         U75JYrLn+T8ZKfu2LLFwqPTX21UgEFQc0rV3vqUQ5aQZuGnYafTSUrElExyqMc0JB0Wl
         DVgg76XY+MWqvmqsM9tX3mcvCIB4exCh+Oxwv/jElmBWiqAbamHHN45sAy0S+GbmJt/2
         bOJUaQl4jSxQhljxRZ769zHmALfXPT+gbh5V5FtKHhsssavdAJNR3gbbm/bsq6bNhfFa
         4KEeqQ5oktWfElpdsJZER4K/fGkUAYpr9Mh4THxBSxm2xDQOFl2+T+qPid7Ck3NEg/Fa
         n3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV42J26M6+1+10hUaKlMrrpA5hqs17m4TnM16RJx2sKooAcpJTNenX2WNwd6VERk42q2Q/bZ5PUNgRvTKuMcTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTje5/3eosG2TFfbf8opNeLzSteXvBazAhoPCdHBfD89ZnpR+
	F9PLRaVT45AXn1XDyS3QfyH0sooJ0gTZFnqGNvAXX0+2dmKJIXNjgaKJrwgS8mato/o4UfAhyWB
	3bWGxTcRg9bg3ZMXm95QLAQ3YeaXxpiIwtzGETrESzEFNTMICOK3gQouXgsIBM6Z6BSf6/Q==
X-Gm-Gg: ASbGncs1tPKvGBiOlHCc4nw/4Z1Ori+TxFI+Jv+n2z28sBRmJifD97wMasYeTZycdp8
	9+nGoq86tgEgJfLAHToLe5ST+yQ0yLiPAw5nG5ouH5/SqC1ld1yvfxXqa5arZDmhtib4wcFZcTx
	EjZELT2JQQsEc1BGOyAur819ej5kqrpbtV2N4A4tnMysWcqVAzIzV4HLcS3aud+7WcjB3wSLghi
	/dmH/AYFD0f4QDWPtrRgf5q9z2i3H6kKClEVSaU55B2nrbIpNGhJa1D3Oc2r6vK4K86Ji+vfoqM
	M7vJU9jyHSiezrnJEwcbWnDbV8YVv26952Aw2J/4xlg6n7Ez8lb2l2DElaNM9w/XJEZgR/GzNjL
	E3/ECTMlx+cc/WXu1PYq7UXxIdDzXvQbGcdIDIwPo61IDGew/HzdJ98tm6NDcLzYqskI=
X-Received: by 2002:a05:600c:46c8:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45dfd5c473bmr26816015e9.6.1757580373278;
        Thu, 11 Sep 2025 01:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEKWKwxqu2qOEyBEgAUAxpXzm9G4HcETc4FviAdPqhEnNC1NKGJCc3NQuXVk0LzZ/0UgZIzQ==
X-Received: by 2002:a05:600c:46c8:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45dfd5c473bmr26815495e9.6.1757580372845;
        Thu, 11 Sep 2025 01:46:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786ceasm1624111f8f.16.2025.09.11.01.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:46:12 -0700 (PDT)
Message-ID: <749511a8-7c57-4f97-9e49-8ebe8befe9aa@redhat.com>
Date: Thu, 11 Sep 2025 10:46:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB pages
 by default
To: Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org,
 corbet@lwn.net, linmiaohe@huawei.com, shuah@kernel.org, tony.luck@intel.com
Cc: Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz,
 jane.chu@oracle.com, jiaqiyan@google.com, joel.granados@kernel.org,
 laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, mclapinski@google.com,
 mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de,
 rafael.j.wysocki@intel.com, rppt@kernel.org, russ.anderson@hpe.com,
 shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <aMGkAI3zKlVsO0S2@hpe.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMGkAI3zKlVsO0S2@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 18:15, Kyle Meyer wrote:
> Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
> Since HugeTLB pages are preallocated, reducing the available HugeTLB
> page pool can cause allocation failures.
> 
> /proc/sys/vm/enable_soft_offline provides a sysctl interface to
> disable/enable soft offline:
> 
> 0 - Soft offline is disabled.
> 1 - Soft offline is enabled.
> 
> The current sysctl interface does not distinguish between HugeTLB pages
> and other page types.
> 
> Disable soft offline for HugeTLB pages by default (1) and extend the
> sysctl interface to preserve existing behavior (2):
> 
> 0 - Soft offline is disabled.
> 1 - Soft offline is enabled (excluding HugeTLB pages).
> 2 - Soft offline is enabled (including HugeTLB pages).
> 
> Update documentation for the sysctl interface, reference the sysctl
> interface in the sysfs ABI documentation, and update HugeTLB soft
> offline selftests.

I'm sure you spotted that the documentation for 
"/sys/devices/system/memory/soft_offline_pag" resides under "testing".

If your read about MADV_SOFT_OFFLINE in the man page it clearly says:

"This feature is intended for testing of memory error-handling code; it 
is available  only if the kernel was configured with CONFIG_MEMORY_FAILURE."

So I'm sorry to say: I miss why we should add all this complexity to 
make a feature used for testing soft-offlining work differently for 
hugetlb folios -- with a testing interface.

-- 
Cheers

David / dhildenb


