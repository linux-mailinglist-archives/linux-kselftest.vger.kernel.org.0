Return-Path: <linux-kselftest+bounces-20119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138109A3943
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A016A1F25390
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324C18FC75;
	Fri, 18 Oct 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLbatw1D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF817DE36;
	Fri, 18 Oct 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241743; cv=none; b=LB82+wKSBun6WUPVMIzehTqxlmExfa/lEc0+f4GsZCKOI83Hma6HcGLW2jfnGl1OlDk6ZfrVd71rzqQI9IPHxgLM3GFXYcY2/2EReRFh74nm5mv+zYgM3O8cPmme+1eSKBOa3Bdor6dEyTIocPMS9SOIUaF+1zntUQ2/LGI8Lak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241743; c=relaxed/simple;
	bh=a3FJK79Wq3kkI8YAqhGkoe37e+zTJROY0waZT8FEpis=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yg1TXOeqV4qA/bfMmwa/1AiNQOGfNOBo0n6oAHGhmROzrzKOpZgoq4nr3hG8Sh5RmK1pQ1HIh7gsyK6cl1OOnZ6vg8LZk5i91YB8ZQgS/xshXMJg9sDZofTTO5njCFkxmf7jx54o/H+pyG1ImeKsmIxSCCbzNlJkN0QGWqgsePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLbatw1D; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729241741; x=1760777741;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=a3FJK79Wq3kkI8YAqhGkoe37e+zTJROY0waZT8FEpis=;
  b=NLbatw1D/UA83CQzfaEw+x1HMigL2D8bxprCGVGkZcEUBiTfxo5N82uB
   qj6/2RRW7Y/Isa8mrYpDQsH/MrgJwigrqCqINnqlsXEy6yTEnyOwN+1mP
   2MjAhNBWMenlGvuu+AL1ssP6aSvhRCh8Oh/yZYk8uwseLauiW/SYc6iCk
   AT5Lz+lXsYKQVgBE6xMHRWWTcaxoW7D2VMR1MEo2nBfAzs8PRjk1XGata
   pRPyEs11y7Tw3Cg01HVmaTzNRgnRTancWhrGUYpg7pysQj8kZq6TcUYld
   d4m5pc1U7RR7YLOBLETq36sWKZ59shDISaIwuB93nFGp/MqOirsxmx/hs
   Q==;
X-CSE-ConnectionGUID: 3dASBEJ5ST+29ZZ0v8nTQg==
X-CSE-MsgGUID: 39aJRo2qRwi/TfCNwQRctw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="40164539"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="40164539"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:55:41 -0700
X-CSE-ConnectionGUID: 0zCBx7OzQYqOJWwkv1NKkw==
X-CSE-MsgGUID: ji2PIPAoTiKHrpBTTeS3tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78719691"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:55:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 11:55:35 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 08/15] selftests/resctrl: Only support measured read
 operation
In-Reply-To: <3e451b37bf88a96018d6ab6564dbdf2f853c86ee.1729218182.git.reinette.chatre@intel.com>
Message-ID: <0d5fdeff-2bd9-91ad-b98e-c7efc998e77d@linux.intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com> <3e451b37bf88a96018d6ab6564dbdf2f853c86ee.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1834914115-1729241735=:1141"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1834914115-1729241735=:1141
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Reinette Chatre wrote:

> The CMT, MBM, and MBA tests rely on a benchmark to generate
> memory traffic. By default this is the "fill_buf" benchmark that
> can be replaced via the "-b" command line argument.
>=20
> The original intent of the "-b" command line parameter was
> to replace the default "fill_buf" benchmark, but the implementation
> also exposes an alternative use case where the "fill_buf" parameters
> itself can be modified. One of the parameters to "fill_buf" is the
> "operation" that can be either "read" or "write" and indicates
> whether the "fill_buf" should use "read" or "write" operations on the
> allocated buffer.
>=20
> While replacing "fill_buf" default parameters is technically possible,
> replacing the default "read" parameter with "write" is not supported
> because the MBA and MBM tests only measure "read" operations. The
> "read" operation is also most appropriate for the CMT test that aims
> to use the benchmark to allocate into the cache.
>=20
> Avoid any potential inconsistencies between test and measurement by
> removing code for unsupported "write" operations to the buffer.
> Ignore any attempt from user space to enable this unsupported test
> configuration, instead always use read operations.
>=20
> Keep the initialization of the, now unused, "fill_buf" parameters
> to reserve these parameter positions since it has been exposed as an API.
> Future parameter additions cannot use these parameter positions.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
> Changes since V2:
> - Update changelog to justify keeping the assignment to benchmark_cmd[4].
>   (Ilpo)
>=20
> Changes since V1:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/fill_buf.c    | 28 ++-----------------
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
>  .../testing/selftests/resctrl/resctrl_tests.c |  5 +++-
>  tools/testing/selftests/resctrl/resctrl_val.c |  5 ++--
>  4 files changed, 9 insertions(+), 31 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/s=
elftests/resctrl/fill_buf.c
> index 854f0108d8e6..e4f1cea317f1 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -88,18 +88,6 @@ static int fill_one_span_read(unsigned char *buf, size=
_t buf_size)
>  =09return sum;
>  }
> =20
> -static void fill_one_span_write(unsigned char *buf, size_t buf_size)
> -{
> -=09unsigned char *end_ptr =3D buf + buf_size;
> -=09unsigned char *p;
> -
> -=09p =3D buf;
> -=09while (p < end_ptr) {
> -=09=09*p =3D '1';
> -=09=09p +=3D (CL_SIZE / 2);
> -=09}
> -}
> -
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
>  {
>  =09int ret =3D 0;
> @@ -114,15 +102,6 @@ void fill_cache_read(unsigned char *buf, size_t buf_=
size, bool once)
>  =09*value_sink =3D ret;
>  }
> =20
> -static void fill_cache_write(unsigned char *buf, size_t buf_size, bool o=
nce)
> -{
> -=09while (1) {
> -=09=09fill_one_span_write(buf, buf_size);
> -=09=09if (once)
> -=09=09=09break;
> -=09}
> -}
> -
>  unsigned char *alloc_buffer(size_t buf_size, int memflush)
>  {
>  =09void *buf =3D NULL;
> @@ -151,7 +130,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memf=
lush)
>  =09return buf;
>  }
> =20
> -int run_fill_buf(size_t buf_size, int memflush, int op)
> +int run_fill_buf(size_t buf_size, int memflush)
>  {
>  =09unsigned char *buf;
> =20
> @@ -159,10 +138,7 @@ int run_fill_buf(size_t buf_size, int memflush, int =
op)
>  =09if (!buf)
>  =09=09return -1;
> =20
> -=09if (op =3D=3D 0)
> -=09=09fill_cache_read(buf, buf_size, false);
> -=09else
> -=09=09fill_cache_write(buf, buf_size, false);
> +=09fill_cache_read(buf, buf_size, false);
> =20
>  =09free(buf);
> =20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index 51f5f4b25e06..ba1ce1b35699 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event,=
 pid_t pid, int cpu,
>  unsigned char *alloc_buffer(size_t buf_size, int memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> -int run_fill_buf(size_t buf_size, int memflush, int op);
> +int run_fill_buf(size_t buf_size, int memflush);
>  int initialize_mem_bw_imc(void);
>  int measure_mem_bw(const struct user_params *uparams,
>  =09=09   struct resctrl_val_param *param, pid_t bm_pid,
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/test=
ing/selftests/resctrl/resctrl_tests.c
> index e7878077883f..0f91c475b255 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -265,13 +265,16 @@ int main(int argc, char **argv)
>  =09=09=09ksft_exit_fail_msg("Out of memory!\n");
>  =09=09uparams.benchmark_cmd[1] =3D span_str;
>  =09=09uparams.benchmark_cmd[2] =3D "1";
> -=09=09uparams.benchmark_cmd[3] =3D "0";
>  =09=09/*
> +=09=09 * Third parameter was previously used for "operation"
> +=09=09 * (read/write) of which only (now default) "read"/"0"
> +=09=09 * works.
>  =09=09 * Fourth parameter was previously used to indicate
>  =09=09 * how long "fill_buf" should run for, with "false"
>  =09=09 * ("fill_buf" will keep running until terminated)
>  =09=09 * the only option that works.
>  =09=09 */
> +=09=09uparams.benchmark_cmd[3] =3D NULL;
>  =09=09uparams.benchmark_cmd[4] =3D NULL;
>  =09}
> =20
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index b0f3c594c4da..113ca18d67c1 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -622,8 +622,8 @@ int measure_mem_bw(const struct user_params *uparams,
>   */
>  static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  {
> -=09int operation, ret, memflush;
>  =09char **benchmark_cmd;
> +=09int ret, memflush;
>  =09size_t span;
>  =09FILE *fp;
> =20
> @@ -643,9 +643,8 @@ static void run_benchmark(int signum, siginfo_t *info=
, void *ucontext)
>  =09=09/* Execute default fill_buf benchmark */
>  =09=09span =3D strtoul(benchmark_cmd[1], NULL, 10);
>  =09=09memflush =3D  atoi(benchmark_cmd[2]);
> -=09=09operation =3D atoi(benchmark_cmd[3]);
> =20
> -=09=09if (run_fill_buf(span, memflush, operation))
> +=09=09if (run_fill_buf(span, memflush))
>  =09=09=09fprintf(stderr, "Error in running fill buffer\n");
>  =09} else {
>  =09=09/* Execute specified benchmark */
>=20
--8323328-1834914115-1729241735=:1141--

