Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8A4B41F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 07:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiBNGYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 01:24:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiBNGYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 01:24:41 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25754E389
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Feb 2022 22:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644819874; x=1676355874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Pvk3lPrntMX0uY2eeOPY/dBiGDlj3REUxSVNgFB0cg=;
  b=DdreKTDhwRxrl3dGjGxPvGls/hYv74daDMKCY1c03QQnFDCAwFp76SYI
   WrhuDBop4KeGykjnDmQRsjsIttsYyy8MfyJg+np8s//2o4em4/Ipu7VoV
   oobYPQjZ6WlTVRim/x+p7D3295z3DT+OzsJ1FUym/bOVtDdvx3liX3fsE
   UePJeFHNiodczZUhBCgTO1Ev8AbLbGt5DEwd/97nyEfLjFxIunO7XKzEG
   uontQIzpdd0SU2m0lm8TUE7xVSBkxToRNNOkDvt3gDjIOKqxPEeI3FJAW
   Hreb1byyHmXR+pAJ2WtMpKudmNrF0fLZEzJZj25OYmFJMoxgXtB9tHjj7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310761122"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="310761122"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:24:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="631946017"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:24:31 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 08:24:28 +0200
Date:   Mon, 14 Feb 2022 08:24:28 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 3/6] thunderbolt: test: use NULL macros
Message-ID: <Ygn1nPpPsM/DDqr1@lahna>
References: <20220211094133.265066-1-ribalda@chromium.org>
 <20220211094133.265066-3-ribalda@chromium.org>
 <YgY1lzA20zyFcVi3@lahna>
 <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
 <YgaOS8BLz23k6JVq@lahna>
 <YgaPXhOr/lFny4IS@lahna>
 <CANiDSCs7M_hSb2njr50_d3z=cx=N9gWHzVe-HkpCV1Au8yVwOw@mail.gmail.com>
 <CAGS_qxp3OHFwK__wCHBGr9cMsLR=gfD2rhjejXcmFNJ276_ciw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxp3OHFwK__wCHBGr9cMsLR=gfD2rhjejXcmFNJ276_ciw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Fri, Feb 11, 2022 at 02:54:37PM -0800, Daniel Latypov wrote:
> On Fri, Feb 11, 2022 at 8:33 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Hi Mika
> >
> > On Fri, 11 Feb 2022 at 17:31, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Fri, Feb 11, 2022 at 06:26:56PM +0200, Mika Westerberg wrote:
> > > > > To test it I had enabled:
> > > > > PCI, USB4 and USB4_KUNIT_TEST
> > > > >
> > > > > and then run it with
> > > > >
> > > > > ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
> > > > >
> > > > > Unfortunately, kunit was not able to run the tests
> > > > >
> > > > > This hack did the trick:
> > > > >
> > > > >
> > > > >  int tb_test_init(void)
> > > > >  {
> > > > > -       return __kunit_test_suites_init(tb_test_suites);
> > > > > +       //return __kunit_test_suites_init(tb_test_suites);
> > > > > +       return 0;
> > > > >  }
> > > > >
> > > > >  void tb_test_exit(void)
> > > > >  {
> > > > > -       return __kunit_test_suites_exit(tb_test_suites);
> > > > > +       //return __kunit_test_suites_exit(tb_test_suites);
> > > > >  }
> > > > > +
> > > > > +kunit_test_suites(&tb_test_suite);
> > > > >
> > > > > I looked into why we do this and I found:
> > > > >
> > > > > thunderbolt: Allow KUnit tests to be built also when CONFIG_USB4=m
> > > > >
> > > > >
> > > > > I am a bit confused. The patch talks about build coverage, but even
> > > > > with that patch reverted if
> > > > > USB4_KUNIT_TEST=m
> > > > > then test.c is built.
> > > > >
> > > > > Shouldn't we simply revert that patch?
> > > >
> > > > Nah, either build it into the kernel or load the driver manually:
> > > >
> > > >   # modprobe thunderbolt
> > >
> > > Forgot to explain why this does not run the tests (I think):
> > >
> > >  ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
> > >
> > > The driver depends on PCI and I don't think that's enabled on UML at
> > > least. I typically run it inside QEMU.
> 
> You can get it working on UML now.
> If you apply the patch upthread for the test to use kunit_test_suites(), then
> 
> $ cat usb4_kunitconfig
> CONFIG_PCI=y
> CONFIG_VIRTIO_UML=y
> CONFIG_UML_PCI_OVER_VIRTIO=y
> 
> CONFIG_KUNIT=y
> CONFIG_USB4=y
> CONFIG_USB4_KUNIT_TEST=y
> 
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=usb4_kunitconfig
> ...
> [14:48:55] [PASSED] tb_test_property_copy
> [14:48:55] =================== [PASSED] thunderbolt ===================
> [14:48:55] ============================================================
> [14:48:55] Testing complete. Passed: 37, Failed: 0, Crashed: 0,
> Skipped: 0, Errors: 0

That's great!

> Mika, should I propose a patch that updates the test and adds a
> drivers/thunderbolt/.kunitconfig with the above contents?
> 
> Then it could be invoked as
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/thunderbolt

Yes please :)
