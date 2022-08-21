Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016ED59B3D4
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiHUNIq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 09:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHUNIp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 09:08:45 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE153E0C8
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 06:08:38 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 84C9230F30D;
        Sun, 21 Aug 2022 15:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661087316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjhSlZPk0mEuD8Fpe39Gjeez86YTbyIidGAdgcUUEDI=;
        b=QSPUd/az8VzLjaK/XtMtlnrwqhU71MYB2nfTW317knMoxmV3OZFSBOH1Br5UMEOR34bshQ
        IZHsZvw0yT0xUEb+VSwPN55OGKN8IjP+iZ8ut42PPU63UE1wKq0omrmUwVs7+yEgplGlIu
        JZ62JzAU4oKgvfQqX/51PxAH2QRYHyze3ZBWgH5po32Zr2b3MeuBz89G0yox8SuAwb1p9U
        J+j39raaKN4WRwH8im5hmUa3lyzJWpboc156e97L/XxzUFW9J3g/ESwes2nYnEvsYWJC2q
        jiYDhXevvwzbYuPKVhwikNU5tb8L99TXMsIlwqfHXPwbiit6IN8DcHMxGOiwng==
Message-ID: <9f28529005867512105182f8fa2b0f7b0d14b30d.camel@svanheule.net>
Subject: Re: [PATCH v2 1/5] lib/test_cpumask: drop cpu_possible_mask full
 test
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Aug 2022 15:08:33 +0200
In-Reply-To: <YwFToOOFKsr/mL7X@yury-laptop>
References: <cover.1661007338.git.sander@svanheule.net>
         <6dfd4d3a4d77f97f13ab3f22bc53c96c38ba908e.1661007339.git.sander@svanheule.net>
         <YwFToOOFKsr/mL7X@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yury,

On Sat, 2022-08-20 at 14:35 -0700, Yury Norov wrote:
> On Sat, Aug 20, 2022 at 05:03:09PM +0200, Sander Vanheule wrote:
> > When the number of CPUs that can possibly be brought online is known at
> > boot time, e.g. when HOTPLUG is disabled, nr_cpu_ids may be smaller tha=
n
> > NR_CPUS. In that case, cpu_possible_mask would not be completely filled=
,
> > and cpumask_full(cpu_possible_mask) can return false for valid system
> > configurations.
>=20
> It doesn't mean we can just give up. You can check validity of possible
> cpumask like this:=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_EQ(test, nr_cpu_i=
ds, cpumask_first_zero(&mask_all))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_EQ(test, NR_CPUS,=
 cpumask_first(&mask_all))

Did you mean cpu_possible_mask, or mask_all?

For cpu_possible_mask, these tests are in test_cpumask_first(), albeit unde=
r a
slightly different form. Together with the tests in test_cpumask_weight() a=
nd
test_cpumask_last(), cpu_possible_mask is already one of the more constrain=
ed
masks.

For mask_all, the mask is filled up with nr_cpumask_bits <=3D NR_CPUS. I co=
uld add
cpumask_first(), cpumask_first_zero(), and cpumask_last() tests though.

More tests could be also added for cpu_all_mask, since this does have all
NR_CPUS bits set, but I think that belongs in a separate patch.

I think the extra mask_all and cpu_all_mask test are out of scope for this
patch, but they could be added in another patch (for 6.1).

Best,
Sander

> =C2=A0
> > Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> > Link:
> > https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseu=
p.net/
> > Reported-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > Tested-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > Reviewed-by: David Gow <davidgow@google.com>
> > ---
> > Changes in v2:
> > Rewrite commit message to explain why this test is wrong
> >=20
> > =C2=A0lib/test_cpumask.c | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> > index a31a1622f1f6..4ebf9f5805f3 100644
> > --- a/lib/test_cpumask.c
> > +++ b/lib/test_cpumask.c
> > @@ -54,7 +54,6 @@ static cpumask_t mask_all;
> > =C2=A0static void test_cpumask_weight(struct kunit *test)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(test,=
 cpumask_empty(&mask_empty));
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(test, cpum=
ask_full(cpu_possible_mask));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(test,=
 cpumask_full(&mask_all));
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_EQ(test, 0=
, cpumask_weight(&mask_empty));
> > --=20
> > 2.37.2

