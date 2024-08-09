Return-Path: <linux-kselftest+bounces-15055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511794CB33
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF542875A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F11741C8;
	Fri,  9 Aug 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/yqMHyX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1C170A02;
	Fri,  9 Aug 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188220; cv=none; b=RiYd4OTKS7f7pJlBgq4Y1Uc2e0p/NMdsPxkcYqTmFQ4LbKpkU3DhY3db1MV5QizGsP5RRn48DaUwpkzXKF63zVWJrkCJVCXCCTuoEOFxgYqqN0l8RS0tOXg2YvHOFEBslyx4ZFAsCaUggLHDNWUosG5/xz3wHUQDMiw8Dh2mwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188220; c=relaxed/simple;
	bh=UOQfJg5xhp8GyUKgK0ri3glpubgJdIRJ1MSNnWt0Npc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZYeLsxbm9Y/mkE9dZ0eBOd5ezY9zRX7TCSONdSsO7l8IrYiKigHg23YU79vlSrPBvjGc0HsHQTif55WpsN/EmAOzwgtOyv+2fcrUJZHb2j0a82YiZC26D5a5M70CpDQG40WdjFIZR5UOBcXLynmFJBkAoh4G7Op06tLKCG2Z/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/yqMHyX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723188220; x=1754724220;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UOQfJg5xhp8GyUKgK0ri3glpubgJdIRJ1MSNnWt0Npc=;
  b=i/yqMHyX7ou0r/nw55+hHf1OSMEis2vPLtfehq8JOlcNQUCcffJu6v93
   VtRYoKiBvEJa98YD5JuFwoe3jJ4+dHagk5TCTi6G/8vdf70L1kE2wXWgL
   ehkBMRM9FjU7XcB1heashgb2k53iiebdkhXLQFvo91NIoZzajMaBPBTDG
   aIbPOcsZi41OXQ5RxmuoEpMvGN+0AxwOBbVkD7WvvOCfA772QvDFrQzE0
   z8zy/E1NNH0gZiSCdVIr1tHS7GEIETIfuzzOjDsFf4N61pd+CnWh5FOaf
   xSQIOCuZizHlNzPehFJ2l3X3fJv6HB81kPetfuElXaGaZDJGfTGcLiBqD
   g==;
X-CSE-ConnectionGUID: tGb6Q2YmQNa3pQEyax8/Og==
X-CSE-MsgGUID: vIN59I3JTcOaoFmCeychoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="43865713"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="43865713"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:23:39 -0700
X-CSE-ConnectionGUID: qpbQjXdrToK1gPdsnsmSyA==
X-CSE-MsgGUID: J8vSJt0gQ2Gw2Z799Ra7uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="61878939"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.119])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:23:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Aug 2024 10:23:31 +0300 (EEST)
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, kernel@collabora.com, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
In-Reply-To: <20240809071059.265914-1-usama.anjum@collabora.com>
Message-ID: <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
References: <20240809071059.265914-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:

> This test doesn't have support for other architectures. Altough resctrl
> is supported on x86 and ARM, but arch_supports_noncont_cat() shows that
> only x86 for AMD and Intel are supported by the test.

One does not follow from the other. arch_supports_noncont_cat() is only 
small part of the tests so saying "This test" based on a small subset of 
all tests is bogus. Also, I don't see any reason why ARCH_ARM could not be 
added and arch_supports_noncont_cat() adapted accordingly.

> We get build
> errors when built for ARM and ARM64.

As this seems the real reason, please quote any errors when you use them 
as justification so it can be reviewed if the reasoning is sound or not.

-- 
 i.

> Hence add support in the Makefile to build this suite only for x86 and
> x86_64 architectures.
> 
> Fixes: b733143cc455 ("selftests/resctrl: Make resctrl_tests run using kselftest framework")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/resctrl/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index f408bd6bfc3d4..d5cf96315ef9b 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -3,7 +3,9 @@
>  CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
>  CFLAGS += $(KHDR_INCLUDES)
>  
> +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>  TEST_GEN_PROGS := resctrl_tests
> +endif
>  
>  LOCAL_HDRS += $(wildcard *.h)
>  
> 


