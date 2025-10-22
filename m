Return-Path: <linux-kselftest+bounces-43774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85080BFD928
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B23B0603
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101027B32C;
	Wed, 22 Oct 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fM26tfZs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6961B7F4;
	Wed, 22 Oct 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153205; cv=none; b=Axyst1VYT6UrfEN3qsmpuW3l4DhF3ZFPavgLBKVqszJ9qzW228jYrWOTmRkG+LU/Xh8YJnk4Fm3TNhLvsGhRurAPSo0q6xV/5X8VdmXPJn5eBZqVXy43oqhG5SQ9tOxCgmvyJG9w5vvRKeRud1jbgvBzgFaB1gG33icOrEOh4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153205; c=relaxed/simple;
	bh=Oc5cL4PM3GS59XiGaVYHm7x2QglMaN7Tq26+NOil5DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTFRvby2F3zThc/bSbR2DA+v/KU96ZCSUemnOcTBxRuj9XUumIRg/youb2fkskFbi0H4TB2YieHvWU5Y2UflSGi5KklPAMLDsc/+TlraJQAVMSiXEh4lqY572zJlKu9N5SHOzShENXScTsrxZegLXk2pY6sb06rroZozViiYlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fM26tfZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FAAC4CEE7;
	Wed, 22 Oct 2025 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761153204;
	bh=Oc5cL4PM3GS59XiGaVYHm7x2QglMaN7Tq26+NOil5DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM26tfZs84ldeAddOmNXArn5RbP7iEp+oNUSPg92OafLdEp2A2CltfwxTYDTDbSBt
	 yhtDIrkROBstCq84hJRIv0uvNE852TNVAVBfnIvhjfb5K+f+sBF1WJ88PbKKep8MPs
	 rsTBFdIzM2FKvPUMhlYOGddUPz2hWCETV98K98SI=
Date: Wed, 22 Oct 2025 19:13:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech, acarmina@redhat.com,
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
Message-ID: <2025102211-wolverine-cradling-b4ec@gregkh>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <2025102111-facility-dismay-322e@gregkh>
 <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com>
 <2025102124-punctuate-kilogram-da50@gregkh>
 <CA+wEVJajSGzb85YTiv98yAY3bcJFS0Qp_xjLc++wnU8t=wDAOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wEVJajSGzb85YTiv98yAY3bcJFS0Qp_xjLc++wnU8t=wDAOg@mail.gmail.com>

On Wed, Oct 22, 2025 at 04:06:10PM +0200, Gabriele Paoloni wrote:
> > Every in-kernel api documented in a "formal" way like this?  Or a
> > subset?  If a subset, which ones specifically?  How many?  And who is
> > going to do that?  And who is going to maintain it?  And most
> > importantly, why is it needed at all?
> >
> > For some reason Linux has succeeded in pretty much every place an
> > operating system is needed for cpus that it can run on (zephyr for those
> > others that it can not.)  So why are we suddenly now, after many
> > decades, requiring basic user/kernel stuff to be formally documented
> > like this?
> 
> Let me try to answer starting from the "why".

Let's ignore the "why" for now, and get to the "how" and "what" which
you skipped from my questions above.

_Exactly_ how many in-kernel functions are you claiming is needed to be
documented in this type of way before Linux would become "acceptable" to
these regulatory agencies, and which ones _specifically_ are they?

Without knowing that, we could argue about the format all day long, and
yet have nothing to show for it.

And then, I have to ask, exactly "who" is going to do that work.

I'll point at another "you must do this for reasons" type of request we
have had in the past, SPDX.  Sadly that task was never actually finished
as it looks like no one really cared to do the real work involved.  We
got other benefits out of that effort, but the "goal" that people
started that effort with was never met.  Part of that is me not pushing
back hard enough on the "who is going to do the work" part of that
question, which is important in stuff like this.

If you never complete the effort, your end goal of passing Linux off to
those customers will never happen.

So, try to answer that, with lots and lots of specifics, and then, if we
agree that it is a sane thing to attempt (i.e. you are going to do all
the work and it actually would be possible to complete), then we can
argue about the format of the text :)

thanks,

greg k-h

