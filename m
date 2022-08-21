Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22259B579
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiHUQkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiHUQkC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 12:40:02 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB072186C3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 09:39:59 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 36E7530F40D;
        Sun, 21 Aug 2022 18:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661099997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btYU0hY8FQEp2zkTFhPT21xYKh/ZrlHIaS3DTYBgHhk=;
        b=v/U9Uirf+4zpQTGdFbZWMp2SD96Q5Enw+AAp2oiyq//MlT5f5u+viebdwcHvmncoMsJsj+
        mjUA5L8J1kRQF6POcwxLQIRovTYSoR3IOn6aKc4azPaO/sk2T9uAw41K1lgsWErLKmAbCJ
        hC+JSxEXBABuQzVSHiR2c1tUooAeogaFO4dXNgIqabxG0OyThAimRJkMZkn+vxseVh+s0l
        mDaaMA9t10wKjfgkfh0YYX/+1xIj87jk8WBlCeWXnDooK8T4Tch3YSh4j/mnkRZEUqLMgn
        oaCQuT/N4/RRAwUEIsTk4zfAOEYmx+8nCZi2CNbH44qY876Av0nwQ7VrckEy+w==
Message-ID: <100b2b54ff0839d4ddff70d43d5efa6d04300a78.camel@svanheule.net>
Subject: Re: [PATCH v2 4/5] lib/cpumask_kunit: log mask contents
From:   Sander Vanheule <sander@svanheule.net>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Aug 2022 18:39:53 +0200
In-Reply-To: <b791c1ce-dd81-f864-dfe2-962ad5ac5d41@riseup.net>
References: <cover.1661007338.git.sander@svanheule.net>
         <98cb4e5323c2059506e93cb39c32ba471031e487.1661007339.git.sander@svanheule.net>
         <YwFWHj0p/Uc0njme@yury-laptop>
         <49f6eaa7e8586e4eba39d636ef034fc1626e3bc2.camel@svanheule.net>
         <b791c1ce-dd81-f864-dfe2-962ad5ac5d41@riseup.net>
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

Hi Ma=C3=ADra,

On Sun, 2022-08-21 at 11:02 -0300, Ma=C3=ADra Canal wrote:
>=20
>=20
> On 8/21/22 10:13, Sander Vanheule wrote:
> > On Sat, 2022-08-20 at 14:46 -0700, Yury Norov wrote:
> > > On Sat, Aug 20, 2022 at 05:03:12PM +0200, Sander Vanheule wrote:
> > > > For extra context, log the contents of the masks under test.=C2=A0 =
This
> > > > should help with finding out why a certain test fails.
> > > >=20
> > > > Link:
> > > > https://lore.kernel.org/lkml/CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ix=
ojymZF=3DVi4tpQ@mail.gmail.com/
> > > > Suggested-by: David Gow <davidgow@google.com>
> > > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > > > Reviewed-by: David Gow <davidgow@google.com>
> > > > ---
> > > > =C2=A0lib/cpumask_kunit.c | 10 ++++++++++
> > > > =C2=A01 file changed, 10 insertions(+)
> > > >=20
> > > > diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
> > > > index 4d353614d853..0f8059a5e93b 100644
> > > > --- a/lib/cpumask_kunit.c
> > > > +++ b/lib/cpumask_kunit.c
> > > > @@ -51,6 +51,10 @@
> > > > =C2=A0static cpumask_t mask_empty;
> > > > =C2=A0static cpumask_t mask_all;
> > > > =C2=A0
> > > > +#define STR_MASK(m)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
#m
> > > > +#define TEST_CPUMASK_PRINT(test, mask)=C2=A0\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_info(test, "%s =3D=
 '%*pbl'\n", STR_MASK(mask),
> > > > nr_cpumask_bits,
> > > > cpumask_bits(mask))
> > > > +
> > > > =C2=A0static void test_cpumask_weight(struct kunit *test)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_TRUE(t=
est, cpumask_empty(&mask_empty));
> > > > @@ -103,6 +107,9 @@ static void test_cpumask_iterators_builtin(stru=
ct
> > > > kunit
> > > > *test)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Ensure the dynam=
ic masks are stable while running the tests
> > > > */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu_hotplug_disable=
();
> > > > =C2=A0
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test,=
 cpu_online_mask);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test,=
 cpu_present_mask);
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU=
_BUILTIN_EQ(test, online);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXPECT_FOR_EACH_CPU=
_BUILTIN_EQ(test, present);
> > > > =C2=A0
> > > > @@ -114,6 +121,9 @@ static int test_cpumask_init(struct kunit *test=
)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpumask_clear(&mask=
_empty);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpumask_setall(&mas=
k_all);
> > > > =C2=A0
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test,=
 &mask_all);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TEST_CPUMASK_PRINT(test,=
 cpu_possible_mask);
> > > > +
> > >=20
> > > It sort of breaks the rule of silence. Can you make this print condit=
ional
> > > on a test failure? If everything is OK, who wants to look into detail=
s?=20
> >=20
> > I will change the macros to the _MSG versions, and log the mask there.
> >=20
> > I implemented this with kunit_info() as David proposed. AFAICT I can't =
call=20
> > kunit_info() only when the test fails, because the EXPECT_ macros don't
> > return
> > any result.
>=20
> Maybe you can use KUNIT_EXPECT_EQ_MSG to print a more detailed error and
> avoid printing the info when the test doesn't fail.

Yes, this is what I currently have for use with the _MSG() variants of the
macros:

+#define MASK_MSG(m)                    \
+       "%s contains %sCPUs %*pbl", #m, (cpumask_weight(m) ? "" : "no "), n=
r_cpumask_bits, cpumask_bits(m)
+

For example, with (bogus) KUNIT_EXPECT_TRUE_MSG(test, ..., MASK_MSG(mask)) =
this
becomes (trimmed):

$ ./tools/testing/kunit/kunit.py run  --build_dir=3Dbuild-um cpumask
[...]
[18:15:33] # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask_kunit.c=
:60
[18:15:33] Expected cpumask_empty(((struct cpumask *)(1 ? (cpu_all_bits) : =
(void *)sizeof(__check_is_bitmap(cpu_all_bits))))) to be true, but is false
[18:15:33]=20
[18:15:33] cpu_all_mask contains CPUs 0
[18:15:33] # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask_kunit.c=
:61
[18:15:33] Expected cpumask_full(&mask_empty) to be true, but is false
[18:15:33]=20
[18:15:33] &mask_empty contains no CPUs
[18:15:33] not ok 1 - test_cpumask_weight
[18:15:33] [FAILED] test_cpumask_weight
[...]

Or on a real system:
[    1.246805]     # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask=
_kunit.c:59
[    1.246805]     Expected cpumask_empty(((struct cpumask *)(1 ? (cpu_all_=
bits) : (void *)sizeof(__check_is_bitmap(cpu_all_bits))))) to be true, but =
is false
[    1.246805]=20
[    1.246805] cpu_all_mask contains CPUs 0-1
[    1.249756]     not ok 1 - test_cpumask_weight

I will send an updated series tomorrow, in case David or others have more m=
ore comments.

Best,
Sander
