Return-Path: <linux-kselftest+bounces-6490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAAF886C17
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48E0280F00
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C8040BE5;
	Fri, 22 Mar 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJvpB8nQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D662770C;
	Fri, 22 Mar 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110637; cv=none; b=GEDTM9TOmmGDmi2GCcbu4z+2A8niYk5KXrdybtFjGmeCl5klz2L2HP+pgp3mTRq9A+ZSNUdVIbkl2NBdIZdqmWXNjgUFOw5tYIRuODH445pyZ+9nd/TG48NcG5AXDFfV/uxEU/01upAkqN25nuskpWXzdsjf6QJE5JvzsAJs6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110637; c=relaxed/simple;
	bh=n9NG5Ms0xKvPeFj5HVos821T8N2D2xc4BOS+QKWMqMw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tWomicDk1wDGLHxUkmvNQmJzwof7Wrw83+81CG/5h3HSufxz1IY8rVVbitJigMNpcJNeWGVEt4B7TBo9TxC1OxBlJ/PVW1OFpxwbMq9djyCAxFShTdKIxrJThDBbdh47XhyvhqyG/BPW4lTd+BMQbJ7S6hw39rz5pusAw8xmGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJvpB8nQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711110636; x=1742646636;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n9NG5Ms0xKvPeFj5HVos821T8N2D2xc4BOS+QKWMqMw=;
  b=VJvpB8nQVwAtFJ9Dq2lOt31IfW6RGaQCYScmVkp45k6DdPdhQEEelIVK
   vYRBAelULRm7pkIakkzbVsY/4ttqHQia7WkqZ9aJXWJfSxvIIDeu8sGge
   uZyzsLU3urqgmosW1DipQEra62FuDrhhZ/N3TrPVOUtoZZ8ErEkD97VjP
   ZrIgzSnj6Xb0fAzOjlHoCsQRaDB6G9vnY5kFWxucvPRG7mXH+yaQKH3Bl
   afJIDvrAdC/I/cFj5BQIdCwYhcYfDIIiZ1Pzyxhx6luqZJ/68N+8p05zM
   RkM+dj1cxq3qAx1Rox0leoTcBgg7cNFqU2EsB+aD7sOcWwI3FRCzEFOba
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16882498"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="16882498"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="46014435"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:30:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 14:30:28 +0200 (EET)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/13] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
In-Reply-To: <578d0b55-c51a-49d1-8f54-989215a3a4b8@intel.com>
Message-ID: <93e4f096-47df-9eba-095f-e8a8c3cd04f5@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-12-ilpo.jarvinen@linux.intel.com> <578d0b55-c51a-49d1-8f54-989215a3a4b8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-552054796-1711110628=:1115"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-552054796-1711110628=:1115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 20 Mar 2024, Reinette Chatre wrote:
> On 3/11/2024 6:52 AM, Ilpo J=C3=A4rvinen wrote:
> > The struct resctrl_val_param has control and monitor groups as char
> > arrays but they are not supposed to be mutated within resctrl_val().
> >=20
> > Convert the ctrlgrp and mongrp char array within resctrl_val_param to
> > plain const char pointers and adjust the strlen() based checks to
> > check NULL instead.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl.h   | 4 ++--
> >  tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/=
selftests/resctrl/resctrl.h
> > index 52769b075233..54e5bce4c698 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -89,8 +89,8 @@ struct resctrl_test {
> >   */
> >  struct resctrl_val_param {
> >  =09char=09=09*resctrl_val;
> > -=09char=09=09ctrlgrp[64];
> > -=09char=09=09mongrp[64];
> > +=09const char=09*ctrlgrp;
> > +=09const char=09*mongrp;
> >  =09char=09=09filename[64];
> >  =09unsigned long=09mask;
> >  =09int=09=09num_of_runs;
> > diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testin=
g/selftests/resctrl/resctrlfs.c
> > index 79cf1c593106..dbe0cc6d74fa 100644
> > --- a/tools/testing/selftests/resctrl/resctrlfs.c
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -469,7 +469,7 @@ static int create_grp(const char *grp_name, char *g=
rp, const char *parent_grp)
> >  =09 * length of grp_name =3D=3D 0, it means, user wants to use root co=
n_mon
> >  =09 * grp, so do nothing
> >  =09 */
>=20
> Could you please confirm that the comments are still accurate?

It's not, I missed it.

> > -=09if (strlen(grp_name) =3D=3D 0)
> > +=09if (!grp_name)
> >  =09=09return 0;

But now when looking into the surrounding code, to me it looks the correct=
=20
action here is to remove the comment and return -1 instead of 0. It makes
this just an internal sanity check that grp_name is provided by the=20
caller.

--=20
 i.

--8323328-552054796-1711110628=:1115--

