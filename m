Return-Path: <linux-kselftest+bounces-7223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E829898E38
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 20:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E74D1C20EA5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA513173C;
	Thu,  4 Apr 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMzGjhIb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FA12D201
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256385; cv=none; b=pJZnREBzlPUaVJB4R6ZsdagkLQRHpqWxVZeFxaNr4ugVlG6I+g5x+dy+wdTLN/9Q5ra1eyWllfkeB0MmEpv570oL7Yc6U9ysS5Vqzocg0axAFLfhd7edYqL1hXwyS8Wya5t+Prg9SqaFfAKTOtVkm1YKGfCLVjyZylbFGLlhOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256385; c=relaxed/simple;
	bh=9juXWwgZPF88eFgPjM9DmD/zCAiyVz5xr459LXtFJpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xs5gdiNtqp5o1eJLNbvE4fBHDxVWDC4/E+t8YzPLQSRmTMUJl3jJbi3/1Gnxxss9PmrAkl2w8Iut7QEyZM9QIhZ/c1qRRsRxKEL1lGPTpcWC1yMQnmfKzP5UoR6RPguJ3fd2BU8kyfpV/n0ULYn6bjhe74OcrZZPlZDM2Mbju0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMzGjhIb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712256382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0AOlev0rhdBhXYrOzdipWHKiceO/AO7mgrDVbM4w7yo=;
	b=dMzGjhIbbUmqWzNQTb7N16TcBO8YQkxwJUOd9q/5FlBaCpxu6GRGP9/vsKPPVLomu/WzKN
	DfHMcg1kIQCZLC08sNEgaCFydeYURcuIvt8GUCoXth/SLoPhjgY9TpauMW6GzfN574na6/
	6kdJ5Cv9IAKCEq1zCHYo5N1ujThQCoI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Tj03xQ6oPqS-Dr8hSJSa6Q-1; Thu, 04 Apr 2024 14:46:20 -0400
X-MC-Unique: Tj03xQ6oPqS-Dr8hSJSa6Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c6bb1f21so495437f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 11:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256379; x=1712861179;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0AOlev0rhdBhXYrOzdipWHKiceO/AO7mgrDVbM4w7yo=;
        b=B8Domz+wxTAWdeVhqZcVovRAFaTxaPCDEpsFWzM5+wr5S4T95ginw3Qib3r5uii/A5
         SaQq4KnKY7aJq43pj4n882zW62X5yYpyQQKnOWCy9UEx2Ahj62XECd5ceWfrNpSBmyUr
         igerqLHnILL2LCBYqj3JDVg0dsulf9HT2jqfTMKHcVLfIT3FE4HsRBXTfZWa2nqTwNW0
         NN7w2931W6JKAP7pLjMbb/93UP2MZM4JIM6C7c4saAsB6LtdMUotV4K79sEbwjdNYcNC
         ClI6RvdD4+CEmZf349eQZHmhSTIC1CIaWTKLdQjt2j8J8uChh2sVcATfWrEcIxDotBQR
         3O8g==
X-Forwarded-Encrypted: i=1; AJvYcCVT74WCc/63yhepnhFnr/oNcZAVQMg5os1GmSigNmB/n5ycBz/dcddwyY2H/65bQODN/5vjRFhp8ENphmEVwj/fqmjGZ7Xyc9SAX1N08ikq
X-Gm-Message-State: AOJu0YyrZ1VIcVYbl8kTi0bXAVwxRfCzxr0YvZvrrrrfi7GOvjqkU6/a
	RoXRgRKZHGDiEvYuiUZiWf5bWEIocSp600G1F4+vvISphsICZq+PLTT1qhu2jUWmvrueSWusQrU
	9+IvR+HshHBsB69LuL54QE8IRoUFmzUCv86Au9ykbI6d/fnLVj84AMX/LllxTIPudlA==
X-Received: by 2002:adf:e845:0:b0:33e:363b:a7dd with SMTP id d5-20020adfe845000000b0033e363ba7ddmr2730283wrn.20.1712256378911;
        Thu, 04 Apr 2024 11:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGvr9qkZUMbzisaz2zVsEMYJ2EQHjo/AAPd5Mf9RdtKX5SLgDn9m3+bMlybOtjfDyVDWQZhw==
X-Received: by 2002:adf:e845:0:b0:33e:363b:a7dd with SMTP id d5-20020adfe845000000b0033e363ba7ddmr2730266wrn.20.1712256378489;
        Thu, 04 Apr 2024 11:46:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id di3-20020a0560000ac300b00341c7129e28sm40761wrb.91.2024.04.04.11.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:46:18 -0700 (PDT)
Message-ID: <394a3c47-b25d-422b-b9bf-d043501739a5@redhat.com>
Date: Thu, 4 Apr 2024 20:46:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: fix additional build errors for
 selftests
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>
References: <20240328033418.203790-1-jhubbard@nvidia.com>
 <20240328033418.203790-3-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240328033418.203790-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.03.24 04:34, John Hubbard wrote:
> These build errors only occur if one fails to first run "make headers".
> However, that is a non-obvious and instrusive requirement, and so there
> was a discussion on how to get rid of it [1]. This uses that solution.
> 
> These two files were created by taking a snapshot of the generated
> header files that are created via "make headers". These two files were
> copied from ./usr/include/linux/ to ./tools/include/uapi/linux/ .
> 
> That fixes the selftests/mm build on today's Arch Linux (which required
> the userfaultfd.h) and Ubuntu 23.04 (which additionally required
> memfd.h).
> 
> [1] https://lore.kernel.org/all/783a4178-1dec-4e30-989a-5174b8176b09@redhat.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


