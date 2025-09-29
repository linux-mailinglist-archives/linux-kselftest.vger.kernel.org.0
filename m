Return-Path: <linux-kselftest+bounces-42566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95083BA8799
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 10:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABF1189C94B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C16278150;
	Mon, 29 Sep 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gwtrv46Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0E2045B7;
	Mon, 29 Sep 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136195; cv=none; b=M6ww0H4PD2gfxQooBH146UslzJiLyvtFcjJvUBltrbWrX5ZwkuYp4md3c6BQRWCBbeUom/6GzIz6AKLvDXMToLjZq+QP+swuV8cHqzExGggMMt4CxEQK4Cas8vzXwHpLpguMNSF4sQ98AM9A1VQQQg4mpU/BXJAbiBGIQgKNlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136195; c=relaxed/simple;
	bh=ae5nf/2ulTFGr40DaWU8qznNB7MHcDdaiOtwnoNEP5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpr1MJYN9PQyFLqNQknqF/8DUPoXy8HX0/5zQvaAzXg9/PsJbNXdTWJ0Qw3jvlU8dH5cL4XzgAVwrtGeypIEothPFbgi/HM8nqf+jgvEQfj/t5/wNGBYLT1wH1lb6aW312Uq5nWCaYx21w2QlST7Zu/2NZ1yyrBBLXy8Z3+HxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gwtrv46Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5RLyKFm4jgkZLyCw57ehihBsj/peM8c/q1zO/wcZ87g=; b=Gwtrv46ZtYa7Hznfg8/cNCvLhg
	d1ztE/AZ6uW5BQC26hBLrk0J1Q/o6YElZu4Kgbn+QRBmq8de+buG4cpE5tXkPbl0XUp48d71c5Tm2
	NRJEba0mQ15/9JnRSlIhH8Rm6m3nKDM7x+X/i+c5/hDlo0qw9J4igZhjBlVn300bshhjZeSVFXcsd
	2hbcWS6xZP7PmFfXRCVrALhUvinh4tR3mdDIzqGsp4AKRcAp1ETQ6oFAuJ225cQ/J1zXfRNrsRNGK
	4ottAuC74oP6TWT3Ve8uq+LwhsBO/VKhoVGKLFb1hKCXsLlkYSqh2J8dfq6CMpm+Mq3Owbm+jpG6F
	alNJ9cEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39gO-00000001qe5-1y6t;
	Mon, 29 Sep 2025 08:56:32 +0000
Date: Mon, 29 Sep 2025 01:56:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <aNpJwH1gSZFedysz@infradead.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
 <aNGaBiUOb6_n8w8P@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGaBiUOb6_n8w8P@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 11:48:38AM -0700, Brian Norris wrote:
> On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> > Controller drivers are a special case I guess, but I'd rather still
> > not open it up to any random driver.
> 
> I don't really see why this particular thing should develop restrictions
> beyond "can it work in modules?", but if you have an idea for how to do
> that reasonably, my ears are open.

PCI Controller seem pretty special in that they provide infrastructure.


