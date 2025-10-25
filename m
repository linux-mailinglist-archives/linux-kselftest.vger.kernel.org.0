Return-Path: <linux-kselftest+bounces-44041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05958C092C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2D014E3686
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9C303A03;
	Sat, 25 Oct 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CF9FcJJ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCF21323C
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406844; cv=none; b=t5sTihNx/QmtRtbI9FMKbM7To0RIOD6CedLDqi161gxiJ9JcSO9cF01RkSYK4jIsEhmm2bPGcGItgRjcJ/qkZaOcy3NH2VflzG+oCqt89XBybqDDqxHihjGsQnpBvI3kaDj9wkAhrmq0L+zmE/wGed2ZO4cRnBvSQpCrWcmunMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406844; c=relaxed/simple;
	bh=0HY16VFXZq4Fs4AqSUpKJwWPQq433JoGDwf5zAVL/Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2S/LYoP+ZA8Pvk8JiOLn8QbDYL23UTIU6kQpbySaqpcqRu2rphQRbMsiuCMSx4JLcRAuzkYb9iexKtYcwiMF9t3kxQR5XbMPiaYcZZPCVFwzDxeDezNXoO35X8cKCtMVIIBa+zCwhyTvAAE849SJrms8pvG5HRnXlHQ4BQGPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CF9FcJJ2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso4692486a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761406841; x=1762011641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HY16VFXZq4Fs4AqSUpKJwWPQq433JoGDwf5zAVL/Es=;
        b=CF9FcJJ2OewgeQP7WyxBZYYfnEwmZ+nkpezxtdSQEItAnoc7TKycpodGV1UvYWdpcN
         PKJj665ea+ijpXk88pukZgu4d/Jpwpl4sYbT3rSGMwtGCDYsDqObUVWucps/NcWzlpvu
         m+K3gCpXJGJwtUJGTQNnywQ1TYEkfS+syDeS6wuJ7px282/ZNy/n6tSz49rYZH2bj+49
         XKsqsLeDKpYV/OmH9Hj/V/6skast6sLChGgxnO0IGr2Z/JHMF73kB63WD4zr2OpF6KJF
         LPnicjcWcsXh98d5ZNSiz459c/RzSqZauQJuSTivaBn3D1S5RFPqlPhuhHtkur1kXa7u
         C3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761406841; x=1762011641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HY16VFXZq4Fs4AqSUpKJwWPQq433JoGDwf5zAVL/Es=;
        b=ZlbDaOuQADO5fcSkLOr7EEcX5yypN0GA+ljlOueOYsRoM8rO08eX6jt8v8410eWwRS
         GQMd48Sx13z6aW86ZqM1319O8bdWmlpPUas0WPeVcTJgQEA08OmBx9aHwSuIa3wJ3fad
         3YSKya1KAXx0HtG2Uq+aCuA/rP2irkK/XUw+ROUz+hHr7Xw/D3wU02kPWZoPpQsjPtok
         E0RfhMqIZfajmTaBnovtLH0zBq7xQWFBSzrCCAB6HjJyrIzfY1RhFF/HEIxYqRTGHruT
         Vg3gjgCJ0pvWPWYWtfH0x4h5C4V85SzRbG5zr+im5UhDDEBA4RE9uq2sQvA0zujt4I6x
         XILA==
X-Forwarded-Encrypted: i=1; AJvYcCXdWf4QQm/5mb29/sxSgZmc4mQFuhSPsGwrTYvEz8foc7PXLgck3Y5KC3CqWjPecl7FNpPjyjoJ8/3vX0g/mCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/DL31WpDDz8Y8BtT2NqCqy82cK6TnYpnMr7lGwOdK6WSid+Q
	1L1FW2ZQkXf0cGQShAYHHm21anpqBcGe+d8PT79PRLIoTye2iBjgFSE5ZzRRh/WZERqZYjmRPLC
	lKrf/fUHcHLHufXKYRf3bSaf2zNhttTELULeMgneEKg==
X-Gm-Gg: ASbGncvghXdVJLm31k2uwGfXd+A4g4YvSImb+ljbWq9uO7XG3YP4A5ZH02Ry+R7eaE4
	j02glcjEiJYdNhOZqAWOoi5wScvPB4fE4Pw3c3YthMnyDt6/JGWQJhtPGuCgu4gLg85oW2/E/Gm
	KkPJiu8YxVQmeEvSxRnZGsIBYB/EslOSk1rzZ3ytl7kUbvi2Uggji9CHri5e6vroEfp+NZwRAxA
	VPMXuZo7KhjNet5nA3vtMF1QAs4pNzskbyTDRT3tkZVuoqew2uCg6bighzV0rA5OLeWCsFudZsq
	TQYQh9K9NIqTY+r3+w==
X-Google-Smtp-Source: AGHT+IHusR3pR0UReEeTXHeTWS5omMas6c+gaYiIEsLmjRg06Miw4AMQcuQX3fi9PVgOyyAmpc1NpRtLuc0jLuFpHKE=
X-Received: by 2002:a05:6402:4504:b0:63c:103b:e1cf with SMTP id
 4fb4d7f45d1cf-63c1f584283mr30192670a12.0.1761406840700; Sat, 25 Oct 2025
 08:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <6-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <6-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:40:04 -0400
X-Gm-Features: AWmQ_bmCjfexrZLPPfdt56XAonJ2DbSa1CpJkmBpIfIxbAsyN_ouXa6sCMuBecc
Message-ID: <CA+CK2bDZ1RX9o80x2+HTshix0zxLcruzDfW--NMS8CjWo1PfUg@mail.gmail.com>
Subject: Re: [PATCH v7 06/15] iommupt: Add unmap_pages op
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

On Thu, Oct 23, 2025 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> unmap_pages removes mappings and any fully contained interior tables from
> the given range. This follows the now-standard iommu_domain API definitio=
n
> where it does not split up larger page sizes into smaller. The caller mus=
t
> perform unmap only on ranges created by map or it must have somehow
> otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
> scan for them)
>
> A future work will provide 'cut' which explicitly does the page size spli=
t
> if the HW can support it.

Are there plans to add "free" when a table becomes empty on an unmap?
Not sure what would be an efficient implementation for that, maybe a
refcnt for # entries in table?

> unmap is implemented with a recursive descent of the tree. If the caller
> provides a VA range that spans an entire table item then the table memory
> can be freed as well.
>
> If an entire table item can be freed then this version will also check th=
e
> leaf-only level of the tree to ensure that all entries are present to
> generate -EINVAL. Many of the existing drivers don't do this extra check.
>
> This version sits under the iommu_domain_ops as unmap_pages() but does no=
t
> require the external page size calculation. The implementation is actuall=
y
> unmap_range() and can do arbitrary ranges, internally handling all the
> validation and supporting any arrangment of page sizes. A future series
> can optimize __iommu_unmap() to take advantage of this.
>
> Freed page table memory is batched up in the gather and will be freed in
> the driver's iotlb_sync() callback after the IOTLB flush completes.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

