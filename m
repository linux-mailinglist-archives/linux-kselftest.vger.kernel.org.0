Return-Path: <linux-kselftest+bounces-41500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA09B57DF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 15:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399661887336
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92B31C565;
	Mon, 15 Sep 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KtFhqylv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE41FCF7C;
	Mon, 15 Sep 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944105; cv=none; b=E8zvfJjVEUV9yegZo+/TYT5mHKI87s5DFAaHfoFHk9KK7njLuUseXgxsI1fZn3ptZhxmwY+jOTPnGZ4J7rKPXEoP1xdApRjtkiif4Dx6iLzDGgaqQ1nU/jHOKVuPYRMVKRDn7jLeqRO8XFbJOFoPftvF7GOwJhHUDE3qniLayDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944105; c=relaxed/simple;
	bh=NTOWiy5dTMZluijZRXvogpMObctV0ej6Q8JzUqFg6Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuQeH7iUFIMbgPRSNH7EO7zIeKF6492tyzazJWoEXAHkn7G3rEGeAsw0fvEELTWlbhfKnsS4TJ/booTo45Sb+jaiGbvs/m4La82lq/DMntqmGWYSeFy1Pg3TfRptego4aCOKh82LUdaCf+zdDaMG9QvN/Pdv0btYbJKDz/mWxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KtFhqylv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NTOWiy5dTMZluijZRXvogpMObctV0ej6Q8JzUqFg6Xc=; b=KtFhqylv9VPDG70FiAWcrua/fz
	zqjVDB2ayLTJPG/dXU6ratFizRBc65qFRqGzQq/eBnedgyAJzgEKZ7o+u0TRm1uKoGklenGh+8A6T
	+MnErMNozi1PHNmM7LwHA+tBapYgOFXuXrPuPnjcVx+h7qss7erdXyYffXyI2CDUDui+UT+8lQBa8
	rtGKeO4jL7M3YOTwtaghH1yEfXoA2NFE2K0uLJtp6CAb1meZfEpQ0x2dxKykeVKPv2WGI7RbxY/wP
	kwohJGFMv/QhuUHRSgmdojp8gcPCsBMK3MZ9e05dkZAcuPrNX+C803mI3C4zoc79/vEAf3d/0ZMU8
	WHHvwGlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9Z8-00000004RlJ-2vGz;
	Mon, 15 Sep 2025 13:48:22 +0000
Date: Mon, 15 Sep 2025 06:48:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aMgZJgU7p57KC0DL@infradead.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 12, 2025 at 03:59:31PM -0700, Brian Norris wrote:
> This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
> There are a few drivers that already use this, and so they are
> presumably broken when built as modules.

That's a reall bad idea, because it allows random code to insert quirks
not even bound to the hardware they support.

So no, modules should not allow quirks, but the kernel should probably
be nice enough to fail compilation when someone is attemping that
instead of silently ignoring the quirks.


