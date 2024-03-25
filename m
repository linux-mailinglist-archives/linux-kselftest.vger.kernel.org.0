Return-Path: <linux-kselftest+bounces-6537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D888AB1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CF2BA3A66
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406935F578;
	Mon, 25 Mar 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjyVlKlw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7C47A52;
	Mon, 25 Mar 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372467; cv=none; b=gh0TodPxIfll/3J9hTGlscRFym4uAY0/lr1x6Ugzw/AQCO/+LlueUv+O06K6Hc+8KDYhVOR5bKP8c70JNUPe3JYVowSmrtfZ2dryokq+ZuykTfbfR7+jA9KZjew5Rvcj9JCeKORxFE0Xdmf2RpJw8+gdh3cnrMF4szyL6JmPq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372467; c=relaxed/simple;
	bh=paNEJwhjSuKW21GSgQhTXiZKf5ZqX9Zxj5ICBM/xyCM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V+uWIadURHsqpvz4H1P7oBBkmB1LRTWYJoRKLCUnqcl0wL2NswINjob1ydZL2HvnzFRK/quFYjJN+OUK9uPMkzNz/bNybnwb82FjZWwkibEXaUG6XSgv1D8rkZ3fZqSK0JXsTkNMXs6DSIYUiauA8n2tXTZyxCamyPvh4LWLOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjyVlKlw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711372465; x=1742908465;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=paNEJwhjSuKW21GSgQhTXiZKf5ZqX9Zxj5ICBM/xyCM=;
  b=RjyVlKlwufgsYqCYHNBzmoV4kUZt9BYKaEMMCxcshrcHUHLtrsvISYBP
   ILYlRsX0OB2RsBK8Thc3gkE8+32yhlm/c2TL4l309eByHTtetYlZ8CFkc
   +HU0EKNDaT8/7mK+XMTGG3PA5jfwHY63npcMS11rlVQpybb5JIF8oPzoS
   9CC4rfxUfbEHT6eDg2GpTj6aQIzBOVRBL3lPr5ZrfwABxOT+aBgQyz5CD
   Vhu0XLMQO1/89gZl3WuD2USB2MbZleJfd5Y0ZG3xU3cfSFmf6ujwPR80n
   2GFwWadkIGr/aenrTLUCoPnU5EzMJGgedKj/zs5oMhEKRp09Uf1rqnEoo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6268136"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6268136"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20148591"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.19])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:14:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 25 Mar 2024 15:14:16 +0200 (EET)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/13] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
In-Reply-To: <8964b621-657d-4f9c-aeb0-3d3ed8c62c3f@intel.com>
Message-ID: <32c9f2ca-a483-97f3-25d1-8e16e2fdf042@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-12-ilpo.jarvinen@linux.intel.com> <578d0b55-c51a-49d1-8f54-989215a3a4b8@intel.com> <93e4f096-47df-9eba-095f-e8a8c3cd04f5@linux.intel.com>
 <8964b621-657d-4f9c-aeb0-3d3ed8c62c3f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-152287454-1711372456=:1020"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-152287454-1711372456=:1020
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Mar 2024, Reinette Chatre wrote:
> On 3/22/2024 5:30 AM, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 20 Mar 2024, Reinette Chatre wrote:
> >> On 3/11/2024 6:52 AM, Ilpo J=C3=A4rvinen wrote:
> >>> The struct resctrl_val_param has control and monitor groups as char
> >>> arrays but they are not supposed to be mutated within resctrl_val().
> >>>
> >>> Convert the ctrlgrp and mongrp char array within resctrl_val_param to
> >>> plain const char pointers and adjust the strlen() based checks to
> >>> check NULL instead.
> >>>
> >>> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >>> ---
> >>>  tools/testing/selftests/resctrl/resctrl.h   | 4 ++--
> >>>  tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++----
> >>>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testin=
g/selftests/resctrl/resctrl.h
> >>> index 52769b075233..54e5bce4c698 100644
> >>> --- a/tools/testing/selftests/resctrl/resctrl.h
> >>> +++ b/tools/testing/selftests/resctrl/resctrl.h
> >>> @@ -89,8 +89,8 @@ struct resctrl_test {
> >>>   */
> >>>  struct resctrl_val_param {
> >>>  =09char=09=09*resctrl_val;
> >>> -=09char=09=09ctrlgrp[64];
> >>> -=09char=09=09mongrp[64];
> >>> +=09const char=09*ctrlgrp;
> >>> +=09const char=09*mongrp;
> >>>  =09char=09=09filename[64];
> >>>  =09unsigned long=09mask;
> >>>  =09int=09=09num_of_runs;
> >>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/test=
ing/selftests/resctrl/resctrlfs.c
> >>> index 79cf1c593106..dbe0cc6d74fa 100644
> >>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> >>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> >>> @@ -469,7 +469,7 @@ static int create_grp(const char *grp_name, char =
*grp, const char *parent_grp)
> >>>  =09 * length of grp_name =3D=3D 0, it means, user wants to use root =
con_mon
> >>>  =09 * grp, so do nothing
> >>>  =09 */
> >>
> >> Could you please confirm that the comments are still accurate?
> >=20
> > It's not, I missed it.
> >=20
> >>> -=09if (strlen(grp_name) =3D=3D 0)
> >>> +=09if (!grp_name)
> >>>  =09=09return 0;
> >=20
> > But now when looking into the surrounding code, to me it looks the corr=
ect=20
> > action here is to remove the comment and return -1 instead of 0. It mak=
es
> > this just an internal sanity check that grp_name is provided by the=20
> > caller.
> >=20
>=20
> hmmm ... this should not be an error because the caller is not required
> to provide grp_name. Not providing grp_name has a specific meaning
> of this operating on the CON_MON group and a failure would break flows
> operating on the CON_MON group.

write_bm_pid_to_resctrl() checks for non-NULL mongrp before it calls into=
=20
create_grp() so with current code, I don't think it changes anything. And=
=20
param->ctrlgrp is always non-NULL too so I don't think the return ever=20
triggers with the current codebase.

However, I was more talking from API point of view. It feels more natural=
=20
for "create group" function to return error if the caller is inconsistent
with itself by asking to create a group but doesn't want to create a=20
group.

--=20
 i.

--8323328-152287454-1711372456=:1020--

