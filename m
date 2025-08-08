Return-Path: <linux-kselftest+bounces-38540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE2B1E0E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 05:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0AA5679AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6114F1A83ED;
	Fri,  8 Aug 2025 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlE/jLff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E33FE4;
	Fri,  8 Aug 2025 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754622929; cv=none; b=NVoj7O2OtiLq3VcYGaJ4s6EeZksrAqDlt7h+vj2vsioet+d+Vwfo8AXJxuPDCMsFLuCt9NW9EYRaGyHIymGzW2d34IioAt0A7n4Pv/ZLbkRWhcl7EOV+n6EHjBEsG2xGBzxyJjxr7kNaZNO12Ld7HUO7XPNzOmKLJjMhtRHCsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754622929; c=relaxed/simple;
	bh=96tGBVaBqZubxLaP9NTmgJKsBxJTzt0tUO4kslTgHAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqjbIAcGs2SNnyf27+7BDZxczbnkHJrxZ+vl5SPRD8SM0uSiu4tA6qhaK9DmM/xzbxSvUCtJPzL6ON2hjItNeN4A5SWsVfhn85gOw6xtNcUYIRMcC+ObUmsU/YMJdNyRt8hKSenTds1hPY/Mx4XNEiJylJKP2Y91h6OpXYzo3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlE/jLff; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-617d43a5fd3so1323247a12.0;
        Thu, 07 Aug 2025 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754622926; x=1755227726; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7p2cRQXKBYMkx/IIEN+NpW/CJNL5It+Gq++nljhLm6M=;
        b=IlE/jLffBMidGPFtvtI1qb82LEaAFvIsJn2OUkElCBYkhpxRFYdKGSotF5SxCEBvbe
         cMjJNwJmP3BRCL9SSo4orzIqDUo/fjpJPgLIede9SnD9pf0eXj4eYe2n589vpFDjVaFb
         RslzSHMJXxIKUM18Grkx5uadqcIOjr5mjtg1SyxL+lr2UMSJaGn29+F5JEpk1SvoQ929
         y/YJEtkLUJfUPFnYB2iIV/9eXSiTgzHT7p1e/EDfsOP13xMFJlVNdpUoUYZGs4ZZuTCE
         lIhzLSq3lqtt5WcteYnRv8oPL4T9O8hwQWKzqyHpg5XmQajmTgXnbtn05UJfpAFnBzJB
         83jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754622926; x=1755227726;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7p2cRQXKBYMkx/IIEN+NpW/CJNL5It+Gq++nljhLm6M=;
        b=Dcj+cfAjSZVWmmXOWw0qGveJhOIzhbIaanv3RdtyfrDf56fuZ8t14WPfqgp2DXcxGK
         QQYQhvNFOxZlDo+TJfZf2YQjWbDMZ8rIfISCCstwarPTk3KABYtkEz2A1H7YRYXrFwXu
         pq3Gxk1kiVjqGc/9NT0Fco48V+9YEDvH/CxTMQ8gQxwUGOxsY/kDRmW0iNUcudJ7z+f2
         OELSbJ3a+DUUbpEU85w+WZVIebuBAKFjBsFHkL+qwN7ZBE6oG74kIlsNYOfHeByPkKrq
         jzSsdjce3/pLqSxJG9F/tQdtFmRXztzEpi8+kqBTk9dimoNvXCShiKeK0zfGq6uiDPGb
         znFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/XhQ57vVN6nDro0v/OQ3U35GiQxybt3EjMSXJpMoIfPsf8CM2nhTugeFczAWBLG3EsLUPytOJOXun+Qo=@vger.kernel.org, AJvYcCXIiC+brrceF9I7FdYcT+wj1pMSYdrwyoVMVs310N5AjEYaj6n0cu2Ptqe/IIZGrBqr6FsgfPoKcDSHQPtyfmVC@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtMGj+nFC82REuTkfkml7TYEjPptQancfrNiBa/X+cGg+swnG
	gyxHBNl3cssbaDI28kijN4iHlbSagyOE+YH+JsoNei/E6gFBjXKV+hCI
X-Gm-Gg: ASbGncsHtE4KkhPNr80ewKaP/zQoEYqwc4dstxzGYEzZTjJIFbnTPklMnac2vpqu0on
	wI6kV7WsW4Abu1RGdEKBAXqRIq6ZeqaTxo/D/cdeLFGuRXlcbfLdIueV4uY3GrknalQCdUNpd1w
	UCZYGAWcQM39FydCRUZS0MykdozklcN1zyclTtO/zkJArKbzcy1pACt0qQUE9MstoZSHVq/no0Y
	haTId0JKhC9rEoKHO9DIqiCKKBtJz7k8scp30gsDxLgcYoWbsKToBzX+9L7/p9ZKKvXLRwS/xva
	UcmgkX/jEVroD+PuBpG6sfqC4ndL6zD5KgQzcSDYDz+WpSu0yL0/G8S3+mjZmsPMb22nDxhyR4P
	ph7Nqmf2RyN9IU2E4Mew1cQ==
X-Google-Smtp-Source: AGHT+IFGiL/42r4aIJ9cUqYKGKbDsAn3hsJB8LH8rLcDsIp2O0U60ZeuOkBF5REVkfSxfPGLNp7HVw==
X-Received: by 2002:a05:6402:268d:b0:615:142a:c066 with SMTP id 4fb4d7f45d1cf-617e2e57052mr876640a12.23.1754622925628;
        Thu, 07 Aug 2025 20:15:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f17829sm12621571a12.19.2025.08.07.20.15.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Aug 2025 20:15:25 -0700 (PDT)
Date: Fri, 8 Aug 2025 03:15:23 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/huge_memory: move to next folio after
 folio_split() succeeds.
Message-ID: <20250808031523.g76tmlghuaorjaoq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-3-ziy@nvidia.com>
 <20250807085521.bhs2o6wk6pe7xf5x@master>
 <30CEAF42-ABC1-4174-8D78-C92B8C8AEB37@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30CEAF42-ABC1-4174-8D78-C92B8C8AEB37@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 07, 2025 at 01:05:09PM -0400, Zi Yan wrote:
>On 7 Aug 2025, at 4:55, Wei Yang wrote:
>
>> On Tue, Aug 05, 2025 at 10:20:43PM -0400, Zi Yan wrote:
>> [...]
>>>
>>> -		if (in_folio_offset < 0 ||
>>> -		    in_folio_offset >= folio_nr_pages(folio)) {
>>> +		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
>>> 			if (!split_folio_to_order(folio, target_order))
>>> 				split++;
>>> 		} else {
>>> -			struct page *split_at = folio_page(folio,
>>> -							   in_folio_offset);
>>> -			if (!folio_split(folio, target_order, split_at, NULL))
>>> +			struct page *split_at =
>>> +				folio_page(folio, in_folio_offset);
>>> +			if (!folio_split(folio, target_order, split_at, NULL)) {
>>> 				split++;
>>> +				addr += PAGE_SIZE * nr_pages;
>>> +			}
>>
>> Are we sure addr points to the folio start?
>
>David pointed it out. Will use addr += PAGE_SIZE * (nr_pages - 1).
>

No, let me be more clear. I am talking about the addr in next iteration. I am
talking about the addr in this round.

For an addr in the middle of 2M, we still could get the large folio if my
understanding is correct.  Then (addr + whole folio size) seems wrong.

             addr
	     |
	     v
      +-------------------+
      |                   |
      +-------------------+

Not sure this would be the case.

>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

