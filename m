Return-Path: <linux-kselftest+bounces-25496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E314A24240
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266753A2FA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D21E32CB;
	Fri, 31 Jan 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHJT52Ad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FD1CAA79;
	Fri, 31 Jan 2025 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345875; cv=none; b=k67TukyNpYWz/BbRqhoVMarm2XmsbSVom+V5XmwHQNiZQlX5kQYbzSVrnmOwiVLxPqFI/ErtQW8fcdNbbNAMOelVf1QysXu61j181VlGJaSB5YflFJJxgJ4ytEmZZCIc1yhujRiopWUHa5oyIVCnILB9alEkCUfoqYq0UY6fInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345875; c=relaxed/simple;
	bh=Xwadh5PqwI0dm0AWWEBcU7Q/VCycmtldXQEouGiDxmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi8cPheddmG18a4AGGMHd+IFwAoItLF5ZNB9TaPxr3k3TE58oXYXgqzc/raq34HXOwwaj7kfUMNBGPBRqc6amDgHkoC55OxX0mQrytst4VygliN8XOnRifZOnF1O7LCEM292jUjDulsbvw/UVNT6qgZcUd5OYQYOfazXgSyfWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHJT52Ad; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738345873; x=1769881873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Xwadh5PqwI0dm0AWWEBcU7Q/VCycmtldXQEouGiDxmc=;
  b=gHJT52AdcmXxpeXCANvGSWhxDnGokEVrPiuhgmCXTShv3r/k+DmtV/YI
   rrSONC5B/toXdO9kkwLzRKhLVEWl/uNPqlpONKE5mgo0NN5kBgxvHYx4z
   tY2I5YPjZq+EOweY+qeTfaJcq5p+ZpFvr9NDkWodqMTvbUCqLC6bV+Rrs
   usZrROTG97KHsukdVZtV7HQhrt+uNAekAOddcca4ySk4HgJ2Wizae0o/x
   HMPJHDbUx5Lq4icmFps5TALV/MmlH2P/GDfYcLPAz8eUpW2sd6FeTM0pR
   WnswH3rGWY6s95jTZa3VM7wVbksJeXShXHi08Tyg8m6zjLT9JEFLRblBE
   w==;
X-CSE-ConnectionGUID: vNe9UBYIRmqAu02K87+Ngg==
X-CSE-MsgGUID: hTspBeYvTueKYEkRPFq0Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38810479"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="38810479"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:51:13 -0800
X-CSE-ConnectionGUID: CtQHtvmiRe+kvZgVedd3gw==
X-CSE-MsgGUID: mbp18H8QT/O90yXk5rzUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114837847"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:51:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tdvAZ-000000071n1-010n;
	Fri, 31 Jan 2025 19:51:07 +0200
Date: Fri, 31 Jan 2025 19:51:06 +0200
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
Message-ID: <Z50NipTu1jGT8pur@smile.fi.intel.com>
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
 <Z50EM7gxqyV0Eois@smile.fi.intel.com>
 <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
 <CAJ-ks9=N8TkYjCm0fSFvoMNHKV2uJNrWJW5oCJziz6JgL2ObMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=N8TkYjCm0fSFvoMNHKV2uJNrWJW5oCJziz6JgL2ObMA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 31, 2025 at 12:25:20PM -0500, Tamir Duberstein wrote:
> On Fri, Jan 31, 2025 at 12:22 PM Tamir Duberstein <tamird@gmail.com> wrote:
> > On Fri, Jan 31, 2025 at 12:11 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > Can you explain what you mean by using -M -C? The formatting was done
> > by hand, is there an automated tool? I tried using clang-format but
> > the result was a change on almost every line.
> >
> > Note also that though it looks like a lot of formatting has changed,
> > in reality almost every changed line has non-formatting changes due to
> > passing `test` around.
> 
> Ah, you were referring to git format-patch. Sure, if you'd like me to
> rename the file, I'll use those flags in v2.

Yes.

-- 
With Best Regards,
Andy Shevchenko



