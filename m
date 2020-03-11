Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF621820C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 19:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgCKS1p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 14:27:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:25702 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgCKS1p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 14:27:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="236370876"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2020 11:27:44 -0700
Message-ID: <664cf142449b0a1ef7f09d04111f96ff84738e28.camel@intel.com>
Subject: Re: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Mar 2020 11:22:57 -0700
In-Reply-To: <b83ba95d-9f0f-4d4f-b68c-c5a612afece4@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <7e3e4b91f5786a489e68eecda21e1d8049b60181.1583657204.git.sai.praneeth.prakhya@intel.com>
         <a7407b0d-4e4d-d0cf-621c-769d218fdace@intel.com>
         <FFF73D592F13FD46B8700F0A279B802F57307F89@ORSMSX114.amr.corp.intel.com>
         <d0409729-b546-f0b9-4944-cbe5c9a74f76@intel.com>
         <FFF73D592F13FD46B8700F0A279B802F573084EC@ORSMSX114.amr.corp.intel.com>
         <b83ba95d-9f0f-4d4f-b68c-c5a612afece4@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Wed, 2020-03-11 at 11:06 -0700, Reinette Chatre wrote:
> Hi Sai,
> 
> On 3/9/2020 3:51 PM, Prakhya, Sai Praneeth wrote:
> > > -----Original Message-----
> > > From: Reinette Chatre <reinette.chatre@intel.com>
> > > Sent: Monday, March 9, 2020 3:34 PM
> > 
> > [SNIP]
> > 
> > > > That's a good point and makes sense to me. I think we could fix it in
> > > > two ways 1. grep for strings in dmesg but that will still leave
> > > > ambiguity in deciding b/w mbm and cqm because kernel prints "resctrl:
> > > > L3
> > > monitoring detected" for both the features 2. Check in "info" directory
> > > > 	a. For cat_l3, we could search for info/L3
> > > > 	b. For mba, we could search for info/MB
> > > > 	c. For cqm and mbm, we could search for specified string in
> > > > info/L3_MON/mon_features
> > > > 
> > > > I think option 2 might be better because it can handle all cases,
> > > > please let me
> > > know what you think.
> > > 
> > > I agree. For the reasons you mention and also that (1) may not be
> > > possible if the
> > > loglevel prevents those lines from being printed.
> > 
> > Makes sense. I will work on the fix.
> 
> One more note about this ... from what I can tell the test for a feature
> currently fails if the platform does not support the feature. Would it
> be possible to just skip the test in this case instead?

That's because the output of the test should be just "ok" or "not ok".

I can change it to something like "# Skip <test_name> because platform doesn't
support the feature", but not really sure if it complies with TAP 13 protocol.

Regards,
Sai

