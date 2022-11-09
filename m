Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1D62364E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 23:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiKIWHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 17:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKIWHR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 17:07:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB97303F7
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 14:07:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o4so27949521wrq.6
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Nov 2022 14:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVu78POIovNyD99aPi4Yv4vzOo0b2PvKhIqKGNMp9kk=;
        b=Lsn0qJl948PIXcPTpBoc5kLqwQH0giN853X1wBZbXW5wayaj/UsFmo6mtUOBn3gjq/
         5RC1fIi6ts5rvITCJO4n8tvQjbAXTiz9UeSVaOf/mxFduVmkpgjy9JT3PXm8EsgVqBIP
         T89yGj+CixA4Xd6Ry+pPkTJPyG1y47swh/X1uJoO64VUlH0FqMpJ4PAd9N0l3DVHyS4B
         S1sY6n+I7sJBczNAJ9CXZPbD+L4y4oY1QOY0gJDLomCW79M/RSj2iKcSmn1pfg7ghUhL
         kPWD6GIpXrHP3bmwepbQfA5+JOVSFA4HIUSvSfCnppz/ZPV8KcEVeXiCRLlnWqJt7gtE
         5vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVu78POIovNyD99aPi4Yv4vzOo0b2PvKhIqKGNMp9kk=;
        b=73nr/iKzCs0JXbbFiwgmKq2i7bpbk5sE6itE74MOEBjz3bU5An6IWyCqQVVsDh0aMC
         xKITwIWEfXGXDG07TRNeZeVQ9i74ERImX775utDdrFzKEBY3k+tUZPp1X7hlc7BBSONO
         SVWCoCFlyIRN631Rn2wVvkHoE4V0UMqaR8izqCMj15KCNBUH4u2FrTS5wAGTdU3GAKzZ
         Vk96OLgFjaWK7xnqisqmbYUkdT42UES2HC13KGMdR25WnX3lAWBiaHpEND1WLF8T86zY
         +c5zkeQPPh2mZwRRIrXE75nc31FjoKW8IZD594Eocdj5yERTnG9NRsIcfIrRrrGv3ZfQ
         Ycng==
X-Gm-Message-State: ACrzQf3yFiwXOM6lSMaOw6caNYM2dcGPi2Q5zTfqvU5EUjYyXA4PQbe5
        B41C/RnIjFb74tXIeuExkmNblA==
X-Google-Smtp-Source: AMsMyM6Wj4IzRHnult9+7un3oEmdTypergzpWovW5Sc9QIE+GP3z6MUmI/2zBhWt7eDOssDBi5Pw0A==
X-Received: by 2002:a5d:6101:0:b0:236:6542:c65b with SMTP id v1-20020a5d6101000000b002366542c65bmr40849068wrt.438.1668031632279;
        Wed, 09 Nov 2022 14:07:12 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b002365254ea42sm14402030wrs.1.2022.11.09.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:07:11 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     akpm@linux-foundation.org, shuah@kernel.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Fix proc-empty-vm build error on non
 x86_64
References: <20221109110621.1791999-1-punit.agrawal@bytedance.com>
Date:   Wed, 09 Nov 2022 22:07:10 +0000
In-Reply-To: <20221109110621.1791999-1-punit.agrawal@bytedance.com> (Punit
        Agrawal's message of "Wed, 9 Nov 2022 11:06:21 +0000")
Message-ID: <87fser235d.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Punit Agrawal <punit.agrawal@bytedance.com> writes:

> The proc-empty-vm test is implemented for x86_64 and fails to build
> for other architectures. Rather then emitting a compiler error it
> would be preferable to only build the test on supported architectures.
>
> Mark proc-empty-vm as a test for x86_64 and customise to the Makefile
> to build it only when building for this target architecture.
>
> Fixes: 5bc73bb3451b ("proc: test how it holds up with mapping'less process")
> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
> ---
>  tools/testing/selftests/proc/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
> index cd95369254c0..6b31439902af 100644
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -1,14 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +# When ARCH not overridden for crosscompiling, lookup machine
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +
>  CFLAGS += -Wall -O2 -Wno-unused-function
>  CFLAGS += -D_GNU_SOURCE
>  LDFLAGS += -pthread
>  
> -TEST_GEN_PROGS :=
> +TEST_GEN_PROGS_x86_64 += proc-empty-vm
> +
>  TEST_GEN_PROGS += fd-001-lookup
>  TEST_GEN_PROGS += fd-002-posix-eq
>  TEST_GEN_PROGS += fd-003-kthread
>  TEST_GEN_PROGS += proc-loadavg-001
> -TEST_GEN_PROGS += proc-empty-vm
>  TEST_GEN_PROGS += proc-pid-vm
>  TEST_GEN_PROGS += proc-self-map-files-001
>  TEST_GEN_PROGS += proc-self-map-files-002

I noticed that a hunk has gone missing from the patch. Please ignore
this version - I'll post an updated one shortly.
