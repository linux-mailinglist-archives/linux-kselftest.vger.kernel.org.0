Return-Path: <linux-kselftest+bounces-10769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72E8D1853
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF791C208B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFA161314;
	Tue, 28 May 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABA5sbKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2515E96;
	Tue, 28 May 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891587; cv=none; b=Oh5mmo/rqmtBbsdc+c1p8/YxpEUOLUg9pH6HGDcHS/pKHcOf+dYIbMHMdaq65byvOnGpV76eRU9Nl1L2V6ndO6MhBkocHofaljv7MJXgILlUENUFN4eAggNoNvI6JIa2cknnbQ/OGrIfkW4asWXyc5/tVH1YPBvUZrVePEF/OCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891587; c=relaxed/simple;
	bh=SZ1vHZwyV3O3++7hGkKg9f2MrPmdeUTNQ+R3OgPz6cU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QiHVqt02NpqaUzoZniO57UsAF4vW20gAccHlxiox7EKKCWSUy2eJTlDm3hQtFJx/6u4ExNLwpnhEhfCXxradyYmgEfsPTpneOYyutg3Q+DIuI5/ARSapow78Jh2sfmCKTKYiqErRu42e7YTtrdGn6Gcy2LEMLR3Fg6uCIJQayrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABA5sbKF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716891587; x=1748427587;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SZ1vHZwyV3O3++7hGkKg9f2MrPmdeUTNQ+R3OgPz6cU=;
  b=ABA5sbKF0EM3xQp9CuKRxaSoCIVNsG0xnuv1w6I+qkPNUe/dQqlCgJ5V
   jarQ6EPqVfhCCduvc+3oQgu/A3j27+ZEfOiNOsuvwl15UdXtCHAatFPWg
   u4ne7nBmVXlQqjANfh/boxL8uG8o2ia+JOsCsK6FqZzK7JWWLUyP1ZjOz
   1vAXrYJVTkY+UtzasmqfxJMJRNizpCEerlsZZRTiiF4KTweADYVl/erAo
   zmbjag0Ph4/uzNvrqNTC/7usELjnIgINlWvQpSV8EAFCyvsXPFadtsVGW
   Sd44iZfg1YbgPUYQGDP9fA0YRfMujlP85tjAGeaS1zzDKG74A16l2WewZ
   w==;
X-CSE-ConnectionGUID: TcdepgrjTn2Ahn/tHAW27Q==
X-CSE-MsgGUID: V54FwbFpR6iGjczuaD00uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13175465"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13175465"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:19:46 -0700
X-CSE-ConnectionGUID: dwxxMZfaRCa4xdsVKcpHDA==
X-CSE-MsgGUID: 0co8FDmZQDyVSWRugC5Trg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39992751"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:19:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 13:19:38 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <b029db88-2e09-0b4a-f46a-84b5e535f178@linux.intel.com>
Message-ID: <904aa442-9fc5-c6dd-f367-07b197085f7b@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com> <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com> <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com> <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com> <d8063ee7-1744-45a2-b6b9-506e68106baf@intel.com>
 <b029db88-2e09-0b4a-f46a-84b5e535f178@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2026881854-1716891578=:5869"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2026881854-1716891578=:5869
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 24 May 2024, Ilpo J=C3=A4rvinen wrote:

> On Fri, 24 May 2024, Reinette Chatre wrote:
> > On 5/24/24 12:57 AM, Ilpo J=C3=A4rvinen wrote:
> > > On Thu, 23 May 2024, Reinette Chatre wrote:
> > > > On 5/20/24 5:30 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that per=
forms
> > > > > the measurement over a duration of sleep(1) call. The memory band=
width
> > > > > numbers from IMC are derived over this duration. The resctrl FS d=
erived
> > > > > memory bandwidth, however, is calculated inside measure_vals() an=
d only
> > > > > takes delta between the previous value and the current one which
> > > > > besides the actual test, also samples inter-test noise.
> > > > >=20
> > > > > Rework the logic in measure_vals() and get_mem_bw_imc() such that=
 the
> > > > > resctrl FS memory bandwidth section covers much shorter duration
> > > > > closely matching that of the IMC perf counters to improve measure=
ment
> > > > > accuracy. Open two the resctrl mem bw files twice to avoid openin=
g
> > > > > after the test during measurement period (reading the same file t=
wice
> > > > > returns the same value so two files are needed).
> > > >=20
> > > > I think this is only because of how the current reading is done, re=
sctrl
> > > > surely supports keeping a file open and reading from it multiple ti=
mes.
> > > >=20
> > > > There seems to be two things that prevent current code from doing t=
his
> > > > correctly:
> > > > (a) the fscanf() code does not take into account that resctrl also
> > > >      prints a "\n" ... (this seems to be the part that may cause th=
e same
> > > >      value to be returned).
> > > >      So:
> > > > =09if (fscanf(fp, "%lu", mbm_total) <=3D 0) {
> > > >      should be:
> > > > =09if (fscanf(fp, "%lu\n", mbm_total) <=3D 0) {
> > > > (b) the current reading does not reset the file position so a secon=
d
> > > >      read will attempt to read past the beginning. A "rewind(fp)"
> > > >      should help here.
> > >=20
> > > (b) cannot be the cause for returning the same value again. It would
> > > not be able to reread the number at all if file position is not moved=
=2E
> >=20
> > I know. This was not intended to explain the duplicate answer but inste=
ad
> > describe another change required to use current code in a loop. I
> > specifically said in (a) that "(this seems to be the part that may caus=
e
> > the same value to be returned)".
> >=20
> > > I certainly tried with fseek() and it is when I got same value on the
> > > second read which is when I just went to two files solution.
> > >=20
> > > > A small program like below worked for me by showing different value=
s
> > > > on every read:
> > > >=20
> > > > #include <stdio.h>
> > > > #include <stdlib.h>
> > > > #include <unistd.h>
> > > >=20
> > > > const char *mbm_total_path =3D
> > > > "/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes";
> > > >=20
> > > > int main(void)
> > > > {
> > > > =09unsigned long mbm_total;
> > > > =09FILE *fp;
> > > > =09int count;
> > > >=20
> > > > =09fp =3D fopen(mbm_total_path, "r");
> > > > =09if (!fp) {
> > > > =09=09perror("Opening data file\n");
> > > > =09=09exit(1);
> > > > =09}
> > > > =09for (count =3D 0; count < 100; count++) {
> > > > =09=09if (fscanf(fp, "%lu\n", &mbm_total) <=3D 0) {
> > > > =09=09=09perror("Unable to read from data file\n");
> > > > =09=09=09exit(1);
> > > > =09=09}
> > > > =09=09printf("Read %d: %lu\n",count ,mbm_total );
> > > > =09=09sleep(1);
> > > > =09=09rewind(fp);
> > > > =09}
> > > > =09fclose(fp);
> > > > =09return 0;
> > > > }
> > >=20
> > > Okay, so perhaps it's your explanation (a) but can libc be trusted to=
 not
> > > do buffering/caching for FILE *? So to be on the safe side, it would
> >=20
> > Coding with expectation that libc cannot be trusted sounds strange to m=
e.
> >=20
> > > need to use syscalls directly to guarantee it's read the file twice.
> > >=20
> > > If I convert it into fds, fscanf() cannot be used which would complic=
ate
> > > the string processing by adding extra steps.
> > >=20
> >=20
> > It is not clear to me why you think that fscanf() cannot be used.
>=20
> This was related to fscanf() not being able to read from an fd which is=
=20
> different interface than what libc's FILE * is.
>=20
> > Could you please elaborate what the buffering issues are?
>=20
> I'm pretty sure that by default libc does some buffering (even std*=20
> streams are line buffered and others streams even more). I'm not entirely=
=20
> sure about the extent of that buffering but here we need to always read=
=20
> the up to date value from the file itself, not from some buffer.
>=20
> Maybe there never is any problem that the earlier read values are returne=
d=20
> from some libc buffer when lseek/rewind is used, I just don't know that=
=20
> for sure. You seem to be more certain but I've not seen on what basis=20
> (other than the anecdotial test you provided).
>=20
> > It is not necessary to open and close the file every time a value needs
> > to be read from it.

I'm bit unsure where to go with this. While I could change the code to=20
match what you described, I realized with the two files approach there's=20
no need to do even review/lseek() call during the measurement. It might=20
not be very significant compared with the open that was there initially=20
but it's still extra.

--=20
 i.

--8323328-2026881854-1716891578=:5869--

