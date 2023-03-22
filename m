Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBCD6C4722
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 11:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCVKCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCVKCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 06:02:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627995073E;
        Wed, 22 Mar 2023 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679479322; x=1711015322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/pDjDAGBcg5WhI+AQMf4x0J3VeVkUcdJvmTMh6YlXI=;
  b=h9KN667D9P1rjP6kl/StBDHidxPIvXCZrgUxr0ecYyE+NtWnnKNKn1DL
   ZeUKop+uy31Ya8He6g+mvKKYsBDdWa5V0cw3PLkUijxJuWTkE737HK5XD
   PaMHK8cYnC+VQ5E/ENcVvG5ze68OLvFv7yMBikfTnZUKgN2L3GXu9CwpV
   UwvEo1K+hhKHhqZ46OHzQFcMj2vZkNlmAdR1T12wSvOoCrWbEe5wTn491
   nnLhPmf5i8yfcNCkvFWwueYPYFI6zbiYk5+7MmfqTCuMzpNdUTFsZH3YS
   3ZNUWSxcG+6krgiQjNWQcPWm17Ed0IWMS+PIp+5FMMVA8NNKcpSGW2uH8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="339214454"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="339214454"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 03:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="750975537"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="750975537"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2023 03:01:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pevHt-0075cJ-2t;
        Wed, 22 Mar 2023 12:01:45 +0200
Date:   Wed, 22 Mar 2023 12:01:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Emma Anholt <emma@anholt.net>,
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
Message-ID: <ZBrSCYp+QrHK47dS@smile.fi.intel.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679474247.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 22, 2023 at 11:05:23AM +0200, Matti Vaittinen wrote:

> Revision history:
> v4 => v5: Mostly fixes to review comments from Andy and Jonathan.
> - more accurate change-log in individual patches

> - copy code from DRM test helper instead of moving it to simplify
>   merging

1) Why do you think this is a problem?
2) How would we avoid spreading more copies of the same code in the future?


1) Merge conflicts is not a bad thing. It shows that people tested their code
in isolation and stabilized it before submitting to the upper maintainer.

https://yarchive.net/comp/linux/git_merges_from_upstream.html

2) Spreading the same code when we _know_ this, should be very well justified.
Merge conflict is an administrative point, and not a technical obstacle to
avoid.

> - document all exported GTS helpers.
> - inline a few GTS helpers
> - use again Milli lux for the bu27034 with RAW IIO_LIGHT channel and scale
> - Fix bug from added in v4 bu27034 time setting.

-- 
With Best Regards,
Andy Shevchenko


