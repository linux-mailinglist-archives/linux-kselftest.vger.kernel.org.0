Return-Path: <linux-kselftest+bounces-26891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55EA3A527
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799C718926F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43517A2F7;
	Tue, 18 Feb 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEDDKPwm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D628137E
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902650; cv=none; b=CaLR0OCHisdfoJWgqO4CvxcJxNC6c5kz74kNoqmOnLORIXQtgLCRTERLKml5esSLFTSHz51tyjZWGb7JwzSN8lk8U69UwHYsJj3fLguZ+nVjLULhLWmrFd9c2Sy0wYd58e7SrSckLWoaRaPMvhzrukFMiOu9qA1kWPKxper/0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902650; c=relaxed/simple;
	bh=BOUyx5EsWWjCZqwoILlVSGflf8blEnkgIikzItCUqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1GLD6yByPAJLDNi44sa/5EkTVQcXJ2auP4cFR0PzE6BFjALIzsRh41RiMfZKs5gt0/z3wsDcoC5s69bot9EWoh5p8fZVXtGgm/w4Rl1Hp6aanaOTy14hkfAeiNR06s8e+sbQmIl3b+5DzmULmy7MknCoTbCXDMzhJ3EaYCyWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEDDKPwm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f6ca9a81so492685ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902647; x=1740507447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M89M9SRzWTrfxkPQChi6cYghdfRxV0Kb26Fn5pPvW98=;
        b=IEDDKPwmsCnXzgsxU9UFmcPy9nb+59LDcji7VEN+uObYIwhYLLVTegfR4cPukphh3i
         n26LIz5uFbOfM/CNOEVdgY4wc+WQR/0qKhZQKofkElSAsQrxpASu4a3Mm1l7JKF3mmDT
         s/NQ2BIxdDPNuCxdxg1g7iomKKMTBrPho1/0geaO1qyOtRU2lhMQTVJf+XvQLCh6bfJ+
         JLqpFqvteKZlzmUfHQ2FFM4npwJoSf3EFM93FUNU9T4II+4/eFE0eCPZF1+11hUGrKPK
         UcQkj1neNFdFBgJQfaNO635F4y3UqCvwiTx+nyUw2/RAme0lKoGug97pV1DZ7CuAWt8h
         Wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902647; x=1740507447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M89M9SRzWTrfxkPQChi6cYghdfRxV0Kb26Fn5pPvW98=;
        b=xRBiDQUiCbbhYgO46WibO4jddXm1aZmXMWSDoALRzQZy/RVaUouBy7csyTbPNU1UPR
         uYFWuASmGhC4JZsvbj9kOVN/33lSy3s8Y7PsmhlRHLF6fqnGrJd9M4+4oQVs1DPS7sd7
         KQgOQn4GD3NsU6W8GfjcwUSnPq8e2yPYm+AwwQIv/bCFiv/eIgDboM9ticY7fkgia4qG
         oYo3pssvZds9Of9Fn+aQJWRVi0IYBIszuUkalK35ZSeFOlQa8ktniEXxK6wSihJbvGRU
         E9YY+W5GiUqEDKIgN6iYpuKFstJrIzP4VVG9Dcb9NUZzbl378sBYzUTCUe4pKTg+6doT
         hDXg==
X-Forwarded-Encrypted: i=1; AJvYcCUimrxRXI7tsACsUAMhLv6P8NBo4TtxVNjlINf271kNbZZqAp+KkXNxdktUxT63yLA/W5wk/rBxbKn1otWnTvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqfYSIwRy2HEVG2fa0gJUzlZ5wnuqTfHxXo6Hv6iwpC4lCI87
	diU7bv3ZmPZK7uHwPdSpyKIHRIe8Yv9eSQ13OheAFee171B1GDu3Pvs+p8hpQw==
X-Gm-Gg: ASbGnctxlFgwM/JmF/3c3uyMDiRraFQdZ/Y+cAQ98CC0ebHVwf8U8Tn9ObUjLARESwX
	Ug+qTMO0swkFaxPrFKOdJW8hVeF3utsQ/QXoCK2yWI8fsuv/DsEXNeOb4I9Du5dMu8JdEJAbKFJ
	wDSJjuVpAGqVrL5UkzA8j63RMxs8vw3R3yO05r0W1jhbegUPA8rk0c3n0NPAxo4CXnOZplW8Ff8
	ExvynE13yuTMZ3sAnbZnY8ap9MZjRu/5POEvkRLHMyesyB0pcWaBJ+LdqBm2c8w2VTVFIYLu9D3
	lNMKEcUmeSkT4id0g+oPy07GAE+ebq2MwKbu7KWmwu8/bZ4HCj/x
X-Google-Smtp-Source: AGHT+IFkiHL5TTpaBclB/MgmM3kcQbDHYVWCGmPRDpeRclWjC4Poa8aWW8CJbN/ySGXple0OccOeRQ==
X-Received: by 2002:a17:902:fc4e:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-22104c939afmr7012905ad.16.1739902646969;
        Tue, 18 Feb 2025 10:17:26 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55960ecsm91516115ad.253.2025.02.18.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:17:26 -0800 (PST)
Date: Tue, 18 Feb 2025 18:17:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7TOq-gIGPY_ztW7@google.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Feb 18, 2025 at 05:24:08AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 25, 2025 8:31 AM
> > 
> > There is a DoS concern on the shared hardware event queue among devices
> > passed through to VMs, that too many translation failures that belong to
> > VMs could overflow the shared hardware event queue if those VMs or their
> > VMMs don't handle/recover the devices properly.
> 
> This statement is not specific to the nested configuration.
> 
> > 
> > The MEV bit in the STE allows to configure the SMMU HW to merge similar
> > event records, though there is no guarantee. Set it in a nested STE for
> > DoS mitigations.
> 
> Is MEV available only in nested mode? Otherwise it perhaps makes
> sense to turn it on in all configurations in IOMMUFD paths...

MEV is available at all times (if an implemented by the HW) and doesn't
depend on the nested mode. As per the Arm SMMUv3 spec (section 3.5.5):

Events can be merged where all of the following conditions are upheld:
 - The event types and all fields are identical, except fields explicitly
indicated in section 7.3 Event records.

 - If present, the Stall field is 0. Stall fault records are not merged.

I'm not sure to what extent, but I think *trying* to merge similar event
should reduce some chances of overflowing the hw eventq.

> Is MEV available only in nested mode? Otherwise it perhaps makes
> sense to turn it on in all configurations in IOMMUFD paths...

I think the arm-smmu-v3's iommufd implementation only supports nested
which could be the reason.

Thanks,
Praan

