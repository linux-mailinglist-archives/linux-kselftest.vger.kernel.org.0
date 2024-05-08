Return-Path: <linux-kselftest+bounces-9675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E2D8BF4C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 04:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5C11C2154F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 02:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179651427E;
	Wed,  8 May 2024 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fK6K0Qbc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CCB14003;
	Wed,  8 May 2024 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715137078; cv=none; b=S5BBO08m6oydZ1ELyQvOnQJy4y/UgidHh0XrKqgm7b80cDsHIH4SdBqpjnHIAJKBE9Ef6yQhpq9tyfrftqF2iSwPWjNTglFvTLigSjxUVPLDFaBV/6nGVZ0yc4N3l2AKjH2/EiGj5KE3zUpWD4GO40TyUY5pgzlCGP2kCIyboOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715137078; c=relaxed/simple;
	bh=7Fb40uljgKsFnE1FzE9EeCrT6mqgfdQY5bkG3RtT+n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSXIDtOLhexXPSqwZujs3PHMQxocgCsL616EcqYRIN87mVnm3g/JkGNuBLVkY95j1fLW3j/zK36wTsldQ1Pp4phtru4lMTwewf/DHl6xcUOhyaL4YQiV6srLoOX1zZ2asywyCCGi/yib03E2mGxCwstiHXvR098TjlE8KkLonWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fK6K0Qbc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715137077; x=1746673077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7Fb40uljgKsFnE1FzE9EeCrT6mqgfdQY5bkG3RtT+n0=;
  b=fK6K0Qbc4uz0oW5sTJlmm4SmZVTrgSJP+E90a5X45dzSwXnF/WeFtDBU
   S5mVFCVc8pMLtywTsqvgNSzZ4RmDTmTBmpi9u4t7x3uPSxCw/MXRXGoZ5
   Tg3gN/Y4zh8+zx31/viPwKG7P6osqAoAKu30ILUuFW2DtYXEFTcc/S/Lp
   zSc3IBrNsF08ljT3+CkRfM5vYH/MM2m0hwj1ckJhbsO7vyeL17CrkOZDP
   m+RLRyb5aAK+yzQ4EMrUJkvOXIZyrHyThqk3EsjzvvO6VceqmhDxA7LKW
   wY/SPpNdBwR3PH093OkFiuw9IMEXaAQRaHFIXeaWDgyru81SE4qVEaKil
   g==;
X-CSE-ConnectionGUID: tuIqC/l+RV2/JCk90SpOTQ==
X-CSE-MsgGUID: CMd0MxKaTP+9d9m4HDkS1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21533526"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21533526"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 19:57:56 -0700
X-CSE-ConnectionGUID: anmJjyLiR6S4ei743rWx4w==
X-CSE-MsgGUID: SLR/iHPIS5Wre20AGIkdTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33291964"
Received: from linux.bj.intel.com ([10.238.157.71])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 19:57:50 -0700
Date: Wed, 8 May 2024 10:55:05 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org, edliaw@google.com,
	ivan.orlov0322@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, shuah@kernel.org, seanjc@google.com,
	pbonzini@redhat.com, bongsu.jeon@samsung.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alexandre.belloni@bootlin.com, jarkko@kernel.org,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH] selftests: Add _GNU_SOURCE definition when including
 kselftest_harness.h
Message-ID: <ZjrpieLKXFhklVwR@linux.bj.intel.com>
References: <20240507063534.4191447-1-tao1.su@linux.intel.com>
 <20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>

On Tue, May 07, 2024 at 10:06:51AM -0700, Andrew Morton wrote:
> On Tue,  7 May 2024 14:35:34 +0800 Tao Su <tao1.su@linux.intel.com> wrote:
> 
> > asprintf() is declared in stdio.h when defining _GNU_SOURCE, but stdio.h
> > is so common that many files don’t define _GNU_SOURCE before including
> > stdio.h, and defining _GNU_SOURCE after including stdio.h will no longer
> > take effect.
> > 
> > Since kselftest_harness.h introduces asprintf(), it is necessary to add
> > _GNU_SOURCE definition in all selftests including kselftest_harness.h,
> > otherwise, there will be warnings or even errors during compilation.
> > There are already many selftests that define _GNU_SOURCE or put the
> > include of kselftest_harness.h at the very beginning of the .c file, just
> > add the _GNU_SOURCE definition in the tests that have compilation warnings.
> 
> That asprintf() continues to cause problems.  How about we just remove
> it? Do the malloc(snprintf(str, 0, ...)) separately?

Removing asprintf() is indeed an good option, but using snprintf(str, 0, ...)
to get string size may go against the original intention of commit 38c957f07038.

Back to commit 38c957f07038, I don't see any advantage in using LINE_MAX.
Can we use a fixed value instead of LINE_MAX? E.g., 1024, 2048. Then we
just need to revert commit 809216233555.

