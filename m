Return-Path: <linux-kselftest+bounces-24934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585FA193D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3BC16BB8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB232116FF;
	Wed, 22 Jan 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCsgWKdP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AA213E76
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556020; cv=none; b=p5e3wZcvtenKyzWZTcxbb1zW8GirxnMJUWXbVzMof2MIaCKTtmSwgFFG+BgxN8XsTOYUtQBkJ1Vbsd/8Gjj3NYP9JBdFUtw5blKCt3Q3+jRqxh0/tYzkA+DXKgKQAnUoNR1ZtJvjAcrXeh0RqxUyx6/8rUacPT3LM4e7gt3y/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556020; c=relaxed/simple;
	bh=AXXdEtq+JI+Dibsgb4mAC8YerHTLsdpcPChz3O5b5xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU8N8b4HHImHBAt9WCOCOBqKiD2x4DXZCiB5+scO/5wATqO4YyW5Bvbuu1/N29/d5EYvw6clb0TCOCfNX2H5r2O4AobUMlhOZ5BlRH398qO4UagyaV6qx4L6APVKq6d/G/JlRsD7ofAZYE3fVA+xgdHTOVSTF6H8QQRnqin17ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCsgWKdP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737556017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nib2Zq7RBvZTuNjk7GJWSKi/LlD20ddTWug2ev0gnzY=;
	b=hCsgWKdPQCOLpRAivTseS8H/12X67uZ+slFS4JsGdHhgCLjegmvdbz1UPG+2h4rHvHsCaA
	NBCHAWDJsl1ZsZHd/T/H22rr8W7m/xCGrBDr/1arbjVHNfG+2cxKBVLyKsDRgASBj8M5qI
	5yzQVkW4GcSW0j7KmGrglhk27Cy1NYo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-qKVnpBRJME2J_6Lgs7cc6w-1; Wed, 22 Jan 2025 09:26:56 -0500
X-MC-Unique: qKVnpBRJME2J_6Lgs7cc6w-1
X-Mimecast-MFC-AGG-ID: qKVnpBRJME2J_6Lgs7cc6w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-386333ea577so2767146f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 06:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556015; x=1738160815;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nib2Zq7RBvZTuNjk7GJWSKi/LlD20ddTWug2ev0gnzY=;
        b=OqmLTf1NrXDByhdg9yCG1D39T5oAFDuI5CEQyuhz2/hAjb7qHAzr7cQz8ucDu7c0nb
         RUUqS6XMf39zuXMsCCj5hYcXFSLNoa3Qxkn1Seshc8xrOqUsFc5e86bRoHVrnVOUB8+S
         D6SPH8/+DVfOFnOgsEEYo4oNMLa7nxpZjepAWSYWXAVD8b1joOMcm72ppFq/ze+76Hgt
         UiQz7oqj3p30gTrudShATEMz/Ag+unmLAzVwBy+O6U0LkO8mnTvbFPWw7EpCpl7LeHON
         4dRcwMHmjAagYbZqFylbBw9dtek9CCDeEnR5ytLJXQsfEUprQNkLDj5ybXUS739OgwGk
         ZNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX24xBtre4mR82ESwS6D1+oH0eMsnmupWq8KW1H1KhMTho4u89KaH4mE5gMRJLGNTPISQ5wcQUOjeeYaFs9Oas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+E8U3dsy9NorQpMcHVkFAuw+48CDwz73o96HvFnmwV7en8WF
	pUct2/VKrpal44pHnwP/fM3ivuIOg01Aw66c6VE6O6UkJMQtQfRkOgFKnDPX45Y59onKiskblOL
	f4sDrazepmPRVnsXle/z4uoFR+fuJGfQ24pdPbhALYa3nyngmvv37oVnkkjB6Z4fd5w==
X-Gm-Gg: ASbGncu7kvwcJSLdhtanQK+SicVL8+xgeP8Jx9AMuPhWgqvePY7AnTkoEY5OpTM+dq3
	+jzyBOhkQlLFEwFMbfi30kaHcbrhFnHYDcgRI5LbP9YalbyCJnPnSRdMMqzzlx9JA007vzrbEEP
	GKx8xRP08vz7OoyRPXo8wM0ecknYkASYw7kpaypbx0hyqpDTmGDar6fESHOAXmtfOUrL9Z5O4n+
	7ZmE0jd8o4ZNv1M13xE4InJMwVgSKRa4abBS3An0kZGWdaQKd/eu4jxhZUMIH01qLkrXIE2giJ6
	tw2CSswfSGXpM7OP7Zyz9Vc=
X-Received: by 2002:a5d:59ad:0:b0:38b:ed7b:f78c with SMTP id ffacd0b85a97d-38bf566f41cmr18758563f8f.6.1737556015042;
        Wed, 22 Jan 2025 06:26:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbI7CY+LZksYsECrVWzTbBQgGkHkycjlWoTJGN59vDVleZYOAGUc0IJNTfskwMXMu5PYeCbg==
X-Received: by 2002:a5d:59ad:0:b0:38b:ed7b:f78c with SMTP id ffacd0b85a97d-38bf566f41cmr18758529f8f.6.1737556014651;
        Wed, 22 Jan 2025 06:26:54 -0800 (PST)
Received: from [192.168.3.141] (p4ff2353b.dip0.t-ipconnect.de. [79.242.53.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221a5csm16660588f8f.34.2025.01.22.06.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 06:26:53 -0800 (PST)
Message-ID: <04002289-c78f-4e1d-b242-144dd53a62f8@redhat.com>
Date: Wed, 22 Jan 2025 15:26:52 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: make file-backed THP split work by
 setting force option
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250122124047.1216024-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250122124047.1216024-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.01.25 13:40, Zi Yan wrote:
> Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> changes huge=always to allocate THP/mTHP based on write size and
> split_huge_page_test does not write PMD size data, so file-back THP is not
> created during the test.

Just curious, why can't we write PMD size data instead, to avoid messing 
with the "force" option?

-- 
Cheers,

David / dhildenb


