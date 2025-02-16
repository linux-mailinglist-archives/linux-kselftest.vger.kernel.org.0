Return-Path: <linux-kselftest+bounces-26750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A5A37770
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 21:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8FF7A1A61
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BDF1A0BF1;
	Sun, 16 Feb 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cej9BBXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950218DF6B;
	Sun, 16 Feb 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739737347; cv=none; b=Jy6g0uBlJbr+Z/0SSo2F1aT++Kk11DSmX60yoWZdgl1k17TcSsgQ5WMANBvYUweS0qfORXUJ2n7LROK37/SGuRRS5IpKUj/lEDSUMKAlb1gbialFnrKFv+QZmqCMsrmgXEMYk/dFkXsaNZweqeuOKUURbv3tmmtTe18fQ1+MfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739737347; c=relaxed/simple;
	bh=a5Us3PrQ3IELKZ69K3ExOVYzXJxG1rP3K7AabLpjZiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZNOoMFdX7jHfaumd3G1B7aJRLHrcbUlUI6ONeuMADS0A71ANvISlNc/2S8d0UIG2OYhaN4WMErmW0HT8xZer2YsQOk38cXg352ccdAGj/v9Nby3D3AFtmmUiKkq8+nh7MAMwGR/QMVpuMyFD16bEyryWSWJOvhO3OJw8t9P5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cej9BBXj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739737346; x=1771273346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=a5Us3PrQ3IELKZ69K3ExOVYzXJxG1rP3K7AabLpjZiY=;
  b=Cej9BBXje+Q8uFbAW4K9cj3syLXBYBxFx4biuO0UXfe9bYgjrDyjT6JT
   OS8dS0YVaBGSGngNuYxH4kb/qrezq1sKH5j7+tKhpjNfE6iyMJA9HBkNi
   S5Mchy91ihrrdPDcVxo7j9zzRQY5K7xrQuAkxod7XzhYTtx8VB2M3XDzw
   KcjvUPw3gnE+WGx//wA6SOsQ0nwkK7sAGb3TFixSVBF8qm6/wGFKD0IN6
   IiWiO1FvIWZfyyMlf1bKd2wO4pfHQcb7o4q+wQeJ9BxKACza0bldIOMEu
   prSGMvT6wyMeWTxPY4jMTsHqo65ke6GRktmXSKfT8gkdS/8qaPPyVPfgP
   w==;
X-CSE-ConnectionGUID: 23/VpXqYRviJAoAT+HiJnQ==
X-CSE-MsgGUID: QgPkoHJgRK6T+UtcPq0NqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51832525"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="51832525"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:22:25 -0800
X-CSE-ConnectionGUID: fbXWpKeeRciwKUMUEHa8dw==
X-CSE-MsgGUID: tGZHl9CvRrKjERQCW2fIHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118095909"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:22:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tjl9d-0000000CCrm-42K8;
	Sun, 16 Feb 2025 22:22:17 +0200
Date: Sun, 16 Feb 2025 22:22:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: kernel test robot <lkp@intel.com>, David Gow <davidgow@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
Message-ID: <Z7JI-YtgZzmOtMDK@smile.fi.intel.com>
References: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
 <202502160245.KUrryBJR-lkp@intel.com>
 <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 15, 2025 at 02:52:22PM -0500, Tamir Duberstein wrote:
> On Sat, Feb 15, 2025 at 1:51 PM kernel test robot <lkp@intel.com> wrote:

> I am not able to reproduce these warnings with clang 19.1.7. They also
> don't obviously make sense to me.


Please, when reply, remove boielrplate stuff!
I have just wasted a couple of minutes to understand what's going on in the
message that is 2700 lines of text as the reply to the bot message which was
~700 lines.

-- 
With Best Regards,
Andy Shevchenko



