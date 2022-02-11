Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F04B2A3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiBKQ1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:27:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiBKQ1L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:27:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A013AD
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644596830; x=1676132830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8mSkdvRvdONqiVDLhrnVLSsz7zzR6KgAaymp8SQetgg=;
  b=dBePyj7iCK+MfnC5DkTao6FGubogAjI0CNZsP0URDeP6whFRbkoS0Lbd
   pl/qABUWoIXo7PANRJ/UEj0ySFKQKSxulHR+bdGcX5Z4tdz9ceDx6eM9c
   jBItSVreuVpQl37FlypI67QR0dkwz5slcUXTk8CJAekorJqrrTnUpIPH5
   5DtcnPGZAGVUhNUmGkVhsqQ+DrCsh8EFW0UzsP8iuNXB3OMZIiRe3F+r6
   wKM3d85J2qto7ecIwHV/gcrenEi+UHXJdLX1k2NmvwDXJL6sJcBE0QOC9
   n1u/tDv9ye3w43vLs27pqAU97dESs38Wz0as7Yo6/IqZhKRLOLL/DTAWb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274318558"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="274318558"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:26:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="586395242"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:26:53 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Feb 2022 18:26:51 +0200
Date:   Fri, 11 Feb 2022 18:26:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v5 3/6] thunderbolt: test: use NULL macros
Message-ID: <YgaOS8BLz23k6JVq@lahna>
References: <20220211094133.265066-1-ribalda@chromium.org>
 <20220211094133.265066-3-ribalda@chromium.org>
 <YgY1lzA20zyFcVi3@lahna>
 <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 04:49:21PM +0100, Ricardo Ribalda wrote:
> Hi Mika
> 
> On Fri, 11 Feb 2022 at 11:08, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Fri, Feb 11, 2022 at 10:41:30AM +0100, Ricardo Ribalda wrote:
> > > Replace the NULL checks with the more specific and idiomatic NULL macros.
> > >
> > > Acked-by: Daniel Latypov <dlatypov@google.com>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> >
> > ...
> >
> > > @@ -2496,50 +2496,50 @@ static void tb_test_property_parse(struct kunit *test)
> > >       struct tb_property *p;
> > >
> > >       dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
> > > -     KUNIT_ASSERT_TRUE(test, dir != NULL);
> > > +     KUNIT_ASSERT_NOT_NULL(test, dir);
> > >
> > >       p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
> > > -     KUNIT_ASSERT_TRUE(test, !p);
> > > +     KUNIT_ASSERT_NOT_NULL(test, p);
> >
> > This should be KUNIT_ASSERT_NULL(test, p) as we specifically want to
> > check that the property does not exist (!p is same as p == NULL).
> >
> > >       p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_TEXT);
> > > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > > +     KUNIT_ASSERT_NOT_NULL(test, p);
> > >       KUNIT_EXPECT_STREQ(test, p->value.text, "Apple Inc.");
> > >
> > >       p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
> > > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > > +     KUNIT_ASSERT_NOT_NULL(test, p);
> > >       KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
> > >
> > >       p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
> > > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > > +     KUNIT_ASSERT_NOT_NULL(test, p);
> > >       KUNIT_EXPECT_STREQ(test, p->value.text, "Macintosh");
> > >
> > >       p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
> > > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > > +     KUNIT_ASSERT_NOT_NULL(test, p);
> > >       KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
> > >
> > >       p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
> > > -     KUNIT_ASSERT_TRUE(test, !p);
> > > +     KUNIT_ASSERT_NOT_NULL(test, p);
> >
> > Ditto here.
> >
> > With those fixed (please also run the tests if possible to see that they
> > still pass) you can add,
> >
> 
> Thanks!
> 
> To test it I had enabled:
> PCI, USB4 and USB4_KUNIT_TEST
> 
> and then run it with
> 
> ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
> 
> Unfortunately, kunit was not able to run the tests
> 
> This hack did the trick:
> 
> 
>  int tb_test_init(void)
>  {
> -       return __kunit_test_suites_init(tb_test_suites);
> +       //return __kunit_test_suites_init(tb_test_suites);
> +       return 0;
>  }
> 
>  void tb_test_exit(void)
>  {
> -       return __kunit_test_suites_exit(tb_test_suites);
> +       //return __kunit_test_suites_exit(tb_test_suites);
>  }
> +
> +kunit_test_suites(&tb_test_suite);
> 
> I looked into why we do this and I found:
> 
> thunderbolt: Allow KUnit tests to be built also when CONFIG_USB4=m
> 
> 
> I am a bit confused. The patch talks about build coverage, but even
> with that patch reverted if
> USB4_KUNIT_TEST=m
> then test.c is built.
> 
> Shouldn't we simply revert that patch?

Nah, either build it into the kernel or load the driver manually:

  # modprobe thunderbolt
