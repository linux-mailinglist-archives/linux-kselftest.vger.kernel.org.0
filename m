Return-Path: <linux-kselftest+bounces-26787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252E2A38733
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238731885736
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D7153BE4;
	Mon, 17 Feb 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djc13nn2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABF20328;
	Mon, 17 Feb 2025 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804666; cv=none; b=Cl8HZR+VWfu8teXJklZGWlvfoS0LNJvwET4B0vpPGoPq0tYoLYJEvsgRo3AAeRcSuK0CoNvxf3JUG+kfH6r4tWW5/ks3YmFMJ5owUoN29zhwbaHjHzKHwj11W1a/37M5VO0KHGEgvICSRWeamGRzChtcF6mouyYjzDwEKxyF2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804666; c=relaxed/simple;
	bh=E8NFgQcJBrQUKIuhIbtkhYlDTz8CDGKjw0SOCRX1wAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3F6uREq9mYa1BEqM3DkgtGX8TcL5g9htWmB8JoqPmf38MpLSsCD8Cheb/72GnXM1u768DSyEU5zIFLSKWfJALQvzuQr9k6oX3zzQXQ9AWVgLXlreYvBJAK6KiU743PwZj80I3Sx9GhWjgoLWpaZfpc0rRW5fpztR4a6n1lhADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djc13nn2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb86beea8cso304355566b.1;
        Mon, 17 Feb 2025 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739804663; x=1740409463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRVxnMeD8IpIEchrlMHMZ4RoqR2md9lA482drmPDviE=;
        b=djc13nn2Qk69qqPreKwyaaXCOv+mvr/EkeSw2W4Ex3gHJELzBjsfzHzhGSsXb5sy2R
         wiVRmafuIKRartXpBCOMGH+prqz77KV8ktZ04eRPhf15WqcX0i9CyWdd7CLuERaFL5CZ
         Rnk/0/DOjx6EVoKsb1CDZIaSKs+uIctM3NxEBkRYXGEb8Jh2hzAXx3i4KGUs1QuFykus
         y4tr2PMEjcgbcGwoH3HU/cbBCDF/N9gZdGJ9qVx0hMJWm+xxYyjDAEqYKunjaA0WRcNE
         gFL4CirYwbE0Y5p4X73gvYQDDzoMMzl2/0vXQ/kIj6OvQoJ7E7I41bh6ikdjaSsZJJtL
         McNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804663; x=1740409463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRVxnMeD8IpIEchrlMHMZ4RoqR2md9lA482drmPDviE=;
        b=ABMv2rHqAG2RjHkHHEw3QJHluYbo3sxt+6fcY0X55by1CkQDwlRDkHWupeZSh6dShL
         +R6o38+pzN5kTPOXH9ogJPEc8qAUNHaYhIt5qQ+gexbaz+xIgCF8vLRdGcQwDgys1EqY
         PLFUDgH5aUBwsJcjT41l18hGsokOe3Pwoo16Kq6rJVJMbb1r4Grg+lQTmk88zy7EZzM3
         o2+DGb8SXocY+2a+YbE7JzmvM4tJVi2XmZ1eKnop4971Qch/x8D/Eq9psUadLnMKsjZy
         ThHoDGYIuUoVu8Qj7tEKUjn6bOiKyNUxWdmgbW4JeQCACcxth49bCTTTBU4i1xg/BN3v
         1LIw==
X-Forwarded-Encrypted: i=1; AJvYcCVA7J3Kdch5hrFi8+getQAJdRQQZBSLs54jMoHKZSQ3H1EpCpYxtjRGAuBpBPty1nju+MJdQnZESx0=@vger.kernel.org, AJvYcCWmuVuYfK+uEOob/660yG1Cj0Y8HoO8n4Dpdjl5HB8w6EfJ9B8SO4GU3MlgFaxjFQWUi3h2inuoR9hiU7X7@vger.kernel.org, AJvYcCXK5O0FcwTWwm8zJ0YKDasFHJtMjuuEU80bW0P2qwSV2oS/WS553l46PvKbIxz8gVPDzzwzLy0MBOVppKP4v7Lz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq/oMxF0phDkhEQvvpfovArGR1WzgMEqN7OQx0VJIHnLOCv88
	0NSUXQT7Duv3Edjm0X3L+vE1Z9e75smqZb3+NFLREsFlRNkWEJlVoWmFs5h6
X-Gm-Gg: ASbGnctHi96tJzDIc3NdH2OPTNAOiQ0qlzWKJmRooaPlaeOaLzkaDvflmPYEj1gF12L
	IA5n9kXF7erRNpVwZ2G23cfnM8SuGrZVzAOKxlgQHxT2BYG3bax1GsmgUN3UlNZxnOvOKqLyQMA
	HEu2Evs1UNhSPXI2dTdIPM0rgDFvfVN9lTG7ieW9XVECPtWBm84xuyR3Ig3vDcHQ310Oiy3XuIv
	vi9rk4fGzbrlTNs+12fjMu/gOFExwR99J44M+6JqIq3nKJYcZWBc8AzPKQCOiNUz4x1Z+yyiVaL
	S66RI0TpXk4N5D9gQ2MJiHQuU9ikQaLD0IxNofHSqOk0IQ9EBCNfppKkIJHe7w==
X-Google-Smtp-Source: AGHT+IFYkiJ8kM74K9tynb+pKXTc08qo1unvFKMr4ZPy5mMIfHNLdjCRSBVFST+JEgGGIGaTZJ5ONw==
X-Received: by 2002:a17:907:1b12:b0:ab7:a39:db4 with SMTP id a640c23a62f3a-abb7115103fmr1054240066b.57.1739804662407;
        Mon, 17 Feb 2025 07:04:22 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:fb:39c9:9a24:d181? ([2620:10d:c092:500::7:6466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb904a4ae5sm301906166b.29.2025.02.17.07.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 07:04:22 -0800 (PST)
Message-ID: <c408c854-134b-4758-931f-e6e3b7a58213@gmail.com>
Date: Mon, 17 Feb 2025 15:04:21 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/5] mm: document transparent_hugepage=defer usage
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, shuah@kernel.org
References: <20250211004054.222931-1-npache@redhat.com>
 <20250211004054.222931-3-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250211004054.222931-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/02/2025 00:40, Nico Pache wrote:
> The new transparent_hugepage=defer option allows for a more conservative
> approach to THPs. Document its usage in the transhuge admin-guide.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index dff8d5985f0f..b3b18573bbb4 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wide, application
>  may end up allocating more memory resources. An application may mmap a
>  large region but only touch 1 byte of it, in that case a 2M page might
>  be allocated instead of a 4k page for no good. This is why it's
> -possible to disable hugepages system-wide and to only have them inside
> -MADV_HUGEPAGE madvise regions.
> +possible to disable hugepages system-wide, only have them inside
> +MADV_HUGEPAGE madvise regions, or defer them away from the page fault
> +handler to khugepaged.
>  
>  Embedded systems should enable hugepages only inside madvise regions
>  to eliminate any risk of wasting any precious byte of memory and to
> @@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepages and that don't
>  risk to lose memory by using hugepages, should use
>  madvise(MADV_HUGEPAGE) on their critical mmapped regions.
>  
> +Applications that would like to benefit from THPs but would still like a
> +more memory conservative approach can choose 'defer'. This avoids
> +inserting THPs at the page fault handler unless they are MADV_HUGEPAGE.
> +Khugepaged will then scan the mappings for potential collapses into PMD
> +sized pages. Admins using this the 'defer' setting should consider
> +tweaking khugepaged/max_ptes_none. The current default of 511 may
> +aggressively collapse your PTEs into PMDs. Lower this value to conserve
> +more memory (ie. max_ptes_none=64).
> +

maybe remove the "(ie. max_ptes_none=64)", its appearing as a recommendation for
the value, but it might not be optimal for different workloads. 

>  .. _thp_sysfs:
>  
>  sysfs
> @@ -136,6 +146,7 @@ The top-level setting (for use with "inherit") can be set by issuing
>  one of the following commands::
>  
>  	echo always >/sys/kernel/mm/transparent_hugepage/enabled
> +	echo defer >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>  	echo never >/sys/kernel/mm/transparent_hugepage/enabled
>  
> @@ -274,7 +285,8 @@ of small pages into one large page::
>  A higher value leads to use additional memory for programs.
>  A lower value leads to gain less thp performance. Value of
>  max_ptes_none can waste cpu time very little, you can
> -ignore it.
> +ignore it. Consider lowering this value when using
> +``transparent_hugepage=defer``

lowering this value even with thp=always makes sense, as there might be cases
when pf might not give a THP, but a VMA becomes eligable to scan via khugepaged
later? I would remove this line.

>  
>  ``max_ptes_swap`` specifies how many pages can be brought in from
>  swap when collapsing a group of pages into a transparent huge page::
> @@ -299,8 +311,8 @@ Boot parameters
>  
>  You can change the sysfs boot time default for the top-level "enabled"
>  control by passing the parameter ``transparent_hugepage=always`` or
> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
> -kernel command line.
> +``transparent_hugepage=madvise`` or ``transparent_hugepage=defer`` or
> +``transparent_hugepage=never`` to the kernel command line.
>  
>  Alternatively, each supported anonymous THP size can be controlled by
>  passing ``thp_anon=<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>``,


