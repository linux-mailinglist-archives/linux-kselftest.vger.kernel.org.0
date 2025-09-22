Return-Path: <linux-kselftest+bounces-42078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1BB92935
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 20:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEA41906711
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4F318152;
	Mon, 22 Sep 2025 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AVL2jKpt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8127A919;
	Mon, 22 Sep 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564823; cv=none; b=gGqvK/GslDPAiDjU40wvSRqBDyp7ARP5sK+Ii9014pZ9Zmn2bE6d8qAlI4SbB32BbsLwNog7g407orqzFW9QE+HHZWaoWnnvS+bDTnoEBi4DU3+Zq5/3qGmoe6bzuQp12tDVy/uZ+DpYcey3LwSCJjVo20s37wIjV3uuJaTyM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564823; c=relaxed/simple;
	bh=FnIP1d/oudYbVFPeCGZFSMBaPDn2/OPBgMUTcrhXMu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpJHNPYGD+ErpsHq9WvWngXPXz20Ojp4WTg5Ak3rts/NbC9JYbsH9vAFfYWGeWcfz5mbSa080DHXOFcAgCI1wrvEgpT0x4C0dzSCtHQv7/eSWdejZ6WsrLEkDEQibdezpl+swvHwiSY/BLJdBpMdZXxEDrF77E66HqdNbR+yk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AVL2jKpt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yMn8t+f20gi/0sHsGEn/jlhXaeASyTY3G1FnyjiIJ7k=; b=AVL2jKptgVFalM3BstsvcmUmda
	j2bAKWdrKy2ac3m0PX46ij7AR6NOxP21OrpXALwWKCB22I3UzjA7IWy91pfaOYunXWiKyrfQeXfR1
	eVkRg/Kgkx2BD5GxSlXuh1NWzGuu+L5/HTUNMKwHFNK3rdVH5y4acz5GApUiGxttZuWNOLjmvTiZ5
	71I10OEe6Dd8wwQl50JDyCeE9I0bpManvKWZVz2UB/qEg0bcefanz8oJvMFTv4zl/I4ijIKhyXu3C
	YSExwfqYUHa8rRG5NgMFOQqWaFOtiQU8Ss35Mnh7ZP1bKz5X/b0yKJ8SqBclRhBYY+hD9KW2h0pX1
	1o/N5gVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0l2h-0000000BDyB-3k1f;
	Mon, 22 Sep 2025 18:13:39 +0000
Date: Mon, 22 Sep 2025 11:13:39 -0700
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
Message-ID: <aNGR0x185VGHxSde@infradead.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMhd4REssOE-AlYw@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 15, 2025 at 11:41:37AM -0700, Brian Norris wrote:
> I see fixups in controller drivers here:
> 
> drivers/pci/controller/dwc/pci-imx6.c
> drivers/pci/controller/dwc/pci-keystone.c
> drivers/pci/controller/dwc/pcie-qcom.c
> drivers/pci/controller/pci-loongson.c
> drivers/pci/controller/pci-tegra.c
> drivers/pci/controller/pcie-iproc-bcma.c
> drivers/pci/controller/pcie-iproc.c
> 
> Are any of those somehow wrong?

Controller drivers are a special case I guess, but I'd rather still
not open it up to any random driver.  When did we allow modular
controller drivers anyway?  That feels like a somewhat bad idea, too.


