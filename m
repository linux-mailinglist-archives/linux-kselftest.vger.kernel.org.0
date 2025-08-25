Return-Path: <linux-kselftest+bounces-39815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50BB33360
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 02:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD66201E95
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E48156237;
	Mon, 25 Aug 2025 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xWdozaNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E34A02;
	Mon, 25 Aug 2025 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756081044; cv=none; b=pxXXZkj96YetA4aoXuljOrzRhve2y+99aKa5b2tU/xYxEWsQ1oZ17wfaJytJhHY5otAjeZCUeSyLP5hJ/a7Om41U7XLrms/rxzzPJc/d3p0yS0OUbBulYXh3JAiYMPl5c+CPxSLy9GLaKx3AL+ILha9DzlIG773Te/HEr8X57IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756081044; c=relaxed/simple;
	bh=+Za+wb6QlHF1oKYfGWLR5av6WtH0xmMNI+APb0Y7x4Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oZi8xC4KZZN3VsMYZwqFQNwPIGXytBdnCyaclzyMsYA14EPmUm58Hl9++2aQnNwJKhmzNP0nAfxVFQ4gQl1RvVzA0MZwctVXxSOZAVV2EJm+Xwg/CIK+F6AOrGeYC9aWwZTAoVRXjXAdQNKToC1s1CfOzXylTQQPIbUWExrTWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xWdozaNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D48C4CEEB;
	Mon, 25 Aug 2025 00:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756081043;
	bh=+Za+wb6QlHF1oKYfGWLR5av6WtH0xmMNI+APb0Y7x4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xWdozaNUWTmGFXHzJFS5GZ8QXqnbZtN3AvSpzBqbjScoXDixsEO6vXIenhumbcla4
	 8/5+eJbB1Bh7BTq9IGPn4zRCdCcX2vahmbtONiBS9f6GVrHlE3CjuR3vTtTAM/am5i
	 j04OlJ172kNwu77bDTGfxdPhs+SB323Gn6wbzooE=
Date: Sun, 24 Aug 2025 17:17:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: ally heev <allyheev@gmail.com>, skhan@linuxfoundation.org,
 david@redhat.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: mm: fix typos in test_vmalloc.sh
Message-Id: <20250824171722.ea915592ea3bd060c6b17a38@linux-foundation.org>
In-Reply-To: <aKq25rlqbyYDaWVo@pc636>
References: <20250823170208.184149-1-allyheev@gmail.com>
	<aKq25rlqbyYDaWVo@pc636>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 08:53:26 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> >  run_stability_check()
> > @@ -160,7 +160,7 @@ function run_test()
> >  		usage
> >  	else
> >  		if [[ "$1" = "performance" ]]; then
> > -			run_perfformance_check
> > +			run_performance_check
> >  		elif [[ "$1" = "stress" ]]; then
> >  			run_stability_check
> >  		elif [[ "$1" = "smoke" ]]; then
> > -- 
> > 2.34.1
> > 
> > 
> ./scripts/checkpatch.pl ./0001-kselftest-mm-fix-typos-in-test_vmalloc.sh.patch
> WARNING: Missing commit description - Add an appropriate one
> 
> total: 0 errors, 1 warnings, 24 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> ./0001-kselftest-mm-fix-typos-in-test_vmalloc.sh.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Can you add a commit message?

A changelog would be identical to the subject.  checkpatch is being a
bit excessive here.

Oh well, I'll add the obvious text.

