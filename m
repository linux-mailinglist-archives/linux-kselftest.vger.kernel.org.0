Return-Path: <linux-kselftest+bounces-47697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C6CCB079
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D37D3073967
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B582296BD6;
	Thu, 18 Dec 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cy4zBfod"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BB19D071;
	Thu, 18 Dec 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048006; cv=none; b=KX6wNhlfhbB22QxOLdeaTLwTmL3xlQZX4HL1sTRrm2WrnETvuBI8w/UBwQyl7WcOO2SsI04gcS5xSIQFhEmJfJIsIjCqdBMH9i9to3bsmzIChvvGgOL9q7yJe1QMhUjbqQ8oYh5rVrh+29nAWv4GesoMTVCHizM9AbDAyka+M3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048006; c=relaxed/simple;
	bh=3IlAd7I22LFs1tRRBA3QsnND9q2u/JxU/Kp0wseyQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOH4Yce3JQINqu3LDXGTO2yhk4Gqz08gXIzZTKyFVMJ4j6/j5ixf1nhur39D1r0Ojls3ACk0f18lrM8WR8dgBDQdbQk3CmcPdm1t2yGoghxr6GFok9GKgrhpWrPt/AQi8XzJkwt96piMzhl1PsthBMENHGULo4kCHCCtrfW/3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cy4zBfod; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3IlAd7I22LFs1tRRBA3QsnND9q2u/JxU/Kp0wseyQvY=; b=cy4zBfodmatUYYsbpwDFs8QTzx
	5pDs5d/wyXRcPZy8FY8U4Vw8qV3pd22KjYmKwcwO0pWaQQDyRLENOItKN6pxMlM1wACm5/RE+1y9+
	vvq/t+upzaC8Quy3WPu2+hB6Y6ROu/R9BncmAAsBFh81ITOqhRnO+l4thNR6Ekgv5ulTxsCN5+4iB
	6wTWEfPSXnv1bB1Q7i+FzMumrcO7uyASMnimoagLd5EqEGxdValDp9WhOfYWyXRxU0ja3SYDlh0rx
	e4PkViuHfH4Fy0dNFKu6KOxh7fg8KtvQCCfaplBalnhs8/lm40W7hf8GJbinNOPwrgGw+sF6wBkBU
	GbE6wBYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW9lE-000000086IE-0Hfs;
	Thu, 18 Dec 2025 08:53:24 +0000
Date: Thu, 18 Dec 2025 00:53:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 02/20] block: validate interval_exp integrity limit
Message-ID: <aUPBBBzeqOw2Bx3S@infradead.org>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-3-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 16, 2025 at 10:34:36PM -0700, Caleb Sander Mateos wrote:
> Various code assumes that the integrity interval is at least 1 sector
> and evenly divides the logical block size. Add these checks to
> blk_validate_integrity_limits(). This guards against block drivers that
> report invalid interval_exp values.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Also please get this queued up ASAP.


