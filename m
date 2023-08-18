Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04E78064B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358157AbjHRHZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 03:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358181AbjHRHZo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 03:25:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B696930DF;
        Fri, 18 Aug 2023 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692343542; x=1723879542;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iNg4a9mqt5LGbkucNgoalthA+YcKMoAQ1V5fU1A3TEs=;
  b=OVON43epXBrU9TBxI1cnFxMI0YkOX2UxeCXQuA1ADYT+iGLLOsb5Ekke
   Cv3XxOGAm4W3bRAKrWxj7571vzRFrO7YBcFMs3NZid3bAq18+IedUGwvK
   YA9WNYabOoEDbHzQSEz08D7v/FoPIRt3FlDIdwZLZya9GKuUPnfmuX3ie
   6Ebc/VQ7W9NyBcDC7efAfhdOMKioUiFWO77r8cYLy4x1j8+/wyjLrkKvr
   KGbk7UPO7+kVfwzOyME6sFBfVwXUV7kK4s61dCyjB7rAnhDAIiAs0Vt0S
   +arYuqON48s8j83kAQhyPpJEIBh8lrbKvBz8GFt3aZu+3ZZgh78FMe6jl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352624510"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="352624510"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="908757353"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="908757353"
Received: from sidorovd-mobl2.ger.corp.intel.com ([10.252.53.164])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:25:39 -0700
Date:   Fri, 18 Aug 2023 10:25:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark
 cmd and make it const
In-Reply-To: <0587c078-306d-e3b4-ce5d-bcdfdeb66d27@intel.com>
Message-ID: <c572a759-fbca-ca5b-3065-274757b1683@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com> <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com> <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com> <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com> <87183b24-f343-2420-9bda-f1012e7195a1@intel.com>
 <f22efaf4-d87f-d3c4-b986-7d326c912a18@linux.intel.com> <bacc2e6f-f747-ec65-b23b-4275d1cac018@intel.com> <c8b7118c-5830-98a0-5ae-66072e384b3@linux.intel.com> <0587c078-306d-e3b4-ce5d-bcdfdeb66d27@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1508127004-1692343541=:1737"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1508127004-1692343541=:1737
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 17 Aug 2023, Reinette Chatre wrote:
> On 8/17/2023 1:32 AM, Ilpo Järvinen wrote:
> > On Wed, 16 Aug 2023, Reinette Chatre wrote:
> >> On 8/16/2023 12:13 AM, Ilpo Järvinen wrote:
> >>> On Tue, 15 Aug 2023, Reinette Chatre wrote:
> >>>> On 8/15/2023 2:42 AM, Ilpo Järvinen wrote:
> >>>>> On Mon, 14 Aug 2023, Reinette Chatre wrote:
> >>>>>> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> >>>>>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> >>>>>>> index bcd0d2060f81..ddb1e83a3a64 100644
> >>>>>>> --- a/tools/testing/selftests/resctrl/resctrl.h
> >>>>>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
> >>>>>>> @@ -6,6 +6,7 @@
> >>>>>>>  #include <math.h>
> >>>>>>>  #include <errno.h>
> >>>>>>>  #include <sched.h>
> >>>>>>> +#include <stdint.h>
> >>>>>>>  #include <stdlib.h>
> >>>>>>>  #include <unistd.h>
> >>>>>>>  #include <string.h>
> >>>>>>> @@ -38,7 +39,14 @@
> >>>>>>>  
> >>>>>>>  #define END_OF_TESTS	1
> >>>>>>>  
> >>>>>>> +#define BENCHMARK_ARGS		64
> >>>>>>> +
> >>>>>>> +/* Approximate %zu max length */
> >>>>>>> +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
> >>>>>>> +
> >>>>>>> +/* Define default span both as integer and string, these should match */
> >>>>>>>  #define DEFAULT_SPAN		(250 * MB)
> >>>>>>> +#define DEFAULT_SPAN_STR	"262144000"
> >>>>>>
> >>>>>> I think above hardcoding can be eliminated by using asprintf()? This
> >>>>>> does allocate memory though so I would like to understand why one
> >>>>>> goal is to not dynamically allocate memory.
> >>>>>
> >>>>> Because it's simpler on the _free() side_. If there's no allocation, no 
> >>>>> free() is needed.
> >>>>>
> >>>>> Only challenge that remains is the int -> string conversion for the 
> >>>>> default span which can be either done like in the patch or using some 
> >>>>> preprocessor trickery to convert the number to string. If you prefer the 
> >>>>> latter, I can change to that so it's not hardcoded both as int and string.
> >>>>>
> >>>>
> >>>> This manual int->string sounds like the trickery to me and can be avoided
> >>>> by just using asprintf(). I understand that no free() is needed when no
> >>>> memory is allocated but it looks to me as though these allocations can
> >>>> be symmetrical - allocate the memory before the tests are run and free it
> >>>> after?
> >>>
> >>> It could be symmetrical but that means I'll be doing unnecessary alloc if 
> >>> -b is provided which I assume you're against given your comment on always 
> >>> creating copy of cmd in CMT test's case.
> >>
> >> I seemed to have lost track here ... could you please elaborate where the
> >> unnecessary alloc will be?
> > 
> > If there's what you call "symmetry", it implies the code always does 
> > alloc. However, the logic in main() is such that when -b is provided, no 
> 
> No. Symmetry does not mean "always alloc"

Oh, so it simply meant code without memory leaks :-).

> - what I attempted to covey was
> that tracking allocations become easier if the memory is freed in code
> that is symmetrical to where the memory is allocated.

That's, unfortunately, what I needed to do even if it resulted in less 
clean code when I, in a later patch that is not part of this series, 
added a function the setup the default parameters into user parameters 
struct. main() will now pass that span_str for it to do "symmetrical" 
free inside main().

> For example, if memory
> is allocated at the beginning of main(), then it is freed on exit of main(),

you make it sound easier than the reality is. There's no singular point 
that is "exit of main()". It has way too many exit paths because of how 
selftests framework works. It doesn't give you back control when you ask 
it to exit the tests.

You'll see how complicated this gets once we get to the user parameters 
structure patch but I'll use asprintf()+free() for now ;-). We can revisit 
this discussion if you feel like it when we get to that patch.

...And to think this all is because C cannot easily make known constant 
int -> string conversion w/o some runtime code.

> or if there is a "test_resources_alloc()" that is called before a test is
> run then there could be a "test_resources_free()" that is called
> after a test is run.
> 
> > default benchmark command needs to be assigned, so no alloc for span is 
> > necessary. Thus, there either is unnecessary alloc with -b or _no 
> > symmetry_.
> > 
> > But I've already converted to asprintf() so no need to continue this 
> > discussion.
> 
> Please note that asprintf() allocates memory that needs to be freed.

Of course.

-- 
 i.

--8323329-1508127004-1692343541=:1737--
