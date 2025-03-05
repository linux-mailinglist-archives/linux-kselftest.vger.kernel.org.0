Return-Path: <linux-kselftest+bounces-28317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C411A503EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A3B7A67CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5D2500CC;
	Wed,  5 Mar 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx2+7Mpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458724BBE1;
	Wed,  5 Mar 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190068; cv=none; b=lPB0V0sAtdSlZaBttdqu4nHc2sEraU6QREkBg6Gd2huMjC+ahF8SuPsj0XPWVI7RxjELI1CSxFsIevgN28sVeDiVxkbz4TF6P2Ow9vArL7MQteyeMdYYSQecx+ThB6Q+17WZkfHaV8gopq502UpDzmVfZ/0rSkdQxzERbSi2Ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190068; c=relaxed/simple;
	bh=4FO7zfHuqw52xFA6APgrJdJ15F1svGjafUi3DaGKuBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1YMeTR5kOPBtAbG25hw3oyRabAXDWfd0iVPTYvo2M29fOSJ0UZWpT+mPMHFgFqaZgo8y3q35anbxae3cdJvnpNbm9FpY2Vr9yV+x4S2P4QqY5WW0ib84sUNs+ZHPu668Xw3nHOw6awJ0WMnpgrdZJ8N33tPoKBwo7SPyPOhvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx2+7Mpq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741190067; x=1772726067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4FO7zfHuqw52xFA6APgrJdJ15F1svGjafUi3DaGKuBs=;
  b=lx2+7MpqJiiXWsBFXPrvilT5Q5cePrhjUDZC8OrkM33p1MO0JUXS2lJO
   iwtqBdguPrmRt+OlkYQSlxCIhLJxXOv4Wao489dDQDomVbM+4BHgsk/k0
   VOx4D/oV6Gy332JjOYYzs9ZaBJNvjsKwB1i70VjzYhu8DlFL4sGePYU6w
   2r8I2y1ojUAYZ0he1YwsV22PI4GDSRDz2UbT93WzTdvl9qSwpgPu7o9xA
   /Kwdfm+n9k0a4EF4M8YQGG1Hwb5GYnn1tOxvH7hInb8jVAiyw+BwOiv20
   fJ/v++VErXe6zNLIrdY/FrnJ7XZthropiJTleWNEaSudaPEQHyiRL1u6v
   Q==;
X-CSE-ConnectionGUID: fbeVnfE5T4SPJJJAwWN/1w==
X-CSE-MsgGUID: cSdQTTWyQxS211+BMzsQtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42067650"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42067650"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:54:27 -0800
X-CSE-ConnectionGUID: eof0d15zQsaIvluPb3OMvw==
X-CSE-MsgGUID: yKMkLMEWT7u1PQVAEPXDoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118890857"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:54:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpr4e-0000000HSKG-47Bm;
	Wed, 05 Mar 2025 17:54:20 +0200
Date: Wed, 5 Mar 2025 17:54:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
Message-ID: <Z8hzrMS0GIip-WkT@smile.fi.intel.com>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
 <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 04:01:48PM +0100, Petr Mladek wrote:
> On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:

...

> >  #include <kunit/test.h>
> > -#include <linux/bitops.h>
> > -#include <linux/kernel.h>
> >  #include <linux/module.h>
> > -#include <linux/overflow.h>
> > -#include <linux/printk.h>
> >  #include <linux/prandom.h>
> >  #include <linux/slab.h>
> > -#include <linux/string.h>
> > +#include <linux/sprintf.h>
> >  
> >  #define BUF_SIZE 1024
> 
> It would make more sense to do this clean up in the 3rd patch
> where some code was replaced by the kunit macros.

+1.

> Also I am not sure about the choice. It might make sense to remove
> <include/printk.h> because the pr_*() calls were removed.
> But what about the others? Did anyone request the clean up, please?

Header inclusions is a pain point to me in the kernel. Esp. misuse of kernel.h
or other headers to behave like a "proxy". If no-one even asked for a cleanup
it's always good to follow IWYU principle as you mentioned below.

> I do not want to open a bike shadding because different people
> have different opinion.
> 
> I would personally prefer to keep the explicit includes when the
> related API is still used. It helps to optimize nested includes
> in the header files which helps to speedup build. AFAIK, there
> are people working in this optimization and they might need
> to revert this change.

+1.

-- 
With Best Regards,
Andy Shevchenko



