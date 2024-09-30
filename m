Return-Path: <linux-kselftest+bounces-18647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CF98A567
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACB5281981
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C2818E779;
	Mon, 30 Sep 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQ7XLHLQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFC157A5C;
	Mon, 30 Sep 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703336; cv=none; b=moLEdreJcrtXWuBu6rGwllpgoQqOU0hSwYlKO9JInEQoVRtc1vOpGTmjnm1dIuB/1vkPagxTkEZ36pj2FxEMN3Yn84NBhH9bmGSOm3T/rkgRft0poI0jH42q3vLQ+d8AI17ozG70rEvZc0Al7gWI+wh/oDZuGcNMpIhuPMzLVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703336; c=relaxed/simple;
	bh=wpk8Xj6hS9Lyqr2G2RKw+Zd47k6ByENaOrMXscau0g0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OtHZ/M/oaJ482iT3/sZAiavzlam/IWDKg8Kn+7F0DkDLIOmWQGVOq1/qBMkR7BFjAR7CLlauyDga+AB3UR3ZUKufFpET0tYddA7lUejZL+76yDG1/zmpihSVXUpXo9VlAHaFg56+ui7Fue+0KANCx4+PYqW2tf+GMOwA4l6l+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQ7XLHLQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703335; x=1759239335;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wpk8Xj6hS9Lyqr2G2RKw+Zd47k6ByENaOrMXscau0g0=;
  b=CQ7XLHLQkmFNTzH7/r/V4mO0ttn2C3tGIg6eW5YmI6HTM3wokUqBMkZN
   v2XADVq060LXIhnzh+YM13B2swISAENFrKvKA4NVAWbL/O+xPy/vK0noT
   7jrXM8UtUhJR0N242HFw/KsSCfoypqez8PrVKJEn51oO5Y1iLeAeFPZK+
   4vFFkC0mMiUHHfBoMUDV6KMg7VJ9vKf9rt1t+j0ZSQm8DeoDio6yRPy5Q
   RXht6v/r51kTKW7fW1c6fVeDvcuRJLZ6GhS8myuxRbLdlzXm7qrR7oPhv
   5iaSjI5mo6GED1s9T9G5H//TWX/x5Kzq2yOBoyoJ7KUIooLJhmZ9txqkc
   Q==;
X-CSE-ConnectionGUID: u0z3PIuyR8e+sWzJs0FBzw==
X-CSE-MsgGUID: 3FhK3vVvR3yChZ/xHMrA5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44311825"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44311825"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:35:34 -0700
X-CSE-ConnectionGUID: OreTxhscTLKPUKPVlETLkw==
X-CSE-MsgGUID: rn88oSeUSnaIZiqvsRXolA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104107858"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:35:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Sep 2024 16:35:28 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 04/13] selftests/resctrl: Protect against array overrun
 during iMC config parsing
In-Reply-To: <c3ff2c7df3d10931087e25e5488eb1ab2f5fe13c.1726164080.git.reinette.chatre@intel.com>
Message-ID: <93b9f530-1d2d-dc19-1d48-c15aced32804@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <c3ff2c7df3d10931087e25e5488eb1ab2f5fe13c.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-737293731-1727703328=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-737293731-1727703328=:938
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> The MBM and MBA tests need to discover the event and umask with which to
> configure the performance event used to measure read memory bandwidth.
> This is done by parsing the
> /sys/bus/event_source/devices/uncore_imc_<imc instance>/events/cas_count_=
read
> file for each iMC instance that contains the formatted
> output: "event=3D<event>,umask=3D<umask>"
>=20
> Parsing of cas_count_read contents is done by initializing an array of
> MAX_TOKENS elements with tokens (deliminated by "=3D,") from this file.
> Start by removing the unnecessary append of a delimiter to the string

Start what? (It sounds odd given the lack of any context, my guess is=20
you're trying to refer to start/first one of the changes you make in the=20
patch but the textual context does not support that conclusion.) I suggest=
=20
you just rephrase it and avoid using "start" word altogether.

> needing to be parsed. Per the strtok() man page: "delimiter bytes at
> the start or end of the string are ignored". This has no impact on
> the token placement within the array.
>=20
> After initialization, the actual event and umask is determined by
> parsing the tokens directly following the "event" and "umask" tokens
> respectively.
>=20
> Iterating through the array up to index "i < MAX_TOKENS" but then
> accessing index "i + 1" risks array overrun during the final iteration.
> Avoid array overrun by ensuring that the index used within for
> loop will always be valid.
>=20
> Fixes: 1d3f08687d76 ("selftests/resctrl: Read memory bandwidth from perf =
IMC counter and from resctrl file system")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index 70e8e31f5d1a..e88d5ca30517 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -83,13 +83,12 @@ static void get_event_and_umask(char *cas_count_cfg, =
int count, bool op)
>  =09char *token[MAX_TOKENS];
>  =09int i =3D 0;
> =20
> -=09strcat(cas_count_cfg, ",");
>  =09token[0] =3D strtok(cas_count_cfg, "=3D,");
> =20
>  =09for (i =3D 1; i < MAX_TOKENS; i++)
>  =09=09token[i] =3D strtok(NULL, "=3D,");
> =20
> -=09for (i =3D 0; i < MAX_TOKENS; i++) {
> +=09for (i =3D 0; i < MAX_TOKENS - 1; i++) {
>  =09=09if (!token[i])
>  =09=09=09break;
>  =09=09if (strcmp(token[i], "event") =3D=3D 0) {
>=20

The code change seems fine so after improving the commit message, please=20
add:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-737293731-1727703328=:938--

