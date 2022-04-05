Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC94F4CFB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352378AbiDEXgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443917AbiDEPk2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:28 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3ED14DFE5;
        Tue,  5 Apr 2022 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649167344;
  x=1680703344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Quhq+ANDcyqCuN52eIRgLzLh2IoR3G+Ogb7BY7KkCbE=;
  b=JfWw2js+sHio6dbd67N4f+BKvGcgXqC+jL6zGIBTKIXzryvcIE7qzxyL
   fAQhMiRTFUrAJ9Wa9Uqfp6pjIffGUKwtBeQ6kq96gPt0Rcx4I/SQa6+tq
   /4wesHmr64EULkm16LIV+z66YSSuwmFC/PzXL8EuTqLIbViL5BoPaBUqM
   MtOqJqtCNazap6UZeRrAMa2IfhYQDY98cmlHqo9nrqZ99WVlsnTUi5tsv
   ZAz3dFApD9DyI+D9oPjtyKzsvhacBT2JvmJ8EVp/x4TIpKfI2wC/zqp6Y
   037kX7KxN0Pk+KkpeKGXDQrZUbxYVdVVHYyPgtan+kxbYXgNOylSg7HWN
   g==;
Date:   Tue, 5 Apr 2022 16:02:21 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        <devicetree@vger.kernel.org>, <linux-um@lists.infradead.org>,
        <shuah@kernel.org>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <lgirdwood@gmail.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 09/10] regulator: tps62864: add roadtest
Message-ID: <20220405140221.GC28574@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-10-vincent.whitchurch@axis.com>
 <YiuPvkQroV/WdFpx@sirena.org.uk>
 <20220317151326.GA7832@axis.com>
 <YjN1ksNGujV611Ka@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YjN1ksNGujV611Ka@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 17, 2022 at 05:53:22PM +0000, Mark Brown wrote:
> On Thu, Mar 17, 2022 at 04:13:26PM +0100, Vincent Whitchurch wrote:
> > On Fri, Mar 11, 2022 at 06:06:54PM +0000, Mark Brown wrote:
> 
> > > > +    @classmethod
> > > > +    def setUpClass(cls) -> None:
> > > > +        insmod("tps6286x-regulator")
> 
> > > Shouldn't this get figured out when the device gets created in DT (if it
> > > doesn't I guess the tests found a bug...)?
> 
> > The system isn't set up to load modules automatically.  The reason for
> > this is to give the test cases full control of when the module is loaded
> > and unload, since the tests could want to load the module with specific
> > options.
> 
> That seems like the uncommon case which could remove the module if it
> explicitly needed it.

Another reason was to get the tests to test module unloading since I've
seen a lot of especially new driver writers forget to test that, but I
realise that for most normal drivers that should be mostly covered by
the fact that we test device unbinding.

So I went ahead and implemented this and it seems to work.  As you
hinted earlier, this also means that the modalias stuff gets tested, and
as we know that's been broken in the recent past for a bunch of drivers,
so that's another advantage to automatic module loading, besides the
boilerplate reduction in the tests.
