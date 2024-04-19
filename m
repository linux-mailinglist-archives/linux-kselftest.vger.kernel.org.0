Return-Path: <linux-kselftest+bounces-8404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA118AA875
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714DB1C20E5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB4D22F19;
	Fri, 19 Apr 2024 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aICcYNMu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCF79F9;
	Fri, 19 Apr 2024 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508442; cv=none; b=g1WDdRpAWoWJqiExH4dlWVXUQX12CCk0dyki93YMgbPD2ck7m4IuwmRDkwSiWQJI9fsGhM/X+6jvaZIKD0MSXTmVgZnrO1FUS5mlDKQwWkH8J6MT48I4OFapPijzVkpO5qG6arLYidAfRJkpU6iySKftJXyyUU8E8M5n53Q6RJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508442; c=relaxed/simple;
	bh=V427dVNaf8/qaI8BGACYOJtsWEOTY36TLQHbLwTxGeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwzeL2q2jZWO/RSuhCYN/Egu4oCWnLRLJt9uE+aN3fGgv00b00h3owLSBDbZqhPt+kN5+P6LFYWX0Xm3EgNQG+MyRu+E+HJ2kehAo7/4YzHIo7HCJ+rZg+nVORYZhkHKWpD8xotk+4/ZV8o2EmnoPOL0YB3DmR351P5jnTYpPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aICcYNMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB64C072AA;
	Fri, 19 Apr 2024 06:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713508442;
	bh=V427dVNaf8/qaI8BGACYOJtsWEOTY36TLQHbLwTxGeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aICcYNMujuqMbFyCMqjvdmwHys4mdXRRmDK9AVcWuVlEXYYGnJjuTpA9TklLC0cIQ
	 ngbJsSJL2HIdFKWRc1sjWF9+FFqCXA8FTqDAD9FDTi9gJVjHy2RAuTEk4opSTIwlvt
	 IxAzIjAK1AH2YbHhjeqeadVt3M6DndkgDvuLSZsI=
Date: Fri, 19 Apr 2024 08:33:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Wander Lairson Costa <wander@redhat.com>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] kunit: avoid memory leak on device register error
Message-ID: <2024041919-untrimmed-palatable-1350@gregkh>
References: <20240418210236.194190-3-wander@redhat.com>
 <b18c2e4b-bf61-41ad-b5f9-8e52d7651cca@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b18c2e4b-bf61-41ad-b5f9-8e52d7651cca@web.de>

On Fri, Apr 19, 2024 at 08:15:25AM +0200, Markus Elfring wrote:
> > If the device register fails, free the allocated memory before
> > returning.
> 
> Can a description variant (like the following) be more appropriate?
> 
>    Free the allocated memory (after a device registration failure)
>    before returning.
>    Thus add a jump target so that a bit of exception handling can be better
>    reused at the end of this function implementation.
> 
> 
> Would you like to replace the word “register” by “registration” also
> in the summary phrase?
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

