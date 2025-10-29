Return-Path: <linux-kselftest+bounces-44338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E8C1CA8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EF26469BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1A354AFE;
	Wed, 29 Oct 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUlka1of"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F73546E8;
	Wed, 29 Oct 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759468; cv=none; b=ZBlwFOXyGb7JJve/Pj+RGnwaUoJrDKlrsjUsfEM/xTp3LFZJH9NWwckAyXUU1z0RW7jxreBtzjhUCL0BuNPCRg/Y2VOMYVmoj8CICs78cnw2CeF+M7sRm9nmME3UhJNuN7M3seb+5VBwBExKvHVPsFS6f6/eHIZ8vSr/z7Fiagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759468; c=relaxed/simple;
	bh=O6jud5d+j/EicD6vnEBKOGqip2gC46w/u/IX3P9LvwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI6gqZLEM6lbQUyGga2oEK6Hfm09FJvx5a32TCvKmXW3y9IWz/U6R/QbgX2EamBPA9RxgjCQaonGzDqvsgfmJs5OrJwrTFjDCARfUH66yAPR/REQyNKEiqwNmNwJCecarrxgrSx+ncKPJR8U/CqZfmxoz6c5LFxPPthxpW6Vl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUlka1of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56793C4CEFB;
	Wed, 29 Oct 2025 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759468;
	bh=O6jud5d+j/EicD6vnEBKOGqip2gC46w/u/IX3P9LvwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUlka1ofVAdnLbHLJZmQZXDPM/PLX7ONqQaOeKJa02ikNxrBwx97gFSL7ZeyYPAeF
	 7Sm80ljxOslM3L8HXWvPjNOzgMxISb4X9Sk52lOkr5A9RG4GkTIDApYWl8bAwVFBmE
	 xLPHa5pjLE0HCjbFlcJrJTQ1/a/F5j9IUMqr7H20UY76ee58LmaUo/o53SjijcDMfi
	 tYO/Deero+CKyYLDq0p+MbJSO9f9hjab/c6kQT37hHkc3LZzQxFIynXilig80vOLdR
	 26pkYcACW9Sl/0LKH97MaLyy45mS+SYVGhYOjEPHxAszagyzyPaz7zhEcAVfRRmYi8
	 JF2yG0lhERxhg==
Date: Wed, 29 Oct 2025 17:37:43 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wang Liang <wangliang74@huawei.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, acardace@redhat.com, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-coalesce.sh fail
 by installing ethtool-common.sh
Message-ID: <aQJQ57TPZqKbNCRJ@horms.kernel.org>
References: <20251027043007.1315917-1-wangliang74@huawei.com>
 <aQD52zzmW1YDC1iH@horms.kernel.org>
 <20251028170842.3fdaea7e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028170842.3fdaea7e@kernel.org>

On Tue, Oct 28, 2025 at 05:08:42PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 17:14:03 +0000 Simon Horman wrote:
> > > +TEST_FILES := ethtool-common.sh
> > > +
> > >  include ../../../lib.mk  
> > 
> > Hi Wang Liang,
> > 
> > As per commit f07f91a36090 ("selftests: net: unify the Makefile formats")
> > I think the desired format is as follows (completely untested!):
> > 
> > TEST_FILES := \
> > 	ethtool-common.sh \
> > # end of TEST_PROGS
> 
> I believe we (intentionally) allow simple single entry assignment like
> in this patch. But there have been bugs in this check which I only fixed
> last weekend so please LMK if I'm missing something..

Sorry, I was just going by manual inspection. If the patch meets
your expectations as-is, then there are no further objections from me.

