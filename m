Return-Path: <linux-kselftest+bounces-34111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F8AC9C6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 21:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36191769B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 19:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4819DF5F;
	Sat, 31 May 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MS+DQxJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9E2907;
	Sat, 31 May 2025 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748718587; cv=none; b=bkfv2oxV5sqR3pAsoPiYVdQb832mGdT+RQQ5umCzk6dM5ryfhTEbQl60nDZGyOz8mHAgOOz3AS0bUNlN4SezCOT4geCOSJEgwNgCTgykB7yQuum3Aw1qKTDYPa27sk3qVxlpn7ADzroy27vPiYachYlS5bOIKFjydQUGMIsRqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748718587; c=relaxed/simple;
	bh=N2ujWeqk/mWitCCBYtBoj8WTbfx0qXgKZ2KjVIw+CUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYeyreoHaj1RS1+F5e8XwlQDm8A26Z/9LkiFYyPvOOVXRHL4Mp4dAEnvCAbaC0LieOZTOUruwAPt+zAtdKtI/S6+s0O8TyNVdkqJxxb3F6araVTR8HnfZOk3R6rbMboL57qrHh7+IMF7d0T+lvOCVX8OP/Reb/AHET2lRZdcvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MS+DQxJG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748718586; x=1780254586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N2ujWeqk/mWitCCBYtBoj8WTbfx0qXgKZ2KjVIw+CUc=;
  b=MS+DQxJG6OSG3ssgDp2m9RZ9vPwQqTbwnIrgDgFLs5jjln26C0+uksws
   b6EhkgQ+xsu8X3odh2D04etwPVaAXRsBAR2HGf31hJP4jjobC/kRnKoMx
   kZvS7qrL5wMKXQJCtduc2Sz0Yi81hfBLSna4xA5kBKnsOyvbkexyBK4xK
   kWi3r89Mv72ip7XXStDVFaZMLug3+eVHgnvX3xX/TvtJc7xTi6ZkMES0D
   8Q63NCJb9sSjvTIShSQpA3XONUnvS574pHicvZYt3Iv0ePAQkoO07kdRl
   Yk+NU7NcUMi+Q4LeDYtTZPXBI0T+UyiyJf8/DtwPpZjJfLHvkpB3GoYkG
   A==;
X-CSE-ConnectionGUID: ixLUPFexTBaDMw+BGOZOfQ==
X-CSE-MsgGUID: uKhtT420SgKgiyfSmjQeLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50937653"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="50937653"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 12:09:46 -0700
X-CSE-ConnectionGUID: WhgRzFJnRQWb4jU5odhQ2w==
X-CSE-MsgGUID: 5LMCvKx/TLK11mLLK2M43g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="144026487"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 12:09:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uLRaI-00000002MfN-40YG;
	Sat, 31 May 2025 22:09:34 +0300
Date: Sat, 31 May 2025 22:09:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 08/33] vfio: selftests: Validate 2M/1G HugeTLB are
 mapped as 2M/1G in IOMMU
Message-ID: <aDtT7hrpxz7-3sh-@smile.fi.intel.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-9-dmatlack@google.com>
 <CALzav=fJS69JeKa-t6ze8Sx0Nwp+y8zRMfFu0RUaCoCcZR3jYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fJS69JeKa-t6ze8Sx0Nwp+y8zRMfFu0RUaCoCcZR3jYQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 30, 2025 at 02:12:36PM -0700, David Matlack wrote:
> On Fri, May 23, 2025 at 4:30 PM David Matlack <dmatlack@google.com> wrote:

...

> > +       if (access("/sys/kernel/debug/iommu/intel", F_OK))
> > +               return intel_iommu_mapping_get(bdf, iova, mapping);
> > +
> 
> Oops, this should be !access(...).

Hmm... Generally speaking that code is a hack. Is there any guarantee that
debugfs mount point is fixed to /sys/kernel/debug ?

> > +       return -EOPNOTSUPP;

-- 
With Best Regards,
Andy Shevchenko



