Return-Path: <linux-kselftest+bounces-40529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E72B3F840
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5EF7A587A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A5C2E5B3D;
	Tue,  2 Sep 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRx2aJEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5455219E8
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801439; cv=none; b=jsOD7nVhzADat+ejg0w2E4PMdBaxtg85fopJ9HEUR6TsCrYenAHgC7nNkCu2S7m1c+mGmm45QEwqgSmOvZ917WRPBjKvGdbRuf2PgwHdUsfRh4tP1xjs2jOfdoZFIZ9UttL1KrnJ4F7ItkLcFKl2vR3QS7iA2phYDfTwXkbgqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801439; c=relaxed/simple;
	bh=aMFJ34UwjSmjAutS+a86DxbvxJkc/UIErII+jVi2eb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVG8s6ZQQ1fuqmaJLucGvcp/SZgRFv/ahEmu6VuDTbaws3b64Pikb3IjFtVNlHl6uHxNs1KQOScRLgwrf5DNYvQ3cAz2Aj6VC9OE7jZHBLABWTqcwrscbsD/Ufy9uS5tA0Qe5aHLi7l4Bdubr2QUMcxauskvQY74oBr5ZoYzDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRx2aJEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756801436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KvxAM3vFK2Ke3HXVSRqbv/c2sggs3s08NYadXVb6dg0=;
	b=CRx2aJExhXhALIxCtaYunnZ8+scXwdliIVGt4Zrkou4yjDKy6NSiHqBf6TcdsPhdZUpQUN
	JV9I4FzK6rvooE9FzNluBBT5KyKRoXC/wTGcawGwJv8Z1LDtvkDQj+PHLrLzES312FAOAr
	L1oGWQPOxfS6tinEfdpP6eqPz2Ju7Os=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-irI3S3Z6Mba234DJhi6kIQ-1; Tue, 02 Sep 2025 04:23:54 -0400
X-MC-Unique: irI3S3Z6Mba234DJhi6kIQ-1
X-Mimecast-MFC-AGG-ID: irI3S3Z6Mba234DJhi6kIQ_1756801433
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cca50781ddso2189570f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 01:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801433; x=1757406233;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvxAM3vFK2Ke3HXVSRqbv/c2sggs3s08NYadXVb6dg0=;
        b=pfZaRuX9bICkpI+VFMwWlbconO17OEuXKRqVqK5skWa9AXKdMk31helgEeL3tSUWW9
         LniB2BLG7XelmU5TiYQTRiL+Kzw76r5cULwIOL7DuguyypzH/FPs5N0Xq4fdnclaQ386
         x+UzubD+JkOgWewxvbCB/Lnhz4UThnVl7eeaMhSkrLtjy4ySLTBBwZpLoM17U8VuZBtf
         ZxjGrkb7absiGQTSG2Pe91iIGuVA6RH3E3+GGGWXI/fryAzyekFIaDcNuoc/yAEtNVyn
         o/n5ldlyvJStxNDuUbYJqxioPTEhva8O4SCr95C4T26OXj27r69kvsG8Gho9a4SGKM6H
         26QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWymdeAxQq4kISH5MxumY5PUeG7vVsErvSRG3A5LJ88mdsxd200bBRyLkJQJ8AwsFJEZg/CkWS1nn9im22Am8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAtGtqWa8tqU00ZSJBoXbS5JbGo0DwW8o6qvXQT8fyaLM/kEy
	0li1ucpJPQLhHnIPgunByGb8pGJr+Io5wwgWJMOrtP1VSyLrZOvir4aCCpqeTpATR01RZl5F6Nh
	PLZSYP6w+VoBM2LmLVnCper29ZjyQrn58kJz00XxEg2PIPpYZ9XQWNkg89eTNb8UhcBLCJA==
X-Gm-Gg: ASbGnct9nWzXjT++NKGrz+7io+0Sym3GAqnNXqjsZWQAHg+ANojLuD836WF6ZjiIuLR
	UN/6BSj02XPbLQpz/bGjPx1nxd2mdWHIV+by8p9AQ1h9Y5nNgQDcbWf47DINjKxPPBpw1YSnFJR
	9OfXgy24v/CSAgy/CyCP286ExoI2zloTpUmjFFQGdjs7pxauq1c49mVc8D0/7vx8IWQn6TBTx4v
	xliz1ahVyaNjB1cRzr/lUoSdtn5DA8IEIrtJj/Hw9/XVZrRlHiEi9xaJfWxEc6fgod1w+Ly0pJM
	a85aRO28T4ddI4ZKBs1M6gYMfrpsvTbQJ7gXgEEQadYBhW7D5eNOAEbsB4a4FBVcjEWzOsZ5kk8
	DsJVwDohXtDRE9NYZlm2arFsq/MGiFnTagRo1bseOyPaUKwSldT04z1fsHvRDscyZP9Q=
X-Received: by 2002:a05:6000:24c1:b0:3d8:8f86:7b0b with SMTP id ffacd0b85a97d-3d88fa504ebmr2342615f8f.50.1756801433270;
        Tue, 02 Sep 2025 01:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGePR3w/xMngBlylIPdnX7e6LlYWdH1m+Rn45nV4kPBWpyUDCkhsR/RDNmCwosoWathSfLsGQ==
X-Received: by 2002:a05:6000:24c1:b0:3d8:8f86:7b0b with SMTP id ffacd0b85a97d-3d88fa504ebmr2342601f8f.50.1756801432817;
        Tue, 02 Sep 2025 01:23:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm19047514f8f.13.2025.09.02.01.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:23:52 -0700 (PDT)
Message-ID: <05f628ba-c24b-4180-87be-e5a577dc4e4d@redhat.com>
Date: Tue, 2 Sep 2025 10:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
 <20250902025112.d2n3o4imeptppctd@master>
 <dd30710a-a210-44dc-93f9-1e7ddf096251@redhat.com>
 <20250902081342.rthx5sopowmg4hyb@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902081342.rthx5sopowmg4hyb@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 10:13, Wei Yang wrote:
> On Tue, Sep 02, 2025 at 09:49:48AM +0200, David Hildenbrand wrote:
>>>> +	/*
>>>> +	 * To challenge spitting code, we will mremap page[x] of the
>>>> +	 * thp[x] into a smaller area, and trigger the split from that
>>>> +	 * smaller area. This will end up replacing the PMD mappings in
>>>> +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>>>> +	 */
> 
> This confuse me a little. How about move "and trigger the split from that
> smaller area" to the end? So that I know mremap convert to pte-mapping and
> leave thp unsplit. Then we do the split.
> 

After spleeping over it, what about the following?

+       /*
+        * To challenge spitting code, we will mremap a single page of each
+        * THP (page[i] of thp[i]) in the thp_area into page_area. This will
+        * replace the PMD mappings in the thp_area by PTE mappings first,
+        * but leaving the THP unsplit, to then create a page-sized hole in
+        * the thp_area.
+        * We will then manually trigger splitting of all THPs through the
+        * single mremap'ed pages of each THP in the page_area.
+        */

-- 
Cheers

David / dhildenb


