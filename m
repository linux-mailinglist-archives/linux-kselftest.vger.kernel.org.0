Return-Path: <linux-kselftest+bounces-16287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3395F487
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA1A1C21BD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01237189BA2;
	Mon, 26 Aug 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="VkXBgwvi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79CC1CD25;
	Mon, 26 Aug 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684514; cv=none; b=LLBS+AFzf4qgEEbCZIEjh4buds0peSJJ8MsM7mjB9kD/FzD9cF8nGyL7XrFr9kmMUM7ztUC6N/zqOyeeNceGDv7BZ/KHkRS6/zI/aMdMBEV1Ixp61+crwAKOHAHf0qQSKoPPbTCM1UzAYMtkHaeBH0QPVO7qrjbZG6kzLiiqlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684514; c=relaxed/simple;
	bh=jSgjWvvQD8+edtmVB9c/uNcLn+pooqKkSJVmKNPbAt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohcs4byLjhu6uNeH7gWoFIf6XDptx6ib5GuAfovEnjB8PanHpAdGxnb/l0u5OCJ00OxL3ZgGretXk3xXTA7FhFrxTOqrLVsgiA3MIjZwMcEvcPc2AxDJUO8K7JDDr7eI+kWaXVR+KifiPtLZAsTVjVaKzSCLfdzdZ6K+AdQdK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=VkXBgwvi; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wsv5g1cLsz9svW;
	Mon, 26 Aug 2024 17:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724684503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yXLWDQCZ5TK80/zWFIY2TSxF4QwKlkw5RXpKLYOLgM=;
	b=VkXBgwvizjFv4gZcT25+rPkj6gmAtxLp9+dGtSIvUOs1NoI3Ea84US7yl7RS/exadB9d68
	wHeXj+UUQhGFzkVW1xW7Q+utTSuxkm8imagvFVFOuWPwypxlH8S1ASL9g7SeID6ePFzG/G
	+nlxzhHZGezrnPmFBawnhAjukn7+/5kgoVyfDEnDe/e3dVlf9YjBmGwrS9wFfbyfy+n64w
	It3bMogpdAyYK3D5i1eHg5soC8YsGKp9NxBJgITLRI4za36o5ss4Wl9mtkY2mEsJCFyqP8
	cN9shsFq8hvV2pX4bCO2G8SyJa6B4Tef2IadQUW5ReMnrWhXdXc23TIW2+KtYg==
Date: Mon, 26 Aug 2024 15:01:38 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-kselftest@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] selftests/mm: do not try to split below filesystem block
 size
Message-ID: <20240826150138.xi3jmtylcej2m6ff@quentin>
References: <20240826145344.33665-1-kernel@pankajraghav.com>
 <340DCD7C-8456-4F5B-B503-9DF5903C16DA@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340DCD7C-8456-4F5B-B503-9DF5903C16DA@nvidia.com>
X-Rspamd-Queue-Id: 4Wsv5g1cLsz9svW

On Mon, Aug 26, 2024 at 10:59:16AM -0400, Zi Yan wrote:
> On 26 Aug 2024, at 10:53, Pankaj Raghav (Samsung) wrote:
> 
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > There is no point trying to split pagecache thp below the blocksize of
> > the filesystem as that is the minimum order that pagecache needs to
> > maintain to support blocksizes greater than pagesize [1].
> 
> But the purpose of the tests is to make sure all cases are properly handled,
> right? If we do not test splitting pagecache large folio below the
> block size, we will never know if a kernel change breaks the handling.
> 
> Just my two cents.

That is a fair point. Let's ignore this patch then :)

> 
> >
> > Set the lower limit for the splitting order to be the fs blocksize
> > order.
> >
> > As the number of tests will now depend on the minimum splitting order,
> > move the file preparation before calling ksft_set_plan().
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20240822135018.1931258-1-kernel@pankajraghav.com/
> >
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  .../selftests/mm/split_huge_page_test.c       | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> 
> --
> Best Regards,
> Yan, Zi



-- 
Pankaj Raghav

