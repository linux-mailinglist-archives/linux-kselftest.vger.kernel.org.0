Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B976C372
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 05:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjHBDSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 23:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjHBDSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 23:18:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631031713;
        Tue,  1 Aug 2023 20:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690946322; x=1722482322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9NCM2C6plWYZlTWDXnxmxP68QKs4h7xrJfHjoOpKpzc=;
  b=HKVScfi42mwgsATJUFTdoEF/d8ysJsHLoXgzwBGEilbCqHr8C50FUEwC
   TPHKYD4tlYU6dfr8TU/vVnv6JOOMXOCKgV3bM+G8Kc4JzN6LPWObPfOkZ
   0hLXJuFBXKISsCaX0ZJXXXdRMLrFAlRJWqyPJKDYobKJ0pmH5S15GP3oe
   hBWEw87tZpOkDuux4fB6w5WXxMOZbHUvwdOP7lTIbs5uVTElHFqY1y55T
   l2OZvigm/JmLckZ7RZRBL30rjWtYzsLI29xD5ZfjCPydP17Ux/fWcWx6J
   YF1KT2e3eRUrBkWQyfgrk+S2TvcDBiQkhoM5nZzG9W+RVoQIhc292UsGl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349773127"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="349773127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 20:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794424914"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="794424914"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 20:18:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qR2Nd-00ExOt-1i;
        Wed, 02 Aug 2023 06:18:33 +0300
Date:   Wed, 2 Aug 2023 06:18:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/4] kernel.h: Split out COUNT_ARGS() and
 CONCATENATE() to args.h
Message-ID: <ZMnLCSsY83IphIrv@smile.fi.intel.com>
References: <20230718211147.18647-2-andriy.shevchenko@linux.intel.com>
 <20230801211139.GA51676@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801211139.GA51676@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 04:11:39PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 19, 2023 at 12:11:44AM +0300, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> > without need of the full kernel.h dependency train with it.
> > 
> > Here is the attempt on cleaning it up by splitting out these macros().
> > 
> > While at it, include new header where it's being used.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI

Thank you!

...

> > -
> > +#include <linux/args.h>
> >  #include <linux/mod_devicetable.h>
> >  
> >  #include <linux/types.h>
> 
> If there's not a reason otherwise, I'd put this in the main list
> instead of the weirdly separated mod_devicetable.h.

The idea is to make them alphabetically ordered. currently even main list
is a mess. And I have no idea why mod_devicetable.h is so special, a few
bus headers (e.g., i2c, spi) consider that just as yet another header while
actually ain't using it (in the respective _headers_).

That said, I would take the sorting change as a separate one that can be
done after this.

-- 
With Best Regards,
Andy Shevchenko


