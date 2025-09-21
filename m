Return-Path: <linux-kselftest+bounces-42027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFCDB8E160
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4951796B0
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4625A333;
	Sun, 21 Sep 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="IJnEBDMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91ED258CF7;
	Sun, 21 Sep 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474808; cv=none; b=Zph86ydGXa2XwdaG1IoDJR8KeC7u2fk4t7gmmj51fmEgfak4Cp7UU7BeNflD/RNdQ45PypcvEfMlLnZHybq5TFrZS9ihdqwORJfRxy4pPG60H4F656uU1UCmQE8Vh4O3OHhWpBji/Xiuo6S/1Ht4pfkPLzerstcio3zKUhlKaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474808; c=relaxed/simple;
	bh=Q8jo9RFMZL6CKiQ9yL4ItfVfRDdClH3IhBmKgJzcfrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFCGWPh0NDMMU9KM+2y6ACqDAkUhWbWFOtLQDFaClrF2cnpZ3h5gFTfSJL1j/oONPcMFxyXjNZ+MfdFN8y42U01HT4bK5dxKDP1E8nyuO+jyX8iy/Q3OC9mAKkK4A7kNnZYr/9fK/D2nihQPzYbWVWxVWcd1IREx8kRIicS4xlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=IJnEBDMX; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758474803; bh=Q8jo9RFMZL6CKiQ9yL4ItfVfRDdClH3IhBmKgJzcfrE=;
	h=From:Message-ID:From;
	b=IJnEBDMXfFAgLA2RWfQfp2k0SZxRN6gJY07Q3u86wORv+COMYnao5OGTPi7Xqe/BY
	 NhWOEwiJuA2qRvxPFLxyvMEPnEebkTsmvUHyajSKIGWeAATcmWq6F3fgEk25illfb/
	 J872Nn3CTCrxzi/LQFMryu9TZnk/+vBom6kBEnYY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 623EBC072E;
	Sun, 21 Sep 2025 19:13:23 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LHDNfT028425;
	Sun, 21 Sep 2025 19:13:23 +0200
Date: Sun, 21 Sep 2025 19:13:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921171323.GC28238@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> This also ties to the question of the other mail. I prefer "errno" not
> to be available if it is not actually safe to use. UML does use threads
> in some places (and may use it extensively in the future). The current
> "errno" implementation is not threadsafe and I see neither an obvious
> way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> unsafe code will not compile and can be changed to use the sys_*
> functions to avoid errno.

That's the point I disagree with because here we're not using errno
more than printf() or dirent(). Why fix dirent() to build without errno
and break perror() ? Why not also break printf() then ? All of this must
be consistent. We're unbreaking some arbitrary functions and breaking
other arbitrary ones, that's not logical.

I'm totally fine with saying that errno shouldn't be defined when building
without errno, but all functions must continue to be defined. perror() is
used to print an error message, it's a valid use case just as printf() and
should remain.

If we disable perror for this, then we must also disable usage of printf
for consistency (and I don't want this either).

Willy

