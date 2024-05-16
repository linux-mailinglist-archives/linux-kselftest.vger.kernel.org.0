Return-Path: <linux-kselftest+bounces-10288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ACF8C749C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2BE1F24B96
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED4143C40;
	Thu, 16 May 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPfUkLrk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA778143898;
	Thu, 16 May 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855198; cv=none; b=AxFI+LrAknVnfGFmLfV9x2WFOzNDLeujCIRYq0HZdl8gXSo0fa++76/Ua90kN4Uni5W6ERWFm8MnEK2eD9SLrbiGlDXfbktEYw/YI4BPpxTsNG+hpeP4xQMg/uUZwtChirksPKIpr2k43Ap0BWAp3LBLbUGqus0jjoknXunlfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855198; c=relaxed/simple;
	bh=6irmRYyO6aI1ugOg4kgQ1h12u9uSfnzT47OyGU1W4lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3xk7SBDqaPCYmTEKSEhsoTbyn0fA9/wJ5njDnl9dY5fnXVjMb8dbO/MoRlFr80k+p7d6f10jR3LRJwFkApGIcE+qsmgu3mh/7r6M1pFhOQbogdqOrCNd77AuDy1sYnlNP7hQO+oSujTfh6+vt/tF1tjFG3r51GGRpS0JfGiTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPfUkLrk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715855197; x=1747391197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6irmRYyO6aI1ugOg4kgQ1h12u9uSfnzT47OyGU1W4lU=;
  b=gPfUkLrkA2ENb63pkQ5Vkc65+90OrU89BJbru95RfpLwEoCFQNXVqADp
   wyhe6ANPEqzLc9obHB6C0PECeLcori1HzitCFSWWpcHSs9yPcSOhei/gD
   vWsDSYuyFS1hXOcSYafTaxW7c4hAJFfHF3TG7FGlgsXa9bJt22BYx70HZ
   Mq2MiQWS0Z9sXevbfSBeKwLwWwO8sxUAiW7LD0Tzyw3cVoxupHMoTxq8/
   aTgSPkNzaSqNpE4XS4PntugGEKtB9tVy4HSvjuIKQOXBwXCRFDxLNoJyV
   VdUYzP9yaHZoxwt6RjCFXmdvcQ18xzq2Om1sO5umb+IjffFJDXdz+r++z
   A==;
X-CSE-ConnectionGUID: 4gD4A0KaSrOGFGFNLON+Dg==
X-CSE-MsgGUID: kPv/2X+PQUivodWnEahB0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22559639"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="22559639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:26:36 -0700
X-CSE-ConnectionGUID: +iBBDJxASNmMxB7aHGkj8w==
X-CSE-MsgGUID: 0/10U3klRTirxFvbJ7jXGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="36265589"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:26:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7YJi-000000080YQ-1zYF;
	Thu, 16 May 2024 13:26:30 +0300
Date: Thu, 16 May 2024 13:26:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
	davidgow@google.com, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v6] lib: add basic KUnit test for lib/math
Message-ID: <ZkXfViBFU0BWpOMM@smile.fi.intel.com>
References: <20210416180427.1545645-1-dlatypov@google.com>
 <b7155efb-e99c-f385-3bf3-3ffcdefd1260@ti.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7155efb-e99c-f385-3bf3-3ffcdefd1260@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 16, 2024 at 03:49:44PM +0530, Devarsh Thakkar wrote:
> Hi Daniel, Andy,
> 
> On 16/04/21 23:34, Daniel Latypov wrote:
> > Add basic test coverage for files that don't require any config options:
> > * part of math.h (what seem to be the most commonly used macros)
> > * gcd.c
> > * lcm.c
> > * int_sqrt.c
> > * reciprocal_div.c
> > (Ignored int_pow.c since it's a simple textbook algorithm.)
> > 
> > These tests aren't particularly interesting, but they
> > * provide short and simple examples of parameterized tests
> > * provide a place to add tests for any new files in this dir
> > * are written so adding new test cases to cover edge cases should be easy
> >   * looking at code coverage, we hit all the branches in the .c files
> > 
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: David Gow <davidgow@google.com>
> 
> Just checking if something else was pending on this patch-set for this not
> getting merged?
> 
> I needed this patch-set for adding tests for new macros I am adding in math.h
> as suggested in this thread [1], so wanted to pull this in my series and add
> changes on top of that for new macros.
> 
> Kindly let me know your thoughts on this.

Wow, blast from the past!
But good finding, it would be good to have more math.h related test cases.

-- 
With Best Regards,
Andy Shevchenko



