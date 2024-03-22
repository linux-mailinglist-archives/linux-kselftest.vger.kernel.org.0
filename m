Return-Path: <linux-kselftest+bounces-6486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB02886BC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 13:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B58286288
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59E3F9DD;
	Fri, 22 Mar 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpMmkcgY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C6405DF;
	Fri, 22 Mar 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108835; cv=none; b=r1cCAoD9/vg6HMGqX+Vev28aY9vG34lE2l7Tb5oJj36rbgtFd6Rqoz5d7s9MF/sLQw13DcxarpmkkstFWyBx0AvoN29z2LTdoBA0vkT+94GwKyTP5Yj2txp0ebtsHL+PxVj3kasxOUWepMdy6L8zziGOKyHpSiWtdpiMtsb5rLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108835; c=relaxed/simple;
	bh=92pX5IDP/FkapkpehkoB1Zy0xn13DvY+iux3kEzJFh0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MefNiKNrZ55MqGXEc8cE4eB1202KClPBhMaRppjR9qErIt7JfYis4qAcUN9eL6pfY9LzrHgBv9cawG0+g54KgUxIjTrBJ1e38WAZm57nFNZ2qZNMzlf+cjTy2mbYs5P/5AhfSFxtAa+gjjm6CZcLvm7Sqp2ZScV2QVNwAwsYBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpMmkcgY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711108834; x=1742644834;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=92pX5IDP/FkapkpehkoB1Zy0xn13DvY+iux3kEzJFh0=;
  b=RpMmkcgYVBhrQDTc0m3aAqNBjjThmVTuaN51Vz1MSrRYHmb0whIKYa+J
   I6IFmPDk18O11RZzKiOD257NLlxl7dSyqN3+BeDYZ5q26T8PswyT6qo/k
   RqeqHxC8gHSnozgVvIK8s47SpphEbAkp5+K66CmEJCOeAAVeuHYPty4zo
   iP4dnjyZA0L9uKTEZR+j1XXGiQGFu8ddCRHNYee5T5q3N3VJ8vpNGhsn6
   HBrm/xe0uEa8jBcSTA24b924rUG8WfqDgcJNMAbWiJ8mINnDOW+Dl5GBY
   KRYMAmuHBooTevd8+USrYw1XlyPLdVTxmPzKzFqzioLBZ7edslLIlryFC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6007738"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6007738"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="46002387"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:00:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 14:00:28 +0200 (EET)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/13] selftests/resctrl: Convert get_mem_bw_imc() fd
 close to for loop
In-Reply-To: <a263ee49-b987-90e2-c794-4d2af0ce50ca@linux.intel.com>
Message-ID: <2d75c1fc-3ff0-839b-996b-28fd4d02433c@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-2-ilpo.jarvinen@linux.intel.com> <832ec5e1-db5c-4123-8768-39ba9e6cca82@intel.com> <a263ee49-b987-90e2-c794-4d2af0ce50ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-207245466-1711108828=:1115"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-207245466-1711108828=:1115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Mar 2024, Ilpo J=C3=A4rvinen wrote:

> On Tue, 19 Mar 2024, Reinette Chatre wrote:
> > On 3/11/2024 6:52 AM, Ilpo J=C3=A4rvinen wrote:
> > > The open() side handles fds in a for loop but close() is based on two
> > > fixed indexes READ and WRITE.
> > >=20
> > > Match the close() side with the open() side by using for loop for
> > > consistency.
> >=20
> > I find the close() side to be more appropriate. I say this for two
> > reasons: (a) looking at the close() calls as they are now it is
> > obvious what the close() applies to and transitioning to a loop
> > adds a layer of unnecessary indirection, (b) I do not think a loop
> > is appropriate for the READ/WRITE define that just happen to be 0
> > and 1 ... there should not be an assumption about their underlying
> > value.
>=20
> Hi,
>=20
> So to confirm are you suggesting I should remove all the other loops=20
> instead?

Nevermind, I read the comment to second patch, so the answer is yes. :-)

--=20
 i.

--8323328-207245466-1711108828=:1115--

