Return-Path: <linux-kselftest+bounces-18650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB998A681
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 16:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8AB284A84
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD4190684;
	Mon, 30 Sep 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzNMkE/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457B419066C;
	Mon, 30 Sep 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704760; cv=none; b=IoDLpausKJGUZgsDs0CgfJ1Kh3o2tbZOp2NYRBJnm8fGuh0iVZPrT7qeOBvCumgKT8fv2tWc/E/xXx95UUwDOHfMwMEbtpDDaBOb8tCbTvdBfRal95sniCKjLyEQd4cd+YXBFTQ8YXtZyybAmVQ+T7KWHUctzrpK8G8DYzEQ47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704760; c=relaxed/simple;
	bh=BWC64kjYEf6R0c6Ln4PGamt8Nyx/opIWtigyOC8jCEU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=axp0Lzz2iLbQ4UZfqveKpcPgTFsEmx7XkVcSWzYxMvUsDPRhRI8JRhPApN+0rscERu8P9J7bmyjDxkoohgBdBpzghMVF9Zej47tsAGj4g2lXISDfONQIKobZV4Mfx3sJ8EX63yUNIzZNS1HFcL9rNF9Mwq3a97cJvtyRNdCa2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzNMkE/T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727704758; x=1759240758;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BWC64kjYEf6R0c6Ln4PGamt8Nyx/opIWtigyOC8jCEU=;
  b=nzNMkE/TdWQx6HOFr+qp9MMcp55X73Pn4M6QAy1fpCoZZ26PQ5XgN05S
   vMbVmNV8PWwiF8knXhDlpG1j4U/L8UWcUP8boEJd2+4bxvTelpkXG9pXw
   9yrcZVo0Fd8xNBxLSlgmFvOwbEZ8qvjl7By7XNJ9PO4iM+/1lWNxvgTxX
   DqVHpDEmhDCkhILtZWNlyveoPnCR6C+CcIldWcq6Wtqy3U6rHniH2hCgd
   EiMAESfzz8lWf9a+wJ1IKaaKa+haf2Id6xmXAG8+m6aQnRKtSQ0Xze0a+
   aGy85pQSswyLgylTNDRGKklVq+xlG6jVJpK+GIW+jWzzIz+azKk0MwOvJ
   w==;
X-CSE-ConnectionGUID: jIzPov0JRHy47lXbNRiOtw==
X-CSE-MsgGUID: UVKl6D+GSUCqG5VYz7W6vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26969353"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26969353"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:59:17 -0700
X-CSE-ConnectionGUID: LXxQ8iuGTwStxfHXqEopMA==
X-CSE-MsgGUID: EaZjteKFRzypGeGSI2cyiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104114371"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:59:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Sep 2024 16:59:10 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 08/13] selftests/resctrl: Remove unused measurement
 code
In-Reply-To: <a6ef99e70387dcc3ff67cda0548da250e4920e40.1726164080.git.reinette.chatre@intel.com>
Message-ID: <5fa3b9e8-66d4-56f6-15c1-4c71bb68652c@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <a6ef99e70387dcc3ff67cda0548da250e4920e40.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2086223514-1727704750=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2086223514-1727704750=:938
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> The MBM and MBA resctrl selftests run a benchmark during which
> it takes measurements of read memory bandwidth via perf.
> Code exists to support measurements of write memory bandwidth
> but there exists no path with which this code can execute.
>=20
> While code exists for write memory bandwidth measurement
> there has not yet been a use case for it. Remove this unused code.
> Rename relevant functions to include "read" so that it is clear
> that it relates only to memory bandwidth reads, while renaming
> the functions also add consistency by changing the "membw"
> instances to more prevalent "mem_bw".
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

I'll take a look at the rest of the series later.

--=20
 i.

> ---
> Changes since V1:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/mba_test.c    |   4 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |   4 +-
>  tools/testing/selftests/resctrl/resctrl.h     |   8 +-
>  tools/testing/selftests/resctrl/resctrl_val.c | 234 ++++++------------
>  tools/testing/selftests/resctrl/resctrlfs.c   |  17 --
>  5 files changed, 85 insertions(+), 182 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index da40a8ed4413..be0ead73e55d 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -21,7 +21,7 @@ static int mba_init(const struct resctrl_val_param *par=
am, int domain_id)
>  {
>  =09int ret;
> =20
> -=09ret =3D initialize_mem_bw_imc();
> +=09ret =3D initialize_read_mem_bw_imc();
>  =09if (ret)
>  =09=09return ret;
> =20
> @@ -68,7 +68,7 @@ static int mba_setup(const struct resctrl_test *test,
>  static int mba_measure(const struct user_params *uparams,
>  =09=09       struct resctrl_val_param *param, pid_t bm_pid)
>  {
> -=09return measure_mem_bw(uparams, param, bm_pid, "reads");
> +=09return measure_read_mem_bw(uparams, param, bm_pid);
>  }
> =20
>  static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/s=
elftests/resctrl/mbm_test.c
> index 80c7a1bc13b8..9744bf1ac16f 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -91,7 +91,7 @@ static int mbm_init(const struct resctrl_val_param *par=
am, int domain_id)
>  {
>  =09int ret;
> =20
> -=09ret =3D initialize_mem_bw_imc();
> +=09ret =3D initialize_read_mem_bw_imc();
>  =09if (ret)
>  =09=09return ret;
> =20
> @@ -122,7 +122,7 @@ static int mbm_setup(const struct resctrl_test *test,
>  static int mbm_measure(const struct user_params *uparams,
>  =09=09       struct resctrl_val_param *param, pid_t bm_pid)
>  {
> -=09return measure_mem_bw(uparams, param, bm_pid, "reads");
> +=09return measure_read_mem_bw(uparams, param, bm_pid);
>  }
> =20
>  static void mbm_test_cleanup(void)
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index ba1ce1b35699..82801245e4c1 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -126,7 +126,6 @@ int filter_dmesg(void);
>  int get_domain_id(const char *resource, int cpu_no, int *domain_id);
>  int mount_resctrlfs(void);
>  int umount_resctrlfs(void);
> -const char *get_bw_report_type(const char *bw_report);
>  bool resctrl_resource_exists(const char *resource);
>  bool resctrl_mon_feature_exists(const char *resource, const char *featur=
e);
>  bool resource_info_file_exists(const char *resource, const char *file);
> @@ -143,10 +142,9 @@ unsigned char *alloc_buffer(size_t buf_size, int mem=
flush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
>  int run_fill_buf(size_t buf_size, int memflush);
> -int initialize_mem_bw_imc(void);
> -int measure_mem_bw(const struct user_params *uparams,
> -=09=09   struct resctrl_val_param *param, pid_t bm_pid,
> -=09=09   const char *bw_report);
> +int initialize_read_mem_bw_imc(void);
> +int measure_read_mem_bw(const struct user_params *uparams,
> +=09=09=09struct resctrl_val_param *param, pid_t bm_pid);
>  void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
>  =09=09=09       int domain_id);
>  int resctrl_val(const struct resctrl_test *test,
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index 8b5973c5e934..a1e097dc8e05 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -12,13 +12,10 @@
> =20
>  #define UNCORE_IMC=09=09"uncore_imc"
>  #define READ_FILE_NAME=09=09"events/cas_count_read"
> -#define WRITE_FILE_NAME=09=09"events/cas_count_write"
>  #define DYN_PMU_PATH=09=09"/sys/bus/event_source/devices"
>  #define SCALE=09=09=090.00006103515625
>  #define MAX_IMCS=09=0920
>  #define MAX_TOKENS=09=095
> -#define READ=09=09=090
> -#define WRITE=09=09=091
> =20
>  #define CON_MBM_LOCAL_BYTES_PATH=09=09\
>  =09"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
> @@ -41,44 +38,43 @@ struct imc_counter_config {
> =20
>  static char mbm_total_path[1024];
>  static int imcs;
> -static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
> +static struct imc_counter_config imc_counters_config[MAX_IMCS];
>  static const struct resctrl_test *current_test;
> =20
> -static void membw_initialize_perf_event_attr(int i, int j)
> +static void read_mem_bw_initialize_perf_event_attr(int i)
>  {
> -=09memset(&imc_counters_config[i][j].pe, 0,
> +=09memset(&imc_counters_config[i].pe, 0,
>  =09       sizeof(struct perf_event_attr));
> -=09imc_counters_config[i][j].pe.type =3D imc_counters_config[i][j].type;
> -=09imc_counters_config[i][j].pe.size =3D sizeof(struct perf_event_attr);
> -=09imc_counters_config[i][j].pe.disabled =3D 1;
> -=09imc_counters_config[i][j].pe.inherit =3D 1;
> -=09imc_counters_config[i][j].pe.exclude_guest =3D 0;
> -=09imc_counters_config[i][j].pe.config =3D
> -=09=09imc_counters_config[i][j].umask << 8 |
> -=09=09imc_counters_config[i][j].event;
> -=09imc_counters_config[i][j].pe.sample_type =3D PERF_SAMPLE_IDENTIFIER;
> -=09imc_counters_config[i][j].pe.read_format =3D
> +=09imc_counters_config[i].pe.type =3D imc_counters_config[i].type;
> +=09imc_counters_config[i].pe.size =3D sizeof(struct perf_event_attr);
> +=09imc_counters_config[i].pe.disabled =3D 1;
> +=09imc_counters_config[i].pe.inherit =3D 1;
> +=09imc_counters_config[i].pe.exclude_guest =3D 0;
> +=09imc_counters_config[i].pe.config =3D
> +=09=09imc_counters_config[i].umask << 8 |
> +=09=09imc_counters_config[i].event;
> +=09imc_counters_config[i].pe.sample_type =3D PERF_SAMPLE_IDENTIFIER;
> +=09imc_counters_config[i].pe.read_format =3D
>  =09=09PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
>  }
> =20
> -static void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
> +static void read_mem_bw_ioctl_perf_event_ioc_reset_enable(int i)
>  {
> -=09ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
> -=09ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
> +=09ioctl(imc_counters_config[i].fd, PERF_EVENT_IOC_RESET, 0);
> +=09ioctl(imc_counters_config[i].fd, PERF_EVENT_IOC_ENABLE, 0);
>  }
> =20
> -static void membw_ioctl_perf_event_ioc_disable(int i, int j)
> +static void read_mem_bw_ioctl_perf_event_ioc_disable(int i)
>  {
> -=09ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
> +=09ioctl(imc_counters_config[i].fd, PERF_EVENT_IOC_DISABLE, 0);
>  }
> =20
>  /*
> - * get_event_and_umask:=09Parse config into event and umask
> + * get_read_event_and_umask:=09Parse config into event and umask
>   * @cas_count_cfg:=09Config
>   * @count:=09=09iMC number
> - * @op:=09=09=09Operation (read/write)
>   */
> -static void get_event_and_umask(char *cas_count_cfg, int count, bool op)
> +static void get_read_event_and_umask(char *cas_count_cfg, int count)
>  {
>  =09char *token[MAX_TOKENS];
>  =09int i =3D 0;
> @@ -91,34 +87,22 @@ static void get_event_and_umask(char *cas_count_cfg, =
int count, bool op)
>  =09for (i =3D 0; i < MAX_TOKENS - 1; i++) {
>  =09=09if (!token[i])
>  =09=09=09break;
> -=09=09if (strcmp(token[i], "event") =3D=3D 0) {
> -=09=09=09if (op =3D=3D READ)
> -=09=09=09=09imc_counters_config[count][READ].event =3D
> -=09=09=09=09strtol(token[i + 1], NULL, 16);
> -=09=09=09else
> -=09=09=09=09imc_counters_config[count][WRITE].event =3D
> -=09=09=09=09strtol(token[i + 1], NULL, 16);
> -=09=09}
> -=09=09if (strcmp(token[i], "umask") =3D=3D 0) {
> -=09=09=09if (op =3D=3D READ)
> -=09=09=09=09imc_counters_config[count][READ].umask =3D
> -=09=09=09=09strtol(token[i + 1], NULL, 16);
> -=09=09=09else
> -=09=09=09=09imc_counters_config[count][WRITE].umask =3D
> -=09=09=09=09strtol(token[i + 1], NULL, 16);
> -=09=09}
> +=09=09if (strcmp(token[i], "event") =3D=3D 0)
> +=09=09=09imc_counters_config[count].event =3D strtol(token[i + 1], NULL,=
 16);
> +=09=09if (strcmp(token[i], "umask") =3D=3D 0)
> +=09=09=09imc_counters_config[count].umask =3D strtol(token[i + 1], NULL,=
 16);
>  =09}
>  }
> =20
> -static int open_perf_event(int i, int cpu_no, int j)
> +static int open_perf_read_event(int i, int cpu_no)
>  {
> -=09imc_counters_config[i][j].fd =3D
> -=09=09perf_event_open(&imc_counters_config[i][j].pe, -1, cpu_no, -1,
> +=09imc_counters_config[i].fd =3D
> +=09=09perf_event_open(&imc_counters_config[i].pe, -1, cpu_no, -1,
>  =09=09=09=09PERF_FLAG_FD_CLOEXEC);
> =20
> -=09if (imc_counters_config[i][j].fd =3D=3D -1) {
> +=09if (imc_counters_config[i].fd =3D=3D -1) {
>  =09=09fprintf(stderr, "Error opening leader %llx\n",
> -=09=09=09imc_counters_config[i][j].pe.config);
> +=09=09=09imc_counters_config[i].pe.config);
> =20
>  =09=09return -1;
>  =09}
> @@ -126,7 +110,7 @@ static int open_perf_event(int i, int cpu_no, int j)
>  =09return 0;
>  }
> =20
> -/* Get type and config (read and write) of an iMC counter */
> +/* Get type and config of an iMC counter's read event. */
>  static int read_from_imc_dir(char *imc_dir, int count)
>  {
>  =09char cas_count_cfg[1024], imc_counter_cfg[1024], imc_counter_type[102=
4];
> @@ -140,7 +124,7 @@ static int read_from_imc_dir(char *imc_dir, int count=
)
> =20
>  =09=09return -1;
>  =09}
> -=09if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <=3D 0) =
{
> +=09if (fscanf(fp, "%u", &imc_counters_config[count].type) <=3D 0) {
>  =09=09ksft_perror("Could not get iMC type");
>  =09=09fclose(fp);
> =20
> @@ -148,9 +132,6 @@ static int read_from_imc_dir(char *imc_dir, int count=
)
>  =09}
>  =09fclose(fp);
> =20
> -=09imc_counters_config[count][WRITE].type =3D
> -=09=09=09=09imc_counters_config[count][READ].type;
> -
>  =09/* Get read config */
>  =09sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
>  =09fp =3D fopen(imc_counter_cfg, "r");
> @@ -167,34 +148,19 @@ static int read_from_imc_dir(char *imc_dir, int cou=
nt)
>  =09}
>  =09fclose(fp);
> =20
> -=09get_event_and_umask(cas_count_cfg, count, READ);
> -
> -=09/* Get write config */
> -=09sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
> -=09fp =3D fopen(imc_counter_cfg, "r");
> -=09if (!fp) {
> -=09=09ksft_perror("Failed to open iMC config file");
> -
> -=09=09return -1;
> -=09}
> -=09if  (fscanf(fp, "%s", cas_count_cfg) <=3D 0) {
> -=09=09ksft_perror("Could not get iMC cas count write");
> -=09=09fclose(fp);
> -
> -=09=09return -1;
> -=09}
> -=09fclose(fp);
> -
> -=09get_event_and_umask(cas_count_cfg, count, WRITE);
> +=09get_read_event_and_umask(cas_count_cfg, count);
> =20
>  =09return 0;
>  }
> =20
>  /*
>   * A system can have 'n' number of iMC (Integrated Memory Controller)
> - * counters, get that 'n'. For each iMC counter get it's type and config=
=2E
> - * Also, each counter has two configs, one for read and the other for wr=
ite.
> - * A config again has two parts, event and umask.
> + * counters, get that 'n'. Discover the properties of the available
> + * counters in support of needed performance measurement via perf.
> + * For each iMC counter get it's type and config. Also obtain each
> + * counter's event and umask for the memory read events that will be
> + * measured.
> + *
>   * Enumerate all these details into an array of structures.
>   *
>   * Return: >=3D 0 on success. < 0 on failure.
> @@ -255,55 +221,46 @@ static int num_of_imcs(void)
>  =09return count;
>  }
> =20
> -int initialize_mem_bw_imc(void)
> +int initialize_read_mem_bw_imc(void)
>  {
> -=09int imc, j;
> +=09int imc;
> =20
>  =09imcs =3D num_of_imcs();
>  =09if (imcs <=3D 0)
>  =09=09return imcs;
> =20
>  =09/* Initialize perf_event_attr structures for all iMC's */
> -=09for (imc =3D 0; imc < imcs; imc++) {
> -=09=09for (j =3D 0; j < 2; j++)
> -=09=09=09membw_initialize_perf_event_attr(imc, j);
> -=09}
> +=09for (imc =3D 0; imc < imcs; imc++)
> +=09=09read_mem_bw_initialize_perf_event_attr(imc);
> =20
>  =09return 0;
>  }
> =20
> -static void perf_close_imc_mem_bw(void)
> +static void perf_close_imc_read_mem_bw(void)
>  {
>  =09int mc;
> =20
>  =09for (mc =3D 0; mc < imcs; mc++) {
> -=09=09if (imc_counters_config[mc][READ].fd !=3D -1)
> -=09=09=09close(imc_counters_config[mc][READ].fd);
> -=09=09if (imc_counters_config[mc][WRITE].fd !=3D -1)
> -=09=09=09close(imc_counters_config[mc][WRITE].fd);
> +=09=09if (imc_counters_config[mc].fd !=3D -1)
> +=09=09=09close(imc_counters_config[mc].fd);
>  =09}
>  }
> =20
>  /*
> - * perf_open_imc_mem_bw - Open perf fds for IMCs
> + * perf_open_imc_read_mem_bw - Open perf fds for IMCs
>   * @cpu_no: CPU number that the benchmark PID is bound to
>   *
>   * Return: =3D 0 on success. < 0 on failure.
>   */
> -static int perf_open_imc_mem_bw(int cpu_no)
> +static int perf_open_imc_read_mem_bw(int cpu_no)
>  {
>  =09int imc, ret;
> =20
> -=09for (imc =3D 0; imc < imcs; imc++) {
> -=09=09imc_counters_config[imc][READ].fd =3D -1;
> -=09=09imc_counters_config[imc][WRITE].fd =3D -1;
> -=09}
> +=09for (imc =3D 0; imc < imcs; imc++)
> +=09=09imc_counters_config[imc].fd =3D -1;
> =20
>  =09for (imc =3D 0; imc < imcs; imc++) {
> -=09=09ret =3D open_perf_event(imc, cpu_no, READ);
> -=09=09if (ret)
> -=09=09=09goto close_fds;
> -=09=09ret =3D open_perf_event(imc, cpu_no, WRITE);
> +=09=09ret =3D open_perf_read_event(imc, cpu_no);
>  =09=09if (ret)
>  =09=09=09goto close_fds;
>  =09}
> @@ -311,60 +268,52 @@ static int perf_open_imc_mem_bw(int cpu_no)
>  =09return 0;
> =20
>  close_fds:
> -=09perf_close_imc_mem_bw();
> +=09perf_close_imc_read_mem_bw();
>  =09return -1;
>  }
> =20
>  /*
> - * do_mem_bw_test - Perform memory bandwidth test
> + * do_imc_read_mem_bw_test - Perform memory bandwidth test
>   *
>   * Runs memory bandwidth test over one second period. Also, handles star=
ting
>   * and stopping of the IMC perf counters around the test.
>   */
> -static void do_imc_mem_bw_test(void)
> +static void do_imc_read_mem_bw_test(void)
>  {
>  =09int imc;
> =20
> -=09for (imc =3D 0; imc < imcs; imc++) {
> -=09=09membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
> -=09=09membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
> -=09}
> +=09for (imc =3D 0; imc < imcs; imc++)
> +=09=09read_mem_bw_ioctl_perf_event_ioc_reset_enable(imc);
> =20
>  =09sleep(1);
> =20
> -=09/* Stop counters after a second to get results (both read and write) =
*/
> -=09for (imc =3D 0; imc < imcs; imc++) {
> -=09=09membw_ioctl_perf_event_ioc_disable(imc, READ);
> -=09=09membw_ioctl_perf_event_ioc_disable(imc, WRITE);
> -=09}
> +=09/* Stop counters after a second to get results. */
> +=09for (imc =3D 0; imc < imcs; imc++)
> +=09=09read_mem_bw_ioctl_perf_event_ioc_disable(imc);
>  }
> =20
>  /*
> - * get_mem_bw_imc - Memory bandwidth as reported by iMC counters
> - * @bw_report: Bandwidth report type (reads, writes)
> + * get_read_mem_bw_imc - Memory read bandwidth as reported by iMC counte=
rs
>   *
> - * Memory bandwidth utilized by a process on a socket can be calculated
> - * using iMC counters. Perf events are used to read these counters.
> + * Memory read bandwidth utilized by a process on a socket can be calcul=
ated
> + * using iMC counters' read events. Perf events are used to read these
> + * counters.
>   *
>   * Return: =3D 0 on success. < 0 on failure.
>   */
> -static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
> +static int get_read_mem_bw_imc(float *bw_imc)
>  {
> -=09float reads, writes, of_mul_read, of_mul_write;
> +=09float reads =3D 0, of_mul_read =3D 1;
>  =09int imc;
> =20
> -=09/* Start all iMC counters to log values (both read and write) */
> -=09reads =3D 0, writes =3D 0, of_mul_read =3D 1, of_mul_write =3D 1;
> -
>  =09/*
> -=09 * Get results which are stored in struct type imc_counter_config
> +=09 * Log read event values from all iMC counters into
> +=09 * struct imc_counter_config.
>  =09 * Take overflow into consideration before calculating total bandwidt=
h.
>  =09 */
>  =09for (imc =3D 0; imc < imcs; imc++) {
>  =09=09struct imc_counter_config *r =3D
> -=09=09=09&imc_counters_config[imc][READ];
> -=09=09struct imc_counter_config *w =3D
> -=09=09=09&imc_counters_config[imc][WRITE];
> +=09=09=09&imc_counters_config[imc];
> =20
>  =09=09if (read(r->fd, &r->return_value,
>  =09=09=09 sizeof(struct membw_read_format)) =3D=3D -1) {
> @@ -372,12 +321,6 @@ static int get_mem_bw_imc(const char *bw_report, flo=
at *bw_imc)
>  =09=09=09return -1;
>  =09=09}
> =20
> -=09=09if (read(w->fd, &w->return_value,
> -=09=09=09 sizeof(struct membw_read_format)) =3D=3D -1) {
> -=09=09=09ksft_perror("Couldn't get write bandwidth through iMC");
> -=09=09=09return -1;
> -=09=09}
> -
>  =09=09__u64 r_time_enabled =3D r->return_value.time_enabled;
>  =09=09__u64 r_time_running =3D r->return_value.time_running;
> =20
> @@ -385,27 +328,10 @@ static int get_mem_bw_imc(const char *bw_report, fl=
oat *bw_imc)
>  =09=09=09of_mul_read =3D (float)r_time_enabled /
>  =09=09=09=09=09(float)r_time_running;
> =20
> -=09=09__u64 w_time_enabled =3D w->return_value.time_enabled;
> -=09=09__u64 w_time_running =3D w->return_value.time_running;
> -
> -=09=09if (w_time_enabled !=3D w_time_running)
> -=09=09=09of_mul_write =3D (float)w_time_enabled /
> -=09=09=09=09=09(float)w_time_running;
>  =09=09reads +=3D r->return_value.value * of_mul_read * SCALE;
> -=09=09writes +=3D w->return_value.value * of_mul_write * SCALE;
>  =09}
> =20
> -=09if (strcmp(bw_report, "reads") =3D=3D 0) {
> -=09=09*bw_imc =3D reads;
> -=09=09return 0;
> -=09}
> -
> -=09if (strcmp(bw_report, "writes") =3D=3D 0) {
> -=09=09*bw_imc =3D writes;
> -=09=09return 0;
> -=09}
> -
> -=09*bw_imc =3D reads + writes;
> +=09*bw_imc =3D reads;
>  =09return 0;
>  }
> =20
> @@ -551,35 +477,31 @@ static int print_results_bw(char *filename, pid_t b=
m_pid, float bw_imc,
>  }
> =20
>  /*
> - * measure_mem_bw - Measures memory bandwidth numbers while benchmark ru=
ns
> + * measure_read_mem_bw - Measures read memory bandwidth numbers while be=
nchmark runs
>   * @uparams:=09=09User supplied parameters
>   * @param:=09=09Parameters passed to resctrl_val()
>   * @bm_pid:=09=09PID that runs the benchmark
> - * @bw_report:=09=09Bandwidth report type (reads, writes)
>   *
>   * Measure memory bandwidth from resctrl and from another source which i=
s
>   * perf imc value or could be something else if perf imc event is not
>   * available. Compare the two values to validate resctrl value. It takes
>   * 1 sec to measure the data.
> + * resctrl does not distinguish between read and write operations so
> + * its data includes all memory operations.
>   */
> -int measure_mem_bw(const struct user_params *uparams,
> -=09=09   struct resctrl_val_param *param, pid_t bm_pid,
> -=09=09   const char *bw_report)
> +int measure_read_mem_bw(const struct user_params *uparams,
> +=09=09=09struct resctrl_val_param *param, pid_t bm_pid)
>  {
>  =09unsigned long bw_resc, bw_resc_start, bw_resc_end;
>  =09FILE *mem_bw_fp;
>  =09float bw_imc;
>  =09int ret;
> =20
> -=09bw_report =3D get_bw_report_type(bw_report);
> -=09if (!bw_report)
> -=09=09return -1;
> -
>  =09mem_bw_fp =3D open_mem_bw_resctrl(mbm_total_path);
>  =09if (!mem_bw_fp)
>  =09=09return -1;
> =20
> -=09ret =3D perf_open_imc_mem_bw(uparams->cpu);
> +=09ret =3D perf_open_imc_read_mem_bw(uparams->cpu);
>  =09if (ret < 0)
>  =09=09goto close_fp;
> =20
> @@ -589,17 +511,17 @@ int measure_mem_bw(const struct user_params *uparam=
s,
> =20
>  =09rewind(mem_bw_fp);
> =20
> -=09do_imc_mem_bw_test();
> +=09do_imc_read_mem_bw_test();
> =20
>  =09ret =3D get_mem_bw_resctrl(mem_bw_fp, &bw_resc_end);
>  =09if (ret < 0)
>  =09=09goto close_imc;
> =20
> -=09ret =3D get_mem_bw_imc(bw_report, &bw_imc);
> +=09ret =3D get_read_mem_bw_imc(&bw_imc);
>  =09if (ret < 0)
>  =09=09goto close_imc;
> =20
> -=09perf_close_imc_mem_bw();
> +=09perf_close_imc_read_mem_bw();
>  =09fclose(mem_bw_fp);
> =20
>  =09bw_resc =3D (bw_resc_end - bw_resc_start) / MB;
> @@ -607,7 +529,7 @@ int measure_mem_bw(const struct user_params *uparams,
>  =09return print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
> =20
>  close_imc:
> -=09perf_close_imc_mem_bw();
> +=09perf_close_imc_read_mem_bw();
>  close_fp:
>  =09fclose(mem_bw_fp);
>  =09return ret;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/=
selftests/resctrl/resctrlfs.c
> index 250c320349a7..eabdf0c20566 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -831,23 +831,6 @@ int filter_dmesg(void)
>  =09return 0;
>  }
> =20
> -const char *get_bw_report_type(const char *bw_report)
> -{
> -=09if (strcmp(bw_report, "reads") =3D=3D 0)
> -=09=09return bw_report;
> -=09if (strcmp(bw_report, "writes") =3D=3D 0)
> -=09=09return bw_report;
> -=09if (strcmp(bw_report, "nt-writes") =3D=3D 0) {
> -=09=09return "writes";
> -=09}
> -=09if (strcmp(bw_report, "total") =3D=3D 0)
> -=09=09return bw_report;
> -
> -=09fprintf(stderr, "Requested iMC bandwidth report type unavailable\n");
> -
> -=09return NULL;
> -}
> -
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu=
,
>  =09=09    int group_fd, unsigned long flags)
>  {
>=20

--8323328-2086223514-1727704750=:938--

