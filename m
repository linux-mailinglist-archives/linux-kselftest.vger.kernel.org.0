Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60F182399
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 22:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCKU77 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 16:59:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:53956 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgCKU77 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 16:59:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 13:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="236415947"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2020 13:59:58 -0700
Message-ID: <03ae9d057e4e3f2f0e7ba017e1ff0ea6253e3dc8.camel@intel.com>
Subject: Re: [PATCH V1 10/13] selftests/resctrl: Change Cache Allocation
 Technology (CAT) test
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 13:55:12 -0700
In-Reply-To: <cfae253b-9df2-8e5c-7b87-d5b8c6ef594b@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <51d0f3c928fbc310c85bac6de20745f69cbc423e.1583657204.git.sai.praneeth.prakhya@intel.com>
         <4ac6fd87-1393-f247-40ae-5d6e34403e0f@intel.com>
         <8645c93547ae6c4e35633dbb09d9355219d9e3b2.camel@intel.com>
         <e22014e5-8ffc-7966-b260-a0665f771ee2@intel.com>
         <38e679141c12108749a402fa60ef1810ef054bc8.camel@intel.com>
         <cfae253b-9df2-8e5c-7b87-d5b8c6ef594b@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Wed, 2020-03-11 at 13:22 -0700, Reinette Chatre wrote:
> Hi Sai,
> 
> On 3/11/2020 12:14 PM, Sai Praneeth Prakhya wrote:
> > On Wed, 2020-03-11 at 10:03 -0700, Reinette Chatre wrote:
> > > On 3/10/2020 6:59 PM, Sai Praneeth Prakhya wrote:
> > > > On Tue, 2020-03-10 at 15:14 -0700, Reinette Chatre wrote:
> > > > > Hi Sai,
> > > > > 

[SNIP]

> > > > Please let me know if you think otherwise
> > > 
> > > I think this patch can be split up into logical changes without breaking
> > > the tests along the way. In my original review I identified two changes
> > > that can be split out. Other things that can be split out:
> > > - have CAT test take shareable bits into account
> > > - enable measurement of cache references (addition of this new perf
> > > event attribute, hooks to get measurements, etc.)
> > > - transition CAT test to use "perf rate" measurement instead of "perf
> > > count"
> > > - etc.
> > 
> > I think we could split the patch like this but I am unable to see the
> > benefit
> > of doing so.. (Sorry! if I misunderstood what you meant).
> 
> Separating patches into logical changes facilitates review. Please
> consider this huge patch from the reviewer's perspective - it consists
> out of many different changes and is hard to review. If instead this
> patch was split into logical changes it would make it easier to
> understand what it is trying to do/change.

Ok.. makes sense.

> This is not a request that I invent but part of the established kernel
> development process. Please see
> Documentation/process/submitting-patches.rst (section is titled "Separate
>  your changes").

Sure! will take a look at it.

> 
> > As CAT and CQM test cases are buggy (CAT is not testing CAT at all) and we
> > are
> > not attempting to fix them by incremental changes but completely changing
> > the
> > test plan itself (i.e. the way the test works), so why not just remove
> > older
> > test cases and add new test? I thought this might be more easier for
> > review
> > i.e. to see the new test case all at once. Don't you think so?
> 
> From what I understand the new test continues to use many parts of the
> original test. Completely removing the original test would thus end up
> needing to add back a lot of code that was removed. Incremental changes
> do seem appropriate to me. The logical changes I listed above actually
> has nothing to do with "the way the test works". When those building
> blocks are in place the test can be changed in one patch and it would be
> much more obvious how the new test is different from the original.

Ok.. makes sense. Will split the patch as you suggested.

Regards,
Sai

