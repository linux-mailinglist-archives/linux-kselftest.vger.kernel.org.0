Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA14F4CEB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbiDEXgG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443055AbiDEPix (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:53 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8F143C7C;
        Tue,  5 Apr 2022 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649166856;
  x=1680702856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WhCHZK9GJJLMq21n9Wjs02V4Hy6iol3pV60QmFhYnXI=;
  b=jOu26AEgH52kLCEHGCDNClrCiuGQsqC0mMbV00LsCQ6D7yvqs5Dp0cZy
   optIlXUGOYK/V04EhtXgmp6AGk/51aFLQeuyzPywOKdv2JKXA+l+F6zE7
   jxHOIV1w+04HJPidE7bujX1V1JGCLkwHL1iXL+GF9c51ejPvh7kJHrDJF
   sWsJXpEG7H3IcBsiHwqDNa1ca2VTQ5eAIIHcwcVTTvxCwHveoCzsrgoBD
   Qg4rKYHk/O7G0KuyvCJLe6mEPgEtYSv+lMmSdwpvvs1oz0dylwi73F+Ak
   1fDOQjfbIzc4yDvOAyiXUKMXCl58iv6V6IbDYllLso+PQ6F552TycWKbq
   w==;
Date:   Tue, 5 Apr 2022 15:54:12 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 01/10] roadtest: import libvhost-user from QEMU
Message-ID: <20220405135412.GB28574@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-2-vincent.whitchurch@axis.com>
 <7f405d8d09a83954aa3411eff8b71ee687c7ec33.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f405d8d09a83954aa3411eff8b71ee687c7ec33.camel@sipsolutions.net>
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

On Thu, Mar 24, 2022 at 02:00:10PM +0100, Johannes Berg wrote:
> On Fri, 2022-03-11 at 17:24 +0100, Vincent Whitchurch wrote:
> > Import the libvhost-user from QEMU for use in the implementation of the
> > virtio devices in the roadtest backend.
> 
> So hm, I wonder if this is the sensible thing to do?
> 
> Not that I mind importing qemu code, but:
> 
>  1) the implementation is rather complex in some places, and has support
>     for a LOT of virtio/vhost-user features that are really not needed
>     in these cases, for performance etc. It's also close to 4k LOC.

Is this really a problem given that the code is imported as-is?  The
intention is not to have to make a lot of local modifications to it in
the kernel tree.  The code is stable and presumably well-tested
upstream, and upstream maintains it as a separate library (in the QEMU
source tree though) to encourage reuse.

>  2) the implementation doesn't support time-travel mode which might come
>     in handy

True, but I don't see the external time-travel controller stuff being
too useful for the kinds of tests this framework is targeting.
