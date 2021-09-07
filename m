Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D13402689
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbhIGJx5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 05:53:57 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36804 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243607AbhIGJxj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 05:53:39 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1875W65O006859;
        Tue, 7 Sep 2021 04:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=XnahfHZ0w+KtzA7Xow7Cig4vQBly6sUG/NI7MjwiLuY=;
 b=OFawF4qtKhEm/jjZtG1O4waRWWfsTVDjWMNvf8PzZ6gXyAIjxzQZzhPjMUzeygOBwOaO
 ZWz2PyK+Wgisu27EXO4QA4ZHYePRZpmiC2sw/L3cDLwfqrRM3La05Q0vWJVHvi8ewr4D
 /bUGHSOODgMVPuNifo43fjpRkFQIBnhSlqhI0gkcWh8tkUNph3Ou0a68IbIAphxImVzh
 u9lAlILlG1Q2UhgOMakbtoXxdh+GxC6o5CAUuMiKlWrkIXadADDUVEv05ws5InEqmZTq
 UhVxdwSNitMJLz4/ZgHJmBQOy1372y9cNxjlIJQMou+PdXQsucDLCPSyVkRbGju1t3L5 3Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3awp5ugqsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 04:52:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 7 Sep
 2021 10:52:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 7 Sep 2021 10:52:22 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A7858B15;
        Tue,  7 Sep 2021 09:52:21 +0000 (UTC)
Subject: Re: Fixing up at least some fallout from '-Werror'
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>
CC:     <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <568ec880-dcc7-c707-53c3-c3c0ebc7a7fb@opensource.cirrus.com>
Date:   Tue, 7 Sep 2021 10:52:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: r8W6th2Ld1PB_uG8SnrMeiAyZrA2sIJh
X-Proofpoint-ORIG-GUID: r8W6th2Ld1PB_uG8SnrMeiAyZrA2sIJh
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> The test_scanf case didn't actually use the Kunit infrastructure, the
> stack use explosion is because gcc doesn't seem to combine stack
> allocations in many situations. I know gcc *sometimes* does that stack
> allocation combining, but not here. I suspect it might be related to
> type aliasing, and only merging stack slots when they have the same
> types, and thus triggered by the different result buffer sizes. Maybe.
> 

I'll have to take another look at this test.

The build robot reported a stack explosion recently but despite trying
various configurations, GCC versions and X86/ARM targets I couldn't
reproduce. Robot got a ~8k stack, but in all my test builds GCC merged
the stack structs and produced only ~100-200 bytes. Unfortunately
haven't been able to spend the time on this.

I wanted to avoid the quick fix of multiple functions because really
that's saying "make stack use (which is up to GCC) < X". The ultimate
stack reduction would be one-test-per-function but that gives really
bloated source. Any attempt to group several tests into a function is
relying on an assumption about what GCC will merge or not merge on the
stack, and that could change.

I think the best fix would be to re-work the code to use a work buffer 
instead of stack allocations (as it already does for the format
strings). With the benefit of hindsight, this is what I should have done
originally. When I have the time I'll work on it.
