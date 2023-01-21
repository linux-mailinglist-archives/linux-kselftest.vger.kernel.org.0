Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D528676787
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAUQ7e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 11:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUQ7d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 11:59:33 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3270E2940E;
        Sat, 21 Jan 2023 08:59:32 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a37so8916728ljq.0;
        Sat, 21 Jan 2023 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lS7OTDH5xsHguwgoMystLpNa9MHa3l+igtaO3KLB4S8=;
        b=qWBeeI8GcMaFhAphaGpt1sLrb6bytQUftC0WTM6eilD8PoXtLu1T3Wh0KfM3HcyWbz
         hMZ/Lnhl9JNmQn481RPwRNc48k9Yg7LGgf/r0P9mFd3GsPEDO4tUVKN1XsvF1FIpB0Jh
         oy+YvYbswSAwJ8MHDhHbr8Z2T/KJNSOL8kR4rfAbbvP11aRRQKbsw+uvdlSM5NuIXkAX
         x/nma3tcCc/CtkjN02CRbSntzizU0w9MO2e9AvdccT+rfIM6SAxDVbtEQhZUtJpnYjhy
         wwIjGW7Glg9PXzfYThUe2gobgln+AuKEzdPmc4cz37UoYvUObKcpz2M7xntdYb2XOBA+
         Vhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS7OTDH5xsHguwgoMystLpNa9MHa3l+igtaO3KLB4S8=;
        b=6khYCXplpYAIdi3V1DU8hjykc+3mvxIBPMykR9uLDn9HViicH+yupGuQDZljrugBXH
         0szfHLfYXJ6OVvGeNcmnOEykX+vPYfiw57tiidmMNZzrVo+H06T1jxB29z6mqBjTQX2W
         MqHVsb5g/puECq3qCJwzVOjAI3v5xHkBodxDGnoyavUQ4a9aORrkaueupucviSryKLOC
         jBTWaxtZ/aGSszZwXH+vIdug/PJqPIGTqyszHSzP8s/ZsVGL1zsvrVKporeIucohxRzr
         1+apnRIaUT74EnyznkewhsAFUytIfxDoSwMYD5mkUP1hQtzfibxyDg1fosY2U+LgkaF6
         JLnQ==
X-Gm-Message-State: AFqh2krYlTaxTpDO+fXNvfdGd6E/sjSPV4kW6yzZSz5bMt9GWECeCkVy
        o40CW64KI6m0xohRTWnXiPPivET/WpTyzvobtjg=
X-Google-Smtp-Source: AMrXdXs2JOXrHvOXx534MiLH8Kc5JcYjdUaE0aZg91H+2RdNyXWFq2+jkC8sSBfnCGviWfUQf8plAu42lOLmnJ+WOoY=
X-Received: by 2002:a2e:9255:0:b0:289:81a4:3a7b with SMTP id
 v21-20020a2e9255000000b0028981a43a7bmr1260269ljg.487.1674320370315; Sat, 21
 Jan 2023 08:59:30 -0800 (PST)
MIME-Version: 1.0
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net> <000601d92db7$39e9d0b0$adbd7210$@telus.net>
In-Reply-To: <000601d92db7$39e9d0b0$adbd7210$@telus.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 21 Jan 2023 17:58:53 +0100
Message-ID: <CA+icZUVoxYrUfW9R9cCcUkHvvbkZoHSCmHVuTVh7gmdf9_jJkQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: amd-pstate: Don't delete source files via Makefile
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Huang Rui <ray.huang@amd.com>, li.meng@amd.com,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 21, 2023 at 5:41 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Revert the portion of a recent Makefile change that incorrectly
> deletes source files when doing "make clean".
>
> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
> v2: fix address list.
> ---

Hi Doug,

thanks for the update.

You happen to know through which Git tree this will go?
linux-pm?
linux-kselftest?

https://lore.kernel.org/lkml/?q=Doug+Smythies

Hmm, I cannot download the patch with b4:

link="https://lore.kernel.org/lkml/000601d92db7$39e9d0b0$adbd7210$@telus.net/"

$ b4 -d am $link
Running git --no-pager config -z --get-regexp b4\..*
Running git --no-pager config -z --get-regexp get-lore-mbox\..*
Running git --no-pager config -z --get-regexp gpg\..*
t_mbx_url=https://lore.kernel.org/all/https%3A%2F%2Flore.kernel.org%2Flkml%2F000601d92db79e9d0b0telus.net%2F/t.mbox.gz
Grabbing thread from
lore.kernel.org/all/https%3A%2F%2Flore.kernel.org%2Flkml%2F000601d92db79e9d0b0telus.net%2F/t.mbox.gz
That message-id is not known.

Maybe be patient.

BR,
-Sedat-

>  tools/testing/selftests/amd-pstate/Makefile | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5f195ee756d6..5fd1424db37d 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -7,11 +7,6 @@ all:
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>
> -ifeq (x86,$(ARCH))
> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> -endif
> -
>  TEST_PROGS := run.sh
>  TEST_FILES := basic.sh tbench.sh gitsource.sh
>
> --
> 2.25.1
>
>
>
