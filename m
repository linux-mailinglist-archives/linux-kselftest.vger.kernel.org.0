Return-Path: <linux-kselftest+bounces-25489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC91A24195
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12FC188604D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022D1EC00C;
	Fri, 31 Jan 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIFAUxDD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD631E883E;
	Fri, 31 Jan 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343483; cv=none; b=luuZFZmMvgidAZdBq/lD7JhdSsff+wJBdQwaYzViSlOG4eaA1b/DdbrSEKA7AcMcT61X2jsiG99wpyOacJYa6dc4rw8U8Kx4z5HZjw3wUqo6W0uea6oXU6pb4ogJ77qYIc759cwcO+P0peCLohH/p5521TOE7RNAcvcVR2Fs7eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343483; c=relaxed/simple;
	bh=DCplqvslcnVefmpVrCa3FsjAMgyXkITnIcGV0DXQ738=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTPN9KqY9AaSTXEdDY4NhlWWeVsyU9tnKLi7tX1lC5C0rtafnak15CzhXyXC6J04iv9qO+lR5R8wOjTTlB0HITKKCQyEbN7bkOinh3a7R9VGDB+dWucJEm2yitvEfTz8jjT6MigX9MyoRWp5fg1UHIyaHrywghcPfieHD8rJjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIFAUxDD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738343483; x=1769879483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DCplqvslcnVefmpVrCa3FsjAMgyXkITnIcGV0DXQ738=;
  b=OIFAUxDDduE+6ja5qsswtUG4SPTx+xuO9q3LCNQFexYKizjrRtHXGBZW
   yF8LBdngp6eyDAYN01RYyTu/o734Ttteg+spEltkOfBFcVaHeyokvu41z
   w5QnQzWDoTjbKcdnIqb125lM3lKt0RDJ8FFt32eC+cP8MsISmBT9tNjd8
   hiry92oMOJ9/OLrmk1/lGK3Qub3s24AhtvEHBGVSiBJkm4gMD2/sQwzML
   MH+ptN92q542Vc2yg9uRohynmWBRDRitSit8PwtNkUwcRd7IjxmqabrtM
   o/VHlv7+1YeWA7Ea1kD9ZKTigAv7qodC5d6GnH8wq2zwPeG5BbWrWwxbX
   g==;
X-CSE-ConnectionGUID: XDCO7Z9VQfagP70yQN64Mg==
X-CSE-MsgGUID: yO/lRCd3ThiUCjGUSQQoBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="49175681"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="49175681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:11:22 -0800
X-CSE-ConnectionGUID: SU2IXt7tSQut2WbM9cT21Q==
X-CSE-MsgGUID: l+iSg3h+Q/2ah5oMFNvVUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110131113"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:11:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tduXz-000000071Hu-3Hcn;
	Fri, 31 Jan 2025 19:11:15 +0200
Date: Fri, 31 Jan 2025 19:11:15 +0200
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
Message-ID: <Z50EM7gxqyV0Eois@smile.fi.intel.com>
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 31, 2025 at 10:47:49AM -0500, Tamir Duberstein wrote:
> Convert the scanf() self-test to a KUnit test.
> 
> In the interest of keeping the patch reasonably-sized this doesn't
> rename the file in accordance with usual kunit conventions nor does it
> refactor the tests into proper parameterized tests - it's all one big
> test case.

Rename of the file may be done, but you need to use -M -C when formatting
patch, in such a case the diff will be moderate in side and easy to review.

P.S. The test modules in defconfig is something which puzzling me. I would
remove all of them at once, if somebody wants debug configuration, they would
specify it and use with help of merge_config or alike.

-- 
With Best Regards,
Andy Shevchenko



