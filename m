Return-Path: <linux-kselftest+bounces-48962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6374D20A93
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6123D301AE33
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BB32BF3D;
	Wed, 14 Jan 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyikEMag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA7324B1A
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413143; cv=none; b=IqPYFA4S+/MC97tDOAkrakA4RIpgvq1fEOfwPx4d8b84QOZsg1s2zlPYKD9uaDljWhTkhymTE/bXdCPS74Drcu6L5A5HA7BkKBx3Skk04FlQjukLHNIO+EjZK3ROZyWy4QYGTNTT/vTQuGTFveG5Y1FjNuYG5dEIV+iwFAVeeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413143; c=relaxed/simple;
	bh=s8UrTc392o6lgGr0L0SSPIY4h/zvAKey5JF2ZjeBBA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxIk1AKyLyTvxb5nH/IWyFfsty2ZEY0kTf55YNSJwnbzSVUiHi50KW4pDVbAyP3RGQXr3tM4GCOWFP0/S3mxn2wvJKMB1dS8uFSZv4TUncV3b3CjUiZo9Zgwg0P1hrMWjvwfLsL33ekLFS5kCmtEDlJguLojJkEBHOR8WT+cBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyikEMag; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso1734a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768413141; x=1769017941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmyLXiVJv4yYyt6EQN1fkH3Mxfa9cv7lABbhV6MoYwk=;
        b=fyikEMag7Qzv++PWevUW6btBPcVLKL3VAO+vnZQnHKvTLM4fKtAYy+Rpurwn59/vCL
         DDKuS45AdONwBkohH5r9SiQ7EiyZiIm/jMwCYFtTjsdLxZ+2VsL5eLr/BAjgRSPWGEum
         aSJbPtUP1QeovCF8fi0NNNxAG/gWme8uK0z9UQa23yAUrx/3oru3NkYL8kVVU7qkjbYI
         yPoxpN725g1h2/hVyaqwSQm7IFVzlovZci6TfbS174DJ+TP87QdvNmzBtWd2K8GqrNmJ
         q1XrvjfzrVQq6XGkBJlOaQ5ivsd+Ku6ZutrUZzKI65x0YJHbpbwZm1bJkDh0drmIGH2D
         cOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413141; x=1769017941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmyLXiVJv4yYyt6EQN1fkH3Mxfa9cv7lABbhV6MoYwk=;
        b=RZykcNQzslpZhHjfO5zEpxrwvaBeoA43nZtQqYFo4tmYtEr0NVPZ/CEkDI6ghyOeFe
         F+udE0suFdYNpvsgFks1BI4yMs4knMgQz8sXAerRzPs2XCvNxgd2k96novUTEK4AFijP
         9VUdywHKYMmICpXMf9K83TrWsDJAu0MKnBO0FvqjdgMudIkdhwWvcPeEufN5thKTt25P
         SL6SbKk1aMOSUga/1aU6qvJT7U4qkkKR4+cZgU3hU0xNccULJ3pYSNnFQkcmu76GhVaj
         ZZGezCaTZanwC6RDOTDgQf20uzpD+IGvxzUSp4xv11eJnzYXz74RSOOUG24MwSXnLqA5
         yXHA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Up5CKipWErclv+O62QVLJ+hFnIXQQqpSQUoP4G4CLsWVzrN0cn/KlCoe5jqrausVMY+ROzwlPRExA+XNXbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOOt0TlszOfvDbSHlj7Jpwd6q+K2cMgg1bVMCU6nsVWcCx7TD
	TaqmLz/9V5ezSLzhAKDb/vnxz6tUBKJJjY1Q9SIl4ISb/UmgIy67Mb6GzbLGgxMGfQ==
X-Gm-Gg: AY/fxX6DVFZu5J0hspuEudbqkz4CevBKcNrO66ezxeJpuvNW8qGQfBfGt3nDVdL3CiS
	pzrw482CWsJmsGlSOApdWBo9jhZothgVsryd3lGve5zhlf+Z6hIu6dLO+iKewfzDkGHXrAe15YZ
	kWJ9XSXAV9seezvbNpx0ZzyxSLdhJu8gmtp9wPop8TQIPJPVy5xnVL7KccRbcKe2veF3cCNT1f1
	oZVRrq4LdN3liklJSOpuhFBuRG6Z4pykxMFP7Wni4KOSFB6j+dG/fpow01Pt6N8VYFupwZsIM8i
	fBNjdlRIY+RbkVcUzIyrlz2zEUiCqPHACeBS+aZsD6tkut0e9AGEVHueQTh0Sl5AiIsoqOuwbuD
	qpZlt5HbbBLz5r2U5Ous9v/wvKe/QpZ+7uQq5sYlDkgLWD4y9wq1VH+HMd3AFIybiafzuURiRL/
	q9g4ERVfUKQ/pk0ufuMGjnCWI1ezFkAunai6hi4gnS4pDC
X-Received: by 2002:a17:90b:388b:b0:341:d265:1e82 with SMTP id 98e67ed59e1d1-3510b143697mr2850122a91.29.1768413141066;
        Wed, 14 Jan 2026 09:52:21 -0800 (PST)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678af465sm86170a91.11.2026.01.14.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:52:19 -0800 (PST)
Date: Wed, 14 Jan 2026 17:52:15 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 3/3] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aWfXzwN4RCSsuF3u@google.com>
References: <20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com>
 <20260113-map-mmio-test-v2-3-e6d34f09c0bb@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-map-mmio-test-v2-3-e6d34f09c0bb@fb.com>

On 2026-01-13 03:08 PM, Alex Mastro wrote:

> +FIXTURE_SETUP(vfio_dma_mapping_mmio_test)
> +{
> +	self->iommu = iommu_init(variant->iommu_mode);
> +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->iova_allocator = iova_allocator_init(self->iommu);
> +	self->bar = largest_mapped_bar(self->device);
> +
> +	if (!self->bar)
> +		SKIP(return, "No mappable BAR found on device %s", device_bdf);
> +
> +	if (self->bar->info.size < 2 * getpagesize())
> +		SKIP(return, "BAR too small (size=0x%llx)", self->bar->info.size);

It seems like the selftest should only skip map_partial_bar if the BAR
is less than 2 pages. map_full_bar would still be a valid test to run.

