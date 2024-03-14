Return-Path: <linux-kselftest+bounces-6335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7B87C0FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 17:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EA2282BB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954BE73510;
	Thu, 14 Mar 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUka1LRJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B173500;
	Thu, 14 Mar 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432596; cv=none; b=NYjZuFF6fTR8v+gxN1xXn1Ye7D8Wg3h5BHqsSJt9kNg+tNJqVYTo2urB5x+85QUbo2u/i7YXxBge3rBF0rMkii7LkCjDqLskVs8ptmDAVGIINKTMM1P/tr71andUloRq2ADOVIR2zGaOGUNgDrH199nRVHxPQTJLPwe2dIBvlrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432596; c=relaxed/simple;
	bh=9u/UDzD0XpRwRBiuyHSJknNscac+rwwiSKoT//XPWhA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rTN1xJjB0EbjFBoBcegZ3NOC1/JbcdkKRRo1z/IHteRnrmaX/zgZInJI22tpxGpmiaRh+3EGvSwuVyjCAEGhOsu11BJ6XvEROpMbFgb787jnv/T+Oaa8dxVseUKsISApzeRDQGJqXy7fjAs23L4Q1+GEYOt449ZnNg51m/MP2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUka1LRJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710432595; x=1741968595;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9u/UDzD0XpRwRBiuyHSJknNscac+rwwiSKoT//XPWhA=;
  b=NUka1LRJjGE3BgA0krMcPuF3KcyIs12wMVI8OdYVuR98N/DLKTCX4rJX
   rjh9imJnV0BbxArnps0YO5v8MDA0/ZtzTy92gBp2UCN6RsbU9XfgE0tEu
   AZU+E2fIAQShp94AGyWKtELPW8dIsiIjRWHt7zR+W6Ic0gHjFuDZ+n1XD
   Oxt65rlplxgGKczrTwX9i3TTSJWcWKpeOgeyAysrdBytT1J7U0aaiTIYP
   +TSWtFFnTHWk4iu3c/OKjooTyuKZUbh08kw06x4TZOJTqA/svle3jDM/y
   BsHHM//MJMOBJjoUmPSU4gZCWcLTsHZwjgXHalJYyBRcD7Sjgi2aSUrvt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5389648"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5389648"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 09:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12735604"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.8])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 09:09:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 14 Mar 2024 18:09:48 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: linux-kselftest@vger.kernel.org, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
In-Reply-To: <jzyc3lehsspybfa7fjzpwwcw2lgyfftsyqysqmpbrpq37aggln@cbjul5wgozu7>
Message-ID: <78991c6c-2a0e-b7aa-1653-4836921507fa@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com> <jzyc3lehsspybfa7fjzpwwcw2lgyfftsyqysqmpbrpq37aggln@cbjul5wgozu7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2033180368-1710432588=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2033180368-1710432588=:1017
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Mar 2024, Maciej Wieczor-Retman wrote:
> On 2024-03-11 at 15:52:25 +0200, Ilpo J=E4rvinen wrote:
> >diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/=
selftests/resctrl/mbm_test.c
> >index 17398cd3aace..ffbfcecf9bd6 100644
> >--- a/tools/testing/selftests/resctrl/mbm_test.c
> >+++ b/tools/testing/selftests/resctrl/mbm_test.c
> >@@ -8,12 +8,19 @@
> >  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> >  *    Fenghua Yu <fenghua.yu@intel.com>
> >  */
> >+#include <limits.h>
> >+
> > #include "resctrl.h"
> >=20
> > #define RESULT_FILE_NAME=09"result_mbm"
> > #define MAX_DIFF_PERCENT=098
> > #define NUM_OF_RUNS=09=095
> >=20
> >+#define CON_MON_MBM_LOCAL_BYTES_PATH \
> >+=09"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
> >+
> >+static char mbm_total_path[PATH_MAX];
> >+
> > static int
> > show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span=
)
> > {
> >@@ -86,6 +93,20 @@ static int check_results(size_t span)
> > =09return ret;
> > }
> >=20
> >+static int set_mbm_path(const struct resctrl_val_param *param, int doma=
in_id)
> >+{
> >+=09int ret;
> >+
> >+=09ret =3D initialize_mem_bw_imc();
>=20
> I just noticed this. Since there is not only path stuff here but also som=
e imc
> logic maybe the function names could be changed? Something like
>=20
> =09set_mbm_path -> init_mbm
>=20
> The same could apply for all these init functions or at least the mba one=
=2E

Ah yes, I'll rename them.

--=20
 i.

--8323328-2033180368-1710432588=:1017--

