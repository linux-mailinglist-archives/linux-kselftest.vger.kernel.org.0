Return-Path: <linux-kselftest+bounces-10661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E828CE1DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 09:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59561F21C96
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B76A82D7A;
	Fri, 24 May 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Doc44Kxm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A67604F;
	Fri, 24 May 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537447; cv=none; b=Ess8dYj+dxqDtpO59PuNKY6ovCNVg+XI6m+NdDdnNnKkbnouMeNUtSnM7vqoYyEcsTBWQkA3gC6HaWYh5u3w8pk7KCFovTuC/zcQOjmagCYsp5sx7pyyRV+sW0MyU9ehmdmRrK+2+aKa8H/eOyBXoKgPLTVGQpNbP9bbWeQksJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537447; c=relaxed/simple;
	bh=2nW2MH8YYHHMcOuU6yP8ETfJDp4ymu8aiSEbCDPefVY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DSCX2aXM62qAmg8vuu0N+3Gmn7OrJim7wgCuB6jjdlgLQ0QDmKB826/AGcZhYoN27QcNkiw9aAuRPc1Oy3KsVQrs24SCxhrvxS7oMo3ppYv2lToxlL1eUPFJTGgHRicYc3WA67bLAn4xccvK0QHbhaI+EmHPMs4wyVGw5nNcjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Doc44Kxm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716537446; x=1748073446;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2nW2MH8YYHHMcOuU6yP8ETfJDp4ymu8aiSEbCDPefVY=;
  b=Doc44KxmINpnOIhMjExKaXokT9sP+xVVFSlUMHDmAZ0tB4B9YWRhAzJ2
   CGfOmMneGgEJ+eVcS04NET9L97i9AVw6PMhFPLe0Rzsh0tY5B9m7OKur2
   MmKhhYvtiRQZCOBL9VQrnnwN4hcWqpF1hqQbQuEZixZPDoen8QCkTZJDM
   3i77o9bGUu8Gz/4rwEQFInFQgWXIgsytKQxVddHmfZow8x3pN5RMstTPV
   SGv3vNdPgSfYJBj7JNyD7KA96Jbfl9Sl8m8st+LrUfMTC9xfaNL1o7pBo
   rIApyt/c6Eu8CIEEJ+Ng29Yb+PTvIna5Hm+lk10wxozdTTF/K3R8Q3ADf
   w==;
X-CSE-ConnectionGUID: CMg1Q00pSMivJCoc4cLMBA==
X-CSE-MsgGUID: zTw9tLpDRMurMhy79jWdNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12843684"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12843684"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:57:25 -0700
X-CSE-ConnectionGUID: IjiR8ATdRbiRMIkWiEyIrg==
X-CSE-MsgGUID: 7miEALFIRtWZk2Ju6+D+qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="34055675"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:57:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 May 2024 10:57:16 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com>
Message-ID: <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com> <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com> <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-355923539-1716537436=:1394"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-355923539-1716537436=:1394
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 May 2024, Reinette Chatre wrote:
> On 5/20/24 5:30 AM, Ilpo J=C3=A4rvinen wrote:
> > For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> > the measurement over a duration of sleep(1) call. The memory bandwidth
> > numbers from IMC are derived over this duration. The resctrl FS derived
> > memory bandwidth, however, is calculated inside measure_vals() and only
> > takes delta between the previous value and the current one which
> > besides the actual test, also samples inter-test noise.
> >=20
> > Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> > resctrl FS memory bandwidth section covers much shorter duration
> > closely matching that of the IMC perf counters to improve measurement
> > accuracy. Open two the resctrl mem bw files twice to avoid opening
> > after the test during measurement period (reading the same file twice
> > returns the same value so two files are needed).
>=20
> I think this is only because of how the current reading is done, resctrl
> surely supports keeping a file open and reading from it multiple times.
>=20
> There seems to be two things that prevent current code from doing this
> correctly:
> (a) the fscanf() code does not take into account that resctrl also
>     prints a "\n" ... (this seems to be the part that may cause the same
>     value to be returned).
>     So:
> =09if (fscanf(fp, "%lu", mbm_total) <=3D 0) {
>     should be:
> =09if (fscanf(fp, "%lu\n", mbm_total) <=3D 0) {
> (b) the current reading does not reset the file position so a second
>     read will attempt to read past the beginning. A "rewind(fp)"
>     should help here.

(b) cannot be the cause for returning the same value again. It would=20
not be able to reread the number at all if file position is not moved.

I certainly tried with fseek() and it is when I got same value on the=20
second read which is when I just went to two files solution.

> A small program like below worked for me by showing different values
> on every read:
>=20
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
>=20
> const char *mbm_total_path =3D
> "/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes";
>=20
> int main(void)
> {
> =09unsigned long mbm_total;
> =09FILE *fp;
> =09int count;
>=20
> =09fp =3D fopen(mbm_total_path, "r");
> =09if (!fp) {
> =09=09perror("Opening data file\n");
> =09=09exit(1);
> =09}
> =09for (count =3D 0; count < 100; count++) {
> =09=09if (fscanf(fp, "%lu\n", &mbm_total) <=3D 0) {
> =09=09=09perror("Unable to read from data file\n");
> =09=09=09exit(1);
> =09=09}
> =09=09printf("Read %d: %lu\n",count ,mbm_total );
> =09=09sleep(1);
> =09=09rewind(fp);
> =09}
> =09fclose(fp);
> =09return 0;
> }

Okay, so perhaps it's your explanation (a) but can libc be trusted to not=
=20
do buffering/caching for FILE *? So to be on the safe side, it would=20
need to use syscalls directly to guarantee it's read the file twice.

If I convert it into fds, fscanf() cannot be used which would complicate=20
the string processing by adding extra steps.

--=20
 i.

--8323328-355923539-1716537436=:1394--

