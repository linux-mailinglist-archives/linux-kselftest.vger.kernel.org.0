Return-Path: <linux-kselftest+bounces-31919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ACFAA18D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC84A3BED82
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C12528F1;
	Tue, 29 Apr 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQhkbJJc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578031D7E35
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949585; cv=none; b=dYu+/EIEagc0AqCezCWsqtpn0i7VMrNM1V5me7vs4DEKlZp/d9gu9jlKGOU21pepeZRFsjCZjeXZ7i6P7IrgS9Emwfz7ScW6SepTng+j11zo2Rl/Bo90Srl1fONaG6eM4B4M+7BTuTTE3njUuV1uP+4+SRoKAlqn+n5CPHCeZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949585; c=relaxed/simple;
	bh=d16RAGrhUAPMnh/Fm7KTz/flsdV6DTvv/njmBuuJRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+np/1QF5pjzbGqjAtN9KveJ9EQXBag8fNit/yd0XR3LATfT+A50niQjupg5tM0Th3ml+4OWJHtK0yWSSHaVAp0CswH+NQWqxs8jo6fV0owdlcVfWcwQNS55jOFuwx94j0YpkE/18VuxzpSCanuMJeFIlLDoNigoxfnpqlPMwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQhkbJJc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2263428c8baso46925ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745949583; x=1746554383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZWx5YzsE6VtBscW7jSSrryOsxFdJT63HSkZNADS7Hs=;
        b=KQhkbJJcGzLvo1uHbQJNFTjX5nhmx2MkqHc+/fEI+SDQVhwDDa4aJuzYG9YAWMFDXJ
         3InBM0/0JGUBs5PC4mgxAWiSJb1c36oWfDT2ew1I9YnxDL2ZTQ8zD1pWCr9L71f06lwO
         ZtOCWrpF02evC1mOVwaVLJQfTUEggPBHko60CWuu5ubPmdghKJKpf1BRd7lc2menlw9x
         jad+/NNqrIGVDq1fU4Li03OucZdSZglhuerrOW0mcPEa7y6+mp8JDQ5vWkB8IvC9cy8G
         MOjeGIcPEZ41HYpI+Y/vSgX4IsmyERs0orBdEo3ybUpPXXE0SyePg6/Gen8mnxpp4fM8
         r+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949583; x=1746554383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZWx5YzsE6VtBscW7jSSrryOsxFdJT63HSkZNADS7Hs=;
        b=AE5noJUq3yA6W/Z+1HXxTsWXf7tzOuoG8xpymKW2Hcwbp8ohfjWvdv8FHIa6/ktUPw
         JKEbo/HXfKQRcyeoJ2g2tVfy5LPFuzJENx59Bu954ceDaGEFWK76V728AnzHf4tITCt9
         qAoCLGIsAnBL81RBQXeB4AhPLlMr2NYpa7STsNr83LoLcojpNL/2RgcyKgm3BtCZ8geE
         oUKXe/6SA68N2GZpYpVWoUrsCyzSd88JC3y5TcHGYMJ++pjKlgyhZYi9yI5Yng2p2ZtX
         TSrWetgL77q3jL6P33fuzXv5Z5cu8iqMoKKSmAaIwDaZkheATOvO/84j2J86F8iJJhFm
         RnYA==
X-Forwarded-Encrypted: i=1; AJvYcCXEzMWnoJGjgPa8SvzRCdbxbfGyJWBGMvUA0xECaoaksUtVTqAroYgfFcowiaY5Awq8HzDKFpmdrQhMEdqXtD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxC3qfvNRaTef757ROU4VxBRd23fFeRgHFX6PU935c8miu4HZ
	UAO2M5W2ad/eBOkI/j47b5Ky9fGwBx+2+dKF5eI6HctKOu/leoo9daM6LnxMQA==
X-Gm-Gg: ASbGncvw/fX6ItTnNeGnDqo9ktGLTcP16GaUkDR0IHfUwq13ntXWWHFOZZMutF53+cj
	cGCTobTGj/bs4/WjV9ATz9Q/ygKkeevsYezHfZQKAyLgdVF1YMJ7MXNyb0Kh4ugkOC6TZWrpf7Z
	DXpEsFQJ7BShudCR6tA5mQzq3Xxx/f3M8mQ7brSngrmPPSL2P6C7ZugSuVrp+whzLq3FTRGUOcH
	hZU3YAh57OfeSF18w+e9+RKmLfEccJYr1sbs4mPrbjtARl3VxH9mWYNVm+B8ODo3LnqKIn8Tv6c
	a/xh+WBo4rwR2fYRVdofpTsFq3iHBs01mm/3nf+HdHfDQDHsi0qFHSQ7QYN2nFbqAnnII7zm
X-Google-Smtp-Source: AGHT+IFpQWcmyzP1N/TbZRNb1gatjkwbbsmgC09afTOnO3GyWImnhX2qlaIfI4JGDZZ0CTRg72ZS0g==
X-Received: by 2002:a17:903:2303:b0:215:f0c6:4dbf with SMTP id d9443c01a7336-22df3fe491emr117295ad.14.1745949583190;
        Tue, 29 Apr 2025 10:59:43 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db510272csm105625315ad.177.2025.04.29.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:59:42 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:59:32 +0000
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
Message-ID: <aBEThP2Bn0YDgXfu@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
 <aBDIpz7w8wxIn_AF@google.com>
 <aBEIBKdjuecVHgpU@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBEIBKdjuecVHgpU@Asurada-Nvidia>

On Tue, Apr 29, 2025 at 10:10:28AM -0700, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 12:40:07PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Apr 25, 2025 at 10:58:06PM -0700, Nicolin Chen wrote:
> > >  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> > >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> > >  				       unsigned long vdev_id)
> > 
> > If I'm getting this right, I think we are setting up dependencies like:
> > vcmdq[2] -> vcmdq[1] -> vcmdq[0] based on refcounts of each object,
> > which ensures that the unmaps happen in descending order..
> 
> Yes.
> 
> > If that's right, Is it fair to have iommufd_vcmdq_depend/undepend in the
> > core code itself? Since it's a driver-level limitation, I think we
> > should just have iommufd_object_depend/undepend in the core code and the
> > iommufd_vcmdq_depend/undepend can move into the CMDQV driver?
> 
> The moment we added iommufd_object_depend/undepend, we already had
> a blur boundary here since we had no choice to handle in the driver
> but to ask core for help.
> 
> The iommufd_vcmdq_depend/undepend is just a pair of macros to help
> validating the structure inputs that are core defined. It is quite
> fair to put next to the raw functions. I also had the notes on top
> of the raw functions suggesting callers to use the macros instead.
> 

Well, yes.. in that case let's call the macros something else? The
current names suggest that the macros only setup dependencies for vcmdq
and not any "two sibling structures created by one of the allocators
above" as mentioned by the note. Maybe we could rename the macro to
something like: `iommufd_container_obj_depend`?

With this nit,
Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Thanks
> Nicolin

Thanks,
Praan

