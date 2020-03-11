Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A91182078
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgCKSMh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 14:12:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:55536 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgCKSMg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 14:12:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="261223466"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2020 11:12:32 -0700
Message-ID: <32b35b12e5e80f309f45b3a17a8d681e7e1fa33f.camel@intel.com>
Subject: Re: [PATCH V1 11/13] selftests/resctrl: Change Cache Quality
 Monitoring (CQM) test
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 11:07:45 -0700
In-Reply-To: <e0bada87-9464-2d08-c4cb-751e30866585@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <26086dda86f062bba4116878a012a553503924b2.1583657204.git.sai.praneeth.prakhya@intel.com>
         <e7bd79cf-4da8-7a61-ac09-4d124315fa93@intel.com>
         <cf8fbdebd8096900d47a97f0e23a852d94df257a.camel@intel.com>
         <e7c85e35-9efb-77da-a33f-dd9447a6cf07@intel.com>
         <04c252f59062450e14642fcbef4b85845f6a7427.camel@intel.com>
         <e0bada87-9464-2d08-c4cb-751e30866585@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Wed, 2020-03-11 at 11:03 -0700, Reinette Chatre wrote:
> > > > > > 

[SNIP]

> Hi Sai,
> 
> On 3/11/2020 10:33 AM, Sai Praneeth Prakhya wrote:
> > On Wed, 2020-03-11 at 10:19 -0700, Reinette Chatre wrote:
> > > On 3/10/2020 7:46 PM, Sai Praneeth Prakhya wrote:
> > > > On Tue, 2020-03-10 at 15:18 -0700, Reinette Chatre wrote:
> > > > > On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> > > I missed that. Thank you.
> > > 
> > > fyi ... when I tried these tests I encountered the following error
> > > related to unmounting:
> > > 
> > > [SNIP]
> > > ok Write schema "L3:1=7fff" to resctrl FS
> > > ok Write schema "L3:1=ffff" to resctrl FS
> > > ok Write schema "L3:1=1ffff" to resctrl FS
> > > ok Write schema "L3:1=3ffff" to resctrl FS
> > > # Unable to umount resctrl: Device or resource busy
> > > # Results are displayed in (Bytes)
> > > ok CQM: diff within 5% for mask 1
> > > # alloc_llc_cache_size: 2883584
> > > # avg_llc_occu_resc: 2973696
> > > ok CQM: diff within 5% for mask 3
> > > [SNIP]
> > > 
> > > This seems to originate from resctrl_val() that forces an unmount but if
> > > that fails the error is not propagated.
> > 
> > Yes, that's right and it's a good test. I didn't encounter this issue
> > during
> > my testing because I wasn't using resctrl FS from other terminals (I think
> > you
> > were using resctrl FS from other terminal and hence resctrl_test was
> > unable to
> > unmount it).
> 
> I was not explicitly testing for this but this may have been the case.
> 
> As a sidenote ... could remount_resctrlfs() be called consistently? It
> seems to switch between being called with true/false and 1/0. Since its
> parameter type is boolean using true/false seems most appropriate.

Agreed and make sense. I will fix this in a separate patch.

> > I think the error should not be propagated because unmounting resctrl FS
> > shouldn't stop us from checking the results. If measuring values reports
> > an
> > error then we shouldn't check for results.
> 
> This sounds right. It is inconsistent though ... the CQM test unmounts
> resctrl after it is run but the CAT test does not. Looking closer the
> CAT test seems to leave its artifacts around in resctrl and this should
> be cleaned up.

Yes makes sense. I will fix CAT test to cleanup things.

> I am not sure about the expectations here. Unmounting resctrl after a
> test is run is indeed the easiest to clean up and may be ok.

The main reason for unmounting is that assume user hasn't mounted resctrl FS
before running the test then we want to make sure we get back to the same
state as before running test and also to clean up any changes made to resctrl
FS during test.

> It may be a
> surprise to the user though. Perhaps there can be a snippet in the
> README that warns people about this?

Sure! makes sense. I will add it.

Regards,
Sai

