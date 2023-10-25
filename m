Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E627D6689
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjJYJR0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjJYJRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 05:17:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD1181;
        Wed, 25 Oct 2023 02:17:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC42EC433C7;
        Wed, 25 Oct 2023 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698225442;
        bh=SQKdM/Kxu04h1c8FbFA9IJo9KecIQs7DTttOwbPdWUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6umIJieOSUHChlY+IijtgaGmlGx3wekwa6Uu5S1+5yivcZn7/BF0BA+5elFjJNDe
         voG0wWuWiysAY2i6u5gxdj5MGckjeATvIs9LnfF2ETpEdC2oKvYt9xGdCq2JO9mrES
         MwHOKBVTpXV8An6kqxtwoypKHyVWtTZ10Pltdr/Yz9Ru4IfBRiGmz3+FS/7gkN8iW1
         6Dov2iNdPybyWJyB9q+tBCyQ63fAacFwLqKv2ntjAQrQYFRyjOcPFvZLicylPoixLa
         GI2sQco4vZ0dvvrZN4Edm4SoL8kF1RTFNZpoSqBmxZkZLHF4N/ss+3pYk5ZN7mbuGc
         +N1RZLqx937Bg==
Date:   Wed, 25 Oct 2023 11:17:19 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Rae Moar <rmoar@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit: Warn if tests are slow
Message-ID: <7nhmlcn3bbe3ey5tw43umsahjei3fisyxxp3vhf34lsi5s4wkr@qpp4bsdv4wom>
References: <20230920084903.1522728-1-mripard@kernel.org>
 <CA+GJov6YQ2YcfqudffKzAKmcwbgCvuXpd8HzKnwSuytF-ozvww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="re4ceqeclcsd5wjq"
Content-Disposition: inline
In-Reply-To: <CA+GJov6YQ2YcfqudffKzAKmcwbgCvuXpd8HzKnwSuytF-ozvww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--re4ceqeclcsd5wjq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rae,

On Tue, Oct 24, 2023 at 03:41:33PM -0400, Rae Moar wrote:
> On Wed, Sep 20, 2023 at 4:49=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > Kunit recently gained support to setup attributes, the first one being
> > the speed of a given test, then allowing to filter out slow tests.
> >
> > A slow test is defined in the documentation as taking more than one
> > second. There's an another speed attribute called "super slow" but whose
> > definition is less clear.
> >
> > Add support to the test runner to check the test execution time, and
> > report tests that should be marked as slow but aren't.
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> >
>=20
> Hello!
>=20
> Thanks for following up! Sorry for the delay in this response.

np, I kind of forgot about it too to be fair :)

> This looks great to me. I do have one comment below regarding the
> KUNIT_SPEED_SLOW_THRESHOLD_S macro but other than that I would be
> happy with this patch.
>=20
> This patch does bring up the question of how to handle KUnit warnings
> as mentioned before. But I am happy to approach that in a future
> patch.
>
> And I do still have concerns with this being annoying for those on
> slower architectures but again that would depend on how we deal with
> KUnit warnings.

Yeah, I agree there

> > To: Brendan Higgins <brendan.higgins@linux.dev>
> > To: David Gow <davidgow@google.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-kernel@vger.kernel.org
> >
> > Changes from v1:
> > - Split the patch out of the series
> > - Change to trigger the warning only if the runtime is twice the
> >   threshold (Jani, Rae)
> > - Split the speed check into a separate function (Rae)
> > - Link: https://lore.kernel.org/all/20230911-kms-slow-tests-v1-0-d3800a=
69a1a1@kernel.org/
> > ---
> >  lib/kunit/test.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 49698a168437..a1d5dd2bf87d 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -372,6 +372,25 @@ void kunit_init_test(struct kunit *test, const cha=
r *name, char *log)
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_init_test);
> >
> > +#define KUNIT_SPEED_SLOW_THRESHOLD_S   1
> > +
> > +static void kunit_run_case_check_speed(struct kunit *test,
> > +                                      struct kunit_case *test_case,
> > +                                      struct timespec64 duration)
> > +{
> > +       enum kunit_speed speed =3D test_case->attr.speed;
> > +
> > +       if (duration.tv_sec < (2 * KUNIT_SPEED_SLOW_THRESHOLD_S))
>=20
> I think I would prefer that KUNIT_SPEED_SLOW_THRESHOLD_S is instead
> set to 2 rather than using 2 as the multiplier. I realize the actual
> threshold for the attributes is 1 sec but for the practical use of
> this warning it is 2 sec.

Right. So I kind of disagree here. To me, the define should match the
definition we have for a slow test. We chose to report it only if it
exceeds it by a margin, but that's a separate thing from the actual
threshold.

I guess I could add a new version to make that distinction clearer.
Would that work for you?

Maxime

--re4ceqeclcsd5wjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZTjdHwAKCRDj7w1vZxhR
xTdtAQD0p4cQm0zUoPf24k74/8nRBRRg4MM1MIick9LeHTrQqQD/fmHItzqlVDea
tpzEFOtAAZg64NPAvfUr4OqoLeuxIAY=
=MNhh
-----END PGP SIGNATURE-----

--re4ceqeclcsd5wjq--
