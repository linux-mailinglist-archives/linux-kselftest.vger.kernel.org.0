Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540CF6C3B71
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 21:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCUUPe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUUPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 16:15:33 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C0F967;
        Tue, 21 Mar 2023 13:14:51 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so9233914otj.2;
        Tue, 21 Mar 2023 13:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iyMeXtw28xdDxjAf1Mr9Ugy13ikhgamAMQijRmwaUg=;
        b=6OkJ4+pUu3bht0dqT0Z2vRb2Wb2eUuWyLNQ9TKY48crEJxlmbHrAjOFLttMiZFnpM+
         z2aJ7ZaX0v4ZRNhtLJD2twjQsOksLs8dHkbOQOcX/1Uqg7MyfKPb6AsH+5sHfxba4klb
         lzFEUOqwhkJ2qJAwBH4emz0y41AgTVDOxyx7ksu7ODBf/Y6p3RvJhvdCbvy2iREu7g3/
         jKCNqAM7jrXf546Wob9eD/KttFLuaCFPXi6MdptA/FMrUISanpnoXSGqTmq2S0Zd6FE0
         nL2FwL2bH42Y2aVvsbgPS92Jsy4l1XkdESs/RrG1hdvgt6EeNDMVTV7GmLkrZaH+pu1E
         8dcg==
X-Gm-Message-State: AO0yUKV0GjouBUJbQFXy7olhpDxRreea2HBMIawhOuXNRstEI8XrHwJ3
        VFTYnP7iZPIeUGgYtP5/4Q==
X-Google-Smtp-Source: AK7set9I74btpUJ+yTSu/rYcbUzo5Thb6TU9525KAhdsVfwO1Eocyf9B4D4yAB3OlE5rvi7eizLHvg==
X-Received: by 2002:a9d:6654:0:b0:69f:8d0f:9a1e with SMTP id q20-20020a9d6654000000b0069f8d0f9a1emr276389otm.7.1679429688137;
        Tue, 21 Mar 2023 13:14:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v8-20020a9d69c8000000b0069f951899e1sm223475oto.24.2023.03.21.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:14:47 -0700 (PDT)
Received: (nullmailer pid 1434710 invoked by uid 1000);
        Tue, 21 Mar 2023 20:14:46 -0000
Date:   Tue, 21 Mar 2023 15:14:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 07/11] dt-bindings: kunit: Add fixed rate clk consumer
 test
Message-ID: <20230321201446.GA1401650-robh@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
 <20230315183729.2376178-8-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315183729.2376178-8-sboyd@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 15, 2023 at 11:37:24AM -0700, Stephen Boyd wrote:
> Describe a binding for a device that consumes a fixed rate clk in DT so
> that a KUnit test can get the clk registered by of_fixed_clk_setup() and
> test that it is setup properly.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  .../kunit/test,clk-kunit-fixed-rate.yaml      | 35 +++++++++++++++++++

Some stuff in test and some in kunit? I prefer 'test'.

>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kunit/test,clk-kunit-fixed-rate.yaml
> 
> diff --git a/Documentation/devicetree/bindings/kunit/test,clk-kunit-fixed-rate.yaml b/Documentation/devicetree/bindings/kunit/test,clk-kunit-fixed-rate.yaml
> new file mode 100644
> index 000000000000..58d7826d9c14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kunit/test,clk-kunit-fixed-rate.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kunit/test,clk-kunit-fixed-rate.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: KUnit clk fixed rate test clk consumer
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +description: |

Drop '|'

> +  A clk consumer of a fixed rate clk used to test the fixed rate clk
> +  implementation in the Linux kernel.
> +
> +properties:
> +  compatible:
> +    const: test,clk-kunit-fixed-rate

I tend to think we should drop 'kunit' from these bindings. You could 
use this for different test frameworks. 

> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-consumer {
> +      compatible = "test,clk-kunit-fixed-rate";
> +      clocks = <&fixed_clk>;
> +    };
> +...
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
> 
