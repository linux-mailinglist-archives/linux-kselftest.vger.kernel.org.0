Return-Path: <linux-kselftest+bounces-26664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81651A36291
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E510188C4EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96B7267393;
	Fri, 14 Feb 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaMKWUHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0EC266EE0;
	Fri, 14 Feb 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548955; cv=none; b=FWeyveDAJlU1OKj7LUyCj7RSS4ind8DuMxc+2K9rZ4TdQERJBIcfb2yeC37I5OmkTCvEGFpEamDU8BdyNDCAbu08sKcNV5OouNyXYVhUCLPdAPjqPr2z8HL95KLM+G9UEsw9zSn4i3f3hvCAsGCyKsw/PaeNtj34GOcbKu2oz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548955; c=relaxed/simple;
	bh=BP0F6Q1wNrUjUl3+JXUo0rphKo1JR7S7n/NVPl/WTLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P83qv+xa0B3cTI6tUowqmEoHphMrAEAWAc9Gcn8OZvFju3eP6hYiqLuvKGFOZWThDPsK5INACdUDY8lM5edENUl71y7gdxA1R7m5c92Zi+GGpd3iFjY45m61LgK+ILiwFNkiYJokPzxXoGPSo1RFBTV5b8Vmk1Dqg+z3T8HhLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaMKWUHG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739548954; x=1771084954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BP0F6Q1wNrUjUl3+JXUo0rphKo1JR7S7n/NVPl/WTLQ=;
  b=YaMKWUHGGAhkb1IVrQBCbav7/076W16jA3FMFD2jJ+TW1oArBA9WFBuX
   ETpuRJkUna/RbM/Gy3r+dwHlm8B6ldNAA3m1avSTDyHniUrumDkWBe4c5
   SuQu8UCZu4/+An94yRtDddmnAZwzbxdOFqf8v911qX5phVW+vxyxbnVxS
   L16kWao0w9eEZeaI8lhNamG0BYVhLCBpVROYVY5HTqDdOisHWzaQNeZ1l
   EzR4uvoh0i6rk6+xHolvUunqisYiMStBZjM9Dq8D5MY+G67JOSoLuTLSP
   h00GPSBT9l4SG6XFhpTa/BNY+hOQH4xJTF7xcgt18nLnatur/mWZ/MMtz
   w==;
X-CSE-ConnectionGUID: nvNWeIfgTVm7chGPby15hw==
X-CSE-MsgGUID: 49bTjfIlRL++AwzlBo//RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="27902468"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="27902468"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:01:30 -0800
X-CSE-ConnectionGUID: +xTXFr+5SXO11Fa5Mdq1nw==
X-CSE-MsgGUID: uC30yGarSOyVHPzD+Hscrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114132370"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:01:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiy7q-0000000BXQx-1JPb;
	Fri, 14 Feb 2025 18:01:10 +0200
Date: Fri, 14 Feb 2025 18:01:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/2] printf: convert self-test to KUnit
Message-ID: <Z69oxhkUzTfJ6YKi@smile.fi.intel.com>
References: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
 <Z69isDf_6Vy8gGcS@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z69isDf_6Vy8gGcS@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 04:35:12PM +0100, Petr Mladek wrote:
> On Mon 2025-02-10 13:23:21, Tamir Duberstein wrote:
> > This is one of just 3 remaining "Test Module" kselftests (the others
> > being bitmap and scanf), the rest having been converted to KUnit.
> > 
> > I tested this using:
> > 
> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf
> > 
> > I have also sent out a series converting scanf[0].
> > 
> > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]
> > 
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> 
> I have just quickly tested this before leaving for a week.
> And I am fine with the result.

Seems reasonable to me. But I want a consensus with Rasmus.

-- 
With Best Regards,
Andy Shevchenko



