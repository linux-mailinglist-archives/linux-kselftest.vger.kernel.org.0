Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB466D9B88
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbjDFPCK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbjDFPCJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 11:02:09 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F0E4B;
        Thu,  6 Apr 2023 08:02:08 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso412743oom.6;
        Thu, 06 Apr 2023 08:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVc8/bAGJqj+ppUY3Ons5mpq5/CyGKqwzdFXHMLxuyo=;
        b=OoqYejOKP7z9qYSmGMs91P8MmZ4tf2CQ5g4CtpjK6dRcIQfGuMT/ptFqHwczrNpI/K
         H4LbROoKByCoTpGDhyj0KJ2sqpXuciRl7VfQgLcy1YFnN4ymAgFh7/3/PV6SsNLi40Wh
         E3LeCksAaUBH5IvrzAl8dtj/nZ/ZVGqjB1YP875LCWtxxYgPuIWziUKBgfy73Z6s5N2G
         WiLLEUEDx4r+Yv9afwAicH+Pbv0M1o/55eO9iW8BtGjzJ1ylCrz9yRVj50CFycc1Wkvw
         e2dSqWJnGOejPrQmLdmCxo5Yd0nUQBDl/lXU+vbGVFFVyXuqjvOfr1HcKXbAKgNr0s3g
         8k9Q==
X-Gm-Message-State: AAQBX9fb0P5yIKInAgXVWpBZ/78QME/Iez5UAxYBXKptQ2kH/WMxsWiO
        KBQ02JlBktUZSXJLpgZvbg==
X-Google-Smtp-Source: AKy350ZBMA2PTTWOcnXOd/S8JXrZnrxTW1zQsidLB6EMMvuKXbyfz4smDokkbjPwFshOcl4aAb2ILQ==
X-Received: by 2002:a4a:378d:0:b0:525:58f7:cbef with SMTP id r135-20020a4a378d000000b0052558f7cbefmr5175366oor.2.1680793327711;
        Thu, 06 Apr 2023 08:02:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w127-20020a4a5d85000000b00525398a1144sm638742ooa.32.2023.04.06.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:02:05 -0700 (PDT)
Received: (nullmailer pid 3087657 invoked by uid 1000);
        Thu, 06 Apr 2023 15:02:04 -0000
Date:   Thu, 6 Apr 2023 10:02:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-clk@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        David Gow <davidgow@google.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v3 03/11] dt-bindings: vendor-prefixes: Add "test" vendor
 for KUnit and friends
Message-ID: <168079332398.3087560.7781936436725334890.robh@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
 <20230327222159.3509818-4-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327222159.3509818-4-sboyd@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Mon, 27 Mar 2023 15:21:51 -0700, Stephen Boyd wrote:
> Add the vendor prefix "test" to reserve a vendor prefix for bindings
> that are purely for testing device tree code. This allows test code to
> write bindings that can be checked by the schema validator.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

