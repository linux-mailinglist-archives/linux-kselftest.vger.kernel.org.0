Return-Path: <linux-kselftest+bounces-42029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7235B8E19D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBF17D775
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65325F963;
	Sun, 21 Sep 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="DfqJ2TpK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0002BB1D;
	Sun, 21 Sep 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475426; cv=none; b=DH9cxAGOF7CvWo6RmhIamRlCNX1IbCqIf50dQDsVs+yP2EBG1FZVQ8bq57JdYadLr0VIqGZywkGZPuTyfRuSvknyMwRPD0/71aLLVTQZmmkqVs7RwbRc7NR6yk22SrFwiungS+I7QXsEgZQDhaoTWNYCCTOX2W7S5yYvjvanWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475426; c=relaxed/simple;
	bh=IA56cvmKnVDHEFdFCk4xwrzSDfGBl+oM9lZtfZHxhA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T40xzNbjDiemIwngWHab+ZKmmHqQSnHPKzofnc31CuNahMQptLZvnK1wfPglTdgrrfuwCPfoEB40B3tNfhfVdixnMmidgqD2Y5UJiuu0KgKeGg+aSkwFLVP2Wv4VPpHWnjNmzfk4xB/fgv/GMJKIRP4KuBIweIxxMhG2BprAVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=DfqJ2TpK; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758475421; bh=lZEJjfmDCtONRBvjrWY369UYPWUKbQc1p+sE1/zjMKo=;
	h=From:Message-ID:From;
	b=DfqJ2TpK5SnUGMKt4nR9j+v5isCw9m35pmAQjU8IwXI8Evs90bMGVtsmuuA0VdnAm
	 bJgn8svrF66M7H4ORGbWjLS/msOjMQr5GnPMWU88x6v6v+DUQT0/Y7Z2PFwdKn6VLR
	 k1+/f16uMTUDw/ow8vC769mzqtjTxxMgQPxG6FvE=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 63D50C072E;
	Sun, 21 Sep 2025 19:23:41 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LHNfJv028498;
	Sun, 21 Sep 2025 19:23:41 +0200
Date: Sun, 21 Sep 2025 19:23:41 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921172341.GA28493@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
 <20250921171323.GC28238@1wt.eu>
 <25a968dab7cc7e473ff85400a3a824b272121c79.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a968dab7cc7e473ff85400a3a824b272121c79.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 21, 2025 at 07:16:50PM +0200, Benjamin Berg wrote:
> Hi,
> 
> On Sun, 2025-09-21 at 19:13 +0200, Willy Tarreau wrote:
> > On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> > > This also ties to the question of the other mail. I prefer "errno" not
> > > to be available if it is not actually safe to use. UML does use threads
> > > in some places (and may use it extensively in the future). The current
> > > "errno" implementation is not threadsafe and I see neither an obvious
> > > way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> > > unsafe code will not compile and can be changed to use the sys_*
> > > functions to avoid errno.
> > 
> > That's the point I disagree with because here we're not using errno
> > more than printf() or dirent(). Why fix dirent() to build without errno
> > and break perror() ? Why not also break printf() then ? All of this must
> > be consistent. We're unbreaking some arbitrary functions and breaking
> > other arbitrary ones, that's not logical.
> > 
> > I'm totally fine with saying that errno shouldn't be defined when building
> > without errno, but all functions must continue to be defined. perror() is
> > used to print an error message, it's a valid use case just as printf() and
> > should remain.
> > 
> > If we disable perror for this, then we must also disable usage of printf
> > for consistency (and I don't want this either).
> 
> Right, fair enough. It is true that it does not really hurt to keep
> perror defined. I doubt there is much code out there, but I also don't
> really have a a strong argument against keeping perror. After all, it
> will "just" result in a bad error messages rather than undefined
> behaviour.

It shouldn't be a "bad" error message, just a limited one, which is the
main purpose of ignoring errno (i.e. where we're running we don't care
about error details since the user only needs to know that it failed, or
may even not know about it at all). perror *does* display the caller's
error message. I'm personally fine with seeing:

    "open(): unknown error"

for:

    if (open(path, O_RDONLY) < 0)
         perror("open()");

when building without errno.

Willy

