Return-Path: <linux-kselftest+bounces-16775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D2965F48
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3951C24A8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6518E742;
	Fri, 30 Aug 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US7cygWb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEB17DE1A;
	Fri, 30 Aug 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013802; cv=none; b=U9ynuxxR4ARNMqYdaijVsA3qLwxDYNodyVhVG3eKl5FMgZx3wrp8oLDg4D57GALBVzmaXOlLCAi0fdRruxrNvmt6knueCmSBdiGolihM4iyaxFR0om/XBlYlu4RvS0u4Z2pP/iy22cRHXhsL9ronbjsU60q61GbCcoSmE9ioUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013802; c=relaxed/simple;
	bh=Hek5YAT/x18HCwSgY3CztBaB6QQtSBFqumpTJZ9Ks+c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=smDOMnJl1+2NOoteELt3TMRB6SEIccEyJSsRCR2lmKXpHDqI3F/hkhufHZyh7gsosUAPL4FuFxJCVlLw6Q15F069ya1t3XxlXoRXE4WuI1EbsAnqcaWIHhgi6njDbD8pJyHTcnzBih6eEFdnujDCiNyQYbF/CbERPf6NXoQUUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US7cygWb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725013801; x=1756549801;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Hek5YAT/x18HCwSgY3CztBaB6QQtSBFqumpTJZ9Ks+c=;
  b=US7cygWbDxeIoJ/BibORlt/7Grgl0uw31WnuSOlkDLA+D1H++Mvy0qK9
   i7qMCrk/M+opwdEtgHLoQv1sFeJcMuKh8/bTHlwsFXmmDBnzVjMjpgOiw
   sPgLSjC9zMm5FyAI5T/E0C0/ttwfDOPqv7rYHKb5PUNZOpHv7npam0k3y
   6BePDB9vkQZAuiLBU5qwD2M0vSHSngBmd6GvgWx372mc6erUFr/VHjoLc
   oDOzKRwix35sjGTvnGA2uoyByGxvAPmJwctVTl1aH+XFVFIKPq9ddoz9a
   AvyKeFPJM/6jtqS8Vda+GEUtdR4drTGi0pUUHPSK4rId3JIfSH57+Dp5s
   A==;
X-CSE-ConnectionGUID: QpRvAtqhTDmYEgC8Xq00YA==
X-CSE-MsgGUID: AerXdeQ+Rp2mS0WTwuPpmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="35023154"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="35023154"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:30:01 -0700
X-CSE-ConnectionGUID: e4Z80fF4SlOt5xZRLzF7Ag==
X-CSE-MsgGUID: eyYuua+aSIulWZqZeB5IRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68762693"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:29:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 13:29:52 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] selftests/resctrl: Fix sparse warnings
In-Reply-To: <ff4afcc2d4988edce7346b4bd32ee06bf724e6fd.1724970211.git.reinette.chatre@intel.com>
Message-ID: <2c975369-8ecc-2c10-d57d-13f6073c0197@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <ff4afcc2d4988edce7346b4bd32ee06bf724e6fd.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-437893452-1725013792=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-437893452-1725013792=:1027
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 29 Aug 2024, Reinette Chatre wrote:

> Fix following sparse warnings:
>  tools/testing/selftests/resctrl/resctrl_val.c:47:6: warning: symbol 'mem=
bw_initialize_perf_event_attr' was not declared. Should it be static?
>  tools/testing/selftests/resctrl/resctrl_val.c:64:6: warning: symbol 'mem=
bw_ioctl_perf_event_ioc_reset_enable' was not declared. Should it be
> static?
>  tools/testing/selftests/resctrl/resctrl_val.c:70:6: warning: symbol 'mem=
bw_ioctl_perf_event_ioc_disable' was not declared. Should it be static?
>  tools/testing/selftests/resctrl/resctrl_val.c:81:6: warning: symbol 'get=
_event_and_umask' was not declared. Should it be static?
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.
--8323328-437893452-1725013792=:1027--

