Return-Path: <linux-kselftest+bounces-47696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE66CCB06A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98C4305F64C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F007261B91;
	Thu, 18 Dec 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9DzAB5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE11C5D57;
	Thu, 18 Dec 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047991; cv=none; b=KCbrAPUywy1hz9BsUWNdbAG4W+pCQwJRUUFvFG6pE7BAgFKwsosgmdf61QxghyfRQTW6t/Ln7gCN+tmfWL712rLa9haxg3LgkLBpWwuErbCoU+vZS2P41/hXRjTLskyrYtZ8+OgIitIEookI28iBbSpogPxCvK9NDUSkT+rTVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047991; c=relaxed/simple;
	bh=+RhHYPLi5xoF2ZJBbLl9/VEroJFBNkszq6crpZIQDsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag9Q+GGmXoy0O97xRMU3P5N0bE9OqKNJ+/yBwg/yTk6qpNdBPfpnwr8j+NdPX6VNYmtLs2gEtRwVaP4pj72aTg4ozi9JqSNj45v0nw3s84Jl4fTFD1w03ksURymxQhGpKdXaKd/MIjPyO8EvnJAbCCaiHedRebu7ToVEN1y/9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O9DzAB5i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+RhHYPLi5xoF2ZJBbLl9/VEroJFBNkszq6crpZIQDsI=; b=O9DzAB5i18i+Q9GoOZyQMIBM8c
	QeEwX1/mO7yb45zlQsHwtFQrabWz4eJQC6XTBn5HjnywKC4S4vcFOUDXCa+kDL8j3t/oyqcAcuAY4
	xqJROOqPtdXGU/ZGVOmp8ZrI+5WIpixCSTpToiNQCyFqZNklJm5jHPOD/otu7fJjnENrZL9egzG3/
	9m9UagxRCOlYKcvGuXi9JdJyGCjyvOI0wUxq5eicxqRO44d4vVIRkvPc3SIKHBXifVHbeH0/DpuU6
	I9eHBvD6O3Ortf5uKIu4F+AdLHq60TKYgTUew3ow7nLNUBuCHpRgchbXzj9RivZfG0wzfONILChUg
	MP1pYBtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW9kx-000000086HS-1VBb;
	Thu, 18 Dec 2025 08:53:07 +0000
Date: Thu, 18 Dec 2025 00:53:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 01/20] block: validate pi_offset integrity limit
Message-ID: <aUPA8zb70ZhC-Jtf@infradead.org>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-2-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 16, 2025 at 10:34:35PM -0700, Caleb Sander Mateos wrote:
> The PI tuple must be contained within the metadata value, so validate
> that pi_offset + pi_tuple_size <= metadata_size. This guards against
> block drivers that report invalid pi_offset values.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Please send this to Jens as a fix ASAP.


