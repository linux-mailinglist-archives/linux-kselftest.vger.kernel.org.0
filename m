Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FEE6D9B9B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbjDFPDZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbjDFPDW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 11:03:22 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711D2D4F;
        Thu,  6 Apr 2023 08:03:11 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so19543429otb.0;
        Thu, 06 Apr 2023 08:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYgmHMtE4Z7gXY8fARqNrSklFArQd85DUjhl84S7U8k=;
        b=46RUrTNkogma/31YfsGCMzy2HZvD4gtizmbuY91BYs2wRCBkBqAeS6meEvd04VQZ0I
         bI6c9nuoqh1bcH2XaMPQUZisgOcUSBqOYEDb88zipwA41PZedCDS5sJDBXgFPGkIJXXK
         hui8mywnr1MrDm94fvcvY0+MHbUJ0Esbq+H9x8wGEmKXLcULhlu54Io5Na3LWpePvFH7
         xlhl8xH4KOoPQOdLb3XoKpsAvYwdRDdECq7oN6hf6wnhxUO1urp7U9Bm6XClDhZRPUGO
         SkjoOTe5yRLwwTDjkMt9RvM0L+aG6NudWpBa3yuu1shxWjUlbIUbyQFeYHVaVSEulg0E
         dwiw==
X-Gm-Message-State: AAQBX9fzWXpDJtvdWJyIrZnXXkiuQyknwt+6NFkMVODDJHV9fq5C8iPC
        fX3GISgekHIzREQBwm03nQ==
X-Google-Smtp-Source: AKy350bZD4DjQUO7AVGHEVenQnfIMLuXNlrLc4gknaEfA4cOh4RhwrUIHpdfd4pE2Dh1CZs3PVEqRQ==
X-Received: by 2002:a05:6830:1390:b0:697:bfe5:93a0 with SMTP id d16-20020a056830139000b00697bfe593a0mr3732206otq.10.1680793390855;
        Thu, 06 Apr 2023 08:03:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c2-20020a9d75c2000000b006a154373578sm765278otl.39.2023.04.06.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:03:10 -0700 (PDT)
Received: (nullmailer pid 3093825 invoked by uid 1000);
        Thu, 06 Apr 2023 15:03:09 -0000
Date:   Thu, 6 Apr 2023 10:03:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        David Gow <davidgow@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 10/11] dt-bindings: clk: Add KUnit clk_parent_data test
Message-ID: <168079338907.3093774.3664348677242434161.robh@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
 <20230327222159.3509818-11-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327222159.3509818-11-sboyd@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Mon, 27 Mar 2023 15:21:58 -0700, Stephen Boyd wrote:
> Describe a binding for a device that provides and consumes clks in DT so
> that a KUnit test can register clks based on the device node and test
> clk_hw_register() with clk_parent_data.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  .../bindings/clock/test,clk-parent-data.yaml  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

