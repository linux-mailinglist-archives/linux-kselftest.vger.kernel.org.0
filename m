Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500866C3B41
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 21:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCUUJg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCUUJf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 16:09:35 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075D3756A;
        Tue, 21 Mar 2023 13:09:33 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17ab3a48158so17458891fac.1;
        Tue, 21 Mar 2023 13:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IoD7Q9QgP9epdBdXgrVu+8obbfapCzV9cQyqFydqE4=;
        b=htl4KWMwZPvEI72QX9+S2zxm2Ub/Q0FFhaJEVd4rbIDdjnthnLg/CBPBpRYfjG6UWP
         jHeSCpg+25HKcNNEaDZPiN4Ek3RcQimeQePe9NP/cf6Qyt6KTV0shExQACdM2pd7axT1
         PW0TWkBofldYOhWU73MqkQsqyWL2j5vwoLQUaXX2NyEWg5u85UIb6mT5JEI8DytqYjKF
         BxTBV97fyXRF7qce5VXozknWEwB9Pt39lMU3PMzdb6JtxxPZh1RG3AN6QIcUvL8Js+Is
         c1OSACEOpkmh4FWp4Q7vTtpvRdwo36tU9DNi9/RQLq2NDMCLA4WxBRQE6mt64RAbn+fV
         FJGQ==
X-Gm-Message-State: AO0yUKXrvbuGoa2SKf6fAUqdk+V0ISlxkkzROnNRfMc7g18ZrazXOlF9
        Oq+hkqEGlCD6Mgz1owYZDg==
X-Google-Smtp-Source: AK7set+pWW0vALEw83DoZDfRZdCvrXXnxgvVR/oSATJR6uJ8gLmhh0iJscB+wyFEqdciz39XeohXEA==
X-Received: by 2002:a05:6871:413:b0:179:d821:b911 with SMTP id d19-20020a056871041300b00179d821b911mr165631oag.21.1679429372840;
        Tue, 21 Mar 2023 13:09:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id wl24-20020a056871a81800b0017255c79736sm4541598oab.43.2023.03.21.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:09:32 -0700 (PDT)
Received: (nullmailer pid 1397876 invoked by uid 1000);
        Tue, 21 Mar 2023 20:09:31 -0000
Date:   Tue, 21 Mar 2023 15:09:31 -0500
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
Subject: Re: [PATCH v2 04/11] dt-bindings: test: Add KUnit empty node binding
Message-ID: <20230321200931.GA1367503-robh@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
 <20230315183729.2376178-5-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315183729.2376178-5-sboyd@kernel.org>
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

On Wed, Mar 15, 2023 at 11:37:21AM -0700, Stephen Boyd wrote:
> Describe a binding for an empty device node used by KUnit tests to
> confirm overlays load properly.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  .../bindings/test/test,kunit-empty.yaml       | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/test/test,kunit-empty.yaml
> 
> diff --git a/Documentation/devicetree/bindings/test/test,kunit-empty.yaml b/Documentation/devicetree/bindings/test/test,kunit-empty.yaml
> new file mode 100644
> index 000000000000..592fd06031b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/test/test,kunit-empty.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/test,kunit-empty.yaml#

s/clock/test/

'make dt_binding_check' will tell you this.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: KUnit empty node
> +
> +maintainers:
> +  - David Gow <davidgow@google.com>
> +  - Brendan Higgins <brendanhiggins@google.com>
> +
> +description: |

Don't need '|'

> +  An empty node to confirm KUnit can load device tree overlays.
> +
> +properties:
> +  compatible:
> +    const: test,kunit-empty
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    kunit-node {
> +      compatible = "test,kunit-empty";
> +    };
> +...
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
> 
