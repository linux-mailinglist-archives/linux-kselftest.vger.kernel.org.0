Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CDA6B126A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCHTtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 14:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCHTtA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 14:49:00 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0145AB4E;
        Wed,  8 Mar 2023 11:48:17 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1763e201bb4so19981973fac.1;
        Wed, 08 Mar 2023 11:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678304814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT0BopLRAw7O6/s7NS3/6EbNSMOzkcqRVPXIOE/BbPs=;
        b=XpJs6TqzAZtKRJrENPxRX64lgzeOpP8XhZdk4oDV4VzUaSJg73bewQ0GX01Daywib3
         kQh+kro7MAujIBO1UOgYrJ69eF6r1jArcMeI+zo26eCbnX3/QVA7DhgAIgJpfymQQyit
         ufzmt/888m3AboKJYqfKwx7X28JeVwaQOTGwUg51VTBrt9dBUI7PBzylTTd+KWcPfgds
         EN8CE/hiyoIEKTII3rFDyPsENHYuu9CeFo+WdJeDfYbfGJvXBERCpmEBPX/oqKQ1/8GL
         bZESVbvE+8hK5ddRcLChxWHVWIlNwJnpaQmsQLEjm+uxVDv9X8oGP/E3SHR3CVhnU3W+
         KYmg==
X-Gm-Message-State: AO0yUKXg4FMAVC0PPpb5oRnPf+LgvBwo+1sO8v0JmjcysTNHZpwJ04+q
        X0rGP1ILtjiSgYhcBY7Liw==
X-Google-Smtp-Source: AK7set/j69mw8inZZ60owmutAs5i9vfN2brcSq4YY56sDxw/VEkhHwLkVFpgj9QDwqIthGRi/b/kpg==
X-Received: by 2002:a05:6870:5490:b0:16e:84c5:7496 with SMTP id f16-20020a056870549000b0016e84c57496mr10085909oan.11.1678304814169;
        Wed, 08 Mar 2023 11:46:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq41-20020a0568718ea900b0017703cd8ff6sm1904577oab.7.2023.03.08.11.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:46:53 -0800 (PST)
Received: (nullmailer pid 3665063 invoked by uid 1000);
        Wed, 08 Mar 2023 19:46:52 -0000
Date:   Wed, 8 Mar 2023 13:46:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
Message-ID: <20230308194652.GA3656473-robh@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <20230302013822.1808711-3-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302013822.1808711-3-sboyd@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 01, 2023 at 05:38:15PM -0800, Stephen Boyd wrote:
> To fully exercise common clk framework code in KUnit we need to
> associate 'struct device' pointers with 'struct device_node' pointers so
> that things like clk_get() can parse DT nodes for 'clocks' and so that
> clk providers can use DT to provide clks; the most common mode of
> operation for clk providers.
> 
> Adding support to KUnit so that it loads a DTB is fairly simple after
> commit b31297f04e86 ("um: Add devicetree support"). We can simply pass a
> pre-compiled deviectree blob (DTB) on the kunit.py commandline and UML
> will load it. The problem is that tests won't know that the commandline
> has been modified, nor that a DTB has been loaded. Take a different
> approach so that tests can skip if a DTB hasn't been loaded.
> 
> Reuse the Makefile logic from the OF unittests to build a DTB into the
> kernel. This DTB will be for the mythical machine "linux,kunit", i.e.
> the devicetree for the KUnit "board". In practice, it is a dtsi file
> that will gather includes for kunit tests that rely in part on a
> devicetree being loaded. The devicetree should only be loaded if
> CONFIG_OF_KUNIT=y. Make that a choice config parallel to the existing
> CONFIG_OF_UNITTEST so that only one devicetree can be loaded in the
> system at a time. Similarly, the kernel commandline option to load a
> DTB is ignored if CONFIG_OF_KUNIT is enabled so that only one DTB is
> loaded at a time.
> 
> Add a simple unit test to confirm that the DTB loading worked. Future
> tests will add to the kunit.dtsi file to include their specific test
> nodes.
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/um/kernel/dtb.c            | 29 +++++++++++++++--
>  drivers/of/Kconfig              | 26 ++++++++++++++++
>  drivers/of/Makefile             |  1 +
>  drivers/of/kunit/.kunitconfig   |  4 +++
>  drivers/of/kunit/Makefile       |  4 +++
>  drivers/of/kunit/kunit.dtsi     |  8 +++++
>  drivers/of/kunit/kunit.dtso     |  4 +++
>  drivers/of/kunit/uml_dtb_test.c | 55 +++++++++++++++++++++++++++++++++
>  8 files changed, 128 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/of/kunit/.kunitconfig
>  create mode 100644 drivers/of/kunit/Makefile
>  create mode 100644 drivers/of/kunit/kunit.dtsi
>  create mode 100644 drivers/of/kunit/kunit.dtso
>  create mode 100644 drivers/of/kunit/uml_dtb_test.c
> 
> diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
> index 484141b06938..ee63951b12df 100644
> --- a/arch/um/kernel/dtb.c
> +++ b/arch/um/kernel/dtb.c
> @@ -15,9 +15,32 @@ void uml_dtb_init(void)
>  	long long size;
>  	void *area;
>  
> -	area = uml_load_file(dtb, &size);
> -	if (!area)
> -		return;
> +	if (IS_ENABLED(CONFIG_OF_KUNIT)) {
> +		/*
> +		 * __dtbo_kunit_begin[] and __dtbo_kunit_end[] are magically
> +		 * created by cmd_dt_S_dtbo in scripts/Makefile.lib from the
> +		 * drivers/of/kunit/kunit.dtsi file.
> +		 */
> +		extern uint8_t __dtbo_kunit_begin[];
> +		extern uint8_t __dtbo_kunit_end[];
> +
> +		size = __dtbo_kunit_end - __dtbo_kunit_begin;
> +		if (!size) {
> +			pr_warn("%s: kunit testcases is empty\n", __func__);
> +			return;
> +		}
> +
> +		/* creating copy */
> +		area = memblock_alloc(size, 8);
> +		if (!area)
> +			return;
> +
> +		memcpy(area, __dtbo_kunit_begin, size);
> +	} else {
> +		area = uml_load_file(dtb, &size);
> +		if (!area)
> +			return;
> +	}
>  
>  	if (!early_init_dt_scan(area)) {
>  		pr_err("invalid DTB %s\n", dtb);
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 80b5fd44ab1c..1f968b6a3dde 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -12,6 +12,20 @@ menuconfig OF
>  
>  if OF
>  
> +choice

No. This needs to be reworked such that a kernel rebuild is not needed 
to run different tests. I suspect that the overlay approach will do that 
for you.

> +	prompt "Devicetree Runtime Tests"
> +	default OF_UNITTEST
> +
> +config OF_KUNIT
> +	bool "Devicetree KUnit support" if KUNIT
> +	depends on UML

This is not a great dependency either...

Rob
