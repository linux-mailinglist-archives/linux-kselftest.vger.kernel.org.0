Return-Path: <linux-kselftest+bounces-38373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E565BB1C621
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB97B18C27FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477EF12DDA1;
	Wed,  6 Aug 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gcnlv58d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F662221729
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484146; cv=none; b=SoVO5mkYDUi9MmNO+0nZnTlIcH2f34f7nMONRTqcBNb0nEXtLXJDUiypNn/noPyF8ALSUtr5GLddzCNLDsrw7dL1+cn17d3MZXJhLiDJB/9bsI/hUFItgCfJ/nvyD1VP0030L50oEufzMDxEkAIpMgGsZY5IRPM0yMlVvsoIbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484146; c=relaxed/simple;
	bh=rFHj5aUhNi4spLOCKUNftny0u9kpf1dxvjwzlTxlfe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O35Q3G1j123FZKQsVwHuY3tzT4QnmsvAsl4Q6u+qmhDW5o99H4arjDEvlLxucNjzX/McxbD5RCSdI21aKSEe9JCcPQ1XIh1H9V1oHdk3u2fTm3rDQtYVGMXYJifONpvzbW/x67un8I8ekg5CIZN6rFZ3iRtvM9k+tCsP1J2SiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gcnlv58d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754484143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6fC+wuZRrS98vNZxfDF8dB7BkGXm5HyL/fUXW2U/KHQ=;
	b=Gcnlv58dhcJzOh5i/SSG6XO4rJynuAKhiPhv+aRiv2RgOAa2xULiNR9sqzRFCb1zRqxVAq
	soGZfp/h+VwMhynHrU1YBuQWj6Fkm1epo6XOGKeUkbqVt4QTU2P1aJ2Qf5eMHERhJN6ARE
	DQx+wpPgmtELoh7bksdLB7hXjtZL0UM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-856Ig9aFNUah05fFp-Hqtw-1; Wed, 06 Aug 2025 08:42:22 -0400
X-MC-Unique: 856Ig9aFNUah05fFp-Hqtw-1
X-Mimecast-MFC-AGG-ID: 856Ig9aFNUah05fFp-Hqtw_1754484141
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b81e16c17dso2384277f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Aug 2025 05:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484141; x=1755088941;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6fC+wuZRrS98vNZxfDF8dB7BkGXm5HyL/fUXW2U/KHQ=;
        b=bkDmR3UBNjG74hayOGroNTaoLoJCBazUPgS6W29c8kcc/iv7PSnb4Bo3hMfEuuH2cq
         po0Uuc4nLi03veOSZpV05OmhWAwtA2uiTBUDzaaT/kSUbnBeglbIBMkmBHzBAdJ9AQF5
         Lb8IM6bR5CR4lj4MupbOga4uplIHYQd4QiNTaANpqb9xvw6DLNjVUZrJKO5K5dhvML/W
         jezgheKbaD42MRvF/xMdKvCpP1Ajczet8O06UI1QrQbG0WbADxmRTBqRO3DCsiZqYwLU
         tWkqIUh/VED1oXpbbkhUzVGLDwnmOtuARHbmL3Bi0CSS1G6OtrP2JyBo0suVB+2xL1dD
         74Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVxnVTKtncdBE0EtH0rWrHRV8wro3di8LV5pFohwTxmdmw+ZB+u+s9q5YtEMuyaan0L2cf3wXtp19klQ5oofJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybNq4NRZWCO94EfKxBA7wqHrWWspdNhnA33U4prdqhBVQrPcbm
	mAKoM6D5yuMAtDwUEAgDilGe28zxeCHaHM4glcVDj7xlQZYE+M3Sr4cszQR2s8G+vqPLkkvqHio
	Vv2tqKcVQ3YQxRFrVHtMnE1uXO4Gis2l0vEXv2D4Vxot3KkedM1Q9NEvd7la+peJLrk5imA==
X-Gm-Gg: ASbGnctWrGVuKu7iZY/D5yXuzDbiHSz/73ipozLYMncr1mvvfJVJ84gF1vGxfwntelR
	+jWZiOmLG6yYVlbxlDErSssaEEuS4J1J3MfBmgkCZQA3znUBJigv3/xWPutRYU3PiPQmat9fJa+
	ouEM1U/YLH5b290N3ttELCP1OKLOLlNY6yzp/jwwP6nOgF/MkBI2x910KW+ffwwyDRIBzNvTuus
	3/t5jPHMME3X8uNLzVlrf/ZKgr9FrOKieJrYiKO9Z/aeIvqDKCWAxbCnkVsxXv0M75lejqDLObk
	3jURA91bfBC3MTJCfP9w4lQhHtwgBOwU+4/URqqeFY24KSEBTbr7iILUKXMy0dEXzsUF5N5Ch/r
	uuF+REDiglJ4y4dD72QGJ0eHjCCMFNZWgAKcndSEhQKlZgERqd+fABXIOGfSHF8hEOMY=
X-Received: by 2002:a5d:5846:0:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b8f48e929bmr1886370f8f.20.1754484140597;
        Wed, 06 Aug 2025 05:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgk4+ikHQX6105e2puO+JLj1QNXAy0kwvoA7WxfsLLJbZOR8ZghoT2xETRXpsUtY54KVrOYA==
X-Received: by 2002:a5d:5846:0:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b8f48e929bmr1886329f8f.20.1754484140086;
        Wed, 06 Aug 2025 05:42:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm22995355f8f.37.2025.08.06.05.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:42:19 -0700 (PDT)
Message-ID: <6a39f79a-d709-43ba-ab28-2b86f2e4c547@redhat.com>
Date: Wed, 6 Aug 2025 14:42:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/huge_memory: add new_order and offset to
 split_huge_pages*() pr_debug.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250806022045.342824-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 04:20, Zi Yan wrote:
> They are useful information for debugging split huge page tests.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


