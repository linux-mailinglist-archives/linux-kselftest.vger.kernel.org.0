Return-Path: <linux-kselftest+bounces-12295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC590FBDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 06:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74C91F235D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 04:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957C24211;
	Thu, 20 Jun 2024 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H3ue6Jzl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92342033E;
	Thu, 20 Jun 2024 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856709; cv=none; b=KpnzhuQeqnvt6odBYMOImRdV38n8G+5/HPwq3EwH6r2DGyETd6qoy5NyD6skzwbiAxBKJG/4bAFsbmjZCndl2FoOTlgf6zN7uROuJytiTklQnHTRoJpMHsKWQ53th3Gfrrf1H3bcekOnLqmjig0hveCW4hNGXUKM2LQtQG6gAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856709; c=relaxed/simple;
	bh=szJbLbfPOhwn79/2zzEjC3tpHjddQcvHJWqVSq3ENWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8eClQrKejpHVUUvJN9PcophybdoBxPueA4zMULcgltfiul5Oecs1NlZ3oLEe4VhNR/rTCHPCPKfH8SfbXOgmZaBzQMVO59j58zq28NtEHBRauYM/Lboo31RKkjeG0O6g5mwpJvniQp6mciMcdfThzCFZkAgF3WKLnorKIuCReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H3ue6Jzl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TrAuEcdbN66byLYBuONA5EHUWkXbGFGEpsYr69PtaPc=; b=H3ue6Jzleheo2WqyMSlb9v3N3C
	3FAJDV2HUnzNVS57QJJ+B5A5JySfcoucabLcrzK8bsTCvqvXnEAJ6Xhp5ugZzhwOtFjysW9Z3YBPT
	6NPuIIcZYj0ucO4W6Vc+VnGfbNoJd5Oef9t4Bi52ptgWz3wgRxseg5muuYnycFtp8785nrhvhqHI6
	1HgmrOEkdDMmOVsq8rDHZTSwclNJM/UPLQRPWslgR/DqMqQX6ifKplu9WiK/EphC/VwFXj4NLm5Yx
	IKDT4dP102TYC+4J/+IzAnADFxIVUVwPlKCDGpq/6WNmYpJL9Guft30azmsJnKY9fepm1USKrK+s0
	Q20yf3TQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK99E-00000003Xoi-0s0H;
	Thu, 20 Jun 2024 04:11:44 +0000
Date: Wed, 19 Jun 2024 21:11:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Fuad Tabba <tabba@google.com>, David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <ZnOsAEV3GycCcqSX@infradead.org>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619115135.GE2494510@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 08:51:35AM -0300, Jason Gunthorpe wrote:
> If you can't agree with the guest_memfd people on how to get there
> then maybe you need a guest_memfd2 for this slightly different special
> stuff instead of intruding on the core mm so much. (though that would
> be sad)

Or we're just not going to support it at all.  It's not like supporting
this weird usage model is a must-have for Linux to start with.


