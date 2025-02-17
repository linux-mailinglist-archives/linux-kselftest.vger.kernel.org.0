Return-Path: <linux-kselftest+bounces-26786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9429FA38722
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 16:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604FB188F7B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F57223700;
	Mon, 17 Feb 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeXF8cOQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48333F7;
	Mon, 17 Feb 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804348; cv=none; b=SaUVw/k0t9nkoV9ts9jNCRcKPL9EFytOVU4ss9U1UtgCFqsitlop7EsPBVxn5EG/Op7KOWhRFbrkbJkU/ZVOOwF7dkbqD1/WKVsTG7ja60FhfW9yTu0M505Z8rtY1mtlGvzCLwvzorrOONsKsryUMJAuugQkcxcpOrAiJ6hxPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804348; c=relaxed/simple;
	bh=ERnk50qO8ESnP0PF7hrTKoSofKjNzmyUIRNoPQMEOnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wa8EBw09vr1IwhKs032Pvtn7lVi4njCLzqqM8jjmBrZDNWx2Rf65vbozS0fE/hBKltaAgKiEGa4XDiNblHvdSy6F9EQcH/o0wTQuOFw+uHO52Uqs01SdK/f34CO+gMgrh+KGyP8iJ2a4omG6VJiImsYNJ4pmC5LppDKktyawsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeXF8cOQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so3304495a12.0;
        Mon, 17 Feb 2025 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739804345; x=1740409145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3nen2ZQWjVU3j6z5FoLCBIj9fu+yhn4VYwilHW5oo4=;
        b=DeXF8cOQeISpsJuQBWMbZUhOpVZb2UrtRgP1Rbz7/e88hxrS0PTGb7T5gjdPuIegvP
         GYoWxQ93Akd1WsSlxMCPBt48Uf2H26Fw9/E5T9DmLxt6yjSPXsokMjv2qWO4rzBPqGxJ
         6dYl53r8zjW+tsM9H0DWuZe0sYoihLlrzM2TkyazbDW57X1+zBj8u85XMonvjifiMgqc
         hylOGkNqNR8r8wnn1yufFBb3PYDUducn+c0OWlpr6IwJHfB5qv8xyiBEGAPPC/W8OuI7
         vNE2PHfAJ3/exmgmTrdS4e78uheRAxwOERQsyrtZn2cVO/BQUVJskT6IDLrG4KocK5nP
         pFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804345; x=1740409145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3nen2ZQWjVU3j6z5FoLCBIj9fu+yhn4VYwilHW5oo4=;
        b=Y1nawCb7WP+aZ+qMbPFLQKiCeo12jg9ZXJavJdJR1KfpZCvoWoRmPKfsElFtYtEPMX
         Jecu9YhfigleE1ezbMy94ZJ/KyPK0UYr4/gJt+dA0Z88G5dqB5yQLw9HGrf2xInKwExz
         NrPbH+m+xTufQXqAq1hzFYZIc+lEf+wVQM2OZZcojiMgnRb79HzAbl9YCdCsAZVmOEWk
         81bR2vvp/nCqjCgeE7U9DfAj8sSchPb8mYIMhusNAm6RxlPRkGCO3gyzvm+kXvPzNB2A
         +P6xI7i1otHgkTWkrP1l6eziYggT2teD/yLTM0gozreI4Uq7RLtMBlJMzH1au8KDEQ/P
         aL9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPETRCeQyUbFkKjAiJzzpwDrEkK51yTc2O64KUhR7FoKNJ9BDFuCbC27aUaygadCao5YCgAAi6kGl5YBxK7vUn@vger.kernel.org, AJvYcCVe4wGqAm9lZq9EcDKWymsDw4Pq8KFgyJFgSgUPezoVurTUvuuYtioNoSDfP2qpFzlC/sHYvBFL0fOMtJHw@vger.kernel.org, AJvYcCVg4v/oPqVORtlkHhGECd3lDBxfv1KJHzia3kspjR0D2vkUoUHXif50Wdr/UJAbVd+LxhlEkC2la/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v6xGtE9/RKngydLCvjfyukVEp7lj9ETRvhwUcTPwKmdLPr4u
	Bm/ncFR8Qr3M//KI81LH0eHIZRSEc7xh9uTRIhOb3oRYckqIU6la
X-Gm-Gg: ASbGncsfDlhAliFVb2As1hAuP84BdpjgQitT7GiXxxTMzKtjJPea/Ybt3Nyhsr1KpDQ
	fqBz6FPLlvMsDe70Zrp2JluyjRSEpfN9KsNj7u/zIi59cPiOQrXgfnxSUOtq6lmf3cXcWCSwAcd
	EQEGvz/c3jx1O0pjcnB7sjgu5+rk9q4gA/ZkwoYyJlLxmdLS/W1xvCP6oPM2LuaRfc2jHAFb2zn
	FamKfrRy2lU7d5K/n9IyiYS1eh5mdH+Sr1dKZx/zwFPV1pr7Op/OzQVPtzqJ5Ut75l70yceKOdl
	bccizY/asdIfvDhL2Ea/YOIpe8Lj8ZIdA6xMjx3NeN38gV+YZcDuY3Mw+8TEww==
X-Google-Smtp-Source: AGHT+IHnTe7KbjcGi7WwFaMqNdoMpfbMfKQ+td8TFe4oH2WZRF5Wq21aBNuVyz43A+JwkZE5XJcgAQ==
X-Received: by 2002:a05:6402:2114:b0:5de:bdbd:6f19 with SMTP id 4fb4d7f45d1cf-5e036171605mr9768671a12.27.1739804344242;
        Mon, 17 Feb 2025 06:59:04 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:fb:39c9:9a24:d181? ([2620:10d:c092:500::7:6466])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e05168c467sm2448555a12.48.2025.02.17.06.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 06:59:03 -0800 (PST)
Message-ID: <c4d7c1e0-e83b-4666-8bfb-1220b59251c2@gmail.com>
Date: Mon, 17 Feb 2025 14:59:02 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/5] mm: defer THP insertion to khugepaged
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
 <20250211004054.222931-2-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250211004054.222931-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/02/2025 00:40, Nico Pache wrote:
> setting /transparent_hugepages/enabled=always allows applications
> to benefit from THPs without having to madvise. However, the pf handler
> takes very few considerations to decide weather or not to actually use a
> THP. This can lead to a lot of wasted memory. khugepaged only operates
> on memory that was either allocated with enabled=always or MADV_HUGEPAGE.
> 
> Introduce the ability to set enabled=defer, which will prevent THPs from
> being allocated by the page fault handler unless madvise is set,
> leaving it up to khugepaged to decide which allocations will collapse to a
> THP. This should allow applications to benefits from THPs, while curbing
> some of the memory waste.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/huge_mm.h | 15 +++++++++++++--
>  mm/huge_memory.c        | 31 +++++++++++++++++++++++++++----
>  2 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 93e509b6c00e..fb381ca720ea 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -44,6 +44,7 @@ enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>  	TRANSPARENT_HUGEPAGE_FLAG,
>  	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> +	TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,

No strong preference, but maybe just TRANSPARENT_HUGEPAGE_DEFER_FLAG might be better?


