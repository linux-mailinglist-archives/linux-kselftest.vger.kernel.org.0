Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78DD6D9A8B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjDFOhx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjDFOhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 10:37:41 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B8BDD8;
        Thu,  6 Apr 2023 07:35:28 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-183f4efa98aso1472442fac.2;
        Thu, 06 Apr 2023 07:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXDlqaghZBjXgA0NY19GPZNJThwtj3XENjKUz55y22o=;
        b=2vBC9p03X6mj/2hMtXggWy4nbCnffg3+ntCGqE55cvBqhafmaRW6CkWsmFvqgvIonO
         EzRz2IXEILlEB/rZmG0k/wZRbxbRwaCzupivZuxamb2u/GcSz0xEp6RTZfMwwCgEDBs6
         7eOrXC9G0BcbF7zpBfNT7EW1DLRzH4iXXcB6N66PMEXU9jiyeSPVbZlCn6jteF5yDxwc
         7kmTFm1q3HIORB5ARmb3CECJ95hlaFo+KX2+R1RvbBVHDhTb7U0ibtCw/gshwit9afFe
         lF/uuRLr/jJtfhlHrMEJjPH3mPkyJ8uRhGRkOVwQ+RDaTJvGSTDlO6xMJDC6d+OYm8oT
         YRJQ==
X-Gm-Message-State: AAQBX9eCc5met2OjN0qG3MeEvMwOMSNeEkcadXUSqidSZdsPcnY6PuoR
        kdgoxIWM4fJkcFOYZlUjew==
X-Google-Smtp-Source: AKy350ZCYG3gr3sW4VveqNyY6bipIYXv8tUa2i2axB2wuzwFS916oDDGB8n9GEfOAKcJhYwRJufQ2g==
X-Received: by 2002:a05:6870:d10b:b0:177:b62d:cc20 with SMTP id e11-20020a056870d10b00b00177b62dcc20mr5204205oac.25.1680791715952;
        Thu, 06 Apr 2023 07:35:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h17-20020a9d7991000000b0069dd3d98ec6sm750727otm.44.2023.04.06.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:35:15 -0700 (PDT)
Received: (nullmailer pid 3056260 invoked by uid 1000);
        Thu, 06 Apr 2023 14:35:14 -0000
Date:   Thu, 6 Apr 2023 09:35:14 -0500
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
Subject: Re: [PATCH v3 02/11] of: Add test managed wrappers for
 of_overlay_apply()/of_node_put()
Message-ID: <20230406143514.GA3036886-robh@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
 <20230327222159.3509818-3-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327222159.3509818-3-sboyd@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 03:21:50PM -0700, Stephen Boyd wrote:
> Add test managed wrappers for of_overlay_apply() that automatically
> removes the overlay when the test is finished. This API is intended for
> use by KUnit tests that test code which relies on 'struct device_node's
> and of_*() APIs.
> 
> KUnit tests will call of_overlay_apply_kunit() to load an overlay that's
> been built into the kernel image. When the test is complete, the overlay
> will be removed.

What if one wants to test the removal part itself?

Rob
