Return-Path: <linux-kselftest+bounces-9761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25B58C0ACB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F72EB20BB6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEF14900F;
	Thu,  9 May 2024 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUeqVCTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C271D26D;
	Thu,  9 May 2024 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231489; cv=none; b=i5H9DjHpgyYDTXuYgyohWeHmH2QFhzv3yu5AlwYaCvEstgqLc9kPjJv7/D3mFWNoLqlVagwu7VGquf8v4Dj4iYWBY0EyWhTLTJRrYlldkkGQYBJTwEaYH/ISUPIecJUa9pMqFl1BwKCWM8CTsk5zeChDnOsCoTL/d2NxOWI7jEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231489; c=relaxed/simple;
	bh=bwP4PkqYOWfJSD3RZMmNAAer7EiNi/W9/vpneJLOBBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYnXGIsfbG717vc53XWNlM51aooLfziQb+bXhl3+k3pZ+PbOzrigIB+XHt5+YwPVhutUU55aqLrV0Kg6js+ArNIyJ9jbj/MzzFuODIUjFf9+KBm9tEwppxTh6vEL4fX2pUfYV8JHgSCF8jKFYMxjxoAPJ34ltIi42Ou848VQpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUeqVCTQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715231488; x=1746767488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwP4PkqYOWfJSD3RZMmNAAer7EiNi/W9/vpneJLOBBo=;
  b=IUeqVCTQ/lwvnb4NQVmwxPS9oTm+yoa2E8WqAW55ZrHuokePPrO14kET
   Fx2Xcbz9tPGTImGZZodrr3/bXaGd1cveUAFPMn4BtSKj+l2HacNTEGTsm
   Y/VFHzCdjw0cq8DLksxHX9WNqMzg/Fli87zve/+gTDNjvHJUtVOMsQJPS
   h9K8/QGlXZark6dAOryPmxTZlB9dlCCAKFsrat4T1dcSbYF+XvmW7ijTu
   xu4AabFX/RBg/YWt0cfQzXP6b8cfvwSFv3Kxc0jknph9WYdD4tQcwItpw
   wYiL2iqjiJpP43qR04ZptAocTekd7hafMPIbHyYTAOLNtuBs/RNa+UAVl
   w==;
X-CSE-ConnectionGUID: 9ASCG7zaReeTcrmrRVXh4w==
X-CSE-MsgGUID: CumAFIfmSnO+XfhVXJCM9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11284475"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="11284475"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 22:11:27 -0700
X-CSE-ConnectionGUID: l1HARRb3R5qiiFZyYJWetg==
X-CSE-MsgGUID: ooJBziBmShmI8TfY+cJ4ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="29212573"
Received: from linux.bj.intel.com ([10.238.157.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 22:11:21 -0700
Date: Thu, 9 May 2024 13:08:36 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org, edliaw@google.com,
	ivan.orlov0322@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, shuah@kernel.org, seanjc@google.com,
	pbonzini@redhat.com, bongsu.jeon@samsung.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	alexandre.belloni@bootlin.com, jarkko@kernel.org,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH] selftests: Add _GNU_SOURCE definition when including
 kselftest_harness.h
Message-ID: <ZjxaVEKv7bEuHJ8c@linux.bj.intel.com>
References: <20240507063534.4191447-1-tao1.su@linux.intel.com>
 <20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>
 <ZjrpieLKXFhklVwR@linux.bj.intel.com>
 <20240508070003.2acdf9b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508070003.2acdf9b4@kernel.org>

On Wed, May 08, 2024 at 07:00:03AM -0700, Jakub Kicinski wrote:
> On Wed, 8 May 2024 10:55:05 +0800 Tao Su wrote:
> > Back to commit 38c957f07038, I don't see any advantage in using LINE_MAX.
> > Can we use a fixed value instead of LINE_MAX? E.g., 1024, 2048. Then we
> > just need to revert commit 809216233555.
> 
> SGTM, FWIW. The print is printing a test summary line, printing more
> than 1k seems rather unreasonable. Other facilities, like TH_LOG(),
> should be used for displaying longer info.

Thanks, do you think 1k is enough for test_name?

> 

