Return-Path: <linux-kselftest+bounces-18565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE9989A6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 08:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE861C212B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F0445948;
	Mon, 30 Sep 2024 06:04:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68473FBB3;
	Mon, 30 Sep 2024 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727676269; cv=none; b=FHDOWGElSKdLQ8fVKv1xAA2IevFwQQEsiBeNffjVOQzH3qY05I/kB8pPd7nO7uwDSdomAjM8y/S6UZkWH9Okn3RWL49fwCZCKUHbeo9jcOBanXRA3cUx/62NchNI/zD3Bkofngq/aV+DoM6S74Rj1j/W7GVSPtgWVFfrTTwzjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727676269; c=relaxed/simple;
	bh=8uXAVNTsfEqBS9q1y0wpLNfAJwLFwvGKN95654kp09s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTz90prTepQhTGtLYj2iNL+d9s/YY41xVA0HqdAq5sI60uNITsnK0zNUztVpm4VwGDtyJc2xWFMxdG+uhmV5O3Nu4YUo2ToDemgHQNR6cN1+2IAzU48Qg9UlouqC4uHt/5pUtWiz2b4w0KPTaoUqPpqT1oN8ebAl/1Rw2Txz2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 48U64K5Q005121;
	Mon, 30 Sep 2024 08:04:20 +0200
Date: Mon, 30 Sep 2024 08:04:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Guo Ren <guoren@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/5] tools/nolibc: add csky support
Message-ID: <20240930060420.GB5109@1wt.eu>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
 <20240929-nolibc-csky-v1-4-bb28031a73b0@weissschuh.net>
 <20240930034946.GB13730@1wt.eu>
 <2f4a244d-e88c-4378-8b1b-71204964dab6@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4a244d-e88c-4378-8b1b-71204964dab6@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 30, 2024 at 07:23:39AM +0200, Thomas Weißschuh wrote:
> > > [0] gcc 13.2.0 and 14.2.0 from kernel.org crosstools
> > > [1] https://github.com/XUANTIE-RV/qemu/
> > > [2]
> > 
> > I think you wanted to place a link or something above for [2].
> 
> [2] was supposed to be inline patches for QEMU, I'll try to make that a
> bit clearer.
> 
> > > diff --git a/target/csky/cpu-param.h b/target/csky/cpu-param.h
> > > index 80554cc0fc03..9181b602a26f 100644
> > > --- a/target/csky/cpu-param.h
> > > +++ b/target/csky/cpu-param.h
> > (...)
> > > diff --git a/target/csky/op_vdsp2.c b/target/csky/op_vdsp2.c
> > > index a9985a03be33..d953f5ea94fe 100644
> > > --- a/target/csky/op_vdsp2.c
> > > +++ b/target/csky/op_vdsp2.c
> > 
> > Also, the first two patches look like fixes for the arch itself, they
> > should really go outside of the nolibc development tree, at least
> > because they might have to be backported to some stable branches,
> > or later fixed/reverted in case they wouldn't be optimal.
> 
> As mentioned above, these are patches for qemu, not Linux.
> I don't know enough about QEMU or C-SKY to know if these are the
> generally correct fixes. But they seem to work well enough for nolibc.

Ah I understand now. The problem with external patches inlined like this
is that it's hard to split them apart from the rest of the patch. For
example just doing patch -p1 < patch.mbox will fail, trying to patch
non-existing files.

What I'm used to doing when quoting code/patches/etc in messages is to
indent them by 2 or more chars. That could be sufficient to explain what
needs to be fixed in the upstream project without being taken for a part
of the patchset, especially for such tiny patches. In this case the quoted
part could include only the strict minimum (i.e. no diff --git header etc).
Just a suggestion.

Cheers,
Willy

