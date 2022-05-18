Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2152B5E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiERJWj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiERJWf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 05:22:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192B31F607
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 02:22:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so1808623wrg.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYv9sRLI7bJwp+N2At4wjffC8t0qCPCqKx/aIfhkVRc=;
        b=Bx791FgAcxOvK9T5I5mW1O2stza4Yq+SU8uF6QI50wTsBwxFr/t4D7Q9mXtDAJcLUx
         p17zMxSvZtETdUdAJpTjH9AtE+TLl6z/dhu2T3Y2J8xzacp47cmvbbiEqJFaIgh0IVs+
         evA0Vuw76mWBxQqeK83sAVqV3e9Jx/OVK9zsje6a8b/oDQTv2CraAJohRuyLm7K5SUKg
         hS1imuK7ZMnh7acWOtZQj7kkhlHLdOvJrN9EUyMVE7rhnxqQYxcoa6orvYhbuuYXAJX8
         thlIQDe8Ytn2pdOsUxfo+9Nkg2QcGQ3TMA8wSblFyUZO5/pjDhmq+QoUfHy3JuG81Xh8
         YMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYv9sRLI7bJwp+N2At4wjffC8t0qCPCqKx/aIfhkVRc=;
        b=w953JQHeT2VHit7jKwcjkQV/jc27FvMVfnSl/Oi1ZjXXlfMDB/6/d6uMapNOSO/gZj
         zX0M3MaakQKDPmE+RnyhVPLXkeifX76OaV0DoEbrrg1/48OJJ7YzbdJ1eLTAn6Au+9th
         AoJ6D7ribscO0vtMXs5cM9/F5tZ5c4rpA+xjrT5L/oiEbh6LFRdOGeMFo+9R8aDu2Rm1
         h6Nsck/2jQlL2OfErxGml2oioEtTDwJLcQU3HYWMRQIuXbgrnRb+jeRNyOu81mr0s0zx
         iJmlEvouQgglj6E7jXsDx7qre9e1VshEQX5VgTZUTMm1Bu+OFlXQ35G7lXadjvfXq1a9
         65Hg==
X-Gm-Message-State: AOAM531Bymw1Vcu26y1BdIk/Xo4TScYXACmQ1X6QDIV81+LUkh4xoiOG
        R95JJGIpigXLGkiGFYWKplrTmg==
X-Google-Smtp-Source: ABdhPJyaIg8Bgl1cARcw5hIG7Q+j6EXk2MNoBQ/8SilKrhqYa6wciJBokhSQg3QGCOpvb/fnUuhhIA==
X-Received: by 2002:a5d:55cd:0:b0:20d:743:6078 with SMTP id i13-20020a5d55cd000000b0020d07436078mr12731983wrw.240.1652865751403;
        Wed, 18 May 2022 02:22:31 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:450f:9c92:a170:5581])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c0a1600b003942a244f38sm3873757wmp.17.2022.05.18.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:22:30 -0700 (PDT)
Date:   Wed, 18 May 2022 11:22:25 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP
 testing
Message-ID: <YoS60c/CIK3mHWyq@elver.google.com>
References: <20220518073232.526443-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518073232.526443-1-davidgow@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 18, 2022 at 03:32PM +0800, 'David Gow' via KUnit Development wrote:
> Add a new QEMU config for kunit_tool, x86_64-smp, which provides an
> 8-cpu SMP setup. No other kunit_tool configurations provide an SMP
> setup, so this is the best bet for testing things like KCSAN, which
> require a multicore/multi-cpu system.
> 
> The choice of 8 CPUs is pretty arbitrary: it's enough to get tests like
> KCSAN to run with a nontrivial number of worker threads, while still
> working relatively quickly on older machines.
> 
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Marco Elver <elver@google.com>

> ---
> 
> This is based off the discussion in:
> https://groups.google.com/g/kasan-dev/c/A7XzC2pXRC8
> 
> ---
>  tools/testing/kunit/qemu_configs/x86_64-smp.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 tools/testing/kunit/qemu_configs/x86_64-smp.py
> 
> diff --git a/tools/testing/kunit/qemu_configs/x86_64-smp.py b/tools/testing/kunit/qemu_configs/x86_64-smp.py
> new file mode 100644
> index 000000000000..a95623f5f8b7
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/x86_64-smp.py
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
> +			   kconfig='''
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SMP=y
> +			   ''',
> +			   qemu_arch='x86_64',
> +			   kernel_path='arch/x86/boot/bzImage',
> +			   kernel_command_line='console=ttyS0',
> +			   extra_qemu_params=['-smp', '8'])
> -- 
> 2.36.0.550.gb090851708-goog
> 
> -- 
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220518073232.526443-1-davidgow%40google.com.
