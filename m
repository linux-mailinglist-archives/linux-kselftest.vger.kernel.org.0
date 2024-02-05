Return-Path: <linux-kselftest+bounces-4145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EE849BA0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 14:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70E0B21603
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495221CA9E;
	Mon,  5 Feb 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9Oqc+Yo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71061CA9A;
	Mon,  5 Feb 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138997; cv=none; b=JMjMN78SiLybAJWWM0qXtMKGQcTEvppaMapf/EgJ3joUQCJ6Oooj0O4kUbpkpC/5BgI3p/804gz5p/uWrdU6IpcqI0GS12TBXbaeiq4mA8TIIAIFLgLob7uOeV1YgAFdRJiYaaFLYdMepE4EPtpvz7SFTfkOD67XafynS0O8/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138997; c=relaxed/simple;
	bh=MHrgHTy57EOm4Y3WpMXf6Mix5n50cOHzPR6QJN3nMBk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JD1evXzfaic60u9EO6sqwGhe4rPD2zqj9kjC8VsSKd/XDQfqXR74sN86eGvga/OjS9tr0Yj627cwIlDAv3yhXtpE942nzIMj54s3vgYLb5gru5vprTmQRluvF2waCRXdqK5QViEP4oE46bgEORqWplX4hjvT4uYWIzLkP9zTWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9Oqc+Yo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707138996; x=1738674996;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MHrgHTy57EOm4Y3WpMXf6Mix5n50cOHzPR6QJN3nMBk=;
  b=b9Oqc+YoPQU2/ixJ7itywBT1bVqUdTLIxaue0thuclkT96TPa7sYdctp
   YfTFVi58DtP8uQ6+qELmoNqjj6SusArgdbeHN/SD3ks4Rvk8TxTYHjUwr
   QZc1K61ZZCzJix6l+u+Yaa3c+FTSXo8lwq+2M+mPPWbubVc7T6VjvCRvh
   I47CxyCSNwjh/68J3bc38IDYqOKBUWA2uPBlV+OESszef8bzOD+L3ix/Z
   +LB0Sysme+S6oIf36/qlsSnlaZOOC+AFlKwIKJqdH+H7MMwKzZMFxQQIM
   mWn7hegPtSQvZ8OS0I7UHWR+5RABOV0bfW6Oj+B3nyMbxsWOQXYTKq7l3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11609369"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11609369"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="691313"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:16:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Feb 2024 15:16:27 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: fenghua.yu@intel.com, reinette.chatre@intel.com, shuah@kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v4 2/5] selftests/resctrl: Add helpers for the non-contiguous
 test
In-Reply-To: <89b8965d563e4e61b95b20be55c26475d830b245.1707130307.git.maciej.wieczor-retman@intel.com>
Message-ID: <7cfff3da-b476-4f24-aa16-428c79bd81e2@linux.intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com> <89b8965d563e4e61b95b20be55c26475d830b245.1707130307.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1807511629-1707138987=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1807511629-1707138987=:1027
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 Feb 2024, Maciej Wieczor-Retman wrote:

> The CAT non-contiguous selftests have to read the file responsible for
> reporting support of non-contiguous CBMs in kernel (resctrl). Then the
> test compares if that information matches what is reported by CPUID
> output.
>=20
> Add a generic helper function to read an unsigned number from a file in
> /sys/fs/resctrl/info/<RESOURCE>/<FILE>.
>=20
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Rewrite function comment.
> - Redo ksft_perror() as ksft_print_msg(). (Reinette)
>=20
> Changelog v3:
> - Rewrite patch message.
> - Add documentation and rewrote the function. (Reinette)
>=20
> Changelog v2:
> - Add this patch.
>=20
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 36 +++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index a1462029998e..5116ea082d03 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -162,6 +162,7 @@ unsigned int count_contiguous_bits(unsigned long val,=
 unsigned int *start);
>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *ca=
che_size);
> +int resource_info_unsigned_get(const char *resource, const char *filenam=
e, unsigned int *val);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
>  void signal_handler_unregister(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/=
selftests/resctrl/resctrlfs.c
> index 5750662cce57..e0fbc46a917a 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -249,6 +249,42 @@ static int get_bit_mask(const char *filename, unsign=
ed long *mask)
>  =09return 0;
>  }
> =20
> +/**
> + * resource_info_unsigned_get - Read an unsigned value from
> + * /sys/fs/resctrl/info/RESOURCE/FILENAME
> + * @resource:=09Resource name that matches directory name in
> + *=09=09/sys/fs/resctrl/info
> + * @filename:=09File in /sys/fs/resctrl/info/@resource
> + * @val:=09Contains read value on success.
> + *
> + * Return: =3D 0 on success, < 0 on failure. On success the read
> + * value is saved into the @val.
> + */
> +int resource_info_unsigned_get(const char *resource, const char *filenam=
e,
> +=09=09=09       unsigned int *val)
> +{
> +=09char file_path[PATH_MAX];
> +=09FILE *fp;
> +
> +=09snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resourc=
e,
> +=09=09 filename);
> +
> +=09fp =3D fopen(file_path, "r");
> +=09if (!fp) {
> +=09=09ksft_print_msg("Error in opening %s\n: %m\n", file_path);

Adding the extra \n in between there will likely mess up the test output=20
formatting (the expected prefixes will not appear). Therefore, manually=20
adding newlines should be avoided.

> +=09=09return -1;
> +=09}
> +
> +=09if (fscanf(fp, "%u", val) <=3D 0) {
> +=09=09ksft_print_msg("Could not get contents of %s\n: %m\n", file_path);

Ditto.

With those two fixed,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1807511629-1707138987=:1027--

