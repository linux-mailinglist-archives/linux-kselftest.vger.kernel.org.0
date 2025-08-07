Return-Path: <linux-kselftest+bounces-38455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7782B1D5C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F3656474D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F06724DD1F;
	Thu,  7 Aug 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYnrNXYQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC723D281
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562394; cv=none; b=Ob/CRkvvtOCL/gfkSP6VLu86rp5ETuDun2aCYM+CzdQyxUeiZZsxECmkUdVlRdUP6WocBwKY3/ThSZoyjAOW//Uty5HC/tWD+kwNiVhaXDp8vG37jUsvYaGrKlrQDSxonoEnZ8ea8l6pzuieRK90PP6KEfAgzoOg//pfVudmyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562394; c=relaxed/simple;
	bh=gry762pvhv1zYegs31/61w+aGvkNZqHLYFRec9I+I0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1zKjYh23yATPow4qGLl6n7H4OflpWtrE9OTfXHdbNALyph59UA5BzfRxv9kYGhPTZzIcEj7Ez0opXCtTWRE9dHRgBKhA4D1KVedoA0/PNbD6PStyWYYrisLI6wF3/fLFCEQ9ZSDFhdBzlf4jvgEW4RYK/v+DCprAl2ia1tWy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYnrNXYQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754562391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZVGQibavMITRGZMUXMYks2pQwACDsPgQ1+QijdprboE=;
	b=dYnrNXYQlvF/9tBskmcUPSqIr0JlS2HDxlIX7aXMJ+6QJ1pCmVstT9oizzTeF2fzTI+xFb
	NY5cUljomuEAarr/zybObGWC+tiRwRGWKVBV90w0CGS9WexrIN34f/j4xmUCIm5Zco1BkL
	4hDCXAWQXCNVkjhDtBbTYBWLB8oEDww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-xydlSbAFMQaSjNjFgZBrgg-1; Thu, 07 Aug 2025 06:26:30 -0400
X-MC-Unique: xydlSbAFMQaSjNjFgZBrgg-1
X-Mimecast-MFC-AGG-ID: xydlSbAFMQaSjNjFgZBrgg_1754562389
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7892c42b7so509444f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 03:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754562389; x=1755167189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZVGQibavMITRGZMUXMYks2pQwACDsPgQ1+QijdprboE=;
        b=mFBH2jW8KT82kvc6542jMhRxtHS0o63MwT5B5cWg6XIfLoEbsMD/5BawEEaGRsskDo
         UcSnHP886N5qls17SSsRzi42+u/79ZK7DR7ALhHAYXsMctdJPRCiIXBuU+RSB5IRswNf
         towJ600uZuW8gsTcHfnvmw2Jg/Ft5553V+zLQ3rkLLGZfdCzfIZ0/aXrbajuo9ONqldn
         fmw6lUJWvMAuSQ5rZ1u41i7OSWgKrw4VtBTG6aftfluRYh95xjDHhXYRkd08T5gQasKb
         mPd4QpZMOk+4FT0Q1aw7kYxR671a9wv5Cm+HfcW0UdgI68tx0qGyFqHyzg+sHzhxHool
         J3lA==
X-Forwarded-Encrypted: i=1; AJvYcCW6A5y0OZPv6VN7C0FVfCt4ZjVs1e69Fb/ai6DrrOOFrEV6RtmDI8SRZ4GpNiJ5lJ3gTuBF7xqPumesGuGmLMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9CZcIraFMPDzxgCbRX42sjGizIhDatWRweaXRQm8zpteyOxII
	IvsINSdV3uVaJJMKPT1OZYJ5De4eYS6Q4di/MCIhh7hcay5RCymrsLd1YmMCAFa4jXN3rqnrCen
	HpjigI9RKKmw2B4R9yhBbTDz1EFY2ql/ltqOpFr29JXpNB65uMnDNxBHFYwZ6DTXCkyXk5g==
X-Gm-Gg: ASbGnctGyzASpoeLDI7b3s/TnYPOLemxMP7BMo29E4zqbix/xKGm0WItKC2hDvZraUs
	45kbgOA72b/wU2YcG/OXx2dLyNb3HnObuOIdzUGo7CHuZ1D+xb3LSgEWikWsY8YmPQG1RtUXV61
	kUi4AccDlXMe3jP8XR1pVWfw2YfB67vuXOoOPT3KwPqhpI8M+l/B7LMNm+Zvc7AhCV0QfeSZao7
	zqC6sJi+RIBwxr6un2v3QJm0dOj+mYt4ov88cCRsI4rvXzRXvmqFXVfRbwOcifPlWHKOfwR0Sjx
	Wsn5Lq0hDHuMijVFhhAAWOO3hvTp6/IW/m/QRd3seG2tzdSolb3JKrj+kotBN23hVaTz5b/02Zz
	RPmCVHK9DXdHTwSypPCD46/l6Tpym+GS7GTOuD/4cZj9ERyfMWpyscUWr/zOUa9Q5rMo=
X-Received: by 2002:a05:6000:40db:b0:3b7:925b:571c with SMTP id ffacd0b85a97d-3b8f492a9f2mr4770289f8f.57.1754562389156;
        Thu, 07 Aug 2025 03:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtRcixiHQt1T6HKtGZCkxOcdXhJODvpNxCQwLp/FeRmqHQKU+zL/VdHlQ5uC55jTnNQBdoXA==
X-Received: by 2002:a05:6000:40db:b0:3b7:925b:571c with SMTP id ffacd0b85a97d-3b8f492a9f2mr4770264f8f.57.1754562388673;
        Thu, 07 Aug 2025 03:26:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b8aab8c0sm219909625e9.19.2025.08.07.03.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 03:26:28 -0700 (PDT)
Message-ID: <fb8216a0-8f47-4129-8b8c-f5d215abddec@redhat.com>
Date: Thu, 7 Aug 2025 12:26:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, dev.jain@arm.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807082707.30647-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 10:27, Wei Yang wrote:
> Currently it hard coded the number of hugepage to check for
> check_huge_anon(), but we already have the number passed in.
> 
> Do the check based on the number of hugepage passed in is more
> reasonable.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


