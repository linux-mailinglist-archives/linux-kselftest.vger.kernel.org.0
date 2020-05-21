Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38211DD5CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgEUSPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 14:15:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:25637 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgEUSPS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 14:15:18 -0400
IronPort-SDR: B1OJchEajIHsjVbNLwyPhcmgGSFWSOhF0jVj564tjY5LsaLD/zxzF7fXMEy49wyvi3cY9g7Wi9
 ukO33mqKpYDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 11:15:18 -0700
IronPort-SDR: 467gzIizawwuQPbVCKoikzWzLyd9P3wjCD7F/en4KMNDyW2znS/vZ+lHLLfj0q2V67sqK7L5/W
 LFxGcqGl7Kbg==
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="255377912"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.230.233]) ([10.255.230.233])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 11:15:16 -0700
Subject: Re: [PATCH V2 15/19] selftests/resctrl: Change return type of
 umount_resctrlfs() to void
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "dcb314@hotmail.com" <dcb314@hotmail.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
 <3c00e744acbfa67a1988638f1718cd67382a6f59.1589835155.git.sai.praneeth.prakhya@intel.com>
 <5703181d-832b-27c1-4b32-241f5cc868fd@intel.com>
 <FFF73D592F13FD46B8700F0A279B802F573B66AE@ORSMSX114.amr.corp.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <2e9ea256-cbf4-8222-c639-74479400fd77@intel.com>
Date:   Thu, 21 May 2020 11:15:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F573B66AE@ORSMSX114.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 5/21/2020 10:19 AM, Prakhya, Sai Praneeth wrote:
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Wednesday, May 20, 2020 4:52 PM
>> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>;
>> shuah@kernel.org; skhan@linuxfoundation.org; linux-kselftest@vger.kernel.org
>> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; Luck, Tony
>> <tony.luck@intel.com>; babu.moger@amd.com; james.morse@arm.com;
>> Shankar, Ravi V <ravi.v.shankar@intel.com>; Yu, Fenghua
>> <fenghua.yu@intel.com>; x86@kernel.org; linux-kernel@vger.kernel;
>> dan.carpenter@oracle.com; dcb314@hotmail.com
>> Subject: Re: [PATCH V2 15/19] selftests/resctrl: Change return type of
>> umount_resctrlfs() to void
>>
>> Hi Sai,
>>
>> On 5/18/2020 3:08 PM, Sai Praneeth Prakhya wrote:
>>> umount_resctrlfs() is used only during tear down path and there is
>>> nothing much to do if unmount of resctrl file system fails, so, all
>>> the callers of this function are not checking for the return value.
>>> Hence, change the return type of this function from int to void.
>>
>> Should the callers be ignoring the return value? From what I can tell the
>> filesystem is unmounted between test runs so I wonder if it may help if the
>> return code is used and the test exits with an appropriate error to user space for
>> possible investigation instead of attempting to run a new test on top of the
>> resctrl filesystem that could potentially be having issues at the time.
> 
> Makes sense to me to check for the return value of umount() and take appropriate
> action rather than ignoring it. But, since this might happen very rarely (I haven't
> noticed umount() failing till now), I am thinking to queue this up for cleanup series.
> What do you think?

That sounds good.

> 
> This bug fixes series will then have patches 16 and 17 because they are fixing a bug
> that could be easily noticed. Please let me know if you think otherwise.

I don't, dropping this change that makes it easy to ignore an error in
this round so that any errors could be dealt with better in a later
patch sounds good to me.

Thank you

Reinette

