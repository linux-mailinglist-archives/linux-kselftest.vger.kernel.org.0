Return-Path: <linux-kselftest+bounces-20117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D649A3924
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7134F1C25803
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18618EFFB;
	Fri, 18 Oct 2024 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L82VRvx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCF18E025;
	Fri, 18 Oct 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241610; cv=none; b=TfXNXJ6YoGtxP0A6/qThmPO4DNTlBFTCYkodNQDZGBIdSFpzhbzM+0fuqVMQNLmZaZM4BndKiAHEVT3O5aSnsU+2xSlEvYlR3ytdI0ofwcTztwwRQFWCSfFpDHlJ16D+TzOaa+aUAuBGAEoyXPhhr9WbXKprdqiFXmDjl9sVv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241610; c=relaxed/simple;
	bh=Eft0/EV53cHhIKGudjtMBWNbw+3vJIAdcxvFutsGwM8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kY+IDrP2blqlQez1IDk5SyeCgwWOGBF7Z5fkR84Af4RUCAD0aVgHAAAKjzDvHRbnDGXKOah2VCQKxjdjTHQZV4HfKl2tjoh9wjW2OoTQtueC8XU+eaRezrgf4iop7+uVLILGD5OTxTWxLJIfuab7WE0SBuIepevu9WL2Auyiwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L82VRvx6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729241608; x=1760777608;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Eft0/EV53cHhIKGudjtMBWNbw+3vJIAdcxvFutsGwM8=;
  b=L82VRvx6wEVzRd7/J+B1Ugh6vDFRmnTowtLwMoigExsg531HULTr2Lg6
   titlNqRuA3AWIiojPxq5XjkGj4Sp6RyrsJewnZYkYctacVRrN/12PqpIg
   cKtWUhy9n/uAZE/oG+5dsaq5pd1milUSVn+Yt83nI1qGSfw0eYLfC6LIq
   2hBNTVo5Vmi3xSZIcncVwknlvEx29JMX5RJ6mrCfKa9/npVs5BsKdJeNA
   n129/xslxevEaemiizgKB8C2ZuZIh6S4HmEfabgFR1zlVBEbtUzxGoF5B
   g6H0/mynnE51pBBDV+KiOI1mfoTcaQp7LLfsVxSfQzQAWpVn2rZ01zOWK
   w==;
X-CSE-ConnectionGUID: sKKsDQxgS+qDku1Z5kUywQ==
X-CSE-MsgGUID: L5trl373QcWyHiYP/Vswpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28899250"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28899250"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:53:28 -0700
X-CSE-ConnectionGUID: 7arqsPE1Q0qPzh2ehBBFyA==
X-CSE-MsgGUID: gCw747VwS+q2T8iY36aaOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="82775803"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:53:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 11:53:21 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 05/15] selftests/resctrl: Protect against array overflow
 when reading strings
In-Reply-To: <4adf01b3ee7019163ea4fc00b5d03d514d41b4b7.1729218182.git.reinette.chatre@intel.com>
Message-ID: <70d4206c-3a5f-e699-0608-f70751f124eb@linux.intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com> <4adf01b3ee7019163ea4fc00b5d03d514d41b4b7.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-895840305-1729241601=:1141"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-895840305-1729241601=:1141
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Reinette Chatre wrote:

> resctrl selftests discover system properties via a variety of sysfs files=
=2E
> The MBM and MBA tests need to discover the event and umask with which to
> configure the performance event used to measure read memory bandwidth.
> This is done by parsing the contents of
> /sys/bus/event_source/devices/uncore_imc_<imc instance>/events/cas_count_=
read
> Similarly, the resctrl selftests discover the cache size via
> /sys/bus/cpu/devices/cpu<id>/cache/index<index>/size.
>=20
> Take care to do bounds checking when using fscanf() to read the
> contents of files into a string buffer because by default fscanf() assume=
s
> arbitrarily long strings. If the file contains more bytes than the array
> can accommodate then an overflow will occur.
>=20
> Provide a maximum field width to the conversion specifier to protect
> against array overflow. The maximum is one less than the array size becau=
se
> string input stores a terminating null byte that is not covered by the
> maximum field width.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> This makes the code robust against any changes in information read
> from sysfs. The existing sysfs content fit well into the arrays, thus
> this is not considered a bugfix.
>=20
> Changes since V2:
> - New patch
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 4 ++--
>  tools/testing/selftests/resctrl/resctrlfs.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index e88d5ca30517..c9dd70ce3ea8 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -159,7 +159,7 @@ static int read_from_imc_dir(char *imc_dir, int count=
)
> =20
>  =09=09return -1;
>  =09}
> -=09if (fscanf(fp, "%s", cas_count_cfg) <=3D 0) {
> +=09if (fscanf(fp, "%1023s", cas_count_cfg) <=3D 0) {
>  =09=09ksft_perror("Could not get iMC cas count read");
>  =09=09fclose(fp);
> =20
> @@ -177,7 +177,7 @@ static int read_from_imc_dir(char *imc_dir, int count=
)
> =20
>  =09=09return -1;
>  =09}
> -=09if  (fscanf(fp, "%s", cas_count_cfg) <=3D 0) {
> +=09if  (fscanf(fp, "%1023s", cas_count_cfg) <=3D 0) {
>  =09=09ksft_perror("Could not get iMC cas count write");
>  =09=09fclose(fp);
> =20
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/=
selftests/resctrl/resctrlfs.c
> index 250c320349a7..a53cd1cb6e0c 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -182,7 +182,7 @@ int get_cache_size(int cpu_no, const char *cache_type=
, unsigned long *cache_size
> =20
>  =09=09return -1;
>  =09}
> -=09if (fscanf(fp, "%s", cache_str) <=3D 0) {
> +=09if (fscanf(fp, "%63s", cache_str) <=3D 0) {
>  =09=09ksft_perror("Could not get cache_size");
>  =09=09fclose(fp);
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-895840305-1729241601=:1141--

