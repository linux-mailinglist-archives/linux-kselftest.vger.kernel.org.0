Return-Path: <linux-kselftest+bounces-17950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E297848F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 17:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87098B24F6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42761674;
	Fri, 13 Sep 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nGd4CI0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CB39FFE;
	Fri, 13 Sep 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240197; cv=none; b=GHwDClu3FnwZ9nIBM6tcuDKhhzS+pPI7H3yCe0cELkUn0D07VbIgbrBHHTfTzvU+4t2B0+ICTVey6igP3xCa76MIxkywc3F9m1pPZhqVHHSC1TR480xCyWfdKtgMjf7OxYk3LYUCESko0BKBEDMDnSj3F9qTOAnnjHfh+/fHu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240197; c=relaxed/simple;
	bh=znU+X4tFxwxnviR4AYXtN1Sh+JSn9dROBTL9XaILOKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWUARPY6RT4+ShoimWAnhz2TUe6CbJTkO0FIlyo8UWV4VCyk1Y6g2UBhEQpXzAdWJljsXYD9VgLM/OTWPPw6OnNjanliUOisJ95SsgZFNYGOydrfkjMoOcG63bOX4gCuc/5j+VnjaROZ42hTZ4Ggc1KyJqFmehAKLx0WRaBKpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nGd4CI0V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x/8EgQj4KxZ9gUl8jGT3nxlXQiSyXCD0NOe989Q1/P8=; b=nGd4CI0Vcf4+UnTwpy63g9lkdt
	Q8WyoobXi5sNYkGmdcjuPJAmEq9cubAp0Zjgfyi/t8iMICdrIdHvt5CvTDLGkoelSeAy5sBI/q1F3
	SYZjT97JhT7JsEez1AYh+T58Nzhh/Qw5HiNJ3k2juGbeXKZ8QgQJT7+N5nxCltJ8jpgTpAxhLcn+d
	zUEL2efANwIrRxe0iMrfPf/y+ZLzQ53vjVdD0W7nfXxNOe6HDdivUMEWdW57/bJiF2bXK148A0ADm
	rnqV6BjzJHQhr8wc+DEK5Hyt92z1Gz2SWuqkbFEHyP3yrWvshUjc5eF9edBqApaPEbBG1P109NTCC
	+W7IqH1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sp7vf-0000000GhkV-1nsY;
	Fri, 13 Sep 2024 15:09:47 +0000
Date: Fri, 13 Sep 2024 16:09:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, alex.williamson@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 1/4] ida: Add ida_find_first_range()
Message-ID: <ZuRVu088KuMbtqsm@casper.infradead.org>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-2-yi.l.liu@intel.com>
 <ZuMEsybAnOi_uSfY@casper.infradead.org>
 <a24aad52-3da6-49d3-9df9-f418fad36434@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24aad52-3da6-49d3-9df9-f418fad36434@intel.com>

On Fri, Sep 13, 2024 at 07:45:55PM +0800, Yi Liu wrote:
> > No test cases for the test suite?  ;-(
> 
> let me add something like the below. :)

That looks pretty comprehensive, thanks!

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

