Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631A5182209
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgCKTTH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 15:19:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:29109 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730807AbgCKTTG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 15:19:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 12:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="236556064"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2020 12:19:05 -0700
Message-ID: <38e679141c12108749a402fa60ef1810ef054bc8.camel@intel.com>
Subject: Re: [PATCH V1 10/13] selftests/resctrl: Change Cache Allocation
 Technology (CAT) test
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 12:14:18 -0700
In-Reply-To: <e22014e5-8ffc-7966-b260-a0665f771ee2@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <51d0f3c928fbc310c85bac6de20745f69cbc423e.1583657204.git.sai.praneeth.prakhya@intel.com>
         <4ac6fd87-1393-f247-40ae-5d6e34403e0f@intel.com>
         <8645c93547ae6c4e35633dbb09d9355219d9e3b2.camel@intel.com>
         <e22014e5-8ffc-7966-b260-a0665f771ee2@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Wed, 2020-03-11 at 10:03 -0700, Reinette Chatre wrote:
> Hi Sai,
> 
> On 3/10/2020 6:59 PM, Sai Praneeth Prakhya wrote:
> > On Tue, 2020-03-10 at 15:14 -0700, Reinette Chatre wrote:
> > > Hi Sai,
> > > 
> > > Not just specific to this patch but I think the prevalent use of global
> > > variables that are initialized/used or allocated/released from a variety
> > > of places within the code is creating traps. I seemed to have stumbled
> > > on a few during this review so far but it is hard to keep track of and I
> > > am not confident that I caught them all. Having the code be symmetrical
> > > (allocate and free from same area or initialize and use from same area)
> > > does help to avoid such complexity.
> > 
> > Sure! makes sense. I will try to wrap them up in some meaningful
> > structures to
> > pass around functions and will see if everything still works as expected.
> > If
> > not, I will comment why a particular variable needs to be global.
> > 
> > > This patch and the patch that follows are both quite large and difficult
> > > to keep track of all the collected changes. There seems to be
> > > opportunity for separating it into logical changes. Some of my comments
> > > may be just because I could not keep track of all that is changed at the
> > > same time.
> > 
> > Ok.. makes sense. The main reason this patch and the next patch are large 
> > because they do two things
> > 1. Remove previous CAT/CQM test case
> > 2. Add new CAT/CQM test cases
> > 
> > Since the new test cases are not just logical extensions or fixing some
> > bugs
> > in previous test cases, the patch might not be readable. I am thinking to
> > split this at-least like this
> > 1. A patch to remove CAT test case
> > 2. A patch to remove CQM test case
> > 3. Patches that just add CAT and CQM (without other changes)
> > 
> > Please let me know if you think otherwise
> 
> I think this patch can be split up into logical changes without breaking
> the tests along the way. In my original review I identified two changes
> that can be split out. Other things that can be split out:
> - have CAT test take shareable bits into account
> - enable measurement of cache references (addition of this new perf
> event attribute, hooks to get measurements, etc.)
> - transition CAT test to use "perf rate" measurement instead of "perf count"
> - etc.

I think we could split the patch like this but I am unable to see the benefit
of doing so.. (Sorry! if I misunderstood what you meant).

As CAT and CQM test cases are buggy (CAT is not testing CAT at all) and we are
not attempting to fix them by incremental changes but completely changing the
test plan itself (i.e. the way the test works), so why not just remove older
test cases and add new test? I thought this might be more easier for review
i.e. to see the new test case all at once. Don't you think so?

> 
> > > On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> 
> [SNIP]
> 
> > > > -static struct perf_event_attr pea_llc_miss;
> > > > +static struct perf_event_attr pea_llc_miss, pea_llc_access;
> > > >  static struct read_format rf_cqm;
> > > > -static int fd_lm;
> > > > +static int fd_lm, fd_la;
> > > >  char llc_occup_path[1024];
> > > >  
> > > >  static void initialize_perf_event_attr(void)
> > > > @@ -27,15 +27,30 @@ static void initialize_perf_event_attr(void)
> > > >  	pea_llc_miss.inherit = 1;
> > > >  	pea_llc_miss.exclude_guest = 1;
> > > >  	pea_llc_miss.disabled = 1;
> > > > +
> > > > +	pea_llc_access.type = PERF_TYPE_HARDWARE;
> > > > +	pea_llc_access.size = sizeof(struct perf_event_attr);
> > > > +	pea_llc_access.read_format = PERF_FORMAT_GROUP;
> > > > +	pea_llc_access.exclude_kernel = 1;
> > > > +	pea_llc_access.exclude_hv = 1;
> > > > +	pea_llc_access.exclude_idle = 1;
> > > > +	pea_llc_access.exclude_callchain_kernel = 1;
> > > > +	pea_llc_access.inherit = 1;
> > > > +	pea_llc_access.exclude_guest = 1;
> > > > +	pea_llc_access.disabled = 1;
> > > > +
> > > 
> > > This initialization appears to duplicate the initialization done above.
> > > Perhaps this function could be a wrapper that calls an initialization
> > > function with pointer to perf_event_attr that initializes structure the
> > > same?
> > 
> > I did think about a wrapper but since pea_llc_access and pea_llc_miss are
> > global variables, I thought passing them as variables might not look good
> > (why
> > do we want to pass a global variable?). I will try and see if I can make
> > these
> > local variables.
> 
> My goal was to avoid the duplicated code to initialize them identically.

I agree that duplicate should always be avoided.

> It is not clear to me why you think that would not look good.

I didn't mean that avoiding duplicate code doesn't look good.. what I meant
was passing global variables around will not look good.

> Perhaps I have not thought it through correctly ...

No.. I think the right thing to do here is not use global variable and hence
avoid duplicate code.

Regards,
Sai

