Return-Path: <linux-kselftest+bounces-10906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF188D4A17
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A661F224CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F116F0EB;
	Thu, 30 May 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRULgM92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977E16EBE7;
	Thu, 30 May 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067490; cv=none; b=RB321vr7GJ/rmPGKqpjOtUonHKYZpArGObyY76TBx32azXV1YUtvSnbdXIikoZE1xZwDNZwGRoAkMmcaO96rijZWT82rinut82HBFz0uFo6/yIeUCtJegrXFLhz3BMRP/hAfGp9dIzCfFv9mZCMunyPHG5lX7fUZ2/v/4axpwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067490; c=relaxed/simple;
	bh=m7Nqw4BzpQisgwB3C3v62bMPbsmyMULykJCFST6uTBw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dBDiAAfMTM7U7zEEBU8b1UvMihUvSHuIgYjcVi8Oej0ULpl+CqeZHAPKVqgfveTXnjPrN1rEQUy0oCfj4Uui5dxWKwHgDW4GgR3/ksF4RKymFR1OprN05mx1KBr1U3CmqCuSWr5k+rUkAx9MFh1KIowTJ07D2gl4yinzD0zU5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRULgM92; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717067489; x=1748603489;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m7Nqw4BzpQisgwB3C3v62bMPbsmyMULykJCFST6uTBw=;
  b=iRULgM92Zt6ALWkowgHoaaoyHOnd4Jm/zr2LKpVJR7jTT3uYCQfnh+0w
   rMphb8KcC8aBr0CuwpB3V6L6nFtYrRka28PMMxW5bGV2B3YabQLEpUi5Y
   BcTCaj932tvubEdrhkxAFRoobw8Ot35/2Ar22fGaSWUVWekJgWOxFpk6/
   eeGX6YlLvJL96VwYigKrhXRZm4BEju/X1z2qm6tVrBngAICStADU/Kp99
   p6pEgICyCWc43i07C99zNhpzAGPZrWo/tdY1rRWsY1SCERy18DVqbxTv6
   4KRgssm/EC9+8YydK//zmMIDJb2baa7uLdpXvK//I8QAGqrAr1FsEmOIc
   Q==;
X-CSE-ConnectionGUID: DbIT0Qi9T4ix933vrvwHyg==
X-CSE-MsgGUID: /Y8O8z5gRt2ZVO1lH1rIZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="31063089"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31063089"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 04:11:28 -0700
X-CSE-ConnectionGUID: nWlfQRbXSF2uTzrCZCyIRg==
X-CSE-MsgGUID: HaNFl82JS0+R6Tre0Dilow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35842073"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.150])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 04:11:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 May 2024 14:11:20 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <700e3df4-4e10-4870-a1df-49d4616cbc45@intel.com>
Message-ID: <0f294d43-e704-d1de-06ee-97bb81ebb9cb@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com> <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com> <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com> <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com> <d8063ee7-1744-45a2-b6b9-506e68106baf@intel.com>
 <b029db88-2e09-0b4a-f46a-84b5e535f178@linux.intel.com> <904aa442-9fc5-c6dd-f367-07b197085f7b@linux.intel.com> <700e3df4-4e10-4870-a1df-49d4616cbc45@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-72461896-1717067480=:1113"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-72461896-1717067480=:1113
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 May 2024, Reinette Chatre wrote:
> On 5/28/24 3:19 AM, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 24 May 2024, Ilpo J=C3=A4rvinen wrote:
> > > On Fri, 24 May 2024, Reinette Chatre wrote:
> > > > On 5/24/24 12:57 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > On Thu, 23 May 2024, Reinette Chatre wrote:
> > > > > > On 5/20/24 5:30 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > > > For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that
> > > > > > > performs
> > > > > > > the measurement over a duration of sleep(1) call. The memory
> > > > > > > bandwidth
> > > > > > > numbers from IMC are derived over this duration. The resctrl =
FS
> > > > > > > derived
> > > > > > > memory bandwidth, however, is calculated inside measure_vals(=
) and
> > > > > > > only
> > > > > > > takes delta between the previous value and the current one wh=
ich
> > > > > > > besides the actual test, also samples inter-test noise.
> > > > > > >=20
> > > > > > > Rework the logic in measure_vals() and get_mem_bw_imc() such =
that
> > > > > > > the
> > > > > > > resctrl FS memory bandwidth section covers much shorter durat=
ion
> > > > > > > closely matching that of the IMC perf counters to improve
> > > > > > > measurement
> > > > > > > accuracy. Open two the resctrl mem bw files twice to avoid op=
ening
> > > > > > > after the test during measurement period (reading the same fi=
le
> > > > > > > twice
> > > > > > > returns the same value so two files are needed).
> > > > > >=20
> > > > > > I think this is only because of how the current reading is done=
,
> > > > > > resctrl
> > > > > > surely supports keeping a file open and reading from it multipl=
e
> > > > > > times.
> > > > > >=20
> > > > > > There seems to be two things that prevent current code from doi=
ng
> > > > > > this
> > > > > > correctly:
> > > > > > (a) the fscanf() code does not take into account that resctrl a=
lso
> > > > > >       prints a "\n" ... (this seems to be the part that may cau=
se
> > > > > > the same
> > > > > >       value to be returned).
> > > > > >       So:
> > > > > > =09if (fscanf(fp, "%lu", mbm_total) <=3D 0) {
> > > > > >       should be:
> > > > > > =09if (fscanf(fp, "%lu\n", mbm_total) <=3D 0) {
> > > > > > (b) the current reading does not reset the file position so a s=
econd
> > > > > >       read will attempt to read past the beginning. A "rewind(f=
p)"
> > > > > >       should help here.
> > > > >=20
> > > > > (b) cannot be the cause for returning the same value again. It wo=
uld
> > > > > not be able to reread the number at all if file position is not m=
oved.
> > > >=20
> > > > I know. This was not intended to explain the duplicate answer but
> > > > instead
> > > > describe another change required to use current code in a loop. I
> > > > specifically said in (a) that "(this seems to be the part that may =
cause
> > > > the same value to be returned)".
> > > >=20
> > > > > I certainly tried with fseek() and it is when I got same value on=
 the
> > > > > second read which is when I just went to two files solution.
> > > > >=20
> > > > > > A small program like below worked for me by showing different v=
alues
> > > > > > on every read:
> > > > > >=20
> > > > > > #include <stdio.h>
> > > > > > #include <stdlib.h>
> > > > > > #include <unistd.h>
> > > > > >=20
> > > > > > const char *mbm_total_path =3D
> > > > > > "/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes";
> > > > > >=20
> > > > > > int main(void)
> > > > > > {
> > > > > > =09unsigned long mbm_total;
> > > > > > =09FILE *fp;
> > > > > > =09int count;
> > > > > >=20
> > > > > > =09fp =3D fopen(mbm_total_path, "r");
> > > > > > =09if (!fp) {
> > > > > > =09=09perror("Opening data file\n");
> > > > > > =09=09exit(1);
> > > > > > =09}
> > > > > > =09for (count =3D 0; count < 100; count++) {
> > > > > > =09=09if (fscanf(fp, "%lu\n", &mbm_total) <=3D 0) {
> > > > > > =09=09=09perror("Unable to read from data file\n");
> > > > > > =09=09=09exit(1);
> > > > > > =09=09}
> > > > > > =09=09printf("Read %d: %lu\n",count ,mbm_total );
> > > > > > =09=09sleep(1);
> > > > > > =09=09rewind(fp);
> > > > > > =09}
> > > > > > =09fclose(fp);
> > > > > > =09return 0;
> > > > > > }
> > > > >=20
> > > > > Okay, so perhaps it's your explanation (a) but can libc be truste=
d to
> > > > > not
> > > > > do buffering/caching for FILE *? So to be on the safe side, it wo=
uld
> > > >=20
> > > > Coding with expectation that libc cannot be trusted sounds strange =
to
> > > > me.
> > > >=20
> > > > > need to use syscalls directly to guarantee it's read the file twi=
ce.
> > > > >=20
> > > > > If I convert it into fds, fscanf() cannot be used which would
> > > > > complicate
> > > > > the string processing by adding extra steps.
> > > > >=20
> > > >=20
> > > > It is not clear to me why you think that fscanf() cannot be used.
> > >=20
> > > This was related to fscanf() not being able to read from an fd which =
is
> > > different interface than what libc's FILE * is.
>=20
> The part I am missing is why you believe syscalls are required. Could
> you please elaborate why FILE * cannot be used?
>=20
> > >=20
> > > > Could you please elaborate what the buffering issues are?
> > >=20
> > > I'm pretty sure that by default libc does some buffering (even std*
> > > streams are line buffered and others streams even more). I'm not enti=
rely
> > > sure about the extent of that buffering but here we need to always re=
ad
> > > the up to date value from the file itself, not from some buffer.
> > >=20
> > > Maybe there never is any problem that the earlier read values are ret=
urned
> > > from some libc buffer when lseek/rewind is used, I just don't know th=
at
> > > for sure. You seem to be more certain but I've not seen on what basis
> > > (other than the anecdotial test you provided).
>=20
> I demonstrated that it works. I have not heard a clear reason why this
> conclusion
> is incorrect. The above remains vague to me and I cannot find a descripti=
on of
> a clear problem that can be studied.

It's pointless to continue this discussion as I don't have anything=20
concrete to prove you wrong.

So count it as my paranoia when it comes to putting buffering in between=20
something that is read more than once and expecting to get different=20
bits out of that buffered interface :-).

I'll just use a single FILE *.

> > > > It is not necessary to open and close the file every time a value n=
eeds
> > > > to be read from it.
> >=20
> > I'm bit unsure where to go with this. While I could change the code to
> > match what you described, I realized with the two files approach there'=
s
> > no need to do even review/lseek() call during the measurement. It might
> > not be very significant compared with the open that was there initially
> > but it's still extra.
>=20
> We are discussing the resctrl selftests that will accompany the resctrl
> filesystem in the kernel. When in doubt on how to interact with resctrl u=
sers
> use the selftests as reference. Needing to open and close a resctrl file
> every time a value needs to be read from it is not the correct guidance.

That's actually a different goal from the earlier, but I've no problem=20
adjusting to it.

Initially, this open/close() refactoring was made because of another goal=
=20
which was to avoid doing extra syscalls during the test.

--=20
 i.

--8323328-72461896-1717067480=:1113--

