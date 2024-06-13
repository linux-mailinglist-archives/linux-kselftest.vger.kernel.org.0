Return-Path: <linux-kselftest+bounces-11854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FA490730D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E591C21966
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C41428E2;
	Thu, 13 Jun 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qggwRUUL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED22AF15;
	Thu, 13 Jun 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283642; cv=none; b=R+Xx+T8d1n5z/yaXFZvZsrOjAMQPY/CyScJuUzV6ODNecIlxfAufPCgoZ0ecQCaTll6RpefhzjZh3fV+eiKgA73trV1lzM+XZ0L+5dW7RPt7E2G84iHlolXkY5faqb1wFbQoms52A+9lYbTUMOroxHbUNHn8dm8D2rXyyHlMpEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283642; c=relaxed/simple;
	bh=J+FOEDQ8EizaWwa5B+nADOYSJHbx/xeNUz9hDlllVAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPhsB9DmoOq9kRjehwg/Rt6+B7nRjeGgcBhZVc/uHb/I7h/iAb/dwyft/MeUjuCEvd1COmI5ETOymQ5f73Ci9rLlaXEwqShnuxTl+Fqtqyns6ik330OpPXX3cVIiAkN5NRSRnCv4FNRu3TBH+t/8jioYZL3NWOjs2DCLZvLKMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qggwRUUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB77C2BBFC;
	Thu, 13 Jun 2024 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718283642;
	bh=J+FOEDQ8EizaWwa5B+nADOYSJHbx/xeNUz9hDlllVAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qggwRUULEqiXxuZ7j5UvKifzy33DHtdZrKO56gBNXhQgLtA73AndYpzFdFKPtgajQ
	 eZ2FrWkaHiyu1CdoFUoJoAYYrvE/N2+CUEp/qa3f0Af+VlZQyOvYOKG67D0tjcqo0x
	 3EW1/WldLUz1c60Qlz/5z2q1SN7/pTXJ3oF6Xdw9Bd3BKzB0X/HP6kxPWzRVlb+7z4
	 9mbcbdJWED1dzELNE6rA9JFZltzNE25ja+CDOS0rLms/EmFDwbgjCb9OqLuY02UOac
	 Ml+wL3j/PPtPYrIAHbcgznafOfDKP/T+JvE6NY0UA7S9SC3cj2JEtsBYFk0OTfG0WS
	 sRAQ05C8tc5Xg==
Date: Thu, 13 Jun 2024 07:00:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sagi@grimberg.me,
	paulmck@kernel.org, davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmrteDHF_HlWHFth@kbusch-mbp>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <20240613081016.GA21500@lst.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613081016.GA21500@lst.de>

On Thu, Jun 13, 2024 at 10:10:16AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 13, 2024 at 10:26:11AM +0530, Nilay Shroff wrote:
> > I am wondering whether we really need the _rcu version of list_cut here?
> > I think that @head could point to an _rcu protected list and that's true 
> > for this patch. So there might be concurrent readers accessing @head using
> > _rcu list-traversal primitives, such as list_for_each_entry_rcu().
> 
> Yes, I can't see how this works for a RCU lists without very careful
> memory ordering.
> 
> Btw, another thing - the old vs new list ordering is reversed vs
> list_splice*, which is a bit confusing (as are the parameter names
> both for list_splice* and this new helper).  Can you switch them
> around to match?

The parameters follow the existing conventions from list_cut_back and
list_cut_position. Those functions cut off from the head to the "entry",
and this one cuts off the "entry" to the tail instead.

