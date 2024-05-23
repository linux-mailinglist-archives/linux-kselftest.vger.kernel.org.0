Return-Path: <linux-kselftest+bounces-10637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF88CDDD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 01:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24B21F240A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 23:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06991292C4;
	Thu, 23 May 2024 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gHP8h8so"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88517577;
	Thu, 23 May 2024 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508460; cv=none; b=kt4zyU416ZHMjRLOaNNm4BBtjKQXmiXngZmv3VQkBaRgKXimdp0uvuJq25TetLBCMmabCda+fiMM31ypwRpUGhs5VU0re5aYUPCmyDmOu0IaV775wqxeCPInv9dwx2Eg659b4X938fpD+IavFWZK6LfURjSzhUkvnhEKGgOH8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508460; c=relaxed/simple;
	bh=azk6U8g/JFqvH7FTtMmTgCO4raAeREkG0pRfkcXX9ss=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KFsrsXTaNkJ3DvoIXyPvClcMbMW0Sni8W30I1ozf8M0YOoZK0VUSfe4d+T2Ge5YotCAaskLAmGrQfs9W5Qw+1OuM8ToEWIJ4Nf5qpq1quyqFbC+HUENPib86tQ+VBVkzQUgiWAkACZZdqL3Pa07QaeRi24E9ZuqcxT5p9UyZUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gHP8h8so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46623C2BD10;
	Thu, 23 May 2024 23:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716508459;
	bh=azk6U8g/JFqvH7FTtMmTgCO4raAeREkG0pRfkcXX9ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gHP8h8soJYQguI9OcU2OQzV6Jvnc+pHjBTbN/hmBwYznSLxlm54Dg9a0oex8FV7Zb
	 mAPyhfJ++NLF27gXzuEIjnDIFfjeLnk61t0+EO6YMF+6HDwB898MpuzAbFp8vVzO7n
	 KPm9ByZqUTM2WBboXJT9gtcKdy+tUuo0DGiJQO3U=
Date: Thu, 23 May 2024 16:54:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: jeffxu@chromium.org, jannh@google.com, sroettger@google.com,
 willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net,
 Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
 rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
 groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-Id: <20240523165418.242555ffc2372e59f88cabbf@linux-foundation.org>
In-Reply-To: <202405231628.BBBB9787F@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
	<20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
	<202405141251.8E9580E@keescook>
	<202405231628.BBBB9787F@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 16:32:26 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Tue, May 14, 2024 at 12:52:13PM -0700, Kees Cook wrote:
> > On Tue, May 14, 2024 at 10:46:46AM -0700, Andrew Morton wrote:
> > > On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> > > 
> > > > This patchset proposes a new mseal() syscall for the Linux kernel.
> > > 
> > > I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> > > of the total lack of Reviewed-by:s and Acked-by:s.
> > 
> > Oh, I thought I had already reviewed it. FWIW, please consider it:
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > > The code appears to be stable enough for a merge.
> > 
> > Agreed.
> > 
> > > It's awkward that we're in conference this week, but I ask people to
> > > give consideration to the desirability of moving mseal() into mainline
> > > sometime over the next week, please.
> > 
> > Yes please. :)
> 
> Is the plan still to land this for 6.10? With the testing it's had in
> -next and Liam's review, I think we're good to go?

The testing and implementation review seem OK.  But from a higher-level
perspective Linus doesn't seem to be on board(?).  I was planning on
holding onto this, see if the discussion progresses across this -rc
cycle.


