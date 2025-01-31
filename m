Return-Path: <linux-kselftest+bounces-25495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F1A2423C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7590416879E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B21C5F29;
	Fri, 31 Jan 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiKXZsBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFF1DFF0;
	Fri, 31 Jan 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345822; cv=none; b=txMJwsCcbYgJLalsgwWvTUgIJvk+VCU0oSh4VKYlZ1+N38wGfR0fZMgFL8jC6B+5k0FPUDytA5IK4FiaxBUiauV0UZ6CjLl0lw1ejfQ/4plN4iw8hVts+u1G8V8OzsQDANA3OqNaJLIGBoTWh6Mwa2UY/+K9B+zMSivtsfhqc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345822; c=relaxed/simple;
	bh=47APOwbK8ggY98CYWGPzEI2INIWNwUIA6pkDYgtMpkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P67qT/3YbLl2A5hzPI16RaZOK3GllXicTtKVqspbFaU/dtwFq2k3vU8kY7HdAN+9gQJamDlk/DYY4yqv+9kRybSFFY5xk1bFYGUQ2Iw+rpKSC/ui93OGKmKTgI50pZ7WMzL3clm6r3Qrgfxl3TRvhM2XTf3eVuhUwRhwRWlX5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiKXZsBP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738345821; x=1769881821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=47APOwbK8ggY98CYWGPzEI2INIWNwUIA6pkDYgtMpkM=;
  b=hiKXZsBPsSwp/Sc5bKSjpZJqgS3pnzf+J7rkN8Mnium83Va5fyzU6pTp
   j0ZnGtCPknSsE+RmNcba7XtzbzCEE4H/nHrPuxrvPd1t9o/m73ftcmPns
   JM5y3eBg5upbuYD+MJic03nKqPsbaTBtEx6WZRtEucUpR1iqoHN0A7Fhx
   JJ1zj/XMo4n2tKJBeVyz5S9TwPD4/BN+M+ogYAbYMEmKHWtJUBGJJju0v
   /d4uGhLjE6GkZ1YX2TtaUqFdXbebbXoYK2Qvgrt+UPsM42aYHJcNFmlkp
   Pnq8PqTVagQ36WpZAq5EcdMKpZ5hjjF4MN9bLLwaG73/K0P2iEp3sEuYI
   g==;
X-CSE-ConnectionGUID: OrCSZ0RhRa6b0ZX0jvTD4w==
X-CSE-MsgGUID: sCs+yIrJQD+mavsfwCUUhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="64281979"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="64281979"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:50:20 -0800
X-CSE-ConnectionGUID: eVpbFSX7TvSB4CDeCN9v7A==
X-CSE-MsgGUID: 0joLOVx7S9CpIVEryDlhGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146878204"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:50:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tdv9i-000000071mO-0Zjy;
	Fri, 31 Jan 2025 19:50:14 +0200
Date: Fri, 31 Jan 2025 19:50:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] scanf: convert self-test to KUnit
Message-ID: <Z50NVYKv7JBn10hj@smile.fi.intel.com>
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
 <Z50EM7gxqyV0Eois@smile.fi.intel.com>
 <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 31, 2025 at 12:22:39PM -0500, Tamir Duberstein wrote:
> On Fri, Jan 31, 2025 at 12:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Jan 31, 2025 at 10:47:49AM -0500, Tamir Duberstein wrote:
> > > Convert the scanf() self-test to a KUnit test.
> > >
> > > In the interest of keeping the patch reasonably-sized this doesn't
> > > rename the file in accordance with usual kunit conventions nor does it
> > > refactor the tests into proper parameterized tests - it's all one big
> > > test case.
> >
> > Rename of the file may be done, but you need to use -M -C when formatting
> > patch, in such a case the diff will be moderate in side and easy to review.
> 
> If you prefer that I rename the file, I can do so in v2.

Yes, please.

> Can you explain what you mean by using -M -C?

Parameters to `git format-patch`.

> The formatting was done
> by hand, is there an automated tool? I tried using clang-format but
> the result was a change on almost every line.
> 
> Note also that though it looks like a lot of formatting has changed,
> in reality almost every changed line has non-formatting changes due to
> passing `test` around.
> 
> > P.S. The test modules in defconfig is something which puzzling me. I would
> > remove all of them at once, if somebody wants debug configuration, they would
> > specify it and use with help of merge_config or alike.
> 
> I'm not sure what you mean? I removed instances of CONFIG_TEST_SCANF
> from defconfig because that option no longer exists.

There are other options like CONFIG_TEST_PRINTF or so in defconfig files.
Why are they there to begin with? The answer to this Q will affect the change
you have done in this patch.

-- 
With Best Regards,
Andy Shevchenko



