Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE94B2A71
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiBKQbu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:31:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351545AbiBKQbt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:31:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89618CCD
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644597108; x=1676133108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ooxdsiAJhFzkbvf3X/hwmQQoIcHZqssXqLEPbjTxy8=;
  b=hZLzUAvkdeU91dxIxuBZ99e0YvNRJlwdxHU7xQ2bZt7VRyWCrBM3JMUr
   mSg+dotSoIaRma29uVEhBSSWAYqnAQLyTBLaVZYaoxhjWYOE626v4wr53
   1TC10+AdfBex4V/ZX7rVo0b91vhMkr/B5OIhiZvFE5nbFZavXkBM+TqBt
   Qu6npHNBDDGnncw17IbHbuvmEDSXSidhnqgA3Qd1XtQkZ7mxy2yUYWd5f
   Xl5ATcOHyU0SS1BF+lGiQcicSkObIBnWShIMzwX59+8uzTtID9/RS3BtE
   zzUJv6eCMuOw6FpM6ArZfl/K8EV0rCA5918HaUgrSt0LC3XNJCz/1i1VC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="249510068"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249510068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:31:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="623262525"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:31:28 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Feb 2022 18:31:26 +0200
Date:   Fri, 11 Feb 2022 18:31:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v5 3/6] thunderbolt: test: use NULL macros
Message-ID: <YgaPXhOr/lFny4IS@lahna>
References: <20220211094133.265066-1-ribalda@chromium.org>
 <20220211094133.265066-3-ribalda@chromium.org>
 <YgY1lzA20zyFcVi3@lahna>
 <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
 <YgaOS8BLz23k6JVq@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgaOS8BLz23k6JVq@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 06:26:56PM +0200, Mika Westerberg wrote:
> > To test it I had enabled:
> > PCI, USB4 and USB4_KUNIT_TEST
> > 
> > and then run it with
> > 
> > ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
> > 
> > Unfortunately, kunit was not able to run the tests
> > 
> > This hack did the trick:
> > 
> > 
> >  int tb_test_init(void)
> >  {
> > -       return __kunit_test_suites_init(tb_test_suites);
> > +       //return __kunit_test_suites_init(tb_test_suites);
> > +       return 0;
> >  }
> > 
> >  void tb_test_exit(void)
> >  {
> > -       return __kunit_test_suites_exit(tb_test_suites);
> > +       //return __kunit_test_suites_exit(tb_test_suites);
> >  }
> > +
> > +kunit_test_suites(&tb_test_suite);
> > 
> > I looked into why we do this and I found:
> > 
> > thunderbolt: Allow KUnit tests to be built also when CONFIG_USB4=m
> > 
> > 
> > I am a bit confused. The patch talks about build coverage, but even
> > with that patch reverted if
> > USB4_KUNIT_TEST=m
> > then test.c is built.
> > 
> > Shouldn't we simply revert that patch?
> 
> Nah, either build it into the kernel or load the driver manually:
> 
>   # modprobe thunderbolt

Forgot to explain why this does not run the tests (I think):

 ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64

The driver depends on PCI and I don't think that's enabled on UML at
least. I typically run it inside QEMU.
