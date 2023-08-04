Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9863676FD58
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHDJdg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 05:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjHDJdc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 05:33:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035754698;
        Fri,  4 Aug 2023 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691141609; x=1722677609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvFrMzhhDrbBL4Q+45OunweAz3Dy/Or5e1XCeyH8IoQ=;
  b=F/yle0iPnwcM5F2Z7R2vVoWDNwh1cr3EkMyxwQiL9nrfk3vppKMb3lXV
   IPCm0/nTdPjcPHJRCE2OUKIu+Ck5s06jFc0dM96fBb5GMHiYsPV+44xBd
   ijk+SyeeI8jP9tA9/3QECJeQ4bruK2iP8EHfm1FmdpEXU7116I4Vuo++o
   M3cUPpffjOnMGrIkHSf75BKXyAQTYO9Zo694wR0gU/KOTGDybniEB1OGx
   Z5uZITW/CXpXxFmnJq5saM8DY/Q0b9mRZcqD9GNm8cBWhGoHTC6r7zR8c
   OdH3YvCN9wp0TxTeIg6t7ER4d+lqBQ7A59/WA9EY/3qjNZ88ynXC0wX2e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436435565"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="436435565"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 02:33:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765038214"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="765038214"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.4.52])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 02:33:27 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Rae Moar <rmoar@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH v3 1/3] kunit: Report the count of test suites in a module
Date:   Fri, 04 Aug 2023 11:33:25 +0200
Message-ID: <1827168.QCnGb9OGeP@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <CA+GJov5G_JWJM3Rw14O-CTioEoB_aTf4SyM-G+tCKEP_txc8yw@mail.gmail.com>
References: <20230731141021.2854827-5-janusz.krzysztofik@linux.intel.com>
 <20230731141021.2854827-6-janusz.krzysztofik@linux.intel.com>
 <CA+GJov5G_JWJM3Rw14O-CTioEoB_aTf4SyM-G+tCKEP_txc8yw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rae,

On Thursday, 3 August 2023 22:57:43 CEST Rae Moar wrote:
> On Mon, Jul 31, 2023 at 10:12=E2=80=AFAM Janusz Krzysztofik
> <janusz.krzysztofik@linux.intel.com> wrote:
> >
> > According to KTAP specification[1], results should always start from a
> > header that provides a TAP protocol version, followed by a test plan wi=
th
> > a count of items to be executed.  That pattern should be followed at ea=
ch
> > nesting level.  In the current implementation of the top-most, i.e., te=
st
> > suite level, those rules apply only for test suites built into the kern=
el,
> > executed and reported on boot.  Results submitted to dmesg from kunit t=
est
> > modules loaded later are missing those top-level headers.
> >
> > As a consequence, if a kunit test module provides more than one test su=
ite
> > then, without the top level test plan, external tools that are parsing
> > dmesg for kunit test output are not able to tell how many test suites
> > should be expected and whether to continue parsing after complete output
> > from the first test suite is collected.
> >
> > Submit the top-level headers also from the kunit test module notifier
> > initialization callback.
> >
> > [1] https://docs.kernel.org/dev-tools/ktap.html#
> >
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > ---
>=20
> Hi!
>=20
> I think this is a really great idea to improve the KTAP compatibility
> for module output. I do agree with Mauro and I wonder if this could be
> replaced with using kunit_exec_run_tests. However, if the output of
> 1..0 for a module with no KUnit tests run is not wanted,=20

I do believe we really don't want that.  As soon as kunit framework registe=
rs=20
its notifier callbacks, those callbacks are executed by generic module=20
handling code on load / unload of every module, not only those providing ku=
nit=20
tests.  If our module initialization callback called unmodified=20
kunit_exec_run_tests() that deliberately prints these two lines=20
unconditionally:

	KTAP version 1
	1..n

then there would be a lot of unnecessary noise.

To avoid that noise, I decided to teach the callback itself to display the=
=20
header with the number of test suits provided by the module before processi=
ng=20
them if there is at least one, and be silent otherwise.  But since both you=
=20
and Mauro think that kunit_exec_run_tests() should be reused, I can do that=
 by=20
moving that logic to kunit_exec_run_tests() and passing an additional flag=
=20
that controls that logic from kunit_module_init() to kunit_exec_run_tests()=
=2E =20
Would that approach be more acceptable?

> I am ok with
> this change as is.
>=20
> LGTM.
>=20
> Tested-by: Rae Moar <rmoar@google.com>

Thank you for testing.

Janusz

>=20
> -Rae
>=20
> >  lib/kunit/test.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 84e4666555c94..a29ca1acc4d81 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -729,6 +729,11 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
> >  #ifdef CONFIG_MODULES
> >  static void kunit_module_init(struct module *mod)
> >  {
> > +       if (mod->num_kunit_suites > 0) {
> > +               pr_info("KTAP version 1\n");
> > +               pr_info("1..%d\n", mod->num_kunit_suites);
> > +       }
> > +
> >         __kunit_test_suites_init(mod->kunit_suites, mod-
>num_kunit_suites);
> >  }
> >
> > --
> > 2.41.0
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps=20
"KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an=20
email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/
msgid/kunit-dev/20230731141021.2854827-6-janusz.krzysztofik%40linux.intel.c=
om.
>=20




