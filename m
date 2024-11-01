Return-Path: <linux-kselftest+bounces-21317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6109B97F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 19:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71126282174
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669F1CDFD7;
	Fri,  1 Nov 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qFYWzjwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B114F132;
	Fri,  1 Nov 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487258; cv=none; b=IW9tl/w6nbh0IHarrMzyO0PT1Gx8odzkEH2K2/sJiviKlFtgsFg9vJ6dneFEMI9vBIOV7pArUOgAuatCs4bseUDu7KpuiviJC1PxTgXux7nIcU8xbgNR672gcefKeyyO0pnhAJd78PuzKXmd5o0Up8nuhpyVN5c4KpPamCizkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487258; c=relaxed/simple;
	bh=SUFxQ7ZLqI0rTTC6IQzP13/0lOXlrIozwL/6c1iShRU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O88nK2U9aIA+V1I4dBTArWZKzMBaJvqiY2qbaC40TMqvD41hVO1SBZbvjo8fDVQD67qLXsZiDbYdCTdZnENM/f/x6M9agU9ohPOaku3sINmne5S6TGRbhP6TdvrcOUPdQWhPEu/WEG9LTMu7P28AFbn2CA6nJsAW93eCtogrJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qFYWzjwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF0C4CECD;
	Fri,  1 Nov 2024 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730487258;
	bh=SUFxQ7ZLqI0rTTC6IQzP13/0lOXlrIozwL/6c1iShRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qFYWzjwrK1CtLgKBZ9Yi/cThIRWOk0cu66mnAm5azK465QxY42od+XKxoPzPT8Bzr
	 HOyNdSSCLlxegWeAIHEGBdXHj6X6pu2Ynw4OEw8pb5iXpTPqMDWd7C802CVQW8jB7M
	 J7DGnMpxNIgzbbPAFueNuqFltz3vZLiOha4I1n6g=
Date: Fri, 1 Nov 2024 11:54:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Donet Tom
 <donettom@linux.ibm.com>
Subject: Re: [PATCH] selftests: hugetlb_dio: Check for initial conditions to
 skip in the start
Message-Id: <20241101115417.dae7bfe1230575378e07a147@linux-foundation.org>
In-Reply-To: <20241101141557.3159432-1-usama.anjum@collabora.com>
References: <20241101141557.3159432-1-usama.anjum@collabora.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 19:15:57 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> The test should be skipped if initial conditions aren't fulfilled in
> the start instead of failing and outputting non-compliant TAP logs. This
> kind of failure pollutes the results. The initial conditions are:
> - The test should only execute if /tmp file can be allocated.
> - The test should only execute if huge pages are free.

Cc Donet Tom.

I added 

Fixes: 3a103b5315b7 ("selftest: mm: Test if hugepage does not get leaked during __bio_release_pages()")
Cc: <stable@vger.kernel.org>

> ---
> Before:
> TAP version 13
> 1..4
> Bail out! Error opening file
> : Read-only file system (30)
>  # Planned tests != run tests (4 != 0)
>  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> After:
> TAP version 13
> 1..0 # SKIP Unable to allocate file: Read-only file system
> ---

And I moved this useful information to the changelog.



