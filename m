Return-Path: <linux-kselftest+bounces-28691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689EA5B805
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 05:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD161891A74
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 04:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD81EB19F;
	Tue, 11 Mar 2025 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I122Az41"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7671DEFF3
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667742; cv=none; b=avqLDEi3M4UI7Jzv65triSqlDPwLr7u/HAM1Q8BYULW9qQuGnISH5n39lz9gXmOQCP6FGGRXSn9SnZw+1bBfLCyfULQfXO+IftYuqZ1obhggCmrFd+ixkmMO0Tjr6M75D/DWKzi7qTG2vux5Oua/Qn6ykYuKJsKe5IgzbIRHCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667742; c=relaxed/simple;
	bh=+bFQW08Y5h5rVZvOgGOk26oDuZlw1eFCGBNkRGg2Cvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC57yxZ+6Dl8mLixxj0ctdKAUIzRIkhIc2L0dSNPz765ykMvqq0KmZSZm5RlMf2zXUodnepc+L7vgBlBZtSQz07dFlClD4hEDRJPaD4RInUghsn23RcrM6HNgeei7WRfBybbAfch1ao/CM4b5e5UVdWTOL9sQ62jvo4Vdg+k7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I122Az41; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741667739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RydWn+mrgbEDJyv29iV6STruNKsJ8UhnPiCwUX9hAMc=;
	b=I122Az41G6fckN61UVN9LKwMrVs8kHQjRnBPCoFuKJWitIy++mWeES1KRjeqTYk386p80E
	wP60fD6FdSasKUy6CKtBSwdq+KooXb/fIo93bYYuXw8wGjHBeaiaZH7a52WJibxUoWmrZe
	rGD46Hyl0U/mribD/xh3IcBRLe+Jw5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-WrS50hfXNaWUDGekfwC0yA-1; Tue,
 11 Mar 2025 00:35:36 -0400
X-MC-Unique: WrS50hfXNaWUDGekfwC0yA-1
X-Mimecast-MFC-AGG-ID: WrS50hfXNaWUDGekfwC0yA_1741667735
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22A8A195608A;
	Tue, 11 Mar 2025 04:35:35 +0000 (UTC)
Received: from fedora (unknown [10.72.120.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A5471955BCB;
	Tue, 11 Mar 2025 04:35:31 +0000 (UTC)
Date: Tue, 11 Mar 2025 12:35:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
Message-ID: <Z8-9jmZ4jiA7C9gI@fedora>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
 <95955f2d-6bcd-492b-9057-37363168bdf5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95955f2d-6bcd-492b-9057-37363168bdf5@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Mar 10, 2025 at 09:17:56AM -0600, Jens Axboe wrote:
> On 3/10/25 9:09 AM, Ming Lei wrote:
> > On Mon, Mar 3, 2025 at 8:43?PM Ming Lei <ming.lei@redhat.com> wrote:
> >>
> >> Hello Jens and guys,
> >>
> >> This patchset fixes several issues(1, 2, 4) and consolidate & improve
> >> the tests in the following ways:
> >>
> >> - support shellcheck and fixes all warning
> >>
> >> - misc cleanup
> >>
> >> - improve cleanup code path(module load/unload, cleanup temp files)
> >>
> >> - help to reuse the same test source code and scripts for other
> >>   projects(liburing[1], blktest, ...)
> >>
> >> - add two stress tests for covering IO workloads vs. removing device &
> >> killing ublk server, given buffer lifetime is one big thing for ublk-zc
> >>
> >>
> >> [1] https://github.com/ming1/liburing/commits/ublk-zc
> >>
> >> - just need one line change for overriding skip_code, libring uses 77 and
> >>   kselftests takes 4
> > 
> > Hi Jens,
> > 
> > Can you merge this patchset if you are fine?
> 
> Yep sorry, was pondering how best to get it staged. Should go into
> block, but depends on the other bits that I staged for io_uring. So I'll
> just put it there, not a big deal.

Thanks for pulling it in!

BTW, the test behavior depends on block too, otherwise it may fail because
ublk zc actually depends on the fix of "ublk: complete command synchronously on error".

So if anyone wants to try the test, please do it against next tree.

Thanks,
Ming


