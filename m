Return-Path: <linux-kselftest+bounces-6108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE58765CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE31281EE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764F3FBAD;
	Fri,  8 Mar 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUy2SIkG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759164779F;
	Fri,  8 Mar 2024 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906352; cv=none; b=lVX1KTivf9CYW3vGR5Ouhn70449hhKZgip7gS7J5fV5jUBfnFpSG3jZS3dsdW2AxvwKAFtjV2w6TXckvrau0ITfxamQyqp+MBKhkPol9rjpA2LjqwMNbeqBiSGeIvqgcL8CqE7gd9G+WBGk97o/l16/JT5M02XVDWb0sxvH8NXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906352; c=relaxed/simple;
	bh=iQ3n49AeOSkqOZc0ifDVP4WSTm2rWSyNDdWitFB/NJA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ao6uf29Oqpr20+oJpvXM3A+5bEEx6dVZ2CI6Zpu210dE1IJM1zAwIzwffSCxfT5YizlBfsvjcHLc1fUarZRvlxoQY76srmdKAwG/7kROQWfDu7VdNYmOMaf+lrCbDrv79ZfPxoo9Zk8M87DUaJ+jeDvr8d/tgNEUzxO3D2xczlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUy2SIkG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709906351; x=1741442351;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iQ3n49AeOSkqOZc0ifDVP4WSTm2rWSyNDdWitFB/NJA=;
  b=gUy2SIkGyaxd1wkSnJcCOt/XUWhCPqTvDuzSEPWBb75WXhqHXqDAFcbs
   gyz2f6DoDAW2O7oVfbThP1c1e0OCGgB8LskZzp8ppcjkVTBCmvhD9/XIT
   7OgP6YDvolPCnqYFJI+EWtcSKMCEL1f42amR4LRNPXcZV4RyVGAxBn+uY
   LDWvEMmJeKXRsOXS4CXFPId0jELB/QOntphhiCJeb+S5FDfWGGyw7NxZd
   yf9npTji9u3WzrInqNnMiM/EejeY5QVvAIqFyUGlSKkHrfxU+8SuyhQoy
   /x7CqGzqqZdt+zxddy07F67RrynMaj321kGOHxPoiNpCeJf2Gl0qvQN3W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4470238"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4470238"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="41445552"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:59:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 15:59:02 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    tony.luck@intel.com, "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests/resctrl: SNC support for CMT
In-Reply-To: <6181937a-54b4-8b17-0c24-734764a205d1@linux.intel.com>
Message-ID: <5983d1aa-6e1e-fb49-b95a-429a9decfe7f@linux.intel.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com> <75849cb145429798b21c23b6be4abd7ece9df57b.1709721159.git.maciej.wieczor-retman@intel.com> <6181937a-54b4-8b17-0c24-734764a205d1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-330930196-1709906342=:9765"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-330930196-1709906342=:9765
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Mar 2024, Ilpo J=E4rvinen wrote:

> On Wed, 6 Mar 2024, Maciej Wieczor-Retman wrote:
>=20
> > Cache Monitoring Technology (CMT) works by measuring how much data in L=
3
> > cache is occupied by a given process identified by its Resource
> > Monitoring ID (RMID).
> >=20
> > On systems with Sub-Numa Clusters (SNC) enabled, a process can occupy
> > not only the cache that belongs to its own NUMA node but also pieces of
> > other NUMA nodes' caches that lie on the same socket.
> >=20
> > A simple correction to make the CMT selftest NUMA-aware is to sum value=
s
> > reported by all nodes on the same socket for a given RMID.
> >=20
> > Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
> > Closes: https://lore.kernel.org/all/TYAPR01MB6330B9B17686EF426D2C3F308B=
25A@TYAPR01MB6330.jpnprd01.prod.outlook.com/
> > Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> > ---

> > @@ -828,6 +828,8 @@ int resctrl_val(const struct resctrl_test *test,
> >  =09sleep(1);
> > =20
> >  =09/* Test runs until the callback setup() tells the test to stop. */
> > +=09get_domain_id("L3", uparams->cpu, &res_id);
>=20
> Hardcoding L3 here limits the genericness of this function. You don't eve=
n=20
> need to do it, get_domain_id() does "MB" -> "L3" transformation implicitl=
y=20
> for you so you can just pass test->resource instead.
>=20
> Also, I don't understand why you now again make the naming inconsistent=
=20
> with "res_id".
>=20
> If you based this on top of the patches I just posted, resctl_val()=20
> already the domain_id variable.

Ah, I retract what I said. I see you actually want it only from L3.

> > +     res_id *=3D snc_ways();

I don't understand what this is trying to achieve and how.

--=20
 i.

--8323328-330930196-1709906342=:9765--

