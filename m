Return-Path: <linux-kselftest+bounces-18648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6698A5DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 15:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAED28319C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8118FDCD;
	Mon, 30 Sep 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQqtYTlo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7B18F2CF;
	Mon, 30 Sep 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704188; cv=none; b=Dudg5I+zLohaM1uq1OhMy1VpsSr/SPTVR0VkpAdYvJqeduitv1kCIiCnOes5EhpowbrnKI3/rQNdz9t/1Zl0nBxr+dNnH9+UmbPwWKXDeq2TUj2OsP2OMJKQbFRfaNibTALhlhS2QhRuX3O8RqvsEjzXZHsGcBReG3XhiqFWm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704188; c=relaxed/simple;
	bh=CMRtgHOyVoHjwQIEEvabYPyGlC1aDfVrMwNWnFIZg1E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hetJzQoLw0G5x6SKO7i8hgP8/rugXX4u1sST70M6CrArrIH72LM3mt7AwnK0mhAcLGrfOgWU8nf+X7GkT0gWD6dAPWExaG+1QbzLq+GkNM2UTQRCxf6flFV+tHU+vb7eamOx+HlL3lp72xR4MGBdMtHNJiiPf82neTvWeqhc7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQqtYTlo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727704187; x=1759240187;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CMRtgHOyVoHjwQIEEvabYPyGlC1aDfVrMwNWnFIZg1E=;
  b=YQqtYTlo+Tje2AMlYHq50cjxOC8s+FB3sA7/0LeXLsDtjyrRUM4pP9y/
   IIdcg4CMdvDtYLzzXuzymnfrtUQ8BA3Xkody216O+BfqhiGSKrChxLNgR
   DxKUzQ1P28lfkZpfH74opwIzyqPTPVNBjZuM/ZZlYWFHEZfLIpf8ELaGh
   bPJH07y00wBqoTrh3On0s/pqeIpRbXeGTDqqbuIau8tEJBrAREEvQnesv
   z1NNZWceAdZ1827smCEQzBUElVBAbTFCqT+49QbCjN4QxC4AR0g7Wt4W7
   HDPjn6ywKYrb8nlIa/aJaNNVHYDWwXLKG8jyzUiKToBZwme8vZ/SefI/m
   A==;
X-CSE-ConnectionGUID: 1duwETtOQH2khmf7lHN+CQ==
X-CSE-MsgGUID: lyI+DQKaS8OlgyduPQnrAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="14417844"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="14417844"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:49:46 -0700
X-CSE-ConnectionGUID: xV2u+7xNSK62NVSHZL/5nw==
X-CSE-MsgGUID: a2MBGPZjQX2cXpNoodiRJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73177741"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:49:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Sep 2024 16:49:39 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 06/13] selftests/resctrl: Remove "once" parameter
 required to be false
In-Reply-To: <1f5ad02dc424bfc3cca705ed9a322df8f35f2ff4.1726164080.git.reinette.chatre@intel.com>
Message-ID: <f692fe7c-e81d-2086-fc1d-f3af436580c1@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <1f5ad02dc424bfc3cca705ed9a322df8f35f2ff4.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2035177807-1727704179=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2035177807-1727704179=:938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> The CMT, MBM, and MBA tests rely on a benchmark that runs while
> the test makes changes to needed configuration (for example memory
> bandwidth allocation) and takes needed measurements. By default
> the "fill_buf" benchmark is used and by default (via its
> "once =3D false" setting) "fill_buf" is configured to run until
> terminated after the test completes.
>=20
> An unintended consequence of enabling the user to override the
> benchmark also enables the user to change parameters to the
> "fill_buf" benchmark. This enables the user to set "fill_buf" to
> only cycle through the buffer once (by setting "once =3D true")
> and thus breaking the CMT, MBA, and MBM tests that expect
> workload/interference to be reflected by their measurements.
>=20
> Prevent user space from changing the "once" parameter and ensure
> that it is always false for the CMT, MBA, and MBM tests.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - New patch
> ---
>  tools/testing/selftests/resctrl/fill_buf.c      |  7 ++++---
>  tools/testing/selftests/resctrl/resctrl.h       |  2 +-
>  tools/testing/selftests/resctrl/resctrl_tests.c |  8 +++++++-
>  tools/testing/selftests/resctrl/resctrl_val.c   | 11 +----------
>  4 files changed, 13 insertions(+), 15 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/s=
elftests/resctrl/fill_buf.c
> index 34e5df721430..854f0108d8e6 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -151,7 +151,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memf=
lush)
>  =09return buf;
>  }
> =20
> -int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
> +int run_fill_buf(size_t buf_size, int memflush, int op)
>  {
>  =09unsigned char *buf;
> =20
> @@ -160,9 +160,10 @@ int run_fill_buf(size_t buf_size, int memflush, int =
op, bool once)
>  =09=09return -1;
> =20
>  =09if (op =3D=3D 0)
> -=09=09fill_cache_read(buf, buf_size, once);
> +=09=09fill_cache_read(buf, buf_size, false);
>  =09else
> -=09=09fill_cache_write(buf, buf_size, once);
> +=09=09fill_cache_write(buf, buf_size, false);
> +
>  =09free(buf);
> =20
>  =09return 0;
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index 2dda56084588..51f5f4b25e06 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event,=
 pid_t pid, int cpu,
>  unsigned char *alloc_buffer(size_t buf_size, int memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> -int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
> +int run_fill_buf(size_t buf_size, int memflush, int op);
>  int initialize_mem_bw_imc(void);
>  int measure_mem_bw(const struct user_params *uparams,
>  =09=09   struct resctrl_val_param *param, pid_t bm_pid,
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/test=
ing/selftests/resctrl/resctrl_tests.c
> index ecbb7605a981..bee4123a5a9b 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -266,7 +266,13 @@ int main(int argc, char **argv)
>  =09=09uparams.benchmark_cmd[1] =3D span_str;
>  =09=09uparams.benchmark_cmd[2] =3D "1";
>  =09=09uparams.benchmark_cmd[3] =3D "0";
> -=09=09uparams.benchmark_cmd[4] =3D "false";
> +=09=09/*
> +=09=09 * Fourth parameter was previously used to indicate
> +=09=09 * how long "fill_buf" should run for, with "false"
> +=09=09 * ("fill_buf" will keep running until terminated)
> +=09=09 * the only option that works.
> +=09=09 */
> +=09=09uparams.benchmark_cmd[4] =3D NULL;
>  =09=09uparams.benchmark_cmd[5] =3D NULL;

Why is the [5] assignment kept around? Is something depending on this=20
double NULL termination? This patch removed the access to [4] so I=20
don't see anything beyong [3] accessed explicitly.

--=20
 i.

>  =09}
> =20
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index e88d5ca30517..5331354aaf64 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -625,7 +625,6 @@ static void run_benchmark(int signum, siginfo_t *info=
, void *ucontext)
>  =09int operation, ret, memflush;
>  =09char **benchmark_cmd;
>  =09size_t span;
> -=09bool once;
>  =09FILE *fp;
> =20
>  =09benchmark_cmd =3D info->si_ptr;
> @@ -645,16 +644,8 @@ static void run_benchmark(int signum, siginfo_t *inf=
o, void *ucontext)
>  =09=09span =3D strtoul(benchmark_cmd[1], NULL, 10);
>  =09=09memflush =3D  atoi(benchmark_cmd[2]);
>  =09=09operation =3D atoi(benchmark_cmd[3]);
> -=09=09if (!strcmp(benchmark_cmd[4], "true")) {
> -=09=09=09once =3D true;
> -=09=09} else if (!strcmp(benchmark_cmd[4], "false")) {
> -=09=09=09once =3D false;
> -=09=09} else {
> -=09=09=09ksft_print_msg("Invalid once parameter\n");
> -=09=09=09parent_exit(ppid);
> -=09=09}
> =20
> -=09=09if (run_fill_buf(span, memflush, operation, once))
> +=09=09if (run_fill_buf(span, memflush, operation))
>  =09=09=09fprintf(stderr, "Error in running fill buffer\n");
>  =09} else {
>  =09=09/* Execute specified benchmark */
>=20
--8323328-2035177807-1727704179=:938--

