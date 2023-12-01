Return-Path: <linux-kselftest+bounces-966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E32800D59
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 15:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4ED281B93
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DC2575F;
	Fri,  1 Dec 2023 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RydNWY3S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501A10F4
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 06:38:12 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-777754138bdso110949585a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Dec 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701441491; x=1702046291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=RydNWY3ShdLBfiklNm8Dqxqb+OQBGaFWZ8FG3cLe3fqBHCVohiDx0CCou5GDZgR7aQ
         DBcxY8pR6jXv2HvO1+mACu1KTgp72zLeGKfFy/qCqgp5y3ajSHuEPDFTyzxZ+kALlyw1
         F0aiTsAeMCque0+Ng4k/oSNE9fq37XeGa6U84VG3kOVHR/JgGphNdo/69LmgtcE7EaaV
         zmYEWMlpU2xQ2I2ei0xxqXDg0o5accz1wWpGoBi8kbkoLItVWd+HxiLB3JM3tuZ6RWKI
         z0y0aZe+cOU/sRQqdruVei9EDRDd+8TOFd+2/sk27Y6OyqSzd/jAZ5aKNSqn6M6aNoyw
         Jh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441491; x=1702046291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=oCFmnkgRTiHzbyrSXUlb6R1RABdncEkKXn4he3SIWNX1dWremMkydMDGQgZsQwGnT/
         MuFpOuX8Miq/OLhbsgdA1CjLDth1ardpW0zFl+7XiWnUJxdXvA+ZARd6yhzyU7RSQwtg
         LDdQZ4PBuL/vQluObS/icOrkiNvf4+dtez7roddrftD66cXs9NbDRTMsR88jmNl+0oy5
         n6k1B91Kp6DCKcPaGVjCIvjp7AcLo+7egV05F8kBMuLf7UgEf0LfChwG3Y3A/+p8B6bY
         dSSe34c+5aJ1FHVRs70Sxt84sliivgFTBT4tNCyob1+kCaMIHYlEL6Ag4jU58K0dbsaB
         ZHnQ==
X-Gm-Message-State: AOJu0YyaZJVYLtQmqXPfvlaIL/sqdv+vov/aV3e/C5APepHsNpWmqOFI
	iBHLGoU4yBe3P9ek9g5vDUzHNw==
X-Google-Smtp-Source: AGHT+IFe8E0VqRO1AEaToLaRVQzH95JILmWc2UsaE9FahWhPD0VYJtmSp9BHS2kePetr70qtmP4TFw==
X-Received: by 2002:a05:620a:c0d:b0:778:ba89:2fbd with SMTP id l13-20020a05620a0c0d00b00778ba892fbdmr22271407qki.36.1701441491386;
        Fri, 01 Dec 2023 06:38:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a110100b0077dd463da60sm1533049qkk.126.2023.12.01.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:38:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r94eg-006FYA-Dl;
	Fri, 01 Dec 2023 10:38:10 -0400
Date: Fri, 1 Dec 2023 10:38:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu: Add iommu page fault cookie helpers
Message-ID: <20231201143810.GK1394392@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-2-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:25AM +0800, Lu Baolu wrote:

> +void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
> +	void *curr;
> +
> +	if (!iopf_param)
> +		return ERR_PTR(-ENODEV);
> +
> +	xa_lock(&iopf_param->pasid_cookie);
> +	curr = xa_load(&iopf_param->pasid_cookie, pasid);
> +	xa_unlock(&iopf_param->pasid_cookie);

No need for this locking, the caller has to provide some kind of
locking to protect the returned pointer.

I'm not sure how this can work really..

What iommfd wants is to increment the device object refcount under
this xa_lock.

I'm not sure this is the right arrangement: Basically you want to
have a cookie per domain attachment for iopf domains that is forwarded
to the handler.

So maybe this entire thing is not quite right, instead of having a
generic iopf attached to the domain the iopf should be supplied at
domain attach time? Something like:

iommu_domain_attach_iopf(struct iommu_domain *, struct device *,
                         ioasid_t pasid, struct iopf *, void *cookie);

The per-attach cookie would be passed to the iopf function
automatically by the infrastructure.

Detach would have the necessary locking to ensure that no handler is
running across detach

Then the cookie is logically placed in the API and properly protected
with natural locking we already need.

Jason

