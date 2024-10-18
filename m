Return-Path: <linux-kselftest+bounces-20122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7B9A3966
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5FB1C21288
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBEA18FDCC;
	Fri, 18 Oct 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQpnsepR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BE1865EA;
	Fri, 18 Oct 2024 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242417; cv=none; b=cneYNMgdU9dKRq8WHQf1WVtSEcuiX1LpYdEopUj1GAl146KLzWLItm9xIIWGcnloj8P9YI7dMhPXexw9rrHAjpqFAbgoIy4F85q9Fo9pCwclkODWnA3epZ1XBDeL83id3pIwWanLWZxz394Fz3Row7sUtpsEFoBqZ4HcFsEIzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242417; c=relaxed/simple;
	bh=MD1IqCerImI2/E5V1nfSvhkHwAZcQZoiQLxeKCChlEo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PDrgkkLCE0QQQCNfJRLokV+Hd950WjE0H+13nLa7gsbCRox8P+DQFdfWeRQSwlwXbYsSdQH9pgyg1vr8ueZ5PXMIfmRTOzfuFk6i08UBBXbLbS1iLH0DRzbeYGXIN3HeQ3qVia+xE+XXB+JyxWfFEyvUTxHhaOzlVCzL90NTtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQpnsepR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729242416; x=1760778416;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MD1IqCerImI2/E5V1nfSvhkHwAZcQZoiQLxeKCChlEo=;
  b=LQpnsepRV3yexEGflx0wC1F0irPqextXw2lF8vn/6ivK4Xpl5BKhNmgh
   9chn7zccvEc8WEQ70Okm7Tfg2tJHZvJpUyvkrEDM2UDkCaFyNPqunAZ4S
   0kkoIU8lZrNv3PkAUjg5J9dSjcrDLgygMEtz1XIa5dNshTJtSYkKcGQAw
   Ww4K/NREi69DuPVIWYH//GkIgbuxy98ntYFSj42dj8liTQMODr04QIwBR
   hdupLm/3WFeB9GHTV6pSpjSBmdGlb+p1u7k4BT9wrjYFE14tdWlBbodlS
   WnzJZKUsAaC7G1+hFVMMoMYbruvR8Iiy1lQHgrKACYhpOVgq4u2COiobq
   Q==;
X-CSE-ConnectionGUID: nXOK9u+fSX25FC5UG/nZkA==
X-CSE-MsgGUID: 5Jr+FKfNRxanyIGRR5XuoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39308204"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39308204"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:06:55 -0700
X-CSE-ConnectionGUID: N3VQl4+1TSW+7d76KWA4Gg==
X-CSE-MsgGUID: z8eSuixsRiS8+8YVF2gadQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78964348"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:06:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 12:06:48 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 12/15] selftests/resctrl: Use cache size to determine
 "fill_buf" buffer size
In-Reply-To: <388c93423d9a071f5877f3edb4f55ef64bf384bc.1729218182.git.reinette.chatre@intel.com>
Message-ID: <064588b9-f6a9-cf49-bbca-c502314490ba@linux.intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com> <388c93423d9a071f5877f3edb4f55ef64bf384bc.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-667949199-1729242408=:1141"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-667949199-1729242408=:1141
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Reinette Chatre wrote:

> By default the MBM and MBA tests use the "fill_buf" benchmark to
> read from a buffer with the goal to measure the memory bandwidth
> generated by this buffer access.
>=20
> Care should be taken when sizing the buffer used by the "fill_buf"
> benchmark. If the buffer is small enough to fit in the cache then
> it cannot be expected that the benchmark will generate much memory
> bandwidth. For example, on a system with 320MB L3 cache the existing
> hardcoded default of 250MB is insufficient.
>=20
> Use the measured cache size to determine a buffer size that can be
> expected to trigger memory access while keeping the existing default
> as minimum, now renamed to MINIMUM_SPAN, that has been appropriate for
> testing so far.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Look good, thanks.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
> Changes since V2:
> - Move duplicate code into helper. (Ilpo)
> - Rename DEFAULT_SPAN to MINIMUM_SPAN to reflect its new purpose. (Ilpo)
> - Do _not_ add Ilpo's Reviewed-by tag ... the patch changed too much.
>=20
> Changes since V1:
> - Ensure buffer is at least double L3 cache size. (Ilpo)
> - Support user override of default buffer size. (Ilpo)
> ---
>  tools/testing/selftests/resctrl/fill_buf.c      | 13 +++++++++++++
>  tools/testing/selftests/resctrl/mba_test.c      |  7 ++++++-
>  tools/testing/selftests/resctrl/mbm_test.c      |  7 ++++++-
>  tools/testing/selftests/resctrl/resctrl.h       |  3 ++-
>  tools/testing/selftests/resctrl/resctrl_tests.c |  2 +-
>  5 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/s=
elftests/resctrl/fill_buf.c
> index 380cc35f10c6..19a01a52dc1a 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -129,3 +129,16 @@ unsigned char *alloc_buffer(size_t buf_size, bool me=
mflush)
> =20
>  =09return buf;
>  }
> +
> +ssize_t get_fill_buf_size(int cpu_no, const char *cache_type)
> +{
> +=09unsigned long cache_total_size =3D 0;
> +=09int ret;
> +
> +=09ret =3D get_cache_size(cpu_no, cache_type, &cache_total_size);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return cache_total_size * 2 > MINIMUM_SPAN ?
> +=09=09=09cache_total_size * 2 : MINIMUM_SPAN;
> +}
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index 74d95c460bd0..bf37f3555660 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -182,7 +182,12 @@ static int mba_run_test(const struct resctrl_test *t=
est, const struct user_param
>  =09=09fill_buf.memflush =3D uparams->fill_buf->memflush;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09} else if (!uparams->benchmark_cmd[0]) {
> -=09=09fill_buf.buf_size =3D DEFAULT_SPAN;
> +=09=09ssize_t buf_size;
> +
> +=09=09buf_size =3D get_fill_buf_size(uparams->cpu, "L3");
> +=09=09if (buf_size < 0)
> +=09=09=09return buf_size;
> +=09=09fill_buf.buf_size =3D buf_size;
>  =09=09fill_buf.memflush =3D true;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09}
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/s=
elftests/resctrl/mbm_test.c
> index 72261413c868..4224f8ce3538 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -149,7 +149,12 @@ static int mbm_run_test(const struct resctrl_test *t=
est, const struct user_param
>  =09=09fill_buf.memflush =3D uparams->fill_buf->memflush;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09} else if (!uparams->benchmark_cmd[0]) {
> -=09=09fill_buf.buf_size =3D DEFAULT_SPAN;
> +=09=09ssize_t buf_size;
> +
> +=09=09buf_size =3D get_fill_buf_size(uparams->cpu, "L3");
> +=09=09if (buf_size < 0)
> +=09=09=09return buf_size;
> +=09=09fill_buf.buf_size =3D buf_size;
>  =09=09fill_buf.memflush =3D true;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09}
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index 032cd9ebd761..a553fe975938 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -41,7 +41,7 @@
> =20
>  #define BENCHMARK_ARGS=09=0964
> =20
> -#define DEFAULT_SPAN=09=09(250 * MB)
> +#define MINIMUM_SPAN=09=09(250 * MB)
> =20
>  /*
>   * fill_buf_param:=09"fill_buf" benchmark parameters
> @@ -169,6 +169,7 @@ int perf_event_open(struct perf_event_attr *hw_event,=
 pid_t pid, int cpu,
>  unsigned char *alloc_buffer(size_t buf_size, bool memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> +ssize_t get_fill_buf_size(int cpu_no, const char *cache_type);
>  int initialize_read_mem_bw_imc(void);
>  int measure_read_mem_bw(const struct user_params *uparams,
>  =09=09=09struct resctrl_val_param *param, pid_t bm_pid);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/test=
ing/selftests/resctrl/resctrl_tests.c
> index 88768f4d4961..790f4eb7871a 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -189,7 +189,7 @@ static struct fill_buf_param *alloc_fill_buf_param(st=
ruct user_params *uparams)
>  =09=09=09ksft_exit_skip("Unable to parse benchmark buffer size.\n");
>  =09=09}
>  =09} else {
> -=09=09fill_param->buf_size =3D DEFAULT_SPAN;
> +=09=09fill_param->buf_size =3D MINIMUM_SPAN;
>  =09}
> =20
>  =09if (uparams->benchmark_cmd[2]) {
>=20
--8323328-667949199-1729242408=:1141--

