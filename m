Return-Path: <linux-kselftest+bounces-31925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0255CAA1ADE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34F2176318
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D270253B77;
	Tue, 29 Apr 2025 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhZ6v0Pz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A925335B
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952264; cv=none; b=sP1S4k5aa2khaSfL9d8fYSZbDh51ZrQxGdLVGG2NGSmB+A8OUVjBYyh5uAhbQIaviVOiv96WJEXejR1cp0rVvbjqxQbQUCqI2N4MSJa4Yp4YcGF5s/qNd2flH77r1f9kAt3JqqYC0gj30hZWFAt2BmbYWKysg0cuzPAVEPPxX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952264; c=relaxed/simple;
	bh=Yd+fxjsRydFKjO90TX3Imy2H/CCh7glVFS4yzzIbM64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv0upAuBcMKRtxC2H5x99nWZC/IupMC3NdQ33KZKpc7e8bWQw12eo5wCXyts5/F72N7vyjUP1QdoSX7lo42Do1F7RdyaFwdxfX8LsCVnVLo8TcJHZ7oqQiL4OLRV73+Ez81mbop9XDlFOfzmyKpIndJnQbKzY666WZ9eoIDYlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhZ6v0Pz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so209705ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745952262; x=1746557062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbAOOUKsalrnyJTM4wor6y5G5I8sKroNDDc7YCgeN4g=;
        b=WhZ6v0Pzns9/1Df0oV/IzmpaB9n0Tbd8W7V22Kcq19c4VJYOxyR3wOrAZuJZmNxLwl
         4bwmBWA4yXIuXWlxrpSfEgMgbBWEu7+S5iQCkGILI5tH4YEJvGcKVY9jcIPoMsB9crTh
         uEDy+ar85+gPMa3fm8dHLSH6EtlHorWVexqlnkQdxRkeRZGGRqDDEg2zYR1AGObrRUNV
         BAzgtCJpAuVmNd8463azBWqHOFJpCtq7hBGosx/gruwQ24l5t/kCfwZ/3nBYg5F6E1Lu
         90un00opbWg1r+Tu23yN7YSFV5bKlUe0VppuCyGZrVtWgjaiLkwcnSa6onuK4fNroRf6
         9UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745952262; x=1746557062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbAOOUKsalrnyJTM4wor6y5G5I8sKroNDDc7YCgeN4g=;
        b=jJkj57Ym8mf6ni6uaDZG/I2/+gRuQ/16bOLI0dzSH81mORFYRodOr9a1VznOZ11Bay
         xi4zS1DLf6vBbtfpKTw/pPiwSM3JZ9w3psYVzM8Ctd9btvwbrFHkJc80/d8X9VPrDJhz
         DtVN7JNqnrV7vuhBmAdXvLMWMwFLVhW4mm1EV4iKBzEgNLX0hmp2MSCHgrDCnhqVQ692
         HOMXbLp0MFRJ673x3P/59jT/0UytGBgLl2LNs8Upct5MlCMTk77e3blhfPwl4sSXjhU2
         KO/eKUTpwCMMzEbVxTUwGKBrRd2xAuzOxInrFZ1BdVmK1zU7Lp5uTt3c0YHXdrQfSlyD
         p+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWmqiz+TYuIWjpzRif0L8ofDNUAuOB9NipC7bcLp6lpkrdsXI36R9NIGHR6rsSbTUr7dHUeV/DdyxbMfJE4Pcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNplkWYLD/GP1D2BD6w+WKJKGBwdnBZriWkssGNiDIAEIRk1AT
	cIFqFyfrfpHxkwc5HGNJ2pnoSp0AEQWf6SHubjrpYFEEGA7F3LeXTcq0+xF/pw==
X-Gm-Gg: ASbGncuZld0dZ+IZ8oFVZZN/ABB38nIqj+F36pkIB+djFb2xYr8Bxng8/8Z3iYZsPyU
	aoewGkdFhga1YdGYcIfL9gdNEuQZGQEbsp6jqs/hqCvqUVAmQCqWYAU+hvFFsqHUU7+30/6DMSv
	SM6r/z5SicO/83DtLfXqD9fVBBRpCv1aRBUn5Pid7RfW3SGOa/McEWQ0LZhxcSyDezAOLQM+TmG
	Hg36k6eW86HNg8G9B6iGyMEaYcK1ISiQuLPvRzc0Uwa0v/HfEneYZtF++OKtXk3c2ohh9/lAOXQ
	1pil4DHU5jRjjg/bWpy9qLh4tQaJoC4oViD29HmlF4+wqTvLckuB1DdROLgqzBmOrqXu8xOX
X-Google-Smtp-Source: AGHT+IHAAAZnrzfCTnyRFSrfgzM7EUKVTFf0g+y/q4rYabIT5b7Fav3BwFROBr2u073eUGpUmQ9SUw==
X-Received: by 2002:a17:902:d2ca:b0:216:21cb:2e14 with SMTP id d9443c01a7336-22df41fb4admr245055ad.21.1745952261334;
        Tue, 29 Apr 2025 11:44:21 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740399415bcsm362b3a.73.2025.04.29.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:44:20 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:44:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 11/22] iommufd: Add for-driver helpers
 iommufd_vcmdq_depend/undepend()
Message-ID: <aBEd-kacX84dkUuf@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
 <aBDIpz7w8wxIn_AF@google.com>
 <aBEIBKdjuecVHgpU@Asurada-Nvidia>
 <aBEThP2Bn0YDgXfu@google.com>
 <aBEVboMt0OtZmt4Y@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBEVboMt0OtZmt4Y@Asurada-Nvidia>

On Tue, Apr 29, 2025 at 11:07:42AM -0700, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 05:59:32PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Apr 29, 2025 at 10:10:28AM -0700, Nicolin Chen wrote:
> > > On Tue, Apr 29, 2025 at 12:40:07PM +0000, Pranjal Shrivastava wrote:
> > > > On Fri, Apr 25, 2025 at 10:58:06PM -0700, Nicolin Chen wrote:
> > > > >  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> > > > >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> > > > >  				       unsigned long vdev_id)
> > > > 
> > > > If I'm getting this right, I think we are setting up dependencies like:
> > > > vcmdq[2] -> vcmdq[1] -> vcmdq[0] based on refcounts of each object,
> > > > which ensures that the unmaps happen in descending order..
> > > 
> > > Yes.
> > > 
> > > > If that's right, Is it fair to have iommufd_vcmdq_depend/undepend in the
> > > > core code itself? Since it's a driver-level limitation, I think we
> > > > should just have iommufd_object_depend/undepend in the core code and the
> > > > iommufd_vcmdq_depend/undepend can move into the CMDQV driver?
> > > 
> > > The moment we added iommufd_object_depend/undepend, we already had
> > > a blur boundary here since we had no choice to handle in the driver
> > > but to ask core for help.
> > > 
> > > The iommufd_vcmdq_depend/undepend is just a pair of macros to help
> > > validating the structure inputs that are core defined. It is quite
> > > fair to put next to the raw functions. I also had the notes on top
> > > of the raw functions suggesting callers to use the macros instead.
> > > 
> > 
> > Well, yes.. in that case let's call the macros something else? The
> > current names suggest that the macros only setup dependencies for vcmdq
> > and not any "two sibling structures created by one of the allocators
> > above" as mentioned by the note. Maybe we could rename the macro to
> > something like: `iommufd_container_obj_depend`?
> 
> That's the intention of the macros: to validate vCMDQ structure
> and help covert a driver-defined vcmdq structure to the required
> core field, as we only have vCMDQ objects using them.
> 
> If we have use case for other objects in the future, we should
> add another iommufd_vxxxx_depend/undepend macros.

Thanks for clarifying the rationale behind the VCMDQ-specific naming.

On the point of needing new iommufd_vxxxx_depend macros for future
object types, I don't think that would be required because the current
static_asserts within these macros validate the container->member.obj
embedding pattern, not the struct type of the container itself which
makes the macro logic inherently reusable for any other object type 
that adopts the same embedding.

However, if there's  a strong preference against making it generic,
I don't have any issues since we only use it for vCMDQs right now.

My main point was to keep the core code seem generic to aid other
implementations in the future... today NVIDIA has CMDQV, tomorrow maybe
someone else would have something for vdevice or something. Anyway, I
don't feel strongly about this. Just trying to help :)

> 
> Nicolin

Thanks,
Praan


