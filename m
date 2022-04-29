Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F745148A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiD2L5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbiD2L5w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 07:57:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B1C6F11;
        Fri, 29 Apr 2022 04:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651233274; x=1682769274;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=38JrCG0dh2dEg8Gd6TkOx2upqz1MJEebkwpL+x8ixzk=;
  b=T9zK6zCkifNpmKMLxaaAp5LiPgMYiKJGjzpzdVbquGE+d4Err0vZnSyV
   Bq+voGu+necml8LHSN7eHPrvKlFiP7Hz5XbFE05Opj+iP3ie87f2mldQn
   f0W7I4+VczmBxErucAuQ0WYOUnts2buUFIobHoRb3UVCShxD/LzaiJ7fE
   af3g1jJBRqcdngk572TIpjjG7VdZGB9T4weQ0hY/pDlitH2qqX6AtGDev
   ejUV5iD9pkMKk2cnMFLJ9N9Lj7iBun+7Dc9k5vKfOpQ++LpK4ljWo9GEB
   EknYOSdLNhwm0P4xxdb1rE1WXayMv7bl1YV2q+i9PrflPQmTo/8XHBYzv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="353055089"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="353055089"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:54:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="732026698"
Received: from agerasym-mobl.ger.corp.intel.com (HELO localhost) ([10.249.133.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:54:28 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Taint kernel if any tests run
In-Reply-To: <YmvO3RoY1JqrR1pu@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220429043913.626647-1-davidgow@google.com>
 <YmuPFGrkzQYACgK0@kroah.com> <87tuacrv7t.fsf@intel.com>
 <YmvO3RoY1JqrR1pu@kroah.com>
Date:   Fri, 29 Apr 2022 14:54:25 +0300
Message-ID: <87o80krtou.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 29 Apr 2022, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 29, 2022 at 02:21:26PM +0300, Jani Nikula wrote:
>> On Fri, 29 Apr 2022, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Fri, Apr 29, 2022 at 12:39:14PM +0800, David Gow wrote:
>> >> KUnit tests are not supposed to run on production systems: they may do
>> >> deliberately illegal things to trigger errors, and have security
>> >> implications (assertions will often deliberately leak kernel addresses).
>> >> 
>> >> Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
>> >> run. This will be printed as 'N' (for kuNit, as K, U and T were already
>> >> taken).
>> >> 
>> >> This should discourage people from running KUnit tests on production
>> >> systems, and to make it easier to tell if tests have been run
>> >> accidentally (by loading the wrong configuration, etc.)
>> >> 
>> >> Signed-off-by: David Gow <davidgow@google.com>
>> >> ---
>> >> 
>> >> This is something I'd been thinking about for a while, and it came up
>> >> again, so I'm finally giving it a go.
>> >> 
>> >> Two notes:
>> >> - I decided to add a new type of taint, as none of the existing ones
>> >>   really seemed to fit. We could live with considering KUnit tests as
>> >>   TAINT_WARN or TAINT_CRAP or something otherwise, but neither are quite
>> >>   right.
>> >> - The taint_flags table gives a couple of checkpatch.pl errors around
>> >>   bracket placement. I've kept the new entry consistent with what's
>> >>   there rather than reformatting the whole table, but be prepared for
>> >>   complaints about spaces.
>> >> 
>> >> Thoughts?
>> >> -- David
>> >> 
>> >> ---
>> >>  Documentation/admin-guide/tainted-kernels.rst | 1 +
>> >>  include/linux/panic.h                         | 3 ++-
>> >>  kernel/panic.c                                | 1 +
>> >>  lib/kunit/test.c                              | 4 ++++
>> >>  4 files changed, 8 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>> >> index ceeed7b0798d..8f18fc4659d4 100644
>> >> --- a/Documentation/admin-guide/tainted-kernels.rst
>> >> +++ b/Documentation/admin-guide/tainted-kernels.rst
>> >> @@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>> >>   15  _/K   32768  kernel has been live patched
>> >>   16  _/X   65536  auxiliary taint, defined for and used by distros
>> >>   17  _/T  131072  kernel was built with the struct randomization plugin
>> >> + 18  _/N  262144  a KUnit test has been run
>> >>  ===  ===  ======  ========================================================
>> >>  
>> >>  Note: The character ``_`` is representing a blank in this table to make reading
>> >> diff --git a/include/linux/panic.h b/include/linux/panic.h
>> >> index f5844908a089..1d316c26bf27 100644
>> >> --- a/include/linux/panic.h
>> >> +++ b/include/linux/panic.h
>> >> @@ -74,7 +74,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
>> >>  #define TAINT_LIVEPATCH			15
>> >>  #define TAINT_AUX			16
>> >>  #define TAINT_RANDSTRUCT		17
>> >> -#define TAINT_FLAGS_COUNT		18
>> >> +#define TAINT_KUNIT			18
>> >> +#define TAINT_FLAGS_COUNT		19
>> >>  #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>> >>  
>> >>  struct taint_flag {
>> >> diff --git a/kernel/panic.c b/kernel/panic.c
>> >> index eb4dfb932c85..b24ca63ed738 100644
>> >> --- a/kernel/panic.c
>> >> +++ b/kernel/panic.c
>> >> @@ -404,6 +404,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>> >>  	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
>> >>  	[ TAINT_AUX ]			= { 'X', ' ', true },
>> >>  	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
>> >> +	[ TAINT_KUNIT ]			= { 'N', ' ', false },
>> >
>> > As kunit tests can be in modules, shouldn't this be "true" here?
>> >
>> > Overall, I like it, makes sense to me.  The "N" will take some getting
>> > used to, and I have no idea why "T" was for "struct randomization", that
>> > would have allowed you to use "T" instead.  Oh well.
>> 
>> Would you consider a patch adding more self-explanatory taint flag
>> strings to the output?
>
> Where would those strings go?  In the oops report?  Or somewhere else?

I was thinking the oops report. Basically most times I look at an oops
with taint, I need to double check what the flags mean. There are soon
19 of them, you need to look at a lot of oops to remember them all.

Currently we also print ' ' (or 'G' in case of non-properietary module)
for every unset taint flag. If we stopped doing that we wouldn't even
need that much more horizontal space for the strings, unless several
flags were set. (I assume people who do remember all the flags by heart
would still want to keep them too.)

BR,
Jani.


>
> thanks,
>
> greg k-h

-- 
Jani Nikula, Intel Open Source Graphics Center
