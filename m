Return-Path: <linux-kselftest+bounces-1671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B603480EDE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EB61F2164E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051516D1D9;
	Tue, 12 Dec 2023 13:44:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E237ED;
	Tue, 12 Dec 2023 05:44:56 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso768771a34.0;
        Tue, 12 Dec 2023 05:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388695; x=1702993495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FHgQG76vAAELXoJjrX/NTMafjPLo+txhiRxr9Qp8Mo=;
        b=auhaQSOmRO15IqW30H7nLcbtcNzirH7c7LM9JZWZbNOIdBLSvE8GAWFh/FqwUOnFB9
         342Uy9vG3KAL0PnE7JTTj0cdHurd1S6Cs9SZ4mUWA+AwFE7H2cWYeGcs1feVip8UR5ZV
         qCfzFUoSeK/C9AXBTq8ItriCkswolLVyx3BYzb72hoO68ZFyS1INq/IFchzrGZ1gAINJ
         Gh5k2z6pYEVueosbPQxVqUoN6MzVjCqj/3iJoV6DPwsoHqw9cclrvDCXX1dLANTVHGYj
         WQzqmZEXuLNgZmUcy9SDpzRr1Rw32yd5emKKKzulfwSHJlMLnoKjftF3CqM4NLu1JBc2
         wfqw==
X-Gm-Message-State: AOJu0YxMJ+Ls/1W5H3xs9cFefrJ36Ny/SoXs/rruCRXMqVRuALmPRQY4
	U4o0ypEmYV0g1Zbj+fuapSpWBxjpnsICxtY5P2I=
X-Google-Smtp-Source: AGHT+IEzBbu/99tixq8ymUICcMSaSMKmg0Twe94v+HrxDZ2VEwW2ix33qAtmHtCK1VxE9WDQ5bojxqSgFWZLD/UZGWY=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr12613201oob.1.1702388695286; Tue, 12
 Dec 2023 05:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205063537.872834-1-li.meng@amd.com> <20231205063537.872834-2-li.meng@amd.com>
In-Reply-To: <20231205063537.872834-2-li.meng@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 14:44:44 +0100
Message-ID: <CAJZ5v0gz4HKPFjKRaP_2aiCLrx8BDqOa_6W_B3PmU8x7ejsZhg@mail.gmail.com>
Subject: Re: [PATCH V12 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
To: Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>, 
	Deepak Sharma <deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, 
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:38=E2=80=AFAM Meng Li <li.meng@amd.com> wrote:
>
> amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
> of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
> without Intel CPU support.
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  arch/x86/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..3e57773f946a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1054,8 +1054,9 @@ config SCHED_MC
>
>  config SCHED_MC_PRIO
>         bool "CPU core priorities scheduler support"
> -       depends on SCHED_MC && CPU_SUP_INTEL
> -       select X86_INTEL_PSTATE
> +       depends on SCHED_MC
> +       select X86_INTEL_PSTATE if CPU_SUP_INTEL
> +       select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
>         select CPU_FREQ
>         default y
>         help
> --

This needs an ACK from the x86 maintainers.

