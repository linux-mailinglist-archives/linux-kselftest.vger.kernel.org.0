Return-Path: <linux-kselftest+bounces-1673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B724E80EDFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FD528183C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAEE6EB76;
	Tue, 12 Dec 2023 13:47:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277E1A1;
	Tue, 12 Dec 2023 05:47:48 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d9db92bd71so769625a34.1;
        Tue, 12 Dec 2023 05:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388867; x=1702993667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/X6R0HR+xbXGN5qRhO2As3RreYVAwdxii2KLmKVXIM=;
        b=Rkhj3hXQDzoRFr4vvAVaxTx7RzPnw16rqj8UMh4FHUqntPxjMt6iwQQ6tCgoQktUfm
         y7rW6YOmn2JXyocc5Y0qUnQ9yJEsI1UbB2K/ytZzlC3ZkBekIc76uxCc7jw/9vdb/Iaw
         GUgUn3ZxdFuxaJGRZZWaZIlmYJhhXiqjWHARy4edRxo/RPE8QumFJc+HzST3WNMNwaFc
         vmCkLcfysfxHJs2gYF0e1lBERWPm0yTYnLrkW0343E+cZ5oWUa3cys0Euz2LjjmtbQHH
         ZwTqq4mctDhFfW+wwQsFROzHEaQnwcul+xpmfo9Vr2TtP4KV/AINzJhqsCue7PeSaqNp
         PS7Q==
X-Gm-Message-State: AOJu0YwUIew1EEw7PsdYpO2rGd0AS9b6qmqYOcjXBlhdtdx1Pf8SOUBR
	EiVeWKYuYUTxr8Wy2ybbC27DIxNUecNSRcD+KyeT7G88
X-Google-Smtp-Source: AGHT+IEJhakpYW3S8EY4DMqvhznErmMox7oe1ZX5qPrH5Xkhs4aGDo5Bbnh5X9aUH+1+IG1hagao25A13pcgEloq/4s=
X-Received: by 2002:a05:6870:b028:b0:1fb:e5f:c530 with SMTP id
 y40-20020a056870b02800b001fb0e5fc530mr11532372oae.4.1702388867382; Tue, 12
 Dec 2023 05:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205063537.872834-1-li.meng@amd.com> <20231205063537.872834-3-li.meng@amd.com>
In-Reply-To: <20231205063537.872834-3-li.meng@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 14:47:36 +0100
Message-ID: <CAJZ5v0ghO8A2co6tK6-kM-1NdjVggM-_26hj+oiv8hTGQGg1mw@mail.gmail.com>
Subject: Re: [PATCH V12 2/7] acpi: cppc: Add get the highest performance cppc control
To: Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>, 
	Deepak Sharma <deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, 
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>, Wyes Karny <wyes.karny@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please spell ACPI and CPPC in capitals in the subject.

On Tue, Dec 5, 2023 at 7:38=E2=80=AFAM Meng Li <li.meng@amd.com> wrote:
>
> Add support for getting the highest performance to the
> generic CPPC driver. This enables downstream drivers
> such as amd-pstate to discover and use these values.
>
> Please refer to the ACPI_Spec for details on continuous
> performance control of CPPC.

So which section of the spec is the reader supposed to refer to?

> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Cont=
rol.html?highlight=3Dcppc#highest-performance
> ---
>  drivers/acpi/cppc_acpi.c | 13 +++++++++++++
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..ad388a0e8484 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal=
_perf)
>         return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>  }
>
> +/**
> + * cppc_get_highest_perf - Get the highest performance register value.
> + * @cpunum: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +       return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> +
>  /**
>   * cppc_get_epp_perf - Get the epp register value.
>   * @cpunum: CPU from which to get epp preference value.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6126c977ece0..c0b69ffe7bdb 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -139,6 +139,7 @@ struct cppc_cpudata {
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
> +extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb=
_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
> @@ -165,6 +166,10 @@ static inline int cppc_get_nominal_perf(int cpunum, =
u64 *nominal_perf)
>  {
>         return -ENOTSUPP;
>  }
> +static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +       return -ENOTSUPP;
> +}
>  static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *=
perf_fb_ctrs)
>  {
>         return -ENOTSUPP;
> --

