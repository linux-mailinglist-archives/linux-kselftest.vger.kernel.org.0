Return-Path: <linux-kselftest+bounces-9762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD38C0ACE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791D51C2271C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 05:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A59A14901B;
	Thu,  9 May 2024 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfq6Nxpd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13D12BEA4;
	Thu,  9 May 2024 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231591; cv=none; b=SmTBVwy9V6C/0Bcr2hK9K7cFArOFhHXshdFq4iPidpX1Ux+d7Ef/V+hJ4S2kOYhzem2yRAlq7rBZZ1LPawGsVEFK6ImA7cLeVuONikuQrKWDIM7T11J8zCeBaFZefhgeq5nn/Z6n5vLj4jW0VFKmsIlvh/cW6W8d504fQYSyHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231591; c=relaxed/simple;
	bh=+HjK0kYCcPNRfuW5/8B5m3uHChuYZwdu24oRvM7pCxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7ReVFSP40T6f+j0D2itsJ84GvQ8McjKIg3xPRRthXErD0o8GJ75GkKQDTZ36kz7QbqmTduxiMvIIuFO/rJxoWNLSsmfFIxKXRPIZVx9biG4Yd6UxHZD++hZd4rikUoNtuDLsK5MsowGTcaGXpGTYcGYXtI/Phm6fev98n4i5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfq6Nxpd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715231590; x=1746767590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+HjK0kYCcPNRfuW5/8B5m3uHChuYZwdu24oRvM7pCxs=;
  b=jfq6NxpdUAJbIzl3QOAMQB6mHHsJ4qbs87QD+YXCrXqYXLwFU6/X3wyM
   FSekhpyuXgALkvIbkEiFYPh6rMky0kMxg8YFtIhtzWy3zOzzbrh6cVEks
   X7P9rxDHcckPWvNX5tRQUAUa6+L6UR45y26XKaWwDVrDI+PYS1VmzWJJ1
   1XZrHeG+Sh/SO1xUKK6HKa4alsP8r1i6vjTTzOcEl3Bb8GvXtbuadY+t1
   aGao6kcXhoxsCVkiW3wP1B2zGO7aQBNQdb0p6n6dqf6I9lBU/sOFL37rM
   dvoJ6UD1nK5k29oKTKpqUInEQK61BkvgjRCEJ23Jk8yrVMFvHUlhqR+5c
   A==;
X-CSE-ConnectionGUID: MXjgI9r4SraRmS+MC2VP8A==
X-CSE-MsgGUID: n7cW3X3ORoKC84b4a3mh+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22279651"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="22279651"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 22:13:09 -0700
X-CSE-ConnectionGUID: /Bb1nj+5TLiK0Mf+JhLsaQ==
X-CSE-MsgGUID: 9AnJBeW3TaakuIFpxgH/SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="52318694"
Received: from linux.bj.intel.com ([10.238.157.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 22:13:04 -0700
Date: Thu, 9 May 2024 13:10:23 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Edward Liaw <edliaw@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org, ivan.orlov0322@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	shuah@kernel.org, seanjc@google.com, pbonzini@redhat.com,
	bongsu.jeon@samsung.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, alexandre.belloni@bootlin.com, jarkko@kernel.org,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH] selftests: Add _GNU_SOURCE definition when including
 kselftest_harness.h
Message-ID: <Zjxav6li45yXMNTB@linux.bj.intel.com>
References: <20240507063534.4191447-1-tao1.su@linux.intel.com>
 <20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>
 <ZjrpieLKXFhklVwR@linux.bj.intel.com>
 <20240508070003.2acdf9b4@kernel.org>
 <CAG4es9Xdo8fBEpZLWGFHodi7=+ZYLvrE-kQYt=YfCeEHWYxaXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG4es9Xdo8fBEpZLWGFHodi7=+ZYLvrE-kQYt=YfCeEHWYxaXg@mail.gmail.com>

On Wed, May 08, 2024 at 10:57:47AM -0700, Edward Liaw wrote:
> On Wed, May 8, 2024 at 7:00 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 8 May 2024 10:55:05 +0800 Tao Su wrote:
> > > Back to commit 38c957f07038, I don't see any advantage in using LINE_MAX.
> > > Can we use a fixed value instead of LINE_MAX? E.g., 1024, 2048. Then we
> > > just need to revert commit 809216233555.
> >
> > SGTM, FWIW. The print is printing a test summary line, printing more
> > than 1k seems rather unreasonable. Other facilities, like TH_LOG(),
> > should be used for displaying longer info.
> 
> I also submitted some patches to fix the _GNU_SOURCE issues here:
> https://lore.kernel.org/linux-kselftest/20240507214254.2787305-1-edliaw@google.com/
> 
> I'm fine with this approach.  It's aligned to what Sean suggested
> there, since it's causing a lot of troubles for the release cycle.

Thanks, I will submit patches with this approach soon.


