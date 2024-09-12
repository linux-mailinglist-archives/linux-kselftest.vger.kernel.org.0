Return-Path: <linux-kselftest+bounces-17846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E855C976D5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A490328D8E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747AA1BBBC5;
	Thu, 12 Sep 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pH2EMlrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3341A76DD;
	Thu, 12 Sep 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153920; cv=none; b=cCm+dTNnx4ppiMSdF8w3mcXiRX9gXsqeMXkqum68WeJrmqccojdCdNOJvUJ5h9qBNRzjiuBlGvVxchwAVZBU9mLxWUzZeH7qAlviRD4Eutr5wkegS660RSbjyTIrg9gnRu93pPVfOyiDHjUWLYOHTEr4t3XPAGh+kMbtmnMaMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153920; c=relaxed/simple;
	bh=1Ym2TiSFpCbr7yzAwcoae9FlyIRlAgmNsZjX/ftiwwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urU2WCjLBK/6FaRqNoXcj9i/Ww75TD7nBZKiihN5Rso7RE040iKr/Mcbf2UQvBqQH0HmthUvurJho7T//zqK05J9Go0ZNkEbszVIDtIZkglSJPdzoqFEf8ubVm2IVxOX8iHenCCJY3MkrCnugVIp7NkaBZDQe+Dr1GWC+E7kL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pH2EMlrZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wrf2IKIDJ3QmIkiR5xrTzhK5a/UwRFJJ/GjVhXV7nYQ=; b=pH2EMlrZufLHxhtK7lHoCqrwKw
	eZ/QqHoncMgv58W9iD26wg19w1IYX3pwkKtscQ/jRCQWvdzoFjXNY+l2P6qZMFuOpqIqZ1/VwoQvx
	UzBexzgeqYx1HIxaQVvR428qv7X4t55JLE78vTIDoyWk2zfDQ31tZuRtbH6/Tk6cTru7jkDvccfDX
	dVXReOXGomtTVn76htD1HWWpaHJwbaWEdDUfB55cx3VTnOAzC707T3oZc5LZhgJHDV+Tm/tjLnf/F
	X0GASBP/2EiOvHd6gRLeMrXbh3A0K6gzUCr6Eyri9+ifQvwQZsMc7wEgILkk7AoTAXByFPHNhzgju
	Mhd1LTOw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1solU3-000000091Bd-3OIX;
	Thu, 12 Sep 2024 15:11:47 +0000
Date: Thu, 12 Sep 2024 16:11:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, alex.williamson@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 1/4] ida: Add ida_find_first_range()
Message-ID: <ZuMEsybAnOi_uSfY@casper.infradead.org>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-2-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912131729.14951-2-yi.l.liu@intel.com>

On Thu, Sep 12, 2024 at 06:17:26AM -0700, Yi Liu wrote:
> There is no helpers for user to check if a given ID is allocated or not,
> neither a helper to loop all the allocated IDs in an IDA and do something
> for cleanup. With the two needs, a helper to get the lowest allocated ID
> of a range and two variants based on it.
> 
> Caller can check if a given ID is allocated or not by:
> 
> 	bool ida_exists(struct ida *ida, unsigned int id)
> 
> Caller can iterate all allocated IDs by:
> 
> 	int id;
> 	while ((id = ida_find_first(&pasid_ida)) > 0) {
> 		//anything to do with the allocated ID
> 		ida_free(pasid_ida, pasid);
> 	}
> 
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  include/linux/idr.h | 11 ++++++++
>  lib/idr.c           | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)

No test cases for the test suite?  ;-(

