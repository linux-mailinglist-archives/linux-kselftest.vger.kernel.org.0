Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB54E6A865B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 17:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCBQbc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 11:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCBQbb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 11:31:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6662938B52;
        Thu,  2 Mar 2023 08:31:29 -0800 (PST)
Received: from [IPV6:2001:861:4a40:8620:656e:de35:bfcf:ff5d] (unknown [IPv6:2001:861:4a40:8620:656e:de35:bfcf:ff5d])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3634660206A;
        Thu,  2 Mar 2023 16:31:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677774687;
        bh=bXW4FE1NNRdrxRwNvl1HA9uGv5Kt5tBRB3ts7PpRZV8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YNdMqiynLRmvhtUHREjx5ca3AlePKdZ6h7YZO7DxQZZc+1gVB+iLak2WyMF5d8v07
         d+uYdDhq2NCdzxPOn2AKTzIsriLqPIHHoBsnvkOgYLgz0XsewlE4Br4wXmba+G3JEl
         XpqBFmoQXdFXrTbfwqzD97Y9XAS482Aaq1R0dXndRCLC69C5slbeXBu9jP2N3Pci5J
         3wTf4EnEhuj3t3KalRKSN50mx+6EnXVRb1mmFH33hd+11sgtupFiKZqasTc6YAWY70
         dIIJhYicNqKxur6fgwQPkw31maQfq2BuEhZXu3OWZJZ11lU+pqnedEdLnfpHrDhRV2
         vdj18lu64W7QA==
Message-ID: <4706bd68-fddd-05e5-137b-cf46c95a2ee5@collabora.com>
Date:   Thu, 2 Mar 2023 17:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests: amd-pstate: fix TEST_FILES
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>, Huang Rui <ray.huang@amd.com>,
        Meng Li <li.meng@amd.com>, Doug Smythies <dsmythies@telus.net>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev
References: <20230204133454.260066-1-guillaume.tucker@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <20230204133454.260066-1-guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 04/02/2023 14:34, Guillaume Tucker wrote:
> Bring back the Python scripts that were initially added with
> TEST_GEN_FILES but now with TEST_FILES to avoid having them deleted
> when doing a clean.  Also fix the way the architecture is being
> determined as they should also be installed when ARCH=x86_64 is
> provided explicitly.  Then also append extra files to TEST_FILES and
> TEST_PROGS with += so they don't get discarded.
> 
> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> Fixes: ac527cee87c9 ("selftests: amd-pstate: Don't delete source files via Makefile")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  tools/testing/selftests/amd-pstate/Makefile | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5fd1424db37d..c382f579fe94 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,10 +4,15 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>  
> -uname_M := $(shell uname -m 2>/dev/null || echo not)
> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
> -TEST_PROGS := run.sh
> -TEST_FILES := basic.sh tbench.sh gitsource.sh
> +ifeq (x86,$(ARCH))
> +TEST_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +TEST_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +endif
> +
> +TEST_PROGS += run.sh
> +TEST_FILES += basic.sh tbench.sh gitsource.sh
>  
>  include ../lib.mk

Is there anything blocking this patch from being applied?  It
brings back the tools needed to run the amd-pstate tests into the
kselftest installation directory.

I could try to run the test on an AMD platform and check it's
working as before, but there was no change in the tools
themselves and I've checked the scripts get installed correctly
now like before.  We might also actually run this test in
KernelCI since there are a few AMD platforms available.

Thanks,
Guillaume

