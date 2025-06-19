Return-Path: <linux-kselftest+bounces-35349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0DDAE018D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEF3B0F30
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F127A446;
	Thu, 19 Jun 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dv7WycaE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBE279359
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324485; cv=none; b=K1mdcauuKvY9finj4sHdUTBxdSVkCBxAo+qCIMRNxAsORVAbWQP8e0v85h1juqccQWPA4232/oNkiP/wUwi8JBCWyo7cGxKDch5HclReGib5oWypbAQYGzVAr7Bvjq+2NBASydQDgsxxNTNWNwH6JIoZNk3dJsR83mdpx5VBkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324485; c=relaxed/simple;
	bh=oskZaqewOdI9Q2vgMTv3V9kHOUv/J7lvDhpMHUc35DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T57nVh0J/nsUI9LXc1X/vWh6nmzBKUqgx4SYMOdd55K0qq35kF6kTrjKD+qMmqtVfZLI4gp6D+F9xgRCKN/r0LDrWMe1g9Vso6vrxbs3/ImC9Ip8PjC9+qVuC498gEu+0esVPAW0tbPcN8v8N7eCAIbIqW/RsPPho8u8c6lW/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dv7WycaE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2357c61cda7so88045ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750324482; x=1750929282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWamqH4Qzt1P4RdD6HP7YstMpMkIZRoPsNcDiTnzqKM=;
        b=Dv7WycaEyXueQqTKSG90D4rovykObav7TJQAiW1sEQx62haVBoBiKX3WPYyRQBbGbL
         8hZQXnpKZanDb5N1CltTayyBnZL1BJQFHkD4g/0176tSaXpCkvuONuc96qP6MNWqXh5r
         lTPO192S9TTYxQCYs/ux9DTLUS0k7TyDDONPZPnoa68NR9CIPyEQHkTtVKD1nrSLp2k3
         TFRNJdq0uTJQSHHiHWXKeGSL9EHLAIMgm8zIfcYh+YGyaHCDakyBqNIsSSWgYGRcZKCC
         RcNfpO84uh0nqkK5B1uERm1X1RvUbC2bpLnBkrRF8TPJiUg7AK1LuGYqQeW8FEM+c579
         9Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750324482; x=1750929282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWamqH4Qzt1P4RdD6HP7YstMpMkIZRoPsNcDiTnzqKM=;
        b=i7WFGMbDwSISaDoERnSUHlgTlogStioW7IELHKdicqCEGn/pzsyZs6Fpg+tVC4UZa+
         yxKSMwDb0VFeT5DMlnZhRXZEsFTXpEkNt/hkd631zwS5ZH6fS5x1L8o7GzfVmv0KQ4Dq
         cIQn2UQmJm3lKLfc0A6kbM1vg7NEFoCKGsxsX6ErxKYBGvHiN8Oax4lFvypvf/tVLCnM
         VyXfiOZKAFpwdplWOQ70+uHRCPlwGCRawh4DDflTiKi/8v8xbicjChWZx3eStPOwfqJ1
         NmB7HTyogrJKz+pVQidxEgTZZuH5Cu0nhlNV5/liIKG++VvMgGAyy+42Vj9aeIlfkm0N
         ZrDg==
X-Forwarded-Encrypted: i=1; AJvYcCW7NRxAZ/5+9Ik1YKuKe4VPyjAQigy6rgTW+R2MOrRTPsZs61uIbFWk9NyUSPLlLT7QRAEaLUyobJkxN2iEwIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw384XYQ16GJqafy3hs0fLpxx9R86bK5bPFi00xbRmX1JT9lqdq
	sEcox4Y7aU0j7ygwf4lmR6ORB8FeWZEB9RGuso2TAJfDqxclGfV9ID6J6rD/5x1goA==
X-Gm-Gg: ASbGncszhvReTtkmCkjFoMg0dbgR4RHsbNRl0RPyUynavYmOd7BFkc69/3tnWP7qDAs
	Yo/XVVH0WxVPUSbFv51zAo3zB/I013TkLZHOTY495Nu9UnI6GxsYcM92TiqF8OOaOG7LfZvMuAJ
	3qWCpbuFKKypY0pd5/Ze9H8x9Hqgk7P/z80PVOunqWjsD6KVggwuQ+teIH26//JB69AaEJcABF0
	ky8fOPvfEm/NvtX2DAAZDEALxL0mhAlOnEoCaT83XbQ7Xse1vFjfF2VZwkaiuMFmM6SmT+/UOfa
	4weQ6RoL47EdfrKsr4dIn3rQLJQpLcAy4tB6MuuZa/ewdxau4W8gWAleIDUHPPy2aMi3s7aESNb
	5Qx8bZUaV9ApDy0Go4ILH
X-Google-Smtp-Source: AGHT+IEvh8ntAaeawSzvvAW9v54xfOai3SDk6b1VSkUWtSTdDIzpJHZdPCeE04W9I0TDOLd777OhYA==
X-Received: by 2002:a17:902:da48:b0:234:13ad:7f9f with SMTP id d9443c01a7336-237ccb4af65mr2441805ad.22.1750324481903;
        Thu, 19 Jun 2025 02:14:41 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c029sm114860565ad.26.2025.06.19.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 02:14:41 -0700 (PDT)
Date: Thu, 19 Jun 2025 09:14:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
	will@kernel.org, bagasdotme@gmail.com, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL
 for internal use
Message-ID: <aFPU9TKgU0Lofl-O@google.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
 <20250616133305.GB1174925@nvidia.com>
 <aFDRKEsdVZc2XQ91@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDRKEsdVZc2XQ91@nvidia.com>

On Mon, Jun 16, 2025 at 07:21:28PM -0700, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 10:33:05AM -0300, Jason Gunthorpe wrote:
> > On Sat, Jun 14, 2025 at 12:14:31AM -0700, Nicolin Chen wrote:
> > > @@ -1321,7 +1328,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
> > >  
> > >  	/* Driver's ops don't support pin_pages */
> > >  	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> > > -	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
> > > +	    WARN_ON(access->iova_alignment != PAGE_SIZE))
> > >  		return -EINVAL;
> > 
> > I don't want to loose this check, continuing blocking mdevs is still
> > important. Only the internal access should be able to use this
> > mechanism.
> 
> OK. So, it probably should be 
> 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> 	    WARN_ON(access->iova_alignment != PAGE_SIZE ||
> 		    (access->ictx && !access->ops->unmap))
> 

Nit: Probably worth mentioning in a comment that access->ops shouldn't
be NULL during selftests and hence we avoid checking for !access->ops?

If you feel it's too verbose, you can let be as well.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Thanks
> Nicolin

