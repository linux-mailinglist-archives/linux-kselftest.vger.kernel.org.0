Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F07560E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGQKu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 06:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGQKu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 06:50:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88BA11F;
        Mon, 17 Jul 2023 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689591055; x=1721127055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8akH87XGHxEQ+Klpl4CglFI+YpNF0AZeGW6h5QLXyM=;
  b=UmVxvExJkcruVf4OVKaT0iWJNodZM0p5BsMZyA5v6aDMUnb23n5vd+vw
   MvvNW2ijuQuOguVCVdT3qCvHipD8wdkQf0FAZu3wCBPmlwJeOBel8E1fn
   6GMjZYoCTdtbfeQoEbO1p4VUqkxaW9R7CSzSPvx6XtVi1ONHw0LQzi2ad
   ZfY29fydoXvBgDG6XZ0hFBUh/DdzTOSfacHETCtoDFVYhPx9EWRXXndR9
   YNlprHnzkG1lNTE3V1Q+Iw+9bYKb7+SvB7q2w+sJ8PtqVRAIZQ+VMJqzp
   JyghPjojbx0NtfbSHVOHQ8szpzGcSKF1gDAeiOXfqQAVDeKAeGeenNQl/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="345489480"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345489480"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 03:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="813274237"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="813274237"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 03:50:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLLoU-00ALzI-2u;
        Mon, 17 Jul 2023 13:50:46 +0300
Date:   Mon, 17 Jul 2023 13:50:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/1] kernel.h: Split out COUNT_ARGS() and
 CONCATENATE() to args.h
Message-ID: <ZLUdBka2tldmBqaL@smile.fi.intel.com>
References: <20230714142237.21836-1-andriy.shevchenko@linux.intel.com>
 <20230714115542.b5373a8dc80ba996338ee753@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714115542.b5373a8dc80ba996338ee753@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 14, 2023 at 11:55:42AM -0700, Andrew Morton wrote:
> On Fri, 14 Jul 2023 17:22:37 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> > without need of the full kernel.h dependency train with it.
> > 
> > Here is the attempt on cleaning it up by splitting out these macros().
> > 
> > While at it, include new header where it's being used and drop custom
> > implementation of these macros and document how it works.
> 
> This blows up my x86_64 allmodconfig build, starting with

Oh, don't know how I missed to grep for that.
Thank you, now I'm reproducing this on my side.
I think I will split this to a few patches in v3,
so we can see better if anything happens.

-- 
With Best Regards,
Andy Shevchenko


