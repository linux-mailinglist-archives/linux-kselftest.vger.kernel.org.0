Return-Path: <linux-kselftest+bounces-19916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA59A1A6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262D2288B05
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC816F8F5;
	Thu, 17 Oct 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHBVP/+L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB814A0B8;
	Thu, 17 Oct 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145042; cv=none; b=lPjlfBmVuTi0KgSJ1MVRiZ4zpMQwg0Cxi1+/KKwuhMNKKheD1X5IGnPm/T8Rmon+UR3naloO+4eFaUuXlbK90CoA8ak6F8LgxBoF5G2mqCXE5uYaK/IjFYzEbEu6ATaYwVv+yT5OwM7W08I8kLSSi0k0RHlOgNrMS2MjEem4h3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145042; c=relaxed/simple;
	bh=X2+GJH0HSRuttevd7H/GoUXpL9DzliRti/5gVBqOrmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyGQpgnPHVjmlcTtwI1H1n7fn09pq27ib0JQLtcg+2NM+/9YJiY694JGV1y/e546aVtKt2cU+NEsCRVhU7MuvMt+LYuxECH0f+vLfqFkLBvfsPrwb2tqe774skPCJdAj7rv1gSIGRv25xaGYbyvDG40MpB8t143NF3S0HMwMLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHBVP/+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B107C4CEC3;
	Thu, 17 Oct 2024 06:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729145041;
	bh=X2+GJH0HSRuttevd7H/GoUXpL9DzliRti/5gVBqOrmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHBVP/+L6v//F10lcFEdWtmIk7VaT9jpaMl/sjhNG7bGRxv7jSyy7qgQwZ28o1LZM
	 A65P5MKddi2jx3K6WTUAlcumnMS2b87yQ6m2hpNBpBynvCxp/cQMtGpW7W1WaHO3jg
	 gsllQKRbKQEP03AH0CGQkhI43/HOLTqa4Q6QzFyw=
Date: Thu, 17 Oct 2024 08:03:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	corbet@lwn.net, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
	pedro.falcato@gmail.com, linux-hardening@vger.kernel.org,
	willy@infradead.org, deraadt@openbsd.org, surenb@google.com,
	merimus@google.com, rdunlap@infradead.org
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
Message-ID: <2024101722-diligent-baritone-b211@gregkh>
References: <20241017022627.3112811-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017022627.3112811-1-jeffxu@chromium.org>

On Thu, Oct 17, 2024 at 02:26:27AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> It appears there is a regression on the latest mm,
> when munmap sealed memory, it can cause unexpected VMA split.
> E.g. repro use this test.
> ---
>  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

