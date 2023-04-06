Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0196D9B92
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbjDFPDJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 11:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbjDFPDJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 11:03:09 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0269EE8;
        Thu,  6 Apr 2023 08:02:53 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17786581fe1so42607708fac.10;
        Thu, 06 Apr 2023 08:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp1soVVgJyw7DnWbzvcH5jF90UmIZzV8nwXox1Hq290=;
        b=s7ntz7VxPQ5Ywn7puNbzIRAU5U2VD5GsL7Xu+FH91u7vNI1NSJeESFM5Be4NVgA+fH
         WGHctQdMGZpkX/45mrUylQRWkC5PjcHQtSHlzZgM54gv10zWv3PL7GUyN8c5mJLSaH54
         1tbyQXIjDe53wfT7d3ydsHRIjsmzj1p/5s287YlHw28W0ebJjFW4rkcZlKpwSAxHt6vv
         K3ImF1HZhJmRF+h9sZ+9FnqQpVIkoZ5GbX+f/UoZ16imXYWtXoDrqY4LDLg8YAbiuYIq
         q0T5HuAP/GJ0dfAS/lDlhNft5tnE5TpsruMTZNuxw47nmAcgL/0dN2se8vukckCeOvJh
         icmA==
X-Gm-Message-State: AAQBX9fmh5ameTDNHwtpf3bfIC/6u2vKHU3SdC3uP1Wn9DHBBmxnTtbV
        UEPkoHVTd+1ZMYiIcKInGA==
X-Google-Smtp-Source: AKy350bG6JhGJke1pSMmP0FQ4u2Wm3qy4H0yHiRyJP2owCnbwM5OJZWiY+LLo5dEFcfAHuQILcINEg==
X-Received: by 2002:a05:6870:9622:b0:177:9b62:6b87 with SMTP id d34-20020a056870962200b001779b626b87mr5747647oaq.20.1680793372513;
        Thu, 06 Apr 2023 08:02:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e24-20020a05683013d800b006a3842a32b6sm785254otq.42.2023.04.06.08.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:02:51 -0700 (PDT)
Received: (nullmailer pid 3092563 invoked by uid 1000);
        Thu, 06 Apr 2023 15:02:50 -0000
Date:   Thu, 6 Apr 2023 10:02:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kunit-dev@googlegroups.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kselftest@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v3 07/11] dt-bindings: kunit: Add fixed rate clk consumer
 test
Message-ID: <168079336912.3092485.14820569065582293049.robh@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
 <20230327222159.3509818-8-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327222159.3509818-8-sboyd@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Mon, 27 Mar 2023 15:21:55 -0700, Stephen Boyd wrote:
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
>  .../bindings/test/test,clk-fixed-rate.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

