Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F3633522
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 07:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKVGOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 01:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKVGOB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 01:14:01 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BAA2CC94;
        Mon, 21 Nov 2022 22:14:00 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.159.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 87E763FA58;
        Tue, 22 Nov 2022 06:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669097638;
        bh=4/b1MCIFM013mc1FCJkM3gyJYez6X70iqknZ8/JDI5A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=C5IQaou2fwknUgSeGBFTvhUBUwWlj1dx6PFZeRumV16ZStQXeBIErLdZnAxt+BwjL
         UKvcfimfJb5wO23Tgzgw8PUZ5RotKLLOfAb5ijtQW6MZ/AoBqIMKOFRAnUp2uUnjUy
         YiGwqH45A5LO7exT4qS0hGgT/ixJeyM0n0fpSvuuhqrFeCi9zmJE0lPifFzk9WOaLG
         CRWa/xjn0SarnQJT4uWIjI3uuZypG+lOFVyV0cH+KpzwcjBI7b3LYCjHSBr74gyYEX
         tcXQzZfdhgyF0+HJw4+1G0iZ0TjwQ+Hn/tWeUVwRvlQZVqg2x/HOAaAFKyOnN4jsxm
         YOEBg+NgeOgrw==
Message-ID: <c9cbef8d-100f-763e-12b2-248dccd812fa@canonical.com>
Date:   Mon, 21 Nov 2022 22:13:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com
References: <20221102175959.2921063-1-rmoar@google.com>
 <20221102175959.2921063-2-rmoar@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221102175959.2921063-2-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/2/22 10:59, Rae Moar wrote:
> Create two macros:
> 
> VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
> is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change
> to the symbol definition.
> 
> EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
> EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is enabled. Must
> use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING) in test file in order to
> use symbols.
> 
> Signed-off-by: Rae Moar <rmoar@google.com>

This looks fine
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/kunit/visibility.h | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>   create mode 100644 include/kunit/visibility.h
> 
> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
> new file mode 100644
> index 000000000000..eb22c9e6b4eb
> --- /dev/null
> +++ b/include/kunit/visibility.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API to allow symbols to be conditionally visible during KUnit
> + * testing
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_VISIBILITY_H
> +#define _KUNIT_VISIBILITY_H
> +
> +/**
> + * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
> + * is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change
> + * to the symbol definition.
> + *
> + * EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
> + * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
> + * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
> + * in test file in order to use symbols.
> + */
> +#if IS_ENABLED(CONFIG_KUNIT)
> +    #define VISIBLE_IF_KUNIT
> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
> +	    EXPORTED_FOR_KUNIT_TESTING)
> +#else
> +    #define VISIBLE_IF_KUNIT static
> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol)
> +#endif
> +
> +#endif /* _KUNIT_VISIBILITY_H */

