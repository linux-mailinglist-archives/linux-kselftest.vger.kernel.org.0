Return-Path: <linux-kselftest+bounces-26389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB4A31070
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46099188B789
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5A253B7B;
	Tue, 11 Feb 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGxvqXhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F43253B76;
	Tue, 11 Feb 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289499; cv=none; b=lamSP0hZLu0XN62UeDI3kxkeBa8p+mV4LSjk0wArB+V8miIWuzkhfuv64qg5UfxE7CUBJ4VFA6/ZAzRhBm7aCOmxKnDHTUHueNFgYYroUAmYgGG1PMCf+QQ7gbgg2PUXTDwVpwBSsJdRa/ig6UsFzk1RBm2BmpCabWqrEyltsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289499; c=relaxed/simple;
	bh=CPtrFdl8jK7P6wP04FdUfUnl7fLqn88GFso5Ury85T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfVIgKC7BX/8YlciVl9XTZpCw7gP3eStXOMh1ie2OpnGc5QydyCzcBzB12/0O0gKdRkY1QMwvV0GxLvf72sbIiC99WSYvECxUkTeB3XwXMVUIX/c8k4wBIiqVyNMzL5eWxBXrR5Z6ZmhP4pwIpVvD4dH/ta8rrCcg/AqkOxEj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGxvqXhb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739289498; x=1770825498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CPtrFdl8jK7P6wP04FdUfUnl7fLqn88GFso5Ury85T0=;
  b=SGxvqXhbPO1OiCjwvOlm7/gPIryCzxm4LRYzTHW5ajDtft9oKvD8DUpa
   MMCrsOnxNxYBpTxDQid0Ex/VoRPlLog8aM/1ylBkaRI+P9dIyqUkg8rPI
   GRe9J9s/4HFWcrFr/YuHySmx7EE0bmRkYq6uvg19tWjiHwTCr57rWmuwj
   Mp6go+S7iC9uiPN8t/fsY1UnW/mMyCWW/83nAi67G5wHobeYVGQTNJ2JX
   GL61D5+LMe2JJV8IZVOq/AFN/1mpMK9bB2Gqd5vernK9dZjDRrTpO8suX
   kbCvmpo4jJ67vPiJ8eNYJoM8c9wAmboDAXcYiGz2jOLFRt3V8gYjBsPY/
   g==;
X-CSE-ConnectionGUID: u9WLffboSDuOvVJMpcCQLQ==
X-CSE-MsgGUID: 5MDMJueUTEq9KwJgZ+T0Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40057318"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="40057318"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:58:16 -0800
X-CSE-ConnectionGUID: CMmbT6r2Sp+ns8OmUeuvJQ==
X-CSE-MsgGUID: CFw5GSEbQzScBvSBndgDBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112408997"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:58:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thseH-0000000AYLx-30r2;
	Tue, 11 Feb 2025 17:58:09 +0200
Date: Tue, 11 Feb 2025 17:58:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 1/3] scanf: remove redundant debug logs
Message-ID: <Z6tzkY375ffTVEXQ@smile.fi.intel.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com>
 <Z6tvzhZIMVKWH8kK@smile.fi.intel.com>
 <CAJ-ks9=Bf42eojROr1X+BnmeQLa=zF7EAr4Y3n2exwZXum+rbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=Bf42eojROr1X+BnmeQLa=zF7EAr4Y3n2exwZXum+rbQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 10:50:33AM -0500, Tamir Duberstein wrote:
> On Tue, Feb 11, 2025 at 10:42 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 11, 2025 at 10:13:37AM -0500, Tamir Duberstein wrote:
> > > The test already prints the same information on failure; remove
> > > redundant pr_debug() logs.

...

> > > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);                              \
> >
> > What *if* the n_args == 0 here?
> 
> Then there's no assertion in this block, so the test cannot possibly fail here.

Correct, but I'm talking about this in a scope of the removed debug print.
I.o.w. how would we even know that this was the case?

(I'm not objecting removal, what I want from you is to have a descriptive and
 explanatory commit message that's answers to "why is this needed?" and "why is
 it safe to do?")

-- 
With Best Regards,
Andy Shevchenko



