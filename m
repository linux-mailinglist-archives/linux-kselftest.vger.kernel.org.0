Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45604A54D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2019 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfIBLah (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Sep 2019 07:30:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfIBLah (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Sep 2019 07:30:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B213528;
        Mon,  2 Sep 2019 04:30:36 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AAD73F246;
        Mon,  2 Sep 2019 04:30:35 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] Add arm64/signal initial kselftest support
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190813162254.GX10425@arm.com>
 <b4c9cb22-6e08-8096-addb-4ac267fc0a84@arm.com>
 <20190902105322.GL27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <f28756a5-a763-7103-6d3e-70305dcbdbbd@arm.com>
Date:   Mon, 2 Sep 2019 12:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902105322.GL27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 02/09/2019 11:53, Dave Martin wrote:
> On Fri, Aug 30, 2019 at 05:40:42PM +0100, Cristian Marussi wrote:
>> Hi
>>
>> On 13/08/2019 17:22, Dave Martin wrote:
>>> On Fri, Aug 02, 2019 at 06:02:49PM +0100, Cristian Marussi wrote:
>>>> Hi
>>>>
>>>> this patchset aims to add the initial arch-specific arm64 support to
>>>> kselftest starting with signals-related test-cases.
>>>> A common internal test-case layout is proposed which then it is anyway
>>>> wired-up to the toplevel kselftest Makefile, so that it should be possible
>>>> at the end to run it on an arm64 target in the usual way with KSFT.
>>>
>>> The tests look like a reasonable base overall and something that we can
>>> extend later as needed.
>>>
>>> There are various minor things that need attention -- see my comments on
>>> the individual patches.  Apart for some things that can be factored out,
>>> I don't think any of it involves redesign.
>>>
>>>
>>> A few general comments:
>>>
>>>  * Please wrap all commit messages to <= 75 chars, and follow the other
>>>    guidelines about commit messages in
>>>    Documentation/process/submitting-patches.rst).
>>>
>>>  * Remember to run scripts/checkpatch.pl on your patches.  Currently
>>>    various issues are reported: they should mostly be trivial to fix.
>>>    checkpatch does report some false positives, but most of the warnings
>>>    I see look relevant.
>>>
>>
>> Thanks for the review. I addressed latest issues in V4, published now.
>>
>> I kept tests verbose (outputting to stderr) as of now.
>> Removed as a whole standalone build/run.
> 
> The responses look reasonable, thanks for repost.
> 
> I'll take a look.
> 
Ok Thanks...but...

I'm re-posting now a further V5 which is also rebased on arm64/for-next/core and so deals
with the conflicts against queued commit:

https://lore.kernel.org/linux-arm-kernel/c1e6aad230658bc175b42d92daeff2e30050302a.1563904656.git.andreyknvl@google.com/
Subject: [PATCH v19 15/15] selftests, arm64: add a selftest for passing tagged pointers to kernel

Differences from v4 are limited to 01/02 and reported in changelog.

Thanks

Cristian

> [...]
> 
> Cheers
> ---Dave
> 

