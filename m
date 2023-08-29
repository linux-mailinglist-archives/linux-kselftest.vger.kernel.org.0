Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7897C78C2AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjH2Ky2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjH2KyS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 06:54:18 -0400
X-Greylist: delayed 1785 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 03:53:47 PDT
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CEACF1;
        Tue, 29 Aug 2023 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To:Message-Id:Date; bh=N5WzpI5h6EC9SL2rqOLnUu4sEe9bxdIyMkAU6n5jD44=;
        b=DGRLpT4gROnRdgq7urYw58wHiripEmYh2gtMPOjOMCSeom9F41r7gpi5q8NXBQkkoxBw7nA28yHnZA6Rf34oALTR651dzQ3ue1AWWSh2arLeZSaVC4Vzc768OIkWKUYTvUuIUFhPxqZMZSZLYQFB8AHwz9aofirJzLAlYW8Q7rA=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1qav8j-00020C-AL; Tue, 29 Aug 2023 09:36:01 +0000
Received: from [192.168.2.103] (helo=localhost)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1qav8G-0002ka-4f; Tue, 29 Aug 2023 09:35:32 +0000
Date:   Tue, 29 Aug 2023 11:35:19 +0200 (CEST)
Message-Id: <20230829.113519.1499398743089914237.rene@exactcode.com>
To:     Meng Li <li.meng@amd.com>
Cc:     Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Nathan Fontenot" <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate
 Preferred Core Supporting.
From:   Rene Rebe <rene@exactcode.com>
X-Mailer: Mew version 6.8 on Emacs 29.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.5 (/)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Meng Li and team,

thank you so much for working on finally bringing AMD preferred core
scheduling to mainline Linux!

> The initial core rankings are set up by AMD Pstate when the
> system boots.

I tested this patch on our Ryzen 7950x and 5950x systems and could
unfortunatlely not find any performance differences. I therefore took
a closer look and as far as I can tell the conditional for the initial
preferred performance priorities appears to be reversed. I marked them
down below. I also attached a patch for the fix. With that fixed I can
measure a 0.7% improvement compiling Firefox on 7950x. I wonder
slightly how this ever past testing before, ...

I think it would be a good idea to always expose the hw perf values in
sysfs to help users debugging hardware issues or BIOS settings even
with percore not enabled and therefore not using the unused 166 or 255
values anyway.

With that fixed, however, Linux is still not always scheduling to
preferred cores, but that appears to be an independant limitation of
the current linux scheduler not strictly using the priority for
scheduling, yet. With manual taskset guidance I could further improve
the Firefox build time by some more seconds to over 1% overall
performance improvement, if the linux scheudler would more reliably
schedule minute long running rust lto link tasks to the preferred
cores and not some mediocre ones.


> -	highest_perf =3D amd_get_highest_perf();
> -	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> -		highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));

Conditional reversed, assigns THRESHOLD if enabled!

>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(=
cap1));
> @@ -318,17 +322,15 @@ static int pstate_init_perf(struct amd_cpudata =
*cpudata)
>  static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> -	u32 highest_perf;
>  =

>  	int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  =

> -	highest_perf =3D amd_get_highest_perf();
> -	if (highest_perf > cppc_perf.highest_perf)
> -		highest_perf =3D cppc_perf.highest_perf;
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);

Same here. Not using highest_perf if enabled, ...

Signed-off-by: Ren=E9 Rebe <rene@exactcode.de>

--- linux-6.4/drivers/cpufreq/amd-pstate.c.vanilla	2023-08-25 22:34:25.=
254995690 +0200
+++ linux-6.4/drivers/cpufreq/amd-pstate.c	2023-08-25 22:35:49.19499144=
6 +0200
@@ -282,9 +282,9 @@
 	 * the default max perf.
 	 */
 	if (prefcore)
-		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
-	else
 		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+	else
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
 =

 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(ca=
p1));
@@ -303,9 +303,9 @@
 		return ret;
 =

 	if (prefcore)
-		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
-	else
 		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
+	else
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
 =

 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,


-- =

  Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactcode.com | https://t2sde.org | https://rene.rebe.de
