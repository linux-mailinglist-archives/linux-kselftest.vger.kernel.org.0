Return-Path: <linux-kselftest+bounces-11838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A510B906636
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6B51F21DE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD0313CFB2;
	Thu, 13 Jun 2024 08:10:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2513CAA7;
	Thu, 13 Jun 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266224; cv=none; b=ulsTYWzP2c4VsBNS/W9dX8SVuLFzcjZrtioOQVj4g9XwsdEBT6xs6tyr05LoEiD3WT8vBKNxQ/Fk6lnJUbVwqpjqD70PGIb6r/DxKiRUioZF0KD88gmat1X5kLzsP012BdvCQ9ophW2fznUgh7ct3wRKUmrowOzP0xXM1OMxWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266224; c=relaxed/simple;
	bh=kuCRy/dvwvgH5lryVQtV60zwp/KBdbHgxITSfmkLE3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfIZncIYiBmpui/bXL/BZ8yaBDINm3u5hNiB0mf+7uJOc3Wqj5ycFfLu4EvU/r8Q+DLMcpyT94uw4qsZWHoegh0pRhJIllJGiRCXd46wejdSnSlaQLV6S/c35HwvPdw4Y5IGejYe+K5bv0l7uRnKSfSw7xTaJ883D9okiWG3hB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4E6268AFE; Thu, 13 Jun 2024 10:10:16 +0200 (CEST)
Date: Thu, 13 Jun 2024 10:10:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, paulmck@kernel.org,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <20240613081016.GA21500@lst.de>
References: <20240612155135.3060667-1-kbusch@meta.com> <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 13, 2024 at 10:26:11AM +0530, Nilay Shroff wrote:
> I am wondering whether we really need the _rcu version of list_cut here?
> I think that @head could point to an _rcu protected list and that's true 
> for this patch. So there might be concurrent readers accessing @head using
> _rcu list-traversal primitives, such as list_for_each_entry_rcu().

Yes, I can't see how this works for a RCU lists without very careful
memory ordering.

Btw, another thing - the old vs new list ordering is reversed vs
list_splice*, which is a bit confusing (as are the parameter names
both for list_splice* and this new helper).  Can you switch them
around to match?


