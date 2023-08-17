Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A85677F23B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbjHQIdY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348901AbjHQIdI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 04:33:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858813D;
        Thu, 17 Aug 2023 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692261187; x=1723797187;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qZsIhhJX19J3NvVa2MXhgOu7cU+WST5BMLKkx34w6mU=;
  b=ZMnU5rVg4rW6j7JTXi0yWP+a1KPHYf74wdQqK7L/xOWXadfcqev8pfHl
   kQkmLK6u4yMExYgTNQlyJwMZxpDzVfrzTZDQgWuXJJcd4UKyiRmlrRNcZ
   GFtE4z8I0VoFASvzqry3bigZAE3efPK4H+ieG2WLKT00DYgPE/ZX8B88X
   hRgQUPjN9eAmBA9ejbjChvHZdNh56a8ACuwIFXGRI5yyxHPIIf3zUim1o
   +dAnkc0PkiBN+a5072VB2dmeGPsgYlyd33io7+9EBlSU2KmUL+sronwCO
   8vH8uVD2pq3Gi8dF13YZ+58yJG4yRHCpy05gSfrYPGoCCA0pU4NLdYdSk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="353066902"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="353066902"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763972332"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="763972332"
Received: from lababeix-mobl1.ger.corp.intel.com ([10.251.212.52])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:32:30 -0700
Date:   Thu, 17 Aug 2023 11:32:28 +0300 (EEST)
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
In-Reply-To: <bacc2e6f-f747-ec65-b23b-4275d1cac018@intel.com>
Message-ID: <c8b7118c-5830-98a0-5ae-66072e384b3@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com> <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com> <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com> <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com> <87183b24-f343-2420-9bda-f1012e7195a1@intel.com>
 <f22efaf4-d87f-d3c4-b986-7d326c912a18@linux.intel.com> <bacc2e6f-f747-ec65-b23b-4275d1cac018@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1487371549-1692254509=:1692"
Content-ID: <4fe2f0c1-789b-aaed-9bec-c4a3a3c7fdec@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1487371549-1692254509=:1692
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <54a614b0-59d6-b2d-7a23-58126f223bbe@linux.intel.com>

On Wed, 16 Aug 2023, Reinette Chatre wrote:
> On 8/16/2023 12:13 AM, Ilpo Järvinen wrote:
> > On Tue, 15 Aug 2023, Reinette Chatre wrote:
> >> On 8/15/2023 2:42 AM, Ilpo Järvinen wrote:
> >>> On Mon, 14 Aug 2023, Reinette Chatre wrote:
> >>>>
> >>>> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> 
> ...
> >>>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> >>>>> index bcd0d2060f81..ddb1e83a3a64 100644
> >>>>> --- a/tools/testing/selftests/resctrl/resctrl.h
> >>>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
> >>>>> @@ -6,6 +6,7 @@
> >>>>>  #include <math.h>
> >>>>>  #include <errno.h>
> >>>>>  #include <sched.h>
> >>>>> +#include <stdint.h>
> >>>>>  #include <stdlib.h>
> >>>>>  #include <unistd.h>
> >>>>>  #include <string.h>
> >>>>> @@ -38,7 +39,14 @@
> >>>>>  
> >>>>>  #define END_OF_TESTS	1
> >>>>>  
> >>>>> +#define BENCHMARK_ARGS		64
> >>>>> +
> >>>>> +/* Approximate %zu max length */
> >>>>> +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
> >>>>> +
> >>>>> +/* Define default span both as integer and string, these should match */
> >>>>>  #define DEFAULT_SPAN		(250 * MB)
> >>>>> +#define DEFAULT_SPAN_STR	"262144000"
> >>>>
> >>>> I think above hardcoding can be eliminated by using asprintf()? This
> >>>> does allocate memory though so I would like to understand why one
> >>>> goal is to not dynamically allocate memory.
> >>>
> >>> Because it's simpler on the _free() side_. If there's no allocation, no 
> >>> free() is needed.
> >>>
> >>> Only challenge that remains is the int -> string conversion for the 
> >>> default span which can be either done like in the patch or using some 
> >>> preprocessor trickery to convert the number to string. If you prefer the 
> >>> latter, I can change to that so it's not hardcoded both as int and string.
> >>>
> >>
> >> This manual int->string sounds like the trickery to me and can be avoided
> >> by just using asprintf(). I understand that no free() is needed when no
> >> memory is allocated but it looks to me as though these allocations can
> >> be symmetrical - allocate the memory before the tests are run and free it
> >> after?
> > 
> > It could be symmetrical but that means I'll be doing unnecessary alloc if 
> > -b is provided which I assume you're against given your comment on always 
> > creating copy of cmd in CMT test's case.
> 
> I seemed to have lost track here ... could you please elaborate where the
> unnecessary alloc will be?

If there's what you call "symmetry", it implies the code always does 
alloc. However, the logic in main() is such that when -b is provided, no 
default benchmark command needs to be assigned, so no alloc for span is 
necessary. Thus, there either is unnecessary alloc with -b or _no 
symmetry_.

But I've already converted to asprintf() so no need to continue this 
discussion.

> > I think I'll use similar resolution to this as CMT test does, it has an 
> > extra variable which is NULL in when -b is provided so free() is no-op
> > on that path. Then I can use asprintf().
> > 
> 
> Reinette
> 

-- 
 i.
--8323329-1487371549-1692254509=:1692--
