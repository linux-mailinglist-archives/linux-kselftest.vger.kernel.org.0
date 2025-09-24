Return-Path: <linux-kselftest+bounces-42163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AD5B98243
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 05:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12D01747E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 03:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599337262D;
	Wed, 24 Sep 2025 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="ZTC1ZAOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C92F56;
	Wed, 24 Sep 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684750; cv=none; b=Rg+5G4eUKHbMuTe6KNeMFehfKbyLwN3Ykswy2CV7JeoZ2WEIjQgKfSXYnfiq/iaTk67RWGbNAYwYdUfFdOco7i7dyzgwPfLe3VjY1r6CUw5UtRxkTl2PpM+0h6lwCPvDUbz23SW4j0OlcB/zah81I+t+qLcMt2UKzGwwqwlKyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684750; c=relaxed/simple;
	bh=8X1kAHCYWjkRW71DjqNNrvPZpTRKA9DUHMu1KiRAz2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNtN4HT/PSms4ax1EbbTpOjmCcSlmSkNxae5Pbedjw/LKbAbxzlUqzfGN5MnLATDcNfE7KgsjgDvSABu/zYasGEDkH654/bDqnd/3BHySbGm378exVdllz++In4S3Nd8SYCzlioQTUnMKE5/rBgohbbLnfLFVEq/NhC6UDCDb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=ZTC1ZAOP; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758684738; bh=pA0xAIiIUj8HYkYDN+N5NPIspAnSO8L0/9ezyiu4Zkg=;
	h=From:Message-ID:From;
	b=ZTC1ZAOPbItSLcuH3Q4AF76+z43R/myMWXl7riFopa3tfXZbdXv+1Z5gqMISMpDAl
	 xcO+8GRKZnO2+KLYSIfBD9KlY8bJ877stsWTvIiU7fCycdQFOC4e/Dr3um1mVatiCQ
	 vqKjwHDRGvY1fLVoECDZmdhUOidDl87I1ftWnwNo=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 27A67C06A6;
	Wed, 24 Sep 2025 05:32:18 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58O3WHSI009048;
	Wed, 24 Sep 2025 05:32:17 +0200
Date: Wed, 24 Sep 2025 05:32:17 +0200
From: Willy Tarreau <w@1wt.eu>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, hch@infradead.org, benjamin@sipsolutions.net,
        linux-um@lists.infradead.org, linux@weissschuh.net,
        linux-kselftest@vger.kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, benjamin.berg@intel.com
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
Message-ID: <20250924033217.GA9039@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <aM15eChUObXfxLzs@infradead.org>
 <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
 <m2y0q47mbs.wl-thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2y0q47mbs.wl-thehajime@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Sep 24, 2025 at 08:58:47AM +0900, Hajime Tazaki wrote:
> 
> Hello Benjamin, Johannes,
> 
> On Mon, 22 Sep 2025 16:41:36 +0900,
> Johannes Berg wrote:
> > 
> > On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> > > On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > 
> > > > This patchset is an attempt to start a nolibc port of UML.
> > > 
> > > It would be useful to explain why that is desirable.
> > 
> > Agree, it should be here, but FWIW it's been discussed elsewhere on the
> > linux-um list in the past and basically there are various issues around
> > it. Off the top of my head:
> >  - glibc enabling new features such as rseq that interact badly with how
> >    UML manages memory (there were fixes for this, it worked sometimes
> >    and sometimes not)
> >  - allocation placement for TLS is problematic (see the SMP series)
> >  - it's (too) easy to accidentally call glibc functions that require
> >    huge amounts of stack space
> > 
> > There are probably other reasons, but the mixed nature of UML being both
> > kernel and "hypervisor" code in a single place doesn't mix well with
> > glibc.
> 
> just curious
> 
> - are those issues not happening in other libc implementation ? (e.g.,
>   musl-libc)
> - same question to nolibc: is there any possibility that nolibc will
>   evolve as glibc does, and this evolution introduces the UML issues ?

Nolibc focuses on early boot programs. That does not mean it will never
evolve towrards more generic usage but this remains unlikely, and in any
case there's the goal will remain not to degrade the experience on the
original target (early boot). That doesn't mean there will never be any
breakage but we're doing our best to keep things in a clean and workable
state. Regarding threads, it seems unlikely that they'll arrive any time
soon. But if they did, assuming UML would by then be a long established
user, we'd certainly find a solution together (even via build-time
defines if needed).

Hoping this answers your question.
Willy

