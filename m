Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC96689DFF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjBCPSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 10:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjBCPSd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 10:18:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190FA2A4F;
        Fri,  3 Feb 2023 07:15:47 -0800 (PST)
Received: from [10.101.1.132] (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56E726602E87;
        Fri,  3 Feb 2023 15:14:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675437319;
        bh=3CNbHI7q6Lfu7dssxqhvzLTLrYHpsxuwToLdzclRMnQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eQVSlNKru3vlHuJ1ptAy2k9l4UzVBFuGai4d5h6wRbCh/IC+c9YEVMsFxdNQTGQMR
         18Wb7H+U8I3eNzW9c57/pa7Dmmw2Oz/iF2qL7b2iuYRfynE9PGM/jQN/yWs6/B86aC
         n4jgvOpsx2xLmm33LOWoQCdO9ql43bxNct/eiMO96sJIOOcdgyTykrlDQHCiWxxsHC
         OwbUxjgWkdZoB1VcwOyMPB4JKpP0FptxelGewbQDDi2cDj8cUw4JHkdZzzCcX9NA6Q
         sHIHFoX4DtgEUkO7JfKu45ErqqmXd7rsS5BB1GeUwMNknIHQhj0H3xqP4zYz/xkqhj
         h7aC04yfmwjEw==
Message-ID: <b18805b0-06ba-2b28-73e5-a1d54425a704@collabora.com>
Date:   Fri, 3 Feb 2023 16:15:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] selftests: amd-pstate: Don't delete source files via
 Makefile
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>,
        'Huang Rui' <ray.huang@amd.com>, sedat.dilek@gmail.com,
        li.meng@amd.com, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
 <000601d92db7$39e9d0b0$adbd7210$@telus.net>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <000601d92db7$39e9d0b0$adbd7210$@telus.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21/01/2023 17:41, Doug Smythies wrote:
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


The two lines above should also be removed as they're only used
in the condition to include the Python files.

I've also hit this issue and independently came up with an
alternative solution, let me know if you want me to submit it as
a patch on top of the previous fix; see below.

The Python scripts appear to be used in gitsource.sh and
tbench.sh so I guess they are needed for these kselftests
although I haven't tried to run them or do anything with them.
This is just to fix make clean.



Author: Guillaume Tucker <guillaume.tucker@collabora.com>
Date:   Fri Feb 3 11:23:50 2023 +0100

    selftests: amd-pstate: fix TEST_FILES
    
    Replace TEST_GEN_FILES with TEST_FILES to avoid having them deleted
    when doing a clean.  Also fix the way the architecture is being
    determined as they should also be installed when ARCH=x86_64 is
    provided explicitly.  Then also append extra files to TEST_FILES and
    TEST_PROGS with += so they don't get discarded.
    
    Fixes: a2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
    Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 5f195ee756d6..c382f579fe94 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,15 +4,15 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq (x86,$(ARCH))
-TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
-TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+TEST_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
+TEST_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
 endif
 
-TEST_PROGS := run.sh
-TEST_FILES := basic.sh tbench.sh gitsource.sh
+TEST_PROGS += run.sh
+TEST_FILES += basic.sh tbench.sh gitsource.sh
 
 include ../lib.mk

