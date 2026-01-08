Return-Path: <linux-kselftest+bounces-48552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3499AD0595C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 19:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D21E530499F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549C31984E;
	Thu,  8 Jan 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mdplkM00"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219E31326B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897224; cv=none; b=CpsfO29WdoesQxbawz+/z6bEiVBSa4WezohqohX3fqe0UCR3UXLNlDZMba4ky58sAlfShAVxA6nOeUjX3yrURa4fHLks6sbZgZcPyBM9bGY/MMvGptNSzcgu/fTqBbG1hBsQSXdKnGUkegnHnT8Sk8zp/gM4QwPDqirYxeruBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897224; c=relaxed/simple;
	bh=friVe+ZjDGl0vJha3E5L94T8EUtcvl8xY3GpjIuxSMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfm2zwDpHn6b0dmz5nnN3jzU1U1lo45jO7VaGnr7HDlB7zHre3uywk/g5CTq1Kae1zINkN8EqhS7lq5MwMpOdM/bGtRmcMyawkUUpuD6LDJqNPUrNx/GQxeljBSO4iJnZMns1s30NEvOrG5+ivp6cQ4HOrR+x6icP9cV0l2eqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mdplkM00; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8bb6a27d390so227430785a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767897221; x=1768502021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeDbCR7Lw3XLjb0kHArZW/oJZIOc8ufadN9fvBnzpPw=;
        b=mdplkM00FTtzMNdw4W2AhXt1dihAiMJcdr80l2u3xXrtq3Y4CchWzA5BaxDdIOnqvY
         K4hFFDpqQ24zbZTGxM/h10hEKD76drJH80UZDwueq3aMhRvqZojt/NGa2noknnH2AKcM
         2mwlIZqzjdH3K61O/z8S+42uXAG8aXOI0Q0LBAq+7up9Cf5qrsRqE3QPmP2MnSoOi06G
         90QsytLCcTOQHKlHu7qVtShpakHPkvRFDqKgfr1vU1AXYj1X0l+Oqn2Sj/8P7ycyLggo
         prymzqAdno/8te1S5QGeqp2O+SGBwTgK7u8asJj5lDObmZDYHkUulToO3wfy6A0ITz0G
         LDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897221; x=1768502021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeDbCR7Lw3XLjb0kHArZW/oJZIOc8ufadN9fvBnzpPw=;
        b=BKjJwsZtBuk/BngbaG72k7FbSGd06Vwqxy3Akq0LzMPwNhPW/b6x2Dz5rzi3ifK7lT
         WJ5DvVfM2Rc9jcc9VxZKTYmZ6EYzaUuTvpbkF+jyiZt8QQWHvP2XoB16U/iqqy+n0six
         ijBb25NiXjQaqx0WVbV9UGtF6YltiPRn43IPIAJDxZwS6AKEZIaJ0ii/C1iVIFikb5MK
         5n1aI4w0pllYCPBjKMbDdcIjS1WzmDhTHirh37/NlBtb/zI1zVEq7Md+KPVOoAiPJFke
         REFRANyqCzUMSFBM6wkfO+cYUKEw+DWPifAICIksvLJQvDgtoRsCerPXBhu3u8yXLF8x
         iC3w==
X-Forwarded-Encrypted: i=1; AJvYcCV5t4BQWNc3VXrqi7L+90AmQD8kr2B5HDmWj4qValdjMuEN8nxqvmpb46EC0ActX+ryRWeugdnTfIrDdQevioU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPL2GADfBvqQ9Q+ukmjoZKLpG6REO3W02yR1VjP9yf1eDvN0q
	XCifZ/L6rMepw6kristaZTIaWMjfITRk2NCrv7XjJDeHKyX4ZY4O4+uIhac4H1C/oNQ=
X-Gm-Gg: AY/fxX4tUtUai1IEaDwXML+bjK/asmRN8Pz6+IKr0DxY9CyjHqQ9SH7da1QaxgA6v12
	SAdVTQ5gX7octbELLhmP0gaVwVWmkccYSqZ96Nx2nSecoU8mFPncb6jH/YoAm1loy8Se+lNFQeS
	mv39hT3iDB00QYtqbtU8ybkjWfiHLgTuPRM+UQ6m73vzrQRxp66LQxi79QYzpZ25Cxp31kxg9TB
	6KrYDzLY7PE/kAzZt/9x6h/UL9iq7vLEMwn0Nap2r7zLPBy3mrYUROcUCAGd5cuzTHAOH3VQhSu
	tedheCAlOxLJpiv8T9cc9laJMO7EpnMXRoqFDyhkrHdRAmxUWO0x3qnSJXJqso3Q9SvXz6jCn3L
	zPkIKm+I+3P66hvj5GxME3y6nNVSqApLEvQAZr8UVSj63BJmNVAwVos6DMQn/S40EaZapr5e35X
	Ms0Zb3kFWIJs06kf0tgPp16aoJBQQMvFBB9ad4OY8D9sUmkMKVt6d+fayJYIsJAZ1Sew4=
X-Google-Smtp-Source: AGHT+IFvxaAGa9/1YlHwiUC0+rcyB8Si3/CdOHpRzOHE2IQYwWhD7wqizXJ2yXbaQu7l341Mgk8JvQ==
X-Received: by 2002:a05:620a:7001:b0:8b2:2607:83d5 with SMTP id af79cd13be357-8c3893fa385mr961645785a.75.1767897221473;
        Thu, 08 Jan 2026 10:33:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm640455285a.26.2026.01.08.10.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:33:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdupH-00000002n7A-3fMQ;
	Thu, 08 Jan 2026 14:33:39 -0400
Date: Thu, 8 Jan 2026 14:33:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260108183339.GF545276@ziepe.ca>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <20260108005406.GA545276@ziepe.ca>
 <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
 <20260108141044.GC545276@ziepe.ca>
 <20260108084514.1d5e3ee3@shazbot.org>
 <CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>

On Thu, Jan 08, 2026 at 10:24:19AM -0800, David Matlack wrote:
> > > Oh, I was thinking about a compatability only flow only in the type 1
> > > emulation that internally magically converts a VMA to a dmabuf, but I
> > > haven't written anything.. It is a bit tricky and the type 1 emulation
> > > has not been as popular as I expected??
> >
> > In part because of this gap, I'd guess.  Thanks,
> 
> Lack of huge mappings in the IOMMU when using VFIO_TYPE1_IOMMU is
> another gap I'm aware of.
> vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap
> fails when IOMMUFD_VFIO_CONTAINER is enabled.

What is this? I'm not aware of it..

> Is the plan to address all the gaps so IOMMUFD_VFIO_CONTAINER can be
> made the default and the type1 code can be dropped from the upstream
> kernel?

This was a dream for sure, distros can decide if they want to continue
to support both or have an option to do just one.

Jason

