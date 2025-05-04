Return-Path: <linux-kselftest+bounces-32279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD3AA83A2
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 04:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067A7189D2B2
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8473595B;
	Sun,  4 May 2025 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sa5Xm9ln"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3C320F;
	Sun,  4 May 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746325505; cv=none; b=HmTEeMp1y8Szpddu3q8GZTAsVA1b8rRP1GmXOSwmNeHbCjXrV9kZJz+FN+S0iuUqBLun85DHS4YHSIFgshv5+j9XfHlKEZaE48wMmNx4tztlniFhg5KWMRm6qzMdGLO2nVblq+wQ+ORCHo1uz3PogBEnbv0WhcQiPQlyLcdfrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746325505; c=relaxed/simple;
	bh=S+OsORA5O5Cv3l1kC9DRd9vjMhq4uhcpcixu095XSQ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bRnC3oa2EQmLRUhWr5+cYEY93x4CwovpdaEi7x6gjPKPkpeSxR1LcvkhCIjeJPgjtuwfii8KA3HHY4v5Le4V7BgtCkGQ0pLDwHV9lYhIElVvwsgX1YsFWMSDPb2PZK2wX5brvDT624lyKZtEFjqV2Ckm5PxT2VzxGKK05kJzt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sa5Xm9ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FBCC4CEE3;
	Sun,  4 May 2025 02:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746325504;
	bh=S+OsORA5O5Cv3l1kC9DRd9vjMhq4uhcpcixu095XSQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sa5Xm9lnZB/lxMkZNAnnZ/pbCpdaYCFuobn5v6LiNaaZf/15Mx0DiiywmSlaBGfCH
	 PlDBlG/Y8WBoW9tum7PDlnY7/KQGQm/Az4CEdWZ6Y03DSIeN9Hr73c+5ZUWpnSs+di
	 QU0Ckqs4mnK0S8tAsYiEhauBQ4dVDgD6btmUGo5g=
Date: Sat, 3 May 2025 19:25:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: Brendan Jackman <jackmanb@google.com>, peterx@redhat.com,
 shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-Id: <20250503192503.5f057ba5396b3c982ddb2d11@linux-foundation.org>
In-Reply-To: <CALkFLLJ4CYRFuyR8sHi5Ah06QD_fDuF9v5eCyG7Xh+2kHPVzEg@mail.gmail.com>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
	<20250501163827.2598-2-ujwal.kundur@gmail.com>
	<D9LO1QI65D6K.NLDZ4RK2835Y@google.com>
	<CA+i-1C1x2TenH-WxkUnkx3-5XpkXOMMmZQTCBV3sHDV8WWN=oA@mail.gmail.com>
	<CALkFLLJ4CYRFuyR8sHi5Ah06QD_fDuF9v5eCyG7Xh+2kHPVzEg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 May 2025 23:46:26 +0530 Ujwal Kundur <ujwal.kundur@gmail.com> wrote:

> Thanks for the review and testing!
> 
> I'll push a V2 with the indentation fixes soon.
> 
> > this deletes the global vars before it deletes
> > the references to them. That's gonna be a real pain for bisections,
> > please can you restructure the series to prevent intervening build
> > failures?
> > (i.e. if I apply just 1/4, the selftests don't compile).
> 
> Could you help me understand this better? The selftests don't compile
> either way if both 1 and 2/3/4 aren't applied at the same time.
> 

At present uffd-stress, uffd-unit-tests and uffd-wp-mremap compile
successfuly.  After adding your [1/4] patch they do not.

This is undesirable because such an inter-series build breakage makes
it harder for people to perform git-bisect regression searches - if the
bisection point lands within this series, their build fails.

Probably this isn't very important in selftests/mm.

One could perhaps change [1/4] to provide back-compatibility defines
such as

	#define test_uffdio_wp gopts->test_uffdio_wp

then remove those at the end of the series.  But this is just too much
fuss and will probably cause other issues

I suggest you convert this series into a single patch.

