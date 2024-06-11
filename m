Return-Path: <linux-kselftest+bounces-11654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829CF903303
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941B71C231D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC717167D;
	Tue, 11 Jun 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXU8ja6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C7171095;
	Tue, 11 Jun 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088632; cv=none; b=t5pYGdteitr5hqRBPWar5i+UquQES/Yg1loHvQSakW4jpObb2OWSNMVf+7t5Xgq6YcJHqs3n5WPBVyZHylZEIFbF4D+u1A1Nz1/ukNGPObQWBZwIzcR6ZyPIM6gFBt7RYmzRKthOYrpc9papHbOPrUv/FCZHKoP+ApfIrsNecR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088632; c=relaxed/simple;
	bh=d9LhRoDirDIVLBHn5Q0g2sU/ZVkj1eYYPirssdqiO8c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bZHK6RVVyIflHswNzKXJ5xxgIef0HxfdHqLBVcxPtnGZHcWVGCitLACdWYbw/BW6GyKoV+EvVJYQFOB/dKUSYiNIEuTwlZR74R2AXCUho13xZfD15w5ZilVHdRM/ZHwEW9ieYgxD5pxZK7Ev6V8nftZFA0gjO7qZIqXElWhxgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXU8ja6y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718088630; x=1749624630;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=d9LhRoDirDIVLBHn5Q0g2sU/ZVkj1eYYPirssdqiO8c=;
  b=LXU8ja6ylh5J3b6EvaheFUV7epUScb/aJ88RlObdfmGt4KDDLlsHi0TG
   5mOD1qrIBLFLmPA4viEPjjGSukdaU/C8U7UBgYtguNM8PyscCPg57/pBL
   c7slSjiv9qMh6Cit+nwWPDPoz0ryiQdLCN7m7l6HgOuj8LX1KOgYRBOXe
   RH4n8AKB9YmNG4I0WlJqGbwiWvHhdzbmCC2xydbI6yIA+HH/yPMSP20+Q
   uJ09r/C2sblK2IGslm3015y/KiKdp21TQml03gxxNvObCZHX7DivomCsJ
   lM5tbgodIPMkx+oPX00AHX2gz1qwHJMsw2UsrIjS+8qOPtnpLfIAI7SJC
   w==;
X-CSE-ConnectionGUID: eNXWUlAKSd+HbA1rIAloTQ==
X-CSE-MsgGUID: q285XIs7Qyivqwpe2M0aJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25442642"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="25442642"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:50:29 -0700
X-CSE-ConnectionGUID: fWhCr+GXTbO/cPA9jxO/lA==
X-CSE-MsgGUID: s0ivOhrIQSSihChdLeAnkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="62494422"
Received: from unknown (HELO localhost) ([10.245.247.197])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:50:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Jun 2024 09:50:22 +0300 (EEST)
To: "Moger, Babu" <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
In-Reply-To: <0e153d27-fa1d-4c47-8d4e-a2004c991ffc@amd.com>
Message-ID: <32ee6801-cc68-e058-dfca-521ef9f398cb@linux.intel.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com> <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com> <91052cec-071b-7cc7-5f85-4fa29ec2aea4@linux.intel.com>
 <0e153d27-fa1d-4c47-8d4e-a2004c991ffc@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-446345429-1718088064=:1025"
Content-ID: <bbe28686-412a-5be0-e29b-c905ab97f256@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-446345429-1718088064=:1025
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7a7c7790-f400-a639-f19d-d6c15fc5af1a@linux.intel.com>

On Mon, 10 Jun 2024, Moger, Babu wrote:
> On 6/10/24 11:20, Ilpo J=E4rvinen wrote:
> > On Mon, 10 Jun 2024, Babu Moger wrote:
> >=20
> >> The selftest noncont_cat_run_test fails on AMD with the warnings. Reas=
on
> >=20
> > noncont_cat_run_test()
>=20
> I want to mention the test here. not function. How about this?
>=20
> "The selftest non-contiguous CBM test fails on AMD with the warnings."

Yes, it's possible to refer to something with natural language (in fact, I=
=20
personally find that better than using a function name when both options=20
exist).

The underscores are C artifacts to replace spaces that do not belong to=20
natural language so if one uses underscores, I'll always take it as a=20
direct reference to C code.

The quote still has "the warnings" though (but I see Reinette already=20
noted that).

> > (In general, use () when refering to a function, same thing in the=20
> > shortlog).
> >=20
> > "the warnings" sounds like I should know about what warning it fails wi=
th
> > but there's no previous context which tells that information. I suggest=
=20
> > you either use "a warning" or quote the warning it fails with into the=
=20
> > commit message.
> >=20
> >> is, AMD supports non contiguous CBM masks but does not report it via C=
PUID.


--=20
 i.
--8323328-446345429-1718088064=:1025--

