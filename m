Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13AC17EC21
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 23:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCIWeA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 18:34:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:49129 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbgCIWeA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 18:34:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 15:33:59 -0700
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; 
   d="scan'208";a="245491074"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.21.24]) ([10.251.21.24])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Mar 2020 15:33:58 -0700
Subject: Re: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
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
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <7e3e4b91f5786a489e68eecda21e1d8049b60181.1583657204.git.sai.praneeth.prakhya@intel.com>
 <a7407b0d-4e4d-d0cf-621c-769d218fdace@intel.com>
 <FFF73D592F13FD46B8700F0A279B802F57307F89@ORSMSX114.amr.corp.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d0409729-b546-f0b9-4944-cbe5c9a74f76@intel.com>
Date:   Mon, 9 Mar 2020 15:33:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F57307F89@ORSMSX114.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/9/2020 3:22 PM, Prakhya, Sai Praneeth wrote:
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Monday, March 9, 2020 2:45 PM
>> On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:

[SNIP]

>> Please note that this is only a partial fix. The current feature detection relies on
>> the feature flags found in /proc/cpuinfo. Quirks and kernel boot parameters are
>> not taken into account. This fix only addresses the parsing of feature flags. If a
>> feature has been disabled via kernel boot parameter or quirk then the resctrl
>> tests would still attempt to run the test for it.
> 
> That's a good point and makes sense to me. I think we could fix it in two ways
> 1. grep for strings in dmesg but that will still leave ambiguity in deciding b/w mbm and cqm because kernel prints "resctrl: L3 monitoring detected" for both the features
> 2. Check in "info" directory
> 	a. For cat_l3, we could search for info/L3
> 	b. For mba, we could search for info/MB
> 	c. For cqm and mbm, we could search for specified string in info/L3_MON/mon_features
> 
> I think option 2 might be better because it can handle all cases, please let me know what you think.

I agree. For the reasons you mention and also that (1) may not be
possible if the loglevel prevents those lines from being printed.

Reinette

