Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347B859B3DB
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiHUNOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHUNNz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 09:13:55 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2B213FB1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 06:13:53 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id D40DF30F314;
        Sun, 21 Aug 2022 15:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661087632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+oJ3L/GYfylbABHpUOk0rPeIZEP6r/zgvfXP3eerkk=;
        b=JL2hcrTet+K3ferK2xvUEY/ihBHCJr8NAJ9DLPQEcJeTSy19/019i0G3WLBEkOxFwX9uX/
        K6YSdMCCTyiwTNq6tG/pc3XMrODgbHQ4ATgUAmrJWu5+ZnuqCBBjj7r9vNBLUZZBoaFGx7
        7H/GKE2FFMQTVzYDRZBqzIGas27qSmqITFCtLrxKpUksuJSOcWXdFWfPTCYU0m1tzz0GBY
        wmxuydneNW5/oMWxC4CHdX5xmG7q2XAhZ19R2LjeclXDfDJb7hkoLl7uABi5d64EajK8ge
        c9NLejEsBz659Yc2SBSI0FA/zdpD2UI56klLCgxeTU4HowRlh65PmioXdiIhXw==
Message-ID: <49f6eaa7e8586e4eba39d636ef034fc1626e3bc2.camel@svanheule.net>
Subject: Re: [PATCH v2 4/5] lib/cpumask_kunit: log mask contents
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Aug 2022 15:13:50 +0200
In-Reply-To: <YwFWHj0p/Uc0njme@yury-laptop>
References: <cover.1661007338.git.sander@svanheule.net>
         <98cb4e5323c2059506e93cb39c32ba471031e487.1661007339.git.sander@svanheule.net>
         <YwFWHj0p/Uc0njme@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 2022-08-20 at 14:46 -0700, Yury Norov wrote:
> On Sat, Aug 20, 2022 at 05:03:12PM +0200, Sander Vanheule wrote:
> > For extra context, log the contents of the masks under test.=C2=A0 This
> > should help with finding out why a certain test fails.
> >=20
> > Link:
> > https://lore.kernel.org/lkml/CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojym=
ZF=3DVi4tpQ@mail.gmail.com/
> > Suggested-by: David Gow <davidgow@google.com>
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > Reviewed-by: David Gow <davidgow@google.com>
> > ---
> > =C2=A0lib/cpumask_kunit.c | 10 ++++++++++
> > =C2=A01 file changed, 10 insertions(+)
> >=20
> > diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
> > index 4d353614d853..0f8059a5e93b 100644
> > --- a/lib/cpumask_kunit.c
> > +++ b/lib/cpumask_kunit.c
> > @@ -51,6 +51,10 @@
> > =C2=A0static cpumask_t mask_empty;
> > =C2=A0static cpumask_t mask_all;
> > =C2=A0
> > +#define STR_MASK(m)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#m
> > +#define TEST_CPUMASK_PRINT(test, mask)=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_info(test, "%s =3D '%*=
pbl'\n", STR_MASK(mask), nr_cpumask_bits,
> > cpumask_bits(mask))
> > +
> > =C2=A0static void test_cpumask_weight(struct kunit *test)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(test,=
 cpumask_empty(&mask_empty));
> > @@ -103,6 +107,9 @@ static void test_cpumask_iterators_builtin(struct k=
unit
> > *test)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Ensure the dynamic m=
asks are stable while running the tests */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu_hotplug_disable();
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test, cpu=
_online_mask);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test, cpu=
_present_mask);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_BUI=
LTIN_EQ(test, online);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU_BUI=
LTIN_EQ(test, present);
> > =C2=A0
> > @@ -114,6 +121,9 @@ static int test_cpumask_init(struct kunit *test)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpumask_clear(&mask_emp=
ty);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpumask_setall(&mask_al=
l);
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test, &ma=
sk_all);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test, cpu=
_possible_mask);
> > +
>=20
> It sort of breaks the rule of silence. Can you make this print conditiona=
l
> on a test failure? If everything is OK, who wants to look into details?=
=20

I will change the macros to the _MSG versions, and log the mask there.

I implemented this with kunit_info() as David proposed. AFAICT I can't call=
=20
kunit_info() only when the test fails, because the EXPECT_ macros don't ret=
urn
any result.

Best,
Sander

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.37.2

