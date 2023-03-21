Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D77D6C38FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCUSP2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUSP1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 14:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E308A7E;
        Tue, 21 Mar 2023 11:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 931F361D98;
        Tue, 21 Mar 2023 18:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBAAC433D2;
        Tue, 21 Mar 2023 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679422522;
        bh=hIOq5dDkrg3sXzDPPJvDRD1aVZ39RpNjhbDlFV9Te8Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VXR6MyBIQLcC8YRSmkoxYqeuBl0N5nxmb5pljge76AYMMBt06x6XPyEkUfUq8+CgE
         /UJvLCkPg1ufseDOQ7g3lE3e3koPsvUqBsGzDRfdtt+NbCNebgoNN0vwd1PzHQH9Zg
         BQrraxC6CKNk1e7Du3u3NXpB76OASsBLcXNWL46DRFeyNGMLfDicYrLoJZ2pYa8Y1d
         Dc2c3nZvtgVhwcVngiUik37zhPF+BmQR+xLwN9sUCHA+FtI6n/vBkdhzO1Pt6uFssT
         EcrtKrFlFeRFrijmpiuLlvkMCoL4tBk3K/EFXtEALyRKDXU7bqniMG8dPLroz8GaZn
         VAuDCcjT/fhgw==
Message-ID: <12903a61f64206be837c1f0744632f29.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321173303.GA950598-robh@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org> <20230315183729.2376178-2-sboyd@kernel.org> <20230321173303.GA950598-robh@kernel.org>
Subject: Re: [PATCH v2 01/11] of: Load KUnit DTB from of_core_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Date:   Tue, 21 Mar 2023 11:15:19 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Rob Herring (2023-03-21 10:33:03)
> On Wed, Mar 15, 2023 at 11:37:18AM -0700, Stephen Boyd wrote:
> > diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
> > new file mode 100644
> > index 000000000000..a4d70ac344ad
> > --- /dev/null
> > +++ b/drivers/of/of_test.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit tests for OF APIs
> > + */
> > +#include <linux/kconfig.h>
> > +#include <linux/of.h>
> > +
> > +#include <kunit/test.h>
> > +
> > +/*
> > + * Test that the root node / exists.
> > + */
> > +static void dtb_root_node_exists(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/"));
> > +}
> > +
> > +/*
> > + * Test that the /__symbols__ node exists.
> > + */
> > +static void dtb_symbols_node_exists(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/__symbo=
ls__"));
> > +}
>=20
> Many base DTs will not have this. And the kunit tests themselves=20
> shouldn't need it because they should be independent of the base tree.
>=20

When I try to apply an overlay it fails=20

 OF: overlay: no fragments or symbols in overlay
 OF: overlay: init_overlay_changeset() failed, ret =3D -22
     # of_overlay_apply_kunit_apply: ASSERTION FAILED at drivers/of/overlay=
_test.c:18
     Expected 0 =3D=3D ({ extern uint8_t __dtbo_kunit_overlay_test_begin[];=
 extern uint8_t __dtbo_kunit_overlay_test_end[]; __of_overlay_apply_kunit((=
test), __dtbo_kunit_overlay_test_begin, __dtbo_kunit_overlay_test_end); }),=
 but
         ({ extern uint8_t __dtbo_kunit_overlay_test_begin[]; extern uint8_=
t __dtbo_kunit_overlay_test_end[]; __of_overlay_apply_kunit((test), __dtbo_=
kunit_overlay_test_begin, __dtbo_kunit_overlay_test_end); }) =3D=3D -12 (0x=
fffffffffffffff4)
 [FAILED] of_overlay_apply_kunit_apply

Now I'm trying to hack on the fake root node to see if I can make it work.

---8<---
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 090c5d7925e4..12c44c86b8ae 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -166,7 +166,7 @@ void __of_phandle_cache_inv_entry(phandle handle)
 		phandle_cache[handle_hash] =3D NULL;
 }
=20
-#ifdef CONFIG_OF_KUNIT
+#if 0
 static int __init of_kunit_add_data(void)
 {
 	void *kunit_fdt;
diff --git a/drivers/of/kunit_overlay_test.dtso b/drivers/of/kunit_overlay_=
test.dtso
index 6e70e2f8cd90..e3ced1467dd9 100644
--- a/drivers/of/kunit_overlay_test.dtso
+++ b/drivers/of/kunit_overlay_test.dtso
@@ -2,7 +2,7 @@
 /dts-v1/;
 /plugin/;
=20
-&kunit_bus {
+/ {
 	test-kunit {
 		compatible =3D "test,kunit-empty";
 	};
diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
index 543fdf0936f6..08b670aee083 100644
--- a/drivers/of/of_test.c
+++ b/drivers/of/of_test.c
@@ -15,17 +15,8 @@ static void dtb_root_node_exists(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/"));
 }
=20
-/*
- * Test that the /__symbols__ node exists.
- */
-static void dtb_symbols_node_exists(struct kunit *test)
-{
-	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/__symbols__"));
-}
-
 static struct kunit_case dtb_test_cases[] =3D {
 	KUNIT_CASE(dtb_root_node_exists),
-	KUNIT_CASE(dtb_symbols_node_exists),
 	{}
 };
