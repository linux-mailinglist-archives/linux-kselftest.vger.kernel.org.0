Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1D59B3E9
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 15:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiHUN2B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiHUN17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 09:27:59 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5E1EADF
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 06:27:58 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 2143530F327;
        Sun, 21 Aug 2022 15:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661088477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vvsu5VPNuHA39zj3/LpeneZN62u/9ZSx0U+NwaMKuhs=;
        b=jQhs/igJ9gB/XJnu8JrKd49u/9IiXhQegyGvjj/zMkqyMBEIEb0eqHglov/+9J/rVQuV9W
        pZ3kKkjP4sNHT+mfE4dsDQKd98o8ebcNrqBp7QiOaekWy51cnDzc6gvUkIK7svY8/Ch0sZ
        1NE0LUrdu6qxlja1MvTSsMs+U66rwXHxX0mfn8mVz+1TyBDvZJhgmfQ6lyeixGk1bXxD6n
        Lzd0v2YCY3IGiczeP6aLAt1c9hDv4fVW49VPNOk2O6q/BcO+ZJJGWRtVfZjfxo1FhiOlMV
        OcPuW+6wRCt5KljOmgAUkbr9t1xDYb7yzOUqPs4wwmHu3wo9Ur0rvnN+WAtn5Q==
Message-ID: <84564f0f7db4a58ab7cd5314685ca2413c1d7081.camel@svanheule.net>
Subject: Re: [PATCH v2 1/5] lib/test_cpumask: drop cpu_possible_mask full
 test
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 21 Aug 2022 15:27:56 +0200
In-Reply-To: <CAAH8bW9yZUMn2shYAB1LaDyzgFMYtWCRUXxq=bMCiFys=gzKig@mail.gmail.com>
References: <cover.1661007338.git.sander@svanheule.net>
         <6dfd4d3a4d77f97f13ab3f22bc53c96c38ba908e.1661007339.git.sander@svanheule.net>
         <YwFToOOFKsr/mL7X@yury-laptop>
         <9f28529005867512105182f8fa2b0f7b0d14b30d.camel@svanheule.net>
         <CAAH8bW9yZUMn2shYAB1LaDyzgFMYtWCRUXxq=bMCiFys=gzKig@mail.gmail.com>
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

Replying back in plaintext, as you sent an HTML message.

On Sun, 2022-08-21 at 09:18 -0400, Yury Norov wrote:
>=20
>=20
> On Sun, Aug 21, 2022, 09:08 Sander Vanheule <sander@svanheule.net> wrote:
> > Hi Yury,
> >=20
> > On Sat, 2022-08-20 at 14:35 -0700, Yury Norov wrote:
> > > On Sat, Aug 20, 2022 at 05:03:09PM +0200, Sander Vanheule wrote:
> > > > When the number of CPUs that can possibly be brought online is know=
n at
> > > > boot time, e.g. when HOTPLUG is disabled, nr_cpu_ids may be smaller=
 than
> > > > NR_CPUS. In that case, cpu_possible_mask would not be completely fi=
lled,
> > > > and cpumask_full(cpu_possible_mask) can return false for valid syst=
em
> > > > configurations.
> > >=20
> > > It doesn't mean we can just give up. You can check validity of possib=
le
> > > cpumask like this:=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_EQ(test, nr_c=
pu_ids, cpumask_first_zero(&mask_all))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_EQ(test, NR_C=
PUS, cpumask_first(&mask_all))
> >=20
> > Did you mean cpu_possible_mask, or mask_all?
>=20
> cpu_possble_as of curse.
>=20
> > For cpu_possible_mask, these tests are in test_cpumask_first(), albeit =
under
> > a
> > slightly different form. Together with the tests in test_cpumask_weight=
()
> > and
> > test_cpumask_last(), cpu_possible_mask is already one of the more
> > constrained
> > masks.
> >=20
> >=20
> > For mask_all, the mask is filled up with nr_cpumask_bits <=3D NR_CPUS. =
I could
> > add
> > cpumask_first(), cpumask_first_zero(), and cpumask_last() tests though.
> >=20
> > More tests could be also added for cpu_all_mask, since this does have a=
ll
> > NR_CPUS bits set, but I think that belongs in a separate patch.
> >=20
> > I think the extra mask_all and cpu_all_mask test are out of scope for t=
his
> > patch, but they could be added in another patch (for 6.1).
>=20
> If you think that possible mask is tested by other parts, then can you no=
tice
> that in comments?

Sure, I'll update the commit message to note the other constraints on
cpu_possible_mask.

Best,
Sander

