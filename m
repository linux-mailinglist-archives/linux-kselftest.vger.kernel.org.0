Return-Path: <linux-kselftest+bounces-44039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57193C09299
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898171A66310
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1830216B;
	Sat, 25 Oct 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="INt4IXL2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02883009C4
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761405905; cv=none; b=gVwTv8rVFue6hMybGFPGa/44Qnva0wEA4ZJretDfJcDnhsLKFNeeA4k6s4hEUBWKfN98byt2ckyYtApJ+jhNNrdOphHu87eBz6Irhr0PjiccGoRrZgKPUPYK/ZcJ7e8fTbDY+v/tTKPQAHJd4fpSDmLzRksb6TTC/NKhcsqMrzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761405905; c=relaxed/simple;
	bh=xDRkpAn0D2lhlrXt3t3UOPRfnSga85kN6uhnRJl1ndk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOTqWG35rPfwT/3U7bftMnNWetjLjllplSUczCYiI6k/MJen3om3MkWMIYoZqn1WGY2GTMljbnmp7DI9DHYD+7UJlHAXzFDxN53GFdM9HNT8JYtyHV/SvSEjt/gHH8H4IgT7hWYBE6RkC0T8gLqnH4kkqbfl6PwvoY62A3JIDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=INt4IXL2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so377566666b.2
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761405901; x=1762010701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEsLv/ORWjWt4JjusiVyw1pkRSWkY2jVnldvJ/kYxAc=;
        b=INt4IXL21VYqDx7iKJKvvZKQiutlYwBCOhjkiXC9yDBFUqb62UGDfYUksjAXFv0mcY
         XfiaRG4ZeGqwvGYfi0Z7VA+1ayJbFAnxNu1s20L5Klcur1fe+pFNyicBbrK5cY/fbpWi
         mO4SXc8jGKTcAkNBwkWzXRrPVgIzy0PLubo3najaSeYOt1qhQ6sfZ8YTOUtUOaBs//Hq
         F4okar97RHI6BlBxjoMFuYrIVmZb7UANxDTdvbUK2V6c+vYaACXe5gtHDLyyU6vQ98MH
         omz2/I7YSnf0qTo4PgAN/O5LyTMSVUsrkxFwETt3Zs+mltCFms8gkrp8Zkn0Qt5J7phR
         kGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761405901; x=1762010701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEsLv/ORWjWt4JjusiVyw1pkRSWkY2jVnldvJ/kYxAc=;
        b=CSiZEkpAs8/PD4SN9zTlkWSYASKiBXA/D5/WASzAF2+INzo9WgWf9VcXtasT7P7vKr
         w2veAERTVxxYjHUuAOSwuPQ9CW0EhpyZeXWJwwL8mlYAzt2Xv8v4sIq3sD7QPzgETHME
         QoPybA8VFDs1tsUIJuhiQ8a2S6+neEbgpzaJnACF5EptHndcidxz2ZG6mZDCad6jqunx
         mVQ9U9PyDEYc3/fgSoewbjrnP7KxGgHDLltVV1P4k/yWKZQWkN0OR90vgZw9+W7NGdJI
         a/fgRiDTWXUgoqWCKvXL+l/X1MLaSDlqjkRSeEYIDWH7jsQD9QbGTsPGPta3+2zI9ID2
         sOOg==
X-Forwarded-Encrypted: i=1; AJvYcCXEhMBFJt7jEPWLyXUURsOHlUB/6r611rOYs5gUZOOkgpVFSBFlSO4F/Czg19eh4KDZV8W2806aRVaw2Gxn23A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVq+JoQzDbcGptPPamqYsLf9BLoxqBRh0XTrcoqYI4hP3eGVD1
	DjrXjWm1AFWMO92XKJQ6dgwrBT24qjyKJAoa+bSqMR1YYy/bnTv5uxmthN9+VlOg2HzxPnl+C6m
	c2sS5vioJrzahItNzVqceRLJbhY3jNfBq4Tn99s3+9w==
X-Gm-Gg: ASbGnctyjYJRvbQoFSO2uY9rinb0YhW6lX9vt1B5A8gBOQFhZmOd3+52zVqrmH3nBJ1
	44wdmQVB2m02B9Eh4yu+MoEEKlK22eoKpfTBec1BVLwTtPzqItMy2qo9r8/koRkXrSCEuUDM67q
	qr7UHA17dHIxg25r+o87cvaTLy5eiCSzYKhkI9HRY2EIklygK7rrvT4B3VIS+dhd8TTaeiswr4m
	wNgc4NqI3Wkcf4FsFZugpl6s35th1remlWzP44dskf5F+MZovsKPCblLbUkoUxTGqkqDvfJn6av
	nXM/MWB6wo9ONar7wf+TVbPfyk/8
X-Google-Smtp-Source: AGHT+IEkKuyMVmFsWXRY0bxtHWTNzex75v+WBGMxRJwOZQScs1xFZAgq+kDpvorbdJ+d0KcQ27kL7+tqDAzCdvkawvY=
X-Received: by 2002:a17:907:da1:b0:b6d:5e64:c36b with SMTP id
 a640c23a62f3a-b6d6fe9fac7mr565664566b.29.1761405901273; Sat, 25 Oct 2025
 08:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:24:25 -0400
X-Gm-Features: AWmQ_bkMrpRaMfcHcpe107aX1k_bm11BfLXJjxsMDuts5-Fo-hDichMUKRxipls
Message-ID: <CA+CK2bC5=rb1C6i5yMad_tG9JpbYYgSRxAX-vhYctuoLvcQbWg@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] iommupt: Add the basic structure of the iommu implementation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> The existing IOMMU page table implementations duplicate all of the workin=
g
> algorithms for each format. By using the generic page table API a single =
C
> version of the IOMMU algorithms can be created and re-used for all of the
> different formats used in the drivers. The implementation will provide a
> single C version of the iommu domain operations: iova_to_phys, map, unmap=
,
> and read_and_clear_dirty.
>
> Further, adding new algorithms and techniques becomes easy to do across
> the entire fleet of drivers and formats.

It is an enabler for cross-arch page_table_check for IOMMU. There is
also a long-standing issue where PT pages are not freed on unmap,
leading to substantial overhead on some configurations, especially
where IOVA is cycled through for security purposes (as it was done in
our environment). Having a single, solid fix for this issue that
affects all arches is very much desirable.

>
> The C functions are drop in compatible with the existing iommu_domain_ops
> using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
> compilation unit will produce exported symbols following the pattern
> pt_iommu_FMT_map_pages() which the macro directly maps to the
> iommu_domain_ops members. This avoids the additional function pointer
> indirection like io-pgtable has.
>
> The top level struct used by the drivers is pt_iommu_table_FMT. It
> contains the other structs to allow container_of() to move between the
> driver, iommu page table, generic page table, and generic format layers.
>
>    struct pt_iommu_table_amdv1 {
>        struct pt_iommu {
>               struct iommu_domain domain;
>        } iommu;
>        struct pt_amdv1 {
>               struct pt_common common;
>        } amdpt;
>    };
>
> The driver is expected to union the pt_iommu_table_FMT with its own
> existing domain struct:
>
>    struct driver_domain {
>        union {
>                struct iommu_domain domain;
>                struct pt_iommu_table_amdv1 amdv1;
>        };
>    };
>    PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);
>
> To create an alias to avoid renaming 'domain' in a lot of driver code.
>
> This allows all the layers to access all the necessary functions to
> implement their different roles with no change to any of the existing
> iommu core code.
>
> Implement the basic starting point: pt_iommu_init(), get_info() and
> deinit().
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

