Return-Path: <linux-kselftest+bounces-20118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7339A3936
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3F1B23E36
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482B18FDA7;
	Fri, 18 Oct 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koHYRySY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B318FC80;
	Fri, 18 Oct 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241668; cv=none; b=lvflyKFA6LCYX/fK1rXEb0XhSI1kNFeH4CfLL+y/b9ALXsfeV7Tc8Z1hmuIDvCNHA39uOWzvqxeeiELYjae6vTR1XF36lj5JuYm0FJtyuErg+d++CVMSCb6ukNxpraTtiWcMVbkPyJPMECDIlaPVhzlzGbI7y6K0ybsKpPymOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241668; c=relaxed/simple;
	bh=jPArnCaOwbwscCXl+GpppUuGJHV9FN6GTAHO9kT0nUo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=irg6NbtLLR+4t4kE9XWGXfg4eO8mN+tGYA/uxoCz+RjaNXvBFFSHvkKOU0ZD0sSsUhV5N+h/ms83W8vFOK0Td5hQxKTGAM98/+qCjszmlOyVCI3U+05qs9gCfoXrH+qwLX9QpjozYwpCXS/mGbQBq4C4nJ3C1CpUpxwQeykpDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koHYRySY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729241667; x=1760777667;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jPArnCaOwbwscCXl+GpppUuGJHV9FN6GTAHO9kT0nUo=;
  b=koHYRySYioF7J2pC/cG9AnSlEsi445jNRJ63pr+grlkdyO8cOU/AxgD/
   UqNodStaMJPfNiELZRAG45Ss7EXlc9I+p3e6tB+RNXYU20VFFqUin4mnJ
   exDyds01GaJ5qqn70gnX+eDTa5LJHHJOBZBGe+4cPt0p5olzJj0uWYhaM
   IgNCIAihhwDvvPTMZfAz5Ys7xX8mApYIMZBiA5tyIM300KB8Eq8p1IZbf
   93eNpN59GcT/V2NvH//L1vrC52Uq1n6k1rSe+5AE7ouWka080NWEljV1Y
   C83M8Kgjtaf9OFOH+C8cMa+WeM462bN0l5cau5N9mGJl+muHzcTESpZ6J
   w==;
X-CSE-ConnectionGUID: 0pS+Np96SEazWj/ArdM9Uw==
X-CSE-MsgGUID: QpbnkgFOQsKfEo8auWcStg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46220893"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46220893"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:54:26 -0700
X-CSE-ConnectionGUID: eyUO36TDRU+4KGFUpALusA==
X-CSE-MsgGUID: aMLV3UWHQhGAHY0tWa0FXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78960632"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:54:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 11:54:20 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 07/15] selftests/resctrl: Remove "once" parameter
 required to be false
In-Reply-To: <8749a13135c7e66bd9d463d94b15a9214b8c4b69.1729218182.git.reinette.chatre@intel.com>
Message-ID: <2502fa49-edba-e01e-78b7-00e2f2ccfa92@linux.intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com> <8749a13135c7e66bd9d463d94b15a9214b8c4b69.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-961659644-1729241660=:1141"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-961659644-1729241660=:1141
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Reinette Chatre wrote:

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

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> Changes since V2:
> - Remove unnecessary assignment to benchmark_cmd[5]. (Ilpo)
>=20
> Changes since V1:
> - New patch
> ---
>  tools/testing/selftests/resctrl/fill_buf.c      |  7 ++++---
>  tools/testing/selftests/resctrl/resctrl.h       |  2 +-
>  tools/testing/selftests/resctrl/resctrl_tests.c |  9 +++++++--
>  tools/testing/selftests/resctrl/resctrl_val.c   | 11 +----------
>  4 files changed, 13 insertions(+), 16 deletions(-)
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
> index ecbb7605a981..e7878077883f 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -266,8 +266,13 @@ int main(int argc, char **argv)
>  =09=09uparams.benchmark_cmd[1] =3D span_str;
>  =09=09uparams.benchmark_cmd[2] =3D "1";
>  =09=09uparams.benchmark_cmd[3] =3D "0";
> -=09=09uparams.benchmark_cmd[4] =3D "false";
> -=09=09uparams.benchmark_cmd[5] =3D NULL;
> +=09=09/*
> +=09=09 * Fourth parameter was previously used to indicate
> +=09=09 * how long "fill_buf" should run for, with "false"
> +=09=09 * ("fill_buf" will keep running until terminated)
> +=09=09 * the only option that works.
> +=09=09 */
> +=09=09uparams.benchmark_cmd[4] =3D NULL;
>  =09}
> =20
>  =09ksft_set_plan(tests);
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index c9dd70ce3ea8..b0f3c594c4da 100644
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
--8323328-961659644-1729241660=:1141--

