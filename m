Return-Path: <linux-kselftest+bounces-22707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67A9E08A1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3631C173A6E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126CA13AD33;
	Mon,  2 Dec 2024 16:02:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E63FB3B;
	Mon,  2 Dec 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155324; cv=none; b=HcMdCvKUyKoO5FMwg2OcUhEyg6rZW3uRcN0lQhiYBoySCTxcIsX2mwK7mcYA9X+BF764ylEYTwTNuajg7T1yqGEvtnLScOqrICifJHJEXMRXhU5fSLFRvHg+OgTjBQJtwbJvGNoHUW0kXyEkN9GVOvhVsl9eh9gcwf49fIAi8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155324; c=relaxed/simple;
	bh=YdtFzfmfCgaEaTmMKoE+ak3D7famQJf8ZgAIVhXwNWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGDvYr+sg0pE+8XyWDTFEAgBLjpZBKLGHXrXvUybLaVSEViEDpKAmcIOvcSnfqAZlYa+yvblfFqXlXMGf9z1RrX3aoW09mbt+PP25+5bj4Jq1BbURuu/e3zKlGtOY3zYHKpBC4bcUXdzEW3leOIYrYG1hdMgVI2J4PJNscBYDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: PykFoYHoSrm7bIPL4PnTJQ==
X-CSE-MsgGUID: n6I264ASQDqba82B8zz5/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44706503"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="44706503"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 08:01:41 -0800
X-CSE-ConnectionGUID: UnHBZLQvSYqvgOHarHL9pg==
X-CSE-MsgGUID: v/TWbRrXQCaXe8gI7V1SPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93457502"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 08:01:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tI8rf-00000003BcB-1JwS;
	Mon, 02 Dec 2024 18:01:35 +0200
Date: Mon, 2 Dec 2024 18:01:34 +0200
From: Andy Shevchenko <andy@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Rae Moar <rmoar@google.com>,
	Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Brendan Higgins <brendan.higgins@linux.dev>
Subject: Re: [PATCH v2 0/6] [PATCH 0/6] KUnit test moves / renames
Message-ID: <Z03Z3k3OdK4VHEh5@smile.fi.intel.com>
References: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 03:55:37PM +0800, David Gow wrote:
> As discussed in [1], the KUnit test naming scheme has changed to avoid
> name conflicts (and tab-completion woes) with the files being tested.
> These renames and moves have caused a nasty set of merge conflicts, so
> this series collates and rebases them all on top of v6.13-rc1, to be
> applied minimising any further conflicts. [2,3]
> 
> Thanks to everyone whose patches appear here, and everyone who reviewed
> on the original series. I hope I didn't break them too much during the
> rebase!
> 
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=E4piSojh3A4_0GjE0fAYbqKjtYGbE9beYRQ@mail.gmail.com/ [2]
> Link: https://lore.kernel.org/linux-kselftest/CABVgOSkhD6=5K72oL_n35CUeMhbsiQjZ6ds+EuQmJggBtVTFVg@mail.gmail.com/ [3]
> 
> Bruno Sobreira França (1):
>   lib/math: Add int_log test suite
> 
> Diego Vieira (1):
>   lib/tests/kfifo_kunit.c: add tests for the kfifo structure
> 
> Gabriela Bittencourt (2):
>   unicode: kunit: refactor selftest to kunit tests
>   unicode: kunit: change tests filename and path
> 
> Kees Cook (1):
>   lib: Move KUnit tests into tests/ subdirectory
> 
> Luis Felipe Hernandez (1):
>   lib: math: Move kunit tests into tests/ subdir

Can we deduplicate test/kunit in the file names please?

See df7f9acd8646 ("platform/x86: intel: Add 'intel' prefix to the modules
automatically") for the details how to achieve that in non-verbose way.

-- 
With Best Regards,
Andy Shevchenko



