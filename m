Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE47E6C4877
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 12:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCVLDK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 07:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCVLDJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 07:03:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223619C7E;
        Wed, 22 Mar 2023 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679482988; x=1711018988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wjvnemr7K7GxTkw8tU1ZW+8hQE4iFHIRWuoX+ttiHQY=;
  b=DGbqoLjvtO/GhREmaL/15LgxnD4iK8taC5hTB+5Zgzu+j7t4utuhjAjr
   Ye7KhlULQ5ch4Z2MCPIb1ohore7ceqx63qC/IZPTX1qBLHs3dHB+pZbbI
   J9RUCvwSA9UPn+OajZmFu7Ydw8zgVKA/vzJt4QHIv49GeAecpzP0wNdKc
   1MN8hEOhUAWRnP1PieZKJ90Xai27BrTuL48Wzclz2yArCn9OUpMBrYw4G
   URDg1narBsxBX0Yzq8X9I+1wGA7xwxhngm9VBJDrd3JLSNvBw36zkK6+h
   AwWgaMXSibs+W6yYpuU7G5tJuC7Y287Y+BqBMt+LrIzmSfI0hk+IK6N9Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="327564765"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="327564765"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 04:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="681856602"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="681856602"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 04:02:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pewF4-0076sm-1u;
        Wed, 22 Mar 2023 13:02:54 +0200
Date:   Wed, 22 Mar 2023 13:02:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Maxime Ripard <mripard@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        Stephen Boyd <sboyd@kernel.org>, Emma Anholt <emma@anholt.net>,
        Liam Beguin <liambeguin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Gow <davidgow@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Airlie <airlied@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/8] Support ROHM BU27034 ALS sensor
Message-ID: <ZBrgXgJ8AooUSRVW@smile.fi.intel.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <ZBrSCYp+QrHK47dS@smile.fi.intel.com>
 <87edphnkg1.fsf@minerva.mail-host-address-is-not-set>
 <8fe9fea1-b7b8-ee46-9534-de7e2b1726f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe9fea1-b7b8-ee46-9534-de7e2b1726f9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 22, 2023 at 12:59:33PM +0200, Matti Vaittinen wrote:
> On 3/22/23 12:34, Javier Martinez Canillas wrote:
> > > On Wed, Mar 22, 2023 at 11:05:23AM +0200, Matti Vaittinen wrote:

...

> > > > - copy code from DRM test helper instead of moving it to simplify
> > > >    merging
> > > 
> > > 1) Why do you think this is a problem?
> > > 2) How would we avoid spreading more copies of the same code in the future?
> > > 
> > > 
> > > 1) Merge conflicts is not a bad thing. It shows that people tested their code
> > > in isolation and stabilized it before submitting to the upper maintainer.
> > > 
> > > https://yarchive.net/comp/linux/git_merges_from_upstream.html
> > > 
> > > 2) Spreading the same code when we _know_ this, should be very well justified.
> > > Merge conflict is an administrative point, and not a technical obstacle to
> > > avoid.
> 
> I definitely agree. This is also why I did the renaming and not copying in
> the first version. In this version I did still add the subsequent patch 2/8
> - which drops the duplicates from DRM tree.
> 
> > I believe this was suggested by Maxime and the rationale is that by just
> > copying the helpers for now, that would make it easier to land instead of
> > requiring coordination between different subystems.
> 
> This is correct.
> 
> > Otherwise the IIO tree will need to provide an inmutable branch for the
> > DRM tree to merge and so on.
> 
> Or, if we carry the patch 1/8 via self-test tree, then we get even more
> players here.
> 
> Still, I am not opposing immutable branch because that would allow fast
> applying of the patch 2/8 as well. Longer that is delayed, more likely we
> will see more users of the DRM helpers and harder it gets to remove the
> duplicates later.
> 
> > I agree with Maxime that a little bit of duplication (that can be cleaned
> > up by each subsystem at their own pace) is the path of least resistance.
> 
> I'd say this depends. It probably is the path of least resistance for people
> maintaining the trees. It can also be the path of least resistance in
> general - but it depends on if there will be no new users for those DRM
> helpers while waiting the new APIs being merged in DRM tree. More users we
> see in DRM, more effort the clean-up requires.
> 
> I have no strong opinion on this specific case. I'd just be happy to see the
> IIO tests getting in preferably sooner than later - although 'soon' and
> 'late' does also depend on other factors besides these helpers...

Since I'm not a maintainer of either, and one of them requires something,
I can't oppose.

-- 
With Best Regards,
Andy Shevchenko


