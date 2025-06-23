Return-Path: <linux-kselftest+bounces-35621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D31AE4564
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFCF188D2DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0680250C06;
	Mon, 23 Jun 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EG7BSpSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDA248F4A
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686553; cv=none; b=nLyVsyoF6tBjAPSKRvxJ8Anw4hJqpjQTsTAuh5YwXkQUvf+lahUo3JhxEmWOeErlRrkRap6AZpqjlONqjo/WTTFhyytp9HUmMThbdt63WhZoro6yB+NYzit5PWFypmQE2vpvJ3+qQpAMUFSF5cBrkm0+RfSR2gU0PhmPrKXMEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686553; c=relaxed/simple;
	bh=f7aOklejQbZ7G0VrNNG8wxBtdwtA0mLdvOXgTTgiXNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjPjlgCpnAu++iKdG7x2pBjWy1kLFOew6n4oc6ragiCpEZTY8Ts4mhNmwNe2Hdw/S/zyORNHjG76g4WxN8IN4BRdYeSt3vfaDKBVtoxEXL6VIF8NLEhFeVNS+t7AA1rdozJ7NrDDUrniTKumZkQEmSP6oHgKCasaZYUje9EaLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EG7BSpSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750686551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jsKHRipSf0W3kGdVFY9Q0sc/VyJxrNO7AzDAt8FfuEs=;
	b=EG7BSpSqO3s5d+HFctyBY+zyKQEBmOA+DYeUazRWKc4XoWAPZKeoG/OHnd+weuvcbh2xOJ
	2iGwj8ljHOo3OfKjwWsNOO6EL7zxaKur1a8I3g9ElZKQqnd+J2kv95ig6kCQYYsfgdsil/
	YujVhBv55IxUIA+KoZ8GDSwqDV9dIj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-CT-7udD_N8W9yIKm1tHIJg-1; Mon, 23 Jun 2025 09:49:08 -0400
X-MC-Unique: CT-7udD_N8W9yIKm1tHIJg-1
X-Mimecast-MFC-AGG-ID: CT-7udD_N8W9yIKm1tHIJg_1750686547
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso18871575e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 06:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686547; x=1751291347;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jsKHRipSf0W3kGdVFY9Q0sc/VyJxrNO7AzDAt8FfuEs=;
        b=VDSbWoCK9VZMC+JIhytAko1jZdX+WmXGQTC76zkvH861Bb0O9XHh7BUz9vNUHrzGis
         4j2Dfj4jPtomQ/UxoBq8v2V/wJQooemh2rrcbWyokeuv8XElQrNNQwhbJBxOHbbJK00O
         qN6POrJef/HqYk8hJBu9SDz9gG7QalKh+ZafviGfkykN19ydJMBqa2Pj3ern5iA9+ImR
         EaXBV+JMvYdQDdWPbwSycf0LOO9SjbwIOsD2Z1nngh8X9bfYvVxochRPpnOb7oCyvD4C
         4TRXl47xvsSXuJe0rlbC/FSY57m4GdOIsauyDiXfSmwVBDsgv2K+TW1/YQMjaNul0Z7y
         +XSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU97Fwim6WPa1+83jgzHn3zfo9ajLStmVWctLo+Q6VonXXNcLJeRfkMUBw5uvD0pWvuJm3HcirV02UXH2A9Vck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV1S3V2Q/FGtPlS0s/ip0JWag4W25czrmTIbGXd/xp1LF6wFc6
	zJG62dyKpq3amCFW/wG1vJQhGIm5v4UdUC/d5RaZAKjzz4vfcCPJnxBIPe74tge7J6vhiyWc6Ag
	/dZKf199PIyh84fcU+xe2riPUtzXKxxmlSa8qAyCOYuxYxtUZQ6Z4oYzztXWBDBCN6GAPWA==
X-Gm-Gg: ASbGnctYdqVmP94Q+2Xi7DZf+ILMVRe4PpNUbPMEz9hCiZrOztveZjhsCXYKQtyYcHF
	jVNlaFliTDxhx/jwjRfIX2B5oB5lH6vzM0DvVzlyn+luRAfvWfgHEO4SnsreDbPIjCs8RXihwkR
	KX9bfWZWU+2E9u2n2ZGbx0sFfaJeolksoCTaVIytXd8TIvYod/r93/9aI0O8U4ZMiigiiib/kCX
	rBGFiirtH1p5knVeNtaEt9nTQtiS65vGfbzn2YRnrqvZ9KgwFYLWAQ1Op08crR4vLMa1Q6ovYvV
	3BCIeEhf0LVin+rJNOG9ptdNpxCH6a5MjGQJASr0B8hpRKtfThokPNqnMa9Znt20oc9Tll3w9/r
	BZkg7j8UxUUFzl+KxnSjVfEsIT0zgtzwI8QbDhWC7tLnGzSsEWw==
X-Received: by 2002:a05:600c:1910:b0:442:f482:c432 with SMTP id 5b1f17b1804b1-453654c931amr124139715e9.18.1750686547523;
        Mon, 23 Jun 2025 06:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG03KKPfAZFSoUe/FDMvp2k1XbIBgN8Sc2WFAhxNfiQpaPmKu3c2IwVA1FchvOgoQIZkih1FA==
X-Received: by 2002:a05:600c:1910:b0:442:f482:c432 with SMTP id 5b1f17b1804b1-453654c931amr124139425e9.18.1750686547124;
        Mon, 23 Jun 2025 06:49:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1189977sm9378431f8f.82.2025.06.23.06.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 06:49:06 -0700 (PDT)
Message-ID: <e80fa23e-f659-4eef-89ba-8c9f5578b78e@redhat.com>
Date: Mon, 23 Jun 2025 15:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: add test for (BATCH_PROCESS)MADV_DONTNEED
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 SeongJae Park <sj@kernel.org>, zijing.zhang@proton.me, ryncsn@gmail.com,
 p1ucky0923@gmail.com, gkwang@linx-info.com,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250621133003.4733-1-lianux.mm@gmail.com>
 <8fb737cc-ba83-4949-b4fb-2a2e1af0967a@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8fb737cc-ba83-4949-b4fb-2a2e1af0967a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.06.25 14:35, Lorenzo Stoakes wrote:
> +cc Liam, David, Vlastimil, Jann
> 
> (it might not be obvious from get_maintainers.pl but please cc
> maintainers/reviewers of the thing you are adding a test for, thanks!)
> 
> Overall I'm not in favour of us taking this patch.
> 
> There are a number of issues with it (explained inline below), but those aside,
> it seems to be:
> 
> - Checking whether a simple anon buffer of arbitrary size is zapped by
>    MADV_DONTNEED.
> 
> - Printing out a dubious microbenchmark that seems to be mostly asserting that
>    fewer sycalls are faster when using process_madvise() locally.
> 
> And I'm struggling to see the value of that.

We have other tests that should already severely break if MADV_DONTNEED 
doesn't work ... but sure, we could think about more elaborate 
functional tests when they provide a clear benefit. (zapping all kinds 
of memory types, anon/ksm/huge zeropage/pagecache/hugetlb/ ... and using 
/proc/self/pagemap to see if the page table mappings are already gone)

I don't think we have a lot of process_madvise selftests, right?

hugtlb handling that was added recently is already tested to some degree 
in hugetlb-madvise.c.

In general, I'm not a fan of selftests that measure syscall performance ...


-- 
Cheers,

David / dhildenb


