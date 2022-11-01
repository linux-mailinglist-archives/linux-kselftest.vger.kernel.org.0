Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99C614B00
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 13:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKAMnr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 08:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAMnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 08:43:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D94818E37;
        Tue,  1 Nov 2022 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667306625; x=1698842625;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=447inlpxE5S1idg51FXKxsFvnXhIeN3ynoRElsi9OSg=;
  b=gH7XfP9kx/OIMnvJKRmhLnN4yZdyiPEA/0N1GUFXuU1kIcaqLzgLwYrk
   IGazOLlpXJnF7/ERzuTbSE1TjJ0mxkWaQgVWJvRM/1AzPyvfjOBjkB43V
   rsK1sVPpucOA4qsQ1AJD6MDzfdF8sSU7CjhaErTRYwA+LbzJdxZJ6Nn5i
   D/JT+VklNkkxqZ1+hPS1goOmFuoNxEyoNGY53JTrKjRVkgo1bjGh7AwwU
   hezU5fIrwTa934kQjCD9eesuE2kQyaaFccl/K7p15gEg+jBRBn3cNrHCS
   9s5tK3XLE/x2T6kmJUf3/gXCtUKU8rYup+W+em5EJvFlMLXSRUKMqsfdV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="292429016"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="292429016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 05:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="633861884"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="633861884"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Nov 2022 05:43:44 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.29.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7EF95580AA7;
        Tue,  1 Nov 2022 05:43:37 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:43:34 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Isabella Basso <isabbasso@riseup.net>,
        linux-kselftest@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?UTF-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>,
        n@nfraprado.net, kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com, igt-dev@lists.freedesktop.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Gow <davidgow@google.com>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Trevor Woerner <twoerner@gmail.com>
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility
 for KUnit
Message-ID: <20221101134334.59500e01@maurocar-mobl2>
In-Reply-To: <CAGS_qxpCPTSRNAyejL0gS0pZAoVNp9SdFwPFkHRyn5yMuPGkLw@mail.gmail.com>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-4-isabbasso@riseup.net>
        <CABVgOS=HO9XAf8C5X7ZD6aTW37r06ify==7AW9a8cpKsgLVfFw@mail.gmail.com>
        <D53B4EB1-1A95-48F1-BF49-8EC0CC7B5418@riseup.net>
        <CAGS_qxpCPTSRNAyejL0gS0pZAoVNp9SdFwPFkHRyn5yMuPGkLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 19 Sep 2022 17:25:38 -0700
Daniel Latypov <dlatypov@google.com> wrote:

> On Mon, Sep 19, 2022 at 1:43 PM Isabella Basso <isabbasso@riseup.net> wro=
te:
> > >> +        * "(K)TAP version XX" should be the first line on all (sub)=
tests as per
> > >> +        * https://www.kernel.org/doc/html/latest/dev-tools/ktap.htm=
l#version-lines
> > >> +        * but actually isn't, as it currently depends on whoever wr=
ites the
> > >> +        * test to print this info =20
> > >
> > > FYI: we're really trying to fix cases of "missing version lines",
> > > largely by making the kunit_test_suites() macro work in more
> > > circumstances.
> > >
> > > So while it may be worth still handling the case where this is
> > > missing, I don't think there are any tests in the latest versions of
> > > the kernel which should have this missing. =20
> >
> > I=E2=80=99m not sure if I totally get how these work. Every time I run =
a KUnit test I
> > get something like this: https://pastebin.com/7Ff31PMC
> >
> > As you can see it has been loaded as a module, just like we intend to d=
o it
> > from IGT, and I see no version lines whatsoever. Am I doing something w=
rong? =20
>=20
> You're doing everything right.
>=20
> The problem is we only print the version line for the *built-in* tests.
> It never gets printed for tests in loadable modules.

IGT tests require loadable modules, as some tests check if bind/unbind
and load/unload works. Also, some tests require modprobing drivers
with different parameters.

Unfortunately, kunit.py is currently broken on such cases: its parser
simply ignores everything if the subtest doesn't have a TAP version
just before it. See:

	$ ./tools/testing/kunit/kunit.py parse /var/log/dmesg
	[12:37:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:05] [ERROR] Test: main: 0 tests run!
	[12:37:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:05] Testing complete. Ran 0 tests: errors: 1

Here, I loaded the test module twice. I can force it to parse it by
doing

	$ (dmesg|grep "TAP version"; dmesg|grep -A9999 intel_i915_mock) >logs=20

But then, it gets confused with two subtests with the same name:

	$ ./tools/testing/kunit/kunit.py parse logs
	[12:37:34] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:34] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D intel_i915_mock (18 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:34] [PASSED] sanitycheck
	[12:37:34] [PASSED] shmem
	[12:37:34] [PASSED] fence
	[12:37:34] [PASSED] scatterlist
	[12:37:34] [PASSED] syncmap
	[12:37:34] [PASSED] uncore
	[12:37:34] [PASSED] ring
	[12:37:34] [PASSED] engine
	[12:37:34] [PASSED] timelines
	[12:37:34] [PASSED] requests
	[12:37:34] [PASSED] objects
	[12:37:34] [PASSED] phys
	[12:37:34] [PASSED] dmabuf
	[12:37:34] [PASSED] vma
	[12:37:34] [PASSED] evict
	[12:37:34] [PASSED] gtt
	[12:37:34] [PASSED] hugepages
	[12:37:34] [PASSED] memory_region
	[12:37:34] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] in=
tel_i915_mock =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:34] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D intel_i915_mock (18 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:34] [PASSED] sanitycheck
	[12:37:34] [PASSED] shmem
	[12:37:34] [PASSED] fence
	[12:37:34] [PASSED] scatterlist
	[12:37:34] [PASSED] syncmap
	[12:37:34] [PASSED] uncore
	[12:37:34] [PASSED] ring
	[12:37:34] [PASSED] engine
	[12:37:34] [PASSED] timelines
	[12:37:34] [PASSED] requests
	[12:37:34] [PASSED] objects
	[12:37:34] [PASSED] phys
	[12:37:34] [PASSED] dmabuf
	[12:37:34] [PASSED] vma
	[12:37:34] [PASSED] evict
	[12:37:34] [PASSED] gtt
	[12:37:34] [PASSED] hugepages
	[12:37:34] [PASSED] memory_region
	[12:37:34] [ERROR] Test: intel_i915_mock: Expected test number 2 but found=
 1
	[12:37:34] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] in=
tel_i915_mock =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:34] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[12:37:34] Testing complete. Ran 36 tests: passed: 36, errors: 1

> Some more details below, if interested.
> Specifically, it happens in
> https://elixir.bootlin.com/linux/latest/C/ident/kunit_print_tap_header
>=20
> What David is referring to is we had tests that weren't in modules,
> but didn't use the normal built-in code path. Those were also missing
> TAP version lines.
> But KUnit needs to do better here in the case of modules.
>=20
> The goal was that you'd be able to parse the result of module based
> tests by something like
> $ cat /sys/kernel/debug/kunit/*/results | ./tools/testing/kunit/kunit.py =
parse
> but this doesn't work because of the lack of a version line.

At least here, debug/kunit doesn't exist:

	sudo ls -lctra /sys/kernel/debug/|grep kunit

>=20
> If we add it to each module's test results, then we'll need to update
> the parse to allow multiple verison lines, I think.

Yeah, the parser is currently broken when used with modules.

Regards,
Mauro
