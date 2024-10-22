Return-Path: <linux-kselftest+bounces-20429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C839ABA29
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 01:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C01284B11
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 23:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156F1C3F34;
	Tue, 22 Oct 2024 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrBPXvL9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D81126C05;
	Tue, 22 Oct 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640748; cv=none; b=CY8tZGbVjTQM6B6ocsMqNYTdvp/RkEvT0Un7Y49nyDav8waiKCfRxVuJU6loiw5JT0UwMC9qvqz3J5xsw6KrQe5wvt0hQNktQUbUj+Kr0KfL/mj2LBwgGBYP8MxrYADTxAds2mmbDSPBX6hGcSR31lX8UxYcauJrydPBFy3IORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640748; c=relaxed/simple;
	bh=pDIp6PIXI7LCutYgWUWmchS4MNpPa0JMX6sCG63Zp3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2UF/uumpEpk3S0fAuuNJQjBWXXPy9p6+Tg19TnKDdYerxGcz62VYqsg7tBaZuyGO4rtj34mulEnxPtaRYxs0HmnjYQWnWxAlcqmASVwNvHwHpEaMaUujTHJ9MCC1SvQmcvTukSE8ONcEL2fkPGFVHfh0bPsvRT9xZU/2HD3V8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrBPXvL9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729640747; x=1761176747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDIp6PIXI7LCutYgWUWmchS4MNpPa0JMX6sCG63Zp3k=;
  b=HrBPXvL91RrlDuB3vYw2Dz2a2asOca1G8EX9Vr4TxoAb+NeWrp66rn/B
   b5RKA3BjTYK1nYm7ajNJHnpv+OOc7dr+EbK+NuxP3OZVThTeJxnnbhMax
   SwAHZGhgH6VFJ0J/zn/AnBHDdRc34ToOqUZIljuIHvWhj7ZEoAXDfJtk4
   1yiyC5/vojbHEyQdCIfPZou0s/xTxJplcS7kI5fA3+m5mtXWD5ICafF8x
   dF3RgaNrEow7fpG5PugJmjcvxZwlj/ZzuK1henSshQbF+rP+JGJup8MJh
   Xh8u5gbyz1yxSnjWstf6kPuUAX7zh8v3fIzXwTnXs5vi+jHP7GSn5WzVr
   Q==;
X-CSE-ConnectionGUID: WWGtQBIdTTmJQuphj3zp4A==
X-CSE-MsgGUID: 1NTfbLFBToGqrfCUdVuNIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29316930"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29316930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 16:45:46 -0700
X-CSE-ConnectionGUID: 55rXk8hyRsK1sIoI0f4Z6Q==
X-CSE-MsgGUID: I305ftsyQn+MbR3owEo2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80096757"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 16:45:45 -0700
Date: Tue, 22 Oct 2024 16:45:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com,
	kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V13 03/14] KVM: x86: Fix Intel PT Host/Guest mode when
 host tracing also
Message-ID: <Zxg5KJKx-mdY4ocC@tassilo>
References: <20241014105124.24473-1-adrian.hunter@intel.com>
 <20241014105124.24473-4-adrian.hunter@intel.com>
 <Zw1iCMNSI4Lc0mSG@google.com>
 <b29e8ba4-5893-4ca0-b2cc-55d95f2fc968@intel.com>
 <ZxfTOQzcXTBEiXMG@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxfTOQzcXTBEiXMG@google.com>

> 
> Out of curiosity, how much is Intel PT used purely for control flow tracing, i.e.
> without caring _at all_ about perceived execution time?

It is very common, e.g. one major use of PT is control flow discovery in
feedback fuzzers.

-Andi

