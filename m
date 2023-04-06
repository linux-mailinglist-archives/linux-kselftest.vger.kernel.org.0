Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF86D9B8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbjDFPCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbjDFPCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 11:02:33 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553876A4D;
        Thu,  6 Apr 2023 08:02:29 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso19655999ote.5;
        Thu, 06 Apr 2023 08:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793348; x=1683385348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXauuPv7V6nw+K9y9u87hFBrUqj41ptimlsFpxUoa10=;
        b=w5r7nNOPbdeTMjYURqVwCGxeOFiB4bqwh/ONpgKY8/+jllP4WewsM3GPY7N2ikNvpG
         rHpcSYzD0Vyw35m7FUfhk7ZUAMwKQ5lzEXWmhIzGxi5ZIJZ9Wog1BbWnFfGHWokCElJp
         P5lhQhZTL/uTP89Oyp96eN6+A17jRAUTGp69Qt7cJm9np+eLSSCeFTT7vT0CWwIR2P2D
         28arqcpJOulcMRw3IAUdN3Oyf9ObZi7SRvcIsco5F2cX0IvF0Byopurr5Re6kdhuh+QZ
         3t+x4QW3ImQw/br4vHQgFbVLUdMr2J3uZMPLS6InMGPX672Hi6F/uXco+hXgou7Fp3as
         M35w==
X-Gm-Message-State: AAQBX9dIHrizhvgmQ4n8NLQeftQjxWwURK/D2Gi+OO6GuTpVf7rNYa21
        tpofcqKjnnV+w1wVGJg85A==
X-Google-Smtp-Source: AKy350aqLbkPGLuk0tZbMl6/7gxaMb4Wnliyi44lmNq2flfn3WT1JRPb2J8aVsK5oJaoCreTyhBzjQ==
X-Received: by 2002:a9d:6d08:0:b0:69b:c852:4ab8 with SMTP id o8-20020a9d6d08000000b0069bc8524ab8mr3229642otp.7.1680793348236;
        Thu, 06 Apr 2023 08:02:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006a2ce5f3641sm782361otl.8.2023.04.06.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:02:27 -0700 (PDT)
Received: (nullmailer pid 3090444 invoked by uid 1000);
        Thu, 06 Apr 2023 15:02:26 -0000
Date:   Thu, 6 Apr 2023 10:02:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        kunit-dev@googlegroups.com, patches@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 04/11] dt-bindings: test: Add KUnit empty node binding
Message-ID: <168079334653.3090275.1222113248015102076.robh@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
 <20230327222159.3509818-5-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327222159.3509818-5-sboyd@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Mon, 27 Mar 2023 15:21:52 -0700, Stephen Boyd wrote:
> Describe a binding for an empty device node used by KUnit tests to
> confirm overlays load properly.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  .../devicetree/bindings/test/test,empty.yaml  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/test/test,empty.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

