Return-Path: <linux-kselftest+bounces-20704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C449B0FE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 22:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FDFB22508
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6AB214439;
	Fri, 25 Oct 2024 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgep87V4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D50214436
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888700; cv=none; b=spG/lAJWf+1EWOIMH0KCoDi3EevSrLB1fHP7fzPu5rKqdZuRYVMRZfCXjnV5g9zZ0Qh5MFNjfpIIhAnOY2obDH1l6/N5USDj01ZJfKcDDfBvdq+Txfazncab9nPFW4lxaBkAzCsHL+ZIJRdZ0tyKEAGUPKv6T2WvgqFXkq/D7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888700; c=relaxed/simple;
	bh=SfmozoMwbNXLhmq2uPndy4BMkkfVSEcsuSqJQX/CojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvBeo3I3TfvwIR/f3gRsAVs/DsHT1aem2McnTvH2ZZVXHu5xrblmgnYQ3MmfBtqQuptltG6DRQN9pGmx4RFjVGRBvFaH6mk7crIl0Qb06OOVU0sktfiIfmLhUzYb5rSUlaV56AEvnugozVD9DsFARfbJe3UnWrSE897esGu2Evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgep87V4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729888698; x=1761424698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SfmozoMwbNXLhmq2uPndy4BMkkfVSEcsuSqJQX/CojQ=;
  b=kgep87V4SQzoIsXqlpikUivaLOoOmklSIW7Cbyzsa4nI1ZvER4vzJ7lG
   xqO71PTricxDFJl5itkX7ltL0idxXMciiwUEZ67ZkCZ0SPNugKIhQbTVz
   9h+GfIku8aWJ9XEZ1IjChUP+NoKnDuWfUmOrlf/sqvv1+cAypolX0/aet
   LQ/evh9oXfm0DfNj/QmuDpVVRyqPSlYqHFM+/BgfVEv88fLiQjeupY+oQ
   23c2bAQCAXfGtkK2PgMYfXZsAJ/4aNIWQO/F1iqHjJrho7r0JsLgozqG7
   Qt/XANEIjcdQRjdx8AGFD6zwPAiS7Zi/WO1COnFOtXd5YqPEZHQcYPX9+
   A==;
X-CSE-ConnectionGUID: w3gPRQoYQFSKdrnQbFsXrA==
X-CSE-MsgGUID: /t/l3cosS6iKCKDFKxwqeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="32429467"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="32429467"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 13:38:17 -0700
X-CSE-ConnectionGUID: UVW8dj2zQPK7QmH8OYpO4w==
X-CSE-MsgGUID: Vo3Au4/nT+GVTdfNymIz9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85628566"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 13:38:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4R4V-000000074dd-3rXB;
	Fri, 25 Oct 2024 23:38:11 +0300
Date: Fri, 25 Oct 2024 23:38:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib/math: Add int_sqrt test suite
Message-ID: <ZxwBs9TkQdYilRdn@smile.fi.intel.com>
References: <20241024195511.72674-1-luis.hernandez093@gmail.com>
 <Zxu3Nd_xdOIdyYl9@smile.fi.intel.com>
 <ZxvumQ3Od2lXYknp@x13>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxvumQ3Od2lXYknp@x13>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 03:16:41PM -0400, Luis Felipe Hernandez wrote:
> Thank you for your feedback and patience Andy. I apologize about the
> hastiness of the v2 patch. I've addressed the feedback and would like to
> wait for any additional reviews before sending out a v3.
> 
> In the meantime I wanted to answer the questions posed to the best of
> my ability.
> 
> > Shouldn't the thing to be in lib/tests/Kconfig?
> 
> The Kconfig entries for lib/math are located in lib/Kconfig.debug as per
> David Gow in https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/

He put it as "Somehow confusingly, ..." meaning to me as a signal that he will
agree with me that moving that to lib/tests/Kconfig seems like a right move.

> > Where is this? I don't see it right now in the Linux Next...
> 
> It's a previous kunit test suite, it should be in both next and mainline
> Makefile: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/lib/math/tests/Makefile?h=next-20241025
> Kunit Test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/lib/math/tests/int_pow_kunit.c?h=next-20241025
> Kconfig entry: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/lib/Kconfig.debug?h=next-20241025#n3103
> 
> The Kconfig entry was fixed in next by Kuan-Wei Chiu in https://lore.kernel.org/all/20241005222221.2154393-1-visitorckw@gmail.com/
> which I had incorrectly placed at the top-level in my original patch,
> hence the discrepancy in the location on mainline: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/Kconfig.debug?h=v6.12-rc4#n3092
> 
> One more thing to note is that there is a patch that organized the tests
> in lib/math as per the documentation:
> https://lore.kernel.org/all/20241005222446.10471-1-luis.hernandez093@gmail.com/
> Which resulted in a conflict and the fix was carried over:
> https://lore.kernel.org/all/20241009162719.0adaea37@canb.auug.org.au/
> 
> Again, I appreciate your time and review. I hope this answered some of your questions.
> I'll continue to follow this thread so as to make any additional fixes
> from further reviews before sending out the next version.

Okay, I will wait for new Linux next tags.

-- 
With Best Regards,
Andy Shevchenko



