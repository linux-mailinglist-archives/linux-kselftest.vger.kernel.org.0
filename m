Return-Path: <linux-kselftest+bounces-13084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E1E924A10
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 23:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704D71C2296B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70A205E26;
	Tue,  2 Jul 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIXmGEGZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D392205E23;
	Tue,  2 Jul 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956766; cv=none; b=S1KpCqPMRImGky+pQWditFKekNVFcbk7FIc6/0NiyrSRtBRbdivQKY/1mEEIIA3u0iZbFaUsBjnqQouZ7CWqF1UeTQ8ZGCJHklkEFS3K9LdfFO5J9RtW4psEI8SRIBvlzRiujqGEa52BfOfpTgA+TFC4yEY32gzEzU5A8qZg75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956766; c=relaxed/simple;
	bh=SgycanCp2SyWy1aw25pdL/KLsl4mjI4EXeRbN2/wzeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBwrdUbpfI6hCzLno0rVWVZYVhcZivS/jJsfF0ESjqdhc9dDim4zMkiueRjs7LUf6e71j8M/GhJYs3Hz7VaGK8hzMjh7q91v3iT4gJCLv7tz1GtJQkP51stg8X5gj5QhT8W6A/Jwah4ukZqIt6PgBS35KuUoYzgQY4jQaGCgaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIXmGEGZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719956765; x=1751492765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SgycanCp2SyWy1aw25pdL/KLsl4mjI4EXeRbN2/wzeM=;
  b=RIXmGEGZzNjFfhoezJ/fyZUMkGamBN7SiR5Wbqm56ES6FNIzViMV5nzT
   u4wmddcPiNMyFR1sfc2IilncGOwJ+Cez0lfqJH2ZwdeXkmtYrSA9g6SVn
   ZYy4OXvuKEhdfenAJMjVVM12G9r32I4GvDXKFpc0SMNJCMg9k9EiKeXxL
   LUCCohrsbCHYmdfGlxFGtnjDsj8OYGOD32PiPvik9wncZgOgtK+crtotR
   Rd3a8S6tmvUEmFJn2RRoxoVSeDDOMHh/as63aXSQLmgFQUPO3ZDOOSNFS
   mIpymNlN2SWnd5PjnmxbaGkpmf/fOsFSd4uZoL0kYAoRTjiqgGQRLxbTi
   A==;
X-CSE-ConnectionGUID: tYwqEEANRmuXRIB1sTN+cw==
X-CSE-MsgGUID: c9jShSCIQi+nFgUuY+G+xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17290463"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17290463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 14:46:04 -0700
X-CSE-ConnectionGUID: QElDSpyvSeGN0bhV7vHKMA==
X-CSE-MsgGUID: s+OChvMeSn6OjMWYkTH+zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46181421"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 14:46:03 -0700
Date: Tue, 2 Jul 2024 14:46:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <ZoR1GSV4_IWrNMK3@agluck-desk3.sc.intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4fdc8cc0-0b04-4879-9337-9eda3b83f603@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdc8cc0-0b04-4879-9337-9eda3b83f603@intel.com>

On Tue, Jul 02, 2024 at 02:26:25PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 7/1/24 9:04 AM, Luck, Tony wrote:
> > +static bool cpus_offline_empty(void)
> > +{
> > +	char offline_cpus_str[64];
> > +	FILE *fp;
> > +
> > +	fp = fopen("/sys/devices/system/cpu/offline", "r");
> > 
> > Check for fp == NULL before using it.
> > 
> > +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
> > 
> > fscanf() seems like a heavy hammer.
> 
> Do you perhaps have any recommendations that should be used instead of
> fscanf()? I checked with stat() but could not see a difference between
> file with a CPU and a file without. Other alternative is
> open()/read()/close()? Looks like when there are no offline CPUs then
> the file will only contain '\n' so it may be possible to read one byte
> from the file and confirm it is '\n' as a check for "cpus_offline_empty()".

Sorry. I replied with Outlook and didn't quote things properly
so my alternate suggestion didn't stand out. Here it is again:

	if (fgets(offline_cpus_str, sizeof(offline_cpus_str), fp) == NULL) {
		fclose(fp);
		return true;
	}

But that was with the assumption that /sys/devices/system/cpu/offline
would be empty. Not that it would conatain a single "\n" as you say
above.

So fgets( ...) followed with "if (offline_cpus_str[0] == '\n') "?

-Tony

