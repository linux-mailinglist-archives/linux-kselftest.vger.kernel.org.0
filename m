Return-Path: <linux-kselftest+bounces-20670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2629B04AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6EF1F243D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635041EF92E;
	Fri, 25 Oct 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myOFC6P+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0170815;
	Fri, 25 Oct 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864485; cv=none; b=MzJcNPtrTjWAmJCKWmzgDGnvW0KwQHwkACyB9MgE5qT3WODwixr42LRH7BG3XtJXZMI7NseLk8nG5WvTBTgiSZ2Wl2nuYNrdn+zsCvCaDsd0y/1mTwCIDSgFuLYQ7sU9QC1qLsK3c69JAH5LwpqiG2WTQjZpJOnGKD/wF3EKf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864485; c=relaxed/simple;
	bh=mpmaUGGIfP4lVjw2PnFl0+jK4lHu7oPJcOeMHyOcNqk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AC4yTIRcw6n7DZPhUR+xhY94Iy+rANc81Mr4fA5gR1H9/0xqw5LeIi95eicSyvimHaJKfOTT2F5g08QIduvrm2gc6gyVl4PR2caJroKTdRaiMZ0genUh1UxLeMEz62lrzLCwso7a3RqUjT1PrK/13HTIt/lSO+u8x4j0DV7n1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myOFC6P+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864483; x=1761400483;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mpmaUGGIfP4lVjw2PnFl0+jK4lHu7oPJcOeMHyOcNqk=;
  b=myOFC6P+mpnT2j51rKkG5668W8PyS9gpR7B3vHHhUw/R6vuO4rv03hBe
   IUhggyZd88oU9NlxyF7up2SpeNRSMjNlKdmrzN44BEILezGZCgGbicQWV
   +0X01kbpsDS29tdZHti2USQe8ZDnV5NIA80X27g+VnPmGvAP2tltApooZ
   e66AUDgBhSeWzz3B3a6EG3LGE6fNn6yoQ11sOSJcCAMiIT3p23x0zgp5r
   kZxvpGWHi59NJTDGR7rLSz0+ksbRDvpm1DLgmM85kt37C389vhO/3GD2O
   tclnZeKBnxv94AcygsCQTbVcHQhEYdmFCA6X/xuE4UlMLoVBHIbHbS+3L
   Q==;
X-CSE-ConnectionGUID: jZyDLYyORHqDoEJ8ujPsZg==
X-CSE-MsgGUID: JmHyXsHoQkiaBJRTUEr4EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29752397"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29752397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:54:41 -0700
X-CSE-ConnectionGUID: 382WJ3+0Tmmo66kharWetw==
X-CSE-MsgGUID: C4lJz9iTSQmu0F9kJrVtqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81231557"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:54:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 16:54:29 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
In-Reply-To: <b0ff78c0-2fe5-4350-94bc-cc6b21960cdb@intel.com>
Message-ID: <ed332bcb-0dfd-ec34-6523-3262babb3e90@linux.intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com> <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org> <b0ff78c0-2fe5-4350-94bc-cc6b21960cdb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Oct 2024, Reinette Chatre wrote:

> Hi Shuah,
> 
> On 10/24/24 3:36 PM, Shuah Khan wrote:
> > 
> > Is this patch series ready to be applied?
> > 
> 
> I believe it is close ... I would like to give Ilpo some time to peek
> at patches 2 and 10 to confirm if I got their fixes right this time. The
> rest of the series is ready.

Hi,

I took a look at those two patches now and they seemed fine to me so this 
series should be ready to go now.

-- 
 i.


