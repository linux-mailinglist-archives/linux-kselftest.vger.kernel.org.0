Return-Path: <linux-kselftest+bounces-6485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29556886BC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81048286AB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86D3F9FD;
	Fri, 22 Mar 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiDE30CD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BBC405CF;
	Fri, 22 Mar 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108766; cv=none; b=lEjoNJyR3o/drvw222IO6q0OXT/58hlc10A8XaLXyIu9wC5phYpGXNysKd30kVXEG3VwpuhQEPDMxOtWOZesITYvVWKMXpohz3q1mXG8zIP5mhU8btme4jleV3/1fJi7/TjTHEt04lCE7Ycx3KQthpt8JX+Gfyxb/ihiVoyG9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108766; c=relaxed/simple;
	bh=TKSr/w6Kq4SXbYjQlg7s7QfJJPOToQ5LI6caBUIa0eU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WP/LNBAYHjIPgCEdO0WotXx61C5qSCvrEn0drSDN5zFouCHxof+nePbsPB5J4WWkbZx9aVhDvpa05SaUzMxOl6HVCCfeFRLu2E+LPSwRilJM7GCSx4IxyFmc1kUksXi2Z4sKc1fPUasBKUjb/hFYNPpUCYloBp0UqJufupt0iXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiDE30CD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711108765; x=1742644765;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TKSr/w6Kq4SXbYjQlg7s7QfJJPOToQ5LI6caBUIa0eU=;
  b=iiDE30CDP6Dvwz6015u+gki77/wWYNoPlUtr0XYIDRnsbXLeswXB3obd
   bqds2dcqC4VSztg96IVoIjwoRmntNVE15NgpUYy9IDReR5pRWK+DQ6F0d
   9IQx3dnBH9ty50OOtSJJobvRfGUjEaAj2bNG5gjM0duqm9Ms97c35qUm6
   8OxMVmB7Eiz7G42f8OGZzDdAP1AaQVvtZjhLxUNh9CIa69ezhdHd7rGxh
   lusjZNPwdYJC4dNvMVAxb9q6d/HhDQol6CDZJ9yk0Lb80AzJtCFAr1MgZ
   ABxd75CdnYPoZFXkZ0S8FtNxEYLNGqtDlL7AlSNghMNqEalQHjPpnL4ft
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6007605"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6007605"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 04:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19588296"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 04:59:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 13:59:17 +0200 (EET)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/13] selftests/resctrl: Convert get_mem_bw_imc() fd
 close to for loop
In-Reply-To: <832ec5e1-db5c-4123-8768-39ba9e6cca82@intel.com>
Message-ID: <a263ee49-b987-90e2-c794-4d2af0ce50ca@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-2-ilpo.jarvinen@linux.intel.com> <832ec5e1-db5c-4123-8768-39ba9e6cca82@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1575227933-1711108757=:1115"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1575227933-1711108757=:1115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 19 Mar 2024, Reinette Chatre wrote:
> On 3/11/2024 6:52 AM, Ilpo J=C3=A4rvinen wrote:
> > The open() side handles fds in a for loop but close() is based on two
> > fixed indexes READ and WRITE.
> >=20
> > Match the close() side with the open() side by using for loop for
> > consistency.
>=20
> I find the close() side to be more appropriate. I say this for two
> reasons: (a) looking at the close() calls as they are now it is
> obvious what the close() applies to and transitioning to a loop
> adds a layer of unnecessary indirection, (b) I do not think a loop
> is appropriate for the READ/WRITE define that just happen to be 0
> and 1 ... there should not be an assumption about their underlying
> value.

Hi,

So to confirm are you suggesting I should remove all the other loops=20
instead?

--=20
 i.

--8323328-1575227933-1711108757=:1115--

