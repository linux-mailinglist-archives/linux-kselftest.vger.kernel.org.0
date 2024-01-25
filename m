Return-Path: <linux-kselftest+bounces-3565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ECA83C267
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 13:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1C51F2134E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A24502B;
	Thu, 25 Jan 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTviEwe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAD45BFA;
	Thu, 25 Jan 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184990; cv=none; b=ZiqE6UXB4jOd4w25xAxtSRIxYOn0ru1hhvjKGtiySw4WCjY/WOLqZP13aR3s8k8ENrBVym1+gKOLJ5uAEdxGZf3kOVNuMTySTJJRTZ8ZLYaR/X0yJAOzMtYNGpdovgfqvH8ChpA1zTKsudvpOdXxj90D2FdmrXF/XcKfldc1QEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184990; c=relaxed/simple;
	bh=HwBQsm7MBgHhSyzAfl7jjyQrBcB7NcfolPyNJzRBR24=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kZijhcnsvmpwHLyRVrT9QzTCFBJgyjfRLA5zIJhWgzyMp4VVYy0vnlbN1+5cMCpILdKELXOdmlxAVuRzWnu754FM8TXVpfCc/no3Z9ZcI5RJbYHPHNUrPAL1btcKeTQEUrhmv2nlTbLTmZXluAitQ49B4olMXZkAJtmYjH0HVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTviEwe6; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706184989; x=1737720989;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HwBQsm7MBgHhSyzAfl7jjyQrBcB7NcfolPyNJzRBR24=;
  b=fTviEwe6cEsoG2IIZ8LDIKg6skdvj+ETVE7yN1Sv2ZxxrzsA9n3oWL/Y
   M7fGfpA0iya3UrpCW9EsgcykVEccXN0ZERnIL0xdKK4djD0GjyAJiTgly
   iI/Xrp4zfB9w6/PbFUzo73RX3LmU/dU7uPRu8piOwR08RAWkDDl9KNIex
   fzYun0ZjQ5LjOiLj/CJMCpGMqnzEYDpfoidZoQDvWKAQrTiAXMB5W9K6z
   X1TPuK705CpNCetsJnPzynxPOENBdfnF93rRR5bbgtgba532FR7L/+gQN
   ae3DiA8HBECS2m1sC0YZ+4Zi3Iao8afFaeik6+waAB9nzK5sIFUAkhaMq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400999114"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400999114"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="736300929"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736300929"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.252.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:16:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 25 Jan 2024 14:16:20 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org, 
    fenghua.yu@intel.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/5] selftests/resctrl: Add
 resource_info_file_exists()
In-Reply-To: <e73a79210076d6b1b7b584b12d0499e2f2e5f4fe.1706180726.git.maciej.wieczor-retman@intel.com>
Message-ID: <7452603a-4347-a51e-c91f-ff0b17cc99ad@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com> <e73a79210076d6b1b7b584b12d0499e2f2e5f4fe.1706180726.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1973767011-1706184980=:1444"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1973767011-1706184980=:1444
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 25 Jan 2024, Maciej Wieczor-Retman wrote:

> Feature checking done by resctrl_mon_feature_exists() covers features
> represented by the feature name presence inside the 'mon_features' file
> in /sys/fs/resctrl/info/L3_MON directory. There exists a different way
> to represent feature support and that is by the presence of 0 or 1 in a
> single file in the info/resource directory. In this case the filename
> represents what feature support is being indicated.
>=20
> Add a generic function to check file presence in the
> /sys/fs/resctrl/info/<RESOURCE> directory.
>=20
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Split off the new function into this patch. (Reinette)
>=20
> Changelog v2:
> - Add this patch.
>=20
>  tools/testing/selftests/resctrl/resctrl.h   |  2 ++
>  tools/testing/selftests/resctrl/resctrlfs.c | 26 +++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index 4603b215b97e..c39105f46da9 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -138,6 +138,8 @@ int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
>  bool resctrl_resource_exists(const char *resource);
>  bool resctrl_mon_feature_exists(const char *feature);
> +bool resource_info_file_exists(const char *resource,
> +=09=09=09       const char *feature);
>  bool test_resource_feature_check(const struct resctrl_test *test);
>  char *fgrep(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity)=
;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/=
selftests/resctrl/resctrlfs.c
> index e4ba8614fb7b..a6427732e0ad 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -763,6 +763,32 @@ bool resctrl_mon_feature_exists(const char *feature)
>  =09return !!res;
>  }
> =20
> +/*
> + * resource_info_file_exists - Check if a file is present inside
> + * /sys/fs/resctrl/info/RESOURCE.
> + * @resource:=09Required resource (Eg: MB, L3, L2, etc.)
> + * @feature:=09Required feature.
> + *
> + * Return: True if the file exists, else false.
> + */
> +bool resource_info_file_exists(const char *resource,
> +=09=09=09       const char *feature)

Fits to one line.

> +{
> +=09char res_path[PATH_MAX];
> +=09struct stat statbuf;
> +
> +=09if (!feature || !resource)
> +=09=09return false;
> +
> +=09snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH, resource,
> +=09=09 feature);
> +
> +=09if (stat(res_path, &statbuf))
> +=09=09return false;
> +
> +=09return true;
> +}
> +
>  bool test_resource_feature_check(const struct resctrl_test *test)
>  {
>  =09return resctrl_resource_exists(test->resource);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1973767011-1706184980=:1444--

