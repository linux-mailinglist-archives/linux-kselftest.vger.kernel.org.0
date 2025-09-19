Return-Path: <linux-kselftest+bounces-41973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D75B8A5C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CD1BC0725
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830631B10A;
	Fri, 19 Sep 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5QwcbEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA831AF23;
	Fri, 19 Sep 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296442; cv=none; b=GNuOG7LdtGsufHPNWockQgDEG4qfp5cn2x4gst8OpVE1AnNfvJpjRrC+snWkVW0+az+aH2S0sbuRDM8QfLNESLOFc5bJknMPVBrSSBFkOXPuNOH+48lYJJG/i4wguRtT2oam/ct+9RuWM9+BHJmfHn2hU4NhkR6kPV2fX1e/B1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296442; c=relaxed/simple;
	bh=rD+5ViKgJptdVexEPid2ZBaWhl89gqDdDSGw11P4dpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOVdn3OqrrZAV3tOsgoQBSFB/A1eDW0MRszGZQL7w2cXiiPbl5ymxS6C4hTiP7nE9pMdMd1qRU+UScsk7SNpn8iPK/b98dO4ih+ZIHyhlw2ODPSCIWaqLKiza+O6WCeyTi4UUg3SFWgvHzozGJcF0c0SuScSlFqyvghiE5e9eWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d5QwcbEB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z9HQEie4yyR1EvlQG0pJEaoVYImYR1NNOaRDN3iYsdg=; b=d5QwcbEB38kmC30MGaAeYFHbTM
	Th0xqTbRMdS9k/FmbDQnotSj+/7ca0ivwB6ODOsXMjI0TKaM9ayO9CP7JAaxKgv2EzgBwJ1A79VdE
	QfYzYtwI2q8Pt6JzWzMTEfhfJ0LgC9GbxtFlJDNP7r30QbHAigIj6ITRk9nTNDxxOvfISg4yFaPiU
	PXjAKyd3hNa+8wSyZ9ucI1pjlrSq51Cy6uHvhk7E4gDYHjRetcPo3YO+mwWqyNYiZmsO6pgqMDZPE
	+c+pnWc+BSdZMVXgmR5jEOeDzZGTLYG63sA7WWDKWaYrsfLwEchvByHL9W5nujOqAGfBTXfeXv449
	dw0nwh7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzdE0-00000003NNn-1nR1;
	Fri, 19 Sep 2025 15:40:40 +0000
Date: Fri, 19 Sep 2025 08:40:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
Message-ID: <aM15eChUObXfxLzs@infradead.org>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This patchset is an attempt to start a nolibc port of UML.

It would be useful to explain why that is desirable.


