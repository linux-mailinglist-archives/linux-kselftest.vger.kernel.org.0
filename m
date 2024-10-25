Return-Path: <linux-kselftest+bounces-20668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4CF9B048F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020A71F240C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765AC13A879;
	Fri, 25 Oct 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4DSG+Od"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA981632E2;
	Fri, 25 Oct 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864353; cv=none; b=hC21TwQ5bPiiKzUADmf77F6YPe08T551gWCTNoSCFrxfk0bxDQt1cFhCNN7yPqHEluBRz3UNFEEHYb4gAyF5NuyvhHjzwYx/+NOPqGQGWWWP/sdcoJ3flSmkvYy/P38ndY7kVP+DBqChvLB8rTs14DR7p3P8Pz0whaUpRUP+mtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864353; c=relaxed/simple;
	bh=AIyr9PWCcooiqaAOo4LnEnqsxWXQm7V0ObfQ7J6ahCo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XRN1PFGyT7kcERiOmNdtXumulAl+a2CxRVy9xJlsyYmLMVLfwIIOBAmPxsPU3lfPAPNt/xlHnjOeFpoMBtcbP0dp2zRrG8pSjkGUamnzVyMfMeG7KtLlWmDyoPaopen6fhy+x1j/CnhYwASqkFiv90AvjgWCzkQzDx3cRrqaTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4DSG+Od; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864350; x=1761400350;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AIyr9PWCcooiqaAOo4LnEnqsxWXQm7V0ObfQ7J6ahCo=;
  b=H4DSG+Ods/SHHxnwY1p4eYhA6VKX19ZMVwSSHBceViScPGGPGstgqinc
   UammtgMfYWNv4oyFs8Ob1VeuI8pSPWOdEyss/eJHgXIjCmMHKh35gQHuf
   PebgnWVXVJro5abMjYqqpocBuYabkfhcQbjWFzuqQl1Nk6+l0S14DjlFG
   eSn7Db1mfP30yY2IG7qtVFa2qH1YZo69mxzo73BoPSFTLi8RvV25rjSKV
   YZ6qLHtrEk7GtfaGVsmMnN9F2UFRUlaxfTw1NGWP+tZIirbTwz/9NHUix
   ZRcgc2bZLHNqsZpYwvW3w7GU93pAMarmU3mS9wozPQuNJrfGZSUMXyI1K
   w==;
X-CSE-ConnectionGUID: gvqE7wCaSRirsW1wz8KIfA==
X-CSE-MsgGUID: /x6HRFk8QfyslFuYPLbW7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46997697"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46997697"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:52:29 -0700
X-CSE-ConnectionGUID: eyNKS2VjTYuS7TVmEQa22g==
X-CSE-MsgGUID: ppYXuU7zSByi2n+ifvg7KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85498298"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:52:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 16:52:23 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 10/15] selftests/resctrl: Make benchmark parameter
 passing robust
In-Reply-To: <5dd880128db5d49ebbf606763c46dc3d707c3c87.1729804024.git.reinette.chatre@intel.com>
Message-ID: <4ab44bdd-b3e8-b574-2add-1273d6ab4eae@linux.intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com> <5dd880128db5d49ebbf606763c46dc3d707c3c87.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1978624571-1729864343=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1978624571-1729864343=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2024, Reinette Chatre wrote:

> The benchmark used during the CMT, MBM, and MBA tests can be provided by
> the user via (-b) parameter, if not provided the default "fill_buf"
> benchmark is used. The user is additionally able to override
> any of the "fill_buf" default parameters when running the tests with
> "-b fill_buf <fill_buf parameters>".
>=20
> The "fill_buf" parameters are managed as an array of strings. Using an
> array of strings is complex because it requires transformations to/from
> strings at every producer and consumer. This is made worse for the
> individual tests where the default benchmark parameters values may not
> be appropriate and additional data wrangling is required. For example,
> the CMT test duplicates the entire array of strings in order to replace
> one of the parameters.
>=20
> More issues appear when combining the usage of an array of strings with
> the use case of user overriding default parameters by specifying
> "-b fill_buf <parameters>". This use case is fragile with opportunities
> to trigger a SIGSEGV because of opportunities for NULL pointers to exist
> in the array of strings. For example, by running below (thus by specifyin=
g
> "fill_buf" should be used but all parameters are NULL):
> =09$ sudo resctrl_tests -t mbm -b fill_buf
>=20
> Replace the "array of strings" parameters used for "fill_buf" with
> new struct fill_buf_param that contains the "fill_buf" parameters that
> can be used directly without transformations to/from strings. Two
> instances of struct fill_buf_param may exist at any point in time:
> =09* If the user provides new parameters to "fill_buf", the
> =09  user parameter structure (struct user_params) will point to a
> =09  fully initialized and immutable struct fill_buf_param
> =09  containing the user provided parameters.
> =09* If "fill_buf" is the benchmark that should be used by a test,
> =09  then the test parameter structure (struct resctrl_val_param)
> =09  will point to a fully initialized struct fill_buf_param. The
> =09  latter may contain (a) the user provided parameters verbatim,
> =09  (b) user provided parameters adjusted to be appropriate for
> =09  the test, or (c) the default parameters for "fill_buf" that
> =09  is appropriate for the test if the user did not provide
> =09  "fill_buf" parameters nor an alternate benchmark.
>=20
> The existing behavior of CMT test is to use test defined value for the
> buffer size even if the user provides another value via command line.
> This behavior is maintained since the test requires that the buffer size
> matches the size of the cache allocated, and the amount of cache
> allocated can instead be changed by the user with the "-n" command line
> parameter.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks for the update.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> Changes since V3:
> - Handle empty string input. (Ilpo)
>=20
> Changes since V2:
> - Use empty initializers. (Ilpo)
> - Let memflush be bool instead of int. (Ilpo)
> - Make user input checks more robust. (Ilpo)
> - Assign values as part of local variable definition. (Ilpo)
>=20
> Changes since V1:
> - Maintain original behavior where user can override "fill_buf"
>   parameters via command line ... but only those that can actually
>   be changed. (Ilpo)
> - Fix parsing issues associated with original behavior to ensure
>   any parameter is valid before any attempt to use it.
> - Move patch earlier in series to highlight that this fixes existing
>   issues.
> - Make struct fill_buf_param dynamic to support user provided
>   parameters as well as test specific parameters.
> - Rewrite changelog.
> ---
>  tools/testing/selftests/resctrl/cmt_test.c    |  32 ++----
>  tools/testing/selftests/resctrl/fill_buf.c    |   4 +-
>  tools/testing/selftests/resctrl/mba_test.c    |  13 ++-
>  tools/testing/selftests/resctrl/mbm_test.c    |  22 ++--
>  tools/testing/selftests/resctrl/resctrl.h     |  59 +++++++---
>  .../testing/selftests/resctrl/resctrl_tests.c | 103 ++++++++++++++----
>  tools/testing/selftests/resctrl/resctrl_val.c |  41 ++++---
>  7 files changed, 178 insertions(+), 96 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/s=
elftests/resctrl/cmt_test.c
> index 0c045080d808..4c3cf2c25a38 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -116,15 +116,13 @@ static void cmt_test_cleanup(void)
> =20
>  static int cmt_run_test(const struct resctrl_test *test, const struct us=
er_params *uparams)
>  {
> -=09const char * const *cmd =3D uparams->benchmark_cmd;
> -=09const char *new_cmd[BENCHMARK_ARGS];
> +=09struct fill_buf_param fill_buf =3D {};
>  =09unsigned long cache_total_size =3D 0;
>  =09int n =3D uparams->bits ? : 5;
>  =09unsigned long long_mask;
> -=09char *span_str =3D NULL;
>  =09int count_of_bits;
>  =09size_t span;
> -=09int ret, i;
> +=09int ret;
> =20
>  =09ret =3D get_full_cbm("L3", &long_mask);
>  =09if (ret)
> @@ -155,32 +153,26 @@ static int cmt_run_test(const struct resctrl_test *=
test, const struct user_param
> =20
>  =09span =3D cache_portion_size(cache_total_size, param.mask, long_mask);
> =20
> -=09if (strcmp(cmd[0], "fill_buf") =3D=3D 0) {
> -=09=09/* Duplicate the command to be able to replace span in it */
> -=09=09for (i =3D 0; uparams->benchmark_cmd[i]; i++)
> -=09=09=09new_cmd[i] =3D uparams->benchmark_cmd[i];
> -=09=09new_cmd[i] =3D NULL;
> -
> -=09=09ret =3D asprintf(&span_str, "%zu", span);
> -=09=09if (ret < 0)
> -=09=09=09return -1;
> -=09=09new_cmd[1] =3D span_str;
> -=09=09cmd =3D new_cmd;
> +=09if (uparams->fill_buf) {
> +=09=09fill_buf.buf_size =3D span;
> +=09=09fill_buf.memflush =3D uparams->fill_buf->memflush;
> +=09=09param.fill_buf =3D &fill_buf;
> +=09} else if (!uparams->benchmark_cmd[0]) {
> +=09=09fill_buf.buf_size =3D span;
> +=09=09fill_buf.memflush =3D true;
> +=09=09param.fill_buf =3D &fill_buf;
>  =09}
> =20
>  =09remove(RESULT_FILE_NAME);
> =20
> -=09ret =3D resctrl_val(test, uparams, cmd, &param);
> +=09ret =3D resctrl_val(test, uparams, &param);
>  =09if (ret)
> -=09=09goto out;
> +=09=09return ret;
> =20
>  =09ret =3D check_results(&param, span, n);
>  =09if (ret && (get_vendor() =3D=3D ARCH_INTEL))
>  =09=09ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clusteri=
ng is enabled. Check BIOS configuration.\n");
> =20
> -out:
> -=09free(span_str);
> -
>  =09return ret;
>  }
> =20
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/s=
elftests/resctrl/fill_buf.c
> index e4f1cea317f1..39545f9369e8 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -102,7 +102,7 @@ void fill_cache_read(unsigned char *buf, size_t buf_s=
ize, bool once)
>  =09*value_sink =3D ret;
>  }
> =20
> -unsigned char *alloc_buffer(size_t buf_size, int memflush)
> +unsigned char *alloc_buffer(size_t buf_size, bool memflush)
>  {
>  =09void *buf =3D NULL;
>  =09uint64_t *p64;
> @@ -130,7 +130,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memf=
lush)
>  =09return buf;
>  }
> =20
> -int run_fill_buf(size_t buf_size, int memflush)
> +int run_fill_buf(size_t buf_size, bool memflush)
>  {
>  =09unsigned char *buf;
> =20
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index be0ead73e55d..74d95c460bd0 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -172,11 +172,22 @@ static int mba_run_test(const struct resctrl_test *=
test, const struct user_param
>  =09=09.setup=09=09=3D mba_setup,
>  =09=09.measure=09=3D mba_measure,
>  =09};
> +=09struct fill_buf_param fill_buf =3D {};
>  =09int ret;
> =20
>  =09remove(RESULT_FILE_NAME);
> =20
> -=09ret =3D resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
> +=09if (uparams->fill_buf) {
> +=09=09fill_buf.buf_size =3D uparams->fill_buf->buf_size;
> +=09=09fill_buf.memflush =3D uparams->fill_buf->memflush;
> +=09=09param.fill_buf =3D &fill_buf;
> +=09} else if (!uparams->benchmark_cmd[0]) {
> +=09=09fill_buf.buf_size =3D DEFAULT_SPAN;
> +=09=09fill_buf.memflush =3D true;
> +=09=09param.fill_buf =3D &fill_buf;
> +=09}
> +
> +=09ret =3D resctrl_val(test, uparams, &param);
>  =09if (ret)
>  =09=09return ret;
> =20
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/s=
elftests/resctrl/mbm_test.c
> index defa94293915..72261413c868 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -139,26 +139,26 @@ static int mbm_run_test(const struct resctrl_test *=
test, const struct user_param
>  =09=09.setup=09=09=3D mbm_setup,
>  =09=09.measure=09=3D mbm_measure,
>  =09};
> -=09char *endptr =3D NULL;
> -=09size_t span =3D 0;
> +=09struct fill_buf_param fill_buf =3D {};
>  =09int ret;
> =20
>  =09remove(RESULT_FILE_NAME);
> =20
> -=09if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "f=
ill_buf") =3D=3D 0) {
> -=09=09if (uparams->benchmark_cmd[1] && *uparams->benchmark_cmd[1] !=3D '=
\0') {
> -=09=09=09errno =3D 0;
> -=09=09=09span =3D strtoul(uparams->benchmark_cmd[1], &endptr, 10);
> -=09=09=09if (errno || *endptr !=3D '\0')
> -=09=09=09=09return -EINVAL;
> -=09=09}
> +=09if (uparams->fill_buf) {
> +=09=09fill_buf.buf_size =3D uparams->fill_buf->buf_size;
> +=09=09fill_buf.memflush =3D uparams->fill_buf->memflush;
> +=09=09param.fill_buf =3D &fill_buf;
> +=09} else if (!uparams->benchmark_cmd[0]) {
> +=09=09fill_buf.buf_size =3D DEFAULT_SPAN;
> +=09=09fill_buf.memflush =3D true;
> +=09=09param.fill_buf =3D &fill_buf;
>  =09}
> =20
> -=09ret =3D resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
> +=09ret =3D resctrl_val(test, uparams, &param);
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09ret =3D check_results(span);
> +=09ret =3D check_results(param.fill_buf ? param.fill_buf->buf_size : 0);
>  =09if (ret && (get_vendor() =3D=3D ARCH_INTEL))
>  =09=09ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clusteri=
ng is enabled. Check BIOS configuration.\n");
> =20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index 82801245e4c1..c9336f9c2cae 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -43,16 +43,36 @@
> =20
>  #define DEFAULT_SPAN=09=09(250 * MB)
> =20
> +/*
> + * fill_buf_param:=09"fill_buf" benchmark parameters
> + * @buf_size:=09=09Size (in bytes) of buffer used in benchmark.
> + *=09=09=09"fill_buf" allocates and initializes buffer of
> + *=09=09=09@buf_size. User can change value via command line.
> + * @memflush:=09=09If false the buffer will not be flushed after
> + *=09=09=09allocation and initialization, otherwise the
> + *=09=09=09buffer will be flushed. User can change value via
> + *=09=09=09command line (via integers with 0 interpreted as
> + *=09=09=09false and anything else as true).
> + */
> +struct fill_buf_param {
> +=09size_t=09=09buf_size;
> +=09bool=09=09memflush;
> +};
> +
>  /*
>   * user_params:=09=09User supplied parameters
>   * @cpu:=09=09CPU number to which the benchmark will be bound to
>   * @bits:=09=09Number of bits used for cache allocation size
>   * @benchmark_cmd:=09Benchmark command to run during (some of the) tests
> + * @fill_buf:=09=09Pointer to user provided parameters for "fill_buf",
> + *=09=09=09NULL if user did not provide parameters and test
> + *=09=09=09specific defaults should be used.
>   */
>  struct user_params {
>  =09int cpu;
>  =09int bits;
>  =09const char *benchmark_cmd[BENCHMARK_ARGS];
> +=09const struct fill_buf_param *fill_buf;
>  };
> =20
>  /*
> @@ -87,21 +107,29 @@ struct resctrl_test {
>   * @init:=09=09Callback function to initialize test environment
>   * @setup:=09=09Callback function to setup per test run environment
>   * @measure:=09=09Callback that performs the measurement (a single test)
> + * @fill_buf:=09=09Parameters for default "fill_buf" benchmark.
> + *=09=09=09Initialized with user provided parameters, possibly
> + *=09=09=09adapted to be relevant to the test. If user does
> + *=09=09=09not provide parameters for "fill_buf" nor a
> + *=09=09=09replacement benchmark then initialized with defaults
> + *=09=09=09appropriate for test. NULL if user provided
> + *=09=09=09benchmark.
>   */
>  struct resctrl_val_param {
> -=09const char=09*ctrlgrp;
> -=09const char=09*mongrp;
> -=09char=09=09filename[64];
> -=09unsigned long=09mask;
> -=09int=09=09num_of_runs;
> -=09int=09=09(*init)(const struct resctrl_val_param *param,
> -=09=09=09=09int domain_id);
> -=09int=09=09(*setup)(const struct resctrl_test *test,
> -=09=09=09=09 const struct user_params *uparams,
> -=09=09=09=09 struct resctrl_val_param *param);
> -=09int=09=09(*measure)(const struct user_params *uparams,
> -=09=09=09=09   struct resctrl_val_param *param,
> -=09=09=09=09   pid_t bm_pid);
> +=09const char=09=09*ctrlgrp;
> +=09const char=09=09*mongrp;
> +=09char=09=09=09filename[64];
> +=09unsigned long=09=09mask;
> +=09int=09=09=09num_of_runs;
> +=09int=09=09=09(*init)(const struct resctrl_val_param *param,
> +=09=09=09=09=09int domain_id);
> +=09int=09=09=09(*setup)(const struct resctrl_test *test,
> +=09=09=09=09=09 const struct user_params *uparams,
> +=09=09=09=09=09 struct resctrl_val_param *param);
> +=09int=09=09=09(*measure)(const struct user_params *uparams,
> +=09=09=09=09=09   struct resctrl_val_param *param,
> +=09=09=09=09=09   pid_t bm_pid);
> +=09struct fill_buf_param=09*fill_buf;
>  };
> =20
>  struct perf_event_read {
> @@ -138,10 +166,10 @@ int write_schemata(const char *ctrlgrp, char *schem=
ata, int cpu_no,
>  int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const cha=
r *mongrp);
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu=
,
>  =09=09    int group_fd, unsigned long flags);
> -unsigned char *alloc_buffer(size_t buf_size, int memflush);
> +unsigned char *alloc_buffer(size_t buf_size, bool memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> -int run_fill_buf(size_t buf_size, int memflush);
> +int run_fill_buf(size_t buf_size, bool memflush);
>  int initialize_read_mem_bw_imc(void);
>  int measure_read_mem_bw(const struct user_params *uparams,
>  =09=09=09struct resctrl_val_param *param, pid_t bm_pid);
> @@ -149,7 +177,6 @@ void initialize_mem_bw_resctrl(const struct resctrl_v=
al_param *param,
>  =09=09=09       int domain_id);
>  int resctrl_val(const struct resctrl_test *test,
>  =09=09const struct user_params *uparams,
> -=09=09const char * const *benchmark_cmd,
>  =09=09struct resctrl_val_param *param);
>  unsigned long create_bit_mask(unsigned int start, unsigned int len);
>  unsigned int count_contiguous_bits(unsigned long val, unsigned int *star=
t);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/test=
ing/selftests/resctrl/resctrl_tests.c
> index 0f91c475b255..24daf76b4039 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -148,6 +148,78 @@ static void run_single_test(const struct resctrl_tes=
t *test, const struct user_p
>  =09test_cleanup(test);
>  }
> =20
> +/*
> + * Allocate and initialize a struct fill_buf_param with user provided
> + * (via "-b fill_buf <fill_buf parameters>") parameters.
> + *
> + * Use defaults (that may not be appropriate for all tests) for any
> + * fill_buf parameters omitted by the user.
> + *
> + * Historically it may have been possible for user space to provide
> + * additional parameters, "operation" ("read" vs "write") in
> + * benchmark_cmd[3] and "once" (run "once" or until terminated) in
> + * benchmark_cmd[4]. Changing these parameters have never been
> + * supported with the default of "read" operation and running until
> + * terminated built into the tests. Any unsupported values for
> + * (original) "fill_buf" parameters are treated as failure.
> + *
> + * Return: On failure, forcibly exits the test on any parsing failure,
> + *         returns NULL if no parsing needed (user did not actually prov=
ide
> + *         "-b fill_buf").
> + *         On success, returns pointer to newly allocated and fully
> + *         initialized struct fill_buf_param that caller must free.
> + */
> +static struct fill_buf_param *alloc_fill_buf_param(struct user_params *u=
params)
> +{
> +=09struct fill_buf_param *fill_param =3D NULL;
> +=09char *endptr =3D NULL;
> +
> +=09if (!uparams->benchmark_cmd[0] || strcmp(uparams->benchmark_cmd[0], "=
fill_buf"))
> +=09=09return NULL;
> +
> +=09fill_param =3D malloc(sizeof(*fill_param));
> +=09if (!fill_param)
> +=09=09ksft_exit_skip("Unable to allocate memory for fill_buf parameters.=
\n");
> +
> +=09if (uparams->benchmark_cmd[1] && *uparams->benchmark_cmd[1] !=3D '\0'=
) {
> +=09=09errno =3D 0;
> +=09=09fill_param->buf_size =3D strtoul(uparams->benchmark_cmd[1], &endpt=
r, 10);
> +=09=09if (errno || *endptr !=3D '\0') {
> +=09=09=09free(fill_param);
> +=09=09=09ksft_exit_skip("Unable to parse benchmark buffer size.\n");
> +=09=09}
> +=09} else {
> +=09=09fill_param->buf_size =3D DEFAULT_SPAN;
> +=09}
> +
> +=09if (uparams->benchmark_cmd[2] && *uparams->benchmark_cmd[2] !=3D '\0'=
) {
> +=09=09errno =3D 0;
> +=09=09fill_param->memflush =3D strtol(uparams->benchmark_cmd[2], &endptr=
, 10) !=3D 0;
> +=09=09if (errno || *endptr !=3D '\0') {
> +=09=09=09free(fill_param);
> +=09=09=09ksft_exit_skip("Unable to parse benchmark memflush parameter.\n=
");
> +=09=09}
> +=09} else {
> +=09=09fill_param->memflush =3D true;
> +=09}
> +
> +=09if (uparams->benchmark_cmd[3] && *uparams->benchmark_cmd[3] !=3D '\0'=
) {
> +=09=09if (strcmp(uparams->benchmark_cmd[3], "0")) {
> +=09=09=09free(fill_param);
> +=09=09=09ksft_exit_skip("Only read operations supported.\n");
> +=09=09}
> +=09}
> +
> +=09if (uparams->benchmark_cmd[4] && *uparams->benchmark_cmd[4] !=3D '\0'=
) {
> +=09=09if (strcmp(uparams->benchmark_cmd[4], "false")) {
> +=09=09=09free(fill_param);
> +=09=09=09ksft_exit_skip("fill_buf is required to run until termination.\=
n");
> +=09=09}
> +=09}
> +
> +=09return fill_param;
> +}
> +
>  static void init_user_params(struct user_params *uparams)
>  {
>  =09memset(uparams, 0, sizeof(*uparams));
> @@ -158,11 +230,11 @@ static void init_user_params(struct user_params *up=
arams)
> =20
>  int main(int argc, char **argv)
>  {
> +=09struct fill_buf_param *fill_param =3D NULL;
>  =09int tests =3D ARRAY_SIZE(resctrl_tests);
>  =09bool test_param_seen =3D false;
>  =09struct user_params uparams;
> -=09char *span_str =3D NULL;
> -=09int ret, c, i;
> +=09int c, i;
> =20
>  =09init_user_params(&uparams);
> =20
> @@ -239,6 +311,10 @@ int main(int argc, char **argv)
>  =09}
>  last_arg:
> =20
> +=09fill_param =3D alloc_fill_buf_param(&uparams);
> +=09if (fill_param)
> +=09=09uparams.fill_buf =3D fill_param;
> +
>  =09ksft_print_header();
> =20
>  =09/*
> @@ -257,32 +333,11 @@ int main(int argc, char **argv)
> =20
>  =09filter_dmesg();
> =20
> -=09if (!uparams.benchmark_cmd[0]) {
> -=09=09/* If no benchmark is given by "-b" argument, use fill_buf. */
> -=09=09uparams.benchmark_cmd[0] =3D "fill_buf";
> -=09=09ret =3D asprintf(&span_str, "%u", DEFAULT_SPAN);
> -=09=09if (ret < 0)
> -=09=09=09ksft_exit_fail_msg("Out of memory!\n");
> -=09=09uparams.benchmark_cmd[1] =3D span_str;
> -=09=09uparams.benchmark_cmd[2] =3D "1";
> -=09=09/*
> -=09=09 * Third parameter was previously used for "operation"
> -=09=09 * (read/write) of which only (now default) "read"/"0"
> -=09=09 * works.
> -=09=09 * Fourth parameter was previously used to indicate
> -=09=09 * how long "fill_buf" should run for, with "false"
> -=09=09 * ("fill_buf" will keep running until terminated)
> -=09=09 * the only option that works.
> -=09=09 */
> -=09=09uparams.benchmark_cmd[3] =3D NULL;
> -=09=09uparams.benchmark_cmd[4] =3D NULL;
> -=09}
> -
>  =09ksft_set_plan(tests);
> =20
>  =09for (i =3D 0; i < ARRAY_SIZE(resctrl_tests); i++)
>  =09=09run_single_test(resctrl_tests[i], &uparams);
> =20
> -=09free(span_str);
> +=09free(fill_param);
>  =09ksft_finished();
>  }
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index c4ebf70a46ef..00b3808d3bca 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -535,6 +535,11 @@ int measure_read_mem_bw(const struct user_params *up=
arams,
>  =09return ret;
>  }
> =20
> +struct benchmark_info {
> +=09const struct user_params *uparams;
> +=09struct resctrl_val_param *param;
> +};
> +
>  /*
>   * run_benchmark - Run a specified benchmark or fill_buf (default benchm=
ark)
>   *=09=09   in specified signal. Direct benchmark stdio to /dev/null.
> @@ -544,12 +549,11 @@ int measure_read_mem_bw(const struct user_params *u=
params,
>   */
>  static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  {
> -=09char **benchmark_cmd;
> -=09int ret, memflush;
> -=09size_t span;
> +=09struct benchmark_info *benchmark_info =3D info->si_ptr;
> +=09const struct user_params *uparams =3D benchmark_info->uparams;
> +=09struct resctrl_val_param *param =3D benchmark_info->param;
>  =09FILE *fp;
> -
> -=09benchmark_cmd =3D info->si_ptr;
> +=09int ret;
> =20
>  =09/*
>  =09 * Direct stdio of child to /dev/null, so that only parent writes to
> @@ -561,16 +565,13 @@ static void run_benchmark(int signum, siginfo_t *in=
fo, void *ucontext)
>  =09=09parent_exit(ppid);
>  =09}
> =20
> -=09if (strcmp(benchmark_cmd[0], "fill_buf") =3D=3D 0) {
> -=09=09/* Execute default fill_buf benchmark */
> -=09=09span =3D strtoul(benchmark_cmd[1], NULL, 10);
> -=09=09memflush =3D  atoi(benchmark_cmd[2]);
> -
> -=09=09if (run_fill_buf(span, memflush))
> +=09if (param->fill_buf) {
> +=09=09if (run_fill_buf(param->fill_buf->buf_size,
> +=09=09=09=09 param->fill_buf->memflush))
>  =09=09=09fprintf(stderr, "Error in running fill buffer\n");
> -=09} else {
> +=09} else if (uparams->benchmark_cmd[0]) {
>  =09=09/* Execute specified benchmark */
> -=09=09ret =3D execvp(benchmark_cmd[0], benchmark_cmd);
> +=09=09ret =3D execvp(uparams->benchmark_cmd[0], (char **)uparams->benchm=
ark_cmd);
>  =09=09if (ret)
>  =09=09=09ksft_perror("execvp");
>  =09}
> @@ -585,16 +586,15 @@ static void run_benchmark(int signum, siginfo_t *in=
fo, void *ucontext)
>   *=09=09=09the benchmark
>   * @test:=09=09test information structure
>   * @uparams:=09=09user supplied parameters
> - * @benchmark_cmd:=09benchmark command and its arguments
>   * @param:=09=09parameters passed to resctrl_val()
>   *
>   * Return:=09=090 when the test was run, < 0 on error.
>   */
>  int resctrl_val(const struct resctrl_test *test,
>  =09=09const struct user_params *uparams,
> -=09=09const char * const *benchmark_cmd,
>  =09=09struct resctrl_val_param *param)
>  {
> +=09struct benchmark_info benchmark_info;
>  =09struct sigaction sigact;
>  =09int ret =3D 0, pipefd[2];
>  =09char pipe_message =3D 0;
> @@ -610,6 +610,9 @@ int resctrl_val(const struct resctrl_test *test,
>  =09=09return ret;
>  =09}
> =20
> +=09benchmark_info.uparams =3D uparams;
> +=09benchmark_info.param =3D param;
> +
>  =09/*
>  =09 * If benchmark wasn't successfully started by child, then child shou=
ld
>  =09 * kill parent, so save parent's pid
> @@ -671,13 +674,7 @@ int resctrl_val(const struct resctrl_test *test,
> =20
>  =09ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
> =20
> -=09/*
> -=09 * The cast removes constness but nothing mutates benchmark_cmd withi=
n
> -=09 * the context of this process. At the receiving process, it becomes
> -=09 * argv, which is mutable, on exec() but that's after fork() so it
> -=09 * doesn't matter for the process running the tests.
> -=09 */
> -=09value.sival_ptr =3D (void *)benchmark_cmd;
> +=09value.sival_ptr =3D (void *)&benchmark_info;
> =20
>  =09/* Taskset benchmark to specified cpu */
>  =09ret =3D taskset_benchmark(bm_pid, uparams->cpu, NULL);
>=20
--8323328-1978624571-1729864343=:946--

