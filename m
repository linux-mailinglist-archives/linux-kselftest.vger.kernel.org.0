Return-Path: <linux-kselftest+bounces-27515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A708A4498D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4408636A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EE720C006;
	Tue, 25 Feb 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuL96jSb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598571FBEAE
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506395; cv=none; b=Atj3aBD8N96BdOJ7HEhS85GSSZsqo0vVp1yjCxM04x/tcsDbv4CimxNKUbcLiSYMt7Z8vaoUIE1LMUzkv4RRwfQ7upBLmJWPzBQNN+ucRNKJVwfz/CObptt3h8rj2cMgAyMz6P3xw3MgyYfWeyvYLgy1XN85BaPGf5RJtmS4458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506395; c=relaxed/simple;
	bh=t+3/xgTztA90riGckbgrI9IzG66KkbXPYhDKFDRxAeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnqt5QYvU8CFjUJZeDyqyAaQ0EJc9hpGrrKNU3yWOl8JIYI7ptUSGJc40w7cql16Wp4aCKJxh7HghzJDrVb5NQ6GniNEPXQpRoM1hstTnurklk1nfb4qVPipq9fryi/kDWwj+xqWES4PgYWsD6IrfJmXHrceMYmAqO7Cf4ImKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EuL96jSb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-221ac1f849fso3655ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740506392; x=1741111192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zet+c1c4ONj7xvmenDNyn9l5ztIYraYudvekwtRFR4g=;
        b=EuL96jSbDAd25L16qFsOdYafktXepV3jB/EwvZHTHfcwGBFQrsz56rYMMmmxKJVGkr
         ulcf+FZSW7aycHtGq3HCGJpMIPxPmZWSa21wwihB9L9ePlpWzMo/yaUj71NZYqIIr6fy
         6n1c6qiR635r6M8mVbH3THSLsE1qnw6ho9hB1ICNCWd9bcpDBlgYAA4UW85o1cqa2sFF
         b8dhDYeXI2lhJs2hojov22fkpHvJMPIB58H7gUQpiwjff8LS0S6KPir+0Rs/KmWtS3A6
         rnzxoER08rxh/8uDs/Dto6Gyp5Rv0Cqdbtd/ViS5lZMulIF1EiIYvVfCBRltMjx5IbDv
         fWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506392; x=1741111192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zet+c1c4ONj7xvmenDNyn9l5ztIYraYudvekwtRFR4g=;
        b=wmBbTG4ypD5zg3x+V8tmxJ8qHVsJ5ohUiDoPXwgTWDc+VS5lNCMWpkh9f2/Kj/7ahj
         xAexIUff2x8ph1EdVxtPVuknTomP5KeJGW9ggL/iQcI/lghkjREp7GiDbjxvXZjpW/Nu
         B0iEijoVAqIWKPKeh4tGPtpB6QYB69Bvn3fD80lyMq+S+wGvEEhJeYR0V5lWNmolicDb
         0fXx5y/b3KyuWsqtCWyzfbXgXB9OboQ3EKbW16ZBbtxpnM5TuDtVn7OiKMlXx6Z4xexU
         exKAO6/7md7DLW/9+4dyJFriNA7bTLS4CTVrxSKnVROxmoclpD4UEXGK6H5bFvtJXIpn
         VBAg==
X-Forwarded-Encrypted: i=1; AJvYcCWm4MwEGdHUYrU5DIRwU6xBn+ZZF674eFMUR8CY16zrRncIq77yYw0kAq9n4T8XPdphZ8tht9fek/VqUP+iyUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgs98AClwLq35xcfVg2WFHPsJGiGcyzYdm3JfhGwb8xuHFKb7
	stpm6oc10qsqhbMyXij41LlcuinWYD68f33OACSR3XE1GyIgAaVNoUa1kS+I/Q==
X-Gm-Gg: ASbGncujLZqq/Scz8y47wl37PwkBmJHuExDpgTjXL/LSN+c9z83nYR3vbhRBjrsHHmd
	rAr+X/sLlJUaiJkXmLJfQU2c3zGJ4A85kGL5edebyy4DQWfMs8NshG0YymJC45iOjaGQAqpodaS
	tVPX3klJxUbc3FY79uJH9h5KZUSkt9gUJsqoWqaXD5mxlK7wKTDi5guqbAVifOiF0HSoljum92x
	Ol/lJVuD5KJ4WQ6ov/4gz2umXbWrd/FHjtRuuRNzrWMNPOnYXKdZMlBC3dFXbHtgPuSoVjZWBER
	MZHL5FchYFH1TDLGx2aDluks2te1Wkj7K9jxsuXQ9mUBXikUTz766HvOzdpIBwo=
X-Google-Smtp-Source: AGHT+IHt1jR5XD9845sVRfVXJk9oOqx4VZihn8kcHDN1a+U5MuzF3NMe86gHqr8wYv7wnn00ZADsGQ==
X-Received: by 2002:a17:902:ec85:b0:21f:631c:7fc9 with SMTP id d9443c01a7336-2230798c8c9mr3956505ad.0.1740506392319;
        Tue, 25 Feb 2025 09:59:52 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f8ec9sm1867028b3a.53.2025.02.25.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:51 -0800 (PST)
Date: Tue, 25 Feb 2025 17:59:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v8 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z74FDTtZkjwrjv29@google.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f465dd9defdc0fc748c2fa2cfc829e37778a4ced.1740504232.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f465dd9defdc0fc748c2fa2cfc829e37778a4ced.1740504232.git.nicolinc@nvidia.com>

On Tue, Feb 25, 2025 at 09:25:42AM -0800, Nicolin Chen wrote:
> There is a DoS concern on the shared hardware event queue among devices
> passed through to VMs, that too many translation failures that belong to
> VMs could overflow the shared hardware event queue if those VMs or their
> VMMs don't handle/recover the devices properly.
> 
> The MEV bit in the STE allows to configure the SMMU HW to merge similar
> event records, though there is no guarantee. Set it in a nested STE for
> DoS mitigations.
> 
> In the future, we might want to enable the MEV for non-nested cases too
> such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
Apologies for my spelling error in [1]. It's supposed to be:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Correct spelling in [2].

Thanks,
Praan

[1] https://lore.kernel.org/all/Z73zvIbsXzJMCaNt@google.com/
[2] https://lore.kernel.org/all/Z730M3XptvDRObBp@google.com/ 


